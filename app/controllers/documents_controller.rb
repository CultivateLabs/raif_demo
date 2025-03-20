class DocumentsController < ApplicationController
  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id
    if @document.save
      SummarizeDocumentJob.perform_later(@document)
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def document_params
      params.expect(document: [ :content, :summary, :user_id ])
    end
end
