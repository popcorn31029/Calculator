function numberconfigration = numberconfig(i,handle,predictedLabel)
textString=get(handle,'String');
if(strcmp(textString,'0')==1)&&(i==0)
   set(handle,'String',char(predictedLabel)) ;
elseif(strcmp(textString,'0')==0)&&(i==1)
   set(handle,'String',char(predictedLabel)) ; 
else
textString =strcat(textString,char(predictedLabel));
set(handle,'String',textString)
end