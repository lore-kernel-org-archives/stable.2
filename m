Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BB37F32F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995127; cv=none; b=fnO7UQhNT56YYa9RMGtEFkdJOgGA5WIXWEe+dT7zgTAGYWozE3SCFbeAz5cMVKaoNuuGtuX04z18I5DP24HMkSx+4WnRfUe66h1u+ZK6ATepPhQtSfqz7Vg5VYE1IM25O2rqApNvr5berV80TjrIhfh6W+vQxrlQUSO5cRf6Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995127; c=relaxed/simple;
	bh=oy8Pf03Xb3bKzV+tVAHn1SinHESgGLHQl0i4z6bB+PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD25ZN9ncctk9l/0nP36C9Xijidq/crBYmt+NIKDxn2ZjbuBZseEVzMJ2LqGgkUTLfPHJZbTntdzcSRefjHuAVJPlGviSmqhqPDfGyeyBpCfUJq8O7Zcn6VQ4akHISQ8vp6M6SxOvmwL2C09ecXIrorEbYV7bdXyJ+H6Hxq+tWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9kWJiod; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9kWJiod"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so16844395ad.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786995125; x=1787599925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wBt9xLi/VKDutjFxVI3PLjtL7dpb/PtctWy5h6/1Kw=;
        b=i9kWJiodgHBiBWeEl96Lru6UMmifWVgTEvttg81jF4Ro7qHsYDbARns5luNFlR4MLl
         q/KbwB0tdujmAjaRQRGBTLYcB/EhvJ2w/P7rCtyH8qDg+EVAG/uDBOpUX4jOVJ9LHDXM
         1Po1XSeRKCZ5Q05QHIedpWgFWN6MP5ieGsizmBOAaUG8VZWqEkJGooxhJJAU7NWQR8ww
         Tq68vALt6PmGCCkZgGoJA8vgfbSXvb3t8z/sk13AhsyR9WuPfoHDit/0XUVxVsWXHCYu
         o7j7/208//0zBJiADEJRm/ZmMpe4pSda+rqeIB8Vbfq/JxZqBQHHrmzjaNqJzv0xFGz/
         5g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995125; x=1787599925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wBt9xLi/VKDutjFxVI3PLjtL7dpb/PtctWy5h6/1Kw=;
        b=HNMjUoe8aFOCGlOgDlldnI/ctacZvpUXcceazRqw0aY4nXsvu25HrYSGMeouCmLaFd
         y2rlOXHLIUVtjMpreMtWzNT9oP3deeO051L2Bb5oZnv6TKp2+6ju9y2nV3X2I0P5r2Wo
         CWAgKd5Y4YCX4tmd9oL42KKTJ4VPByQiZbkqUQ7YWSqX7iPh26oAHiu3rBBoS7vpntCp
         04Pb2Z/ZcO52T6sDiwOQXt1AGk98CKEWWJhXMntKcEzp2mpx7xt2hcSEOSwq+c7QwCod
         2WjZrtBnQnGalkt4T3fJOD4xMck5PaWQby7D154sxM0UwD+wa9fZTWsdZ7QBe7tFYDFV
         xA5A==
X-Forwarded-Encrypted: i=1; AHgh+RogsC/KxNwO/mAYeZ4WzbBvWqWXVYJW2FnqoCBQIGIDlDLHqhOO2oT+2Udvm+u3yP1otU4p75g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFY/sFi6OvwZioc27UF4UGG3KiG+iIcaI3tmP2j1IqwEyvxG3t
	daCzNnQdygEnwkJ09IKdblD1255q85hWyVW6CWGFfYobqKr4GIKciOsm
X-Gm-Gg: AR+sD116Fq/JasHcz2YjBHBp9qd8IdIVixIz9qsZMXUoSlWq0wdzMR04ez9I7T8QFnY
	v/4k2sYJmWBD4wKqDxLbSrW6Ihxj7n3a+Ft1tlW5nxCH5X6mgXEwPNVazFIPJUdyIYZdSFK4LD6
	dIOus7G25+jsiggzOuUvS+obxXzoLuZelMI7DEqCULJssr3Drx+uvyvTSWMH0yFFpf+AElXCCGT
	Am3bprvEVNrHPw9JC44NGLeZn/0xbBQGnz4nzohLBMMwxBhCVbKoiFQIlMvoU9lJcQ0WIb8eNoT
	8jcFw09sitgyVsx5+ajPzmbU00FWAUFFIpegh1hea8OEL++iGg4tpLtl6PqLRgSxDWAEH6FmhXt
	Ds58asDypK0Gm45PMQA8pI+Zvon0/geKFaAn6lugaSWfUCsKT8GCDyDA7pragkBDPIaaKKi04fQ
	9f69zbrQb3PWBL3TgM3DGkAyFEesgTM2KbEAvyVLghpHdUnklTqoHeshbHyIGZ0fC/J9S4hGV/E
	36POzp2zB+33XM=
X-Received: by 2002:a05:6a20:6f8a:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3cc71e5c82amr33662410637.16.1786995125386;
        Mon, 17 Aug 2026 12:32:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c8972d2sm7469283eec.29.2026.08.17.12.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 12:32:04 -0700 (PDT)
Message-ID: <2e6b9933-0cd3-4eaa-ad0d-f1a71875e7bc@gmail.com>
Date: Mon, 17 Aug 2026 12:32:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/609] 6.1.183-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132543.039278408@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132543.039278408@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.183 release.
> There are 609 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.183-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
