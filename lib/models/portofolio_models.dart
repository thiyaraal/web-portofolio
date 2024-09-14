// To parse this JSON data, do
//
//     final myPortofolioData = myPortofolioDataFromMap(jsonString);

import 'dart:convert';

MyPortofolioData myPortofolioDataFromMap(String str) => MyPortofolioData.fromMap(json.decode(str));

String myPortofolioDataToMap(MyPortofolioData data) => json.encode(data.toMap());

class MyPortofolioData {
    Biodata? biodata;
    List<Service>? services;
    List<String>? skills;
    Projects? projects;
    List<Experience>? experience;

    MyPortofolioData({
        this.biodata,
        this.services,
        this.skills,
        this.projects,
        this.experience,
    });

    factory MyPortofolioData.fromMap(Map<String, dynamic> json) => MyPortofolioData(
        biodata: json["biodata"] == null ? null : Biodata.fromMap(json["biodata"]),
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromMap(x))),
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        projects: json["projects"] == null ? null : Projects.fromMap(json["projects"]),
        experience: json["experience"] == null ? [] : List<Experience>.from(json["experience"]!.map((x) => Experience.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "biodata": biodata?.toMap(),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toMap())),
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "projects": projects?.toMap(),
        "experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x.toMap())),
    };
}

class Biodata {
    String? name;
    String? description;
    String? email;
    String? resemu;
    List<Contact>? contact;

    Biodata({
        this.name,
        this.description,
        this.email,
        this.resemu,
        this.contact,
    });

    factory Biodata.fromMap(Map<String, dynamic> json) => Biodata(
        name: json["name"],
        description: json["description"],
        email: json["email"],
        resemu: json["resemu"],
        contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "email": email,
        "resemu": resemu,
        "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toMap())),
    };
}

class Contact {
    String? phone;
    String? email;
    String? instagram;
    String? linkedIn;
    String? github;
    String? behance;

    Contact({
        this.phone,
        this.email,
        this.instagram,
        this.linkedIn,
        this.github,
        this.behance,
    });

    factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        phone: json["phone"],
        email: json["email"],
        instagram: json["instagram"],
        linkedIn: json["linkedIn"],
        github: json["github"],
        behance: json["behance"],
    );

    Map<String, dynamic> toMap() => {
        "phone": phone,
        "email": email,
        "instagram": instagram,
        "linkedIn": linkedIn,
        "github": github,
        "behance": behance,
    };
}

class Experience {
    String? name;
    String? experienceName;
    String? year;
    List<String>? description;
    String? link;

    Experience({
        this.name,
        this.experienceName,
        this.year,
        this.description,
        this.link,
    });

    factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        name: json["name"],
        experienceName: json["experience_name"],
        year: json["year"],
        description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
        link: json["link"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "experience_name": experienceName,
        "year": year,
        "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
        "link": link,
    };
}

class Projects {
    List<App>? app;
    List<Design>? design;

    Projects({
        this.app,
        this.design,
    });

    factory Projects.fromMap(Map<String, dynamic> json) => Projects(
        app: json["app"] == null ? [] : List<App>.from(json["app"]!.map((x) => App.fromMap(x))),
        design: json["design"] == null ? [] : List<Design>.from(json["design"]!.map((x) => Design.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "app": app == null ? [] : List<dynamic>.from(app!.map((x) => x.toMap())),
        "design": design == null ? [] : List<dynamic>.from(design!.map((x) => x.toMap())),
    };
}

class App {
    String? name;
    String? date;
    String? description;
    String? link;
    List<String>? buildWith;

    App({
        this.name,
        this.date,
        this.description,
        this.link,
        this.buildWith,
    });

    factory App.fromMap(Map<String, dynamic> json) => App(
        name: json["name"],
        date: json["date"],
        description: json["description"],
        link: json["link"],
        buildWith: json["build_with"] == null ? [] : List<String>.from(json["build_with"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "date": date,
        "description": description,
        "link": link,
        "build_with": buildWith == null ? [] : List<dynamic>.from(buildWith!.map((x) => x)),
    };
}

class Design {
    String? name;
    String? date;
    String? description;
    String? link;
    List<String>? toolsUsed;

    Design({
        this.name,
        this.date,
        this.description,
        this.link,
        this.toolsUsed,
    });

    factory Design.fromMap(Map<String, dynamic> json) => Design(
        name: json["name"],
        date: json["date"],
        description: json["description"],
        link: json["link"],
        toolsUsed: json["tools_used"] == null ? [] : List<String>.from(json["tools_used"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "date": date,
        "description": description,
        "link": link,
        "tools_used": toolsUsed == null ? [] : List<dynamic>.from(toolsUsed!.map((x) => x)),
    };
}

class Service {
    String? name;
    String? description;

    Service({
        this.name,
        this.description,
    });

    factory Service.fromMap(Map<String, dynamic> json) => Service(
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
    };
}
