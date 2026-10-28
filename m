Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220211;
	b=Mru2UntJ4Hvl8LOoFqfYd48NIlYx+uvGgCh5TE4oCNohyFWTSa+AeSyIussULyjcmJzP
	 ym4m48Z5flc6kgY50X/2UANMX9WyTa9VkEG4JSQhaDXeg7l5tHI8XZOqEqlML4Pais6JH
	 +tllqJEWNzOHIhznKHPc0hobZtFYBU/rFIRFHjirqBRi/x7IdcgxZHuskmJrv20f7dlE2
	 GBZRLD68M6e2f+2gj3G560moHSMZWdMLyXqsHBynjs+HGIuUvHSI4GTMTCNv82zkvnzM9
	 DQ3yzKd5YUvw1ndsz+Rk4HDpoFSUfLmeib1fUJjz3QAdcaPPCQeLZ6AVP9ATE9fW+LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+Knq+SFx3pxVCNywq9r2730akCFH+DH4I66drqpj7+c=;
	b=f2YekcawEJmqY8ZeNoxGorjl68opQd80T4cf0jg0XgSM+lUViEHU3FSk88dhxZ9fLhIe
	 KeckRptYv3gIMPt8Uc/itNQfVnxr3PNV1BgAx2o3eK87YHA2FQ9WGiI1kLKjNs7uA7Xvb
	 a8U0yK6dRX658dD9cvvqYREsjlK6QPqOVGMyW1ZFYiy9HRS1jmgDdLPgXHe7wMFciJe6J
	 y84iaUcSGTYl+1dm6I8dIkbA5Sxzeu5haB6h+vZV2uZ3NK7F4Oa49kuqZ/jNt65g0dAB5
	 vVsCOXTMvfcWixDhzcjh5Gzw5XuYThRsB1nfki6j0Ut1I4JEnP95eIN2iriLcdTIKHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8Kuqc1e;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5F606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF5F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8Kuqc1e
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1660875a91.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793220210; x=1793825010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Knq+SFx3pxVCNywq9r2730akCFH+DH4I66drqpj7+c=;
        b=a8Kuqc1eLE3E9yn23c4DdCuufVsh/81buWsKxhRdissNPzDf/Dpjt3IQ4uKm7yNBVS
         RPsMNyPKv1Kp/gZVDmPPrYNPCuU635i69KB8fa5nUf5kL2ySGVmZAnacJ/AiZarq/TPv
         frIgaqt2KLHMudDc31qR60TLoQwt9bcz/TeyULii+G+X6tQF1AwrQ0HJ1doxEUX9QKyZ
         lkvvuEkBY5ZRY1wJNP7czfkQnET9S0CX4o3kHGEwnUfELK34uqkabBwwltFNc2k464i2
         GYUn12taERH0UzF2c6HvBJ0XXt7mTE4iTbOpy2XLizuZbr8VIsBPucJ2MwRhQfrs6YSm
         Urxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220210; x=1793825010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Knq+SFx3pxVCNywq9r2730akCFH+DH4I66drqpj7+c=;
        b=fZzB9CfIf2MHOviYat6s4hQ0MPh0k7/MRugCBMslLhhLyGSbdQDUqyxxvqhNIx2cma
         Z9MKfgiKPvaQ4bH0eUXGb9x4Km/Uglh9K3bbgesqgUSWnO54WSBM+xIdchz8UmFoRTS1
         RhVYL6r/MzP1eVdk0kmYMrMUHM4+8qlFs6AcUx/yUq1jTWr6VnatTmR6LARFCYZjfcv7
         X3GXD5RD/Ocr4dS09suPtvKoqa6dY0BbqGZWV96ovZ5CtfHqQuH+S/LeYgeUXYwjSKGY
         PgBLuEpp13HjX8vus18X8LJBg8J9AuITAC7tu9X5R2qj3LDt34SdAHP38DCaJnOrX7bW
         Awwg==
X-Forwarded-Encrypted: i=1; AKwUvByo1c0n6iNPRVZVL95q41ZMjhPoi3d8QOBi/3AOch5KLNkmHCBEd9bTDKjo8vOKTY1mRejs054=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZEkkKAidKuvpiudkmiB61B/h0kAwPC1JkD6RMsuYGfs450iBV
	So8TwCnLuIoHqCB3Xb904Sdwsr2nIvfAGQTcKp/B9Rdjii5kWNjNqmOp
X-Gm-Gg: AYBFou27khRvV73lWmLb/KgRmNawUTlZ6nmsRtAjvNFPaz+FbrpOS69SP22o3DabkMA
	Kf4W6LsJ9X74Z8jrIpjNwY6j74kIdsRzWPnSFHhhfJvf0oe2odEdtGoNK9uV6Z3MNsxETK6icvx
	Eo3RVJ6ITu1JQYrwGi25/EYlHN38au4SaCaPfdXEwwwpg4S6809P6jzWkoT0tRbIZVU+G7xg0eO
	TMWIj9YXFR55FgTT3MTHb0oemdwjV+nNGE/ai/GzIe9EN/VFubM2dud2OeMr9VBLPDaYpImh0f8
	e8M0Usqa8XLmpOCXeh37cvAik2hZfp8Qw9LJE80aTBSGfR+GH7HYa9GoMhuXfqDRU/gp/IxkITL
	AYTY++PegQnwC0rPvNYQMdqWdB9wCUMTL92Iprzmh4rQ3+ZXNSh5NuARE8XJHx31qu3bcyLDH8q
	1f9xfkW1uX+lOYkj97tzX7qALB0PbC4vsSKUTcqzeHF0nCOvyuKhuKo5DyBfVaEsh5dctgb3w5K
	klvheB+jZOHjg5JIZM1qnkB/oErIfmb5PNcInfNpC5d4JxhJjQcZnZ3OqY0iqrLkK/GT3eTjeuy
	hH1Bk3QhDfVmM0sFOpy+n7WFPD8GYRxm2T3se/yxw53gilwgoexEEiv7
X-Received: by 2002:a17:90b:1d44:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3ae57f638cbmr2422136a91.20.1793220210245;
        Wed, 28 Oct 2026 13:43:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e898317sm940454a91.16.2026.10.28.13.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 13:43:29 -0700 (PDT)
Message-ID: <7cec1e35-fbb9-4e9f-ab90-c81b7af10aa3@gmail.com>
Date: Wed, 28 Oct 2026 13:43:27 -0700
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
Subject: Re: [PATCH 5.15 000/571] 5.15.224-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028170008.009143722@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028170008.009143722@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.224 release.
> There are 571 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.224-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
