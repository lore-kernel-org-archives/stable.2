Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D2346769
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014263; cv=none; b=IqH6Er48LC531v8OFdJa2yIa96ghtqn2vSW+dfMOLuz8IjTRHMBVnfPdk04P1DrxqWJ+DAuWH6/YjfGazXOAcnxXpLiPMo096cVcpLVd5+33FBiKYgW87/jkRO3MQ5tPOCSG6DtSviWFzSiyHvBZBOWh9GaNoGKtEB7zPL2erfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014263; c=relaxed/simple;
	bh=slYQfA95u4w9IfAmSQlot7YQrqu1NxdBnaQ4y+GqwuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrRLIurRmB+6l8qv/XXl9IfV5gI/C8mpX0zbzP8Igkd6CdOtUY7KZWqEeUMDoqEE2TFRSLaS7y0ye7V0WAz0QWGtWP9wD4NH28fF+ceNu+gBrtNujnXWrJUZyjgNH3125icVMXBoOPodnMFBDOzprBZ1W2iojcDXbp53HZ4HrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QyVj6LDl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QyVj6LDl"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb545db3afso845001a34.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783014261; x=1783619061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HK9U9SbnZZhSV1BjuVIdjTw4J1whSoiAiJpu28W0Epw=;
        b=QyVj6LDlxqHH1rUL8Z6wRhewKKEyWUI5uSElhl61iM1HtRPXazF23ZdoKlFowekMQW
         KIh3JRHHgFjPjmT0+81xUbU7PKh48neTNFHEhZs/Oh2Cn1wyB/JrushrWz8qEiCgO6rR
         1X6QDA+QEENoI6GQy5K/qDMK62pf29ZeRsBdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783014261; x=1783619061;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HK9U9SbnZZhSV1BjuVIdjTw4J1whSoiAiJpu28W0Epw=;
        b=PJrFXpEU6fC+61oH10MHM5KCegwQDZBMIGvnE0uai0Up0qOmPQPWlUgQ7wSi9VHWeY
         d8/BiOizio9RcmUuQVI+9CgleV78r7JgHorL2dzACLK4aTFoLaczcaQpHDNfJLc+A83P
         6dAUTSe530ajRQwxt9fcmvvRQwfbJL5hx1MCsuYTcMhgOxVFolNdRbZVORgM5AIYLFhk
         e/xuFtLhePL5g+88vHYO5BBHkAmPTtF18K4HMGhUUIl6QjXTxL/+LQvPjcC1bBx97p9z
         RxrcyeRkz/iIQk+GRl/yu+kBgScViUpHmTqEc8xU+n4D1eAuNcmjGoBUw/yW1n/gMJje
         uEEg==
X-Forwarded-Encrypted: i=1; AFNElJ/fwhN/FDdMguI+Stjq8mgLrbtm198Z38+9/Y8PuHKNKb3zWVygj+ZKhm7pQKa+YMG1/xkzFGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6RpxOaYCeoafQW4sufixTsvuXipsOrQdCoK28SiBx40hhE7T
	YpJyIxRDUnCs/HoB4T5EfugC3jc7IV8xWLB9pMXg91f9XuGj1elP8J6pcAekPdN1IHI=
X-Gm-Gg: AfdE7ck0iKQm1/vaL7T0a7Xwx516Nc1oLJo/KTj080WVQCGsU5uw6F3wBvZxxB7jI57
	TcSLs69Y4bdfcrzZpBuujj5uTCfplKGQdnJ2H5Fg1Kkb5R4kcxjIudzRblwHvAHajGKH3JMXm//
	2rluJEdJbLMmUV7apaU0EJd60TQ+jYRXJ7BWcCVYXxZMVlmjQtrAnzbysHdtjbRZjJ2VRQfH6ky
	1czzxceuLlUv+Jhq+gs+vWsQrjniv6MM0OXQcWx97QM9/wsFR+3+Aq2ueJtPbq0xRfNaEW6idZz
	WGOrH3cCFj00IZKR74hfvFSDweqIjODVQ6l5Teg6i5vjf2RnCe/9OWdwxfE9mjUJXTnM0Z5Y0sV
	CqsJxuV3fYuIGbTN2Tpzgpu4JRZAgm7GcrvZgGH/6k756eqSy1GRS3izWpbV9wmaL3BrpdpsKFg
	7463N/ei9pJYI08flhcqAfG3WdYpAtJkU=
X-Received: by 2002:a05:6830:6816:b0:7d7:e142:2ead with SMTP id 46e09a7af769-7eb504b30d2mr3873128a34.20.1783014260892;
        Thu, 02 Jul 2026 10:44:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm3026439a34.8.2026.07.02.10.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 10:44:20 -0700 (PDT)
Message-ID: <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
Date: Thu, 2 Jul 2026 11:44:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/26 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc1.gz

I am seeing 404 on this link. Maybe I will it more time for it to show up on
kernel.org

Same with 6.18 link - haven't tried the others.

thanks,
-- Shuah
