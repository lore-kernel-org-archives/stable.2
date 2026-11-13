Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608786;
	b=tAbPsKA0hNyBnBOy0abXuQ0Lo+10r/jJEEWXeKR0EbGkZ/wdxpQakOTpZfM1Bv4Hzeb2
	 pCtnpGRnBayQbMRPSv9B6sm2b76rl4l4IyX6onAuanTrikugSogT55e1+sAmZStkqDJch
	 zWpGYBMAQMNvMy2qJMEniHs/JDzDo/4U7fIu7osxFEquaCaTisP9t+ptBmLONhsbvRwvo
	 SPEgqv4UNf8zZ9WmrUzeMlqCmc/KbJnQPDVhaeufFhTaP8Ttcs/cgz0WWOyQqQv8W/wCI
	 i7o7a9iG3d+d22OR58kbLzlqS9tPa+PbobZ7PuX+gbmA1wb8entAyxuqUgUVAIvUT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qN6krYwEOOaADQfooIYZcB5GNu+bZMz584ofrhIVz5M=;
	b=ieEmIfClXusPaQtx6TFyKY5mqYVZfWIhNABy+WzVpd3BQCzqP8tp1WgGgxjxwRxgnVtv
	 pZ9n8P8GtxkBfJwWyVVubIfQ0/DX8dlBea1Lra3lwwYQiSjw6QZBo4jMDAoTIZHEYXPeG
	 kTDRVywHOQkR10rvsqKDrFLoRMiS2WP8t8mAkO/6xF2hU3GAg6t9AkV/etYNUFEd5WbLz
	 Ism/LmJcWqb5A4TfAV5pcX0YlC6yOlVsPXKz/1y+sNCdRRCvxzGlQwj0VOteri5zKaWXk
	 5N0VVMv49rGoQhLUz0Os7cZ0zMjmH6gQhjwQDd141j87AP48CGnZgZ17oYMhDtZq0uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OckkWaHq;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B391606A889
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B391606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OckkWaHq
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b28d9537bcso1807519b6e.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794608784; x=1795213584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qN6krYwEOOaADQfooIYZcB5GNu+bZMz584ofrhIVz5M=;
        b=OckkWaHqZj+lDpiXsd8AHfca0d7kYcQjpoucf/9ciX0JzXnhg2Bl4aE/aEVvygOCNN
         3Ls887fyzlSVFf3e16mt3Dypj59OPQnRj8LhlSGTJVHzYwv8+R94EQsteMw+TzDr9nI4
         FOcnYGMY6e4egR3OAXhqVhVUyjscsfM2626x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608784; x=1795213584;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qN6krYwEOOaADQfooIYZcB5GNu+bZMz584ofrhIVz5M=;
        b=nAKi0D/q36oJndD2hYWhzP/oca6lIx7A/iUfTOE7HeXCx/+Yn/6tiFZ3nEa42V0fqW
         ZjC8K5NzOBDMB+g9E6YDB5myRphiHCL5wvultjAHw17T8gndiQ3HiwRR7h38CojPYlq6
         0xH+KtNWwIzjg5qDDR3JDe50e0gmvS+GvkTakhSHf2BdGhS0DdDu5lsdpBiVKhEPP/9n
         A8bJYBKxzkljpF3k/QIKlOztVn82AlAW3x8kSfeJVeLj66itQ0whLaG1dY09wB22vt0A
         TsRnMUspBLmabvXCjR549p+nowIzLvSm6s11eK2Z3QgXbyQn/cXU54hKdwCdkQExGIH4
         6tcA==
X-Forwarded-Encrypted: i=1; AL+hErGJ2FXn9+dFCOPnGJwCjaqe0p92Jdo07md4qZEDRN9omiDxxix6aF/D/tWEdTjAovFD4Qix5yQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8chE9cqWCkCPyDQ/LDHJ+uUPHr1LDLJC2fR+rhiIwdU0/dQDE+
	OQMuTa+xELi6Is55kZV2qvvil5RhYFr4LNFMWxgdX/zegApShmnmejKNovzqDBiK1ww=
X-Gm-Gg: AYBFou2W6sxe7jgPvhH+mXF6TcrVdAHq2aycLP7cTMceghZY7yw1pGc1todd6vNRfuC
	QG+jwZ8cRuVaPXzQYeAMKXBO3723/s8pfasdx6rhlmjtWEnTF/KXg7rsxrb2OdjMQH0AQ9UxW+4
	P1TlB/W/w1xg69Mkw1Kw9Rqzbncr3CZV8t7Ac4nQRsULLSlZpgREOgb/u3IBkgYCUj1IOex1Lsd
	ZEi2zry+jCY1HLjMevbamdXancfr6k15UzA7nVFHMPsEy2iUMH8Hh2D8mJjsAAsFsT4OSivQ9dT
	yJWNLMdpvMeYbzWgVurR9mRmsz2NfwdoqWpFkGQX1low3AFgre3Zgnm+BFZa+1gxfQ+P2lS6P/j
	rHm6uwqgvpRR1wni0Jd8owRueUDHC4G5vaVILaGUlkTAPJaDx5p0sSTQTHfRsbj9yr2dq3TRp8P
	jUdX915DOUIr6ejZDu9ttO4OhmxkPZ7BMfKMQAYZciQYE8dtTemW2rNnC1xN3Ab3VgU8dhsT4s4
	CJfP4OU60ZjfVuV0oYI2Bw1QpVIgzCT/FVtCtBcrU1agnEEslQyAV4SNNj0H97ZSv61BBGR9bUm
	AKRD8bL2kjouyqMw3hM5eshGRqg7gg7z7gvMGZM=
X-Received: by 2002:a05:6808:1520:b0:4b2:8dbf:ffd with SMTP id 5614622812f47-56cd557713cmr4332703b6e.1.1794608784082;
        Fri, 13 Nov 2026 14:26:24 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7024673csm3195795b6e.8.2026.11.13.14.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:26:23 -0800 (PST)
Message-ID: <695f8bdd-edda-44b7-8cee-e7557c963a1f@linuxfoundation.org>
Date: Fri, 13 Nov 2026 15:26:20 -0700
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
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261113153753.358973689@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
