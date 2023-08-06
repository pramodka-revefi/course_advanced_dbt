{% macro start_date_of_month(date_column='CURRENT_DATE') %}
    DATE(DATE_TRUNC('month', {{ date_column }}))
{% endmacro %}
