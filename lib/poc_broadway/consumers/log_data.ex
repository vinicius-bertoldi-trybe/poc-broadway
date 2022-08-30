defmodule PocBroadway.Consumers.LogData do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: LogData,
      producer: [
        module: {BroadwayRabbitMQ.Producer,
          queue: "poc_broadway",
          qos: [
            prefetch_count: 50,
          ],
          on_failure: :reject_and_requeue_once
        },
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 50
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    |> Message.update_data(&Jason.decode!/1)
    |> process_message()
  end


  defp process_message(%Message{} = message) do
    IO.puts("\nProcessing Message...")
    IO.inspect(message, label: "Message")

    message
  end
end
