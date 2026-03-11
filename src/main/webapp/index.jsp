<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%
    String pageTitle = "NovaTech Solutions";
    String currentYear = String.valueOf(new Date().getYear() + 1900);
    String serverTime = new java.text.SimpleDateFormat("hh:mm a").format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;1,300&display=swap" rel="stylesheet">
    <style>
        :root {
            --ink: #0a0a0f;
            --paper: #f4f0e8;
            --accent: #e8401c;
            --warm: #f7c948;
            --muted: #8c8880;
            --card-bg: #ffffff;
            --border: #e0dbd0;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--paper);
            color: var(--ink);
            overflow-x: hidden;
        }

        /* ─── NOISE TEXTURE OVERLAY ─── */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 9999;
            opacity: 0.5;
        }

        /* ─── NAVIGATION ─── */
        nav {
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 4rem;
            background: rgba(244, 240, 232, 0.85);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border);
        }

        .logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 1.3rem;
            letter-spacing: -0.03em;
            color: var(--ink);
            text-decoration: none;
        }

        .logo span { color: var(--accent); }

        nav ul {
            list-style: none;
            display: flex;
            gap: 2.5rem;
            align-items: center;
        }

        nav ul a {
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 300;
            color: var(--muted);
            letter-spacing: 0.02em;
            transition: color 0.2s;
        }

        nav ul a:hover { color: var(--ink); }

        .nav-cta {
            background: var(--ink) !important;
            color: var(--paper) !important;
            padding: 0.55rem 1.4rem;
            border-radius: 2px;
            font-weight: 400 !important;
            transition: background 0.2s !important;
        }

        .nav-cta:hover { background: var(--accent) !important; color: white !important; }

        /* ─── HERO ─── */
        .hero {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 1fr 1fr;
            padding-top: 80px;
            position: relative;
        }

        .hero-left {
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 6rem 4rem 6rem 6rem;
            position: relative;
        }

        .hero-tag {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--warm);
            color: var(--ink);
            font-size: 0.75rem;
            font-weight: 400;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            padding: 0.4rem 1rem;
            border-radius: 2px;
            width: fit-content;
            margin-bottom: 2rem;
            animation: fadeUp 0.6s ease both;
        }

        .hero-tag::before {
            content: '';
            width: 6px; height: 6px;
            background: var(--accent);
            border-radius: 50%;
        }

        h1 {
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: clamp(3rem, 5vw, 4.8rem);
            line-height: 1.0;
            letter-spacing: -0.04em;
            margin-bottom: 1.5rem;
            animation: fadeUp 0.6s 0.1s ease both;
        }

        h1 em {
            font-style: normal;
            color: var(--accent);
            position: relative;
        }

        h1 em::after {
            content: '';
            position: absolute;
            bottom: 4px; left: 0; right: 0;
            height: 3px;
            background: var(--accent);
            transform: scaleX(0);
            animation: underlineIn 0.4s 0.9s ease forwards;
        }

        .hero-sub {
            font-size: 1.05rem;
            font-weight: 300;
            color: var(--muted);
            line-height: 1.7;
            max-width: 440px;
            margin-bottom: 2.5rem;
            animation: fadeUp 0.6s 0.2s ease both;
        }

        .hero-actions {
            display: flex;
            gap: 1rem;
            animation: fadeUp 0.6s 0.3s ease both;
        }

        .btn-primary {
            background: var(--ink);
            color: var(--paper);
            padding: 0.85rem 2rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            font-weight: 400;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s, transform 0.15s;
            display: inline-block;
        }

        .btn-primary:hover { background: var(--accent); transform: translateY(-2px); }

        .btn-ghost {
            background: transparent;
            color: var(--ink);
            padding: 0.85rem 2rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            border: 1.5px solid var(--border);
            border-radius: 2px;
            cursor: pointer;
            text-decoration: none;
            transition: border-color 0.2s, transform 0.15s;
            display: inline-block;
        }

        .btn-ghost:hover { border-color: var(--ink); transform: translateY(-2px); }

        .hero-stats {
            display: flex;
            gap: 3rem;
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border);
            animation: fadeUp 0.6s 0.4s ease both;
        }

        .stat-num {
            font-family: 'Syne', sans-serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--ink);
        }

        .stat-label {
            font-size: 0.8rem;
            color: var(--muted);
            letter-spacing: 0.05em;
            margin-top: 0.2rem;
        }

        /* ─── HERO RIGHT (Visual) ─── */
        .hero-right {
            position: relative;
            overflow: hidden;
            background: var(--ink);
        }

        .hero-visual {
            position: absolute;
            inset: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .circle-grid {
            position: absolute;
            inset: 0;
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            grid-template-rows: repeat(8, 1fr);
            gap: 0;
        }

        .circle-grid-dot {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .circle-grid-dot::after {
            content: '';
            width: 3px; height: 3px;
            background: rgba(244, 240, 232, 0.15);
            border-radius: 50%;
        }

        .hero-big-circle {
            width: 380px;
            height: 380px;
            border-radius: 50%;
            border: 1px solid rgba(244, 240, 232, 0.12);
            position: absolute;
            animation: slowSpin 30s linear infinite;
        }

        .hero-big-circle::before {
            content: '';
            position: absolute;
            top: -4px; left: 50%;
            transform: translateX(-50%);
            width: 8px; height: 8px;
            background: var(--accent);
            border-radius: 50%;
        }

        .hero-med-circle {
            width: 240px;
            height: 240px;
            border-radius: 50%;
            border: 1px solid rgba(244, 240, 232, 0.08);
            position: absolute;
            animation: slowSpin 20s linear infinite reverse;
        }

        .hero-center-box {
            width: 120px;
            height: 120px;
            background: var(--accent);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 2;
            animation: float 4s ease-in-out infinite;
        }

        .hero-center-box svg {
            width: 52px;
            height: 52px;
            fill: white;
        }

        .server-time-badge {
            position: absolute;
            bottom: 2rem;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(244, 240, 232, 0.08);
            border: 1px solid rgba(244, 240, 232, 0.15);
            backdrop-filter: blur(8px);
            padding: 0.6rem 1.2rem;
            border-radius: 100px;
            color: rgba(244, 240, 232, 0.7);
            font-size: 0.75rem;
            letter-spacing: 0.08em;
            white-space: nowrap;
        }

        /* ─── SERVICES SECTION ─── */
        .services {
            padding: 7rem 6rem;
            background: var(--card-bg);
            border-top: 1px solid var(--border);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 4rem;
        }

        .section-label {
            font-size: 0.75rem;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--accent);
            font-weight: 400;
            margin-bottom: 0.75rem;
        }

        h2 {
            font-family: 'Syne', sans-serif;
            font-weight: 700;
            font-size: clamp(2rem, 3vw, 2.8rem);
            letter-spacing: -0.03em;
            line-height: 1.1;
        }

        .section-link {
            font-size: 0.85rem;
            color: var(--muted);
            text-decoration: none;
            border-bottom: 1px solid var(--border);
            padding-bottom: 2px;
            transition: color 0.2s, border-color 0.2s;
        }

        .section-link:hover { color: var(--ink); border-color: var(--ink); }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5px;
            background: var(--border);
        }

        .service-card {
            background: var(--card-bg);
            padding: 3rem 2.5rem;
            transition: background 0.25s;
            cursor: default;
            position: relative;
            overflow: hidden;
        }

        .service-card:hover { background: var(--paper); }

        .service-card:hover .service-icon { background: var(--accent); color: white; }

        .service-icon {
            width: 48px; height: 48px;
            background: var(--paper);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            transition: background 0.25s, color 0.25s;
        }

        .service-card h3 {
            font-family: 'Syne', sans-serif;
            font-size: 1.15rem;
            font-weight: 600;
            letter-spacing: -0.02em;
            margin-bottom: 0.75rem;
        }

        .service-card p {
            font-size: 0.88rem;
            font-weight: 300;
            color: var(--muted);
            line-height: 1.7;
        }

        .service-num {
            position: absolute;
            top: 1.5rem; right: 2rem;
            font-family: 'Syne', sans-serif;
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 0.1em;
            color: var(--border);
        }

        /* ─── FEATURE STRIP ─── */
        .feature-strip {
            background: var(--ink);
            color: var(--paper);
            padding: 2rem 6rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 2rem;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.85rem;
            font-weight: 300;
            opacity: 0.8;
        }

        .feature-item-dot {
            width: 6px; height: 6px;
            background: var(--warm);
            border-radius: 50%;
            flex-shrink: 0;
        }

        /* ─── PORTFOLIO / WORK ─── */
        .work {
            padding: 7rem 6rem;
            background: var(--paper);
        }

        .work-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5px;
            background: var(--border);
            margin-top: 4rem;
        }

        .work-card {
            background: var(--paper);
            padding: 2.5rem;
            min-height: 280px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            transition: background 0.3s;
        }

        .work-card:hover { background: var(--card-bg); }

        .work-card-bg {
            position: absolute;
            inset: 0;
            opacity: 0.04;
            font-family: 'Syne', sans-serif;
            font-size: 8rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--ink);
            letter-spacing: -0.05em;
            pointer-events: none;
        }

        .work-tag {
            display: inline-block;
            font-size: 0.7rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 0.5rem;
        }

        .work-card h3 {
            font-family: 'Syne', sans-serif;
            font-size: 1.35rem;
            font-weight: 700;
            letter-spacing: -0.02em;
        }

        .work-card-side {
            display: grid;
            grid-template-rows: 1fr 1fr;
            gap: 1.5px;
            background: var(--border);
        }

        /* ─── CONTACT ─── */
        .contact {
            padding: 7rem 6rem;
            background: var(--ink);
            color: var(--paper);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 6rem;
        }

        .contact h2 { color: var(--paper); margin-bottom: 1.5rem; }
        .contact .section-label { color: var(--warm); }

        .contact p {
            color: rgba(244, 240, 232, 0.55);
            font-weight: 300;
            line-height: 1.8;
            margin-bottom: 2.5rem;
        }

        .contact-form { display: flex; flex-direction: column; gap: 1rem; }

        .contact-form input,
        .contact-form textarea {
            background: rgba(244, 240, 232, 0.06);
            border: 1px solid rgba(244, 240, 232, 0.12);
            color: var(--paper);
            padding: 0.9rem 1.2rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            font-weight: 300;
            border-radius: 2px;
            outline: none;
            transition: border-color 0.2s;
        }

        .contact-form input::placeholder,
        .contact-form textarea::placeholder { color: rgba(244, 240, 232, 0.3); }

        .contact-form input:focus,
        .contact-form textarea:focus { border-color: var(--accent); }

        .contact-form textarea { height: 120px; resize: none; }

        .btn-submit {
            background: var(--accent);
            color: white;
            padding: 0.9rem;
            border: none;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            border-radius: 2px;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
        }

        .btn-submit:hover { opacity: 0.88; transform: translateY(-2px); }

        .contact-info { display: flex; flex-direction: column; gap: 1.5rem; margin-top: 1rem; }

        .contact-info-item { display: flex; gap: 1rem; align-items: flex-start; }

        .contact-info-icon {
            width: 38px; height: 38px;
            background: rgba(244, 240, 232, 0.06);
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 0.9rem;
        }

        .contact-info-text strong {
            display: block;
            font-family: 'Syne', sans-serif;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.2rem;
        }

        .contact-info-text span {
            font-size: 0.82rem;
            color: rgba(244, 240, 232, 0.5);
            font-weight: 300;
        }

        /* ─── FOOTER ─── */
        footer {
            background: #06060a;
            color: rgba(244, 240, 232, 0.4);
            padding: 2rem 6rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.8rem;
            font-weight: 300;
            border-top: 1px solid rgba(244, 240, 232, 0.06);
        }

        footer a { color: rgba(244, 240, 232, 0.4); text-decoration: none; }
        footer a:hover { color: rgba(244, 240, 232, 0.8); }

        /* ─── ANIMATIONS ─── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @keyframes slowSpin {
            from { transform: rotate(0deg); }
            to   { transform: rotate(360deg); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50%       { transform: translateY(-14px); }
        }

        @keyframes underlineIn {
            to { transform: scaleX(1); }
        }

        /* ─── RESPONSIVE ─── */
        @media (max-width: 900px) {
            nav { padding: 1rem 2rem; }
            nav ul { display: none; }
            .hero { grid-template-columns: 1fr; }
            .hero-right { min-height: 300px; }
            .hero-left { padding: 6rem 2rem 3rem; }
            .services, .work, .contact { padding: 5rem 2rem; }
            .services-grid, .work-grid { grid-template-columns: 1fr; }
            .contact { grid-template-columns: 1fr; gap: 3rem; }
            .feature-strip { flex-wrap: wrap; padding: 1.5rem 2rem; }
            footer { flex-direction: column; gap: 1rem; text-align: center; }
        }
    </style>
</head>
<body>

<!-- NAV -->
<nav>
    <a href="#" class="logo">Nova<span>Tech</span></a>
    <ul>
        <li><a href="#services">Services</a></li>
        <li><a href="#work">Work</a></li>
        <li><a href="#about">About</a></li>
        <li><a href="#contact" class="nav-cta">Contact Us</a></li>
    </ul>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-left">
        <span class="hero-tag">Digital Innovation Studio</span>
        <h1>We Build<br>Things That<br><em>Matter</em></h1>
        <p class="hero-sub">
            Crafting scalable, enterprise-grade Java web applications that power tomorrow's business. From concept to deployment — we own every layer.
        </p>
        <div class="hero-actions">
            <a href="#work" class="btn-primary">View Our Work</a>
            <a href="#contact" class="btn-ghost">Get in Touch</a>
        </div>
        <div class="hero-stats">
            <div>
                <div class="stat-num">12+</div>
                <div class="stat-label">Years Experience</div>
            </div>
            <div>
                <div class="stat-num">340</div>
                <div class="stat-label">Projects Shipped</div>
            </div>
            <div>
                <div class="stat-num">98%</div>
                <div class="stat-label">Client Retention</div>
            </div>
        </div>
    </div>

    <div class="hero-right">
        <div class="hero-visual">
            <div class="circle-grid">
                <% for(int i = 0; i < 64; i++) { %>
                <div class="circle-grid-dot"></div>
                <% } %>
            </div>
            <div class="hero-big-circle"></div>
            <div class="hero-med-circle"></div>
            <div class="hero-center-box">
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                </svg>
            </div>
        </div>
        <div class="server-time-badge">⚡ Server Time: <%= serverTime %></div>
    </div>
</section>

<!-- FEATURE STRIP -->
<div class="feature-strip">
    <% String[] features = {
        "Java EE & Jakarta EE",
        "Spring Boot Architecture",
        "Microservices Design",
        "Cloud-Native Deployments",
        "24/7 Uptime SLA"
    }; %>
    <% for(String f : features) { %>
    <div class="feature-item">
        <div class="feature-item-dot"></div>
        <%= f %>
    </div>
    <% } %>
</div>

<!-- SERVICES -->
<section class="services" id="services">
    <div class="section-header">
        <div>
            <div class="section-label">What We Do</div>
            <h2>Services Built<br>for Scale</h2>
        </div>
        <a href="#" class="section-link">See all services →</a>
    </div>
    <div class="services-grid">
        <%
            String[][] services = {
                {"⬡", "Web Application Dev", "End-to-end Java/JSP web applications with robust backend logic, session management, and seamless database integration."},
                {"◈", "API & Microservices", "RESTful APIs and microservice architectures designed for high throughput, resilience, and horizontal scalability."},
                {"⬙", "Database Engineering", "Schema design, query optimization, and ORM integration across MySQL, PostgreSQL, and Oracle."},
                {"◉", "Cloud & DevOps", "CI/CD pipelines, containerized deployments on AWS, GCP, or Azure — shipped fast and monitored closely."},
                {"⬛", "UI/UX Design", "Clean, conversion-focused interfaces that bridge the gap between engineering rigor and design elegance."},
                {"⬡", "Technical Consulting", "Architecture reviews, code audits, and strategic roadmaps for teams looking to level up their stack."}
            };
            for(int i = 0; i < services.length; i++) {
        %>
        <div class="service-card">
            <div class="service-num">0<%= i+1 %></div>
            <div class="service-icon"><%= services[i][0] %></div>
            <h3><%= services[i][1] %></h3>
            <p><%= services[i][2] %></p>
        </div>
        <% } %>
    </div>
</section>

<!-- WORK -->
<section class="work" id="work">
    <div class="section-header">
        <div>
            <div class="section-label">Selected Work</div>
            <h2>Projects We're<br>Proud Of</h2>
        </div>
        <a href="#" class="section-link">View all projects →</a>
    </div>
    <div class="work-grid">
        <div class="work-card">
            <div class="work-card-bg">01</div>
            <span class="work-tag">Enterprise / Fintech</span>
            <h3>CoreLedger — Real-time Banking Dashboard</h3>
        </div>
        <div class="work-card-side">
            <div class="work-card">
                <div class="work-card-bg">02</div>
                <span class="work-tag">Healthcare</span>
                <h3>MedFlow Patient Portal</h3>
            </div>
            <div class="work-card">
                <div class="work-card-bg">03</div>
                <span class="work-tag">Logistics</span>
                <h3>ShipSync Tracking Platform</h3>
            </div>
        </div>
    </div>
</section>

<!-- CONTACT -->
<section class="contact" id="contact">
    <div>
        <div class="section-label">Get In Touch</div>
        <h2>Let's Build<br>Something Great</h2>
        <p>Have a project in mind or just want to explore possibilities? We'd love to hear from you. Fill out the form and we'll be in touch within one business day.</p>
        <div class="contact-info">
            <div class="contact-info-item">
                <div class="contact-info-icon">✉</div>
                <div class="contact-info-text">
                    <strong>Email Us</strong>
                    <span>hello@novatech.dev</span>
                </div>
            </div>
            <div class="contact-info-item">
                <div class="contact-info-icon">✆</div>
                <div class="contact-info-text">
                    <strong>Call Us</strong>
                    <span>+1 (415) 555-0182</span>
                </div>
            </div>
            <div class="contact-info-item">
                <div class="contact-info-icon">◎</div>
                <div class="contact-info-text">
                    <strong>Location</strong>
                    <span>San Francisco, CA — Remote Worldwide</span>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="contact-form">
            <input type="text" placeholder="Full Name" />
            <input type="email" placeholder="Email Address" />
            <input type="text" placeholder="Project Type (e.g. Web App, API)" />
            <textarea placeholder="Tell us about your project..."></textarea>
            <button class="btn-submit">Send Message →</button>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <div>© <%= currentYear %> NovaTech Solutions. All rights reserved.</div>
    <div style="display:flex; gap:2rem;">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Sitemap</a>
    </div>
</footer>

</body>
</html>
