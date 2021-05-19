# Valid $minute parameter to Cron::Job.
type Cron::Minute = Variant[
  Integer[0,59],
  Pattern[/(?x)\A(
    \* ( \/ ( [1-5][0-9]?|[6-9] ) )?
    |         [1-5]?[0-9] ( - [1-5]?[0-9] ( \/ ( [1-5][0-9]?|[6-9] ) )? )?
        ( ,   [1-5]?[0-9] ( - [1-5]?[0-9] ( \/ ( [1-5][0-9]?|[6-9] ) )? )? )*
  )\z/]
]