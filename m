Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2C440A19
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075777; cv=none; b=C/K8ArEgaPH4R9VdKoP0/cRJiz4rqGf7wFUgKC2tzSYSBgiSRyXIkm788P5SJaXJZR+neqnWgEZtDD1l3fI0lICCSRMqteohVszDFvcVHhoekfgMuzFj7vpKT02gKOy18kkmmkQOVD2JQXSCB42dJ/fmJvwVxBcQ0KwHqpLWUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075777; c=relaxed/simple;
	bh=M3DVfwU/m0JULqch2OXrqQDoIktVGSlWi85bz3z9oSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuBLohPP5tGhz3sRFwDTbPwP/v9Y1bbkL3YHBnjBbm/+UzKnMGiNIOK/V81QFH4eT874VSRLiMidaDnbOsuWR04a6Uon3Hc1/oze68DkuY6RODko/HVl2l6O2izgmOd/YhhSsfWQaa9z7SPZdMAZ8U3shOtTpt5lm5zsBfKedbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5G605lj; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5G605lj"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b5737bb2so126100a34.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787075774; x=1787680574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=889CWzIwcDqm1G8XCqrv2SBVsVdxaQlsOgfoPJyky4c=;
        b=F5G605ljp1aDs2DyGopemMd3T95IxyrRaOLPgBmzUtMTJR0F/K9SNCJOeb/rM6xQx7
         ab88AnLUQVNyLybsL0AC1MQDTQF8o6/ocStAO4lREjtfWvTaSjMPxQ4EzufhwFRxHjWO
         ZtowzLDGodgKDvyw49mpFg2Y3cKdXHOxtMwiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075774; x=1787680574;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=889CWzIwcDqm1G8XCqrv2SBVsVdxaQlsOgfoPJyky4c=;
        b=cA0iKD0dMV/gK5N2iCbbIZlkpL5qsQHZOjK5AN87oa0bdMyorz3QAJa4XkfVo9Ht/k
         U48GmJ2+N9QE7nIWiN5k1ZDDxrRUZZu1X3t/NX5liixbuEZ01PkN/KonWJWVwr2P68Km
         hVe3EriRUcSSTcM+aNjZPRsNRV8SD2VfKiq39XcMeB056JkyMf/pjbXwkR3k4KXPmOTd
         1xqJgGJtDtZzhaknIFnFRKvGpjV3j++Di+Q+pwbeqq47ktQ/pNTnP5OCn7zngIit75kJ
         0NZ3eqyGclLTBam5XtbKPb80vOrhkAWJNP2cWzp/z6pjBL1nIEFD5PgP9h8qkxMAfk1J
         J4aw==
X-Forwarded-Encrypted: i=1; AHgh+Rp17p2JdSwq/uUsg0C3k0/wYRzNi7ou+v2V1EUJ9kq0BpJov1+K7GyGyMIa2awv167W9ueS77o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxIBhLl7PAZ/7L/bCyD55tKNLDOwaBr5NlxIvKQRqNCoY+9Ih
	lHTiJ7QOpt3RUnmxWpaHT1UPtY+QD4UOeJoX2DgO3Htl5cS0sX7QazcXvt1kcEn1ssk=
X-Gm-Gg: AR+sD12k3+XSrp6FgjWCo+NWW81R2jtiZ1eiWhtVx+Y3dQGfF7vL4JWmVXwKycOBVfc
	T/RpR/IpxPzRNHdaVtEWK+YvziY12J6QZNkKPylTn7lYyO2ro09R1i73buegrWM7HKsZmXKg7/4
	xWpvNlLVhFcFjhBidQvYEVS8TamJwbRmk9d9hekEctUbV4REQGdYh5xIPM4xqZVivc/Pe0QhSgE
	dAp26r1/JwYFxGjPRDUnSpiidjKxzsVwJveFp3UqEt0g56mtAIK8cM5gcaHirCAXAKa36z+Eu8o
	EY8FSYOxzZp71mU9tL0aEW+TcVRbPOXMV4JChjfnzhWTBoNrzqYJY6sLYmfqnwWEZ5u39g4LDOC
	Wvhj8zs2oaAtAYDePEEnaSvng57z+fvmcEh9qVG2OjQFYhS8ySaD86aqUwvs6cFAOxWR3L6C5ZP
	XWjwAqp9untiKs2co0VJ74JqSJt+feATD05e41QZvgLWJjK+ht8n2aCuAcrQOegXeGIs69Lg==
X-Received: by 2002:a05:6830:63cc:b0:7e6:f7fb:9678 with SMTP id 46e09a7af769-7f423c38469mr10395776a34.1.1787075773922;
        Tue, 18 Aug 2026 10:56:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41bf2cc6dsm4804215a34.10.2026.08.18.10.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:56:13 -0700 (PDT)
Message-ID: <3c4f5e88-538c-47a5-8817-d222adbaab31@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:56:10 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132543.039278408@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132543.039278408@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:24, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


