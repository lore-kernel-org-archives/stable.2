Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF97360ED1
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302113; cv=none; b=uDR4YV8XssP64FVrSI3VjMwyzfQc5Prsq+YXpRgdMiROfg6e3C61det58ix4GiRNqU8p56iaNUW0quEFDdIxNIqpKI0Vf33zIsXp/nQ1oekWOQNU6Gzv0pmtlbgaQJr9TpU7OpZpwyb0vZkwmIlcHpaotzFoInG6PTbzYh71wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302113; c=relaxed/simple;
	bh=slActN+LG+kX4UR/U7IgxrFQHhsmFcw5paYWob5e1zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yocz73fZixDYZQd/LdggfI6Yzhg49Bn3Z/BCwwN6t89XcI4ZtAIgstftPk1Hm7C+RmeL56olw00ug5nF8ygh36lTc+tCXrHgZO8ufB9bl04gBfLcMKSAJej+j5SGg09wvMddtCv6m/pvQPMexOJ7T1jZG3q+yaecDGyPQ6E50uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRG4nEUo; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRG4nEUo"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-497d3e4460aso1480786b6e.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784302109; x=1784906909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBq4hL5G4a9IGwnsXBItyfm3yXQ9D6Km3DzDTKJ1mgU=;
        b=VRG4nEUoOhPTL3syAVfHSbF8VFDUXk+f/1J8CD86QWpoQmz1j/CrkCGAqc+UhHKdkM
         OsF/rMJbooNn5jB+ZsQDZiWxukeqchTLoBccg+o2IvwP4xlZH7J+FftuzWaabBShRnWI
         80SGekFNWGlSKyAgeQqxtvQ5y6ChM9/U6Z0ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784302109; x=1784906909;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBq4hL5G4a9IGwnsXBItyfm3yXQ9D6Km3DzDTKJ1mgU=;
        b=EmFk9fhYUtkQuP/fhHRjrjYMsKMuesXZ76vzZQTpkXo0Ta8A5ueUqbjRnCoQmiJkxI
         fUccqo7OFvz8IdqsjpI9crddZaqeI4EjjUH86Ak4PfW/rDKN/Cv6sN5IIDrslb5GR9+v
         vwviibS5h/9gBemcR0ixYB84pwjALYpruqcFK7TQp70BTuowv0vXb92KCKhF8hxUtPNb
         dSLLB14mGRYy1KyeG+ctdJ2+40RLzZWv0UT2UAcTAQr71jjdg+hGj/Etvrbvoxs/xQ+k
         dS18Z3+S8hAWEraTDv5SguVVS/f8r+62aki/PzseIxliYKZevAGFa94KNYn+9L/uFJHK
         xZwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlLm39BXkwoKv5BTplU16okBEvXBKi1yQQOziDmeu0+pG9RiISuJcn7WvIdWkvcQYzeOZTT0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHJGpr/coKN434TEnE1ongRoaFPikB8sSrRcDXAMtMnnr5xeg
	pn+1XSbQsHxyq3cSpJ8ZdODQM9zdZlRN65mqQfvMpCLc71ZRi2D8GKi3Zy/wHkCIKCk=
X-Gm-Gg: AfdE7ck31Bzw54wOtH8RXXEytDs36nIHLbo7zSGv+D8A+gYON6LRmJzCoAsInn1Qw9w
	QozLmcIpPlhLIfhZ7lf0j4BxM9ig9YdTGImIILMxZrdefPScMkeKclrwWluCuZnfvBIDp0cfLK5
	g/jPAhz3Ec9i2jEWXhaSkxNbPUhK9inDIMrB51vPQBkTiygX/8+KuBbt+2+K9WR1LH5kh0tr6R7
	X+bWD1VfSvM5NREzaToDoz0WZybNwtqYW9w9KEGygn4ZFxIfOx9pKKf4N4Br9vYg6KdOY3g8SdF
	6uLAVPPbKC9geOYpJ+h03ZgbYIh8gN+5+Fjokmopk943c95Z+btFBZWfBxTW0VKZHZgSN5dAKrk
	TD5E/0ttFhGxugmjP7ubXzgWbBAs2MkMVIjqLLxBFfEptQPskMK5Ww8oWmM1lpOWhzEnzaIg6Wj
	JOuXeOOTEv1YI=
X-Received: by 2002:a05:6808:2518:b0:495:7d58:77c0 with SMTP id 5614622812f47-4a4cf4f8db1mr1416900b6e.20.1784302108985;
        Fri, 17 Jul 2026 08:28:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3d4aa0dsm983905b6e.17.2026.07.17.08.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:28:28 -0700 (PDT)
Message-ID: <636105aa-266f-43b8-b648-af744c59ddfd@linuxfoundation.org>
Date: Fri, 17 Jul 2026 09:28:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/518] 7.1.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260716133047.772246337@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260716133047.772246337@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 07:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
