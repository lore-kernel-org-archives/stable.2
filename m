Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D555388E4D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725900; cv=none; b=JhYKFFvJBZnhCOQxQct/xwg/kGzJUNBjGP5VwCT09jRNmpxoTl+Eu3bUyJQeQbL7Uc2Q2h/LtNWGSQtmlDd1rL2FuOcP14Lze7gH7w2VeBuujFlD8J3zBVRlPMeNIigu3TwlLEGJUjgxocWxEq/fbxh7L5T0MfjjJNEqvJOAbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725900; c=relaxed/simple;
	bh=YRWp0QBY9So9jvC++gDHCc2QC2B11a+d/rs/bKIKsrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU2wJoj1LUUp8G70pv8gLVeV9Kvc7WvsZ1tV8wGfgZ5JtSO4jb25RLbnPS1kriYbFou6iqetYFtrQkDyppXyN3SQGNMYuiiMCNu2trGI0VIB+PWNhLbjnaZ/yVhkRHBHrYQEs1iZtpnnzi9TAeA2P4jP76qUBw8nAauyObKOsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BkVIAemT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BkVIAemT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so509375e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781725892; x=1782330692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfGIZP62uh7PYVhHDF3yN5s7VorHMzFuzJ11i4tucO0=;
        b=BkVIAemTjGfUcaOQikqNUm0zy1wn19m9E/96O6C8r/lI7ZKR9/1rG+oeUI8AvhzWhm
         cVNa4jB11BC5qSok1oZlNVZ5QSEloumXRB004Cktxg0vi/WIuxv2Oeyh8aAt46EX6twz
         UVTrzsFOqzQCv2cceZYnUBnF/M1LT9y2Do1LmLD9wnQrt+sBIkaJSzZyG6uFQmpBSZPP
         qjYWMpAwzDtheBWCPL/rYeg0tSyolwjWsQzXMqtYodXHGNHsECV/ibbQ7cJuXrX9pjFC
         ZnXiLLbH6wqY30FSm3GvjVs2m8Lhwv3gyyB0hntZIlm345giL9MjUPR4tWdw3yTRASch
         qZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725892; x=1782330692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfGIZP62uh7PYVhHDF3yN5s7VorHMzFuzJ11i4tucO0=;
        b=ZbMFp/CggUB81xrXjpmSM90dxT0U5s5f7DxGTBIRcV6Gt4KVj4l2tTmT1EkH7up6gN
         XuaYZZbJHMA0vXkPSEB1omckr7JeEb7RJd023xm/l875HesJmJDUP2jFj+PwcIIK+4jW
         dvoDxl5R7cosAQgoIh4LqtKStCOerWgz77c+fnet29yFvpHkBnvMJ6UJ9c+A8iAHBtAu
         h1Ey2Q06p5TmNlwxhUjxEn3RjenFiL2ls1NBnYNmZZ+SYrQ7bJxcqHB8Dx30Yob0beAd
         rJ3Ft4J1jyzPFKhsbPjjRWbI5C2a2RqvOq08CffkI8kJEJZjup6U/EwgE9O/9vBoEgA7
         b6kA==
X-Forwarded-Encrypted: i=1; AFNElJ8QaUIWj1WIBUil3rtLn3vxWI6GYNR9Nr2lyZEg2gEMCPF+gsF4Sc45kEAjCc03paAQGGr5+1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvolKziKthJkJWYCSGWUS3qWds/1WtAu99Rjb23i59b+Sknoo
	nYORDKe0FQQ2YGW+Y85nxjtxMT9rogwu3Ua7phSU5Cl5ymc1YrEodVU=
X-Gm-Gg: Acq92OEGCCf2q87RE0mNK50l9RGWEMp+cNxdiuP3dp1ZFOMr46pPsJWzhc4xz0g38og
	ZQNJ6EPIF2Ahh/vUILp1tAL0aRMmnvEeD4oxF8gnKZejgCz7xg7v46E+f0qklJf4DhxAosHFJXh
	kz/12VMsCEw+BFeR6d1PCXFSQUCyP5vM6dr15JGpaYlnnk3MsK5HlXeN0awBBOffFldUaiXDzS5
	1uXpil+oXpYHgHL3zCr6v3vaOAOUfe+oAgNG9MVNKOedXiVuvJ8jzuLv24OWo9Ue9QacrkSjeQw
	Oaeem6X/s/7Ux+VUKWOXDchXWJjhuBVMtbV1PVf+qgnhTlJHQvwGmp0y7lHtwg8a55axki0gJGi
	jKEAWICySM+Yp7YEede36HgCGniD9++vLjJuEMeywM74dsbfwxLPYW6/UgHq57mxy1QZ77kU+fz
	h10yDG0ueEbYT7gyz7D4PnYNIvcKRAobVECOKDNi4u9Uye+xXEfr2VPbAIyBrlmhjj
X-Received: by 2002:a05:600d:6443:20b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-492381e2430mr11808775e9.7.1781725892360;
        Wed, 17 Jun 2026 12:51:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm211320875e9.6.2026.06.17.12.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 12:51:32 -0700 (PDT)
Message-ID: <a937041f-31f6-40b3-83f1-1cac8deb1f50@googlemail.com>
Date: Wed, 17 Jun 2026 21:51:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145523.335696673@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.06.2026 um 16:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
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
