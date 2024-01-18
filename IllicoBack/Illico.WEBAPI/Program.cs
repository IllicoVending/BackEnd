using Illico.DAL.Interfaces;
using System.Data.SqlClient;
using Illico.BLL.Interfaces;
using Illico.BLL.Services;
using Illico.DAL.Interfaces;
using Illico.DAL.Repositories;
using Illico.WEBAPI.Services;

var builder = WebApplication.CreateBuilder(args);



// Add services to the container.
SqlConnection connection = new SqlConnection("Server=5346\\SQLSERVER;DataBase=IllicoDB;User ID=sa;Password=formation;Encrypt=False");

builder.Services.AddScoped<IProductRepository, ProductRepository>(x => new ProductRepository(connection)); // Une seule instance est créée pour toute l'API
builder.Services.AddScoped<IProductService, ProductService>(); // Une seule instance est créée pour toute l'API

builder.Services.AddScoped<IPersonRepository, PersonRepository>(x => new PersonRepository(connection)); // Une seule instance est créée pour toute l'API
builder.Services.AddScoped<IPersonService, PersonService>(); // Une seule instance est créée pour toute l'API

builder.Services.AddScoped<TokenService>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(opt =>
{
    opt.AddPolicy("legrosseum", config =>
    {
        // Tout autoriser
        config.AllowAnyOrigin();
        config.AllowAnyHeader();
        config.AllowAnyMethod();

        // Limiter l'origine de la requete
        // config.WithOrigins("http://127.0.0.1:5500");
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

app.UseCors("legrosseum");

app.UseAuthorization();

app.MapControllers();

app.Run();