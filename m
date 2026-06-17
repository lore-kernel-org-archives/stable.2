Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBB2EBBA1
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719105; cv=none; b=mwDDuLSKpd8+PkwcDlytgL/BZtEcyTXjGOwHGPSzDZWFqVEqxQBev0eD7OU+pIzLoQUm0PqbA5i5uJIXSgf/i49HezVgyu3PIlLnfPBIEX97LSuIqfOn6EuEVRm0hLht7Yx+fezPf0wQA5xmeMSdD1sCqNlC3TSRlHMWSR6Vt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719105; c=relaxed/simple;
	bh=Guw0tA1J8byOmGpxmwZek6dbqqoxCDzeMh6YE1dAJtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiTuQT7s/HV8LLPpKnQJYxVGuMFaWiqtOZBbW+4cceRPqQmr6qY8jfvBN1DwGX8F5Ux2edkzEGxywHcOu7i4i2HquMf3dVWza4GDZrGjEENHhv2KkP3+eqWic5tmEk5zLIcnqvXwz0WVsIgNGWEbLWWJ4l1RirE+TdPy+hmpfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GhmT1reI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GhmT1reI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4629d80fa08so90007f8f.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781719102; x=1782323902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CL7rn3pRUfZddrPejdk+SOSMtwuDTO3Wu9e7dDN4jg=;
        b=GhmT1reI2Mep4RVTwrXArz6V3gf7fEQbLcGGlPbSqFdJSBm4GXSdRk8LoBMV8gb4Ra
         UTekQOg/PpCK1b+WYe5w3B5xMHCtPSyBaZDOURX8zTS8CEIekB/l0IMNxGsk8Xv7u6CE
         7ZhCOCMvMODWR0/rrT0ORMTTh+nrK9k3o79ODzcR6tkaz/rpTWc99gIejlyAnMbEyh2g
         Z0GWhB/3ZXalTyenXbestU8lt1foiRLYHET7InD6Fpk1XnTkOEhmxWKrlUkGOqbFOsxd
         kwbC+Z9kqqoTmOPRhjUYme0fbs91Fyj12sJdQ7z5GoYu0tITWaHcWS6GsED5RqKXBRiW
         /GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719102; x=1782323902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CL7rn3pRUfZddrPejdk+SOSMtwuDTO3Wu9e7dDN4jg=;
        b=bCGjumZlQJjnp+RT5xrvbYY5SSCANFM73NsLNu0SJn8jp8ax5YfaxyqLXG9NZTIYyj
         21fLoaklu/MItLgRn6hElpJ+Vk0HGFMofBYKxrlI9SrkZNYbs8Huw3ULySBk9pY/hMvf
         MdCIs1xJYOxKv4+LnQzVKTg+PvOapldFEWOu6hXxOACkKYKsZSKl4HpqN0whhUInC6Iz
         C/0O6auVh9986W/TZIg/7At+CHPQsH1EPgcCCVTAFyDuRwBWONOUJnz0DsF9Hm9VDywX
         oYjlLZnr7gG7SqJfEXTv/mfQAeO+e/JFt/qi1nfZCyJ2tNXhp0N/NVYps7Wrn24oFGzR
         AaBA==
X-Forwarded-Encrypted: i=1; AFNElJ/mwIGqw1yezQ242/LNBSFui0MENcDIGUnnvs1q/0FaP/ojt9BKpPAMfflnDSBVHw66YgZRAxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vAm60FVJdyb2dKT3FpXzZOcW/x1aSiiWCSxT7D0pKbmUKtDb
	NTDuJ4Tn8lzKScZRtnUWNhk0TuTUt3/IPVrCSW19Y7NSGmUPVDa197E=
X-Gm-Gg: Acq92OH+0YlDhcPzfVuKUFgrm/lSR13Ct+ibk2nPgBVCy0hyak33U678lE8X2tkKHs8
	pMrHxj2u858h/qXESlPA520Pgw3VMjRsp23JzFB5KoNPFNURRlBe0j33fHW68m3+PqYN0FYL2KA
	9OIAZYITE1pVro73BKst07ZyNe3XOcdohHCWsVTkviTvH+jIfZw0+8+Mt4xUVtMwVmdHywnpc+D
	dCn6BmWQYe/lCOiANMgW1OhlDBrAMBJVbOXLwcKssVCz42eMxIZCFUr9kREUs7yBtrdPjnvszrN
	oitymbr172McyTnzEAg63st+QGqkMH394MUfpQRaPB5AmIeXtQ9PfcLwjwd4kUgFuPUDD6zm1cG
	CRgKWTUWGHcUavOLHSVDjM6Alu37TVJ+n/bBbYHdjkRpPgL/EY76h9uWFI9Jk8IKy/7mb/g+TnB
	G70ZJF9oD+uDi8uuEiM7ex+RZL8Yr7zIoqD56oZ6pvsS/1tQZMKxc9jV8Lg5XVwz8yRiIkTcAOK
	rI=
X-Received: by 2002:a05:600c:609a:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-492333a991fmr83089395e9.9.1781719101742;
        Wed, 17 Jun 2026 10:58:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm204165435e9.6.2026.06.17.10.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:58:21 -0700 (PDT)
Message-ID: <e8462f98-9722-4679-b162-748174c607e0@googlemail.com>
Date: Wed, 17 Jun 2026 19:58:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145057.827196531@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.06.2026 um 16:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
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
