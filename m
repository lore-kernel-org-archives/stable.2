Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F713B47C3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999474; cv=none; b=tUWzAmO+R/m22w4t3X38tgbKOYXm7ShQpBv1ewCCLjXM+yDuLjM2GbJ2i3lTVWDnc2+NgIrMQtEzjZR0PQSmBUZbAzNIB2H0UQR37aIHNPuEk3rRqUE76+tsQmCSsPFlrTZRRreroiyKrrEoa8iOy372Zf0DO5SQ/b1FBhbqdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999474; c=relaxed/simple;
	bh=uvG1pQDdAHtYTp3fVqKQ9zjEj4I3LF3WH12RcltAZzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=de56u0vbx8fdr5LlWIP6SP3bjCYNmRnhYEVI53Z1SBPeNFVD1y2LJPIZ6YOEfxGZN2P7yf/WzEi/PkHHFvaOJfJm+0vQ88IXoFefXupFSS1qjD3pUXE8Be+dhfb9yHdHVaAfdISa8hwIgo7jSkUZyJBp+beOv0UVUgkA/j6M5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsi2EXsh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsi2EXsh"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9087fb771d3so18538376d6.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786999471; x=1787604271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPDq1Kb5UwI/zjAqBLHoJZETNskmh8QDvEqMyrkW3k0=;
        b=Vsi2EXshEBjtAuTj8xvUjN3TDVpyB0A5UYZDB53DQ32fK19kEe8mEuq/rXotktr7Pg
         ZB1ixolPv11kY6kmI1miq9WPFNr1kwblM9dcLBeDFyC73vdRb9ZbGUQieuUqSTzdEt/G
         LnEzlJwa5ECeRguK0q408YW7nMR2szM7or1OJQ54G8TVEzDcU2Z0KtA5oX0nAM7h2jbE
         lFX0qWNOq24ZSQvzFqARkHDkXMiqUicFQ00cTJSBj3G7pY/9bKTkWEsveL9tING/Xowt
         eN9UiKmoIxhm9rRk0FadLgiuAWj0sci6VWh8iCiQalHI77cchQUtXj8FELnOJyl34F3P
         mwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999471; x=1787604271;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPDq1Kb5UwI/zjAqBLHoJZETNskmh8QDvEqMyrkW3k0=;
        b=nnD95i4Qpoao+Zca1Wa+0qY8UNwMBtcVoU1n05BhYvGomxDMcuBYALNWfO75c/tuKj
         YwbOa1HBpGXOzyahfvT3VXGDWzWncNlhaUn6rUX23cVwUaoV+27Jv43ujVPqa7jtlJKc
         4fS/Q9ZkcrfNbn5ndBq3QXZMXSserTERwug23CMXfbLNybdPAyV0eSaQUzDSFHovWv7g
         pF2Kv9h+gvWGki/pX1WnBb92BjP9Ydxumd0EWntAogZdSygHAp3/nQhJf6DbSAi/Slvz
         bR3Cm4LL8yNh9SpsV/pDhK/NY7cXnAJImHNDHIc9HvoebX4KV5FSVcIr+Pl+/VjqEGIH
         tQ0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpRDBwrqF0pB9W77tf6xiHKRhS+vdzajBSek/4xeXueBgKIsZKSp1KoXfV8WvtXnSwF9KadRwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYBgFPVqMOj9YP/rqZZQeJSZGjT4/iGQk1ozDEKdsxU3HQSzc
	cIqBZIGX3ZZ5GygjKVPo1FyTYlJdhMwtGAGlIzSD8aE715u+t6aQ4kYD
X-Gm-Gg: AR+sD12u+L2VR4jYc12H2FUt0V3EavZomlLY6+1OTT3nI/krRrvjeTcKatHrBOyIUQi
	2p/BeiEP8GQFotmKCiJ6nzpcey+waiBCBC2wbyacgJKcIf0itbzb7JPGtwfMq7sXIMF/Co2/Kba
	fBAIS+Mr0n5UWYon362nQeKJX4zjFRSGK1Aya2B2RsJiaHD7KpTqBBa8xP5xhM3Sp+8/4uFvkSF
	ToXUq5xIaSfld1xqIqQ/+aGsHTBgT2HQMs4LzajkQkJSqwzWIPrqZLvsEAh7fggJwQwq99VcMvF
	ztRTH8ntD2ZjKpFWTklPf/qxOXSrQ+j6XYh+ZLZJ1hnpgYnsmF23Jh+d3QvHS6PDgnPMhtg/4iB
	/AX+C2LZDKjJVjk8KWihrs3YoobtrGp8oB5IybbHF+6pF75P6KUfh4/x+ku2CL56xCsURrKL/OM
	PfJ9bsSljsTu6jM4i7Xw1K3SHSASWs6rViBDj0CFn5anumUOv0yNkwP7rab8zp2AGJO4pLTE9tt
	oXTLBGBukhDLYVK2/jpcdKQUQ==
X-Received: by 2002:a05:6214:4518:b0:8be:1620:a95a with SMTP id 6a1803df08f44-90c4b3f113fmr39253886d6.27.1786999471123;
        Mon, 17 Aug 2026 13:44:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45950413sm16824676d6.35.2026.08.17.13.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 13:44:30 -0700 (PDT)
Message-ID: <989951b3-37b1-4d54-930f-6f8a34631887@gmail.com>
Date: Mon, 17 Aug 2026 13:44:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/250] 6.18.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132536.466235697@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132536.466235697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.45 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.45-rc1.gz
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
