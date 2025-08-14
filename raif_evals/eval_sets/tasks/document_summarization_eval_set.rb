module Raif
  module Evals
    module Tasks
      class DocumentSummarizationEvalSet < Raif::Evals::EvalSet
        eval "DocumentSummarization produces expected output" do
          user = User.create!(email_address: "demo@example.com", password: "password")
          document = Document.create!(content: file("arc.html"), user: user)

          task = Raif::Tasks::DocumentSummarization.run(document: document)

          expect "task completes successfully" do
            task.completed?
          end

          summary = task.parsed_response
          expect "the summary is between 500 and 1500 words", result_metadata: { word_count: summary.length } do
            summary.length.between?(500, 1500)
          end

          basic_html_tags = %w[p b i div strong]
          expect "contains basic HTML tags in the output" do
            basic_html_tags.any? { |tag| task.parsed_response.include?("<#{tag}>") }
          end

          # Use LLM to judge the clarity of the summary
          expect_llm_judge_score(
            task.parsed_response,
            scoring_rubric: Raif::Evals::ScoringRubric.clarity,
            min_passing_score: 4,
            result_metadata: {
              compression_ratio: (document.content.length.to_f / summary.length).round(2)
            }
          )
        end
      end
    end
  end
end
