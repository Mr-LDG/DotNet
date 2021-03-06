package handler.main;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.Instanceof;
import org.apache.ibatis.logging.slf4j.Slf4jImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import handler.CommandHandler;
import main.BoardAskDao;
import main.BoardAskDataBean;
import main.MemberDao;
import survey.SurveyDBBean;
import survey.SurveyDao;
import survey.SurveyDataBean;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainHandler implements CommandHandler {

	public static Logger userLogger = LoggerFactory.getLogger("user");
 	public static Logger mainlogger = LoggerFactory.getLogger("main");	

	@Resource
	private MemberDao memberDao;

	@Resource
	private SurveyDao surveyDao;
	
	@Resource
	private BoardAskDao boardAskDao;
	
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public void logoutFunc(HttpServletRequest re) {
		Logger logger = LoggerFactory.getLogger("MAIN_LOG");
		HttpSession session = re.getSession();
		
		String id = (String) session.getAttribute("memId");
		mainlogger.info("logout:"+id );
		
		session.removeAttribute("memId");
		session.removeAttribute("isAdmin");
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Logger logger = LoggerFactory.getLogger("MAIN_LOG");
		
		String id = request.getParameter("id");
		
		//		logger.getName();

		String passwd = request.getParameter("passwd");
		int result = memberDao.check(id, passwd);
		int userSt = memberDao.checkSt(id);
		if(userSt == 1) {
			return "block";
		}
		if (result == 1) {
			if (id.equals("admin")) { // 愿�由ъ옄�씤吏� �솗�씤
				session.setAttribute("isAdmin", 1);
			} else {
				session.setAttribute("isAdmin", 2);
			}
			session.setAttribute("memId", id);
			mainlogger.info("login:"+id );
		}
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> s_numList = new ArrayList<String>(); 
		int pResult = surveyDao.checkPart(id);
		if (pResult != 0) { 
			s_numList = surveyDao.getPartS_num(id);
			map.put("id", id);
			map.put("s_numList", s_numList);
			surveyDao.getPartPoint(map);
		}
		int wResult = surveyDao.checkWriter(id);
		if (wResult != 0) { 
			surveyDao.getMyPoint(id);
		}

		return String.valueOf(result);

	}
	@RequestMapping(value = {"/a", "/search" }, method = RequestMethod.POST, produces = "application/json;UTF-8")
	@ResponseBody
	public Map<String, Object> alignAjax(HttpServletRequest request) throws Exception {

		Logger logger = LoggerFactory.getLogger("MAIN_LOG");
		List<SurveyDataBean> surveys = new ArrayList<SurveyDataBean>();// surveyDao.getSurveys();

		Map<String, Object> map = new HashMap<String, Object>();


		String align = null;
		String search = null;
		SurveyDataBean arr[][] = null;
		//request.setCharacterEncoding("utf-8");
		
		
		
		align = request.getParameter("align");
		search = request.getParameter("search");
//		System.out.println(search);
		String b_tp = request.getParameter("b_tp");
		HttpSession sess = request.getSession();
		if(sess.getAttribute("memId") != null) {
			String id = (String)sess.getAttribute("memId");

			logger.info("id:"+id+",search:"+search+",boardType:"+b_tp+",align:"+align);
		}else {
			logger.info("id:noMem,search:"+search+",boardType:"+b_tp+",align:"+align);
			
		}
		if (align != null && search == null) {

			if(b_tp.equals("2")) {
				switch (align) {
				case "recent":
					surveys = surveyDao.getSurs2();
					break;
				case "partnum":
					surveys = surveyDao.getSursView2();
					break;
				case "hits":
					surveys = surveyDao.getSursHit2();
					break;
				case "point":
					surveys = surveyDao.getSursPoint2();
					break;
				default:
					surveys = surveyDao.getSurs2();
					break;
				}
			} else {
				switch (align) {
				case "recent":
					surveys = surveyDao.getSurs();
					break;
				case "partnum":
					surveys = surveyDao.getSursView();
					break;
				case "hits":
					surveys = surveyDao.getSursHit();
					break;
				case "point":
					surveys = surveyDao.getSursPoint();
					break;
				default:
					surveys = surveyDao.getSurs();
					break;
				}
			}
		} else {
			surveys = surveyDao.getSearchSursSub(search);
		}
		
		arr = new SurveyDataBean[surveys.size() / 3 + 1][3];
		int c = 0;
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr[0].length; j++) {
				if (c <= surveys.size() - 1) {
					arr[i][j] = surveys.get(c);

				} else {
					arr[i][j] = null;
				}
				c++;
			}
		}
		map.put("arr", arr);
		return map;

	}

	
	@RequestMapping("/main")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SurveyDBBean surveyDao = new SurveyDBBean();
		
		HttpSession session = request.getSession(); 
		int b_tp = 1;
		if(request.getParameter("b_tp") != null) {
			b_tp = Integer.parseInt(request.getParameter("b_tp"));
		};

		// today
		List<SurveyDataBean> todaysurs = new ArrayList<SurveyDataBean>();
		if(b_tp == 2) {
			todaysurs = surveyDao.getTodaySurs2();
		} else {
			todaysurs = surveyDao.getTodaySurs();
		}
		if(b_tp == 3) {
			int getCount = boardAskDao.getCount();
			request.setAttribute("asksCnt", getCount);
			List<BoardAskDataBean> asks = boardAskDao.getAsks();
			request.setAttribute("asks", asks);
			String id =(String) session.getAttribute("memId");
			if(id != null) {
				request.setAttribute("id", id);
			}else {
				request.setAttribute("id", "-1");
			}
			return new ModelAndView("main/boardAsk");
		}
		
		String align = "recent";
		if (request.getParameter("align") != null)
			align = request.getParameter("align");
		request.setAttribute("align", align);

		SurveyDataBean arrToday[][] = new SurveyDataBean[2][3];

		int c = 0;

		for (int i = 0; i < arrToday.length; i++) {
			for (int j = 0; j < arrToday[0].length; j++) {
				if(c < todaysurs.size()) {
					arrToday[i][j] = todaysurs.get(c);
					c++;
				}
			}
		}

		request.setAttribute("todaysurs", todaysurs);
		request.setAttribute("b_tp", b_tp);
		request.setAttribute("arrToday", arrToday);

		return new ModelAndView("main/main");
	}
}
