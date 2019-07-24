package handler.main;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.Instanceof;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import handler.CommandHandler;
import main.MemberDao;
import survey.SurveyDBBean;
import survey.SurveyDao;
import survey.SurveyDataBean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainHandler implements CommandHandler {

	@Resource
	private MemberDao memberDao;

	@Resource
	private SurveyDao surveyDao;

	@RequestMapping(value = {"/a", "/search" }, method = RequestMethod.POST, produces = "application/json;UTF-8")
	@ResponseBody
	public Map<String, Object> alignAjax(HttpServletRequest request) throws Exception {

//		System.out.println("alignAjax 함수 들어옴");

//		SurveyDBBean surveyDao = new SurveyDBBean();

		List<SurveyDataBean> surveys = new ArrayList<SurveyDataBean>();// surveyDao.getSurveys();

		Map<String, Object> map = new HashMap<String, Object>();

		String align = null;
		String search = null;
		SurveyDataBean arr[][] = null;
		

		align = request.getParameter("align");
		search = request.getParameter("search");
		String b_tp = request.getParameter("b_tp");
		
		if (align != null && search == null) {

//			System.out.println( "align :"+align);
			if(b_tp.equals("2")) {
				switch (align) {
				case "recent":
					surveys = surveyDao.getSurs2();
					break;
				case "partnum":
					surveys = surveyDao.getSursView2();
					break;
				case "hit":
					surveys = surveyDao.getSursHit2();
					break;
				case "point":
					surveys = surveyDao.getSursPoint2();
					break;
				default:
					surveys = surveyDao.getSurs2();
	//				System.out.println("default surveys");
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
				case "hit":
					surveys = surveyDao.getSursHit();
					break;
				case "point":
					surveys = surveyDao.getSursPoint();
					break;
				default:
					surveys = surveyDao.getSurs();
	//				System.out.println("default surveys");
					break;
				}
			}
		} else {
//			System.out.println("search : " + search);
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

//		for (SurveyDataBean el : surveys) {
//			System.out.print(el.getThumb_path() + " ");
//		}
//		System.out.println();

//		JsonObject json = new JsonObject();

		return map;

	}

	@RequestMapping("/main")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SurveyDBBean surveyDao = new SurveyDBBean();
		
		HttpSession session = request.getSession(); 
		
		String logout = request.getParameter("logout");
		int b_tp = 1;
		if(request.getParameter("b_tp") != null) {
			b_tp = Integer.parseInt(request.getParameter("b_tp"));
		};
		
		if(logout != null) {
			session.removeAttribute("memId");
			session.removeAttribute("isAdmin");
		}
		// today
		List<SurveyDataBean> todaysurs = new ArrayList<SurveyDataBean>();
		if(b_tp == 2) {
			todaysurs = surveyDao.getTodaySurs2();
		} else {
			todaysurs = surveyDao.getTodaySurs();
		}
		
//
//		// 정렬에서
		String align = "recent";
		if (request.getParameter("align") != null)
			align = request.getParameter("align");
		request.setAttribute("align", align);
//
//		// 전체 설문 수
//		int cnt = surveyDao.getCountAll();
//		

		
//		System.out.println("surveys.size()/3 + 1 = " + surveys.size() / 3);

		SurveyDataBean arrToday[][] = new SurveyDataBean[2][3];

		int c = 0;

		// today (2 x 3 이라고 확정함 null 생각 x)
		for (int i = 0; i < arrToday.length; i++) {
			for (int j = 0; j < arrToday[0].length; j++) {
				if(c < todaysurs.size()) {
					arrToday[i][j] = todaysurs.get(c);
					c++;
				}
			}
		}

//		for (int i = 0; i < todaysurs.size(); i++) {
//			System.out.print(todaysurs.get(i).getThumb_path() + " ");
//		}


		request.setAttribute("todaysurs", todaysurs);
		request.setAttribute("b_tp", b_tp);
		request.setAttribute("arrToday", arrToday);



		return new ModelAndView("main/main");
	}
}
