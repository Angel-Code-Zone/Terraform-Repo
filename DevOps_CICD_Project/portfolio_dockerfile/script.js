/* ======================================================
   SMOOTH SCROLLING
====================================================== */

document.querySelectorAll('nav a').forEach(anchor => {

    anchor.addEventListener('click', function (e) {

        e.preventDefault();

        const target = document.querySelector(this.getAttribute('href'));

        if (target) {

            target.scrollIntoView({

                behavior: 'smooth'

            });

        }

    });

});


/* ======================================================
   ACTIVE NAVIGATION
====================================================== */

const sections = document.querySelectorAll("section");

const navLinks = document.querySelectorAll("nav ul li a");

window.addEventListener("scroll", () => {

    let current = "";

    sections.forEach(section => {

        const sectionTop = section.offsetTop - 120;

        const sectionHeight = section.clientHeight;

        if (pageYOffset >= sectionTop) {

            current = section.getAttribute("id");

        }

    });

    navLinks.forEach(link => {

        link.classList.remove("active");

        if (link.getAttribute("href") === "#" + current) {

            link.classList.add("active");

        }

    });

});


/* ======================================================
   HEADER SHADOW
====================================================== */

const header = document.querySelector("header");

window.addEventListener("scroll", () => {

    if (window.scrollY > 60) {

        header.style.boxShadow = "0 10px 30px rgba(0,0,0,.35)";

    } else {

        header.style.boxShadow = "none";

    }

});


/* ======================================================
   TYPING EFFECT
====================================================== */

const roles = [

    "AWS Cloud Engineer",

    "DevOps Engineer",

    "Linux Administrator",

    "Terraform Engineer",

    "Docker & Kubernetes Enthusiast"

];

let roleIndex = 0;

let charIndex = 0;

let typing = true;

const roleElement = document.querySelector(".hero-text h2");

function typeEffect() {

    if (!roleElement) return;

    if (typing) {

        roleElement.textContent = roles[roleIndex].substring(0, charIndex++);

        if (charIndex > roles[roleIndex].length) {

            typing = false;

            setTimeout(typeEffect, 1500);

            return;

        }

    } else {

        roleElement.textContent = roles[roleIndex].substring(0, charIndex--);

        if (charIndex < 0) {

            typing = true;

            roleIndex++;

            if (roleIndex >= roles.length) {

                roleIndex = 0;

            }

        }

    }

    setTimeout(typeEffect, typing ? 80 : 40);

}

typeEffect();


/* ======================================================
   SCROLL REVEAL ANIMATION
====================================================== */

const hiddenElements = document.querySelectorAll(

    ".about-container, .skill-card, .project-card, .contact-box"

);

const observer = new IntersectionObserver((entries) => {

    entries.forEach(entry => {

        if (entry.isIntersecting) {

            entry.target.classList.add("show");

        }

    });

}, {

    threshold: 0.2

});

hiddenElements.forEach(element => {

    element.classList.add("hidden");

    observer.observe(element);

});
/* ======================================================
   SCROLL TO TOP BUTTON
====================================================== */

const scrollButton = document.createElement("button");

scrollButton.innerHTML = '<i class="fa-solid fa-arrow-up"></i>';

scrollButton.id = "scrollTopBtn";

document.body.appendChild(scrollButton);

scrollButton.style.position = "fixed";
scrollButton.style.bottom = "30px";
scrollButton.style.right = "30px";
scrollButton.style.width = "50px";
scrollButton.style.height = "50px";
scrollButton.style.borderRadius = "50%";
scrollButton.style.border = "none";
scrollButton.style.background = "#38bdf8";
scrollButton.style.color = "#fff";
scrollButton.style.cursor = "pointer";
scrollButton.style.fontSize = "20px";
scrollButton.style.display = "none";
scrollButton.style.boxShadow = "0 8px 20px rgba(0,0,0,.35)";
scrollButton.style.zIndex = "999";

window.addEventListener("scroll", () => {

    if (window.scrollY > 400) {

        scrollButton.style.display = "block";

    } else {

        scrollButton.style.display = "none";

    }

});

scrollButton.addEventListener("click", () => {

    window.scrollTo({

        top: 0,

        behavior: "smooth"

    });

});


/* ======================================================
   HERO IMAGE FLOATING ANIMATION
====================================================== */

const heroImage = document.querySelector(".hero-image img");

if (heroImage) {

    let direction = 1;

    setInterval(() => {

        heroImage.style.transform =
            `translateY(${direction * 10}px)`;

        direction *= -1;

    }, 1800);

}


/* ======================================================
   SKILL CARD HOVER EFFECT
====================================================== */

const cards = document.querySelectorAll(".skill-card");

cards.forEach(card => {

    card.addEventListener("mouseenter", () => {

        card.style.transform = "translateY(-12px) scale(1.05)";

    });

    card.addEventListener("mouseleave", () => {

        card.style.transform = "translateY(0) scale(1)";

    });

});


/* ======================================================
   PROJECT CARD ANIMATION
====================================================== */

const projects = document.querySelectorAll(".project-card");

projects.forEach(project => {

    project.addEventListener("mouseenter", () => {

        project.style.transform = "translateY(-10px)";

        project.style.borderLeft = "5px solid #22c55e";

    });

    project.addEventListener("mouseleave", () => {

        project.style.transform = "translateY(0px)";

        project.style.borderLeft = "5px solid #38bdf8";

    });

});


/* ======================================================
   DYNAMIC FOOTER YEAR
====================================================== */

const footer = document.querySelector("footer p");

if (footer) {

    const currentYear = new Date().getFullYear();

    footer.innerHTML =
        `© ${currentYear} Rakesh Singh | AWS Cloud & DevOps Engineer`;

}


/* ======================================================
   WELCOME MESSAGE
====================================================== */

console.log("%cWelcome to Rakesh Singh's Portfolio", "color:#38bdf8;font-size:22px;font-weight:bold;");

console.log("%cAWS | Terraform | Docker | Jenkins | Kubernetes", "color:#22c55e;font-size:16px;");


/* ======================================================
   PRELOADER (Optional)
====================================================== */

window.addEventListener("load", () => {

    document.body.classList.add("loaded");

});


/* ======================================================
   END OF SCRIPT
====================================================== */