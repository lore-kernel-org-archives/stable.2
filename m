Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E7368D41
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787482532; cv=none; b=kGD0Ym4FV2QAQQKnRtNme3eGnYTrnU+E5iUsWAJnvyVWBpgZcQV2rbgV/trr2YxTD0ADEGMyvzmCUVpoWaPlfFHPmKi0acRd72/Z78qH6xckPIf56TtapYUQjN+NMrLsLo0f6NhA73BmzAN1L8zDjtMQuZ7eU3ajmMFR8HKj4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787482532; c=relaxed/simple;
	bh=N+uGOo/eDS1WxTFQV4MXFh5/qVHIMFKkx6nRIDr7V0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI3PrEO12IDFjNJqeK7BjS9BangNQiIWg8uIyLjvNulargfox4sZfxbqXP2U7LELfnXnsXcpKuNdIn1f2cz/4OWmFb+AHLpaG31e9eicUkdDx922xFVOOphBJaUP8lGP0sxdYX4iK6MvbVgKpWriSofYNvzI/RasWdMqEnJng+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PjbulMvq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PjbulMvq"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cd3fd760so294945266b.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787482529; x=1788087329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xr1IRjdq0tafgzj0wiYO0YYZkzimvM4nS6Ue94QzKNc=;
        b=PjbulMvqGald6YndZcGHYKrIy9Oq19+W3SAfKqlMSZnufTnTw1dHysA3EBeoPUiEhu
         xo1e+COeJKGS8f46mRo1M2j/hFCCpyl3z2/yu9Qd25BilJUziQB87nBIRvC1BJgyIJYm
         a8f/NRO0eli4rBbZXB7O5z/9r0WmcINEbJ/ZwU/MfDzFIoydSt8XTXp1oedehZSgiP+e
         cvmdfJIYouMoGt5UYfikzVQnIkJQUc/0WjjAMLo/jKCBQV4567+m4uE75zW9iSwtz14Q
         ePou76/698PwBNb46LVFhv2n5gcd3q3Ct7jLniTvp7To5CbafJLmPFZrjiDqYJO5thFI
         LE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787482529; x=1788087329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xr1IRjdq0tafgzj0wiYO0YYZkzimvM4nS6Ue94QzKNc=;
        b=C/9FKY26IhMqxM0w5soBfJ10IM3XHnZw3gwe07ME4f/HvgLkQO3xlEafJWdD1sk3hb
         stSy1JKpB9l444eXUm/C/U5nY4FtiKtlKIAz8k1AK8eINAAAJ1PqZudu8zQpOrgbzOS6
         XPgp/WhlutW3VKLPNzTkxiSooayrOVr6PZIUqG+4gWkK4gYktNVn2yw+sw8jWpit0Qm1
         Yo6z/YANyNaRMLNiUZ+14fjiE4RtyVTdXMJTE/EUWvVr8qFm1+czp0QWu/lPcJ39QxaB
         INtHF0BeFvsn8od6qEIRTnQxcEj3ya1nBZT5r7WUWMpcXLI61NvPG2IMj0SkvolDMBhC
         3kbA==
X-Forwarded-Encrypted: i=1; AHgh+RoI0+taCJrLmWSCY1rhiSsjdLphSmTTS2GMhPIMBmBzDCkRD0tqL6mINyxjvIOcBS28eDRwMBg=@vger.kernel.org
X-Gm-Message-State: AFuF++kXtm2yYYQKP16r6xnEb/28X09Ds4MRPF8mAFR4Z37WvdCZtrxp
	o0E5WRbUvyoogF8hUe2XelySht6R/1mLR5V14I0HnTnM+GicEGaViT4=
X-Gm-Gg: AR+sD12lDRa+INkRdFiKzYfqsKXfZamMkxB7AW2zI5vtAQZOQr9aBp61DMzzz1i9QYp
	sOP/npk8CiKCSZfSTc7ymqUNrHgJybc8+/sC3mAPolf6FzVhO5Cw6G5SeP2sQ+2RGG9sb4/4oha
	lwd36H34dOvYS+L4zMj2IU+rpCnLySUWILAokOuzUYN79oUpbGDOsQKd4kBL9UC6bkMEn4fKCWW
	a6WhuxiL/NKNKtOosEfeKw+YIHzJN53BZJVpmrm7nB3ib4L/dHCDbqlhco2OsLb1sSNOGtqBHbc
	kUKYFhvHPWBOQUzSWalAMNMVBqF17e5SfrWs6G0pE8+d0NR88wjpFy4MncnkL9QgyalgaKXcLi2
	MQIFE4ALLsd3Amj0IeKMYPNpwYJNbwmCszSKc8rRRKmmFWBUREuTlmIgJnLgmV/IjEx3TJ81FcG
	WltkJu+0DpihPWvJWhOIp3Lr2HZy4+rltt2sM2cxdU0FCH0hlxxfqOTR6mdTrxJod0kZwTIbO/O
	pIpEb1kZ4qxDoyaKwmIjcYgJYMB1oc4XunaJLaV9WAIXzlfcM0X
X-Received: by 2002:a17:907:944b:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c24926a1cbdmr1254414766b.15.1787482528475;
        Sun, 23 Aug 2026 03:55:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac46c.dip0.t-ipconnect.de. [91.42.196.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2183sm705877066b.58.2026.08.23.03.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 03:55:28 -0700 (PDT)
Message-ID: <76b46256-fc3c-462d-b84b-6b6420d793b4@googlemail.com>
Date: Sun, 23 Aug 2026 12:55:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/160] 6.6.153-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260821142844.249995408@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260821142844.249995408@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.08.2026 um 16:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.153 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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
