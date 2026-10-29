Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291363;
	b=EB8KodvAgDHf5oIj8hYaggpXc8EPFyjGitvN1a6Nk8d6WQaFtx2gjkucwJStAY5DmgcT
	 lDHY+6CuMQnvOP6UkEHFAKVsOURgCmJDBQ+csFhT8q8/1m89Pe2FlrUZYtJsXz8JPE/cR
	 fTY4R4LPBtPk6PtFTeK0A253gtJHdUznordZ+wNFbvOAkSU9FpRhT7/EDp9bXlMHLznc+
	 iEEH2MEXDPjYKAHaUFgLr3+ShvOHSRlZQSpGI0Ny2AioF9BjMmDqXRLbVmE9e05P1liNI
	 eSx5TsDzvy1PI1HNgPeRLvjzSyNv3RMPyNxAsAcafDYqZKeoRqYjLtnHeXZAbWKd+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HO+j6ign2yj4NoqgE38MT77slEhL72UAiKeSfh5MQb8=;
	b=fdxCxLZUr2zCeaeRMJMlsOtcvH5olgQwRbzTQ42wE5wZJClg6fgP6rdg4Y1oh+VeLGKY
	 AuXeIFdHVRhtIN4nPyjTp42vKlPlYZA/+6HjEKONnglklDUmD4tFUSrzigwPLbib99ynI
	 EKaZ2TrTDBjuFH2iNfOlfsJzQe7BnRxzuwYr6ubFR1UvRtpiKTrIEuTyK/Rzc4h9O5sW8
	 utOXYbQMfnDluKdp8sPHohBKht+kWmSkQIH538LqTYUK/Dv7fOzV0gO21oib1riSdyNRQ
	 FqSnuee7MnG1HFxOc8qZtHe7XptsiCJNd2hmb8VaoyiFZsBw2JLB3OCNa7hB8tcfyyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSahb8w6;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F35606A321
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F35606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSahb8w6
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso951749b3a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291362; x=1793896162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HO+j6ign2yj4NoqgE38MT77slEhL72UAiKeSfh5MQb8=;
        b=rSahb8w6dMZA/vBGQ+1QSwH466DAUvGXEojg+saw4FZp5AolDh3+WEm/WEpq/8NNPI
         VAv0Kw6epULXELT9Mshcu8bL8Kc1BFidz/9N63sweSxCDLxzyEBMI9EmlocYQcRhMd0G
         rf4373BUKFG9/X02Ddz2soK40FsjSFaRXfxP68MSgLWKoNwI8hmZQWCGsSsd++opETRS
         +Y1ilGMkpn4o5b9k+CVwrx5KeSuh/JUjD+56pAJgDlKua1xGqth08yTmGzsKeWT0HzD9
         RTncmYs+CuX8lT+tf4xIYetLZQyMt5SypbrXCsNYRF3u4OTZyy0yh4y1qZ/cY5FFh6MM
         tVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291362; x=1793896162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HO+j6ign2yj4NoqgE38MT77slEhL72UAiKeSfh5MQb8=;
        b=NXb+AR16jPBOZZwzj8lwzWfK3aGSp7YnummQGXcAtD60FZiaReDcvK+eTOu0lMnt1+
         x3+bIovsSVXyUW4i1qMt9EwfjtPuOEmN3ch7ABrWTGoTvm9WWa5DmkHluFIr1Dwx/qna
         ZoQD7q+8/Y5b6bydZEczuQkB6OSj7Bi59QMX6taQ1DS0FkmhcnnOI0X1F9HxDvJCjil+
         YHdTIFLbyE1U3lLYfWngkZyj2R2qU4rq6ZAjgnAdI+8Ymj9aryjXBRT1eNgnoX16fG7X
         tOU+bt6yjfHwQEWAOy8nI8eVYqNWNo57qiCGBVHrx3ouu/LVP0eoeCcB1LtYRs5Zeluz
         3g2A==
X-Forwarded-Encrypted: i=1; AKwUvBxzx2mccf18TC/LsG3u35Pc6D264fpwilEMv2HQdTkfvD/l2XiLNeHWFo7mh00eMPoH+dQQ3bA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgrK0Ynx1JxuZ6Sxban3Jn7Ut5RF9Tfr5hIyeIoLY+DIw+Xp+T
	MkISKIaeWS0gzcbZ3GSiZTNPpSL4SB6IBVgsxvbNeOInToQtv7DmV0mf
X-Gm-Gg: AYBFou2gXELudyI0jNSe6zGwjqeRIREzpibWoOwHY/0CL3sFCRw1oYtNJPXfC2/6VMm
	8sUu62issAoHvmyq6fb5p+DYJIAWVeMNbaHbJZDXK4ZuqIXm9cWJ1tkMEPumUHn/cVoq3ElkddY
	KcRKu/1GP8orUsrzJ4X+2fMVI3+BOO11WNmwPmXrLSNjCWsWIug0W04DJ8AiD0GHeBm19LLb4Nh
	UC8BC9KpIGFgjIfcEoKjwBi+VV/g9LQLeGcnV7N3Z5EUYCeYXzmC1prsfpdWqjzBOj2bzndcuF7
	z9Bb5uQToMO9MoTOy/+M1UNbkl/QppwSOH2c/SHfqJ2djuzwBaTOfd70NiweRz48qTakU46RX6K
	SWQwU4jjozjw9hUYnktQvYuS2PMZrqHYLvU7oLJYFmnVjipyiRTk3zgQ9Gy37l75DL+0s3UUzni
	rMNkpqFGJTogpV7H1/+PyPvWJRebWCmnzc/+pCgeyBPEYXkvx8DplmkHEZWSPOZ9iKog2UhSASl
	5XHcfuTjKiy5FdkfzCRYNK7eh4Oe13gHpdgLi4eJE7LxiGpVp488Zgej1Su6eDGTYNRGMfiRQzK
	EyjDtJUSqS1BWQEj44Hbv1oGYzNY/Yum4+ziq3Ttk4BmJGsrkXsyAPij
X-Received: by 2002:a05:6a21:4c0f:b0:3e2:76f0:ac27 with SMTP id adf61e73a8af0-3e902325a74mr5014369637.40.1793291362131;
        Thu, 29 Oct 2026 09:29:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a989adecadsm114437b3a.41.2026.10.29.09.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:29:21 -0700 (PDT)
Message-ID: <56e68cda-6c37-4d4f-b3fd-725cf432feff@gmail.com>
Date: Thu, 29 Oct 2026 09:29:18 -0700
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
Subject: Re: [PATCH 6.18 000/109] 6.18.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028165942.357251485@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028165942.357251485@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.60 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.60-rc1.gz
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
