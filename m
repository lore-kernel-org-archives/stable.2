Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6C53CA70
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921349; cv=none; b=Ki98FAM/xRW0bA1nLfB3Wxt5fZiMN+d8XuLuJWlVgHEAnyvcCk5drHRKguKt11gUfmkMkyXoGpWGmOfphRoF5rX6QI3SBISPPiwZDWdmalmCBFlG7EgOfXin6p0NvMNYr9P/+bAtl4aL/GEA/fq8Hvwvt98eEc4+0WoW4xDP2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921349; c=relaxed/simple;
	bh=kHUiE5axvYANqYFGTvm2buddRW6YsS1oOZ5DJXHz0O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXpXrdJjVkX0LWKfXE1D1RcdaWaePwCLgm+4JQuIkFtWF0YGNfL6/Mo2u4l0dKjnNekwDlkpSLqiXms+RJ71SLAT2nCV3za47BvZOQWrW//XYMDRTUxKDwk6nKDEJp6zimLIgLLQ5kvN2PpYt1H302fJkEq9i24E8ZOpfLXCaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Srdx6vqR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Srdx6vqR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso2654827f8f.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791921347; x=1792526147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jv8xjU6QFIXZ0JAxxYKajZr9UsaBaFM7IIOQawJA+84=;
        b=Srdx6vqROq0NVTMRrrffiLmYk3qn1XVfZ+hzBrRmtIyy84Ju+j1OGZmmyZ06cpdV+M
         QYM3lo1AwpogIHZD86EfkNZtQ1lYUBkYTXNISEhN9CwO0d7iIyp9yOZ8UZ7jJo8BrLcz
         Sz7+GXOUuz9CHpuweADeotUEevEkLpuDSewjPBCyzQwhfYzQDd627nnaYOIs9pJxUHRJ
         ejLhh5rIrTHzu2F7wFYYNtMfgUgOkIQJWaoC98BMjHBRgYeL9KjFwOp0nvg9ZmmDa3yx
         9I2dTf6bqjkKMSdOGGf9Cxk88u0ex+BgABrTt8WJIQz7AI0CHV2kaCrrHtKBuJCGA0Po
         K8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921347; x=1792526147;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jv8xjU6QFIXZ0JAxxYKajZr9UsaBaFM7IIOQawJA+84=;
        b=E+MS9c5HEMD27xtMQgcZ4Lp8uQpNXZZa9nPIL7QPqvRZXJytFLvslQwa48wqeBLwLx
         ai0lPGX7/+MOUsECl/oiHW9VjGabVdardQHJaixbZ8WK8l8AtH0UjTZIbMfqTpRTwMD8
         IZh/u5jacGPAzbLbJnti89khKG2wJ3MBVQBF+rGbTeMXYdUjBSv0dD0W8WDB5YwQd9fv
         Dk68teqaL3G1/WiBbKiVQrULHKsAUGA5g16zpM7lviM9wGb+6OzjzwOW4Xv1x69urmAd
         DLnJX8vV8p2qbnciDztdKf9iWTA/glW7ujv0WTSFaj021gYGE7W+yWNF0OrEg5g43pvx
         xyuQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/b4GPnfZjiNeb0c39emxkGplY4Nszkh4HYoT5Pz668hIK/Ev3kVIBOAvVE4b2U/HQzzvJVyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTR2fyaeMMe2UwKdITZzfVBnFgg8rrRfUrOaWX6etS3K1kv99U
	VJP9Z6OT+UYFpycAilqmggijM/wcHMmvajnA2GMrZnjGn71mHpxEA5s=
X-Gm-Gg: AYBFou1D8t4q1ytFO4hBe3VVvECxgkYQmhKoqFVy9zfRN7csedyqOsf/DH70PXq35s8
	CgZ793PXBauxLDwOUXLTlFBh1JzSDXgGLQjiteSLR2lf3JG2JO68dV/T+l1ilaSvYbGno+XQYAi
	UuDUbjOvABEkXfrjRoXejUh0SzDDbDa+YNph524ZOuhPuWMNN/YFVa+mYKEFZy6V6moE31CI5V9
	l2/VY7son1ee12n8Rwopa0WhGcUy+zaBnb+NK5ExEY3YETGBB0ijOiNVfcpUIDOUW7jJ67tpUO7
	ATW2bavXWItvfr78NLfDjBLjcwwPsoJfhw+RTCFd3hzQNkI9uufPCW7puSfrMD2dFZOjtj36J9g
	treC782FQyD/EHoGJzw+0pvoUtM4r2FD6YmSgqEde7IHg58MpTg/XQHRzO2yO0Nt4N4aZaivxTQ
	L8HNd2lB62TM1cfRB40peNHq68MR9gBc1SHMNfZipt8uDZaHrOO9Ymz1FBvdFc8kfknY6w5NG2m
	1vTv9d1gpQjq2eNJ4TZVTQwCf1t4YjAgNB0QGVdb+amCuDk
X-Received: by 2002:adf:e005:0:10b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48ddec797bfmr8286448f8f.7.1791921346559;
        Tue, 13 Oct 2026 12:55:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b0e.dip0.t-ipconnect.de. [91.5.123.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac52d3sm7133340f8f.43.2026.10.13.12.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:55:46 -0700 (PDT)
Message-ID: <44a8e6dc-0e5d-414e-8e30-e3ea53b034a0@googlemail.com>
Date: Tue, 13 Oct 2026 21:55:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/497] 6.12.113-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261013112907.864180619@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261013112907.864180619@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2026 um 13:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.113 release.
> There are 497 patches in this series, all will be posted as a response
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
