using LegacySimulationApi.Services;

var builder = WebApplication.CreateBuilder(args);

// Logging & Configuration already provided by default
builder.Services.AddControllers();
builder.Services.AddSingleton<ProcessService>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseRouting();
app.UseAuthorization();

app.MapControllers();

app.Run();
