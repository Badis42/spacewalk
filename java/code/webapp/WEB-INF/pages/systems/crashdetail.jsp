<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html:html xhtml="true">
<body>
  <rhn:toolbar base="h1" img="/img/icon_bug.gif" imgAlt="info.alt.img"
               deletionUrl="SoftwareCrashDelete.do?crid=${crid}"
               deletionType="crash">
    ${fn:escapeXml(crash.crash)}
  </rhn:toolbar>
  <h2><bean:message key="crashes.jsp.details"/></h2>

<div class="page-summary">
  <p><bean:message key="crashes.jsp.details.summary"/></p>
</div>

<%@ include file="/WEB-INF/pages/common/fragments/systems/crash_details.jspf" %>

<hr/>

<rl:listset name="crashFileList">
    <rhn:csrf />
    <rl:list
         width="100%"
         styleclass="list"
         emptykey="crashes.jsp.nocrashfiles"
         alphabarcolumn="filename">

        <rl:decorator name="PageSizeDecorator"/>

        <rl:column headerkey="crashes.jsp.filename" bound="false"
            sortattr="filename"
            sortable="true"
            filterattr="filename">
            <a href="${current.downloadPath}">
                ${current.filename}
            </a>
        </rl:column>

        <rl:column headerkey="crashes.jsp.path" bound="false"
            sortattr="path"
            sortable="true">
            ${current.path}
        </rl:column>

        <rl:column headerkey="crashes.jsp.filesize" bound="false"
            sortattr="filesize"
            sortable="true">
            ${current.filesizeString}
        </rl:column>

        <rl:column headerkey="lastModified" bound="false"
            styleclass="last-column thin-column"
            sortattr="modifiedObject"
            sortable="true">
            ${current.modified}
        </rl:column>
    </rl:list>
    <rl:csv
        name="crashFileList"
        exportColumns="filename,path,filesize,modified"
        header="${crash.crash}"/>
    <html:hidden property="crid" value="${crid}"/>
</rl:listset>

</body>
</html:html>
