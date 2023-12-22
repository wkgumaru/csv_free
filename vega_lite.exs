Mix.install([:vega_lite, :jason])

alias VegaLite, as: Vl

Vl.new()
|> Vl.data_from_url("https://vega.github.io/editor/data/weather.csv")
|> Vl.transform(filter: "datum.location == 'Seattle'")
|> Vl.concat([
  Vl.new()
  |> Vl.mark(:bar)
  |> Vl.encode_field(:x, "date", time_unit: :month, type: :ordinal)
  |> Vl.encode_field(:y, "precipitation", aggregate: :mean),
  '''
  Vl.new()
  |> Vl.mark(:point)
  |> Vl.encode_field(:x, "temp_min", bin: true)
  |> Vl.encode_field(:y, "temp_max", bin: true)
  |> Vl.encode(:size, aggregate: :count)
  '''
])
|> VegaLite.Export.save!("vega_lite.html", format: :html)
