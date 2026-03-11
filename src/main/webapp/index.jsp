<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%
    String currentYear   = String.valueOf(new Date().getYear() + 1900);
    String currentDate   = new SimpleDateFormat("EEEE, MMMM d, yyyy").format(new Date());

    // Sample book data: {title, author, category, status, accessionNo}
    String[][] books = {
        {"The Pragmatic Programmer", "David Thomas & Andrew Hunt", "Technology", "Available",  "A001"},
        {"Sapiens",                  "Yuval Noah Harari",          "History",    "Issued",      "B012"},
        {"Clean Code",               "Robert C. Martin",           "Technology", "Available",  "A002"},
        {"Atomic Habits",            "James Clear",                "Self-Help",  "Available",  "C007"},
        {"1984",                     "George Orwell",              "Fiction",    "Reserved",   "D043"},
        {"The Great Gatsby",         "F. Scott Fitzgerald",        "Fiction",    "Available",  "D011"},
        {"Dune",                     "Frank Herbert",              "Sci-Fi",     "Issued",     "E005"},
        {"Thinking, Fast and Slow",  "Daniel Kahneman",            "Psychology", "Available",  "C015"},
    };

    int totalBooks   = 4820;
    int issuedBooks  = 312;
    int members      = 1045;
    int overdueBooks = 27;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bibliotheca — Library Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,500;0,700;1,500&family=Jost:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:       #0f0e0b;
            --surface:  #171612;
            --card:     #1e1c17;
            --border:   #2e2b23;
            --gold:     #c9a84c;
            --gold-dim: #7a6530;
            --cream:    #f0ead8;
            --muted:    #7a7567;
            --green:    #4caf7d;
            --amber:    #e0913a;
            --red:      #c0483a;
            --blue:     #4a8fc9;
            --r:        6px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }

        body {
            font-family: 'Jost', sans-serif;
            background: var(--bg);
            color: var(--cream);
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        /* ── SIDEBAR ── */
        .sidebar {
            width: 260px;
            min-height: 100vh;
            background: var(--surface);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0; left: 0; bottom: 0;
            z-index: 50;
            padding-bottom: 2rem;
        }

        .sidebar-logo {
            padding: 2rem 1.8rem 1.8rem;
            border-bottom: 1px solid var(--border);
        }

        .logo-mark {
            font-family: 'Playfair Display', serif;
            font-size: 1.55rem;
            font-weight: 700;
            color: var(--gold);
            letter-spacing: 0.01em;
            line-height: 1;
        }

        .logo-sub {
            font-size: 0.68rem;
            font-weight: 300;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            color: var(--muted);
            margin-top: 0.3rem;
        }

        .sidebar-nav { flex: 1; padding: 1.5rem 0; display: flex; flex-direction: column; gap: 0.15rem; }

        .nav-section-label {
            font-size: 0.62rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            color: var(--gold-dim);
            padding: 0.9rem 1.8rem 0.4rem;
            font-weight: 500;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            padding: 0.72rem 1.8rem;
            font-size: 0.88rem;
            color: var(--muted);
            text-decoration: none;
            border-left: 3px solid transparent;
            transition: color 0.18s, border-color 0.18s, background 0.18s;
            cursor: pointer;
        }

        .nav-item:hover { color: var(--cream); background: rgba(201,168,76,0.05); }

        .nav-item.active {
            color: var(--gold);
            border-left-color: var(--gold);
            background: rgba(201,168,76,0.07);
        }

        .nav-icon { width: 18px; text-align: center; flex-shrink: 0; }

        .nav-badge {
            margin-left: auto;
            background: var(--red);
            color: white;
            font-size: 0.64rem;
            font-weight: 500;
            padding: 0.1rem 0.48rem;
            border-radius: 100px;
        }

        .sidebar-user {
            margin: 0 1.2rem;
            padding: 1rem 1.2rem;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--r);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .user-avatar {
            width: 34px; height: 34px;
            background: linear-gradient(135deg, var(--gold-dim), var(--gold));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.78rem;
            font-weight: 700;
            color: #0f0e0b;
            flex-shrink: 0;
        }

        .user-name { font-size: 0.78rem; font-weight: 500; color: var(--cream); }
        .user-role { font-size: 0.68rem; color: var(--muted); font-weight: 300; }

        /* ── MAIN ── */
        .main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; min-height: 100vh; }

        /* ── TOPBAR ── */
        .topbar {
            height: 64px;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2.5rem;
            position: sticky;
            top: 0;
            z-index: 40;
        }

        .topbar h1 {
            font-family: 'Playfair Display', serif;
            font-size: 1.15rem;
            font-weight: 500;
        }

        .topbar-date { font-size: 0.75rem; color: var(--muted); font-weight: 300; margin-top: 0.12rem; }

        .topbar-right { display: flex; align-items: center; gap: 1rem; }

        .search-bar {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--r);
            display: flex;
            align-items: center;
            padding: 0.45rem 1rem;
            gap: 0.5rem;
            width: 260px;
            transition: border-color 0.2s;
        }

        .search-bar:focus-within { border-color: var(--gold-dim); }

        .search-bar input {
            background: none;
            border: none;
            outline: none;
            color: var(--cream);
            font-family: 'Jost', sans-serif;
            font-size: 0.85rem;
            font-weight: 300;
            width: 100%;
        }

        .search-bar input::placeholder { color: var(--muted); }

        .topbar-btn {
            background: var(--gold);
            color: #0f0e0b;
            border: none;
            border-radius: var(--r);
            padding: 0.52rem 1.3rem;
            font-family: 'Jost', sans-serif;
            font-size: 0.82rem;
            font-weight: 500;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
            white-space: nowrap;
        }

        .topbar-btn:hover { opacity: 0.85; transform: translateY(-1px); }

        /* ── PAGE BODY ── */
        .page-body { padding: 2.5rem; display: flex; flex-direction: column; gap: 2rem; flex: 1; }

        /* ── STAT CARDS ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5px;
            background: var(--border);
            border: 1px solid var(--border);
            border-radius: var(--r);
            overflow: hidden;
            animation: fadeUp 0.4s 0.05s ease both;
        }

        .stat-card {
            background: var(--card);
            padding: 1.6rem 1.8rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            transition: background 0.2s;
        }

        .stat-card:hover { background: #232119; }

        .stat-header { display: flex; justify-content: space-between; align-items: center; }

        .stat-label {
            font-size: 0.7rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--muted);
        }

        .stat-icon {
            width: 32px; height: 32px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }

        .stat-value {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--cream);
            line-height: 1;
        }

        .stat-delta { font-size: 0.74rem; display: flex; align-items: center; gap: 0.3rem; }
        .delta-up   { color: var(--green); }
        .delta-warn { color: var(--amber); }

        /* ── OVERDUE BANNER ── */
        .overdue-banner {
            background: rgba(192,72,58,0.1);
            border: 1px solid rgba(192,72,58,0.3);
            border-radius: var(--r);
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            animation: fadeUp 0.4s 0.1s ease both;
        }

        .overdue-left { display: flex; align-items: center; gap: 0.8rem; }

        .overdue-icon {
            width: 36px; height: 36px;
            background: rgba(192,72,58,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .overdue-text strong { display: block; font-size: 0.88rem; font-weight: 500; color: #e87a70; }
        .overdue-text span { font-size: 0.78rem; color: var(--muted); font-weight: 300; }

        .overdue-btn {
            background: rgba(192,72,58,0.2);
            border: 1px solid rgba(192,72,58,0.4);
            color: #e87a70;
            padding: 0.45rem 1.1rem;
            border-radius: 4px;
            font-family: 'Jost', sans-serif;
            font-size: 0.78rem;
            cursor: pointer;
            white-space: nowrap;
            transition: background 0.2s;
        }

        .overdue-btn:hover { background: rgba(192,72,58,0.3); }

        /* ── TWO-COL ── */
        .two-col {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 1.5rem;
            align-items: start;
            animation: fadeUp 0.4s 0.18s ease both;
        }

        /* ── CARD ── */
        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--r);
            overflow: hidden;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 1.8rem;
            border-bottom: 1px solid var(--border);
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.05rem;
            font-weight: 500;
        }

        .card-link {
            font-size: 0.78rem;
            color: var(--gold);
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .card-link:hover { opacity: 0.7; }

        /* ── BOOK TABLE ── */
        .book-table { width: 100%; border-collapse: collapse; }

        .book-table thead th {
            font-size: 0.68rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--muted);
            padding: 0.85rem 1.8rem;
            text-align: left;
            border-bottom: 1px solid var(--border);
            background: var(--surface);
            font-weight: 400;
        }

        .book-table tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background 0.15s;
        }

        .book-table tbody tr:last-child { border-bottom: none; }
        .book-table tbody tr:hover { background: rgba(201,168,76,0.04); }

        .book-table td { padding: 1rem 1.8rem; font-size: 0.85rem; vertical-align: middle; }

        .book-title { font-weight: 500; color: var(--cream); font-size: 0.87rem; }
        .book-author { font-size: 0.76rem; color: var(--muted); font-weight: 300; font-style: italic; }

        .acc-no { font-size: 0.75rem; color: var(--gold-dim); font-family: monospace; letter-spacing: 0.05em; }

        .cat-badge {
            display: inline-block;
            padding: 0.2rem 0.6rem;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 400;
            letter-spacing: 0.04em;
            background: rgba(201,168,76,0.1);
            color: var(--gold);
            border: 1px solid rgba(201,168,76,0.2);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.22rem 0.7rem;
            border-radius: 100px;
            font-size: 0.72rem;
            font-weight: 400;
        }

        .status-badge::before {
            content: '';
            width: 5px; height: 5px;
            border-radius: 50%;
        }

        .s-available { background: rgba(76,175,125,0.12); color: var(--green); border: 1px solid rgba(76,175,125,0.25); }
        .s-available::before { background: var(--green); }
        .s-issued    { background: rgba(224,145,58,0.12); color: var(--amber); border: 1px solid rgba(224,145,58,0.25); }
        .s-issued::before    { background: var(--amber); }
        .s-reserved  { background: rgba(74,143,201,0.12); color: var(--blue);  border: 1px solid rgba(74,143,201,0.25); }
        .s-reserved::before  { background: var(--blue); }

        .action-btn {
            background: none;
            border: 1px solid var(--border);
            color: var(--muted);
            padding: 0.28rem 0.75rem;
            border-radius: 4px;
            font-size: 0.72rem;
            cursor: pointer;
            font-family: 'Jost', sans-serif;
            transition: border-color 0.2s, color 0.2s;
        }

        .action-btn:hover { border-color: var(--gold); color: var(--gold); }

        /* ── RIGHT PANEL ── */
        .right-panel { display: flex; flex-direction: column; gap: 1.5rem; }

        /* quick form */
        .quick-form { padding: 1.5rem 1.8rem; display: flex; flex-direction: column; gap: 1rem; }

        .form-label {
            display: block;
            font-size: 0.7rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: 0.4rem;
        }

        .form-input, .form-select {
            background: var(--surface);
            border: 1px solid var(--border);
            color: var(--cream);
            padding: 0.65rem 0.9rem;
            font-family: 'Jost', sans-serif;
            font-size: 0.85rem;
            font-weight: 300;
            border-radius: 4px;
            outline: none;
            transition: border-color 0.2s;
            width: 100%;
            -webkit-appearance: none;
        }

        .form-input:focus, .form-select:focus { border-color: var(--gold); }
        .form-input::placeholder { color: var(--muted); }
        .form-select option { background: var(--card); }

        .form-submit {
            background: var(--gold);
            color: #0f0e0b;
            border: none;
            padding: 0.75rem;
            border-radius: 4px;
            font-family: 'Jost', sans-serif;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
            width: 100%;
            letter-spacing: 0.04em;
        }

        .form-submit:hover { opacity: 0.85; transform: translateY(-1px); }

        /* genre bars */
        .genre-list { padding: 1rem 1.8rem 1.5rem; display: flex; flex-direction: column; gap: 1rem; }

        .genre-header { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 0.35rem; }
        .genre-name { color: var(--cream); }
        .genre-count { color: var(--muted); font-weight: 300; }

        .genre-bar-bg { height: 4px; background: var(--border); border-radius: 100px; overflow: hidden; }

        .genre-bar-fill {
            height: 100%;
            border-radius: 100px;
            background: linear-gradient(90deg, var(--gold-dim), var(--gold));
            animation: barGrow 1s ease both;
            transform-origin: left;
        }

        /* activity */
        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 0.9rem;
            padding: 0.9rem 1.8rem;
            border-bottom: 1px solid var(--border);
            transition: background 0.15s;
        }

        .activity-item:last-child { border-bottom: none; }
        .activity-item:hover { background: rgba(201,168,76,0.03); }

        .a-dot { width: 8px; height: 8px; border-radius: 50%; margin-top: 0.35rem; flex-shrink: 0; }

        .a-text { font-size: 0.82rem; font-weight: 300; color: var(--cream); line-height: 1.5; }
        .a-text strong { font-weight: 500; }
        .a-time { font-size: 0.7rem; color: var(--muted); margin-top: 0.2rem; }

        /* ── FOOTER ── */
        .footer {
            background: var(--surface);
            border-top: 1px solid var(--border);
            padding: 1rem 2.5rem;
            display: flex;
            justify-content: space-between;
            font-size: 0.75rem;
            color: var(--muted);
            font-weight: 300;
        }

        .footer a { color: var(--muted); text-decoration: none; }
        .footer a:hover { color: var(--gold); }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @keyframes barGrow {
            from { transform: scaleX(0); }
            to   { transform: scaleX(1); }
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 1100px) {
            .two-col { grid-template-columns: 1fr; }
        }

        @media (max-width: 800px) {
            .sidebar { transform: translateX(-100%); }
            .main { margin-left: 0; }
            .stats-grid { grid-template-columns: 1fr 1fr; }
        }

        @media (max-width: 480px) {
            .stats-grid { grid-template-columns: 1fr; }
            .page-body { padding: 1.2rem; }
            .topbar { padding: 0 1.2rem; }
            .search-bar { display: none; }
        }
    </style>
</head>
<body>

<!-- ── SIDEBAR ── -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-mark">Bibliotheca</div>
        <div class="logo-sub">Library Management System</div>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-label">Main</div>
        <a class="nav-item active" href="#"><span class="nav-icon">⊞</span> Dashboard</a>
        <a class="nav-item" href="#"><span class="nav-icon">📚</span> Book Catalog</a>
        <a class="nav-item" href="#"><span class="nav-icon">👤</span> Members</a>
        <a class="nav-item" href="#"><span class="nav-icon">↗</span> Issue Book</a>
        <a class="nav-item" href="#"><span class="nav-icon">↙</span> Return Book</a>

        <div class="nav-section-label">Reports</div>
        <a class="nav-item" href="#">
            <span class="nav-icon">⚠</span> Overdue
            <span class="nav-badge"><%= overdueBooks %></span>
        </a>
        <a class="nav-item" href="#"><span class="nav-icon">📊</span> Analytics</a>
        <a class="nav-item" href="#"><span class="nav-icon">🔖</span> Reservations</a>

        <div class="nav-section-label">System</div>
        <a class="nav-item" href="#"><span class="nav-icon">⚙</span> Configuration</a>
        <a class="nav-item" href="#"><span class="nav-icon">🔒</span> Users &amp; Roles</a>
    </nav>

    <div class="sidebar-user">
        <div class="user-avatar">PS</div>
        <div>
            <div class="user-name">Ms. Priya Sen</div>
            <div class="user-role">Senior Librarian</div>
        </div>
    </div>
</aside>

<!-- ── MAIN ── -->
<div class="main">

    <!-- TOPBAR -->
    <header class="topbar">
        <div>
            <h1>Dashboard Overview</h1>
            <div class="topbar-date"><%= currentDate %></div>
        </div>
        <div class="topbar-right">
            <div class="search-bar">
                <span style="color:var(--muted);font-size:.85rem">🔍</span>
                <input type="text" placeholder="Search books, members…" />
            </div>
            <button class="topbar-btn">+ Add Book</button>
        </div>
    </header>

    <!-- PAGE BODY -->
    <div class="page-body">

        <!-- STAT CARDS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-label">Total Books</span>
                    <div class="stat-icon" style="background:rgba(201,168,76,.12);color:var(--gold)">📚</div>
                </div>
                <div class="stat-value"><%= totalBooks %></div>
                <div class="stat-delta delta-up">▲ 48 added this month</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-label">Books Issued</span>
                    <div class="stat-icon" style="background:rgba(74,143,201,.12);color:var(--blue)">↗</div>
                </div>
                <div class="stat-value"><%= issuedBooks %></div>
                <div class="stat-delta delta-up">▲ 22 this week</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-label">Active Members</span>
                    <div class="stat-icon" style="background:rgba(76,175,125,.12);color:var(--green)">👤</div>
                </div>
                <div class="stat-value"><%= members %></div>
                <div class="stat-delta delta-up">▲ 12 new registrations</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-label">Overdue Returns</span>
                    <div class="stat-icon" style="background:rgba(192,72,58,.12);color:var(--red)">⚠</div>
                </div>
                <div class="stat-value"><%= overdueBooks %></div>
                <div class="stat-delta delta-warn">▲ 5 since yesterday</div>
            </div>
        </div>

        <!-- OVERDUE BANNER -->
        <div class="overdue-banner">
            <div class="overdue-left">
                <div class="overdue-icon">⏰</div>
                <div class="overdue-text">
                    <strong><%= overdueBooks %> books are currently overdue</strong>
                    <span>Send reminders to <%= overdueBooks %> members to avoid accruing late fees.</span>
                </div>
            </div>
            <button class="overdue-btn">Send Reminders →</button>
        </div>

        <!-- TWO-COL -->
        <div class="two-col">

            <!-- BOOK TABLE -->
            <div class="card">
                <div class="card-header">
                    <span class="card-title">Book Catalog — Recent Entries</span>
                    <a href="#" class="card-link">View all →</a>
                </div>
                <table class="book-table">
                    <thead>
                        <tr>
                            <th>Acc. No.</th>
                            <th>Title / Author</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for(String[] b : books) {
                            String sc = "s-available";
                            if("Issued".equals(b[3]))   sc = "s-issued";
                            if("Reserved".equals(b[3])) sc = "s-reserved";
                        %>
                        <tr>
                            <td><span class="acc-no"><%= b[4] %></span></td>
                            <td>
                                <div class="book-title"><%= b[0] %></div>
                                <div class="book-author"><%= b[1] %></div>
                            </td>
                            <td><span class="cat-badge"><%= b[2] %></span></td>
                            <td><span class="status-badge <%= sc %>"><%= b[3] %></span></td>
                            <td>
                                <% if("Available".equals(b[3])) { %><button class="action-btn">Issue</button>
                                <% } else if("Issued".equals(b[3])) { %><button class="action-btn">Return</button>
                                <% } else { %><button class="action-btn">View</button><% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- RIGHT PANEL -->
            <div class="right-panel">

                <!-- Quick Issue Form -->
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">Quick Issue</span>
                    </div>
                    <div class="quick-form">
                        <div>
                            <label class="form-label">Member ID</label>
                            <input class="form-input" type="text" placeholder="e.g. MEM-2024-0182" />
                        </div>
                        <div>
                            <label class="form-label">Accession No.</label>
                            <input class="form-input" type="text" placeholder="e.g. A001" />
                        </div>
                        <div>
                            <label class="form-label">Loan Duration</label>
                            <select class="form-select">
                                <option>7 Days</option>
                                <option selected>14 Days</option>
                                <option>21 Days</option>
                                <option>30 Days</option>
                            </select>
                        </div>
                        <button class="form-submit" id="issueBtn">Issue Book →</button>
                    </div>
                </div>

                <!-- Genre Distribution -->
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">Genre Distribution</span>
                    </div>
                    <div class="genre-list">
                        <%
                        String[][] genres = {
                            {"Fiction",    "1,240", "78"},
                            {"Technology", "980",   "62"},
                            {"Self-Help",  "640",   "44"},
                            {"History",    "520",   "36"},
                            {"Psychology", "390",   "26"},
                            {"Sci-Fi",     "310",   "20"},
                        };
                        int gDelay = 200;
                        for(String[] g : genres) {
                        %>
                        <div>
                            <div class="genre-header">
                                <span class="genre-name"><%= g[0] %></span>
                                <span class="genre-count"><%= g[1] %> books</span>
                            </div>
                            <div class="genre-bar-bg">
                                <div class="genre-bar-fill" style="width:<%= g[2] %>%; animation-delay:<%= gDelay %>ms"></div>
                            </div>
                        </div>
                        <% gDelay += 80; } %>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">Recent Activity</span>
                        <a href="#" class="card-link">All logs →</a>
                    </div>
                    <%
                    String[][] acts = {
                        {"#4caf7d", "Book <strong>Atomic Habits</strong> issued to Rahul M.",  "2 min ago"},
                        {"#e0913a", "Overdue reminder sent to <strong>Sneha Patil</strong>",    "18 min ago"},
                        {"#4a8fc9", "New member <strong>Arjun Das</strong> registered",         "45 min ago"},
                        {"#4caf7d", "<strong>1984</strong> returned by Kavya R.",               "1 hr ago"},
                        {"#c0483a", "<strong>Dune</strong> marked overdue (7 days)",            "3 hrs ago"},
                    };
                    for(String[] a : acts) {
                    %>
                    <div class="activity-item">
                        <div class="a-dot" style="background:<%= a[0] %>"></div>
                        <div>
                            <div class="a-text"><%= a[1] %></div>
                            <div class="a-time"><%= a[2] %></div>
                        </div>
                    </div>
                    <% } %>
                </div>

            </div><!-- /right-panel -->
        </div><!-- /two-col -->
    </div><!-- /page-body -->

    <!-- FOOTER -->
    <footer class="footer">
        <span>© <%= currentYear %> Bibliotheca LMS — All rights reserved</span>
        <span>Java EE &amp; JSP &nbsp;|&nbsp; <a href="#">Documentation</a> &nbsp;|&nbsp; <a href="#">Support</a></span>
    </footer>

</div><!-- /main -->

<script>
    // Nav active state
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', e => {
            e.preventDefault();
            document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
            item.classList.add('active');
        });
    });

    // Table action button feedback
    document.querySelectorAll('.action-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const orig = this.textContent;
            this.textContent = '✓ Done';
            this.style.borderColor = 'var(--green)';
            this.style.color = 'var(--green)';
            setTimeout(() => {
                this.textContent = orig;
                this.style.borderColor = '';
                this.style.color = '';
            }, 1500);
        });
    });

    // Issue form feedback
    document.getElementById('issueBtn').addEventListener('click', function() {
        this.textContent = '✓ Issued Successfully';
        this.style.background = 'var(--green)';
        setTimeout(() => {
            this.textContent = 'Issue Book →';
            this.style.background = '';
        }, 2000);
    });
</script>
</body>
</html>
