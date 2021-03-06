#------------------------------------------
#ex1 scripts, part 1, before starting hive
#------------------------------------------
wget https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip
mv "Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip; charset=binary" "dataForEx1.zip"
unzip dataForEx1.zip "*.*" Makefile -d /user/lin/hospital_compare/dataForEx1
cd /user/lin/hospital_compare/dataForEx1

rename "Hospital General Information.csv" "hospital.csv" "Hospital General Information.csv"
tail -n +2 hospital.csv > hospital_noheader.csv

rename "Timely and Effective Care - Hospital.csv" "effective_care.csv" "Timely and Effective Care - Hospital.csv"
tail -n +2 effective_care.csv > effective_care_noheader.csv

rename "Readmissions and Deaths - Hospital.csv" "readmissions.csv" "Readmissions and Deaths - Hospital.csv"
tail -n +2 readmissions.csv > readmissions_noheader.csv

rename "hvbp_hcahps_05_28_2015.csv" "surveys_responses.csv" "hvbp_hcahps_05_28_2015.csv"
tail -n +2 surveys_responses.csv > surveys_responses_noheader.csv

rename "Measure Dates.csv" "measure_dates.csv" "Measure Dates.csv"
tail -n +2 measure_dates.csv > measure_dates_noheader.csv

#------------------------------------------
#ex1 scripts, part 2, after starting pyspark
#------------------------------------------
from pyspark.sql import SQLContext
from pyspark.sql.types import *
sqlContext = SQLContext(sc)
hospital = sc.textFile('file:///user/lin/hospital_compare/dataForEx1/hospital.csv')
noHeaderHospital  = hospital.zipWithIndex().filter(lambda (row,index): index > 0).keys()

effectiveCare = sc.textFile('file:///user/lin/hospital_compare/dataForEx1/effective_care.csv')
noHeaderEffectiveCare  = effectiveCare.zipWithIndex().filter(lambda (row,index): index > 0).keys()

readmissions = sc.textFile('file:///user/lin/hospital_compare/dataForEx1/readmissions.csv')
noHeaderReadmissions  = readmissions.zipWithIndex().filter(lambda (row,index): index > 0).keys()

surveysResponses = sc.textFile('file:///user/lin/hospital_compare/dataForEx1/surveys_responses.csv')
noHeaderSurveysResponses  = surveysResponses.zipWithIndex().filter(lambda (row,index): index > 0).keys()

measureDates = sc.textFile('file:///user/lin/hospital_compare/dataForEx1/measure_dates.csv')
noHeaderMeasureDates  = measureDates.zipWithIndex().filter(lambda (row,index): index > 0).keys()
