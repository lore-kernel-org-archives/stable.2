Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08A2FB084
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994308; cv=none; b=MFG4D0kl8TvEVPjMOlSoB0V/SwLGtO8ZthIiwxNiO4w8slUtPVLfs5Dkfl86kZdDuMYsP1tguGZWStH8GGmcU817jQUpcVPL8NwwwZGBdTCf/RgDHombV8jG9EYeMEsq6slZ0D0Pmu95bHBG0PAxiMhyCgWLuhb8OL+xAglMxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994308; c=relaxed/simple;
	bh=29/UPfY5Nthq2RpwxSboYXXvxzzYGsctgvnG0yqUzuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L76rh3pB5iYNntDJCLxBW0TTJq3RyiGJshY6NNuC9ofVa3ycQodMS53QdivInjpX/oP4Ri5wlF4H5xTmlTINt4vIKxLp32FwChxRA9ZOJ5c/KvZGFqBLIOuZzIhCAR/pPEhyu7ueW/Pj7gde+zsktvrIfUKazfCIWihxrOeNb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aE02GP/E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aE02GP/E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so31215245e9.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786994305; x=1787599105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMVdF/RXKO/xfkwhQ6TWQXJqHUFG6J2KjoazKU+K+tY=;
        b=aE02GP/EC+40eIYdSaqi2iu2RjEj2tix4iQLEFPrwxZn6Hzz+3ITU+pYL4ot7uHaxn
         krn1AKIIMzvg3VlVvd3GVPeMKm8IcjNHPfxUS/FfLAFfdxOtuFoJOKPizCL0Q0cSEFY0
         Doj+bXSuWgU5FFiWaR7wNx5wQj8twQSJ3+AQSFD/sRJxwYzszEPlZ+USF9CaS5lw+2iO
         3OZZPCOLiRhTtUWeG2cuasw0l1VFmRVFPnX8fHGybSGzA9+SNeWPyzdmgWh0XGrtQMjN
         jtrRUi+yRDKFynbD6vj2TBxuGw3cwU02ojwCS9DACvIoGChOloYaJpy6eCLdTCsHmY0R
         zN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994305; x=1787599105;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMVdF/RXKO/xfkwhQ6TWQXJqHUFG6J2KjoazKU+K+tY=;
        b=Yys6B4PQwO8Zh7pRo7WOjCbrlEkLys45aFVAPX4aeaFDIbvIN+SJ18D5RsUXvhBgmg
         ShUuXVOycz2E7hP1M0dIvRsrPaDwgIDl+6aT1mZkRVnHKxpHrgrAwRafKXBgpyWvX75P
         dEYJULZGswKn6TsHtlebUYrw8XIgk1MGsozdvXfp7IZqaZrLJbqs2lGWIQfoIH5wFQf7
         baWW4iWBbcrEGLpLFWgB7DsCAT7EdBArfg9R8vlnhMcVRyYVQWPPH0+8R/xdCdHRjvxc
         kfYwOWZCCvOLuj3CvgpW9ZjeOdLUDcAMNLr3coePEE2JH0wlK4sGhRJu0tO3Cdl+yREk
         wQ5g==
X-Forwarded-Encrypted: i=1; AHgh+RrQyAGOE8iTW5S2X6OIKluEnzx5Hagn4jcX//i99xUOIHe1CHla8jP0j2z3CCi0ZnBGqrKyR+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAQ0BrrBfGPzCB7aIlKENjjmq+nwZUFxX7Ec5p0XCwgaYhbqY
	ZlZsnuDtA9xA166IvhXo9fNtuweC/tMYF5Zn21vv44yJg5qiHnuaTnI=
X-Gm-Gg: AR+sD13JtdCxUTMsHqpAunjwxgnPIF5rsPVK3aGruGSL6Nao7MCX1mXUkIzJkfJPksj
	JTEkEeuNi0/NEhOnYf+vlWO4v9dNZdLfjT4BBwNOQTqurli+Rodbp8pO+ABc+H9pxJNVD+AOjxI
	SZQvGvEvU/M/hD4KcVv5jBWb5uvWKlhVfgmq2ods7lAfALvC8dyvj4gC6+iZ4OHjatKcj/K651X
	8EQZEN400XcMANdL120WHpqG7UON3Ovrh3VwyjH1owaJMdMfG9SH+UzNvgtW297xcsr694/acwR
	XlsM+bjKeveH0E2i8/CCsoyMQ1JmzXKJr9OxqsUmIUI6oivb/MPTxjFJHySwndOm2Ez2lT4Px06
	DbR3fGI+j7Bk7+0siwtKMkJkjgaVJWXlhAgqGjbAtFsgjz8CZ46rLaUt8K63eX70ZBhzlzdN4jk
	1Q6q9/VQnryUB8UUJp99xk59OUOK/CyP4aiNoaSxwc4h4jDZh04J0KbopaiajuMFhdoqhFr/uvh
	UqW8382W8aRsUncOrvASUTguuRnak5DMEzheSMQ
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49987981e52mr453171115e9.19.1786994305106;
        Mon, 17 Aug 2026 12:18:25 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b466b.dip0.t-ipconnect.de. [91.43.70.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610966dsm222871785e9.5.2026.08.17.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 12:18:24 -0700 (PDT)
Message-ID: <e9f71a63-839a-4d6f-abb6-f2b8c579233b@googlemail.com>
Date: Mon, 17 Aug 2026 21:18:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/181] 6.12.104-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132535.394764707@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260817132535.394764707@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.2026 um 15:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.104 release.
> There are 181 patches in this series, all will be posted as a response
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
