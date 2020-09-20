FactoryBot.define do
  factory :user do
    nickname                {Faker::Name.initials}
    email                   {Faker::Internet.free_email}
    password                {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation   {password}
    birthday                {Faker::Date.between(from: '1999-09-23', to: '2014-09-25')}
    
    #日本語名前生成記述('gimei' gemを使用)
    gimei = Gimei.name
    first_name        {gimei.first.kanji}
    first_name_kana   {gimei.first.katakana}
    last_name         {gimei.last.kanji}
    last_name_kana    {gimei.last.katakana}
  end
end