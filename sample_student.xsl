<?xml version="1.0" encoding="UTF-8"?>
<!--  XSL Style Sheet ("sample_student.xsl") with a transformation template for "sample_student"
      XML Document.
    -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>

      <!--  "table_style.css" style sheet to style the tables  -->
      <link rel="stylesheet" href="table_style.css"/>

      <!--  style of the body, h1 and h2  -->
      <style>
        body {
          font-size: 13px;
          font-family: sans-serif;
        }

        h1 {
          color: teal;
        }

        h2 {
          color: CadetBlue;
        }
      </style>

      <title>  <!--  Put the ID of the student -->
        User Account: <xsl:value-of select="student/@ID"></xsl:value-of>
      </title>

    </head>

    <body>

      <h1>List of current courses:</h1>

      <p>This is of all current courses</p>

      <!--  All current courses here  -->
      <xsl:for-each select="student/course_list/course">

        <xsl:if test="@status = 'current'">

          <h2>Course Info:</h2>

          <table>
            <!--  Course Name row  -->
            <tr>
              <th>Course Name:</th>
              <!--  data cell -->
              <td> <xsl:value-of select="course_name"/> </td>
            </tr>
            <!--  Instructors row  -->
            <tr>
              <th>Instractors:</th>
              <td>
                <xsl:for-each select="instructor">
                  <xsl:value-of select="@for"/>:
                  <xsl:value-of select="."/>,
                </xsl:for-each>
              </td>
            </tr>
            <!--  Credit Hours row  -->
            <tr>
              <th>Credit Hours:</th>
              <td> <xsl:value-of select="credit_hours"/> </td>
            </tr>
            <!--  Description row  -->
            <tr>
              <th>Description:</th>
              <td> <xsl:value-of select="description"/> </td>
            </tr>
            <!--  Text row  -->
            <tr>
              <th><xsl:attribute name="rowspan"> <xsl:value-of select ="count(textbooks/text)+1"/> </xsl:attribute>Text:</th>
            </tr>

            <xsl:for-each select="textbooks/text">
              <tr>
                <td>
                  <xsl:choose>
                    <xsl:when test="@type  = 'webpage'">
                      <a><xsl:attribute name="href"> <xsl:value-of select ="link"/></xsl:attribute> <xsl:value-of select="title"/>.</a>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="title"/>,&#160;
                      <xsl:for-each select="author">
                        <xsl:value-of select="fname"/>&#160;
                        <xsl:if test="mname"> <xsl:value-of select="mname"/>&#160; </xsl:if>
                        <xsl:value-of select="lname"/>,&#160;
                      </xsl:for-each>
                      <xsl:value-of select="edition"/>
                      <xsl:choose>
                        <xsl:when test="ISBN">
                          edition, ISBN: <xsl:value-of select="ISBN"/>.
                        </xsl:when>
                        <xsl:otherwise>
                          edition.
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </xsl:for-each>
          </table>
        </xsl:if>

      </xsl:for-each>

      <h1>Number of passed courses: <xsl:value-of select="count(student/course_list/course[@status = 'pass'])"/> </h1>

      <!--  Get number of passed courses  -->

    </body>

  </html>
</xsl:template>

</xsl:stylesheet>
