{% macro replace_comma(column_name) %} 

    (REPLACE({{column_name}}, ',', '.'))::NUMBER(10,2)

{% endmacro %}