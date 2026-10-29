Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287202;
	b=LFdo1IwxeCBcUj9O1GxQASC/L5DdVf64HM1ZLJzknenY8twGfZ80Ad9RA+6dg19k4GJf
	 krlfwZSj3Gjg0rRYc/+Kc1ufdyvAp+QKafSPlNFwPZV0qajPjZ9C0ENfD8PFH95InyhrT
	 zZ+znW8AFIu3FvMuSwtd7nUW+Y5mjSuUDIR7BpmuP5KUF840Tk2uO6Aofo+Kp5WjXGpjV
	 /a0JSmkMoMeaZHPIhfzG6yoUd/F/AF1+BFjJ0gMN0dlYtXfswgqIZibhxesG9T2L88IEe
	 Dpxu+FQi5g6X/tPvSFxW5CkRtm2s9hJTWwp8Gk7mPWB4v1y/YmnwI6xYkOZOB4p4usQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=x473ufmcJ5W3DLAFHIuNnT5Lpmdr63e0NBlGNs5sk3o=;
	b=TlDsh5caxnK28Oe8hH7J33ypiPSK+7XolybiTszFWsMMKfUYY41tYNBg0bvA517pb/Sx
	 kTVQxtNcP/okDPE5UDpC89MNA/3L4+G4bZjeGA3K7Of+3x2Nf/x9EY/xvHLoFYk3jBjag
	 tbf9t14X3nTiv/F6ZvtJ2lONt2rP7KcZ0XEcE6WdQqZOJuOThoROQpsjP2UqjVF6lp/8W
	 WywIabSZ6WkOCx7r8vq5Q/ipUMqlGP6vSR4Eb2TiWCekwL/Dj8LQMhXZGKhzcfJtgVAdc
	 ZAfHoHZZPE4b+Dma3bL1GzEMY+P/HZSjzI0oXRPsTUbGORJv1V2jNVtIr59Ppx1NhoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=dMbfqC92;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E3606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=dMbfqC92
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-702fd86d674so1565212eaf.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793287199; x=1793891999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x473ufmcJ5W3DLAFHIuNnT5Lpmdr63e0NBlGNs5sk3o=;
        b=dMbfqC92YyXt2EJ6qqq0TeQI8ZcYJlvA+L4HQAfALpXt1DoG/dV4NajcMHZzAVNyNF
         tHvT3fbft+VzXRNllk1ys4eBCzRkDEoQATRbvjimQuyLpmAM6nUR+OnPZ4gPTvGlOMGu
         PrTiS8M1ccbzeZb/RmtdKVELL8JeIG1GVcmtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287199; x=1793891999;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x473ufmcJ5W3DLAFHIuNnT5Lpmdr63e0NBlGNs5sk3o=;
        b=UieeCpBmarc2lndSzV3nrgf8L10GZnp8/lYdx2GgmR/uPaVEikG4ZLPzyy2/nrsI8K
         tc/2R2a3WGPjlAqjg793kpTcIhsXD3E8SigPipSJzhaA7RfYK1wn3QLmoSqnUwkEwB/a
         IuVJfOuAQUl2ch12FPIOi1n5BXnBoL6YVcdEEnbcVYqxHcx3CRPtAyAf6DriErtqcxKG
         8Yd1HDLmRRGmw9eKuLaNAL1fEMxlzfvkvUP4nj1IQHriyJOPNAi0KhqTID71tj0C0U2T
         sOLmRJwSB3mqPfAygw8T7ilsc9Vkc1Q1YRwxupecCrX3ig7CyxLPpmu94KFtOmVZjq6P
         OInw==
X-Forwarded-Encrypted: i=1; AKwUvBwVCyeji4xTVNSiDm7HahXw9c1Tfht+JFptgWIBKYAnG5B2XeEsgxdGxWdzuMFN6BPtNt/32zw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfM+mNQWrmjmirsm3M1NjEKaWyNlfYLQhzTIfnhyzd0Z4cQFgc
	LlwxzeW3HfcHtdZmRrTGR0g3CpUkdKOTusfz6/Bthz0pqtk2S8AdzdZ9O+G9yGqQhfo=
X-Gm-Gg: AYBFou1CCMYiIzf0EQ8aetaRStm1G7oUATfDsasRt8caBe2igNyJErF3Dh2UtapVXuh
	sB5sKaZcN29KLFaz6EjRKgVdUoqSyQqcyiZ9cH3oFEt7hnQygXCPbhimPkFQNba5mYyaM2WhTFC
	j+pgmJCI8I1rRGX/25MO6IDxGXMw9SERplH97fqHsDtTMwUnzwrugZyA78zXan07F05Wdtk32CN
	8EWLQgtze209ZFeV4ET6jycbmgH2JJ7yZnQQfmU1PSSrjzvgy3DZgctjyz1JLsQE8QhAIzNUfT6
	osIIeardUczVJHNh3BZ3OJ7Mo+Tw/b/LnaEk477Qglq31D9ON43URVnHvJTX46vtbvfi8EOiEpZ
	EXFRNO20cDRypE2JNN1mIWyt3gw6tpx7bBUxNjeN69fYkrjYDCHpQnhWHhhAn76C9OE4pZTQWug
	nqtp4KjxVDFWjQjmFk9jSfRIjDnxOPKMrzWMlRNjWj6QTzolBkZ9P5iwlMJsCnmoksaTIO4uEOl
	HsLBunxqn0elYCnzPUjHiUQTpw84LMPwIkPEPrx89dQrg9YyalURVKOP4DEbP70rBzWq5o4QOQ2
	fIDItTW7TGMgIqTN4xT1MD8WbLE7bbWYlkJDWA==
X-Received: by 2002:a05:6820:1c96:b0:6de:d2c1:e95d with SMTP id 006d021491bc7-713f01f0633mr3625060eaf.72.1793287199393;
        Thu, 29 Oct 2026 08:19:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b793fe7csm4994076fac.15.2026.10.29.08.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:19:58 -0700 (PDT)
Message-ID: <d6d7f806-c771-4b8b-aeb5-c3e1308780f8@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:19:55 -0600
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
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028165942.107695352@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
