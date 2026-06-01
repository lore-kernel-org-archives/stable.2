Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758C280331
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331665; cv=none; b=KbowSaVbhgFe5d2EbYJw9YTU0m05ox9zGhtK8Xi6+TZ6XD7pe7arXyify1/RMT1/7xRSsIAsf/l9/atkqM+sUPU+u1mJyCfH6vRlRrmCK2FanvkmV2ukjjfs4uv9xja8APw2rmN2VADAe0aIR3kub0rK+f0w/q+i30FpbIc1xB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331665; c=relaxed/simple;
	bh=9va04Gj4TZWVzfvnJgVPRuChJfeJ8W9Gwo7jtNxSdVE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3CZgbcBT8vk89hAVoLtc/rIE5fpD8itQ/55Q09A6asTFvumPRwfPcRKSlDWPVcnlns02nikbW/y/MgwMFX1xR8FEkTcMhQBAt/y+2gt3KMivA1kSy4WalULVV6dta4zZb4YO1x95qnNey7w4HKhomHtFgpPGN8vkq5Qavdqe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6CF4x+k; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6CF4x+k"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914bb8e95c2so584164885a.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780331661; x=1780936461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNAWf7f8TEsVni9T7N4RVk0OisBxfJyU8zGQlhBLT4Q=;
        b=f6CF4x+kX+R+qFGCZdCpT7GHgGj6YzhtLyy3lRrT9WboI47BvRQDjaKlAXyVfYUf02
         cMkEs6JoYniuqP+oxUfvJMpBJdjdAxglzOUJfXeSAgoWadpN58Z/MWZddlp1YiGZvv2s
         LvbTtxVxZiBxaOf970UiDaVOL5HqFrOn6Usy497D91iI/M2RbUb78gsyGBPIbWEyP0HQ
         kPktvc5cFwpoH74gahvijNao9h8KaGHvJCk7UmZWtX/zvcjB4vFS9UEUe1GlhMMMLdSR
         84lYDgBMEkkPZalvqFbigMCjiVX8OvJ5wX7LaeiS0RWn8Vw8bM95T4zJ197Hozl9lxO8
         RcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331661; x=1780936461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNAWf7f8TEsVni9T7N4RVk0OisBxfJyU8zGQlhBLT4Q=;
        b=druM7OvEYybwCcTo375lAIZfBPV2hq7DGgmSauRxkLp5pReCiyruc3At+4BfN9d/Nm
         v0q5Qi0VLeTKbrwuepYyxjrUbTTdt54AvczVUwc54wK1Rvz9Lk9qPXQqyUhfQ2L3nhXC
         dEnZ339jbt8lx0cQB6lMCjYqktBei3Af+rKZnbOxOjHbaMEQt79pjuXGNmP7SrjqtozD
         0n0NmrSy66f5zuSUKPoPHzGNlSN04SOwsl+f5xEYbEfb6sbp+QwjC6n1PO4lC6rvqMGJ
         ZVG0yuruBuHLMLhrVPvKXo+Ibt7tcqboHPEydDJWoZQIpX5R7klNZjKhWIF5SWQS3pSp
         +zRA==
X-Forwarded-Encrypted: i=1; AFNElJ9yzFN1HFUm/R016iu2ZPE4boccV0gbGFiTYGHB/CRdIqa/NeGosN9YKrxtpyA0CUGjzF8d0+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzz0aK0sM8hxjOvGHJcYi3FWFXz/LkdVpWXCXRKpKF7GjNlfZ4
	54Gi/eRJ7pFEL1VQr6KDNLWOG/RChlVWjTNO6XA+GByMULjeY6Hui3Du
X-Gm-Gg: Acq92OFPajJq/IaDXBAy4sVfvNWWbGLTnIs5e/hv86ppIjMzt8xI7oUfxJxHMO18MVp
	iooUHbT8DnY0gCoN9ZfAYxkQoW01Mq0NRE4eCrRSZ/5vg/2Cx2crsW7HpNB2f3f4QdX0Z5mNkN0
	rRh1NiRMQc+P3e+4ZzMqBEO3Cic/Nvz00PheaLA1bGL/Rd0DyFhxwTaTTj2LiUgF1wLfCpm+Ud8
	dVh/mQndLM7IZUb41n9j/XusL/yR/oDFTJ6vXOoNLJAySkD5lIh/EKcqR072xETt16JsO8MahcY
	bOV1w3mkgN4ZotJGoeARHVmaWOQKw/k2gyFfIznXPSrtwpfLByUVUs9pB5lsce6kf2imNQkDUJp
	5t3OgOxqhQ4z04ezG+B2RsVpQ72Bef8yAbVYD4997WLaa9jT6xlWA7UAA42uT2KqMdQbIWhCuvn
	V/9vWVT51AEghmTVV+weFYE73/dOt26WR5VoKCUFp7/fUqYDhXyiaXudOoCZZT
X-Received: by 2002:a05:620a:29c1:b0:914:c316:45ff with SMTP id af79cd13be357-9153d9e993dmr1703808785a.40.1780331661355;
        Mon, 01 Jun 2026 09:34:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262d1b4sm1058346985a.39.2026.06.01.09.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:34:20 -0700 (PDT)
Message-ID: <e5de9229-8f67-4de8-acab-7b8fe7281aa9@gmail.com>
Date: Mon, 1 Jun 2026 09:34:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.10 000/589] 5.10.258-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260530160224.570625122@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/30/2026 8:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.258 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jun 2026 16:01:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.258-rc1.gz
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

