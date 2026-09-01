Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53D481672
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281163; cv=none; b=atvH8BY4R1srcr5SLJapSlnwdZpzhAIPIIw6k3bepKqDM+ugjoCL74kehG/uewloq3jab14gc9MXBOHLlYUfSwQ2PuKsHcMaOhbw/JBSRBy3JSJFTAR5cSPRogF0nBJKs4dBp6vg/4Ev++t9jP4Z90SuLMIzOF4T2v56jBDdw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281163; c=relaxed/simple;
	bh=UYUPD7JgwryIKNVtCnoJgUs9pzPFe048Yg5ClrK2qRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aH2fwclfTeH0NDrfVuYQ5r2fTvToyY1iFGPY2AP8e2qKjsjrWj0HR99UC2sVgLpnjAvZPDB9noTQEgK83hz8hhjvO4JcMdRg2ZuGKxPFM8IgR203nFavUMq/U2j9BPPPmnSCCYK1qb5Bnz+11T8tS/NlVQDz9ygdTg01tcTOaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aAMJ9WCZ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aAMJ9WCZ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-446f87b6de1so62574fac.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281160; x=1788885960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hHZXaeBv2IvcIvud5R7QHHLCYnONKsJzwC8o/GJ/kk=;
        b=aAMJ9WCZhL54dhUpwfuXozSZNHAvv6GIP9IiJNLofonZysP14L4A6sd2DMbDZ99VtZ
         j20TSqVJ1EVlkOQ/UK+Rf4W/cyub9i0bHZxjGaFPU8+XsS5B5dBUqIKhdRcgHvHAlO7i
         s2R7SyHcYUAjJYtUYh0s2NwFZP6u0iJaGE6YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281160; x=1788885960;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hHZXaeBv2IvcIvud5R7QHHLCYnONKsJzwC8o/GJ/kk=;
        b=KN8oqDwbm0XxRvVrvLkLTjYP8KdCAVNlWVy7fz4YAoigFos77MYkYdXLbSzkeUY8mA
         FI0JNa3+x0qBxMHOHHTzgKMbquTCPwBPwuvDg3wh831zD+WtNUKPhs2Di3iJDsq0cg/5
         uhWJMITWi3CenfDyUocXf0Sim/AhvDoScipd6/YMvM2aYOxQpew934tXo5QRbQuPByea
         xwi45dtaEqP8vv/mu8H4HZ0PHkMfNwFjpaN6VHm38CZOdXcHlQsaQTldWnQCeKOHBGIy
         /saceuLvQFrdL9qeSQa7ytB/VFeQ24G1F2EMPVcHxjKExXJ+yySLSd5ml/YuJBNNT5MQ
         WkDw==
X-Forwarded-Encrypted: i=1; AKwUvBwFrIsyP9gFVogQmpC/px+yuLEIRyDC5wXOcf5cTiDxhvUZvFJWagu779ZhwN0i7/v7i1LXSPE=@vger.kernel.org
X-Gm-Message-State: AFuF++lUXqmxPLZloB36AX1FZFWTNc4VJQe+Ur5Fih5AXf6f2XFRypHO
	5Qy+gWf7jJVVccxRzkzxqUCAOIovl8cY3rTXl4tvW4R9gCXdN8UKO6rLUVB0kiF6eFE=
X-Gm-Gg: AR+sD10L4G0xBODrx4joZJ3qtjJdKZPFNzLYAr4NW1lSYOdYzySySyq/jRnoMq1jUoC
	FDZ3d3WKLsQT5hcQlH2b6BaYG7Zu+D8vMysGm5daaV8LESGIDE3n/maHMPaYiJSuM+JxudHvK9h
	8c3B95UVnmkb9Uwgu6konp1nMhYW01ffsXohFNGvQNj27qUCYxZOrOMz5rPbquooVMn6n53YTZk
	ehdD8zslcIZrOrTUDTQwyXfP4xioH1QXmshWdhN6mUSYPSWTD4rcffgP0tGANrIEbuK7OnMJJFL
	X9A9qYttqnyc7d9gWRU1WklKIr90ifhv1Ztf/VIG8jWDkKl0LqQKvW6OUVsrEg8KGiF2dSSaC6T
	86dcxjq2cd52zYj9U+I+j2p7s6H5R37f7SJwEbxo48KwD2hzxYY2SNZyQh106bIYDArX1rvkqYa
	cbEaQZjKcaGKs6eaH3+3I4E/Wrfwel+yVfatIlhGXuAKoxe7Cd7p4BKUCV0IjKzXmWO4Gw
X-Received: by 2002:a05:6871:cc1b:10b0:466:ad49:d0f6 with SMTP id 586e51a60fabf-46af542e37emr6739032fac.7.1788281159759;
        Tue, 01 Sep 2026 09:45:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f336c72f2sm124082fac.18.2026.09.01.09.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:45:59 -0700 (PDT)
Message-ID: <08331aff-3195-47e0-bb56-dd4a5fde074b@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:45:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/99] 6.12.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.740409777@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.740409777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.108 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.108-rc1.gz
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
