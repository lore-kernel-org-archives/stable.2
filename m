Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072469;
	b=fFQ6HFInzHVi+rw4rRfa0sl0OcKvYPPC16KbJgrXOouFPolAWbvBlxlPG3ZKdjXWyYaT
	 Yk8FAVIqeUP1uTgOMtHKjSlN9KvtwImbKw4ZGWkjQJ+aQJT3NOKF2lnV4t1yhDrUFiMav
	 m5oZp91My+V1wV9hx8WjdcSKnU0keryZUFWBNtxCIY29p7zrsbsGX68/2FInhUrMItihm
	 kz2lYV4uomQmVkX3nFjxQ4PBI+1cV6Ufo85IfTVsk18ND723kIo0rGOqDcQOhhHJ8qvYC
	 ZXaMk+Xgg2lotf1VFMiRCE5JDnIz8gCWJ6ZEyMDE4+H0+IgNaI9eV/e0vN9t00rh7vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2owh4YFvS9EUc9o02yTBqgiJn10dXj2haaCLbozm9sU=;
	b=mwdG2mio0giF6qI4uFfzlPLfTHkL/hcO+gnYehFN8yCpOAKIbB0YLoHk6LlW8r9GtFWU
	 GTvBr7trMCrQ2MKN4RUHHLmFgJhaTwI+hx0oL6Ym2NMa4svErlioHN4GPTPN3sAWSmOUd
	 7HbFqR1Mif8pzmnmf2850EFwk9EFXQrWmrcug29tmUjzJw5yFGHHkxjTAtfYJnw57KcG0
	 zyafEl/UWonzwXG+Gx0fJLun1+DPzId8ZH1lMDDtEUYg0tzPaHwl2MuBYDHszSsd/V7sa
	 jLOvE2VkWPUtqfFvz2rLojw6r1heawHvYLEP4cZYy9kmBtj/9MeZhJfAhigcOVCXEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=aZ7XrS9B;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2D2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=aZ7XrS9B
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so15123415e9.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794072468; x=1794677268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2owh4YFvS9EUc9o02yTBqgiJn10dXj2haaCLbozm9sU=;
        b=aZ7XrS9B+HBmRsZSF26/8uIrYZfDi16AVeuc7soBbg9g2mLKRqA6Nq5mC4ZON2Th0Y
         uepR6nsr3pIHeHAoCWVuajymxDhrpucEhe1yIEFwvCvjeoBq4mhh+1YBOAZfJX0EaYwM
         A3JrxkHi3nwD9BeUtjd1xReHpxUf8MjiAG1p4DNF4PX+gRMgVqVL5/q7ubF6qWmXnT5f
         N0m+nKhouTpLHLiFJguf0i1b7YvsHv/4hLSHoDp9iD1G50hZTA1XnWlmA91AygVDU6Mv
         AQ+Bb1PyOmMheO1TQoxukcqQWM/08XgJOK78FUHPyVj4PKgfg4AosfzYDaJVyZrnIUYm
         atTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794072468; x=1794677268;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2owh4YFvS9EUc9o02yTBqgiJn10dXj2haaCLbozm9sU=;
        b=wDKnosFwP14rxqAzGy+niSE3PPuqZ2SnRNgNcHYUGw+2vwdyupwhEyPDrB0GY3i40a
         hcKcMno4kuyoq+/j0aiw0zH6goW5spSmrhft5mB3vonU4pgyaUsr9mSVWMOhtYIw5L0u
         +FQJKOSYcEJziES9qI9qOOtMjhBjHj69uf+UzuUMPpUcGF6T5bcKtItDz217gWRQpFS+
         ymUdykYqcL8fOgRkIKl1yNg/AhiBa9MmGtWVUDnpWUHEBHgnCc29IvB0pLO8kKw+AiW9
         yJ3vcrXAGwL2yUOtMdwemHqcLZAQWMpvWvhbt7RPKxYK6q/l4FZV3OwOPPqr1kcnbugG
         N7eA==
X-Forwarded-Encrypted: i=1; AKwUvBzVpbodHuMFT+4XFXg7BEpaHY0pgVLnALyoYH6qP5M+2T6T6jenIlxautfY0vAGo4DcG/Ukq0o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tHGkNGyUSGQKWGH2BwGVU2TJM0HoMwlWSTRoxbVtSRf9xE7h+
	Mlad/YAZxeU5duh+aKmBxqtF+1BIQpHNPt6KUm3tQB2ljKYPjclbOLE=
X-Gm-Gg: AYBFou2iHE5Qstz/YoXkXpR8ruGkROOIhMA6ooWqx2IOwGdsomafC3Dreq41H7VVtY9
	vbJWMgeH9W/aZBqpi050i5mj8vqhOVIZ1vs4iW9LqILtIaiHc3QsEXuA3uzl19rsJtu6MKx/mHS
	eC5JhaUnZTldpG26EQQCD5jbz20fYjaMhyiM1NsgzBmGPH/xbKVRmovFgeG/ZInwy2Ox8hpDIIW
	macs7iZl4CqBoyuL0GjAX3F8CnVsvMAqiZaaToX0QZZTEk+8JXMyrXMHq1hdrj3UFrsTYgPesRh
	QUUflLgBvsbjGMcR+YYQeX+5W55ObrF6DX411bPpDAUM+0eoRzCPMnt3fgrmCuA/FRL7/I74Y8v
	LznLxpw4KhC8aMeTtemvwSWvapUmpIHzFnRYNY5VvSDNSB97fn+VD3pTmYszIyalKaZnG9/VLzX
	LUx6oL6Y+n+24VnNgtOdgz2HsY4IwzG6sZbeoy8H+hHdoMB+MUb7PNd9g4m9NnECi2xt1jZGPc1
	mIH2PsmtTghrY8YHbk+yMNYSCG15FpBUr92ayxDOoDUNRAsGNGp+hgZY1cAuRqULRtMDbcSXVX1
	AcvYSeXDvYHgiiY6ZLqB1W8CGldj2Pojzsi7yVJexeBLAdqSQovTZQAakUq276Ymv6c6cQcw308
	8Gfs=
X-Received: by 2002:a05:600c:310f:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b6ded4a3b0mr105329935e9.29.1794072467520;
        Sat, 07 Nov 2026 09:27:47 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf48.dip0.t-ipconnect.de. [91.42.207.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32b46a3sm88407715e9.6.2026.11.07.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 09:27:47 -0800 (PST)
Message-ID: <0e21a66d-5f93-40e0-8991-aac8a464b7c4@googlemail.com>
Date: Sat, 7 Nov 2026 18:27:46 +0100
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
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
Content-Language: de-DE
To: Ronald Warsow <rwarsow@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
 <68c2efb8-e54f-40bc-9c36-76c719a590d5@gmx.de>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <68c2efb8-e54f-40bc-9c36-76c719a590d5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.11.2026 um 16:34 schrieb Ronald Warsow:
> Hi
> 
> kernel build / boot test on x86_64 (Intel).
> 
> I need to revert (here)
> 
> 1564da6afd7ce5297ba24f2d1e61d6a79a9ff6db
> 
> 
> otherwise I get:
> 
> In file included from kernel/sched/build_policy.c:71:
> kernel/sched/ext/ext.c: In function ‘check_rq_for_timeouts’:
> kernel/sched/ext/ext.c:3852:41: error: implicit declaration of function ‘scx_exec_sched’; did you mean ‘scx_prog_sched’? 
> [-Wimplicit-function-declaration]
>   3852 |                 struct scx_sched *sch = scx_exec_sched(scx_task_sched(p), cpu_of(rq));
>        |                                         ^~~~~~~~~~~~~~
>        |                                         scx_prog_sched
> kernel/sched/ext/ext.c:3852:41: error: initialization of ‘struct scx_sched *’ from ‘int’ makes pointer from integer 
> without a cast [-Wint-conversion]
> make[4]: *** [scripts/Makefile.build:290: kernel/sched/build_policy.o] Error 1
> make[3]: *** [scripts/Makefile.build:551: kernel/sched] Error 2
> make[2]: *** [scripts/Makefile.build:551: kernel] Error 2
> make[2]: *** Waiting for unfinished jobs....


I do see the same build error on my machine (2-socket Ivy Bridge Xeon E5-2697v2 server), and the same revert helps.


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
