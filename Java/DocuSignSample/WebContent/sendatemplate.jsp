<%@ page session="true"
    import="
        net.docusign.sample.Utils,
        net.docusign.api_3_0.*,
        java.util.List,
        java.util.Iterator"
    language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Example of how to Send a DocuSign Template via API</title>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui.all.css" />
    <link rel="stylesheet" type="text/css" href="css/SendDocument.css" />
    <link rel="Stylesheet" type="text/css" href="css/SendTemplate.css" />
    <link rel="stylesheet" type="text/css" href="css/default.css" />
    <link rel="stylesheet" type="text/css" href="css/Tabs.css" />
    <script type="text/javascript" src="js/jquery-1.4.4.js"></script>
    <script type="text/javascript" src="js/jquery.ui.core.js"></script>
    <script type="text/javascript" src="js/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="js/jquery.ui.dialog.js"></script>
    <script type="text/javascript" src="js/jquery.bgiframe-2.1.2.js"></script>
    <script type="text/javascript" src="js/jquery.ui.mouse.js"></script>
    <script type="text/javascript" src="js/jquery.ui.draggable.js"></script>
    <script type="text/javascript" src="js/jquery.ui.position.js"></script>
    <script type="text/javascript" src="js/Utils.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(function () {
            var today = new Date().getDate();
            $("#reminders").datepicker({
                showOn: "button",
                buttonImage: "images/calendar.png",
                buttonImageOnly: true,
                minDate: today
            });
            $("#expiration").datepicker({
                showOn: "button",
                buttonImage: "images/calendar.png",
                buttonImageOnly: true,
                minDate: today
            });
            $("#dialogmodal").dialog({
                height: 350,
                modal: true,
                autoOpen: false
            });
            $(".switcher li").bind("click", function () {
            var act = $(this);
            $(act).parent().children('li').removeClass("active").end();
            $(act).addClass("active");
            });
        });

    </script>
	</head>
    <body>
    <%@include file="header.jsp" %>

    <div style="width:1024px;height:800px;margin-left:auto;margin-right:auto">
    	<article class="tabs">
    		<section>
    			<h3><a href="<%= Utils.CONTROLLER_SENDDOCUMENT %>">Send Document</a></h3>
    		</section>
    		<section class="current">
    			<h3><a href="<%= Utils.CONTROLLER_SENDTEMPLATE %>">Send a Template</a></h3>
    		</section>
    		<section>
    			<h3><a href="<%= Utils.CONTROLLER_EMBEDDOCUSIGN %>">Embed DocuSign</a></h3>
    		</section>
    		<section>
    			<h3><a href="<%= Utils.CONTROLLER_GETSTATUS %>">Get Status and Docs</a></h3>
    		</section>
    	</article>
    <form id="SendTemplateForm" action="<%= Utils.CONTROLLER_SENDTEMPLATE %>" method="post">
    <div>
        <input id="subject" name="<%= Utils.NAME_SUBJECT %>" placeholder="<enter the subject>" type="text"
            class="email" /><br />
        <textarea id="emailblurb" cols="20" name="<%= Utils.NAME_EMAILBLURB %>" placeholder="<enter the e-mail blurb>"
            rows="4" class="email"></textarea>
    </div>
    <div>
        Select a Template<br />
        <select id="TemplateTable" name="<%= Utils.NAME_TEMPLATETABLE %>" >
        	<%
        	   if (session.getAttribute(Utils.SESSION_TEMPLATES) != null) {
        		   List<EnvelopeTemplateDefinition> tdefs = 
        			   (List<EnvelopeTemplateDefinition>) session.getAttribute(Utils.SESSION_TEMPLATES);
        		   for (EnvelopeTemplateDefinition tdef : tdefs) {
        			   out.println("<option value='" + tdef.getTemplateID() + "'>" +
        					   tdef.getName() + "</option>");
        		   }
        	   }
        	%>
        </select>
<!--         <input type="button" id="selectTemplateButton" name="selectTemplateButton"
            value="Go"  /> 
-->
    </div>
    <br />
    <div>
        <table width="100%" id="RecipientTable" name="RecipientTable" >
            <tr class="rowheader">
                <th class="fivecolumn">
                    <b>Role Name</b>
                </th>
                <th class="fivecolumn">
                    <b>Name</b>
                </th>
                <th class="fivecolumn">
                    <b>E-mail</b>
                </th>
                <th class="fivecolumn">
                    <b>Security</b>
                </th>
                <th class="fivecolumn">
                    <b>Send E-mail Invite</b>
                </th>
            </tr>
        </table>
         <input type="button" onclick="addRoleRowToTable()" value="Add Role"/>
    </div>
    <div>
        <table width="100%">
            <tr class="rowbody">
                <td class="fourcolumn">
                </td>
                <td class="fourcolumn">
                    <input type="text" id="reminders" name="reminders" class="datepickers" />
                </td>
                <td class="fourcolumn">
                    <input type="text" id="expiration" name="expiration" class="datepickers" />
                </td>
                <td class="fourcolumn">
                </td>
            </tr>
            <tr>
                <td class="fourcolumn">
                </td>
                <td class="fourcolumn">
                    Add Daily Reminders
                </td>
                <td class="fourcolumn">
                    Add Expiration
                </td>
                <td class="fourcolumn">
                </td>
            </tr>
            <tr>
                <td class="fourcolumn">
                </td>
                <td class="leftbutton">
                    <input type="submit" value="Send Now" name="SendNow" align="right" style="width: 100%;"
                        class="docusignbutton orange" />
                </td>
                <td class="rightbutton">
                    <input type="submit" value="Edit Before Sending" name="EditFirst" align="left" style="width: 100%;"
                        class="docusignbutton brown" />
                </td>
                <td class="fourcolumn">
                </td>
            </tr>
        </table>
    </div>
    </form>
    </div>
    <%@ include file="footer.html" %>
	</body>
</html>
