Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC702374E6F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234148; cv=none; b=cEjMoOs/eVG1jtwb2L8NGR0119Rx+L7FaCTqhrvqKXTJN5KT0WnhMTwmTqkdDFY/Azo/FVmd5c+0a4BvDEiOzZMom4ZEjetrvRqQnqROEDJMoKBOWfeSxBvrufBgkPrl4k+FmsgvGdh1dGWWUn7zVnMKVWgX4/nJIKriNY8pimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234148; c=relaxed/simple;
	bh=uzYzUOpCUybuVsbVA3DcsY6yHybI8URN7D+i+1CPVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osDPbp3WSyYgYmlrU8VnmOHx7B1sOu8w6rwOgbzIhko/cwiISkGl91aiVRbCg4OSxTWMligymjThAJFUT1bWlm6obj3xChqGRbhrG4UkLh1giTdYYUbYnrB/GgWLLxYyGid+9bWwQm56l4baSviPOfYuc5Y4iPF6OUs4SUyf1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R6BZTzhi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R6BZTzhi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c733f15aso61854775e9.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784234145; x=1784838945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c1DyXPkjEzI9dz3oHSPFi8xNB0t5SPnNQYNpF18ngA=;
        b=R6BZTzhitm5SpSTGlt2m2V2/3p/RdiE2HqaadRO2olN+wCgS4akP2fh93UJrB2s7EO
         lNbPt4FAqBKuanxR6NGgHkhX1ajAwdb6CpyNn02ofwry7mZM56BVGRR+DQ9MfTshClMa
         luEs1J9YvLWU2oEp9eS2G5VdzdgTxK8mjjXR+R530bIjQ2k7Ej/IaWIkWsOvTQ99KO+v
         4NtgeN8uzh/uV8yGswJysls587U4PjFPc3RE9H5Nfe1wzHC9NnR7S9MKVdhNlkBC4g5s
         4v9GtOfNHZv2wi9EqtLyzAKy+87JRI+DY+wxZmyd2ATGP2RtoHSNtnnxcc1j9etutRXY
         SNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784234145; x=1784838945;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c1DyXPkjEzI9dz3oHSPFi8xNB0t5SPnNQYNpF18ngA=;
        b=Ko5iw65uDMCcsfQcjyYVfayZtjrVGJCmk4/NSjaU75E9Ypj/OdmLqME9PxQjjJIbCa
         UbW1IzRW7xiNK731AUG0GK5mRZvRfEUIu1V0Srt+Xm+nVL1jCWyxwtP2U0CaPyQV8Gyf
         my0tnnEYL63vsMwQrRdocdHvtGjxdnJ+ECcABp/JAHEKPjtBW3L1cETrsZ9bD0M9de1n
         z3GI8W9EzFBcRuv3uMTTa6WnXLB0yjcMayjX8uzmINcDgZQT/iIG8BOX93kIVtbWiXGo
         n9H7fNl18RwKab6oDN85nx5MElKg60JP84Cla74MBbnb+8NzJJGCc9yQwr8MRU1d7EAi
         Qq4A==
X-Forwarded-Encrypted: i=1; AHgh+RqAJX4dbZe4KGEg/eozJN/ArOfyWPEeKVnnk41cWDa/xvL3QcMqyw3QVSvvdJZwxLhg0IlLn6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXT83EO8YYONRuTGxufDUTiGypJk8+dEF7/EwQX7uDEdR/A7o
	xq0bGLYLqu+OWrDuWs8ecawBlLGkHN1ZVFtkxtLUGg5a5IWO9kXdMhrXFB6x27U=
X-Gm-Gg: AfdE7clHhS29qHRDUSfqMrciqnvXSKdIvzYsRyF+FTf1vVRifNI/ru2COtv4+jvOxU3
	e3n9jXDDyF0EXL5VLRzYItKDnH5eg00QDcvGSh6cViTZXLY0xZXsRFYbmDWUZQvU5xhIMrK/dzy
	l8Xhyp6QeY0KbeyssnItvRrGAMXs14fD6qF28fdLk459/dkyyuWOwrnoPiKr2BnXgACE1C7/EC2
	1xcfqjUASq2GGmEo6DzHoI6GRocRxT+SK8HehQLQR5NjHusd7TgN6PmbIXkCfZPQARgO4HlT7B8
	+cFia1X6zMUqjyEVAgUkVgggWa0eFDjy9pj6WHHVLFjTmbhgKIc4T8GLSXh68g9i3kCsd1Gufqm
	pCM4jZQcCw8d6y3amk315AQimzIYJ4avbbx/whDbYtJrcEFQ1FgN2BywVBvNTkpswH4Z8KE1ayS
	0O7xk+bEgF3rUsM+bY+Tovp7cXBzOgSXDtkce3jAoLKjioXehWj3Y8eg==
X-Received: by 2002:a05:600c:1f8e:b0:495:4598:6e14 with SMTP id 5b1f17b1804b1-49545986ecdmr35345505e9.24.1784234144880;
        Thu, 16 Jul 2026 13:35:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b44d3.dip0.t-ipconnect.de. [91.43.68.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7f84sm25780178f8f.27.2026.07.16.13.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 13:35:44 -0700 (PDT)
Message-ID: <565b9102-031e-4fff-8d5b-9352182bb44a@googlemail.com>
Date: Thu, 16 Jul 2026 22:35:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/480] 6.18.39-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260716133044.672218725@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260716133044.672218725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.07.2026 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.39 release.
> There are 480 patches in this series, all will be posted as a response
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
