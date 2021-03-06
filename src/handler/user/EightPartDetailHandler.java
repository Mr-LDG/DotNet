package handler.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import handler.CommandHandler;
import main.BoardDao;
import survey.EightDataBean;
import survey.SurveyDao;

@Controller
public class EightPartDetailHandler implements CommandHandler {
	@Resource
	SurveyDao surveyDao;
	@Resource
	BoardDao boardDao;
	@RequestMapping("/eightPartDetail.do")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		

		String id =  (String)request.getSession().getAttribute("memId");
	
		
		List<EightDataBean> eightList = new ArrayList<EightDataBean>();
		String s_num = (String) request.getParameter("s_num");
		String q_num = (String) request.getParameter("q_num");
		String q_content = (String) request.getParameter("q_content");
		
		eightList = surveyDao.getEights(s_num);
//		System.out.println("eightList" + eightList);
		EightDataBean eight = new EightDataBean();
		
		List<EightDataBean> eiList = new ArrayList<EightDataBean>();
		List<String> selList = new ArrayList<String>();
		selList.add(eight.getSel1_content());
		selList.add(eight.getSel2_content());
		selList.add(eight.getSel3_content());
		selList.add(eight.getSel4_content());
		
		int size = 0;
		for(int i = 0; i < 8; i++) {

				size++;
			
		}
		
		Map<String, Object> cMap = new HashMap<String, Object>();
		List<Map<String, Object>> cList = new ArrayList<Map<String,Object>>();
		int cnt = 0;
		for(int i=1; i<9; i++) {
				for(int j=1; j<5; j++) {
				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put( "q_num", i );
				hMap.put( "cho_num", j);
				cList.add(hMap);
				cnt++;
				}
		}
		cMap.put("s_num", s_num);
		cMap.put("cList", cList );
		cMap.put("id", id);
		cMap.put("size", size);

		List<String> counter = new ArrayList<String>();
		counter=surveyDao.selectCount(cMap);
		
		selList = surveyDao.selected(cMap);
		
		int hits = 0;
		hits = surveyDao.countHits(s_num);
		request.setAttribute("hits", hits);
		
		int parts = 0;
		parts = surveyDao.countParts(s_num);
		request.setAttribute("parts", parts);
		
		String subject = "";
		subject = surveyDao.getTitle(s_num);
		request.setAttribute("subject", subject);
		
//		System.out.println("List : " + counter );
//		System.out.println("q_content : " + q_content);
		
		request.setAttribute("counter", counter);
		request.setAttribute("q_content" , q_num );
		request.setAttribute("cList", cList);
		request.setAttribute("s_num",  s_num );
		request.setAttribute("q_content",  q_content );
		request.setAttribute("selList",  selList);
		request.setAttribute("eightList", eightList);
		return new ModelAndView("/user/eightPartDetail");
	}

}
