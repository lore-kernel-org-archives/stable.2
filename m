Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36393D47DA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739379; cv=none; b=H0jRM2+AT1xAstdqVflC71TOA+2INiEMmK5Cv1mePM5s2Ukv8xNPB71HoXNiCH+CJTCmuIW1p/urdWJhXY/r5zTBngvypsU2WZA9XnwbS8A95U9dGLjlknOA83q/gqavyxapoBInagOhuahqOvr3ebJiTCeFjxZisrIQZXrAOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739379; c=relaxed/simple;
	bh=rci9TaTiV+aXvjUilW7ZX6DoI0odRocOImgqMMLWJU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gna+iZ/3hPMWHEim/W6d1VRfhO5Ate3WAr2ebUtzJbGuoVEcuIYz7E1LKMBtttDRGoER7eIg+yHcLVmBDMCOL/h/EsmJhPo5PP9JVDzQQm+j+PoS9fiYY+qh/y1/pCG2fZfndwGYaneAh/b++eb9v1WLsevfTXT154r6LDLHC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HRzSjM7T; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HRzSjM7T"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4472500e25fso6139553fac.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784739377; x=1785344177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcVqI9nNZSfEoCc3vL/vD/jS991vj6WZxdUxSGF8rUY=;
        b=HRzSjM7TZS0TbLW9MN+mCEJjv8x2P5LEMQYkWZeWArJda3ZlYl4yC33th0Xf0B1of6
         E9GOcRs6pLc06N3A9LwTUAy/7ddbvL+ep024QxGdd+KWOiWQsgS6kxjO42Q6aAoZ1Exn
         qSCkBRIdj9FxPVwpnVSicDZKLeK7meoWtSeDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739377; x=1785344177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcVqI9nNZSfEoCc3vL/vD/jS991vj6WZxdUxSGF8rUY=;
        b=R7h82A9bRFVwe/x8KLJMaoxuyl/z/81Hs4M2NEvO9oRX5oqcLVPQusVHqaPqS1KghD
         aN5MMMI3QAN+qh16M2hQW4cIg3Kup3WNSKzVGEkk1PRucXBPDcV6y90a8IJdigGcLSW4
         29kcfHUCakZwC01T1SM94Lk3LCoy9veHTHZq4gHZmniPCa/+Csj4aTksQRJR+7xhmTNG
         z3zoFVWkbdP0+NkcxnO+/vB6NN/0IUqxfAXxThVX4foQ1Lq97OVctNunUmL5M1sBDG/P
         vf/parjEA5rZ5sDY4VD/A3xyNlzBX58Rpet8U1YKzTsP+VmEF49rBfSnN6WTFrfQuxDL
         H8XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqp3Mr8SnAFVeONoCjD7qyRYcb4hpwkyvQNqsRBLJe+qLsWu1vj1ao8/q6lCXcJYUJqp4ryUhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6xHLcpjfDJiI6biT58F4qP7Bh4VpjWSYJkbmuubTNp8qEL9x
	/UiPKPM3mI33yQFFi4wxWxSFZxo8WcbZG1H64eQaBXAF1O13udU69PWjYMHKC2OBoTY=
X-Gm-Gg: AR+sD11tn74+WFfFaOqPEe+aMmCYjM8JPM1CDGJ+ME0L+usKPthqPYB/ir6l24YYtMd
	xLgMaaYWI2pbduAFQsno1eDEdZu8rNasDLmiBf+6eDlce1h5AnbjzAM6eDq89v5ywPD3FMPipaL
	3kPsmjPXiv6CWJyU4iGBaySitnYMqoDYCofhAbQ3GqjBB5+OTtgEIqp69SWB7BjXffchYvyp+pL
	UeHOplecmd894u6Cwaq8sbTtXrkDs6Fyc33Dxnw5O9zDZhtfxwbJfrg3sRKdqbqNqkplZz7UJKI
	haUNmkOTLVweLlD99FPpRoA6WsJGydM2GenvNymziZlZjM4KbmGcSIiQDXNZSm/ngYrAa8idwCj
	xMRCD5D2e4po9tDccQWspag2vm/Yb/O9ux3WS5gZgAvlxQZSXA0kxBBm0RHQ9e4w5f4PFpeQASO
	kAWlRPP2NOefY=
X-Received: by 2002:a05:6870:d30d:b0:447:9dcd:ad3 with SMTP id 586e51a60fabf-4569031b3e0mr10790866fac.18.1784739376677;
        Wed, 22 Jul 2026 09:56:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767486cf6sm2444471fac.15.2026.07.22.09.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:56:15 -0700 (PDT)
Message-ID: <e07b290a-7e48-4998-b29b-fcb2f6f55906@linuxfoundation.org>
Date: Wed, 22 Jul 2026 10:56:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 0000/2077] 7.1.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152552.646164743@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152552.646164743@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2077 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.5-rc1.gz
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
