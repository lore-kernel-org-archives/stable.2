Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8431E822
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717027; cv=none; b=sP7X0zVhIj+ZShPFCXf1Q3/u2z63OdQqCWEd9KR9egfeU+D3RGOlgs5LlNmzVVBddcDroxggvBp8aqOOwTbVuDMJIsGk8obeB97Crqb748EhnlOl0MePEvtcPSqF4uofCwEN4FmyCJCoN/JLdpw5evS2tBw+4Xkr7Q65+SdBuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717027; c=relaxed/simple;
	bh=LpkugHqniC1/Ud+acecpCwDNeyNZT1ZImtaVjAiFeWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtR222z/3DvY1gS76oV+y86gt2gNfnDm7n89JHMdmRhXCLwEtk3eeXm9darEYst4pmTAgyvBhqJWncVnJP5xadaVaC7oLEzgugMvXAVd8My5NzNm0cnDyzK+rltJKgnxFY4V1T9UVcvdbK9CpI70Kmx9ythOacSZ/3tx2NTgBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cvzn3f7z; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cvzn3f7z"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6d2f297f4so3696856a34.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781717024; x=1782321824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qi3a8oYApaPNeH5JbeamWYok+cJhMUB6yg9/Q+xM1c=;
        b=Cvzn3f7zjR/MMTs8U3RNFSJfxPfFxvdlxHftYrrUctYq7W7mJxkrq2O3C47/PuBFgZ
         imLlvcSehe9cNSfOzOk8qMq6BSx6+YZpxPiidmNUajB2O02jixX9JMexnKSnH3AmUQPR
         EQJJ+jCdsggIu1XdnKTZPrqNhqkop8pHHdP7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717024; x=1782321824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qi3a8oYApaPNeH5JbeamWYok+cJhMUB6yg9/Q+xM1c=;
        b=R8GCske6JWkKj6dQql4aMMTPoWJGxBdv/MsO0RHGKes9F5eidPMC5HA7mjbMD9YVob
         e/zDDhYTE+FNzDsQi+XDgZux0ybdnWbiFC2+pqX1bAp28odKggXGvDuuelaSN2ooHhFh
         /MI+Zh8PukDPdJSIh2UWfLZhv6p9ahLWzN7WodlqGJfqhkNqFjisGA/C1FCl7wFAs/3t
         HXIRRuGu+wMNzjuI1w7rI+azn2Brt4vujt3j0SLuChZyrFnfJEDBT5p6+OEeyxiJdRcZ
         n5Ko4wGcQ3FbIOxMQmAia2CaSsnueW49uYuAcRyifzQy9hDnqdy86pZwG42fizkgntBy
         224w==
X-Forwarded-Encrypted: i=1; AFNElJ/2O/BgvvFvyh69fvgz9X8Ojmp3c8p5vJSRuwL4HLYH/TOfsCUN1D3AeFN6XlYrG8tJy0FX6m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+hVLfiUsq97EHlyejPVC8tniUgyIK5ncxt1QDs09KM1epLOt
	V/+CqvFmXknWhjwuf3cMGeZ+0RwqB/Ec30PeZ4AkRM3GozzmkaZCbQfnLH5mc+74BuI=
X-Gm-Gg: Acq92OHsXg2dlYGnocpef6ihTjx7fZQaiqAn1P+uJ+CFT2iZc89l2xyJVBet0TQVV2c
	k5K6qeLlQar9oKmFzpa15m8pvLyXiINLeFR2uvCPHvqrZb78e+GHPnMcAvPS8jz0jsBk797aRpT
	7fAchqmEnfoMJjv94BHLPkOUpCbA8gaNt6z9xTg93w925z6xC8tIkLqeJJYWcE6NwCbNeWA6Q2O
	ZZS04v0doONxbfQj0hcv1uRrS7bCmRLGDmjNbSgvnxmoWJdD9DAXELQZ5+Rm7Zc6wcS1yCLJC2n
	2KV25aRJ+jC8fPCwz+3QOh8YBXfvIYeQTSpYQ1V4ofZgeHfOPqo7M516VboB1Ao8wCbEMeQCc9m
	rMWJgIGevO9uGPcM2hjRmCzOiqYqAxxgNO2d30Il6Co4i8d0lPi2kEZA6/gv9ff61IHpg3zx9PD
	S6dSY/X9JZu7J8tWzfvUVq
X-Received: by 2002:a05:6830:350a:b0:7e7:623:80d5 with SMTP id 46e09a7af769-7e90b3f9891mr4771801a34.19.1781717024327;
        Wed, 17 Jun 2026 10:23:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb5fcsm10283124a34.9.2026.06.17.10.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:23:43 -0700 (PDT)
Message-ID: <d266b43b-309f-41cb-a832-8a0868b8812b@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:23:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/261] 6.12.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.94 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.94-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
