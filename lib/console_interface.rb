class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"]
    .sort
    .map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      #{"Слово: #{word_to_show}".colorize(:blue)}
      #{figure.to_s.colorize(:yellow)}
      #{"Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:red)}
      #{"У вас осталось ошибок: #{@game.errors_allowed}".colorize(:green)}

    END

    if @game.won?
      puts 'Поздравляем, вы выиграли!'.colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:red)
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
          '__'
        else
          letter
        end
      end

    result.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def get_input
    print 'Введите следующую букву: '.colorize(:light_blue)
    gets[0].upcase
  end
end
