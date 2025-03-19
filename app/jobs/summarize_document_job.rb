class SummarizeDocumentJob < ApplicationJob
  queue_as :default

  def perform(document)
    task = Raif::Tasks::DocumentSummarization.run(document: document, creator: document.user)
    document.update(summary: task.parsed_response)

    Turbo::StreamsChannel.broadcast_update_to(
      :document_summaries,
      target: "document-summary",
      partial: "documents/summary",
      locals: { document: document }
    )
  end
end
