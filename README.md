# fluent-plugin-raw-data-parser
######Fluent source parser plugin for parsing kye/value fileds in Low Data.
######This plugin support to change from RawData to JSON.

# Installation
```
Use RubyGems:
 not support yet.(comming)
```

# Configuration
######examaple. Input source.
<pre>
&lt;source&gt;
  type tail
  format rawdata
  pType testParser
  pColumn time,test1,test2,test3,test4,test5,test6
  pPattern 14,2,4,4,4,2,4
  tag td.log.data
&lt;/source&gt;
</pre>



######examaple. Output Match.
<pre>
&lt;match td.log.data&gt;
  type tdlog
  endpoint xxxxx
  apikey xxxxx
  auto_create_table
  buffer_type file
  buffer_path /path/path
  use_ssl true
&lt;/match&gt;
</pre>

# Output

######Original RawData Log.
<pre>
 : 2016031809404940120808816427146806
</pre>

######output
<pre>
 : Key : value
   {"time":"20160318094049"},
   {"test1":"40"},
   {"test2":"1208"},
   {"test3":"0881"},
   {"test4":"6427"},
   {"test5":"14"},
   {"test6":"6806"},
   {"pType":"testParser"}
</pre>
