#include "minigui.ch"

#xcommand WITH <oObject> DO => Self := <oObject>
#xcommand ENDWITH           => Self := NIL

Memvar Self

PROCEDURE Main

	DEFINE WINDOW Form_1 ;
		AT 0,0 ;
		WIDTH 400 ;
		HEIGHT 400 ;
		TITLE 'MiniGUI ODBC Demo' ;
		MAIN  

		DEFINE MAIN MENU
			DEFINE POPUP 'File'
				MENUITEM 'Test' ACTION Test()
				SEPARATOR
				MENUITEM 'Exit'	ACTION Form_1.Release
			END POPUP
		END MENU

	END WINDOW

	CENTER WINDOW Form_1

	ACTIVATE WINDOW Form_1

RETURN


Function TEST

	//2025-06-23
	//mysql-connector-odbc-5.3.13-winx64.msi
	//error
	//LOCAL cConStr := "Server=localhost;Driver={MySQL ODBC 5.3 ANSI Driver};dsn=;User=root;password=1234;database=mcg_db;"
	//error
	//LOCAL cConStr := "Provider=MSDASQL;Driver={MySQL ODBC 5.2 ANSI Driver};Server=localhost;Database=mcg_db;User=root;Password=1234;Option=3;"
	//error
	//LOCAL cConStr := "Server=localhost;Driver={MySQL ODBC 5.3 ANSI Driver};dsn=;User=root;password=1234;database=mcg_db;Option=3;"

	//2025-06-23
	//mariadb-connector-odbc-3.2.6-win64.msi
	//error
	//LOCAL cConStr := "Server=localhost;Driver={MariaDB ODBC 3.2 Driver};dsn=;User=root;password=1234;database=mcg_db;"

	
	//2020-11-10 ok running!
	//2025-06-23 mysql-connector-odbc-3.51.30-winx64.msi
	LOCAL cConStr := "Server=localhost;Driver={MySQL ODBC 3.51 Driver};dsn=;User=root;password=;database=mcg_db;"
	

	

	LOCAL dsFunctions := TODBC():New( cConStr )

	Str:='SELECT AbsenceTypeCode FROM tblAbsenceType'
	dsFunctions:Setsql(Str)
	if !dsFunctions:Open()
		msgstop("Can't connect to database")
	else
		//MsgInfo("OK")
	endif
 

   WITH dsFunctions DO

      ::SetSQL( "SELECT * FROM tblabsencetype" )
	  //::SetSQL( "CALL test_output_procedure" )
      if ::Open()

		/////
         // Put data in fields array
         ::LoadData( ::nRecNo )

         *MsgInfo( ::FieldByName( "result" ):Value )

         *::Skip()
		 *
         MsgInfo ( ::FieldByName( "AbsenceTypeCode" ):Value )
		 
         ::GoTo( 1 )
		 
         MsgInfo ( ::FieldByName( "AbsenceTypeCode" ):Value )
		 
         ::Prior()
		 
         MsgInfo ( ::FieldByName( "AbsenceTypeCode" ):Value )
		 
         ::First()
		 
         MsgInfo ( ::FieldByName( "AbsenceTypeCode" ):Value )
		 
         ::Last()
		 
         MsgInfo ( ::FieldByName( "AbsenceTypeCode" ):Value )

         ::Close()
		/////
      endif

   ENDWITH

   dsFunctions:Destroy()

Return NIL
