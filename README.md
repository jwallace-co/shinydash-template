# shinydash-template

This example project demonstrates implementing an R shiny dashboard, using structured queries to published data, and an export function for producing a powerpoint pack using the resulting graphs.

The project is split into multiple sections to modularise the code, and allow expansion. It is recommended that you follow a similar structure when developing a dashboard to allow for future development and expansion.

### Core R shiny code

There are three files that set out the structure of a standard R shiny app:

- global.R which runs when the server starts, and can be used to pre-load libraries, functions, and variables
- server.R which holds the interactive and dynamically generated elements
- ui.R which sets out the user interface

### Dashboard pages

The upper level structure of the dashboard is set out in ui.R, with the layout for individual files kept in separate files within the 'pages' subfolder with a suffix of 'ui'. Similarly, the reactive functions and scripts for each page are held within this subfolder with a suffix of 'server'. Note that for server.R the 'source' call to import these files needs to be within the server function and include the local=TRUE option so that the local code is run from within the server environment rather than the global environment.

The demo uses the base shiny navbarPage format for the high level structure, with the individual pages built using the dashboardPage format from the shinydashboard package.

### Helper functions

Some of the more complex repeated actions have been condensed into helper functions within the 'scripts' folder:

- colour schemes.R for consistent colour schemes
- data browser functions.R for access to the civil service stats data browser
- format_table.R for standardised formatting of the tables in the dashbaords
- powerpoint slide formats.R has standardised ways to add new slides to the powerpoint template

### Powerpoint export

Using the 'officer' library, it is possible to generate a powerpoint slide deck using the same graphing capabilities as are available in shiny. This allows you to reuse code from the dashboard in a static output.

A key component of this is a base template with slide outlines which can be found in the 'template_powerpoint' subfolder. The helper functions found in 'scripts/powerpoint slide formats.R' are then used by the 'pages/download server.R' code to set up an export of the graphs into this standard format.
