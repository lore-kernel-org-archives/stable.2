Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D870409108
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724014; cv=none; b=SA22ttWICcX+TIT4lKt8RhkDqa4sCMmUC+8Pjs9qD+3nmtW7hE1gD3pkOSTWN8E5WWc0ipU+Dyj39z/jq9IpAXADi4i8hmXtVBGWP1UtEjmCyACfOIL5Vmatd3snJ8ydOyZs4mZl1nA81LFfpIS4ZJKhzeJjMkTHrR5zToFNP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724014; c=relaxed/simple;
	bh=XWDly2bshxB9+r2/vatmL2lJD5sH3CtBSsQ7Czp2trA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGSjJmDlUDEchaka6rgU1+GZW8Wqqm+GNUbnz38Gk9y80fdNxnVccf21Jw6O0DcibD/A6h3RB0ZA0tEgmftV7MGn9lQgN5D5tKw23H+x68NN1A55GCRTDwoNt1iDoR2WUIg6pvLUtGFcZIZvruxxqq1lMrmcoXn85c4oZWmHMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmNWm/uX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmNWm/uX"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47df6a5202bso843050f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783724012; x=1784328812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZMuJmOMRKFkwmQjMCN1ntzaT1XaecLSvQONyrn+oG4=;
        b=YmNWm/uXDQQBet5OrbduqQirrK/7duWy2BKXHTGYyKoHhcnPTb9HaHt29eW9OvfKwj
         8qDcQ2mn5sxUWRWPGiwPkzvVO4L/jldp7jV42Sse8cywZ5IG8FnXMSiJ1/9j1cEO9674
         wJuQqcEDNpB+VnauoG8ETxR0IA9ZB97m611QYh0VtTM0FhlT7tZWquraZb8oy5bAk5Jb
         v6iqPJvs1eWJB5sZ1bkWaQd8UT6jGDyHyiJGR0++MIh8YPnrnBTJl+ANdgafMcwTfQOv
         7IyhD0dFcKppC+R6nRfN67mFEg0BRAc/ZMwQBZMnLvK/vJGylxb5VDMV1SL/WW2HVEC1
         166A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783724012; x=1784328812;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZMuJmOMRKFkwmQjMCN1ntzaT1XaecLSvQONyrn+oG4=;
        b=pb5pyfr8bJqEaxFyGHtLvFV5AzjtGHR1NyG77qEoXQNMyRMtQSej7QKw3nlH/n0LkZ
         BzzaTh7miAMrxF35DT8rY9MUigzxfz5FQuFuhwpZeHnuSaMOqZnd97PSDBM7S255Ibba
         lygd99puzvsd1+YO5dUk8IZaRoN3g6gK2t8cJcVMlXnLa9yMaA35WezXWSIOsvQ55KtA
         WMgjO1Rf1PfaW2gXAgvC+F8jQ+C8DVk+vGwxOCrdg6gNOGUwds1qZwtxsUk2M0ctXVmg
         TAirDM6FlGox0JKfTVzssJti9pImtJWIRgWNzzFECW7CVpMiUPlP4u43WosDSf6tXXvb
         vCfg==
X-Forwarded-Encrypted: i=1; AHgh+RonfQNQOka+InBxLMQHRBqSZ2rxvxpC4Carfk2rKUnCARX0oEm/fnXvFiqF8O/H6otXKdmohIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDAtaf+iru+UjYMeKR6Hl6MRq/yt2RJF0Kg9haOqN0cIDAj8Z
	SwKvQULwrA8KzW0SrQ9ZA5rB/qpFqbmJaKd2Sdl0lS1+o4gvWLVFfxeX
X-Gm-Gg: AfdE7cn+MlPp2nZTrTxN1SseoE8t8I3X95CdlzNU5E0i/2f+lrIwlsNzDUGK3dQzWhj
	U93HwpZpjhk0DqIXCphYhjguvbczdDkEZJla1I2zKFAGjMbn+yHBF+84Kl85fXatg82lhL3gC+K
	VjRj5d+RQhVgPm3ta6IRMHBgrF2SFhfMimDrcW9yO22586Cv5En5TX/9+287m7gwXrB9lg7vWWX
	d3wZ/6zTX7wPwzz7U1HYuPYl5HDCPt/T33CvG4+4p/U5Z3cqPYRS+Ln5DLAY38cLglfZF+CFJ6C
	3HYanBVkvhdL+9jHDXX5iZ2lp5qNDDOLrZaVGumLwVGZ5Jcla/MT5CwKOcKb6EDmfFpbqj6JXGP
	K6JZB/293zRxiDGEXjXo/CJQPHpx5ZI1fG5TKi87yTr08gizkXMYBCWaXrNFK18nLsU5ZP9RfcN
	RbzXh9YcuvGBn7GvuGyz1I0P9L9eYaeOjdMlol+eFjyYoDe0bsO3Tt6FJZ7CNtsOdY8RX0Os+2t
	kF9Y0rczysZ0YM=
X-Received: by 2002:a05:6000:4010:b0:47f:2baf:5e31 with SMTP id ffacd0b85a97d-47f2dca845cmr596773f8f.1.1783724011546;
        Fri, 10 Jul 2026 15:53:31 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f113:9101:fced:7ed3:a061:c995? ([2001:9e8:f113:9101:fced:7ed3:a061:c995])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm64826572f8f.0.2026.07.10.15.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 15:53:31 -0700 (PDT)
Message-ID: <84daa623-6767-437e-915b-933dbebd2e8a@gmail.com>
Date: Sat, 11 Jul 2026 00:53:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com, Florian Fainelli <f.fainelli@gmail.com>,
 linux-mips@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
References: <20260702155115.766838875@linuxfoundation.org>
 <34b7e26f-df63-4523-b4d2-5de13c192a8c@gmail.com>
 <20260710163023.agent5-0013@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260710163023.agent5-0013@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 10.07.26 23:03, Sasha Levin wrote:
> On Thu, Jul 09, 2026 at 11:45:14AM +0200, Florian Fainelli wrote:
>> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, same build failure
>> as 6.1 for MIPS:
>>
>> arch/mips/kernel/smp.c: In function 'stop_this_cpu':
>> arch/mips/kernel/smp.c:396:2: error: implicit declaration of function
>> 'rcutree_report_cpu_dead'; did you mean 'rcutree_prepare_cpu'?
>> [-Werror=implicit-function-declaration]
>>    rcutree_report_cpu_dead();
>>    ^~~~~~~~~~~~~~~~~~~~~~~
>>    rcutree_prepare_cpu
> The offending backport was dropped before 6.6.144 was released, so the
> build failure itself is gone.
>
> That still leaves 6.6.y and 6.1.y without 9f3f3bdc6d9d ("MIPS: smp:
> report dying CPU to RCU in stop_this_cpu()") while both trees already
> ship 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single()
> on PREEMPT_RT"), which is what exposes the MIPS reboot hang that
> 9f3f3bdc6d9d fixes.
>
> Jonas, could you send backports of 9f3f3bdc6d9d for 6.6.y and 6.1.y
> with that adaptation? I'd rather take the author's version than adapt
> it here.
>

Sure, I adopted it accordingly and sent patches for 6.6.y and 6.1.y.

Best regards,
Jonas
