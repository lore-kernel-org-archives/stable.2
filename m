Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D31A3BED69
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302180; cv=none; b=cGC0AiMIFDRK+LBvSAdKqzYfmz26FKsPod9STeiCUkqZZ1Gj/rRmVkWxqE7pDMiT1jO2tmZcWH2jbysY2vLd0W9CEqR/vbTF1IIQuRFM353xo2Zec/uqskdDn7z1CfshY6fPPRdf/R5dWUztYJP/ixyMhX5z2enxrwFyuBa3Pn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302180; c=relaxed/simple;
	bh=GigjgsAQay2xWPGyyBlPHgSfJeJf9hQ58iKnrfuKuug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTr2HpbF+YojMPly1qPe1gGyDMwVBbPKkDe2DB1AyNRweCe9wakqIot6fvt/cD7+yVkQDVA57zRvCKJ/na/el8m04Jd9OPglOa0DjkjED+6kku42aZhJlHPXTwgr3VVPgWOo59vACssN9a1sqg0I4fPYs4wHbhfdgEl6ouWH8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z59FjSia; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z59FjSia"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-499f6e0bbabso3225478b6e.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784302176; x=1784906976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKfqwUoLQDCcY1DVOzAXCStYSm8mMQDKjMof8yWpr7c=;
        b=Z59FjSiaFo2fRo+nDWiIbO+RpRqzo0RrxjbqDfooQwHVPnsJ5bxvT93O2AYddiN6q6
         5YyG4hJg0u/rb/ZaZpYLJncn+HxTUhL0Ps7ZzObF+QhA+gPcMNEZ1lekOJNZ2xIJSs5L
         eXhKft1UecJnmA8C7VYChM/NDX6BiNu2+Ai8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784302176; x=1784906976;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKfqwUoLQDCcY1DVOzAXCStYSm8mMQDKjMof8yWpr7c=;
        b=b7W8/4cQgfJxxclDeQ3ztHadyL4RhFzqbyXRu6GOWsivTJnhZ9SnVjoW6/y1Mq/GaL
         Sn1DXDDQ1QcmlNe1YtihUiD1s3ahSjDjJLmn1FGLnBpusUYBHVBO0qh2EJuS86jthrp5
         k53EXXQJMWEHw2m4oysOBsCNQkTBWnrkkAnPc+UdXz2UJEIQqJ8pp7mVL5LpwwwuuJ5d
         0KDDJAW/8Z/ceHOgzk79eHOp4EvLKN977Uc89/W+VbJ2xwH14VuJXTuSEC0dKAzfZiTm
         kdHEVkVrqoPI0wiZ1BidKPgT4pzKTpsSBqcd9JI5tHsTnO7xoCHW8pm1JVCEPySttpvV
         P/MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpb/Gb96iBvF1j2cZXhXok1IrTFv7KfqWBZuemg8EjpuHFcLzI3pY6ae3fH7ohAul08num43os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5IT9v7dSVvtJgO4P2mDKl6DGKvBd7gMLkiIh5M5bOMxKQnqn
	YtwO6nq/fARkFd3maPcMBHz0yGoKxbKjBNQPW1GFrKqGJHmWet4im1VcHcOTakyC6KI=
X-Gm-Gg: AfdE7clCl4K70+UEw2eyXDiS2IwEzF2kNPH4q52pvmOmHBe0lykOrc8RvHgR5PwWgCi
	USzFsC3OFZHR0ckvQij5ZakAP6l/1aOlo96ptmGR+bzQ/gTl7dCEB83CYnT/yCUenvMNUITpGnm
	chft2Kh2oVQECSTQshKrE7Frggmc/fdWOa4JgbKTD+VDSGTXqMsqyw/mnUzSHWXT2+5R5mLdhsd
	kIl7FavyhgHoRYtE3xJoDGEJ7EljEWCvYuK1GlEjHhWw50hIKH223S5bs8frcIjC77XfkxjSTwk
	YdTuUpTiP0XP+bGFwStRp5qzTr8VPuWIG94FnQlZO63N9gwrALf2sBy9+z++uhtnYgq/IQc4+Ve
	fsaVhHD8Gju2j8tS41pmtPR59PPXukcQ6+ULaSyBOQeV3DuNDIlET/h0HGMUPC9FvyFHQ6wCcl8
	EPUQLLVNwawHw=
X-Received: by 2002:a05:6808:1a04:b0:49b:9a35:f71d with SMTP id 5614622812f47-4a4d0389a1fmr1375408b6e.30.1784302175977;
        Fri, 17 Jul 2026 08:29:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3a57b0fsm1003127b6e.1.2026.07.17.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:29:35 -0700 (PDT)
Message-ID: <fb873910-2073-4121-995d-93cbed621c4e@linuxfoundation.org>
Date: Fri, 17 Jul 2026 09:29:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/480] 6.18.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260716133044.672218725@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260716133044.672218725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 07:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.39 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

