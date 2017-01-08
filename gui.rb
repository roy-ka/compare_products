class GUI

  def initialize
    @link1 = FXDataTarget.new("insert first link")
    @link2 = FXDataTarget.new("insert second link")
    @temp = FXDataTarget.new(" ")
  end

  def load_graphics
    manager = FXApp.new
    main_win = FXMainWindow.new(manager, "Products compare",:width => 800, :height => 300)
    matrix = FXMatrix.new(main_win, 2, MATRIX_BY_COLUMNS|LAYOUT_SIDE_TOP|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(matrix, "&Link1", nil, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW)
    FXTextField.new(matrix, 100, @link1, FXDataTarget::ID_VALUE,
                    LAYOUT_CENTER_Y|LAYOUT_CENTER_X|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_ROW)
    FXLabel.new(matrix, "&Link2", nil, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW)
    FXTextField.new(matrix, 100, @link2, FXDataTarget::ID_VALUE,
                    LAYOUT_CENTER_Y|LAYOUT_CENTER_X|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_ROW)
    FXLabel.new(matrix, "&result:", nil, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW)
    @score= FXTextField.new(matrix,100,@temp, TEXT_READONLY|LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW, :width =>50 )
    FXLabel.new(matrix, "&", nil, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW)
    FXLabel.new(matrix, "&A score above 100 means it's the same product", nil, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_RIGHT|LAYOUT_FILL_ROW)
    compare_button = FXButton.new(matrix, "compare" )
    compare_button.connect(SEL_COMMAND) {
      links = [@link1.to_s, @link2.to_s]
      result = MatchingManager.new.match(links)
      if result.kind_of? Hash
        @score.setText(result[links].get_score.to_i.to_s)
      else
        @score.setText(result.to_s)
      end
       p "done"
    }
    exit_button = FXButton.new(matrix, "exit", :x =>50, :y =>50, :width =>50, :height =>0)
    exit_button.connect(SEL_COMMAND) { exit }

    manager.create
    main_win.show
    manager.run
  end







end