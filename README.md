# Owid-Covid-Analysis
Our World in Data - Covid Analysis
<h2> Day 1 </h2>
<ul> 
  <li> Configure SQL server for Mac (Intel Chip) </li>
     <ul>
       <li> Download docker for Mac (Intel Chip) </li>
       <li> Open terminal and enter the following commands </li>
          <ul>
            <li> docker pull mcr.microsoft.com/mssql/server:2017-latest </li>
            <li> docker run -d --name ms-sql-server -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=xxxxxxx' -p 1433:1433 mcr.microsoft.com/mssql/server:2017-latest </li>
         </ul>
    </ul>
  <li>Download and install Azure Data Studio</li>
  <ul>
    <li> Start new connection </li>
      <ul>
        <li> Set server name to "localhost"</li>
        <li> Enter username and password as in link i.e "SA" and "xxxxxxx" </li>
        <li> Connect </li>
      </ul>
  </ul>
  <li> Create a SQL Server Database and Import csv file data with Azure Data Studio </li>
  <ul>
    <li> Open a New Query Editor by clicking on the <i> New Query </i> button on the Server Dashboard </li>
    <li> Create the Database by running the command "CREATE DATABASE CovidData;"</li>
    <li> Install the SQL Server Import extension </li>
    <li> Right-click on the database just created and select Import Wizard.</li>
    <li> Complete the "Specify Input File" step </li>
    <ul>
      <li> Before this step</li>
      <ul>
        <li>change all dd/mm/yy date to yyyy-mm-dd format since SQL server accepts the latter format </li>
        <li> ....... </li>
        </ul> 
    </ul>
    <li> Preview Changes</li>
    <li> Modify Columns</li>
    <ul>
      <li> For each column name, set the appropirate data type. Columns such as "total_tests" must be sent to bigint and "smoothed" data columns to be float </li>
      <li> Set "test_units" to nvarchar(20) since this column's data requires only  20 <b>byte-pairs</b> to store the test unit. Refer misconception (to think that NCHAR(n) and NVARCHAR(n), the n defines the number of characters) remarks <a href="https://docs.microsoft.com/en-us/sql/t-sql/data-types/nchar-and-nvarchar-transact-sql?WT.mc_id=DP-MVP-5001259&view=sql-server-ver15">here</a> </li>
      <li> Remember not to set column type (such as "extreme_poverty") bearing blanks as "float" or any data type that cannot represent NULL value </li>
      <li> Change "diabetes_prevalance" data type from "time" to "nvarchar" </li>
      <li> "new_vaccinations_smoothed_per_million" from "nvarchar(1)" to "nvarchar(50)"</li>
      <li> "new_people_vaccinated_smoothed" from from "nvarchar(1)" to "nvarchar(50) </li>
      <li> new_people_vaccinated_smoothed_per_hundred from "nvarchar(1)" to "nvarchar(50) </li>
      <li> total_vaccinations from  "nvarchar(1)" to "nvarchar(50)"  - & not bigint since column contains null values and NULL!=zero!</li>
      <li> people_vaccinated  from  "nvarchar(1)" to "nvarchar(50)"</li>
      <li> total_vaccinations_per_hundred from  "nvarchar(1)" to "nvarchar(50)"</li>
      <li> people_fully_vaccinated  and all such columns</li>
      <li> Allow null value for "stringency_index", "continent", "population_density", "median_age" ( delete all rows with null value in earlier steps - plan to do the same using sql later on - therefore changing  data type from float to nvarchar)", </li>
      <li> Remove all such subsequent errors by modifying the csv file <strong>(much better practice)</strong> or by modifying the data type</li>
    </ul>
  </ul>
  
  </ul>
