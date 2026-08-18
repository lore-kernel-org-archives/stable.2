Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC493A3E7A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075416; cv=none; b=EjpNbIcHWpuM6UDa0P+zJGbXC7kSPDfS8COYCIzQVI7YVNRvbVe1C9fPc4WPxf/jmaXi1Ex9y9p+vb5Z6vinFFNFGDeJnl5vzRH0BJfsJUackIPKx0P/RdPUAsa4Rr3iIv1fbhcD5ngv0oYVtv6KqVHjL/pMAE344/V8cYwuvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075416; c=relaxed/simple;
	bh=6oeHzMp7Ds2zqQQ6KuTgHRLm0wzWhDN6LUijSL1QMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ovui8vspD6rWIrGGLWPele0Pbd5JbM22YtbJ7dlpBtgSodaB+iFnu7j5ga0f0ny6cfXpdOizlbO8CBL9sNF33Ck7zbPifGB5/uoTqyWJboe1f1WZNUaUdPmfhCMPsx+/uEBjm1qBFsyhlMR/zggaWZiUP+GhP5kFGd/QBWPhxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4+Mz8yg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4+Mz8yg"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b13735e47dso117958eaf.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787075412; x=1787680212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Hts1Aw8R5eKycNYcfV877YpxuyVxc2DdbMBIfo45KI=;
        b=I4+Mz8yggid4EvDmvhVhUZOlumlwEx8bRI6SP06lXy/ZuhErZzmWM4CBx4xGnPFzkz
         g4RFgFPOTX+BH6nLaVIafg02FlH+N3ex7PEsLYcGtoBNBYSpIYJoMDbi6Hm1i/xc8YvT
         72iUG/nn1sq3zNFbaQuo8ZQNGeWDtG849v1q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075412; x=1787680212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Hts1Aw8R5eKycNYcfV877YpxuyVxc2DdbMBIfo45KI=;
        b=fXn9oHtpbzmOfdm+Kh1ZHnRVMM5ZCw5fTF9mIocBkg8nBTu9fKhHLLrDy8NHzkd/6T
         qxEXW0b70HYE/cM29AYqgSQ4GeVcIeCjsmdwEGKCfYuFR6GaAUi8fGPWJbG121yr2D3r
         DvoOstyngH+36rjkBGUezA0jh5iQNljDllEE4y6QaEkekQ32PFGipPYlb04+8qc/gjuU
         bG336FStqoW4Z8YO3yKwjKxsQT6HroxqY0RJUA+GjJgLKWcNF5x6QZfPlUoIn7+1lNDa
         sKzmTNIb3P2aGkdgcIGLqgQ5pcXO6FC3Ik5HAsK8x8nTdF9USZ9sfUqhv6acVTtsmKFH
         zRww==
X-Forwarded-Encrypted: i=1; AHgh+RomXybkm+ufqBCGCmV2N6Ms7mg4tme+bcHapO6yn1QiAxZZnlk0fSGM0K58Smm8EoIP1Iw3M2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpX1Xh3At45Lu9bMevMfmL3sNKTxzjqm5WcmlRGv7T8KX7XV4
	7TO6Y3Ow6yM/u2oATNtI/db7N9idwgfiNyKOV35kg0pkNAUtj9JunzUAXwrPw6ZOrP0=
X-Gm-Gg: AR+sD11URBZTC1ecf48LOeZe/9ucslJrFhnkc/Im3m/n6P9enq8g2eo+zvXSa/FM0Yq
	9shuIxiIQcBWaSjmL0Hr+TabVtDynPboYA/2lNjc49rGf+0bmTGR5ZNNu132Xla8mXJGuoVKzCs
	q9EZ+kj3sB7G5I9dA1Z9UqTio0Zf3MIX+Bg1fhzBLghNXNfLfQl1ew2eeqdimqKZdNz+r8KHC2g
	JkwaSu58zuT2F7Zn9estyeh8UpR81RfInmYoUWIILLBAg1WZoaZwWQ4p+2KPyULyW1shZtniGHh
	gl6BMoEc/kf0bkP0+y7HxRmEUuiM9ox78xvGBGy/1m+1fekxnDLg88N0G+qjsRCUPTMb/iSxUQW
	x6XX+VxAglvaOz4jDy5Tw0T8RW6I2WADttGABx3gVPD8ZJcuQN8F0ogMYi/1wsKn1aIrZOXgSt4
	wz7t3EPTJUra+cBd2jmMnwk5tK2Tu2uX6L84zKxcWMthD8qJejMs0mhDVuIn1a+jepwd1eLw==
X-Received: by 2002:a05:6820:f004:b0:6aa:e1f6:32dc with SMTP id 006d021491bc7-6b0d6279964mr28011878eaf.22.1787075412028;
        Tue, 18 Aug 2026 10:50:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b115fa53desm5156363eaf.0.2026.08.18.10.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:50:11 -0700 (PDT)
Message-ID: <94636860-20d4-4aa1-8545-34e91c0ba37a@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:50:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/156] 6.6.152-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132534.666299318@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132534.666299318@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.152 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.152-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
