Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF0390231
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436816; cv=none; b=XwGEUQdRYYOuqoYUrklpYKtivgT8iK6sdqUc9T92dYS9tB0nq4Fn7LMIhu8xy4GPufboWHuXHgUgPPcQ9M/BDaJ8WFMyRO+O/Dq+WDOGa2hkHVBR1RB8AlLVZ1Jk0TRL7OgE5U5qNuny0GPv+qNucvlyonfLrO8/oYseAfqRlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436816; c=relaxed/simple;
	bh=hy6fx6N3Nh/WxBBogRW5aSz2ZGxWvmhqsB9P6yfusvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfYE8Sso3Q05RPHJ9uK3FKo+dL83oAU82lE2P69AZb3P9QY7CPpPnuuymTQE0mEEn7G2tmzVwVduFLKUQ9LSHdixoEJb79IK7gb8exHXfcISgZ5cYZtOB1Pxjr3BwbHeG64QRDKP13AwhhrQKzE/ItwuUDnTkTjkAvTYUMfO38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwrpha8f; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwrpha8f"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so97102a12.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436801; x=1786041601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Ii8g7gfGJyZMSKYNBxvXh449cEi0V2rqHcf+jvAPVQ=;
        b=Zwrpha8fe3omvwIzvorI9EU5E02xNAmPejIXRuGuUi/V7hd3fB+pfNiiRt/gARhwO6
         OkjiphPWGHLOfFE1LJPsW1meYlbfZluyOEldckXeTaUUE2R9dLZ0627JizGDFr0PMZ2c
         Y3kk1Y+l8IXMnnqQYUcrG31qklLI5yq0xiX3+oZz+ZhSCwUSUkWTLN8gfMOmZHfbvM2e
         I41ch6Pi8WcjDMT55BAShTygOgpLgAAJ++3Cq9HfxsixXSkBHPtlUrhTRYxwpe93DvPd
         IjrOzQ1BImQeArQ7dGGfnxhr+2U172009OJj3GYhlhyt5D+RC7WCE6tY0vASqRtnCnWy
         2F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436801; x=1786041601;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Ii8g7gfGJyZMSKYNBxvXh449cEi0V2rqHcf+jvAPVQ=;
        b=GiBS61HNWoCHZT9xkipPwVba7niFXCG4Rs6bXsEHraiGt8vtLhjxirf1soOcFUrMeC
         L5mmbVUkoG8I+SCQguZ/Zp2PaCHX88Grz3vKw0SMXD+4JqPz6H/PutJPXPy+vdj8I7VL
         6/nDM5QVMKKyDoxti7dg3P0h2F0ka3Th/ulwzjb4tTJ7vG4vJWjNcTzBhj/vUy+9zltN
         kE49LS4zR423O4hUW3F5nVDvORF/y2fHFQe2cDa3y20BE6j1vc89UV8s7IinOLZ6mg+2
         +L4KO/8xQEfthVyC0vnwsL/t4K46ZtMn742912Ejo2wPwz55jk7xkolLXtZhdhfSwo9S
         7hHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9ZpbLYOAs8Y6D7t6CUmIlQmm8rR3+jqARdeh59xuUVe2Q/zR0JShxKxGGHk3V/5OjyxLt5Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ehJRjnk3k8F65ob+KSIhL7MY2P5AoghXsjq7+e8UAknYOWh1
	ET0WJvHBALPWTyZjplcaXmZJ4ksRpVeurbZqGUReRfUy6zYifnMRH44b
X-Gm-Gg: AR+sD13k2HCnGHf/CmSVmwsmzy/jOc87J5tGm8GLOpIwhX8ZJBZ3nKMMEBl8AmorY7P
	dkDq/DMWjg1SjhK77x6PmnUKFAOQInVAkabsE2EkdGki7KbylokoEvzSkjaR93hiBCa7LKrtbls
	CSKXONKv5FzSs0ztrV70FBBKXIzlmyWPkTd7FhcHIqznNG0RL2ROsjghCrBqxtpfyUBq2lQHrzN
	/tPKqHTzZUh6BR+ymsctqlzoF8qL+ngktD0kxMJyb/sKXuTYgClSioc5jxpCWx0Y8/XTQgq1xP1
	FmcAxL+w/bDqKSA4K3vykbLk4pwJfmdQWVNeA7Umet23uEHvhrgmJieWRnUNX0u5xbZbrAcD0Z9
	au6pRkrDXt+6+oyPj754wCfErRUtqYNLJv7DDqYsZmlzzwlxjwApbWJtIZHpynNzowBEWMNU1ba
	Ns5sk0wTv+rbhLv4ogDarykknasz/n0blP+6rraLAlCrGE+8EhESpgTuBT3fxwVm18BkXcVVsnx
	W8ip/h67PcG87A=
X-Received: by 2002:a05:6a20:7f89:b0:3c3:9595:57ef with SMTP id adf61e73a8af0-3c9006b6d23mr3663067637.31.1785436801475;
        Thu, 30 Jul 2026 11:40:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504baa01dsm25330548eec.12.2026.07.30.11.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 11:40:00 -0700 (PDT)
Message-ID: <e85b5fff-b92f-48ff-b33e-359c3f048d12@gmail.com>
Date: Thu, 30 Jul 2026 11:39:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260730141445.110192266@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260730141445.110192266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.42 release.
> There are 675 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
