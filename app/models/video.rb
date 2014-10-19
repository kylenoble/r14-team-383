# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  game_id         :integer          not null
#  name            :text
#  video_code      :text
#  renba_views     :integer          default("1"), not null
#  problem_reports :integer          default("1"), not null
#  license         :text
#  published_at    :datetime
#  views           :integer          default("1"), not null
#  likes           :integer          default("1"), not null
#  dislikes        :integer          default("1"), not null
#  new             :boolean          default("f"), not null
#  hd              :boolean          default("f"), not null
#  highlights      :boolean          default("f"), not null
#  description     :text
#  length          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_videos_on_created_at    (created_at)
#  index_videos_on_name          (name)
#  index_videos_on_published_at  (published_at)
#  index_videos_on_video_code    (video_code)
#

class Video < ActiveRecord::Base
	belongs_to :game
end
