Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408500;
	b=oCTkYLHoJwwSgqaOuDsgBPuxB4m6Hgt6KiUQ6Hsara4Lq4/2Pso27qfuq5KbfOTzwN3F
	 GWOVxk/csHGyckh6uRcSIy0shAfReDQ1CI4wfYUZGbALFEg43rkEN4tnm1pEZkEGDxbxr
	 7E4pLOUEg0mnDb13f4/o26UVgK07e+5cGeEL3LugVqdC2iPD71US0u1MypKwVsg/38K6O
	 fyAOuePKiRjyafZXw8b2ntqhNzBJ3ikphv+PN1aPpIVJrNoh/TEWXq5cKoUtjNGLG9Mnt
	 E76uOouEof31+7cV8Mozt63bEfhsMGu/+YUiUcNLmHSeYwyc6tZB2Y5cB81dR0wMogA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LZfsTBRamD15PPndPrII3yvEWmYbhtdxrXyNeJy7iMk=;
	b=Otu3XR/LN2U9ZQ9HK6oApWtIGfItNmOzqXYXckPRpoJlAJBzNkGAn9VIvjwCCKS2yfgo
	 8mjSB9b0+XrEQqSrq4enJcmbEzCdBc+ta+aUPCqsbaH0d8pBopmPIt/9u76CVXlly3fxm
	 dmjf43sC+uaF3x6mfUXBUvoYJtwXPOxNidtI5jM9aEWvGUGimZQThWH6MzOYETuQzPrcF
	 4eAlr4VE6twTSW0K6dQf8U0rHH8ljpXn1JEcrm6k1Qj3PGcgv28Syrp5YVyl2rm7JK+uK
	 fcvapJIHC07xVLZTjHh+nszLwJPulkwyiRoo8YQ7rpY8qhjBuyxRl7Tl3vr4WvHEyjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=F0Y7D4D1;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E585606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E585606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=F0Y7D4D1
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso11396855e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793408499; x=1794013299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZfsTBRamD15PPndPrII3yvEWmYbhtdxrXyNeJy7iMk=;
        b=F0Y7D4D1WpvD68HyCqk/6sbetNEWS3Lm3B/x8NuTjvGaU2zNv10or/rcVPfy8jPGar
         MT0/AOmi2oXnoSVQ0PUW9u9NSg7/DLTIwjEwe7Tf6MGUhYkP5HiAG9gsbA5dyC6zXjD8
         raKZN1ffprH5QTxdJyaTqsNuQAyoTd9torSq1RmwbgTwTO3FUV9Fd0gzh9pFXW14N2/9
         p/Y7xM3cULiLH5joXcqMPCWsV3bGPLw/TBauugYaITc0/J1ZBh4uicDwsIHJkwoYzJ58
         8Wv9Oj9xT9DES8kerqQwU3UTYhqHmtO6fSbSLD4tfGxK1mL93M5GUKR2PAhGUIIyyYB5
         CT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793408499; x=1794013299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZfsTBRamD15PPndPrII3yvEWmYbhtdxrXyNeJy7iMk=;
        b=14ngmRDwcWOzCIxpJm8TkamHUPIJGKjtkXkouCg9LHJT9cGJRFKPwvfMsQTt1jtarH
         YKmro+WLcndr8uA4gQgVMgoyWJPrwGOtC7jGfvXmTrN1/3Q3V4OwyQ/ZTpwh84xCLtCh
         D1ybWdyYcjRSmV9t1ulHyHBSAQR/ezMxwI3/C7nwY6U2rnyYM4n5ZrWcOL3pET5boQEZ
         pgblmNaUJ2OSL/5isEKTG28kXx6kaZxF1ec9uz116oZGWarHOjiajrIDDpVBFsitsMcu
         eq+f6YwdfJ1uSaifx7HGS2/CteRxvByo1q0EOAqINKokslN0Ut6BwNzV5GPHDMom4Zcu
         IjxA==
X-Forwarded-Encrypted: i=1; AKwUvByRHYo+HFA7mW4s8wkoqnx/eKKEAfOHHWIQmC7zXfXS3UV5wPTx0baNe/bz1eGDP1cqsXP0PUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI51ipOqq1CSQxvwvKPRyPpQZbYT+8DXuXhVAcM3+smq30bUoJx
	2KGvfKxIZIbUSKy98PS5qMcg5uwLdsvG6/p2+X0lEiAlOl6Q4JKbBK4=
X-Gm-Gg: AYBFou1psu0DBEtkcEqDvci+dh+dMQ0fzAxJAoryRFfiZ4FOEq6BT7LjpC7D/wA84q/
	s4JiDLcKx6/NSreN8d/neKGN+OpK9M/Lr5g8jWjQbWZtsZG9DG5nDIn5SHtxlYqwuj+fFKsTzK1
	RHLlilTi/LxD77gykGJqGV8qIbBEQfqb3oEVVthlE9olr1cdBBj83SumuhRCNDUogRgJXeHYKtn
	Bl4d/v7CFxyuixXfqOozX7BCMaTGKKaZmBISNaT9McnYu6MhnMFYoM1WMbhMbcbUB5L9eaw4WSW
	WJxogNiZbB+XiqZrax3OrANCY93XsEvvFnltnuO36bD0NIXyDLAuWNOUqz5nxzWsCsVUoZGzMn2
	AcMK/xk9+7CKDOv+ytCRHxmXefGzy4NGNKP5HOAHc8imu2DYJKwsXHijE8XSNSkkPyJuA2kyMLY
	nb3mNI8yiyk49Hk5oEon8YQoIjQG9coLllFcfDTT8zvV1x9mf0Yi/xd0grte0kFieUrEoDmBE9H
	I36iSw99+N21nIB5r3RKP5MZRsN7ldr/tmGWnEUOdW7D+yXKEtMDxkFcbAyIVJ/UXE3i0sBcmvy
	tUN2SUwtV6qicSXczEcagQhfGQWB0q9KUO65QH082Oo2HBKG+++Wd+WX6w92lMIyNyzgtwXD4BI
	JAvo=
X-Received: by 2002:a05:600c:198c:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4ac151a9a36mr94244865e9.4.1793408498561;
        Fri, 30 Oct 2026 18:01:38 -0700 (PDT)
Received: from [192.168.1.3] (p5b057761.dip0.t-ipconnect.de. [91.5.119.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm146688815e9.3.2026.10.30.18.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 18:01:38 -0700 (PDT)
Message-ID: <0db80581-4d82-4771-a495-4dd1c4a1c282@googlemail.com>
Date: Sat, 31 Oct 2026 02:01:37 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 00/10] 7.2.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261030121255.257615100@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261030121255.257615100@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.10.2026 um 13:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.15 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
