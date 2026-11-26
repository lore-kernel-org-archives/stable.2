Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698289;
	b=pScIyudU9FsRl/XJOfG+58m0Q9UU4DdMkZy1W9QI0/3izep91xQfY1BP9IbIMGZ4rKnf
	 rr0+nvkZOzvIa0GjkxvvUCjmTVJ7ueFbsNqjRV5OUvj3bT9vEhDNX9J4dQevymjbVt74Z
	 JHsqG6wGvw+XrbgeTaCnn3M1ZYes0XLPHv850C5su8PMA7fXQZikg2+k21TsRgfk2PArf
	 mHRO6plySz7e6atiTs9m9OpfJ+T3Nw3oDrncS2dzJG7iUCFisQIH1X9tum1s63nBcFix+
	 JdyUojG5SW2rJCbzUA7rbCUt9dNQZ/9SuYh4pEVhNHxOv9D1t6oZ9dnePjhiydYwujA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6vl//TEiVujCr0d0TeVQNkynM+ywZsLPCxfyBJsTqY8=;
	b=Sc4JLwtjt2+nKx7abJJn40NkWKfnvNpSwMAzHpr4NI2YX0/aSfXTGkjP6NmWWOXUhM4X
	 98cMYWcsFMsE3KglWzFOtzN8LA52g3AkTMjmeE4uoiDmmRJVMx5cAsSAkdtF2/sKNhBDJ
	 M8ydPnWp8cfl7GArq10q/+mv0a4YXlGq6M6qCsKt8ZbhUboWXmRynAu8HuuHSf7vDlsQq
	 F4W0CIAYi64fC1/+7Pdzgojgw2+aQVndXtPna88DJEf4vW6xqfFiD3EBzV9MLxK990S88
	 Pg3FIZW1uZ+PBzhB3eHcuoKjcrHDZEY6jvIMFW1Q0nK6jY7YCpwnSnqAdhVfHNDazVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=QuTyQwPw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E707606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E707606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=QuTyQwPw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso65082655e9.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795698287; x=1796303087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vl//TEiVujCr0d0TeVQNkynM+ywZsLPCxfyBJsTqY8=;
        b=QuTyQwPw+9enggmusS7jA93tVKR7nQ0o+ac6AGqrFh0PN9Hw2vo4k2nSgoUvsg2Ukd
         FOMr9Mj+8wChvuzimvyDPKZomWP5iOAmiAnZA5uEza3c04ytAOinYZwTO40i9Wc6Zt+x
         itOTRX82Wt4Y0PLyHnexhTA3/f9/iKt10HzSPNVTzXrqxOqvgiR+mAIhtVR3CiIwZaCv
         7CfKch2xv7bTdDKKVWOfV7raiS2nwjsUTa6DAzwPwDIlvXU9d/STkWbJeTzzMKnsvvE4
         peXxhfnaDluA3XSsdJRKbbL9db009xdCb/jbCFfDX6LzWPtO1tpXWvkXYl2nGudEYycV
         8pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698287; x=1796303087;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vl//TEiVujCr0d0TeVQNkynM+ywZsLPCxfyBJsTqY8=;
        b=opw1CO/kIpSGVkO80753H6fkds3Utvutefq5LWbCq2R0oGZ5UWJq0bKK7Lsw9TnVnp
         3hkDFewaO0r2/SVRe+aA/T8xGSug2gTyQCwnPb1y2fVdAwT7IrqZ7GfWRz7RKWX2k0Zg
         ZPeSsJYC1VkLGBPH2+BZ7Y7pHnGcsfSN/Q4dEDC/nqQiN0ukZvkB6HBIG0zRmDd8x3SW
         2FLjbmjEgU+dm5zIVdW9rICIiRMKfGVKzldMZdaYgQv6D3gDY2bE/6lU/kPb39NX5hSC
         DWPgQYSJurh34lKrPgwjDThmTC5tiim95CMIAg++rnuE97ZB3fsBHBfEi+8DtD0amEVT
         uMDA==
X-Forwarded-Encrypted: i=1; AL+hErHYvpJsukv6XFBDwYHAo9K4uRNQA4dCH9+jruMxDBKmx6sWD6czmt5mf0EL7byWsOQQhFpPiLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iWZPQst0LUcyb7Z9iw7HtWOVi5rf3t5PSxeyVBnzbyp4C+M2M
	sGyf0UgKrHlO4EOOEc/Hn684lPwfzIymaDM/KRQUqroWzUuWJO3jboU=
X-Gm-Gg: AZFdTZc9/B5z973Rl+2GzPYxFXx4HMAHXPLt1gU0I1Fp+9H8ZCgdm/uu10UOIkd1wDX
	ARxXFwB8bmfGaDgIWKzwBvS6t9dS4vw1TIS1sAw5BikqdVjn5vTV75jFkVR23OsRNL7IoMnOKoS
	LdrgXzV271q3TWyb11xt7UjHVlaqSVbGnYq+oaZ2/4mwQYZ0YpxzpOm4vZ92QaGVK521V1tqSzj
	ZJcydZyomwJfzQkKxBKzyX3TImghx9zQg0bvKNozgOktGdOww05hr8L51y5TVnRJWyX91pUC4WM
	nt8DvtCXisvocqccLcqY9KXS5W3KFvaGgiHSxlOOSCYqnd19MGJFnSsaqVp4/GnblZ8DkFwHFmv
	gjx+BcpR86axxS2YNZivCFdHVLF6pjZgDLQV/ql6YSnkq4p6pvz+re4QLHZywt8FH5gfHqFKxzh
	UydbpFj7TdqdgpkgLnS1Lm3Im3CgjoB5yjmrHHnffk20FqFL2sAPrXQ+32GMxl1dsDrGSOv/bjN
	vl6a7PpGzoLLRYPV/RhICAG7P17VwrNvNJTquwVD6oXheeHzzET+kLmkZ70m6FEuUDWcCnJ329y
	MVRTWSWieLYUVi0LenD0yFChxUYW3kDLyKKwE8DtlhBrwvGE1I4vKZrKEI/pWgFEzwhZt6KntYF
	1/xUx
X-Received: by 2002:a05:600c:64c9:b0:4bb:8701:bb14 with SMTP id 5b1f17b1804b1-4bb88804d1cmr454203995e9.5.1795698287307;
        Thu, 26 Nov 2026 05:04:47 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac210.dip0.t-ipconnect.de. [91.42.194.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm39148222f8f.47.2026.11.26.05.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:04:47 -0800 (PST)
Message-ID: <ca369fe5-dbb0-43b0-8f2c-74a971e1770b@googlemail.com>
Date: Thu, 26 Nov 2026 14:04:46 +0100
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
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Christian Brauner <brauner@kernel.org>
References: <20261126105729.110697432@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.11.2026 um 11:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1002 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

I don't see the warning message in the dmesg output here which I reported against 6.18.66-rc1 
("WARNING: CPU: 19 PID: 454 at fs/libfs.c:495 offset_readdir+0x1ae/0x1d0"). This 7.3 RC seems to be fine in this regard.

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
