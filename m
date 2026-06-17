Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E5374195
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717620; cv=none; b=D68NPgXqQgDoRtzRd3m/R6MbjTXg+lw9TZ7gmjDd7vMe0aPShDUX7/cKfpKox6ypfuZJoe8Ay8hFSiJrqtu6l6K/SQaHwYX2um68GSLGcisFNcP6zqzbbDci4dFSSr1dylETuyn4aAAdW5UnUDgpvKlrdtGNnOhFYAMqHLnceSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717620; c=relaxed/simple;
	bh=hIwmC213wLcSWDqxTttp1NyeaGwkLczVuaFVFeNnVSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm1W8hjZSZQkFwkGBs/W1HDNJ3o7xm8XyamXwnNfgBCjB4BYrz2WlXu3Slm9zWt/VQY47dMaDMwmjCg8Ywt+AXyxb6TwtHdEqtf+dDShYXw39uxjBw5cJAe07mzRrqpnsgkOZrfYDlBdn+8fF6+Rf8lLG2mqKlVAP9vYgtapUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC1fsxek; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC1fsxek"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6c047c6bfso1958a34.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781717618; x=1782322418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rf2iG4MQkM7iTLQQTt+KD2Vw29aqWn38Iccwsy09sW8=;
        b=WC1fsxekqt1FbOQvmis31WZrw67bNq5VYuTp+jx7UXdq2GP2DBiq/qng5oGN8ykIFY
         wQ7nyUg+dajeXGxZ+1D0MuT8uMuBwO4ZaFshYqPLGKuaf/07H4iZYU8weWNbllbdTBG3
         kCRWcJf4gjLtsB460K9Z8ryPZBGPcuJyno4BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717618; x=1782322418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf2iG4MQkM7iTLQQTt+KD2Vw29aqWn38Iccwsy09sW8=;
        b=dRC2auUiZvRgzC8L53WY2pNdNZJWx056T2J2AowVPIkxn+326JyV0qyr3Ogm5vlOHY
         DR08CADGNBBeP49+bZylpFSXpMbG2F+Hq1f9Wj2elfEwZZoZrOCMCuN1Q1a6i9gP/Pdl
         SJhqriUzz1+VhbmWRQyljEMfsfrOc3NrZ/2wbyhrTZl0pue4kxb1DcdIuo7YM7LDYeEN
         qDk74K1tGZJlgvIDcWsj6CGDMww6N6MkgP47A9jTnqTU/RiCuHSq0Siquiqo/oaDemXQ
         tsnY8X66BhTwQPqfpIaxKaq4/Bj9QQ18JbCLXwvHbHju83lettCUZuPTLz4neoqDcPp7
         c+6g==
X-Forwarded-Encrypted: i=1; AFNElJ9WVUJ4klklz0E05xv11zSYBirzk6HpFr7ktm1b9I1HFs9OHpPY8ha+05Oac/UzFQM9Qpb8ZoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPST5PfNykOOpvt6UyQYulQvQ9hB5pCyoN6DivLw0gQrC5yXDl
	WvKpERg/L1y3YHsv8T9xJJnjcFZd9zhO9V047kMXym+KvZWZfwRFk8LiiH6qCz3OMOo=
X-Gm-Gg: Acq92OHl/cF01pjhFsJ2AcrYP3qh5rFqcV1hmJoZjJda5NYMi+4O7ATorCBPIgiSDbO
	wp8CpmHq1jBCdQsmJLz+nYhzg1I7k5jg9VSDVszfU7dzUI93MX1DeKivLGHdDbX68rzM+mx1cvG
	leV5fRhc1tBc6OGhxON0ujI/B/qVSYQchlCk5kuWtMosPH0Hl3n+v3eA4yD3Ola2wKNf+3ECaI3
	pq+7ZvUysloGLuSSPMDb49aC4JCuSHkn8y8x8T9yfyPdsfVkRtOqrMkqLJ0i7w89z1EVIe8JXG9
	nZaIGBE7HYnTRRyLCxL01gl0mi2ytp6KeIVxcr9fHlbgONWjfnFrcqcOLS6pQwvv7l9TNOs1wRa
	+OrGPY3sJMO++XKyDbufXjtytyKPNm/O5TH13yoBdwVRtrqa+LJmL+glhIOCILNWhZezvDWRFxH
	fRqPY29Wds9CyNG2+sAy/s
X-Received: by 2002:a05:6830:230d:b0:7e6:fe3a:b777 with SMTP id 46e09a7af769-7e90b38a99amr3923302a34.13.1781717617577;
        Wed, 17 Jun 2026 10:33:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a1de6sm9605897a34.4.2026.06.17.10.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:33:36 -0700 (PDT)
Message-ID: <4fc2c04d-e76f-47bf-ab7b-e02e39ce2bab@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:33:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
