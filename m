Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7513385D9F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817020; cv=none; b=E81iBxlhi1M0qbQDvDkMSm+zNw6fn9GQD67KxZlM3cxfi8pT0Tuazd5nbZux6sYTa29CKMmKDC1g9aYat3HH67A99CdnYGWT9t2bfmFUnWVS9WmXe20naBGwdD3Mgx6bS/WDVKYO5hhrmaKE3yGwwsUj6ygxIDv+y/9IWfscRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817020; c=relaxed/simple;
	bh=Tq+EEQZZUSkW/OHULP4X5a3jFtNXvLlkqUIM3wN+i+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI+Yyn6zawDJCyl4bY9ULXpLo4X2CMQawfN7xUq/n+OmYzSb+iHa7XRaw/PhaqIjB+yIAsjfoDAjXDok9CB7t1UmdiZaE0sELNZzvqgulez/XtNOyKna5UwHc4pTJKjJvDoQybu7wjVz+zm1rRbsr6dRqPDC851Z2ra0lhtoAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k6xd6uAN; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k6xd6uAN"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b05fdb2f9so446612f8f.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790817015; x=1791421815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Hqg7fvezYx0gMAe4vTkP11iGpswB7iKcMQUSEGGhy4=;
        b=k6xd6uAN2j9hAboy+qkp71mKUnYkHa23MOSi8NYL0SrQC9P3OuoiNrhzBo38iyxFDr
         Q5t8uX+EgqWNH+kpAwzIb/oLn3TrM+VlVpcYuLuFNeKBEz7r+XNQGuSl+0aIqndBuaWJ
         phrXRC/WfJABx8wCv8Rksf2G1m0v7m7OrwzxBcBAd7WQueWsnExLzR2ldMI8woc60D+y
         GEBAqHTBChCGu9xb6ClC9D4T5s/5AX8OKsjQP2Zg7e9nZWKGjvMXpFH3XAjbPeopbtiP
         /gioLEM1m0MgF8l/dkve0AfIjzdLHV3wud1mJFmTncqsXxcfr29WAi5k0tU5iqL7L2Kt
         6HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790817015; x=1791421815;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Hqg7fvezYx0gMAe4vTkP11iGpswB7iKcMQUSEGGhy4=;
        b=oevdT8Pb5yUDRLa3JHorV6huYVnXpSr7JUUhggXEMKc6qetOfLL2y/LBAKiHmNO0mE
         MWXw2JxcHEqqbtzCgF3s2U/Vd8mgtGcC0CgIH0PGpmYS24uqks7xSqa4VPrcfFu69+C/
         y3Wq6ava+D/gFmyxzfB4bPa28HRqpLFsQwyBQONeEhxQ/GpjoZj+Lnh5grU/MZHuYGEj
         LU4tg4TUgWh0wD8SsMimuFs5Qg5wD8ZkIOhg/lxmbUa2RPhf3AN0cfVWMwHr0/njFqqs
         thAK2zN7zaFsaoxiVwiZ0cyrgCgcN0b/W7Wn5RB9WP0r2Z2asIMTszbwnrqbennuZgkv
         hJEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaxWSk55E5KHSfCfvBd85MUderx0A7HGM+Vnwk59+ALWBISHXMWLlX8OdqPK3C4sENzA73xMA=@vger.kernel.org
X-Gm-Message-State: AFuF++mufJTzhxYX0rEDE/J2UsGWGLMXb6PqDanCb2hFMyH7bmu5aiG/
	RINqtO4qlHqjUVeiDeqSf4MrqJ8+5pirVC3tkjshYxYRX4RAtyJT4KA=
X-Gm-Gg: AYBFou1D6NWmxXt+zt1N+X1m5TUAVNIDkNfjnv0/BHNv5IUQfCzXEofOEaDG6gY4kXP
	kwrmlUD3O0mC5aL21pKoGwd8AHZcxTJNgtaWwjtUZxdEvqGAOPXe/TqihgKVGjaCvEyFCENhiWX
	cxKx5fnNQTrvCqrgH/627L5VDTI5mzaZpUobSrdUWanTSrziKMHONU2eomDOwdONI/wHqcMbEeL
	Hl7k7C0Det/to7tvZNxMFV2FlaL5JfT0eOLk0pdVLS07eDAqgn55IdFVtdZbMl/rkRtT6FieCTf
	/tCWbqGTOPDxIHC6uz4IWUdw1V0I2QWdiBdOQmhkKbjuDPm4ZnuubQY2+Mb0Y34o5KQ/jqu5c5Y
	MhS0XgjsCr1wbf8q8KZc6F7vNlGQNEA5w7fxjmQ4155udN4z5qTPK/RTa+d6Z7u5q2n3pHH6zEk
	Acbvzg0eaYSa6HfgWc/9/MG6clYkS/j1dKt0pj2mNZIKT0Hj2rDrj52Df0fy3w5ju12r6vQIv78
	0fEnmC9UnU1vltg3Qoa/ZbpOD40Sid/80mpk7W7TSslRJxZbLFnwUkKtnol
X-Received: by 2002:a05:600c:8b88:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a01ad98373mr50081855e9.4.1790817015182;
        Wed, 30 Sep 2026 18:10:15 -0700 (PDT)
Received: from [192.168.1.3] (p5b057568.dip0.t-ipconnect.de. [91.5.117.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f952931sm26870905e9.13.2026.09.30.18.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 18:10:14 -0700 (PDT)
Message-ID: <f7456596-f978-4d75-b949-f61e21f4c798@googlemail.com>
Date: Thu, 1 Oct 2026 03:10:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/395] 6.18.55-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152340.591469096@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260930152340.591469096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2026 um 17:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.55 release.
> There are 395 patches in this series, all will be posted as a response
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
