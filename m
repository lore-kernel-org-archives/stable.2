Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EC449B0C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685148; cv=none; b=PNuJ/3wm+g3X/TmnowgBGc6xhhh7e42bPs1SLvL9LcuRoO3MTB6zjEX7b2ksASG97UZ8g1tuu+KjjyWBSJ5D0LPDQ5i1PAguwb/PfjGzv1YGOpWIVxsfq3EYvooKesJgGb9IZxTvLP6p514plUtykGvJM1rIfS0ni5IkQvozPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685148; c=relaxed/simple;
	bh=akcJ0MmLlenQNjkoQU/ZAksKJ827LifeS7rmDdrnKsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5Cw6dWTYZTLQrx0ry5Kkx2N2obbewBf5pplmbIZHT7vrlhCiKWD0xIhYaYGqNQY45QgsDXN2lquZpizwI9JsWYsFwVowVicTkoctF5MvdEMfa+IbsfnGHy9RGXBbMgSCAN7MPARcKVr5AlJ4+sRXe1BXiC5J2tgG1e26RI3fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=USxhVeJm; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="USxhVeJm"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so756365e9.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789685144; x=1790289944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vbbmySAgXmsI40pXiFD1Hh73sth3K7z+LhNCUvEReA=;
        b=USxhVeJmggC5w3jyf5Qj4kn/VSOFlT1TP/AO6x28X5ESvJ8jLDomNouucpxpL/0DaY
         X1cpEbXVldPJzvdEL8MZLZE/caC0enI7eymF1wht5DhfpaBPVtta6Vjh1EfMan4kJTu1
         I5s20KoKXwrYiPPMHY0PK+8kiaZEg6o+BeC6iSjHH7vuh47DoY62atLK1w75m94+jFgK
         H829jYbO+Zl2ebOOrV5rF90i9vQ7J5gLM/HiT8eRDxsqLRWVKkoIv6poh8ybFe5VzTRL
         LofcJAH6w5cZzfABpSYl4B+t4JmyGCSEJDe2ejOe0W9j4z6uzSQNaUSDN/A0XGzWB1zw
         JIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685144; x=1790289944;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vbbmySAgXmsI40pXiFD1Hh73sth3K7z+LhNCUvEReA=;
        b=1OFdA2pNTSy2lNztwCY/SAxp/BDBh2680X1qnYXiJlDUbQP2QwNagVzfsmnbVNPg/I
         b981mOTtw7jYA0nmVINFAy/OxY3lvL8vzRgPjwNUudU9YX2R1oEHFYt8H2ck9VAxXk9I
         zdUcOgR8joaUdGwoMSNnLUHHiAzN4ocz5gvAm88Rab0Obb4b7mTKrEoGt+LhSWnz/pRR
         6k2i/TbLh5VVkBj48nNvpdGQ9uyL8Q4CpTNc7qRvE39tZU6/nB37Z1hYdBLJbET0mejH
         1fKx8Tb58RKAfiFlwKk4H8ct9+xvgtQBr/Ik8Yz7Pj6VNLnNlGuwCDSdUlgHn7r0yNdE
         pjRA==
X-Forwarded-Encrypted: i=1; AKwUvBw5LQ6jGUmFjRSPUOpGI9GEebNu6PZfhz8MZxbtE29wFB2AIvNK19T1vZTeyxxiwisRhWksHfg=@vger.kernel.org
X-Gm-Message-State: AFuF++k3EHRH7ZTYfFs6ywekfF4yvdaGrhf2UIz+F5bExLNO3e/DTvRg
	9uDrIMRyInlCUfhac3H2lz/wDy3275C3vitbujricmDeXZSRIvVrn6w=
X-Gm-Gg: AYBFou3AiteHP4j4Irx9VIAMy1Z3VHTkvGNJYqNUbRJG6pC+7tJWJHY1h42EPodkaSJ
	icOCtmMl9rQ0WtVKI5Bo0wH9BkTiuml1jWd9wTuPt6u9fQWu92gr8n/1O4bdrIFwkdSHLrnhNH5
	SkIR1Ai8kOUz2xeS8+7Pz6TxxGRiygzlFf8Ge5pmMiN+Oq4QOxmOHi21dz6EmHqG3U8piCr6HDI
	Pgv8pwoVftjY+COWHSN2se3UdS9a24I+x/x5lv92TARQtOMsFpxd5RANJavaPI3PAYlXQ/M7WjQ
	NDb/BkG5ilSGSt1ao1T6Fn8jZaLVhx/GykyKrptV34lIeIoxyG1fFo1fXPM6rrow6ruRe+Aa9oG
	wxMaO5HbNA4Ki4eChtM5v0cceDCF8WUpVOhghEJzUIGkQ4iGvWm0/tl8vD/T0ctYYlOsqZvFMuD
	9A01hCORpDi4sPEqdTyqMW1mCsKl02bUHEX+8sWttFwjHasZHak4/WpGufqjxb69Na3LreOOxyc
	5fjrxsyDWgOUpD3/LTdqfAWRDm45rbuRH3ofyN1MWK4DBo=
X-Received: by 2002:a05:600c:34c3:b0:49c:fa21:e74a with SMTP id 5b1f17b1804b1-49fc5757f73mr4006775e9.32.1789685143622;
        Thu, 17 Sep 2026 15:45:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b057001.dip0.t-ipconnect.de. [91.5.112.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc5755c40sm8484455e9.3.2026.09.17.15.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 15:45:42 -0700 (PDT)
Message-ID: <047bf331-375b-4dea-b847-e5102f377411@googlemail.com>
Date: Fri, 18 Sep 2026 00:45:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/733] 7.2.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151350.597953846@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260917151350.597953846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2026 um 17:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.7 release.
> There are 733 patches in this series, all will be posted as a response
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
