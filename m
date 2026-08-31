Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5C4A3D31
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200475; cv=none; b=lwu2BNTeGzpppawMEQPR8mMsYYGKcxJIVz6ewMFRFFAmqglQPE8Bcc6yeajxFNcFdyilnXy/0J1PIYaaPm3PhndMAas7cSKuTNtINyT2v5uNry6rwpORqlf7CwQ2CpMVHJ4LSb6HuQrSuKoUIYFbbJYsEq55cJWoak3nGYEAK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200475; c=relaxed/simple;
	bh=CTe7x0uus5Jyh61aGiyKsb0esjA18qPPL2GDz+sMqHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDwGAi0KTQAzhnNFE6JvdwQzvIOSxbdc13UtI4M9F9RiYRyxlUfhjehKqJOeGNCzQqWnNlWgqMKaC7P360F/hYUfJ4nGsO5Ymj9O4u/GUtjTmxFiswsaujea+jUzGZJO0DOn4+porYnOj2AwCeqkyFPbKfag74eb15TyquCL1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu7OG3Em; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu7OG3Em"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3907416a91.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788200473; x=1788805273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C8d9Mw5d8wycdXLHEiB7Z81VhrXXtSb8zZr7GQsQHI=;
        b=Bu7OG3EmLNxUgEc1ZAZ6Yz2G2lLiJvtGbQUEDiSYmYsEALwOVeJvPB7P7Hd7NuSEDz
         Tp0K9BMdmEXFeFL2qQzk9RCGyd43cy7PhiIsc8VX157NobeVrmgytmAsFdRg45F9UOzk
         FNfQbTRSIA6BL8LF4a1BunrrST8gwwSlgejZnhQAtqXTZejhOfzVJwD28VcZkd70YCLp
         CFNIuonkqjagzKj4BJIkKb7cRd74+mSU4op+XFYENlQncCgPmvm4SAIn2HTzD4bmoaCn
         DoTMjAXbmwSBSsxrGSYfTMMB6hjHUFLN2kpNU4o6y6vQyXMDhZqwiBnnfZY/nazB6JQg
         xnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200473; x=1788805273;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2C8d9Mw5d8wycdXLHEiB7Z81VhrXXtSb8zZr7GQsQHI=;
        b=Qqf62GRWokSSD+6Q8r+yM4XSR3J0eUZuWYUKLfRimTlmwfhkE4fEw/gzC49ZzVvPmG
         jFBI63/cfzryMWqeiR/aQ1u/BFGyKgJ0cIh0dwJIKakgp2oQAgZUfHd+ZzH0C2C9bsgv
         LKj7XqXdx+yZUj1ia0pZdjMqRNbkNvbxI+CP8btyqnuk8r2EeaCumqMsxe/Mc1Q67s7t
         cVcgv8nUE+9UEBZKfbkwjaUa2FsAEIZf5TOQpvs9H7SK1uAaIT4bAOSoJVg5g3ts8R2X
         /YjpNLCSy/udXz4QDYcQIkzrBNPyaPhGhQzXK+DWUADXwKa2CiKQRcK5s4WXg7GAojSs
         K6PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbX3/MtGl5jW6Gn0UuTFl0NkfV+UOQ7W5aeha8dTTVjS9WdVxOIupVpM/uSj+p77UOusVmOPE=@vger.kernel.org
X-Gm-Message-State: AFuF++kR5cPEYqKTsd0H2I6nl0onRXbUtDidTbAfm7oXIzsJB1zF9Td9
	xWm59MBpSkjq83L9ZcS7If7arPM4XVMSM4wJOCUxgUpapV7mlKBvxCNh
X-Gm-Gg: AYBFou0Tu83EasL2zo7GiUsb3qbVj7nn3XrnoVbAbyFRRcpKbItfYjvklkW88zEhjNR
	R06t8Odg2DypfZAWweaySZWWLIiXT7ueIPehjF8Yl1LSXE1Ebulb0QqDg6UVAzXlG6n/ircIEpG
	ZpBB/92l2n/tfe0ya747byfhqt2d2S5eAw3+xYIvjEXMCi5Rlp5vpE9llrCtR/S5fFo31OFpO2u
	V5a1XYVSA4Pm4Ygn2T6UhxntPzxMYb71xf+Wn/K3Qjwb5QX5Vp/JH4E9DTnvwOEWb3/bys2dR2p
	UtUf+woT+Hcn10LmV3k4vaJIEjQIEhmBtDKgVDsJ4pP+rxO0UhVw2AAyJn8P5xowLyO5GGD6n2H
	KDRjjOlEcitOin0UtwuJTU0brPpJownF0yyR7Bgkt/FhXhL1PyWgFOG459Kcz79s+agWUfgi3af
	cdTsoGKuB7gHKN6Qb2fD1mJ0Bs7/aVz1MHIWeahzbN8eaP8g/oTpVYC4sbJPmup3vTZbyRnLc6g
	h7FgkqxNJ1xbfGicpFHllR6kjeLrQ==
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-396d0f1a83fmr43783255a91.13.1788200473351;
        Mon, 31 Aug 2026 11:21:13 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4d92sm27298588c88.13.2026.08.31.11.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:21:12 -0700 (PDT)
Message-ID: <e741bab6-782e-4e82-a7fb-7bcf526a93ec@gmail.com>
Date: Mon, 31 Aug 2026 11:21:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133359.468089036@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133359.468089036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.156 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

