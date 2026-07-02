Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D8391837
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028099; cv=none; b=sFrqczzEi+cVCXISoKcnqs9b3MU4TKiXkwLQpeF7K1kBuDOp3pV8cCski4E1DlSkZDwn9zltAKtNrRyTLXTdq/g0yLF9+DxFa92I243/hcrfM+6HaeLs3Tsdu854+NaS927uk6ZrMGbV3sUKes3TX7yFKN/+7myK3r6JWfHOE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028099; c=relaxed/simple;
	bh=dAZkIgzTMcSNkQrudd/y6YvGZbWolbOeKUyGbxaXf/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgUptG+ipvjIHdBDwV6NYUHxrlU0vDqhEIazAl048RVqUvyzfwk2m+tKqSaobL5LXZEVouDaAqYxhuymchMKujEOt/lgJW+IgOOLc8PJdkjfAI71/vVhZVs/SZQJWZMMRO4d7LMk9Ijsfm0aZRYuXpsE17Rj0QpyiqgYzwiaebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FspbfWsB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FspbfWsB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso9956705e9.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783028096; x=1783632896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19Jd1aI1vovs/PrcyY0XyIG8DDEui4gFTZsXXL4+sNc=;
        b=FspbfWsBG7ce4m8Niig2AXTNim4Q5H/gOKPf2P6oTN/ScEyWf23ahy2RfL31Wxu3c5
         B4PbkAGM+r/Ye0bZG5KkQiYZpHt1MI3xUYMZbpwNbr6i7PXXBjYIB71DrggIWIRHuR9B
         ZOqWG90qAgf8TXVO7492tHxFT1m3sQf+WXvvKZ2jgGN6zeiLbuR+qW01S/yU79EiH1lu
         CAyW9P488n0zrQAmwyncNT36ulP89jE1C44CA+6AyPYdRFBkfrA6Ub8YBPPP2xGp1Uvd
         NURfb9S1xpN7jEiR6ocYlsdsaLZLAA9/ZlaHex3K97OM9ulNkPnrh3DbbYGJsanOsAyj
         oTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783028096; x=1783632896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19Jd1aI1vovs/PrcyY0XyIG8DDEui4gFTZsXXL4+sNc=;
        b=Y0cSPrk/0QXereNTIVRJYkZKF5YCL9ItDt5arh09k2sjT7glNTr2tNT7i4fEbHwcr6
         ZzoqH0liXm39QRh6RH6X/e9wtoVhGIrGGzek1MIBapW5So7CDQgtUqfefdxq89y4dRVT
         5u9vbJrMPqivBtg2xezppifcf1c3DZRDbWKfGG4ceHayVE067VC73PE2YHF1owCcAXlK
         LOhUj8ECPnJEYADSk2dc1oStZKkGQQnEEHiSLCcarq2+XGcKgX+Vgqhb4mN+cV1QkCew
         xVScSyaXW/+CFfP4sFqj2C90e8Xyv6VMJS7EryqQdajHusWQVVqIz838k+N8RgagAKOx
         Jl8g==
X-Forwarded-Encrypted: i=1; AFNElJ9+B0R8wZ7OykDw6clHktoTSVBYO7D867Fch04K6OVusnIbQ+u9USTAp82fp6MxclmUlYnfeEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/YtcCoV5I6e1oie/7vjTbrMhIzEYcSNlmTte7WWU4OAU2NtD
	vOBiWSw8yKQWkoklZ9C7Uq79i04IwOqL5CF/+5GGLKxwTyM1ZtUXDag=
X-Gm-Gg: AfdE7cmGy7ES1wHcRxk/OSPZkvn5GdyfU1YWQPgzWmTGQZnRrIzlaWmEyU2Aarsvv34
	mxHXgs1TLz6+vslf9wMyYeu8eHIXApdo2ELJr6QfAfR9GQwQqPv8X2Wx+HbcdDu1UgkBpO3sNqD
	l4ZGRUqRpDX9th6dJj00qFWkQVwHsGX1yfrwfrNHnzINPpTIV9aG8J5UOWP2GyzFZIvE0auaa1e
	mZJAe+OduLzG7xnES6/VZ+71lGfR9Sqmh2HEHgYirmcbrfcPFXoPT5hMj8w2Xbe+gXJSmTwF3kf
	M78Ng68JiLx8fxKMGhKgt5+jo5kQupg4nmTrjhgX795LsoZxQhSqauqUo4ghErvePNACdIPrCJe
	0ubHM/cXjDvyOeffL+SzpMxTTmpWMYZqueyADauMYqYDDfH+21DcTeFHlXegSkRHWRD0IQVSPNX
	bLAJ9Sux5R3z+vNSZf9GMGzynxGutNd2rznGUs6sHFxDPP7FH8ldR1JeCdKp6Pq90=
X-Received: by 2002:a05:600d:8649:10b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-493c2b904e7mr91825445e9.22.1783028096241;
        Thu, 02 Jul 2026 14:34:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm136523215e9.0.2026.07.02.14.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 14:34:55 -0700 (PDT)
Message-ID: <59059758-e29d-4452-806c-bc4df09cb85d@googlemail.com>
Date: Thu, 2 Jul 2026 23:34:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/204] 6.12.95-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155118.667618796@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2026 um 18:17 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.95 release.
> There are 204 patches in this series, all will be posted as a response
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
