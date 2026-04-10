{% macro clean_accents(column_name) %}
    TRANSLATE(
        {{ column_name }}, 
        'ôÎ', 
        'oI'
    )
{% endmacro %}