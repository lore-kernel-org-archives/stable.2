Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D934A6CD4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016015; cv=none; b=D/VUiSsZlz6IWuiqbEbO1sb82OYRl5jAoMuLSwK81M7F3grsTDX8T2ChJg2dCMLVL6Yt12THWQ64WRodtmQMC+0ric/UbS6zugCJ+YvAUoTsfcroQcgN2ZZNENBX4BPdw/aKyTbcelJc2iaRjm26VCP7a8ELy9OTf4H3M61r3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016015; c=relaxed/simple;
	bh=OJJLDBSVtpI8wz96AabglhUFLbr4QIfvWBzdT8ARCdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xftni2a44CG6Gwl9N6kLkIQ1M6OyU2OG6ru0rK9US9n1U3ZwdOnE4dN1EN3a414f01K7OCZ4Vp73u+Ed0VlYHHF959SGk7LcsEN5RNQmhyFf4wmzE3d1VwyRDKIbPOiu1mbER7S5cTs4yveHftJZRgOkFmT+2yGooy5/gy800PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+lj3t/l; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+lj3t/l"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4722146eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792016012; x=1792620812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxweolJrlHVj2MNzfSYncB6B+aQ1Kt9zKOvPMQbgcwo=;
        b=N+lj3t/lIENMHblKKnEzLHQtsFWe8h7GsS5lyghCxwvTrqMA5aOJlRLOh9ixLjubhV
         SDB9uy8p1ueUH4DPGJRwEorR3CrFL3kJbK9wqsynAgZxjjX3zGEPnkj0uN0YKhlW8dCK
         Z++yACGXvkeG89mdtBzT5y992fw3FKP/VGVnQH0zegWS2eXdhxkbD3wEaqiFp+zGLMbq
         /5VQPjwsE8jBHiT6Hm2W5GBOhwwPPj1NgEcSpgQPyGa0OrkhfZFYlpQKuQhqKv72NZv+
         7GoVVTN5o6qAwrGpWa7agutnOtdpTEBOS5toSe8YyiYT9ojaQ9d3newrdMX6lExMrE1G
         pegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016012; x=1792620812;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxweolJrlHVj2MNzfSYncB6B+aQ1Kt9zKOvPMQbgcwo=;
        b=NE+bko9tBB8ivHe0AZ8MVZhu/V2znxwVQ/85UeyrmHbbAfmo7HqZPstgFqHTor9qaw
         O2YHTLTu80Ap8jFX33gvyptZJlYEUJ6I+X1jhMQrYpxCVrnbVSrqdJ9L9c3u7AI2CjpI
         iogSMf9/A6QPM2EozAkPqaDsaMTNNZIibIO9cwRshKUVp4D1hwOlZCFZS3+xCwBy4FTS
         1JiiCVveb8TeaRFa/ayFkMSjG64dZddseMVGDkLUOJzpVkUyBA1J2S2SHPwv4A99yeqa
         Tblr9mqTFSAFxSzn8qaOWDv4QIwqIWe7icq+I3PVDvtjvc29yflTWJN/kxy3/rCRdFXU
         iG+A==
X-Forwarded-Encrypted: i=1; AKwUvByBnVCcLbb6YbOAgicS723RM+ZB2wIPIj/SzjYfu8BPmKGtlIF29FRpZOyAwhRs13MtmrwU6Ww=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSma0UIM1Y2XU/5caONR/PhK9feOKI1G2z6YEYS/3aaDFOTP88
	Z5RRkQ1AKE9BPZjkz9I4/z8gv+T5tRerujVaz0CK9RvgeceJa/c5/O7N
X-Gm-Gg: AYBFou3pRY/3CWkKlWBI2Q6wskqe+DCmd+z4DQFAjOaSq/wmfvhiedR+SPv1eKUhcni
	iUhdujzbMi5B5p2PBTW4PSidk+Fyr8KJnVa7BVglaU83tWNSPJOiAYkpMIL1AtfvRM6o8LvhJLa
	HPG5ZjMs5CXdDwusPlS5E1GW90XN2w43F4rVzC5rtDqWX7iW9WTWZfOkpy6HwNVNRiima05HXeX
	d8YavCF5/cy7TWuIJveuuySzdNXAJ2AuTBfaYvB26bUP/538Taq2McyuPIrxrUvlk0m6mdeGpMD
	6S3S7T8FlrRl9nRFgRhWoliJhOyfogRE7/XeMjA/oZbwrgbp2vA94BmvC/UnyEihMcGA+r2GwsC
	mnGf66Zv7d0XHalan1rgUD9X/wSQGXXy/Uk5/x+QbFMfBR/xUYxoQeUBIV37JyMXLXe+JGyWZrT
	1kX1MHcioOg2nIIRfp7FFGzUw9cGwFQgsZzDjilYEUPPCRL4Gu2gV7gn14atiD/ENKJnp0lAHwt
	uOmD/NbPmgWpqWyQ8sa9sSj
X-Received: by 2002:a05:701b:2713:b0:143:26cf:8615 with SMTP id a92af1059eb24-16a6169558fmr24799867c88.25.1792016012151;
        Wed, 14 Oct 2026 15:13:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a4429603sm47377549c88.17.2026.10.14.15.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 15:13:31 -0700 (PDT)
Message-ID: <08247c8e-3719-4c8e-9782-962c648d1c84@gmail.com>
Date: Wed, 14 Oct 2026 15:13:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/284] 7.2.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261014123758.782265692@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261014123758.782265692@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 05:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 284 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Oct 2026 12:37:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
