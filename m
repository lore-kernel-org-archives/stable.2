Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B28C87C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603912; cv=none; b=mne73DzPOWeQstOtgEx54/scgtk7HGv91Pi/+s4Q2lg2KSGzJ8O6JacSBHr8kldQ6sWG7dmfqNUH6ZNzfjwYuWiftPO23+udwfO8Oh+YoyT8ZhjfBfzmJMrjNCfxhXel/kDl+l8pSl+wfH9MC9OE3jionzXTYzooK/5SZdDxSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603912; c=relaxed/simple;
	bh=nK+XWSu+Tw+t9agE8i4GBCd/GLcgTvq6lhVAwjuSSYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SpXcLofybJyoltqeoUB0rlL93NukbJIeFp0f2/k77JLKFvfTR9Lfg8NHyCGDIj/ejInQBPCNBwrLuGWvYca5zLR11Lu4kgAbryd4BYu+FtTfFAVrBfefO6fmyjVwlvB0RkJEY2sNhOSaRMjhyqk8Nl5XuyxFserDz5OXBbeoieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAriyK7J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAriyK7J"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472326ca506so1327809f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603908; x=1784208708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/M+W6LXlcmdxEuUQROOr/3E+bmWxRBOl/fTyxk2NmY=;
        b=bAriyK7JsSYhxZ3fgpKB5VOMCNYWjDHj6q9jFUK41h94MIIFiPiu28+bSv9DthvbG7
         SZKiUUjNkXnwPXMgCRdqfpEAmi0RcUuRjoLUHou7prG2197MNO70ttQQPaCN0BY0SqXj
         HXoLeo0k5v99rMCaZjktxOGyRDGnHazlAaV066KFmhL5M8Gn5nBTHMjJ3SyBwVV5cLjI
         e1+uFFOAxdK/lYfUmrk6PTBmlZ8EDi8B04jtOBBg/jytkHhB9icdrdA1CIWG7OfGRbI7
         yJQBBEKnlSh15I4WhAwOImbKah4uv/O2pvn+J7LGWnrDQcZDLqQ5vnd4S7FTk48ZP9Wh
         kD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603908; x=1784208708;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/M+W6LXlcmdxEuUQROOr/3E+bmWxRBOl/fTyxk2NmY=;
        b=FRn6ZZk1ZWcNiN5CHT9U621llQkucxmvXtW5nNaFr3Ts8NnGpREnHKHTKLZvFPOD7v
         qgMAGyZ9gPB6nu6FGS4uWq2PVUyxV9xr9oFCG6ui2uWmb2gUpW8WI4xeIhSh0Egod468
         SkLHoYqrCfkgc978kmTVk2XIXISa4Ab3CSUoeingTLeqeN643s83XdvGmiYeZLSuovrv
         7cQConsgrGcr/XqWUPj2h6pg7+NM64yWvJMZbpTikK0uR7X6qWoYrWmMoQFEhEsz8E+m
         O2Rlc3JMAUVJY3JoKS5a/2KBQsPRVIM3O11DM0898gCyQpAnVkn0fUkOBIU9n5YQ3lGU
         EYgA==
X-Forwarded-Encrypted: i=1; AHgh+RqqTiPzgnmToeYXTp3un5yqR/SmcinWj7hW0tcO8cPkE7Fb/9uI8puLkmNajA6hrQr3HudVabc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEZRjZAxFTWU3A8EzMQvWRjwS6w4yU3GMwi9JAsETa0JTMJwQ
	2/3BLnPv13t2CCnPcTDabeCX9dpodUUnwogPXM1dx1Hjo/swIOQVytnA
X-Gm-Gg: AfdE7ck5t7VT77/sv0RGg/PffU1zapcZVcZnqOuiihPTMxaEicj5fLW7k/Aob0Vt0O0
	dTSznIPcb99EPGkoupxYFtz77E6ztJ857aNYeRTK+XRnVm2KHNunZdJjPjM5HbeNa91FO2kiZep
	uEeCe8gV/eUyLbBU0tkI/heS9y6xvUPayt4k89MWOzbIqy+7oO1A1wl++0iJIhjXeyHQXYMSin1
	NCl/EZI6hnvId1rPSm76ueLIFlnDvYqPvkHiLqcfhl40pt1d7BxOxO823Z+7icHTIXNepMkjHpd
	MtGNOXX/UE7S9VDO4F56TXlntzho7PEmoG280jxF6cTBsBAxHSncep8LoSnjwgCg5BklFgtWv9p
	sBXJy7Lt/kat6Ix1vq36K5YwtlCN525OPdQ6qAF8CNRvG5ZIHb4roY/guO6j+Q5WiuSXmexjjZZ
	M9bcssP3tYm5dUPzxZqvRao+LhZeC5BPJQxIUBpOa/QXkRkma/AzuntVJd5mmWZQ==
X-Received: by 2002:a05:6000:24c5:b0:460:3233:beee with SMTP id ffacd0b85a97d-47df0775706mr7751817f8f.42.1783603908110;
        Thu, 09 Jul 2026 06:31:48 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm52356756f8f.22.2026.07.09.06.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:31:47 -0700 (PDT)
Message-ID: <d4579324-8e59-4113-9409-6c4048b5dc00@gmail.com>
Date: Thu, 9 Jul 2026 15:31:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.18 000/109] 6.18.38-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260703072816.644513463@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260703072816.644513463@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2026 9:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.38-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels. Please backport 
7ee7f48413c42b90230de4a8e40898b757bc8e82 ("perf trace beauty fcntl: Fix 
build with older kernel headers") for MIPS builds of "perf" to work. Thanks!

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

