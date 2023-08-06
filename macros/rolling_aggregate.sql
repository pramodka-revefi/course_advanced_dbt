{% macro rolling_aggregate(column_name, partition_by, order_by, aggregate_fn='avg', lookback_window_periods=7) %}
    {{ aggregate_fn }}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ lookback_window_periods - 1 }} PRECEDING AND CURRENT ROW
            ) AS rolling_{{ lookback_window_periods }}_periods_{{ column_name }}_{{ aggregate_fn }}_per_{{ partition_by }}
{% endmacro %}
