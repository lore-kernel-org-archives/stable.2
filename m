Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704100;
	b=PIjYCq17vHuuMseu2b4h/9H6GVe66u9GzjcbraO3tGEwAlO6K1X7M/R2Zgvh17ve1KPP
	 p3tKenr8g2oSV1M0IvXe7cXm83gZ0wQkl/Qk01MltMrp+aY5Szbic1UCSNbkEx3/FhR/o
	 50j7RSunaKD3XIPOe7Y5B/rWB4KcduDI9wzlTZVMVNRjWzgfs6sDLjwibMTQ2GpwDDvSt
	 XGWDobGzeLSIIoG2ZpCvJvtuo5IPViIR0l0xWYWnndT2AEMyUxjlFth6OtEbTjkytGiUC
	 /hpxonX7fqckMbvTf9rbUdDDEzXHpZtx1OLhFnxIPtc3w15fuPiK2KJjiftt3popsQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LpdDH3GEwcUlVHPK2yBSFsZGWkbH52RFZRnAmaJgBf8=;
	b=0U6HZN75sfIlUMVJoMjZjBXcYR9UKrbVJR6mBm0Ta4ecNKLRweoLUm0gFQvoyHpbwvO6
	 K+tdqLUKew/xV6Wm+wBKw4On0zAhHouhW4iChW7CuQ2Hzwre1f+95dP8+aY7RswFynP/4
	 yIqhZX4lnzuIOOyUVFwu+1Z/H6Ml6KMjb1b4/n/O/EMmLMoUN2fWk77mcY9cOFeC0qM66
	 1qF9BIcIe8fGlDJfuHYhLAmffiKyb23nQT+bANUTP5+B7QQC96BAuQZ/zFVFGSeBDaass
	 MWoPY1YgUFXFHFmcxtC5CeFqA39BRJ4mw4hgoW3UQctnLLMkyfNMxF7gG0m2AcPNTRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gL4LUGC2;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5872606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5872606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gL4LUGC2
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2efe591a1f6so23980605ad.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795704099; x=1796308899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpdDH3GEwcUlVHPK2yBSFsZGWkbH52RFZRnAmaJgBf8=;
        b=gL4LUGC2lPmHO+C+7Y2OB3wZsZdBRH4/iXzpDVUXZEdKrY5hv+Enka1lcT7Msk221d
         siYQKI1hM4GZiZc3yxACoinn6yc7kXd4mWwhoF1ATOZU3XP90WcInKvpobtZXgGjzXiT
         XSfeFpnB1ycd7V2L6e9erfoLjTUv0Jav3TcXFXOqpiq7Wx8kXZhuDGfrbVFe7d6pZ+np
         G9CgMVsOq6UsHLtqkAqrEV2rcCzpX3y+SdkiKNski+CYq66UT6bO/eaS0JT54Vj2Bb5i
         ET9l2uFaN5mLU6hpN9iLJJWKKIMbuOJt59iBWF/SzNjVXZZOPUyJQhFny28kGeCDSKcL
         1wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704099; x=1796308899;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpdDH3GEwcUlVHPK2yBSFsZGWkbH52RFZRnAmaJgBf8=;
        b=rQb4XQLR2kW+9nM5I2Sz800krmUejIiooFAHETA/n9+MD1yGDCXdRrSFTnm+ZVxrXT
         qgzVCaEmIXKQDg7+rcFPAZFKu94YLrkGXIyKwjTbaG1eVlJ2+owtglgi0N1+4TcDN9da
         MsBrl5kYn7tH0QzfPRXIwJECiL/Zj0vdpTod+jeELvxDROWwhJX5pORPe6vesWPrxo6u
         VffqbbFNKCS8YkmlYmw9WOk2PLHyuPVFONSE7XDGv2rImPaRYIAFWqaioy+dpHn4lWvP
         zsXy6XsvCIwpspNMTfGjoDcuuS6PspBOnySiKQABtVnyJZfx5bC49S7yVddAsHbiNktp
         vRtA==
X-Forwarded-Encrypted: i=1; AL+hErEo8fM92Rl79iLokg/JnZbVvPLXJbm4BRBLOyyZZc4Ikt8ItKfro9Q+LvPdcszZUvrh2RSzb1M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9df4H06amPtj6p1qw4tCremZSV/2Qz9UuJWnDqUlgVLpwuUC6x
	281IBm1gsxblSaaU3jHt7qLuksR4VS1mbh0oLB9baw7Q7ol9fsiBAOJA
X-Gm-Gg: AZFdTZemW/EyrXE4sRDLyvhcyXl3a4EYkntEM+pp96z1XiUy67V3EpMEZq35GsDg7ki
	6E+2k2GhlZRHmURkHPphBbEl0T47cJXCPKZT0mQ66wTjq075+txmfqXpwHpjrpMMhXNdgOOPFKF
	oqjfrLY/6lxpKxqnsInv/DhUfylGpAa36d4XTbIuzSLDf1O3bH9hicYxd2TW+yDeNAJIN6nOjPP
	RUDozfyowVcC+L/0EIc8X9bk5nsZldycCkT30hsWcgx6YnzCWypScd7coTtEaUVpZRAY0LKFiuQ
	lAeAgm7gN7JTatYQ3uiAu0+LtntbqOTX2n7aFTgF3iJLZcLrwOCm6qjSIZIlopRrmrft9mZDhti
	h1wQIWTePRLE3bGuCNeh5eufEplI5VFGOPVh+sGs73K6fqdKXk6mj+oJqn3i3OxZC5jwybR4MUb
	gvToWxnhQ84d5Phn7Mq/VtCXdx7iuE4p9bsdumkRG54XXtSJn9KYjZ1Xh7o9iR+9K1xL6FGua4s
	6ZK+CWRh+rlV+Aw3uaVLkwxgilmeXigcKH1B5ybSND2BuOP6bEQhC8vlxqYekvuQFcaLzQW/wHi
	Q9RG5rgbZeJy6//bOSTo/Cqlkyd6cuLxKg==
X-Received: by 2002:a17:903:1a0e:b0:2ed:38c0:332d with SMTP id d9443c01a7336-2f03f16eabamr208027145ad.23.1795704098961;
        Thu, 26 Nov 2026 06:41:38 -0800 (PST)
Received: from [192.168.100.6] ([121.144.254.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f10e67csm104457755ad.53.2026.11.26.06.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:41:38 -0800 (PST)
Message-ID: <b8ed68cd-4d8b-486d-b933-b1e093a403cf@gmail.com>
Date: Thu, 26 Nov 2026 23:41:33 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261126105729.110697432@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26. 11. 26. 19:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1002 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Hi, Greg:

7.3.7-rc2 built and booted successfully on my system with no regressions
observed when compared to 7.3.6.

Note that the kernel was marked as dirty due to two
distribution-specific patches, which are required to build with
OpenMandriva's modified LLVM toolchain.
https://github.com/OpenMandrivaAssociation/kernel/blob/master/linux-6.18-clang.patch
https://github.com/OpenMandrivaAssociation/kernel/blob/master/linux-6.19-acpi-clang.patch

Distribution: OpenMandriva Lx Rome
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 7.3.7-rc2-myllvm-gce73b94700e6-dirty
(user1@omv-zenbook) (OpenMandriva 23.1.5-1 clang version 23.1.5
(/builddir/build/BUILD/llvm-23.1.5-build/llvm-project-llvmorg-23.1.5/clang
0b5f47964323614ae2dc227f0b267ba43892bf06), OpenMandriva 23.1.5-1 LLD
23.1.5
(/builddir/build/BUILD/llvm-23.1.5-build/llvm-project-llvmorg-23.1.5/llvm
0b5f47964323614ae2dc227f0b267ba43892bf06)) #1 SMP PREEMPT_DYNAMIC Thu
Nov 26 23:29:00 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin

