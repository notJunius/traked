package traked
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"


pages :: enum {
	home,
	lift,
	weight,
}

main :: proc() {
	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Traked")
	rl.SetTargetFPS(60)
	currentPage := pages.home
	title_pos: rl.Vector2
	show_mouse: bool = true
	currentWeight := 260

	for !rl.WindowShouldClose() {
		mouse_pos := rl.GetMousePosition()

		if rl.IsMouseButtonReleased(.LEFT) {
			show_mouse = !show_mouse
			fmt.println(mouse_pos)
		}


		title_pos = {20, 25}
		switch currentPage {
		case .home:
			if rl.IsKeyReleased(.SPACE) {
				currentPage = .lift
			}
		case .lift:
			if rl.IsKeyReleased(.SPACE) {
				currentPage = .weight
			}
		case .weight:
			if rl.IsKeyReleased(.SPACE) {
				currentPage = .home
			}
		}


		rl.BeginDrawing()
		rl.ClearBackground({30, 30, 46, 255})
		switch currentPage {
		case .home:
			rl.DrawText("Home", i32(title_pos.x), i32(title_pos.y), 32, rl.WHITE)
			rl.DrawRectangleLines(125, 30, 500, 300, rl.WHITE)
			rl.DrawText("Stats", 340, 30, 32, rl.WHITE)
			avg_weight := fmt.aprintf("Avg Weight: %i", currentWeight)
			rl.DrawText(strings.clone_to_cstring(avg_weight), 140, 130, 32, rl.WHITE)
		case .lift:
			rl.DrawText("Lift", i32(title_pos.x), i32(title_pos.y), 32, rl.WHITE)
		case .weight:
			rl.DrawText("Weight", i32(title_pos.x), i32(title_pos.y), 32, rl.WHITE)

		}
		rl.EndDrawing()
	}
	rl.CloseWindow()


}
