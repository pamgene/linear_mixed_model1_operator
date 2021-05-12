# Linear mixed model1 operator

##### Description

The `linear mixed model1` operator performs a mixed model analysis with 1 fixed and 1 random factor.

##### Usage

Input projection|.
---|---
`y-axis`| measurement value
`x-axis`| random factor, i.e. Barcode. Note that the random factor is not nested in the fixed hence, hence if the same value of the random factor occurs for multiple values of the fixed factor this results in a "paired" analysis for the fixed effect Use unique values for the random factor if this is not intended.
`color` | fixed factor, i.e. Sample Name. When using a fixed factor which is numerical then the effect is interpreted as a slope and significance is associated with the zero slope (i.e. null hypothesis).

Properties|.
---|---
`Main Grouping Factor`| Indicate if the main grouping factor (i.e. fixed effect) must be treated as categorical or numerical. Default value is categorical.

Output relations|.
---|---
`pMain, logpMain`| numeric, p-value calculated per cell
`fdr`| 	p-value after false discovery adjustment
`Top`| per test rank according to p-value, if there is only one column in the calling cross-tab this value is returned as spot annotation.

##### Details

This is an operator to perform a [mixed model analysis](https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=Mixed%20Model%201%20way) with 1 fixed and 1 random factor.
Some examples with one fixed and one random factor are:
* studying a drug treatment effect (i.e. fixed factor) in a populations of cells lines (i.e. random effect).  
It is implemented as an  [operator PamApp](https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=Operator%20PamApp) (i.e. [RStepOperator](https://pamcloud.pamgene.com/wiki/Wiki.jsp?page=RStepOperator)).
