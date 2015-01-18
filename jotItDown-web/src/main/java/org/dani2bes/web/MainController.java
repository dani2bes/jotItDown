package org.dani2bes.web;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;

@Controller
@RequestMapping("VIEW")
public class MainController {

	private static final String MAIN_VIEW = "mainView";

	@RenderMapping
	public String showView(RenderRequest request, RenderResponse response,
			Model model) {

		return MAIN_VIEW;
	}

}
