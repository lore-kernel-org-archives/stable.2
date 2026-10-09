Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB993B05B0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588186; cv=none; b=XrmZnfSen8hqV0UD7ufrOLDnS4HCps66s4qUUwF4V0OABZx44Teek4KiOSLbs7f/5zL3E1tWMxd82Cm0HHXY4cEVR5uODxZKf437AGGuEG2ICKjVOLwlH1m7kdNYw3KateBarxTFZoe+Q/q0pIRWpSFSfj7EyT3mVOUb0YY+iaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588186; c=relaxed/simple;
	bh=VBnbwFMLD3JSNrfnQDebdiG+E2lh/z2NfE/iMSTFfOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcZhfKiuF9yE5vuXF/TqJR8W8Jocd3aFz7T0360KmYUM64+75TsYh0/zXDVeLjRBC8S2CWTUcI8AAfFQ53WB7O6cARuHUYVLgF28VYfpfyfhvGkSSlBKVC5fedy2rtzP9ZfiUZTcAYsk2dWDgXZib12wJUegVoBX2bdzVD8tS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcDDop27; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcDDop27"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so284421eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791588183; x=1792192983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKTLYTxvw3UCc06aTLO4FFaTc08hP3j7X8BS9ATAWjs=;
        b=BcDDop27C+2zWeWF1JrDuJDLf+//jZP3CTS1F5ZTjGWC4MZ8vgWrLMq7b+vhdrbOTi
         j3MD8JOmCNRJ7zRuLd8HMyPZJC8eUQKT/ok44NrdszLijJAzYHe5UlTfYTr8DJSgQ4bv
         Dv80klLLu3FMcOjIqvgqixm+s/LLXURFWZEa3OR3I2Ee0PaLwVt4akjlbI2dnX9ohC08
         OFqfqoCqJOUkMVxE1YCdkZ5LdtmezzpPCiuvhg+HnTgkVQl67WAcQjnlYoOCgC6EQlwg
         ulmi/zCynS3ymI4OQLDF5Em0x8kfTZjUJk/0ARQ9S4SzC7cBRVRSrBDBYBtj/bsY1BoU
         uEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588183; x=1792192983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKTLYTxvw3UCc06aTLO4FFaTc08hP3j7X8BS9ATAWjs=;
        b=On1GpIbv6Knaau2eYtOeWKE2OyeVRep6q6xjPmvvzRLN+rBgrX+swCCM+8QSTRTABv
         DTpzjJTMfhKD5PGzZjGNWLAA89MvdMAN/dvKXGKyjKK1OezNBA6B4Ss2NhHmWdG2MzLc
         5gm6DfShQLh6wZtK6oDhx0lCQPFKgWpnbgViyoc6K26WbtkQCUDYTnAmdm7b1T0Dp3sp
         0yQEox8uNplrRdsw2MBHW3kJJ8KuEtyHQOZmemBS4o9vE+8uNCrQMx1bzxXybcLJ/Oi4
         BRb3QJgeu/pECvtWi+M3j5ti6hhIUXOhGGNEH39zu/69F0dNbXkoM0SUgI3KIBb8qC0B
         aBPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN8HXL2hTONxRfqdiSVJZ6rQg6XrR/GwkC7Aocy78L0J0CaSy3J5VO1jsX0zSFMxt1jiFYJAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaMsoSnPDGWZz9zPUcAn0oxWPDgcZDivHW2n/U+y/4sVABqPBm
	egIg7XHXpVspFrfTIpuZxVwzdsD3QjghBmMI9Q4c9McjvrGmIx6ofO4O
X-Gm-Gg: AYBFou2GCXJRUzTNsfYIhWwWVPhq8jIGdU5BchOjCWv6jDsN0m/nyH/PeXgUeLaHre8
	pJgfSARKqZP1uwi22oC6l8vQ8mDeIQFfzs4UcajKFbVkLMZ89ocrr6NAnt+hroip8/sExYx49Fj
	2z7J2OEvvQcUh5+fdsHyNpSGAJfJR9cnAa9/5WgYqm5EPc+MSYIO4dCJxpGDgqL9P5pyR3uaDsa
	jPVolavRKxuGu4JgkuAO4V36UxqFyGN5x7oJIK8ZcnGZVg8R6YbImMix8P8TI1uiFhmyFa3Aa82
	Z3Lh40l/xFhmnW3i2in183HNdU9kAXKWlx+K+RvdaLAz4QoNksStGbrBrKrQTb3MPStO9tl3aY1
	MLaEfYrSyp6zmc6VUmlY3oWOeNX+HJUWyJjhbEl9F/END6k3T4Kax0DYLwa+NLy17mjtzweKPUq
	Gbv5XEqvaFLbwhiFf5Cl91p23zJ5MBNimWAQ/y5EqNkzyT0wjogUy+y/V6PzMR0MGRP1OwsF5eW
	gIiuBpclsc6Ef0OBNJUSJkL
X-Received: by 2002:a05:693c:4090:b0:351:1230:e379 with SMTP id 5a478bee46e88-3537df59719mr5073363eec.6.1791588183110;
        Fri, 09 Oct 2026 16:23:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm8736839eec.13.2026.10.09.16.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:23:02 -0700 (PDT)
Message-ID: <bc869fb3-404a-4c81-926c-545def70956e@gmail.com>
Date: Fri, 9 Oct 2026 16:23:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/403] 6.18.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261009140952.119038291@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261009140952.119038291@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 07:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.56 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Oct 2026 14:08:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.56-rc1.gz
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
