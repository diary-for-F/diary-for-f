CREATE DATABASE IF NOT EXISTS feellm;

CREATE TABLE feellm.emotions (
  emotion_id  INT         NOT NULL AUTO_INCREMENT,
  name        VARCHAR(50) NOT NULL,

  PRIMARY KEY(emotion_id)
);

CREATE TABLE feellm.diary_entries (
  diary_id        INT       NOT NULL AUTO_INCREMENT,
  content         TEXT      NOT NULL,
  ai_feedback     TEXT      NULL,
  created_at      DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  main_emotion_id INT       NULL,

  PRIMARY KEY(diary_id),

  FOREIGN KEY(main_emotion_id) REFERENCES feellm.emotions(emotion_id)
);

CREATE TABLE feellm.diary_entry_emotions (
  emotion_id  INT NOT NULL,
  diary_id    INT NOT NULL,
  level       INT NOT NULL,

  FOREIGN KEY(emotion_id) REFERENCES feellm.emotions(emotion_id),
  FOREIGN KEY(diary_id) REFERENCES feellm.diary_entries(diary_id)
);
