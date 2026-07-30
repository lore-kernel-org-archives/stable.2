Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAD43F4A6
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435802; cv=none; b=tz2YvY8CGvVsa/xfXGhJ/UWQiWs2+YMrCXTyTuBj9KXIVpe5NeZ/ZTXvByA3D8vVT7JYGN+CXu6Lj9ZgMAOxKA/yay7NkvDUbLuvE3tnMMzagcBVTGbmTofAMBqPvGId3bTlRVjYpmbqFh9fZ188RhdGOoowUt/Pu/qQ+uvhMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435802; c=relaxed/simple;
	bh=xCJhnHpVwOTvaL/DW/gllYM+iIXcd40BoQJSe+AulWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QisKp4iwHfk8Z8saj0rkVxb0SfyRwvpTBAyD2fhS5QiJo0XXqG3v83cxJQiWhWg9TR22GnguWKcezmbdRj9J1J//PWch8JSrtqfh0OgngmoklWHBKdzI1DxZGn1WrSXx24kg50ZXWM2PoODY6hTC8mw0QZ6uK0NwHeGbWH9WbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l/3clUxR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l/3clUxR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d29264cso311885e9.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1785435799; x=1786040599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqfbmiEZ/jbsyui/HXGCKKp3cbCCYufKhVYiKs6CwOs=;
        b=l/3clUxRDspjJLTGla7VBbovFZMrSJpniqJoFLC2SlbAenhyW37BJWW6JP1GALWsIB
         t5QxY3CXr85oZm+P8w9ocUGwd0nBOzhUoionm3yuaAtfkD2CI+GJm0a60xqP/wNW4CjB
         zOmw16KbZIu9vdLiC8VANjXz5C9+/xFPFNPmpg4SUohLG2ZAf0DilUY8lSbPtt5ehB/d
         r/8t7dbWllEgoUmnudlbeYOG7biwtDFpQC6HWV9JnPO3sDat+wFvpUBT8oywCRCGT/XK
         cug1t9aTgyvJ7MKBza86+0qmK6jVfIkKbp0ViHKJ3KNiNkCsrYitgLk55VFpLo9xwDId
         ci3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435799; x=1786040599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqfbmiEZ/jbsyui/HXGCKKp3cbCCYufKhVYiKs6CwOs=;
        b=Sd3pU9o6WoBj9Hvmu4/BFegkcIS8jw4xT1x9lgrjQXyPh5DAGcpxSA9b868yle0twV
         umHgKHwdX7R2MmQSjkZGM+fZRYfJMIq0xKPSB5YN99tqhOFaMPVQDH6kxtJt/zhVfUDJ
         n3G7z3MYQmQijoo1odwZ5hWy7oAGeF31gj0KZEyw+pBx4XCG6/uC6ET4j/Ku4kzT+ahG
         rzE4MJP7qCtDIsEZknuSr7pfttbyAlHmeXFqebPHLEYf1LXe1zCNQKm21dhiv/L+T7Mi
         ERFfIz7gza4E4MySco6oBTfs3KPRU8Q4RXbDAJye14D/lJb2dJsFSXnFEy0/czlVC0b8
         BWaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoITmkmqjhf8C0JpJIh29J/GtpevF8tXpgb0EKISGO0CY1VcTrJDBEd5MOxVfmTcqp9GhgNOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MTl115PrP2+SydcA0K7qrpbzHhzuSv8pmhEjmAApg/Tez9rj
	+rM+YFYVteq29kQ6BmOyTAerXsRaUGa9TixNox9J2DFzYu0EM26Jx8o=
X-Gm-Gg: AR+sD12YTKuvMWUA2XZMqlpfvtBWUaRVl/bT8OKdDfzKHbsW11793L9xRpRDawbCPTI
	xJNCGZYKkDveO43z6BwdpgMA8TIhVlYvglOYUuiYLdI359Qx5qjdOaXxud5oo4gJYXEFqUTlcxl
	GLcSOPdv7ne6bgP+9qONjSTZOAEVX96dcbhGVMELogU9w8Mcq7jEUP7dJ/DNBhD9oBjtZyetbdL
	skppQzT2zaalp4JXBq5Y4MXQueVK649FT9m0NqXzXHzVfpv+lDbD7zWJ8SZEauYUs556Y+5LXYU
	L0miWdvUoVp6ytKgs4i9RDS6UAH06k+fkj9Q7UCCmYOn/1EZPkvclx44pH5M7xct5qbyyLE8EkR
	gwtI4ppVynbtAvf5xdpOq8yj6dh+8w84jPbfE86PZXnRoyvANAuQjLg5CFsxzcUTDKPVye3B0Gh
	mX6lZN3Hj05wijeAQgMeQlVB9XbKV355Kurml0t/I8En2cpq4ES8vpjoLJpf8MqZyVRCAwEvZfj
	gF/QztpYOsAifG93pzZBh2cj6hdbn3/n8s8rZEWdQ==
X-Received: by 2002:a05:600c:4ec7:b0:495:6934:414c with SMTP id 5b1f17b1804b1-49804c531bamr23186975e9.19.1785435799385;
        Thu, 30 Jul 2026 11:23:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca7f.dip0.t-ipconnect.de. [91.42.202.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49801216694sm72464365e9.13.2026.07.30.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 11:23:19 -0700 (PDT)
Message-ID: <9ba2d3bd-593d-4d72-9654-5a6e4d76c0d4@googlemail.com>
Date: Thu, 30 Jul 2026 20:23:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/484] 6.6.148-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141423.392222816@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260730141423.392222816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2026 um 16:08 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.148 release.
> There are 484 patches in this series, all will be posted as a response
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
