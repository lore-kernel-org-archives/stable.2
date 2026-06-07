Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D31F7575
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780867912; cv=none; b=PtFN3XOjkYoxJMzFMBPSjQzgeB7aNPFxuuYE8Xw3RjMCnNd57iZ1zaYrSFDZUdUlhs06k9li80m6kVWlJK8dbXSyWZpo+UceG8f6BHcw6GOQQaDkzxh7NURXktXlml47e0EEW1Qt+hpVYObDwlPC6+g3pm4KE7S0tqT8g98vnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780867912; c=relaxed/simple;
	bh=DxO8RqzscgWYf+wIOrGgjSYaWUOAiGyJN9i1tPFtdXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKhizlyJV2AqOeunPS+G2orZUaO/L3UBeSeENdgzeYbNAsjhApfWCt04sswimDO/rQiC7l0xpl18OhU7CaRQrRpl+nlMUZmJlXQ1O+7x0j/3s92u8c0ves0t4N8emfLI8vaNNnsfjvkAuFZOki4GjJEkI5pvYBXXslx6hr2bFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ut/a2t/4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ut/a2t/4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso41095195e9.2
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780867909; x=1781472709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2gcOathGztfrOdVPX6VicT8KCAhQRH0y3mn+5yBJLA=;
        b=Ut/a2t/4Xo9ATDOEioEpgaEfyzmCodseARBXR3iHDGoaJP6U8/Ji3SU+BQhMa4dDNs
         6zc1+jkxQER25wECDy/7hdSA248jZievAB0IUpFk/0FZofmgdX5E8dkY4bmbWe5FroOp
         EHYK6CDOG5q1cYiwYI7Y/eEGz6RqMO2mTm+yU3YS5aBODqPMlVZunON7wSqPaa8emcSM
         d2EtirYO1pX4goaYlfyIlOHV2i8nO++6f5TBHTarguHAO96olBtNws58rbvlSL0fOIX6
         pU2ifAZyaME1GPt23BhiIPhA93f1oYbWvbKGRU4Vhcxtg0WF1+45wIk6VoZbgGDh1WcB
         IwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780867909; x=1781472709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2gcOathGztfrOdVPX6VicT8KCAhQRH0y3mn+5yBJLA=;
        b=JHbOEl2A4iyoWRkE9sEimq7fXMAGT1PH6DVkG41UxtIiV6WU4lxetlBtaPZN2ANbno
         DJcIcvEjzcN7JXlzdiz1IHfkNwUv0MlHZnfLya/68WXliu4LQPiVNHWL7ScumZetcK1G
         JqYJwJbUXaT2o3ufrKSjFYzsbW8/Ew3XUwfcxz8oV53DzF3Fndow5GYIlOZ0BmCSDjcz
         EgQf1UB1CMvQjhR7qfIdwILPDQvMj1+AjUTDK3Ro7LuN6E7g8zw4Yor12VCTOaU43CWO
         iy8ldPsLOa5YYYjXYnoRpHIJ14q772akDSWfiRUNqTfsqKJsSlCAZhHMl9a2CK5AWqV7
         2lWg==
X-Forwarded-Encrypted: i=1; AFNElJ/UIW0LkhoUAxjZ7fZsttktFMgAwUzilstn9YcIrKy14vHgm37LGfqZUAUPTD3Mz2j6Q7zAa34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMz5k2zEHHfJE5eSqvPSAELKE0iGu3gmpoXvpX2PTe0xG+NkLF
	SKmV9qI8NPljnoUX3IIZC4jZjwbVD32o4kE23LlysvCBaPk1pDEmL9I=
X-Gm-Gg: Acq92OECv9EbcvG0IVqNCEmNZB196couL+JJBK3HlXfu5AObquQNxj0Mk6X2976BOYt
	tULOPk1w0tmNHCQOo6M+fe5iVpfv/HfI4p19Hz3NIBCRHyjrXjn49iK18edMK6zKXghFmVFUXXg
	1iqQ8Y6orZfxteD0P0NQZWSjglJK9hFc5LbQIXYgreqIjsa6mEIu80rNjK1KnKuolDz5Q2EPh5Y
	Lx7sk8wG3eSvf6dkRapPZgeuyRIAZrDroydWWeGJcyM73gQhwhzqhWloSKDf2pghk68/KCSc9mO
	mZMLupbz/TiLWyrUl2PPkCtlBEyDtjX21h8JIprlERIcEzLS4dHqRrH0XQO55ONytaiPOmExJvi
	Pj8npzu/l5339NsgCcCIIdMY0lSsSWsWvFHS52wOe/HRL4QAIMF5qzxBCV4y3JjdFmJEXXerqPR
	tY3bHORq1FzS+KdYdkv/Dwz/oKr99AHWb0qe8ftqOxvEtHJxoQH/pE268W/leZVpbctar7ur5c7
	Y0uN2+R6o/c2Q==
X-Received: by 2002:a05:600c:4f90:b0:490:3890:605b with SMTP id 5b1f17b1804b1-490c260f448mr224236665e9.31.1780867908858;
        Sun, 07 Jun 2026 14:31:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48d7.dip0.t-ipconnect.de. [91.43.72.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm47459482f8f.13.2026.06.07.14.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 14:31:48 -0700 (PDT)
Message-ID: <44b1d1ab-923f-45e9-86d9-abd235abdbca@googlemail.com>
Date: Sun, 7 Jun 2026 23:31:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095728.031258202@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.06.2026 um 11:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
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
