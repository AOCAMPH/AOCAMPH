package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;


public class DataGenerator {
    
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }

    public static int getRandomIdPlaya(){
        Faker faker = new Faker();
        int idPlaya= 0;

        idPlaya = faker.number().numberBetween(1,12);

        return idPlaya;
    }

    public static int getRandomIdUsuario(){
        Faker faker = new Faker();
        int idUsuario= 0;

        idUsuario = faker.number().numberBetween(2,6);

        return idUsuario;
    }

    public static String getRandomFechaReserva(){
        Faker faker = new Faker();
        String fechaReserva= "";

        fechaReserva = faker.number().numberBetween(2022,2022) +"-" + faker.number().numberBetween(1,12) + "-" +faker.number().numberBetween(1,30) + "T14:57:14.000Z";

        return fechaReserva;
    }

    public static double getRandomPrecioReserva(){
        Faker faker = new Faker();
        double precioReserva= 0;

        precioReserva = faker.number().randomDouble(2,1,20);

        return precioReserva;
    }

    public static int getRandomIdVehiculo(){
        Faker faker = new Faker();
        int idVehiculo= 0;

        idVehiculo = faker.number().numberBetween(5,31);

        return idVehiculo;
    }


    public static JSONObject getDataReserve(){
        Faker faker = new Faker();
        int idPlaya = faker.number().numberBetween(1,12);
        int idUsuario = faker.number().numberBetween(2,6);
        String fechaReserva = "2022-02-15T14:57:14.000Z";
        double precioReserva = faker.number().randomDouble(2,1,20);
        int idVehiculo = faker.number().numberBetween(5,31);

        JSONObject json = new JSONObject();
        json.put("idPlaya",idPlaya);
        json.put("idUsuario",idUsuario);
        json.put("fechaReserva",fechaReserva);
        json.put("precioReserva",precioReserva);
        json.put("idVehiculo",idVehiculo);

        return json;
    }



}