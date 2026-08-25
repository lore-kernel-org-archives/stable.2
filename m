Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD83D9DC1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680065; cv=none; b=n3EjarmUReWb0dhiEDNVxBR+RZfgu1P4d0ns7sr0fDbiKWe5sA8K3EtZa3mDEqUJtNEDgRbaj0MHdSvOU9fXyzbilxno6sqByY6ZxsbJefBlTGNSiHmEa6Nurhq04ybWKdJt4ZamoB5NNuOkttGOE71HDKCMXX58soTZUKji8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680065; c=relaxed/simple;
	bh=zMbngc3qdiMhSfAuDNFpS1vX0WbZW8PHrPGV1cV0NHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1JahIx8zAKj/O9iLME/DWXtS3KXrg7XC8rujN9iqWonj2GmNnlbLfCne8W1nOh5FiOGUXSDtO04wyJeLt966Fs2O3DveLn0fSaMrFi+rWSu95z1VzJIgQBcP/9W/SgoOHrSKqgLOoxt1ldxp46zAu44+VYoZQezFF8rz1AQzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX4V9MUK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX4V9MUK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-395cf2535acso69222a91.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680063; x=1788284863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nqK+uofot3qNgcx5OymPq89/mB6rANapa6yRWsX8aY=;
        b=gX4V9MUKyqlT2FRxILkWf3MTzFFZgskQMO1cOU7UoYUykSOuWIJLnctZxJYXvFko3e
         i7ovy4D/z1ewAENWVjy0oxLQQWBFu8qtJBM6DsbULogJz15EycNyWBORtyrDUDkzR0DO
         zraKzx3qrsXbZVPQwDC+MtY0V2dSuqPJNkHvArT4bVdVcnqYAV/f3iqhyYFczuPSos2k
         04BV2cDYt3mXhrQMAFODyplwWICN/BhwHXjiy1lhxkYO3kZaijKX9Usr7LNBEcGSNlsg
         c5vk0U9vmbdeJ9XH/mUV7wu/Dngrq0BPSsaHlZotVZYhUiz+G64ELym3lZPEDw24i7oh
         MsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680063; x=1788284863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nqK+uofot3qNgcx5OymPq89/mB6rANapa6yRWsX8aY=;
        b=Itd2UacdaJNfsc+CP5j/Hs2fzu8/aCRnZprKzslDBPzYUgTCTJPqiBs96z/5yKj4ms
         ID2vdATLceh8Xu4FqzZCUQDMDJEBLg3wbDuve8X0VxO4GO3bq+pe3UUdjkCrpQhpCxyX
         CGOZsAlIhtDmuKreO8Q+7J6NxTY5RavuXklqthrqM50psrY2m7xYjx0gI2kuxKiAI/34
         +Qh4jvilQXR4PVE/SHfwhLn+i3ikSMlPfrQSG7uqqHypVKbZVrHzBNxs6ZDxBbMwFxEA
         Ute1qir9PtBG+xLo1Vn6t951Dd7PMqEP893yt1DWLkxsJ42p5xlM/qR2ZcmX52G05o7A
         pPIg==
X-Forwarded-Encrypted: i=1; AHgh+RqcQ7q1O1Mu7yHohOxE8BwVpy/hP0LogQaJkQJO1TVxR3fOPLC3Kg/4rEUEjw209UkjUNb6Rks=@vger.kernel.org
X-Gm-Message-State: AFuF++kdcS4ZxgKGPw2nPJQnW8aXqT6l5z3Az42QHBuCLOAV6uJetrrL
	hk9lKvmH08VG6zt70qGwZ5itvhDRlgwimRMPU4LCoYY/ZjHCCqVXZu98
X-Gm-Gg: AR+sD11T+2Tnb5QuLESaYi5VIxJ4ACuE2yYytrklU+XeTPq9vskuViArVhS3FbwsfSB
	I8R0RpqtdAbgf5dqwjGzY7y/H8mtv05D2khkt4DphwSZSmeRQBgX0olvGb+JoqXBmo2QxOYVqFm
	C5wyfOV4hjk37w0nR/n7SYj+489DOF9AapaLN63oIK6N5qIjD2/xPZoBTgulqv5CZ4hiWxx/i/w
	kt2Ys/MNdOIJ0SsQ2NT91PYj2U5vyiz6nTqVR0zBhGJV4vGryX2LyHf/1Y0LNoX4N6t1zb5lcJf
	RdqOchN+8WsK8THGNT+v2LANkVRe2Zk4GJRJJnShkyGQMWlGFhkaKG3hSEa4HNfmFlxFHmpMU6X
	5+6g4JKS4LIhulPsUAjmnRQKqUb3ETYvWBLhfaFKejvVPuaTAMfHkbhIa088Mw8JiRx34tweIo+
	3b461xWfD6vc4HhXJn+LFBqX+EmIQZB/XtdYsUl4kuLC/oOsqfkatjrLKsDbRCZrPZG51ol8YoS
	smteIiZ/kfTWFI=
X-Received: by 2002:a17:90a:a890:b0:396:4ce0:6400 with SMTP id 98e67ed59e1d1-3964ce067f1mr7649214a91.2.1787680063258;
        Tue, 25 Aug 2026 10:47:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm891969c88.1.2026.08.25.10.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 10:47:42 -0700 (PDT)
Message-ID: <45629d75-7a00-44e7-ac7e-68685f33bcbb@gmail.com>
Date: Tue, 25 Aug 2026 10:47:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/57] 5.10.267-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.342390421@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.342390421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.267 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.267-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
