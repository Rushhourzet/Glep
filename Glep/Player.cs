using Godot;
using System;

public class Player : RigidBody
{
	Camera camera;
	float cameraSens = 0.001f, movementForce = 1000f;

	public override void _Ready()
	{
		camera = (Camera)GetNode("Camera");
	}

	public override void _Process(float delta){
		// GD.Print(camera.Rotation.x);
	}

	public override void _PhysicsProcess(float delta)
	{
		ApplyCentralImpulse(
			getMovementForceVector(camera.GlobalTransform.basis.z.Normalized(), Transform.basis.x.Normalized(), Transform.basis.y.Normalized()) 
			* movementForce * delta);
		
		if(Input.IsActionJustPressed("gravity_toggle")){
			if(GravityScale == 1){
				GravityScale = 0;
			}
			else{
				GravityScale = 1;
			}
		}
	}

	private static Vector3 getMovementForceVector(Vector3 forward, Vector3 right, Vector3 up){
		Vector3 moveDirection = new Vector3();
		if (Input.IsActionPressed("move_forward")){
			moveDirection += Vector3.Forward;
		}
		if (Input.IsActionPressed("move_back")){
			moveDirection += Vector3.Back;
		}
		if (Input.IsActionPressed("move_left")){
			moveDirection += Vector3.Left;
		}
		if (Input.IsActionPressed("move_right")){
			moveDirection += Vector3.Right;
		}
		if (Input.IsActionPressed("move_up")){
			moveDirection += Vector3.Up;
		}
		if (Input.IsActionPressed("move_down")){
			moveDirection += Vector3.Down;
		}
		Vector3 movement = forward * moveDirection.z + right * moveDirection.x + up * moveDirection.y;		
		return movement;
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
