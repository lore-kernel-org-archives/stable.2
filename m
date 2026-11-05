Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920844;
	b=AnmAcwjGDUIPw28brB8c7DB3HvstNFvQSramG42iem2xb87/tAhy9wMze6QpT+y/6BLk
	 8qldtZUneCekB+LqmXr3PcDbLxOFRoTSaMnnHj8K6qbJvzbitqKC9PO057TgXja+vUsio
	 v1w9BHeaoF31zIc7CLhrZxsU0KQrQ4dnm44gEYynWpd+FXM2dRn8V7HYgET3MVu8IUUoJ
	 rm7pVlClnWM2UcOjvnhRb+5d+H2BKgr02fAUofI+5MliWjCmhJLkqarSWEJ138GXLdn7s
	 fdK5t6buWeNZ44k7UijrwvHprCCsA26oCy/pqdj43Y4Xed0/N3LyHJaxJYdMLgq5IPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7TboJa7vOyFx21F/S29MlnKjYaribdRj3iyzdvB38D4=;
	b=PVVdgEbSvcKjfMTGs9dyPqlibCv7W8ZIUK6VOcymZcwB7amnlb6eTZbiJEpokYo9Aq++
	 ZchxvZDMlYqRivYBtRI+zVeXMNexkdBuYid5p/DDNeP/Fp0Uz2v0CnZ75qSLBTyurCTjv
	 /leSDnX0ZSP3JLxFWz5t/puFaqy4dzER/sbvoxN9r33BwDPXHe2xBEjW9jiBUd1g6MDCy
	 zMTAn2VFTaV/lQRUXMZhbyC2sOPO/Iza6vageO02QG21BY9JFSR/P1PTOXZWY9vyhOByq
	 6oE4To0yzkEtuHExjDuB30TqShh4d/HPVoZiv5P+/R0UFnUMQsBJvUMjfTH3onz537w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Sbhi7Bem;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE0606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75DE0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Sbhi7Bem
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70059e4dab6so60130eaf.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793920842; x=1794525642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TboJa7vOyFx21F/S29MlnKjYaribdRj3iyzdvB38D4=;
        b=Sbhi7Bemt5Hc8toMS4S0rRJ2XTLFzyPGH0jI1PTygk48WLjylo+FnbXK1IKakGxOxa
         ysCaCsIDBg3jc9KZFgVQKQNQTeREXL3dBvj8/r+a6+JUq0qMliQPfsLkoq7sKv7iq7xJ
         l1HbBcWLbFLq4djDTy744RksTIjLGJBbQ3sSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920842; x=1794525642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7TboJa7vOyFx21F/S29MlnKjYaribdRj3iyzdvB38D4=;
        b=ZSk026U/6PaqFMLKioamuquDwgXr1js3dgA7+2UKFnGvFLGYtqmRWh2JDUzOZe5ydY
         zcLlj2s+/h/C+f+fYrCYK2epIhagxY0i2LwuvDTVsCdZgzDotzdbQRUyWZWABaKLBfCk
         K0U7az+SzCL6/LSLrwmC7oG0Crh4plCxpXZIwBUcuTcsb+P2IMmKAiU6yfjSPi3dWqS6
         aK9SmlzEBM8k2GTRtq67xpVOZHYilWjfm/wXvFZppYetDxi+Ub1poA8nhVMqbUQXDJSJ
         6dMf3ANyGxLIWKZGNczGYcUvM8jOYc8D95kSTnQ/8TSVAZg6GYFc5SGdT++RgQlW6at0
         owNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCs9jM6n6c2eGIUmHE7CPFqNnV+CrZnS5hayoDdjeWxGmADvGmreDD1nOfvhRtSnJ+n/Z+PZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r2Sh57dnjIgOjqBjQQIrysCmr4sO099X9O5DNuB7cc4sfw84h
	Y5aSBL/nN9d4U4ykiXsr2t6cKmJQ+Q+vQIdXsUYkbi4wwpzGD1EF5GXI1zFj0xE5NBStmp33ZiW
	vJjZLNpQ=
X-Gm-Gg: AYBFou1RWqf0B1d4iHXPRAfAIfZ4uid5u7TArL+KjTAi6BJkoTf16iP77+1MfVpa2p+
	Ga8+Wx5EodfGm5L1X1kyXhjTKXqF0T/YTAWkAdQTnLJQEXeHxnPIDGEZ2niXaOzmjt+OjAoiLIw
	OCGTa596ueG26SmiQJLIAXMCTUrNHTM4OhV8BL/0tTfC7Z56s7qwfvd3CYiGRLThDW8fbmBnmvZ
	dYw0qIfx7kQx2lgIjwcdT8dZSyo3hV62/PEAQ9hEc32y+sv/rM5yeIwwdzHWOK8+LteSzkYkB1+
	S8x+jcHXdnxbswreIFVHnTBj6ykgaiR1Yb/KvKHPJjsyu21ZIqAx3etwik1voHQW1Ghj+DA4JtI
	SrEfpu/qvBKmPcF+oCTTho4jHClk8VzQozP9hpMA63wyK94WdZ4j1lAMm6AHYmbO6YzzdVjL8uQ
	IJjV1ZETi5F3BLIiw/osxRTpwC0luimkW7EKc9PDPdO0FhQgEH3VnIQeu08nIiz+hxN9SxbH4LA
	wLjqIcwYIDZ5rC7uDiMcNvO28EJLi1y6bwH7CpsHVqEaeFkJjIYCOzOtgv2gHPgBnzrja7M+xm3
	rBojI2JOa2rwx6jnLkGn7wpEvkDXLSrM62EVmAEGFg==
X-Received: by 2002:a05:6820:1346:b0:6fd:4277:16e7 with SMTP id 006d021491bc7-716e78e3963mr715043eaf.23.1793920842324;
        Thu, 05 Nov 2026 15:20:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716ea18a791sm484293eaf.14.2026.11.05.15.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 15:20:41 -0800 (PST)
Message-ID: <76fbb257-cbe6-465d-97f4-f8ca51df01c1@linuxfoundation.org>
Date: Thu, 5 Nov 2026 16:20:39 -0700
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
Subject: Re: [PATCH 6.18 0000/1005] 6.18.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261104211043.516122098@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261104211043.516122098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 13:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.61 release.
> There are 1005 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.61-rc1.gz
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
