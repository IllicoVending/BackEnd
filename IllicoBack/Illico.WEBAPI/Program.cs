using Illico.DAL.Interfaces;
using System.Data.SqlClient;
using Illico.BLL.Interfaces;
using Illico.BLL.Services;
using Illico.DAL.Interfaces;
using Illico.DAL.Repositories;

var builder = WebApplication.CreateBuilder(args);



// Add services to the container.
SqlConnection connection = new SqlConnection("Server=5346\\SQLSERVER;DataBase=IllicoDB;User ID=sa;Password=formation;Encrypt=False");

builder.Services.AddScoped<IProductRepository, ProductRepository>(x => new ProductRepository(connection)); // Une seule instance est créée pour toute l'API
builder.Services.AddScoped<IProductService, ProductService>(); // Une seule instance est créée pour toute l'API

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("MyAllowSpecificOrigins",
    builder =>
    {
        builder.WithOrigins("http://localhost:4200")
               .AllowAnyHeader()
               .AllowAnyMethod();
    });
});


var app = builder.Build();


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseCors(builder =>
{
    builder.AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader();
});

app.MapControllers();

app.Run();