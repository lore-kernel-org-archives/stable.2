Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379341754
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703160; cv=none; b=SYEC53YrCU2WYTqnuHAp36K8HrwhauJNao+rVz3CUZo8LlOhrfbt9Yeop6Wmv9JmhKoIaLrFxSmx7VNTjjlWF5cMTF+NL+PQYUTgbk09y9lwQopg8pSxcSnZgt/mj03K7VD0Dfy7OsoLCNNHGhERuAnYZZcJWljBUkFK+4sLcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703160; c=relaxed/simple;
	bh=AHg3ALect9MWamD34g2iatsGrEFzW54Ua2w+eP9s6ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndBfOVUdWObAMoALl7CmMcsJpNaHdb9mtsGQd/H7IcpjDqxaL+8a68PVoPSYdzzG7HPuriJWPYBqM+dSjVnK8Otso/WGIWa1Dw7+P/Q90pLbgOir9OOsK7LwPuMtRjUPbeSN3o1nD9+UG5LXexSGUyGHbaKWZxNTViWoxZljytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsXahTSM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsXahTSM"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f4b94d72acso347362a34.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787703157; x=1788307957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwKsdY7lSw4NPr5IEq6eGfRhtrIkXovdxO3az9ib2qE=;
        b=bsXahTSMV8dJX05SYe7/1uN53HT9zYGYybne4Y5It8YV4qG+xaC6My1e1lJNehQl1M
         5ayBVQ+DCNcV2LXsAxsWAAxQf20RwLzPksS2dBVlrg8cX6/fvQYhKIyEmCdZgLfbnn8r
         lYbScRE0vYESR3dkWs2OmpPmt7KGKrfG4idAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787703157; x=1788307957;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwKsdY7lSw4NPr5IEq6eGfRhtrIkXovdxO3az9ib2qE=;
        b=Rg208w3Sk8avH0iFNKANY9V7FMVHBvRYIKtIb+kDo1tmgFMwUI+gcIISj0jngxcPyE
         BsTUYuhgMyOtBBP6QbAzdpkIy9XGvwU3KBBt07e0RBPpN6FVE2f6egO16kpDG+06sLU8
         p5mlrzy8Owzn9LlIa6dxtdCDD9XHPYoIP4CjwgAUZDFq4gksgbGLkbG3rBjF2WPpnxQ2
         T9jK4u1NT172C7BGk10Gf+O3Yz4SfLJVJ2gM8sUbOXY4KGd/G8MWWR+GfVL+39e4+Ypd
         fjYAIiiz/4wtarpH22nZA5QdyqzyKa+0zG1wugTdGqwCk9NSAgZ4wztZ9s3U1SbNVHy1
         W5Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpuV4m81HobAXmgK/A9DNTUOEnEDl4XS6/1tGREYEo+6YwKjBmILTsHQssyUExDsYtDr+Bbb+I=@vger.kernel.org
X-Gm-Message-State: AFuF++kSWcXi0ibx+NOovgnGCCz+JRFzxqRvaYwPv2Q7znUIJ+MP+/9S
	0b4gccZPw5FIys5G+GVs3ubMkTHAfGjNLEQnucgg/AwwuYeek3zPbYKPm+LB7+k81ZE=
X-Gm-Gg: AR+sD10NmgkRBwLsGIm9CrKH6J2Frc9Ymc24hSL0e5gThLmIXTOxfMbS/lx/W42Fu+z
	V3Asxh5ibe5fn6jnIKUM6Ng4U/6oQU2BR6SlbqSFVTEcyAvh2GQar+VIppKA0K4IRKS/lX4BEwp
	DC+NvcHw41MpXLjfRogIaMc6UcrrbnYgLw1I7imuM2ZdXq/6azAGk5mflqb0eSSvIO6H5RVyVOu
	lUInKd6GSiXLNYrcvxiNQk83dUYFqpQ7+ZISvmgUtoGTAdYdvM5paKSQDnhetQO5NpIZT5R51b1
	6wtIg9seU86wWnBM2rd/qKdKXwFye4DMsfU+WWBCl6ktwMYJwm4CDQckZSbkqNh5OY9XWcNpbjP
	MFLEjP6A4AsMzrtsJjhVxWTqo5iWCKbpp7pALdTWGtI01/4iH7qobLGNAYGno/c7NABvpbdiORj
	hDtoUj7ZfYzRnPdPdalduHfbGXggO7g1jXVCxjX4LvtMhZivnW6ADh537+XX+MFz0EMu3U+FShg
	Xc//kk=
X-Received: by 2002:a05:6820:2016:b0:6ac:9729:6710 with SMTP id 006d021491bc7-6b1a049e03bmr3104301eaf.18.1787703156730;
        Tue, 25 Aug 2026 17:12:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a268023asm346821eaf.13.2026.08.25.17.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:12:36 -0700 (PDT)
Message-ID: <bde7c5ce-16f1-4c9f-9e10-894a754db7b2@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:12:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/87] 6.6.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.813800447@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.813800447@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.154 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.154-rc1.gz
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
