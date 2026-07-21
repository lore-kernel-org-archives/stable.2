Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1D231829
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656103; cv=none; b=H3sYBg7Acg4qO/edu4jrHQvHGFNU0jfiZBdNZqByZ8hYVo+yFc6f9MRjHvcOQ//qFsFlSOHB/vnd/KR83Hbc7BjIaBI0kRAtoBp0FWCDGcs89B0RE1NDvntJOlYGqhN/dpcPilalOqBxykY3vdAaOlGiWQMSDDec71/pvUKGctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656103; c=relaxed/simple;
	bh=z54MjucnwGiMuLytprU1meauzDZpnVxUhp878AqFPHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onOcJinAFrR7r6K/PVskpfITqniSKkTrDgjWvgg/bOej4SocoNoeGuZ5mPsNcLZRaspmEj174PG+z54I552MOtf3rO80uCUvbe1XdXcRZnNmi6679/jpU7YbKqwPhZEEuYepMXhRySR5Rr1UZVJQ1V4Uwc2oUjj8lIS7Ze5amho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJJ5LjrO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJJ5LjrO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c149c5722so65382741cf.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656094; x=1785260894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3sA2bQLKGkL4eSJMH3iVxOG8hSipTaYQuYvaWYUCx8c=;
        b=nJJ5LjrONTXHF0EYsxzA1tUMXNvytVdp/625LwT2c0S3jiXmNVkeGjtrv1e6IZOn4W
         kB47V+0YYE7AnZpQzkAMTXI2bXXCnYZZPRvK8x/hOcZZe7FAePVNSdPShupkt+cHnQc8
         +EH3sIKBtxyygAEJ5qPsipxwKvCik4Z5S6dsdQDyFB4+lZPybfnVM5ju/zwbKHWc8PJd
         oXqxSwvOqSoOZanIyP5BzL2YjoJ0esYtdexyCk5t00BrqZg93aN4iUG/L6K/iSck8vWu
         fz6TnhZpsYJVBwov8GoX4zV260+GJwvkTlO2K6lkSal5uCDOlkasxn0wD18/hLyA4v7O
         oK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656094; x=1785260894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3sA2bQLKGkL4eSJMH3iVxOG8hSipTaYQuYvaWYUCx8c=;
        b=Pokna+jkJMc9nY3oRPHMn5CCD57B0GaqrR7CG27kaQ3mMPy2O8zyK8FXk5YYvxkhCM
         mm7u+2PmmEkouW3k6p7cskvLHybZxKjIptf62mIEP/4XJR7v8wLYXe8I1kYtFvlayJuO
         y3QBmHIAHPxlsZoFJLXixotgD3NbR6Fh8ZoMweuAKJURQc5C77ZsHKgOu35NqR0c2DUT
         zy8wEsgqye06LthELrhnznHZ37TWfPjCd1a0ieJxWsoyCabA9rZSvfXD4LPtP0wuIXw5
         VFX0GOJkMX9TiJiPntPBvbkQzMFHTT2nLW+8gnn51Hx51kDaQ4sN5yjShef3VV/XIcQ3
         SyjA==
X-Forwarded-Encrypted: i=1; AHgh+RrOu1yx9lsD1h2RofCaSxRkwjcW2XfIMKq5x5FsfIyI0KUXsqZ1VFAQCj0w8A9kZD6hyGfjFnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lmuinMehyzR8FJDjSoB/eTJftgAtw//KzXdzq00loZXm4Mf4
	JPg430/820v8HKPdfjUgc/BlR4GP2IsHDGq+DinTznOrk8bJGIOK7Hw3
X-Gm-Gg: AfdE7cluVdmnj2oLVcWy6HPUw7wNTkYliqV14WBu9qhz2Ok2mfTK4B3IqouUfVbRgrB
	OjxACaJ9v9MiZaU3Him36BSFKqcWyWrrre4fQlJQB3pFB3DmZvgS5v82VxriUwzbVnjOZqw12og
	9l1zbeJrbIr/8YyaZbwE2SNCeLHd19ihi9VMzV7dWRDGmQLURL2a1yQvanbU5ZvMfmCZe6/rMzA
	6b9X/rJulkMhrvPErBllBGZHLkJmEq/97Dlv+rFamYLe9vVBm3hiHT1JEhvStEq+JzfqNK80QFU
	msNONHyFWg5KKCv7tNu5D5V8i4rkqvniuqdd/c5q66bYoLsD6FyF8hrBTon8vy/9ta2vkz+XwU6
	nExu9Zr5CNhiDtdDXvGov+3LhcDNmsBR7mIJhaVE2tDUWRfLK4jcyS8oge2/MjI20CHwxx+dkRO
	m9E6YPrq8N4CBGWZd0E9nZJA496RZh
X-Received: by 2002:a05:622a:958:20b0:527:7406:56c4 with SMTP id d75a77b69052e-527a6508866mr5249551cf.11.1784656094527;
        Tue, 21 Jul 2026 10:48:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d2896f9sm99528351cf.13.2026.07.21.10.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:48:13 -0700 (PDT)
Message-ID: <8869a0f4-8e26-4f83-b258-f633a6eb6da3@gmail.com>
Date: Tue, 21 Jul 2026 10:48:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1611] 6.18.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152514.750365251@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152514.750365251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/arm-spe.c: In function 'arm_spe__inject_event':
util/arm-spe.c:472:37: error: 'struct perf_sample' has no member named 
'evsel'
   472 |         struct evsel *evsel = sample->evsel;
       |                                     ^~

due to commit ca625699a8d5ddea7213231f090dab1e0ec0380c ("perf event: Fix 
size of synthesized sample with branch stacks"), it looks like we need 
to backport aeae075a0352eb6ab363fb1910f209eaa296a175 ("perf sample: Add 
evsel to struct perf_sample")
-- 
Florian
