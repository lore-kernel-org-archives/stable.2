Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1323CF1F1
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033507; cv=none; b=D38Tm0aOkyxdv5q+IYrCv7A3ofEVHj7X2uD6SViZqbwCDuFkPEOq2MWMpmXdqFZMIMkaMGRhB9kguCw48jgBT+I4GWH3tBIfvcZ/UGIM3OYlbD9zm3EEulHIOEi0IoaBkZ5+VD5FDN+nb0OhSvzi/B1kYbl6/w7Z7h4OXnpM1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033507; c=relaxed/simple;
	bh=Vlg9pG4iIZCLQ0P/0sDPdGAueJcnWGVsb9802mY1wUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afYlnGIj+xlb6Sx7fXop6NxOuwv7MOaauAztVm8veRPKyUwAGsvHa4hbTlO/rs22etTQH1XWbQcCluqeVjDP70O4hbySiEymZTjkgUN9qW9Pfjn5vodNFJ3iaXBfq/oMmfV/o0IbwvGD+3UJCKQhs8CxVf4JWAgqvtgy0PLK9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NvNA9Hq7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NvNA9Hq7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493bab44440so6855785e9.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783033505; x=1783638305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIn0YGtCcLnHRn9ikjvXBO7UGFstU2JEsQO0VjhImf0=;
        b=NvNA9Hq7Bw9VODFuD+rOAB7Whq+fojYDOj7kxJPfITLc2xKDj8XRBae92yyyTzlkrE
         8ubvGJWhk4RJ6xa5acvOoxUxwON+QZbAWfXzjIbYCxmPb6LStHEhwdpR58QzJ9VxyzeM
         ToQPFtLX9hGTTNbJUBZSqR696TWHFozwX/epzV5UiyYgZ9zUYqxMENNineceJj1xTw6x
         J4IIbEgZaeGYfwfk3FduZ6sIGFuJ5BS7Wawz32cPZWER3pFbuMqpB6MLx+deJ9Kg+64L
         699esqm1vEerg2IvuR+Qdck/ChDRr3HX1MFktFCV4thfV3/1hYtKGxmQtk+/gyhN8OD1
         uVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783033505; x=1783638305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIn0YGtCcLnHRn9ikjvXBO7UGFstU2JEsQO0VjhImf0=;
        b=lbwGsGlSSBLj74RUMvQIxZEozdxl3lbCif287kNRqv+eqXbN5p8ZEOVcLQpSGCm7kq
         gXVLd4SVl0KnXYzzkhk47FGGZgcfjm2pF6YOVPT2Yg9zX5V8S4KnqCDwYX1xd2orevAP
         l3ZT7MDr9hm1cZKRWrtYll6+g51nKxuwA4+IwEW+T/+hz2a5DX2LVip1Z/0xwMurtlPq
         yR7knuqm+XIasMCLWbkW4Az7gkXLq/t6eZYtVI/pHYgxp1RanM+RUbno502bKJ/+0Ud2
         pcmtV6GXO1zJ4JTPDt+f0gxgBi2PXtMHcQwFbHu8Jgk9tEM9KA2QbRlDPvjdNk526z2y
         owXg==
X-Forwarded-Encrypted: i=1; AFNElJ9c/lKjg5oCb5EttmKuk0GX9FX2BOzriQwQt7f/BF6rPlYudtCReTbYDjRLmvmj6C65NQjz1zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGUI+kuZIijgPQ/jc9CK1sVF2MKQfmP+h/jl30dpRU1zBYEEb
	11CxMGhnMnB6j+EAe9HsLm/1UeYDGlZ+ReU596wm+sz24ckW6rzSMi8=
X-Gm-Gg: AfdE7cljnYMpQlnL6jwcLiDGkxXD96eWNZsc21gxzRciG9Yy8RBEOhOfflLfCQtHkNz
	8n43awAmnYL+Fbs38iFmIjVCN5WXPzLn3q8io+EPX9whxHB3cx1+vGujC7EqiDa13XwG45x4GK4
	gok3ls5JEtdWY0JIDagaL6/EBv6VapLxEj8cu0oUUubpRDaEdKbNihcHnK7eX3t9nhoQZsykx0a
	tW4dkn08I0CefWIV+KaNPjf9J0FwFyIX7rsiwuJaza+e6JPjnUMOpZdlXPYzNCly7hiHNcn3gcb
	3Z4W8qITHaHUfeVhyQQpE55GOKY8JrgPnqJbd2Kh09QaDqTM7PhPIUG0rRqI8Tlmj1zgTxTnGsT
	vVCEHkrNjtoBVUXUJrFUhGWmBz0bsK6FWbod1qnPLN0pzKGaDfrRmTHGhH8NAiCN6kWFKZjvyrC
	gNSDUJm6++ecISvuGgKKD+YqwNEMzg07H1b6FoihfJURRdNp5dkfHcWk4UF++cuyY=
X-Received: by 2002:a05:600c:5492:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-493c9b694a8mr23737225e9.16.1783033504570;
        Thu, 02 Jul 2026 16:05:04 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63b6f28sm87092595e9.9.2026.07.02.16.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 16:05:04 -0700 (PDT)
Message-ID: <e7885894-2a1d-4246-aa80-8806b6c69c1b@googlemail.com>
Date: Fri, 3 Jul 2026 01:05:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/108] 6.18.38-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.110058792@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2026 um 18:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
