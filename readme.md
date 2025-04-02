# {maize} package


# maize <img src="man/figures/logo.png" align="right" height="139" alt="" />

## what is {maize}?

{maize} is an extension library for kernels & support vector machines in
tidymodels! The package consists of additional kernel bindings that are
not available in the {parsnip} or {recipes} package. Many of the kernels
are ported from {kernlab}, additional kernels have been added directly
to maize transposed from
[Python](https://github.com/gmum/pykernels/blob/master/pykernels/regular.py)
and
[Julia](https://juliagaussianprocesses.github.io/KernelFunctions.jl/stable/kernels/)
packages.

{parnsip} has three kernels available: linear, radial basis function, &
polynomial. {maize} extends to further kernels, other engines, and adds
steps for {recipes}:

### maize engines

<div id="rtjobajvew" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

<table class="gt_table" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false"
style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: system-ui, &#39;Segoe UI&#39;, Roboto, Helvetica, Arial, sans-serif, &#39;Apple Color Emoji&#39;, &#39;Segoe UI Emoji&#39;, &#39;Segoe UI Symbol&#39;, &#39;Noto Color Emoji&#39;; display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: 16px; font-weight: normal; font-style: normal; background-color: #FFFFFF; width: auto; border-top-style: none; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: none; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;"
data-bgcolor="#FFFFFF">
<caption><br />
<br />
<br />
<br />
</caption>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead style="border-style: none;">
<tr class="gt_heading"
style="border-style: none; background-color: #FFFFFF; text-align: left; border-bottom-color: #FFFFFF; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; padding-bottom: 0px; padding-top: 6px;"
data-bgcolor="#FFFFFF" data-align="left">
<th colspan="4" class="gt_heading gt_title gt_font_normal"
style="text-align: left; border-style: none; color: #333333; padding-left: 5px; padding-right: 5px; border-bottom-width: 0; background-color: #FFFFFF; border-bottom-color: #FFFFFF; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; padding-bottom: 0px; padding-top: 6px; font-family: &#39;Open Sans&#39;; font-size: 18px; font-weight: bold;"
data-bgcolor="#FFFFFF">🌽{maize} bindings</th>
</tr>
<tr class="gt_heading"
style="border-style: none; background-color: #FFFFFF; text-align: left; border-bottom-color: #FFFFFF; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; padding-bottom: 0px; padding-top: 6px;"
data-bgcolor="#FFFFFF" data-align="left">
<th colspan="4"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border"
style="text-align: left; border-style: none; color: #333333; padding-left: 5px; padding-right: 5px; border-top-color: #FFFFFF; border-top-width: 0; background-color: #FFFFFF; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; border-bottom-style: none; border-bottom-width: 2px; border-bottom-color: #D3D3D3; font-weight: normal; font-family: &#39;Open Sans&#39;; font-size: 14px; padding-top: 0px; padding-bottom: 4px;"
data-bgcolor="#FFFFFF">more to come!</th>
</tr>
<tr class="gt_col_headings gt_spanner_row"
style="border-style: none; border-top-style: solid; border-top-width: 1px; border-top-color: #000000; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; border-bottom-style: hidden;">
<th colspan="4" id="toss_out_spanner_dev"
class="gt_center gt_columns_top_border gt_column_spanner_outer"
data-quarto-table-cell-role="th" scope="colgroup"
style="text-align: center; border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; padding-top: 0; padding-bottom: 0; padding-left: 0; padding-right: 0; display: none;"
data-bgcolor="#FFFFFF"><div class="gt_column_spanner"
style="border-bottom-style: none; border-bottom-width: 2px; border-bottom-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 5px; overflow-x: hidden; display: inline-block; width: 100%; text-decoration: underline;">
toss_out_spanner_dev
</div></th>
</tr>
<tr class="gt_col_headings"
style="border-style: none; border-top-style: solid; border-top-width: 1px; border-top-color: #000000; border-bottom-style: none; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
<th id="extension"
class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th"
style="text-align: left; border-style: none; font-weight: normal; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; padding: 5px 5px 5px 25px; color: #FFFFFF; font-family: &#39;Open Sans&#39;; font-size: 14px; text-transform: uppercase; background-color: #000000;"
scope="col" data-bgcolor="#000000" data-valign="bottom">extension</th>
<th id="maize" class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th"
style="text-align: left; border-style: none; font-weight: normal; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; padding: 5px 5px 5px 25px; color: #FFFFFF; font-family: &#39;Open Sans&#39;; font-size: 14px; text-transform: uppercase; background-color: #000000;"
scope="col" data-bgcolor="#000000" data-valign="bottom">maize</th>
<th id="engine" class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th"
style="text-align: left; border-style: none; font-weight: normal; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; padding: 5px 5px 5px 25px; color: #FFFFFF; font-family: &#39;Open Sans&#39;; font-size: 14px; text-transform: uppercase; background-color: #000000;"
scope="col" data-bgcolor="#000000" data-valign="bottom">engine</th>
<th id="mode" class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th"
style="text-align: left; border-style: none; font-weight: normal; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; padding: 5px 5px 5px 25px; color: #FFFFFF; font-family: &#39;Open Sans&#39;; font-size: 14px; text-transform: uppercase; background-color: #000000;"
scope="col" data-bgcolor="#000000" data-valign="bottom">mode</th>
</tr>
</thead>
<tbody class="gt_table_body"
style="border-style: none; border-top-style: none; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #FFFFFF;">
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_laplace</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_tanh</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_bessel</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_anova_rbf</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_spline</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_cossim</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_cauchy</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_tanimoto</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_sorenson</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_tstudent</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_fourier</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression &amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">svm_wavelet</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::ksvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">regression
&amp; classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">svm_string</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">lssvm_laplace</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::lssvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">rvm_laplace</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::rvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">regression</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kqr_laplace</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::kqr</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">regression</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">bag_svm_laplace</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">ebmc::ub</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">binary-classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">rus_boost_svm_laplace</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">ebmc::rus</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">binary-classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #ABB4BF;"
data-bgcolor="#ABB4BF" data-valign="middle">{parsnip}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">ada_boost_svm_laplace</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">ebmc::adam2</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">binary-classification</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #E6E7E3;"
data-bgcolor="#E6E7E3" data-valign="middle">{recipes}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">step_kpca_laplace</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::kpca</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">transformation steps</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #E6E7E3;"
data-bgcolor="#E6E7E3" data-valign="middle">{recipes}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">step_kpca_tanh</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::kpca</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">transformation steps</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #E6E7E3;"
data-bgcolor="#E6E7E3" data-valign="middle">{recipes}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">step_kha_laplace</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">kernlab::kha</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">transformation steps</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #E6E7E3;"
data-bgcolor="#E6E7E3" data-valign="middle">{recipes}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">step_kha_tanh</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::kha</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">transformation steps</td>
</tr>
<tr style="border-style: none;">
<td class="gt_row gt_left gt_striped" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #838873;"
data-bgcolor="#838873" data-valign="middle">{probably}</td>
<td class="gt_row gt_left gt_striped" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">int_conformal_quantile_svm</td>
<td class="gt_row gt_left gt_striped" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle"
data-bgcolor="rgba(128, 128, 128, 0.05)">qrsvm::qrsvm</td>
<td class="gt_row gt_left gt_striped" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; background-color: rgba(128, 128, 128, 0.05); padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle" data-bgcolor="rgba(128, 128, 128, 0.05)">prediction
intervals</td>
</tr>
<tr style="border-style: none; border-bottom: 2px solid #ffffff00;">
<td class="gt_row gt_left" headers="extension"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px; font-weight: bold; background-color: #838873;"
data-bgcolor="#838873" data-valign="middle">{probably}</td>
<td class="gt_row gt_left" headers="maize"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">cal_estimate_svm</td>
<td class="gt_row gt_left" headers="engine"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">kernlab::ksvm</td>
<td class="gt_row gt_left" headers="mode"
style="text-align: left; border-style: none; padding-top: 2px; padding-bottom: 2px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: rgba(255, 255, 255, 0); border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; padding: 5px 5px 5px 25px; font-family: &#39;Open Sans&#39;; font-size: 14px;"
data-valign="middle">calibrator</td>
</tr>
</tbody><tfoot class="gt_sourcenotes"
style="border-style: none; color: #333333; background-color: #FFFFFF; border-bottom-style: none; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3;"
data-bgcolor="#FFFFFF">
<tr style="border-style: none;">
<td colspan="4" class="gt_sourcenote"
style="text-align: left; border-style: none; padding-top: 4px; padding-bottom: 0px; font-family: Almarai; font-size: 12px; padding-right: 0px; padding-left: 0px;"><div
style="background-color: transparent; width: 100%; margin-left: auto; margin-right: auto;">
<div style="height: 10px; background-color: #E6E7E3;">
&#10;</div>
<div style="height: 10px; background-color: #B4B8AB;">
&#10;</div>
<div style="height: 10px; background-color: #838873;">
&#10;</div>
<div style="height: 10px; background-color: #51593B;">
&#10;</div>
<div style="height: 10px; background-color: #202A04;">
&#10;</div>
</div></td>
</tr>
</tfoot>
&#10;</table>

</div>
