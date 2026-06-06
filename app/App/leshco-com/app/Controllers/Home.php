<?php

namespace App\Controllers;

class Home extends BaseController
{
    public function index(): string
    {
        $data = [
            'base_url' => base_url(),
            'title' => 'LESHCO :: Home',
        ];
        return view('home', $data);
    }
}
