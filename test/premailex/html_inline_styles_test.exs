defmodule Premailex.HTMLInlineStylesTest do
  use ExUnit.Case
  doctest Premailex.HTMLInlineStyles

  @css """
  body,table,p,td,ul,ol {color:#333333; font-family:Arial, sans-serif; font-size:14px; line-height:22px;}

  h1, h2, h3, h4, p {margin: 0; padding: 0;}

  td p {color: red; font-size:13px; background-color:#fff;}
  p    {color: #000 !important; font-size:12px; background-color:#000;}

  a {color: #e95757; text-decoration: underline;}
  a:hover	{text-decoration: underline;}
  """

  @input """
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Test</title>
    <style>#{@css}</style>
  </head>
  <body>
  <table cellpadding="0" cellspacing="0" align="center" style="padding:20px; padding-top:0;">
    <tr>
      <td align="center">
        <p><a href="#" style="color:#999999; font-size:12px;">Test link</a></p>
      </td>
    </tr>
  </table>

  <table cellpadding="0" cellspacing="0" style="padding:20px;" align="center">
    <tr>
      <td>
        <table cellpadding="0" cellspacing="0" width="100%">
          <tr align="center">
            <td>
              <h1 style="font-size:24px; line-height:24px !important; padding-bottom:8px; color: #2eac6d;">Heading</h1>
              <p style="color: #fff;background-color:#fff !important;font-size:11px;"><p>
            </td>
            <td align="right" valign="bottom"></td>
          </tr>
        </table>
      </td>
    </tr>
  </body>
</html>
"""

  test "parse to text" do
    parsed = Premailex.HTMLInlineStyles.process(@input)

    assert parsed =~ "<body style=\"color:#333333;font-family:Arial, sans-serif;font-size:14px;line-height:22px;\">"
    assert parsed =~ "<h1 style=\"color:#2eac6d;font-size:24px;line-height:24px !important;margin:0;padding:0;padding-bottom:8px;\">"
    assert parsed =~ "<p style=\"background-color:#fff;color:#000 !important;font-family:Arial, sans-serif;font-size:13px;line-height:22px;margin:0;padding:0;\">"
  end
end
