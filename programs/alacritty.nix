{
	programs.alacritty = {
		enable = true;
		settings = {
			window = {
				opacity = 0.9;
				padding = {
					x = 10;
					y = 10;
				};
			};

			font = {
				normal = {
					family = "JetBrains Mono";
					style = "Regular";
				};
				bold = {
					family = "JetBrains Mono";
					style = "Bold";
				};
				italic = {
					family = "JetBrains Mono";
					style = "Italic";
				};
				size = 12.0;
			};
			colors = {
				primary = {
					background = "#1a1b26";     # Основной темно-синий фон Tokyo Night
					foreground = "#c0caf5";     # Основной светло-голубой текст
				};
				cursor = {
					text = "#1a1b26";           # Цвет текста под курсором
					cursor = "#c0caf5";         # Цвет курсора (светло-голубой)
				};
				# Обычные цвета Tokyo Night
				normal = {
					black = "#15161e";          # Черный (очень темный синий)
					red = "#f7768e";            # Красный (ошибки, git diff удаления)
					green = "#9ece6a";          # Зеленый (успех, git diff добавления)
					yellow = "#e0af68";         # Желтый (предупреждения)
					blue = "#7aa2f7";           # Синий (директории в ls, ссылки)
					magenta = "#bb9af7";        # Пурпурный (архивы, специальные файлы)
					cyan = "#7dcfff";           # Голубой (символические ссылки)
					white = "#a9b1d6";          # Белый (обычный текст)
				};
				# Яркие версии цветов Tokyo Night
				bright = {
					black = "#414868";          # Яркий черный (серо-синий)
					red = "#f7768e";            # Яркий красный
					green = "#9ece6a";          # Яркий зеленый
					yellow = "#e0af68";         # Яркий желтый
					blue = "#7aa2f7";           # Яркий синий
					magenta = "#bb9af7";        # Яркий пурпурный
					cyan = "#7dcfff";           # Яркий голубой
					white = "#c0caf5";          # Яркий белый
				};
			};
		};

	};
}
