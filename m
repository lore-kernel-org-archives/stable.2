Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAD31195B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146399; cv=none; b=CS+BEJxdC9C6sgOzVhf5n/B73GDmvdo1NCYEi33b5boUiT44tdN/CszNg0irDTZgZTWhuOXCH3o+fB6gwlitO6SFdoZFNdX+0p9xGvt+WdnSLnBrxPGoPo4wyxzOYVhaT7PXFzWFd8KFd8NRq6Y0ZmGteQFlvaEEEDJRu+4Uqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146399; c=relaxed/simple;
	bh=5+tDMdsJThIYK3BfVinjMIZ2VhLWEN5NWD5f7yUPuRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DZn4Ia+yMreYTl/aGP5GcaBr1HpXMglvtYsDy65mygqDArzLoFxBGK05qXBUIIHuY37n2xBuC1SDP01ofjfdgbk3EpBzfJX/fA3LcukZ6VRffqTq6NH63swtwMWVFDJKs/15cutGhYcGfvPC9KY3Q7DvBl0BkUr+g7SUbExNZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwsUFI2m; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwsUFI2m"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso1046694a12.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782146397; x=1782751197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+UiOBa/IqtfWsMn+EdSXuBzHGb6PpRZ4HutiV+njy7k=;
        b=FwsUFI2mgRtQnzd0+RATWJK4GwQup5QD6NuqGlCX2wMMSxy+0rTDPxCjhLQjBMm67B
         HALzgN3gQ/Sqm2AGwEgR4cmJqNkWJhNnGr2rwiLG33wI0nQS0MlQYRJp+AspZxOZ1gdZ
         IN3QXzxPpQMuNS48MiAKvKdx9NsYiImIsQvRxnCql6plW7oGfq6DYTQZ80WeI01J4woQ
         SNM0en5FGq/b4fSZ5zqbpc2Afwf5udd5OoKg8MiPyo6kI36rjuloIkMMgKV6saiXgr55
         sK6OD6H2oF2qvqKwaztwBvStd6c8Zse5wxcZfVSEeisnOAlZ+VdeSiR83t5hFdzZl3sY
         IpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146397; x=1782751197;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UiOBa/IqtfWsMn+EdSXuBzHGb6PpRZ4HutiV+njy7k=;
        b=bIt9PD4+SyHmRu/+xMESJlUUFiZCi/ROX73kAiYLq35JBKiJEP+l37zVZZ6N5klZA2
         tv29f/zTKeyewyh4IT8ncwwGQRXlv8UHNyMCde+rZtSuRKN2jFOjnWXYVF7t/BDbpqiA
         KNJO/843VISsYNcPOKlrpOaU/Ew4ZNEq1g6U1L0tk9DZYoHK3sY4gDKJMNC0ZeOrRLvI
         +VBtpkPA4QZNlnTxucPKwYbFcsXiW35Idb1+hpWqLg2u6eF6hbjalI0etsi5HCzT0Jmp
         0CihCT6tJ6TERhRksFU/zLPB0192IivdRm1k4zel7LG7DEIWEk/bOI6wuRdTMb+fMslX
         /8WA==
X-Forwarded-Encrypted: i=1; AFNElJ+Fy80unFOvbqYQvL+5KwMGmVkvCYo6zvJJcUIsFw6cH7dTAWVk91QPyBBOlP6RyPg8ODH9jtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBAsFpLkAYyAEB0kC/gF7yvPI52N4M+EFvOmK2XDt/R5dNKIx
	a1F/6jqS4Q810+74DFNKX8GxrBj7KcS/iHc6X91r10SsNTmVFyhLk0TP
X-Gm-Gg: AfdE7cl1Y+HREzvywR+e5SOH2sigCfNOVsyf2y5+Mz4t2n6I18N7ayeambvcmKfB5VT
	mAyJoOOhrNwZpPXRAZJe6IoH8hiW/PX03aab9onA/XeJf2XIdwOaU7IM9PxqDDQR/DfkdHVKYY4
	SDtJamZsGhQ+U8s11CikFKRujw5fosactMdrTklvwS+auxVMF3R5Iwd2/t/iphXyQVrH7GQ42ah
	F6oxubdZmryPGUCRzv6PIGuJF2qUoa5LeCOXZvyu8kHO05mhmfUB+uaOZdu/A6wCWIo8ZWwf5Fb
	h6I02YH4g0/aLcWJL3K26G0wS+qEyiUFvJqNTXK2AKdILOPcK3B9UvOhzslf43kBD3GK5u/N6B2
	O3MfcL2bOFB8Dn8yLD8pA4NXdc1o0odL+Edriu9TC1AYtNohtzgOEDG+B1NXni/u2JI8UtKXgA1
	eQ/W5QD6PtUhWsFYVeSl3L9H0LvG30Hg==
X-Received: by 2002:a17:907:26c6:b0:bea:5ce6:4267 with SMTP id a640c23a62f3a-c0b74a83ebemr698183966b.35.1782146396793;
        Mon, 22 Jun 2026 09:39:56 -0700 (PDT)
Received: from [10.178.4.71] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60bc01d2sm379776166b.31.2026.06.22.09.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 09:39:55 -0700 (PDT)
Message-ID: <ae8667b4-8bff-428f-a725-44f3d1fb8d8b@gmail.com>
Date: Mon, 22 Jun 2026 17:39:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145523.335696673@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/2026 7:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:55:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

