Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070986;
	b=K6jO1Mbz3Ts+mTBz0B/F3lTdGVuwShIeMn+p6d/O/RV0nWRyrOxiZ6WLwDzZvWnKmiKm
	 SvxA7fYNYBNOuVG/a/InkE7qN2kvV4duNN9PkcYNKcfxFSN/xEolG0xf/Q7Xqb65t8C5y
	 D35I69rQy6e3azDiLaLRxe1eKL8O6Xfd2tZx5GfsmfiF8uXrKRKO0Lk07+a6BJ/cDjZZV
	 CUsbXMvZGaLO4N5HViWn/uP6/Zs7wz1UDI3fU1kLeaIh+9UGL6Y3J1zHnK47lwdT7WhY9
	 PeBKnt9o2VS74v2Cbs1YwTycw8deQTLU5OQGA+DaO4WXEb5o3ovHYUadeh7ev8Oy9mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=myuh5cci3C/VnU4rAsT0YjOgSwGITK6f3ixSFCZ5/S8=;
	b=E+zEvngvT4Apdq1+gspGvPdR0eegckDUrCBVYlnkp7vvi5EKcxfUEBJU8imB03HFfAI6
	 b0wfVymy4D8/1mS8z5GmyTA8T0t8cw2EftR4oDifvItHhY63oahvXVd0QRSY/JPB9yZMZ
	 qAFGNysEr11BF617GhSAORW6vPqpD5j/bxNks9GcMQblGufRd1ybvaLrd3ntrMTU2Z+ad
	 CyVNMx5PTyPvS8H4FaHF6VLf26OtTRHrqnCWYSGXVcUa1yrUPaN0S1/Gdxt/h0IFjwN9u
	 TW2NGBikrf8rINFNNvCMU0RmgXh8nHYGuwMhLhfhQHV2duF4J2yLhE0hVh+HIp1rX/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl7qK9dK;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D29606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl7qK9dK
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso1048207a91.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070985; x=1795675785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myuh5cci3C/VnU4rAsT0YjOgSwGITK6f3ixSFCZ5/S8=;
        b=hl7qK9dKHotq4tAlWwWgZB1Fwu+qYg5tWV099ciWP/Q4Q+su73qdejMSuTY3NL40rD
         VrIQ0IaG32qBFd1weS++CvKwxe2uWpHBJCP6Xr2skDBR6esIMzTO/JtxLTpK9waR/S6I
         hnlBEwDXHkq5ZvM/JwyB9FiyhuBlnpClxCImm5OtgQ7Nmzx0b7JYReDZ9QP1NU8HNPeL
         4JiCgqkl2xF5GM16Hp3tgVjySFMAwhoE8tF1SBvc1KB4dcjOwOYDWbHZEevQJh56qCs3
         /sdJNRyxPuBu3z/J1Ala1eEUCcCT+UDknGd0DxLz2iUXXXyv/uigke8BQmhOiV7Wn0D+
         N9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070985; x=1795675785;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myuh5cci3C/VnU4rAsT0YjOgSwGITK6f3ixSFCZ5/S8=;
        b=sqvmUi2V9oBycusqQ31dCCjzAPbxJsPhwtXl/ki3Xceejb0Cr/E+TlpdP0fwQqj9dP
         XYM1wJRKWKCBdxiN+OBCu8a4SZ8l6Nb1orlqw6TvSVIKRasUB/iGV81Xk9c0BjJnju0w
         j36aenia311aOnydwhyC8kgHJeRI6C+rf0GAJWhCctNgqBs1FHMTLYyhvbbmZBvjCIxr
         JCypvlsS2pK7SRPfoQ9a6vVP3vEOBYviuL6YcZHqnpYHWxpEXG8NjsWLYwzz68P/UWm1
         xLRHgDc0Pry/OKWh6qSZshE/KSVS181LzCdvrZ6pOhD5CKX3h8gKEprSvdHIsGEDK0pu
         mIJQ==
X-Forwarded-Encrypted: i=1; AL+hErEQDM3sidPiiVKCHFPZTV/e3rA/3YI3Kx2pbvYlvHc4Qotx4OS9lwhaEZ/wVqADcNjRbm0i+so=@vger.kernel.org
X-Gm-Message-State: APuU4Z80f9zO5/IwYGUHBqjEdLPMxmWzYHw1PjTOq+V5RL//z1xi/UZa
	jMj6IVxL5PNklGTXyvs2aS9DUmqLRNU6cygi/k7Tp/NYJq2IRkQ8ex0C
X-Gm-Gg: AZFdTZeEPkafuE+IPr6u2YwnrQ7YvAS6K07q+UokPpZ1aBksk/7QHCbFrnlooK8W2k+
	dB0+WHajt4I94BNh0DqYu0NqgL5BeqcZZ6pvmrpWYewuvwXevslLTbruHAs3Ap3YWnsumWTFkPS
	CZ8DYKnJHfo+0q/nvYjL2x+YcV5dks1IRIUs5jUlRngl5p2wJc80s+afAleJn6NUqwjQ8vTduQR
	Be7e2Iwrwj3Nd2QKW1kGi0dTxqDeuYo4uXfl7vOGu0sXAGEgFv/uedKcU4u8oz4VDsw6ibsgPBT
	8JZtl3R4Rj4uN7biOn1Vh15BEHren0m8IdrUcTt45afob6FP2IR67Vgw7QMpACT5EhGNHdEHd7e
	hsWDRqX765QGmvDoyh66ifecjy6TfSrtvXw2qnhXg7a7KBBG3XScLUqK/VGp4HTFrethlu/Bb1Y
	KQe3D+mAskicm8BEI5Prnk1CfOvO9+BOLCrgvIeD03DG2HD4wmPon2OPLg56ib2Gu2qaPq5YmnJ
	BtuHWYD3OJqpNXcEzCn+PN2r+5/XdLpLCzNO1ly+kIv0DkH6XkxV2xahNNlZsW+SVZwNtGNTEf/
	6XQbHLh3dB3wdvaYGrkD8xqS+kWlWqU=
X-Received: by 2002:a17:90b:4fc6:b0:3ac:b867:81df with SMTP id 98e67ed59e1d1-3b3d07a38f8mr5227675a91.39.1795070985048;
        Wed, 18 Nov 2026 22:49:45 -0800 (PST)
Received: from [10.222.0.188] ([59.20.222.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40543eda7sm1159723a91.0.2026.11.18.22.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 22:49:44 -0800 (PST)
Message-ID: <088f8590-0ee5-41e8-9a2c-48566d6ced82@gmail.com>
Date: Thu, 19 Nov 2026 15:49:39 +0900
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
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150121.603863898@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 11:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Hi, Greg:


6.18.65-rc1 successfully built and booted in my system but a dmesg
regression was found that was not observed in 6.18.64-rc1.

[    0.000000] Linux version 6.18.65-rc1-900-myllvm+
(user1@gentoo-zenbook) (clang version 23.1.6, LLD 23.1.6) #1 SMP
PREEMPT_DYNAMIC Thu Nov 19 15:35:28 KST 2026
[    3.060808] genirq: Setting trigger mode 3 for irq 87 failed
(amd_gpio_irq_set_type+0x0/0x180)

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin
