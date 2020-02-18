using Godot;
using System;

public class Player : RigidBody
{
	Camera camera;
	float cameraSens = 0.01f, movementForce;

	public override void _Ready()
	{
		camera = (Camera)GetNode("Camera");
	}

	public override void _Process(float delta){
		GD.Print(camera.Rotation.x);
	}

	public override void _PhysicsProcess(float delta){
		if(Input.IsActionPressed("move_forward")){
			
		}
	}

	public override void _UnhandledInput(InputEvent @event){
		if(@event is InputEventMouseMotion eventMouseMotion){
			this.RotateY(-eventMouseMotion.Relative.x * cameraSens);
			camera.RotateX(-eventMouseMotion.Relative.y * cameraSens);
			camera.Rotation = new Vector3(Clamp(camera.Rotation.x, -(float)Math.PI/2, (float)Math.PI/2), 0.0f, 0.0f);
		}
	}
	public static float Clamp(float value, float min, float max)  
	{  
		return (value < min) ? min : (value > max) ? max : value;  
	}
}
