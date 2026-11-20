Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164311;
	b=FoMjerHr9W3L44E42Ev32y/6au1IQsPqz2jMNIV+xI5y6C1ekBnGnPNt1JJXM4TQ1+H2
	 DoFYbuB1qU2bNceXEHzbnz4en4R7+7kIiGj0HBq9/JG4P8cljdoIJb6KzmM0yNnzd4BWY
	 f7rVAdf4KISNWQRFTfuEAiQTSwpJXZFnneUGRFWrrTtAoUiYrx44I0uqsFTkn/VYg9BO6
	 5z1JcJo7SJzJkeIQnaZv4Z9Dn6lbIg6+lDszUmuNhObiqyvdKUaBYsj9PO5SU1GCetjKz
	 cS6tGEjVRfYn4Bm9adQ79G8V87xehH/jo6Aqyn7eRjHS5+uwWej95xg8fk+N3KCKyQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sCqnY8v5CI6MdsdAysAACdNLL0d1psytcPbpLVmifrw=;
	b=CemA42Hy80QMZ9P+47/TAgd5EDdY901Kf9f+AScMlSUyQ7V4NN2ChQZHpF35fbuOplC3
	 u/tAXTDthM01DCn1OKSe/j6X0HUMxuAnWKYF0oKiUrWd7n5CLF3aR+JGZG94aIGJ32aY/
	 EYvBDihBC5typBah5bcUBK5K1uzhbTsu+F96TYxmLnV3PiRZ14duRV9kBMIOv012FaoL1
	 qviX/hMXqQwcXKBhEexQEuzafU0HIInekJ7c0NA6e4dnfazSFSJL6HmZlDedLId3jE123
	 +LbnCwFl6GUKBX4/Ug3XE9m4GVe3gA8Usj8BapynLpGiqRbkIRFCg/+qJhMFFcCdteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWoNqd4f;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006C606A7F5
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E006C606A7F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWoNqd4f
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso356023a91.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164310; x=1795769110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCqnY8v5CI6MdsdAysAACdNLL0d1psytcPbpLVmifrw=;
        b=qWoNqd4fJn9RSajGzyE7A2zlx6ns2ZY/bJeicScAsDGEBtuNXIEf5LAKiaypWUCwmM
         /fICDf1m9LIGUvxDIzqXMg4XoJV3IrYTSDNLANJ21Trti0hnxK/fEo/Yy/tFhHI7M6E8
         9/yIVInbJ7RMp2K6B/DN302WqPTivLDbI+MFOrhxzp32VOSgU8dlGONCMSzXnwm1vUDy
         tXGwVQdtobkFZRMqZHvZkIiFtGzk68isP1CBgLPv3jD39euDqU/pdsWyIYkUCXEm1cIt
         58KEnOHX+vwBvx9X33RFTstyHC4k4Aqan0TaXGXA7DLjDqWtglGcspxJn0u50TKFXplw
         PSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164310; x=1795769110;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCqnY8v5CI6MdsdAysAACdNLL0d1psytcPbpLVmifrw=;
        b=KG4j63CVoFaivSFvEuZrMmNi9LB1hAOUnAZwt/zxxb3/gRXyA3Mqu6Gps29Zt0r3jq
         fw0da1PRJvRmMmyAHn4bZe5/G0TurSZmnOsemVROLIJT5Ve3v2f69p0Y4iD5Y822tgH4
         2c1XtOM66qJ6NR+eKpIXUp/k79GAwufZa925XzYoIIZ963093Htt36aJ4GPcI3+WGb6M
         SiOVp3NJQVZCAl8BuVtP9qZkx5s5A7Riyq8oCv3bDFYP+dHWevcEDaa0iE1P0+tL3MM3
         CyeXpSL/bmyWd63KY1mlUBvGRamV3+6YMGJ/4Ufo+WDez+TTeJ1sf8yRgadQkI2aSk6J
         IEqw==
X-Forwarded-Encrypted: i=1; AL+hErFAyr4e2hBiGcGgYhQFq/zMHph96gjkj29S0UCre7TXSItYxZKmZE1s9nGKK2GxkH527kdl0UA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MmS6IYRrZ7FsMlIkyhnw77t/BXsuvCqTxoGSLCN1aZ168p8yR
	39bAN2+TUS/LLfyVLIoIanlqTpV+9vZD1Tud/iJlV4qFKBSiLiYMpElY
X-Gm-Gg: AZFdTZdRuk249BxklsxI/K1oVavkHq4JOWOCn1rkIBmj9M+UPwuJ8JkzFAkmDvRSY0W
	sL+ZCS2XfVjXglA+tnWA2MvMmGxxT6ZclcPOTFIgrVkjGFXe9fKW8TbQhDjX41AEKO99DC90fnZ
	uSpiW7in8ZjThFtQtjoW+ISa3qBF4Pl9IAWB+7Zn8lsOm0cUoOa/cAWf+RPWtGl0PdnXX3MIEar
	AQZxty9Of8rQX8Fzri2dZlKRHzgqW3wRFhVzLIaRYOBQA1bw3hnEt7r+v+8fVFDg401vRS4/uC3
	ryT8DX3zC99IgJLTMd9+/73YmYceRaErPnpGw6bb2I4AdojfW1l1C2vOvXrT4qtECTh/IQpzJtp
	bTGWH9jGlpfaj3YJ5GXVuVmadLNQeEJY00La74NNPymP4zYF8TcbR2p5LKsu2h3Gpy2UtebXG0+
	AvCT2hCcbjSrwHXtvIYMubJqoeaHPT+X6KRi0Oa6fCUYWw0hXmv0Wh9ZycmyQgcxR1i1FPnnNjJ
	NVR0QdgvwrzLw4u2dAXfz0o/F/JlOXoJDVyrHOkqZ1tsk4oKZK3EhLNPziTi7dk+fjrfQignRCR
	JnuyMwy9qMiwUOMZ6LTW5YP5At4RuQ==
X-Received: by 2002:a17:90a:e705:b0:3ab:1b1c:8a70 with SMTP id 98e67ed59e1d1-3b41c938d83mr1968763a91.38.1795164310099;
        Fri, 20 Nov 2026 00:45:10 -0800 (PST)
Received: from [10.222.1.82] ([59.20.222.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm3376049a91.13.2026.11.20.00.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 00:45:09 -0800 (PST)
Message-ID: <e0df1ec0-d6cc-4c5c-868f-cd490d252e9a@gmail.com>
Date: Fri, 20 Nov 2026 17:45:05 +0900
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
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055248.913352689@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 2:58 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2642 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Hi, Greg:

7.3.6-rc2 successfully built and booted in my system without any notable
regressions.

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 7.3.6-rc2-myllvm (user1@gentoo-zenbook)
(clang version 23.1.6, LLD 23.1.6) #1 SMP PREEMPT_DYNAMIC Fri Nov 20
17:29:11 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin
