Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1B3750CB
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315305; cv=none; b=Fpn2kCEgpBIekjdy2gxpuHJZ35mU2BH+uWGBPrIHlIbFNR37LfTOtY7VmaeQYJINUv0xYr2JuDYma8cvcUtNduEKUHO7Id2JvVI6kud73jkLqqjXEMH90T1rAJrw+qzy0080J6Ul5tUkBszfLfSHgQbkbCrIFFx+5asNT6k8M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315305; c=relaxed/simple;
	bh=8rwDxA0XSOwvaBmFjlbE4Je5DPFd6kCu56rmVbuWb4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDD8w2sQEmXCwrzPhZq1kgULr6wAQ4gHYORXxVMzjFvpt+poAxRzos6T75muIBaNvEs1TVwdZmPTgWrCE35W5kCUh9VVkndLDDX8bqdvMNEBo96FFOXu9iCNGCoUf26BZ6DRP6NolROeeOj5Uu+uIBBYGtVFAn1PUzXOujL3bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEDdyPQ5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEDdyPQ5"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e08baf860so5781530a91.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315303; x=1784920103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtNKtp784jLI3cfxFkoMon75bDpNr5z9iWtT6MawmxQ=;
        b=IEDdyPQ5z8hoRDJrLn46zWfhvoI4NAPf7WH1lxH4mWB4nag//U1RoTNWrBBx3igpNt
         wk0H5PwKpLzCiBxIZ0jAfnUJQHBEflCN1+XnqKbfm4ZzYj3kW3yJwuP9/9Scs+oJShpp
         mWkoOJQHaYtKCPPzoT1RFaljnwJS1nES5oP6Nz2ij+m6NABDTac8ZFgem67uZUOIBK4O
         m0rO0vGF2G9nEe0QmVtTzR7/HvhghpuuvkixlcZBf0YdjWfuGpTaIeKWMraNS5zq+27U
         f/oL4/JDmYVV9f1NgUX2rdXzUHYPRycu9vmeXwv7Oz4pCq2eTl59jnBCAjCrlvODEffL
         Qawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315303; x=1784920103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtNKtp784jLI3cfxFkoMon75bDpNr5z9iWtT6MawmxQ=;
        b=gVDL+TtFOAxqI3Hg7GPwUyFytXTppIHvEmvMWEJFH5AWdu7cRKGnLMbRFaBYt9UJuW
         BqIc34SAoDLXw1DM525Ogc7OvhJoK4cktjzmBhIMiVQZla2uPvc3y3CyTSmf+ovYpiB/
         gcdEIEoEQ12MaTkfpLLuxNFqTEVXlSKQKkPSJIkd8bBQ7QESbWz4LBV5MRo9jLuLWT5c
         jpGfN+05XSDWS1xdZoqQH1UVea4GVIlSWtjrwn96w2IzXaVB8aBkQdDYdovW+pSRjyrU
         wfcdJUSurfXZmpdBpbBnlFAi4QzreQjcfS4Ef3XhVBSXDzq5UXPxxe2Lm/N/SQ+FHeoQ
         bkWA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4dicVPhdkawXHPv52zd9Xl7bjtNk+BKK+/pqxsrKe4LZdWdnhQflCyu+N2TTYhRTxPn+EW38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZS5cQ+7pVcllJWB4lP1XUPj1rm3gD8RzzQKfAlkPsauABYz0Z
	5e1bjH+WW03LSYB0l1UEIdk2YjN0Mn9g0Cin2RyUHl0nKwlsQE7un6v9
X-Gm-Gg: AfdE7cmGooRfCryJwTsbgcycuc+FPPPhB6ksNIWTrY5JUWmHjo0MaNHRHd16Hz48Jg/
	S9O4iKoFICCYgDYEJBRpBs857dHyYqrGnhNIvl5WGCuteHIn8QO0Sc8ix9+Wlb9eyECitKqpdcy
	IC0rGAJ+RF+Nt7z13T/IKu2sv3SNjHbZpiDjKUeMvyWwuwy4G/xzpZG2PG/z/UedNWXrZhPym4y
	mJNmwWGFYbBXNkm4c68lM8N1QPCL0gF6Kss4Fyi8wQHu+5FQ29dtk4KZP55yHUYBo4Ib1wBKA7N
	Dzir34tBMYNjwTQ/1dhvZLWIgx73xxpc4Kg6CXw8gmcr3HJD2o8jFcj122oth60OIqXZVyOh2dC
	YbIGr16TmGa91GbisTp00zY+0xsu3rG7du54U2Hr9PzLkyDJ8Ct0FqlsUsoVI/7Tiq7fl/vQlTO
	9uw3wc3/WD0v7zo1h7Ug6Ii1EjiNZC
X-Received: by 2002:a17:90b:3ccd:b0:38e:11ba:992e with SMTP id 98e67ed59e1d1-38e4b57dd07mr3819471a91.35.1784315303098;
        Fri, 17 Jul 2026 12:08:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bb62sm9209012eec.2.2026.07.17.12.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 12:08:22 -0700 (PDT)
Message-ID: <a230a463-a9d4-49fa-878c-a2117965a748@gmail.com>
Date: Fri, 17 Jul 2026 12:08:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/495] 6.18.39-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260717101904.922623678@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260717101904.922623678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 03:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.39 release.
> There are 495 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Jul 2026 10:18:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.39-rc2.gz
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
