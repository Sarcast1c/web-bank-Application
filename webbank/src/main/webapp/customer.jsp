<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign up Page</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&display=swap');
    body{
    margin: 0;
    padding: 0;
    font-family: "Lexend", sans-serif;
    font-optical-sizing: auto;
    font-weight: 500;
    font-style: normal;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    }
    .navbar {
        width: 100%;
        background-color: #FFA500;
        padding: 10px 0;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .navbar h2 {
        margin: 0 20px;
    }

    .navbar h2 a {
        color: rgb(37, 57, 47);
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .navbar h2 a:hover {
        color: rgb(16, 228, 55);
    }
.form-container {
    background-color: #FFA500;
    padding: 20px 40px;
    width: 600px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: rgb(114, 227, 167);
}

.form-container div {
    margin-bottom: 15px;
}

.form-container label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-container input,
.form-container select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.form-container input[type="submit"] {
    background-color: rgb(114, 227, 167);
    color: #fff;
    border: none;
    cursor: pointer;
    font-weight: bold;
}

.form-container input[type="submit"]:hover {
    background-color: rgb(90, 180, 130);
}
</style>
</head>
<body>
    <div class="navbar">
        <h2>Signup</h2>
        <h2><a href="login.jsp">Login</a></h2>
      </div>
      

<div class="form-container">
    <form action="register" method="post">
        <div>
            <label for="name">Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your name" required/>
        </div>

        <div>
            <label for="address">Address</label>
            <input type="text" id="address" name="address" placeholder="Enter your address" required/>
        </div>

        <div>
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" placeholder="Enter your phone number" required/>
        </div>

        <div>
            <label for="email">E-mail</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required/>
        </div>

        <div>
            <label for="account_type">Account Type</label>
            <select id="account_type" name="account_type" required>
                <option value="current">Current</option>
                <option value="savings">Savings</option>
            </select>
        </div>

        <div>
            <label for="iamount">Initial Amount</label>
            <input type="text" id="iamount" name="iamount" placeholder="Enter your initial amount" required/>
        </div>

        <div>
            <label for="dob">Date of Birth</label>
            <input type="date" id="dob" name="dob" required/>
        </div>

        <div>
            <label for="id_proof">Id Proof</label>
            <input type="text" id="id_proof" name="id_proof" placeholder="Enter your AADHAR number" required/>
        </div>

        <div>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required/>
        </div>

        <input type="submit" value="Register"/>
    </form>
</div>
</body>
</html>