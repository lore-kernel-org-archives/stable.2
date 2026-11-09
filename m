Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254802;
	b=JYAJipvL1k3NaAz3EQp2XDOIHX//QrkvEoJQREf0TpCwICXaQ+U+5aVq8peO/OO2eqUC
	 ZSGFxbtCs/j/HX1afGZmTFeWjoHizc59lMugM3YLL8xH5AChxG8593NlBru+GNOwc9kb6
	 ZzMcXp/SHnnAH1sNUUVkF0O0y68n7bbDYR1lIvBy4eZ57p997VGA770YGQatLNo8+0dgt
	 Uz0worLLU2+aJcS/FAB20FDla7qBTa0pRWk/KsjlV0Y+yJGxCu4GFSv2WR1/MXxBarSej
	 8k6LnrbgXwWUtPOlyxtondHaV/NbHJ/mwu5mTeI+gyHLukJAi8qgYY6F+FXxFmNWFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=foef8cSuDtXRvHW/3i9rIYIPK5SqXDCZtNX9m115QFs=;
	b=d42tKoPFovuillJTpq4jJxlAI35KTG8HTIqyqpKjmT2jDcOn+ym1Pps1BENiaHpLN/jf
	 tPH/2xXTLeN1OQoAcPIdHakGJPk9xVBhKWhIoHVNe5EcFbbcSpuDBC8XQGOYQyR0wuVqp
	 GrkwGNRJCrzCX8towgSeP26z31REI/fqvGzekVigiPsN4vYXHGDcoPDl4zwhWGbReriSZ
	 e1PZN7j4lhalHqLQzRGEIIqZvBh/TtdYBDEClIyHy/sFN8ryQThpzlkaugkdWMlP/XBjT
	 LUPLm7KfbXVg7hC1Xl9oI6aiaKCHE+3oD1/5/qy9gpN8DC1OhUQxUQfwXja/2fZmIqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=cVvTdYl4;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2F606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC2F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=cVvTdYl4
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4a77761ff8aso856228fac.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794254800; x=1794859600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foef8cSuDtXRvHW/3i9rIYIPK5SqXDCZtNX9m115QFs=;
        b=cVvTdYl4kccJQlT5I7ztVkIB/bXt38Xc7QVaFvkYYF2ogaFkq+gPt0cnz9z6UtIqfq
         nxis9FJQ66sZZT7P9sfkKbJA0IojsZPj0sQimSMJ1yQKjc++kzhT1NYyQEXI/PqWvjB3
         qQpxMPtDr36zh0FrkF9HbooW4vDbBLEi7a9bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254800; x=1794859600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foef8cSuDtXRvHW/3i9rIYIPK5SqXDCZtNX9m115QFs=;
        b=ECozKBJtK56Wp7n4dqKvacIrUJrbNQ1iwY9+i4UqFnkpj0EaT5v3BqV0hZ2WsqihZI
         UnJ2ia84X+CYAB5geHxvYnPwzw3Hkt0MPhom1YhccyNDR6BDw1204A9mi/KEnIEDlb3V
         YCL1FilmEKHVrD9foODiMByxgLz0oyU1O3lg/cVZwvs6coAWgGmQzq7c0BbsZVTJPjFd
         p7/5OCBuNlZ2tbGA+Qr/s87kJdglPlcMcoABbtUOXY+spOVHS85zZa0FYLxzSubhW0f8
         rzbHTZywug3nESg0PTRaZakb3y58bW2754TaZjMAgPpWw8oRgihrJb1G5fDPQcBb4ExQ
         ThyA==
X-Forwarded-Encrypted: i=1; AL+hErF9IBT/xGRxcODENIlFDmp38j216gKajEOtsYwPFx+YjKYsQNVabp+ewtSh/5xXCuZsKAVNNjU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xC6f/4oXTjfu4mdMjs4qVvV9T2LneiT8MHrFk3qHtJCvuIMuU
	6QKo0mtMh8w/Kea42wAYMEnMjlIKIXMYucEDtUCjoBXtsvc6kB4yi0YmkeklkW/iIWc=
X-Gm-Gg: AYBFou2Utjek0pHAAEIHpsyp4ZVjzhhiOLuxuk0xogyOFBph2UShyR0SVWoqaw9pCfp
	ZS1ZQYCN33jishiDEccn58ZSbabemXgvhXDCm6EEHvDUHvRfrXjbWTJXxeOvbEiy0SizkuJXE7S
	Fs7Srq5gNAc0G3qRU48M4Yx2Jb1SxRsNksssfxoX1kORR6kCdicBgonztjoUi6wIl+aFKo0ILeH
	EpVyIrPhPVa4Jt2Qy0MbW7BPE7p7QLe8xpm5PWKx+ugS/fKry1rmDh17qPTiY3FP22kp5gq/EW6
	nOBpyY43Mk2yW3bVyK/xT9pmj6631UlPXAuIJV+TdBmXJuXqUbq/Gnf6lCN4vRowvL53WpUwPLl
	kef4PsI2OlyYmIT3tXpCt4Ps5pM3zTFfSzDFzgUR8r68jDVfD7LHXCsO0uxM16HZhIhCG7fDR9b
	tC9alyYQv+UuQzwRPJwFCulosQV7hcuK3rFj4eS0m0ZR+AHrS0I8BFkvtKs1uP1MYYUq6EToTNF
	7jLaoDyCas8JUu2PsuMZFtApJDV86P4H1y+N5+dKjHFCEabgAaNH2/HIP64xuHl1HXVYAEIZ876
	f8Amksl/0r9pE2r58xjrQNAj5Ng1VKf42RIhxg==
X-Received: by 2002:a05:6871:d212:b0:475:e066:7711 with SMTP id 586e51a60fabf-4ae22612a18mr178123fac.24.1794254799938;
        Mon, 09 Nov 2026 12:06:39 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae2308e3ccsm85800fac.15.2026.11.09.12.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:06:39 -0800 (PST)
Message-ID: <73aaf4d1-3cfd-4128-9c2e-b8bda16d535a@linuxfoundation.org>
Date: Mon, 9 Nov 2026 13:06:35 -0700
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
Subject: Re: [PATCH 6.12 0000/1536] 6.12.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261107134957.653319350@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261107134957.653319350@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.117 release.
> There are 1536 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
