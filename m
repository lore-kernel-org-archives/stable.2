Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B4481AAE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012713; cv=none; b=XPKBkmcSht5zKDWbpAB/GAZvNv8vRPwKqGJYjv+lbPWydWB5kkbzY70Xdu0+9GTm2e6Itu3rCavRux0rdDqSKvK90Bs3+Cn/tw1I5ou7vjV3Z06YqoXtPJkkdxv48nFEGMRxH3IVoJDThs2BUlYL/cWWHjFVBiCGB0HXS1au1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012713; c=relaxed/simple;
	bh=Y0DvBWI+BZCsUB8TIe1s5HesTMuUsn2dMO58K2fiaZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfnFhDuwQYMZAu/Yon6RsgdlipikgwSonfbz8kPZH+/geWTxzcoxQd/9XmlNFl0UAt1gb5VvHqjMkIjl8dNLVvs3elxAvZcem8kf+CX2e2eDWFYQ3IzUvVAJu+9vpHvpdM93FxZQ82MVEwxUh7kbw6oeXcuwe19nMKbzGbw4op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/+LZHC0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/+LZHC0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e706a6ba9so588432385a.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012711; x=1792617511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQvRlCYoMMgwjA+XyVsNGaS2zRGK6+FIJmhvRdNh+DU=;
        b=b/+LZHC0andF8UMOaAYZITI6ULxKECm3d0ncnJY0PsMLG5bjYzAj4z0gEP7t0Qz+kz
         FXIpjN6k5hiKbAiR1zT+zkRLQL9yFQRsz6y6Z6lifdWy2EMCA7P7nlD18xkuWMW5lf7y
         PnCts1jCvB0FDIwisiYjWDCmTN7Kvj283Xw8WR4mhYJ48B7fcR5XC+nTUlxCPYAMN+wB
         MNXdFs7SQvQVz3OQxNl2c4yZBm5FPJ4gYvhZcy3XR3vukMTcezeUAgpy6UpzNE6OJWU7
         JeVA8hwk1SyyyANxd2rC/9O5vc3nhnZtbobimBmX/Yk0Ma96Bp3qU838Q+opEjq36PDH
         /N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012711; x=1792617511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQvRlCYoMMgwjA+XyVsNGaS2zRGK6+FIJmhvRdNh+DU=;
        b=05v4TFXtj6rNAsjB/rBc+E6RZCxX26sM7UDHxZT9FLKY9lJXSbDqTrFTgslBt6VK8S
         kXMGJ2OJwKbDXwyt1Z11dUMzPl1w1VIevW2HI9GrECdT8Nkk8aH9/H3yT+6Oo5QGh6Bk
         slX70dtLD3I9zir0CD5m0mThY32M/IBwnJwFHxFq0CIMDWOPe4ikajCa1qD/QrZ472lp
         lNDtk3ckuAmWGyG8STRjUcTED1N3tf4daDjvf01Hf4YYeim5o8ajcITiV5jjTA5UzrH+
         BE9H3TzStpis+FFmF8v9N4s0Vo6bAcrex5Ns5iJix4zseQh2uKN4oW2Jk5XVwbnkrEfX
         sgQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAoZE24ynuqELCYzZNrOOSKL7JlZ/6S3b9OnVnbj1ALF6opR6hTHeQmcjfvO/Q0trWHeqB6F8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIboSRHzz7IHbu7KJpvypcgasj17HcVZDAhiOZq0DdSDacW7T5x
	6PYZJNlnhnNS0qMllXSeJW7QB/zgj6VksTFl92z+iiK/R3IhGq09VqNv
X-Gm-Gg: AYBFou2cO7VTmT2rhwDmTOrwrNU+bXkdBMsRo3vmjrcLIlIvFJol2GLXxMAk/Dkrdzx
	vaZIVIStCeMC0wb+AcBAdOkeNTCLFGhW55byLZ3SblVtdo8JlJVTv8sy5iz4nxUaqdk+TgusZzw
	/idtyEPa5k353Vi+FO+V5U88g1iwTVcKwfxWZWzVVOBo4Nn2PVQHaxkBgBW95zr+Ez/zPz6AYDn
	xNbHvEi7ey2kM9depLcRYRx7igvBx6l9fzCgQGY4l2gVZi2mCElJBcHZlEWdqn+QYSF3ubNq0QI
	WAHDT2qY4ZEsyam7xOTo8t1NWwzZ54P/vvbD4E3f+ZL9jU8d0FxnsFrwpaj9EIBwx6QhsBD4gFQ
	aD06WvJUekp+ujZ4HGBy0rXVVeYWFBUKMIpFrgsMkunqZ6XfKun9l2c9IFyAPeSprjACbWJQu9y
	lscyc2jFhUdOYH7j5m4E4iB+YWczldRvSgJ+3BEBCB4csDcjnrc6uThhDgW+m/E9Soaaz2WuHOp
	Mr+9W92vdQku9Z5IFsiJ8ed
X-Received: by 2002:a05:620a:4552:b0:93e:5821:2c57 with SMTP id af79cd13be357-93ebd2244d7mr3063691685a.22.1792012710742;
        Wed, 14 Oct 2026 14:18:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5051c4csm601360685a.29.2026.10.14.14.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 14:18:30 -0700 (PDT)
Message-ID: <14d347be-4ac3-45e4-9b5f-9df2fedcf6dd@gmail.com>
Date: Wed, 14 Oct 2026 14:18:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/632] 6.18.57-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261014123820.008483134@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261014123820.008483134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 05:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.57 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Oct 2026 12:37:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.57-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
