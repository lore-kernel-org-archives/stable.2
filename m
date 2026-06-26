Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521D46B5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432296; cv=none; b=j+/pLEarLhIG7OhEhsgdjA7H8PhaquWLC6NzzwqmUo00EdJ2tXcUgxUuhD/fH3Rwe/A9WVQZOl6iLJe7XNuzsNvQyj+AQ+T5eGpZlG0zuO5EuZzpz517lP5M+4rCYrRQWpwa+VIcEN2dix8m6jGF0TL/4rjfn/Bn2nGHWZgutyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432296; c=relaxed/simple;
	bh=6npILbQz1DAujwGLQS/wVPTVMOw2YgD223tQgQ/sffo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ+EzRjNU7hNknRsp39mH9nuLK3jMyUevUVXlcHP5iuNTFygg9S0SG5TJQtixOevOGpoaR3af50Abef3Hubnn7+TwNF9VCflFPyLROM3IPqoqEi1rG4dg4/u+cCUifa7+yhD9QZY6akv1u51RIIcEW89BoliptoJNrhVTTGs3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJwsjeWs; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJwsjeWs"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e93b04a142so145191a34.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782432294; x=1783037094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWC2jBknzrOAkBFz+eAheUaf25DyynwIce2dfcZykbA=;
        b=JJwsjeWsGFTnuOSMWc+VvcaVnm8UbbC7rfrSWocBEMzVD1yFrXEkFezHK14t+mSFW+
         5Scldxca2QRZcnBlbGPjTAHCWThpvNSzWEQYlvs3+YHITRJWlkSjMTTgATS+BUcmdYCF
         WjuWbkMGOMKpyZabCmy2iuSQo2wVVCRMDQgsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782432294; x=1783037094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWC2jBknzrOAkBFz+eAheUaf25DyynwIce2dfcZykbA=;
        b=DvyaoYLRPtN2ewuIG91EdBEcdKEw4mDBRh/EF4dunGF41WWq5AcMFPnbXrPLyDk7yy
         NnPTY1CbwBhqCXwHwGamn925vYuC+Nvk3fT27nRUt2JXnpz9HslDIQAcp03KaumtJGae
         DHldjn0iLIZF2wfbVPDSsoEWz6trjHJpdEB0/uQEfp2fXBDHcn8wGv/7yyeXiwcSUnDK
         gNbbeGjfVkYu62XZZescJFRqbIgAjZMXa6PZnyS8q2ej9IvwAHiYJeVMyrhCnRuUq3Jk
         Hmh7XdMcspmdagzflcouxR2br5dO37ubqPW2FlV8vwTBJyBAx/mWCnm5s5oMNxZI/6dz
         1y8g==
X-Forwarded-Encrypted: i=1; AFNElJ904ySQB21wWovDjQyzJKT3D5j/GvyjHS/YsTLCM1GbWbWNynRjy5ID676tHgErFZvdOFCnuQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrosPf7LGqJN62s5erDYrE6YFY1fzuc+OeXFE9A8Y73UDbRm3
	Tafp1cC2KpSmRD69VjF9yLYcqTfdO1dvytO/xBqUl9379yD6eDN0Vt4Qy4x4Qp8zqdg=
X-Gm-Gg: AfdE7cmtEfOJA1ZRJlPADeF81rIp3s3gN4yVj0YX8Oh13lG/4czhsWaLYz91WoykHtb
	gs2RIeo0NfPNqhHwNJhvy5TgZc3xhkWaN9EoSP48uPoRP87Im7uhjHxexIJD5zK7CCJ6ueUOD0V
	1oeq40Q+2jIohPEVl7Woz6MXPJrB1HeVIPbyg9WLZqoAD5Hw3XvlBjCS9vvFKlRgkjqovMgMBKX
	yJrrIfBvudQ22oQ3hMPqT++HIiWr/CD5ArKPFrYO26jRpxM8y82ejcN1hOmEZW4WBlbEY6ZIVBV
	qlefzPuqwDB0PeNMqTXChael12F1D6VFH0iBjbMnhHXpj5l9rIMFTA3EILKmTbwNtEfgYOiGI+W
	+kvf91czVF72iT3QQCvibxJ5ZZC6uTvvJAlrykvmuqWZ/Nmw66vbj28BqjdXfZmQ3TBQ0OCeqOS
	qa4h9/nuW8ZS8BWEoFdK/R
X-Received: by 2002:a05:6820:2902:b0:6a0:e2f5:3b04 with SMTP id 006d021491bc7-6a13519c66cmr4165794eaf.20.1782432294200;
        Thu, 25 Jun 2026 17:04:54 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a1414aba15sm398446eaf.11.2026.06.25.17.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 17:04:53 -0700 (PDT)
Message-ID: <ef6cff6e-cbd0-476d-892e-a80c3ecc1f98@linuxfoundation.org>
Date: Thu, 25 Jun 2026 18:04:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/60] 6.18.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 07:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.37 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
