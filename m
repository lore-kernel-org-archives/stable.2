Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793244593;
	b=YG1xuqF4MsHbxkYx/VzQ3p1Tuu5nLQOlw0GmuLPnbV5AP2MEvHPQesH93uJtpa0j1F5B
	 2e1aXqcunx31SGxF6FgdplI9ehdQhrErkMM5VSmQyKd8mtBM6sLldP+Gy5WFaNZKVHfp8
	 d0ISfMNttBnoY1Mj44wp1KDGhUWIsBdDmxTebz8KHasiL3wc3d7Rqnb5hLpod9PZV2K//
	 D1oD0SoDqONbnuhzyjkgVowmZDO/dQKIB9l7aKgYZ05KpwAr4nfzfyM4qU8WxknFRfAQW
	 vIT99/+DAEjGUGj2aEEnKoipM1LVd7kKX3Y1HuTVNKc00p64hO+5OOBEhOznOkEi+Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aLxkHNwaV2Nm/4SXJqHXqRt/QoXx8VfPwy6LHI2UFFM=;
	b=lDLsrQbTnj15jeMDkoiEC9LbEdx+E/L5gAsAc1tAMAGfOqikmtSovg5oX71JCbJgVvaq
	 Anj2IfPVeBatHhKSEVANB0GC+43ZIoEmzGJty46rlNA/CQBKxUYfN/+PEgALjnJSn1KsT
	 JhOISRnXOUCfO5VBfp4L3ujXcZk85eqXr6f5rA7wVybN+AHw1xM7nKKlzDuFQgRbsmfbc
	 XVzLtrcZOGOglHyDksgbUtt9kK4VMUnb2KkuisA8JLH3DY+B8qYqa0dE2YTevYQ+crfYu
	 /4Aq0P6dobddiXtWyo/WODRHie1gVOBl0tvIP+RCFbiOHghmXD/74rC/1OiLzGRGMww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=nRg7cJN9;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AC606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=nRg7cJN9
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a210470b49so13037325e9.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793244586; x=1793849386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLxkHNwaV2Nm/4SXJqHXqRt/QoXx8VfPwy6LHI2UFFM=;
        b=nRg7cJN9SLqW61SOTpAvJUE6k+wITMzWkO1BGOzi4qowcDN2HOi2XBaTgc8oBVKBD4
         lVg7a3HC/DNhM9g3Ot9jBkrBl5hCThZUE9A6fRO7VEinLVqDjXqSs0ud2S6jaw6TJ60H
         pzOw91R3lcIl/e34GqL8gj84v4Mp7QjDNG0g1YiFaBxg25VoIXH9T75abWAOs930/1GJ
         oEfM678598TckKw1ZgQ500OfELjiRAtUWU/vHMT4zu4FxBfo3l6GHkeGBzkgyc20ffUu
         O9mV/4AE+xh3FHNK+JpuW0VvRMNCJIF6rhC+TcgJIchu9DqLUEGrsf5+dkPgmfc89BzD
         P/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793244586; x=1793849386;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLxkHNwaV2Nm/4SXJqHXqRt/QoXx8VfPwy6LHI2UFFM=;
        b=aRGxFLIxNTrsaYJRWyGSe27mSpiTGlNwoE9uGfASFYaUly/DS6uryCQ8bFze+May5H
         QZaYVokeLE8IS2EEzIUCv7xCbAlLk63hSnqfHOWISOWCQJNVngL1ZXdggmq0WKM0Ux4R
         CyIQd/uiXEH3TSngS03YwXnEjC8z0RjTEbkMmW4WeRqbymLVkb3pt4CCVQhjN+ky8579
         lEqqMsKb5YJquJO6t96Nk2s/WgjK5Ehn/iRy4kC3DFlSeA9pKCcmOSYqtEKj6dAmuLG4
         UUbhno9iPLU/sbLpVhv6QU3l9vaBBvBf7AOXJmeIFP0h2VWGHY/iQYUSGUyOefKh5dM4
         hBSw==
X-Forwarded-Encrypted: i=1; AKwUvByPG5dbngzfFmJp0koUlA5WsYMwEXqNCa9CnLPJKOeXSPNQCATPRCKXu5Y6OUytfhTuKBHhJw0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ+MAEMvvEKo2G9BFMcWmWIdvgWlNxarD9ZRRx+Xxo6TTLu0K3
	YNk7Q0PwsDq5IRcJcqpfz0o1xnnkmfaxbekSmQ6X+DvpBzmEH7gIYdM=
X-Gm-Gg: AYBFou1AorU45cSPCkESMI+WCehWzkCCJcTskkQshrnU1iHsYD6RQSl4mx/INH+4Rlt
	nx7UF5WGaNU9ibOKtjqAugAKYebKH0LcxBOfjg5U1Hbhf4wl+g8SW2KZVEZqv1Ygn+dNBco2KqT
	sIstCoFZ8lMpenGYbopDIQ140hPy+x8MsoY6O8vXr7wjnWNii6n+p7c66qVbeCzN7Gvb9bJvxbk
	KWP9FudW+lYtfqHtA2CCawVO6Y3vuuuWDNAP7GeSdJWLjnqLyFNKIP92p+7k8GzmVreVuNMtCm1
	t7XlGMQbc0/4adnp+5TMerHwRY0+LrZOdoHC0AjD4R8N7jVhbXcvvHkPswTR9Bepd2ERBl/sNid
	da4500QQizSApyat75TUUuOBTUu74vB/Uy0cefLQJQZKW3xNJabbw6Qb8e1DGqcLCH0Fa5+4d9y
	Da/J/Ris4BivcYJ2KDe98kU/EcRuzMg0ucgOmyklj18A0y29ojS08tuKjJs9EDZrIJ5/1N3mcIC
	KtAPpL2JxjldghNItveGiQiYeC8XRB4lLXDGSjsqXeYfQ/VmMlWJ2G/vDSDpQanLXr37AWrX1zJ
	sQfn8Wgeh7bHlzP58TzrX5t9g8JGlRwPuPDh1nSrTKL7sycLrJ+aw2H8KeiQuWRPgduc1hAFuLx
	br10aIX4=
X-Received: by 2002:a05:600c:4f94:b0:4a3:5a42:b29c with SMTP id 5b1f17b1804b1-4a967202997mr98238455e9.26.1793244585802;
        Wed, 28 Oct 2026 20:29:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3f1.dip0.t-ipconnect.de. [91.42.195.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee57589sm37717095e9.2.2026.10.28.20.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 20:29:45 -0700 (PDT)
Message-ID: <a58da4e9-8fa4-4aaf-a0c5-f2f443a79504@googlemail.com>
Date: Thu, 29 Oct 2026 04:29:44 +0100
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
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165943.089486480@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 17:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
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
