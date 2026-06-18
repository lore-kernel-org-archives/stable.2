Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F33B4EAD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783214; cv=none; b=gCh7wDFt21HxESdLtIECq3edOut7NYVln0iAhtx+r9FENHbAmckfL+GhYXY60NAlZuyccT9T5zgY4OfbphasgDBxf6PnF34M6fPDAVGvACwEba/Inj7RpTj2iWxHGwEz3xW3PXq8+Ovpa9SmUJA9UPcYrAJH1bRFaeQdekl3xYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783214; c=relaxed/simple;
	bh=vQ+HAki6E8x9KEeaRuveOCb6/8L9j/jcZH16cNZ9uss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx1wJfWinb+Qlowm3ihc+vVtGnOt4rzDcAmKlTDleKuQ1yjOYL5FZ9eWcuGeMsp0x9Nt8LDSqoKfNwVuIR6e79mbGiN7SKjFoYMQO9AmyJlOIa0s4JyuxPPm1TBZqVFv7Ury0RYQhk4J5eWMFDkcdGnETyWfdnUxo1LdpQeqB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geEHwbQP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geEHwbQP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490afc47455so2979515e9.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781783211; x=1782388011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RcPJ5vmiw5p2JNiLjYZxK1/VIU//IbyCjbXLw/2zm0=;
        b=geEHwbQPKpRD41vdZVwcVbbHwhDp7823YWMJOpFsYqwcsWcbqWezVjOEKiY6qJ6eyr
         iJUlz0JCdqXz5bsVM6gZnC5NjGR3hk+5FWHF2mJmTDebBFggwgJlspcDyHyjpN0aYke3
         OoziilNcETj5t9vtb0BKPFaulOrlwnRFma/PUwX2IF0DVHDtYL2AMvYMgPiv84vPWuDx
         y4cBKETT2uBhaZaEnDUiLvm2P0g/u2jIsZ4ONbsfTC++YvQ8H/v4MdgDn4P+0kIiQq23
         cpm5bHtR9JKbqX//TeskksC7WOI/EkshrAKTcKfcqGPWZ3FjBB+Izlb0bQUuH8LLirQj
         iT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783211; x=1782388011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RcPJ5vmiw5p2JNiLjYZxK1/VIU//IbyCjbXLw/2zm0=;
        b=Qgz2nTs/NzxyS18PuCG3SHP2ZGhrcfGyCEhoeeFfGMj3qItppew12WL64KIY18VZqC
         EN4uJn4AzFgblQGyUYNrvAWDj1ab+VHoj7GzgxePoxyjdMaiYMpqvqxlQEb3fE4ofiWe
         UKKT+8BiWLUkOLTjrtGn+gGzJ4uWHm3J8z4ANRFeeMiBRmB7mSetQsE2XsfspLh8doCD
         JIMa7SPTWJ+eeJCF1w1k5bcJqX+/ISdRqBa+UAuHtFp2JSBdOoFgq94E/wHPhDRWIizA
         fU5HO9rUbOUqDBh/+0EgDzocGmky1/NrPdfImzd8ph7oNhhdAF0tAtfUv4X+8evKwrsk
         COjA==
X-Forwarded-Encrypted: i=1; AFNElJ+8eD4zY9+SiCOkWxRW7imclOj+vOw8g6FJCBABm0fLtJWlKa2NXGd/V7Vq2X8vDhVYSE8S1TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PGzmHMSVf8nnQPT0cE9y+ilqgx6ti5fXyKSmW0aNvfF2qsEV
	AmBxSjLIQSOrUolE3mSmHAIh47DOWc3J9XAJvv4mF8efW2g4GT9MMSll
X-Gm-Gg: AfdE7ck+ILtqjXYotggyjA6pEyjrhDnYCX1ZXY+5QjhiNLlk5rLEe6ZX8N0nt/vnBYW
	wesbKEHRyQv42364CoyTsaJMH6yvn3vs/ppK9VRIn20Sm9DbXtvhvKZNyOfXjXo27yo/SyNlkhr
	DkFs8+8L2oPmMDSjUXIlIYN9Es2uKKUwn482M/ksoEF8kUDtyJKEO39FG0N8ftW7zuZqePdhuiI
	iGq/0k4lFes8cX2Hh+zV9wH6YWvYwmHIyTw/A0jROp6t09EokDEOsgZM8zMF36YcfMhph0v9Ws7
	fwClk11u7+iAGu6CkPuOJ43fxzAcyTE7x0i+LytxePjk9ZV7JHM+fZ3S3NHQs3fgT5QoBI/QtW+
	4DdDS1/aePtp1sOMoXRZ6AhOqTtewZBKoE+TwBWoVLrZi4BDls4K/GkPuZcm6BPE4VRpl094fe0
	HRNRbqCl6b0iti6oMNTLIYB7otXMISgg==
X-Received: by 2002:a05:600c:4715:b0:490:b446:fb8 with SMTP id 5b1f17b1804b1-4923a97f870mr23146315e9.11.1781783210900;
        Thu, 18 Jun 2026 04:46:50 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm62440164f8f.3.2026.06.18.04.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:46:49 -0700 (PDT)
Message-ID: <f9445527-daf3-42b3-81a1-8e0b01e275bf@gmail.com>
Date: Thu, 18 Jun 2026 12:46:45 +0100
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145044.869532709@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/2026 7:57 AM, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian

