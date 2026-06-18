Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F73F0ABC
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781278; cv=none; b=QbZQ0Crt/S3mQvSxnrUCWmUJ1uSH4b/L3OWHYEICog/He5OG6eNtapm0p6biotpovmmcCzJw3XrT4saMfZNXoOTskmJe6PB5CheayWJ4TE41RBDG8Iz8Ps9xnW0uQrvoD1UujlaB5RRThT4ZCe3o1mON8aXTX55H6xSLOH658xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781278; c=relaxed/simple;
	bh=0xisGoATiu0CNcq48G/i11ypGmwcHZBkKbRPSzbckeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFV1H6si5opwysutFW7TFVGljET+cAnFAarMYFbeUUbTcbqV83PNd97DqxFqzFITmQUddbnMGIkVRXWAjXG61W1Yi5vmOSSMbB2DqH9NDoBaA54mT3lu5Q0AOVmm2xjuujd9Jc9miDZ+iGjKJScC8cKHaoJoglz4oR7Hrab3hqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdHOPrIW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdHOPrIW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so647230f8f.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781781275; x=1782386075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXeyrG62+aF39kKcXSYXLiE3a7D4Ivb39fzeBzQrUlo=;
        b=cdHOPrIW7CkLt0cUKuey9H/eSPmzExKvmf8bfwDMDDm6ARotg5bmPLWChAVHVZAGFV
         5N2T/zWFhAePYrIbd8CyyxCvJ5iZqjsLnlXzgl2wdP2A1gZWn0QmOrKfOrY6lBKTuVSM
         KZXorcp/nf2nT+OjcLGYMbYN9Xet6BtumWoDEB9fSWsnjR2oWTnlL+JUpcLEtoQttzHR
         pMdvSfhkbaz9rAoO282zRWyhOseNICcHlfq6c/IB+vBrI7y4f5+UZWqRigRnrFuv5fGk
         3BfC7BMUgFS6Ihc5yehg8J7SijDFXG/kC1zt3LcSC6dV9laZZEhHv05tfeYPM0SYXWp1
         Or/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781781275; x=1782386075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXeyrG62+aF39kKcXSYXLiE3a7D4Ivb39fzeBzQrUlo=;
        b=ce8ZbWfKy7ZA2UWCFmAkEBzQj3vWycckXXw+1WZeUDQO3pN77O2dfptyGE4793ujZ0
         O5AShdMgxO30gt4DIg+Bp0jJhBVYjd3prZCH5oktcvkGtW2cOFhe4VM/dC3eMiuEaPZ9
         UGMIuvsL2rrvs9YeXjO36mMoFu9adDG28yZM0A3bp/Y5Tp6vNiKUkk4k4tpZjuCX9PA+
         2PymaRb5ZROyPYdj0c2bGNjVjPmYQajzAhjpk2C/RqFbmWuCGXPLtRYjZUZ7+HWJ9qjM
         9vMddycY+wUhSxkKtYdka08YJ7gmRf/qW5QugYPZpKYBgT15x92Cr/kJpPrWhz96E+Si
         6hJw==
X-Forwarded-Encrypted: i=1; AFNElJ/OHfyO4c1eQP3is0yIMH1hnvnLM2hlUelyDAqzQ4UpJ7T4m+WxQR4EZephHuhKlbi8FioX8to=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAN5Zjd7M8JokoQc288DrEqhjwIQDzr9HZRT9Hfhwz/XxA006L
	q9kyet3+uddwV9iiHq4J5oPOgJa8C8VgWCnahFXVaUD/aAYEXvtPMbUJ
X-Gm-Gg: AfdE7clKpPRsEqIwchlBhDYAi5OmRTF8MD0+9Y4ZejtYskfKJ777KtsvdHrd6W/EQkZ
	xsDaQrkD5j0qXIJb7sCSAtay3ANWmkonkYleB3OUYXqq2sJhDXItJwFiRpJ2RmqOUQifnhfknGO
	N/472yziFoZoYWYQuU8DRlpdCJJVyfSNNCwECzm7h5itpYV9UejhRu2LS63VUof7kzrFasNbreN
	hgq2sS9+wRztId0DkNXbyOKR9bWhTXhQZlggbCgBWjMhGJ7CKRKGDPtPikNvLs1MILPurGvdNZO
	SCN929sMzRQ5u+UASjfNszXMEio9qMKI1gq9M8qceaLStZt0Qu3VfvhlFiAXsOg4/3YPTz2lFxE
	TWCZzliXUcd9PnjGbhO9gUUald84otxdgXq/RzYOGCXF4O3FkoJJT3Mvc36nCMZaUPY8hqkcDJu
	h5uTjyKvsc69VmmkBVJ9pPIYB/B/8Rnw==
X-Received: by 2002:a05:600c:1c24:b0:490:c2a3:1782 with SMTP id 5b1f17b1804b1-492333f8042mr133951675e9.35.1781781274936;
        Thu, 18 Jun 2026 04:14:34 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923a1d2d9esm35375345e9.1.2026.06.18.04.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:14:33 -0700 (PDT)
Message-ID: <60f91bcd-49a7-4c9e-8488-45608184b20f@gmail.com>
Date: Thu, 18 Jun 2026 12:14:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/410] 5.15.210-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260617080316.111043001@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260617080316.111043001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/2026 1:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.210 release.
> There are 410 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jun 2026 08:02:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.210-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

