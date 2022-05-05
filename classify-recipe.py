import prodigy
from prodigy.components.loaders import Audio
from prodigy.components.sorters import prefer_uncertain
import random

@prodigy.recipe("classify-audio")
def classify_audio(dataset, source):
    def score_stream(stream):
        for example in stream:
            score = random.random()
            yield (score, example)

    def get_stream():
        stream = Audio(source)
        stream = prefer_uncertain(score_stream(stream))

        for eg in stream:
            eg["options"] = [
                {"id": "DISTRESS", "text": "Distress"},
                {"id": "HAPPY", "text": "Happiness"},
                {"id": "OTHER", "text": "Other / Unclear"}
            ]
            yield eg

    return {
        "dataset": dataset,
        "stream": get_stream(),
        "view_id": "choice",
        "config": {
            "choice_style": "single",  # or "multiple"
            #"choice_auto_accept": True,
            "audio_loop": True,
            "show_audio_minimap": False
        }
    }