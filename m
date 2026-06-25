Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D77361650
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407522; cv=none; b=CqL9NcsJvA/tBrp4GmM6Ylz3MmW6JQgGILFlDuRdf40sIVLx1leBb11kXeaX9MuU/Z+TGim2xxpCvAv+tPmxNpqrcDC09Le+zCESNglWjRVY0zMpWCzM80bJBYFT8DW325O6G+1C0zUmozihu0eJxdmDEtKpWcZejtv+0nuhmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407522; c=relaxed/simple;
	bh=GYQPxRYeOZe9xA3Z7jlOLVuS8C1pKrNXXpS5JJeJb0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mr95F4CaaQY2fe0KczP4+JQBLlEH0i/rFcBNrEV9sZ1N2GqpzhbmfV3H7AYl/4fzq6gzLNl9jE+nIZMrh4/v/wWvARJhe+4UWuF/mvxX9uDa45ibMuYtJUn7D2oXl5Jycx/upETmhA42pTtIrZfaCttq4wa1n8okm9Bdw2Q9hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Mc1hYMK5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mc1hYMK5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4602e2a0372so2037309f8f.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1782407520; x=1783012320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/nrtkiDBwccYRRPEcbTsqsJxJusPJzF4noA53Uf2LA=;
        b=Mc1hYMK5APX4jC+RnMlIhVaN3lS5Sa9uyCQv1Y3+EHIvGqLXy81y/AhvybW5YtwvDc
         GntPXJjrWFzJ0d45K/hrIF6pXgKHNw2YcoSc4HbrRMeq7VZ81+gTX/RUdDFr4mvsE1jB
         sAm0tXGCK/2ZrOrYAFFHu7xJ90WFbm2xXQy945EA0siLOgdXVfmjXRmxuE0jW3QnmyjT
         QKLJzxqPyg1jG1f84MK8m9oa0/Mej7FKOz34bH3Q+xG6O9C9kLbp064+LRnbq3YH2ocU
         zD4iqD9Z3Af2lWgaeln1UWlda9zmSZqMMVwfWj/eFrzVogQZ8MH+j7U8gqx2Vom/g/fr
         CLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782407520; x=1783012320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/nrtkiDBwccYRRPEcbTsqsJxJusPJzF4noA53Uf2LA=;
        b=bqdLtVlauDzEOq8GzCd7u3N+MOFOJXU80l9lQ25m2oJdNOCqtmBZSaI8MefpU28Ydb
         7cBQn4I01RotLPohfmCWNlP3crARKA/sMiXCBNdro91V2owVNpg4qMW+Rw4M24EE9YMu
         U22nLOZeEw3IpylJAc9ClUoEcxLIOEtZp0xJaLvgWvgfF8bYsHX7mV7v40xrqM2UcnSv
         QsQNAmpQ0J0auM6NFCWmeEiLAPQ5bQ/OPujMVuWF0PeCwFPGGK2OuIYhGr70zbxBrwt5
         dum6No14nlOkZ+twnODnVGB1snjEzlE/JRbKns4ZH1SL0G5hRz/vFnkd3SzJKKdfUVOk
         lrCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpyfs01Kr7YQjsOpgY3DtZWlEuAcmStr7HrmUkvQFDDoXLUtZaeKq919+2tHnZIF6Ty8otEIAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0DRjWR40UA/ARCQARubMayPByjLlNr/Ozd/ZKlKHdGenOHi8
	IGgKmQMvzQtDFUjj0ivpb2Q8PlvMKOYa8iBDQdRU85Ls5uSkgsDwYrk=
X-Gm-Gg: AfdE7cnhXpvxsHVdLng+Rp91K/iIuIMlM9GN96fm4ub69fGNaxKJ85WtR1zUjwaYTQb
	xQeFwmyejyT5bGoEefSiDFMMJyuFnyVAR8jn65B7EZR0BluykVVKq/rnUny0PAE5GJweS1uH1J9
	DKB/6OksO5X5I73AkHzEwX8flrq+QoiezT7rd9lIvmlB8BSMTOuMBKPtG+uCnCy2/fiY9z3pRbz
	7sIa0ZtiyzNe7VTVzetQ99LMbXGJTqz9wbrZ3Ni8YmyaVPQnPVbF6l1qTpasRVV8SDcC+lfgSED
	iwZI3tcXQTVnOeZtyaCCRIgRHDUzxCXwVkvUD3GuXJ+w4l4kdWSLcf17TGRTGGyoTKoyd7L+VXG
	C3N0gB4fpTDKC9a5Puh4VQ3D86YGjGrja4wuDYXNcCl9A8GVesYGCyYjuLKPomfnlGhvIbGV5mI
	LoGlw64zWCqX/t3siXNSokz55AWrN1R/ZRrpvSG4KHOPBV5fCWHUf8K2GBDDdaTGAm
X-Received: by 2002:a5d:5e81:0:b0:468:4f81:5aa4 with SMTP id ffacd0b85a97d-46dc026de2bmr5435368f8f.10.1782407519694;
        Thu, 25 Jun 2026 10:11:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b0572d8.dip0.t-ipconnect.de. [91.5.114.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm16930278f8f.20.2026.06.25.10.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 10:11:59 -0700 (PDT)
Message-ID: <5cd52e45-cd66-4cd1-8f32-22e36702c0e8@googlemail.com>
Date: Thu, 25 Jun 2026 19:11:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260625125645.554579168@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.2026 um 15:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.37 release.
> There are 60 patches in this series, all will be posted as a response
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
