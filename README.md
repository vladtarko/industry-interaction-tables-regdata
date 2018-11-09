# industry-interaction-tables-regdata

This is an R script for generating all the interactions between (NASCIS 3-digit) industries and the US regulatory agencies. The tables are based on the RegData 2.2 dataset.

# Requirements

You need to download the `metadata.csv` and the `industry_3digit.csv` from RegData 2.2: <https://quantgov.org/regdata-us/>. These files are too large to be uploaded here.

Citation:

> Al-Ubaydli, Omar, and McLaughlin, Patrick A. 2015. "RegData: A Numerical Database on Industry-Specific Regulations for All United States Industries and Federal Regulations, 1997–2012." _Regulation & Governance_ 11 (1): 109–23.

You can try to adapt the script with the newer datasets.

# What's included here

- the R script: `generate-tables.r`
- the resulting tables created by this script: `tables-3digit-industry.zip`. Inside the zip file:
    - an interactive table: `__table.html`
    - a simple aggregation of all the tables: `__table_simple.html`
    - all the tables as single html files

# Example:

Oil and Gas Extraction is regulated in the United States by the following agencies (cummulative restrictions from 1970 to 2014) :

| agency | 	restrictions | 
|------|-------------|
| Bureau of Export Administration, Department of Commerce | 1084 |
| Bureau of Indian Affairs, Department of the Interior | 33392 |
| Bureau of Land Management, Department of the Interior | 14784 |
| Bureau of Safety and Environmental Enforcement, Department of the Interior | 11181 |
| Coast Guard, Department of Homeland Security | 2327 |
| Coast Guard, Department of Transportation | 0 |
| Corps of Engineers, Department of the Army | 0 |
| EPA - General |34556 |
| Federal Energy Regulatory Commission, Department of Energy | 8980 |
| Geological Survey, Department of the Interior | 5182 |
| Internal Revenue Service, Department of the Treasury | 3529 |
| Mine Safety and Health Administration, Department of Labor | 0 |
| Minerals Management Service, Department of the Interior | 89496 |
| Office of Navajo and Hopi Indian Relocation | 5617 |
| Office of the Secretary, Department of the Treasury | 2 |
| Unattributed | 109 |
| United States Fish and Wildlife Service, Department of the Interior | 2424 |
| Utah Reclamation Mitigation and Conservation Commission | 198 |
| Other | 6936 |

