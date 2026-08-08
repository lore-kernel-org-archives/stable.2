Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4A157487
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149303; cv=none; b=hlaPOLyFYCvjP0mKcT3e3drQn9fmYGAcjgvPKtYvjg769d7NvvwQljm1ArdXcuLeqDhAAihUAvsrpJUOJq2klnmtd205Ms6Pn0C+96WmyEWJCYyDu4a6fVA7r+UbSShnQYvrz2S0LOtNEOa809P9CIZtKZInPbDnUFQ2Wk/3M9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149303; c=relaxed/simple;
	bh=qPWYVDfGidSWObMm2aZe8inJYQg4VBphlJz6TEyKM3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuvxTfDFl+ksa0F1YZI4EFJjFL7BdS7hOigZ5fUWiRtAY8Zclj6m20YV+OyOcla6M7hvu2AQObwVKFJE9zsRE8JdIKs+FqTu3z8HwtPPfXyKKkZ8qbPFc60BkHMIDVV8F8hH8e41VVcXGTYCA0ZWx9zDh9lN8VCylEYOWizRkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WA/G0ynl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WA/G0ynl"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso167653a34.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 17:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786149300; x=1786754100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrtwQ4j+g8aN1LkT20rOlsm19+tjXqZu2a5a73OuJPw=;
        b=WA/G0ynlhD+EhVDDUiZG8KCRCXBbT/m2n1GCWeWWVsQ0N42FmFIX/pBupkjNPzmv2b
         3cLH5+FceK77S93QVpX+EvKl7ymHObHvar6IDRT02VYGnwxzBs74Hn0zUl5XvpGZ1rpl
         /ITDw3xa2MNIYoqyZtat0c5gxLhfhC2DYJDNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149300; x=1786754100;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NrtwQ4j+g8aN1LkT20rOlsm19+tjXqZu2a5a73OuJPw=;
        b=V+ZGTPaUCbk2dCORVVwv+JWyCD9JZ0rnMNZxPQqmXrCiG1j9cvL/GtRsWdMxtMXfhw
         F75zCOSnqP0Vr88AKnDk3syrrjbEft9DtzfN6C16E20ZICOV6tvdZVgsCoWqGpdd8bqf
         3PxOJr5HyVRuPOxyqe0p3KM+Ox5VzxptXVxBalH1UU0h07lZZ9Z6GD2boG8anQ4k7h9s
         m+Y+YG9oHUkdgGZtxZdmeflD1w5dGuH2Hh22pA7SG8L6P5JxH9Vc2YmjGRlr1YD6aWYd
         w6O9BVOLamFEeP3uOHckEsoeN2GuloiGGeM5fe53FSyJUVGIVFEWBqIVoDnjebqJp6Om
         PSQg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Le8I3OSN/QY3OjBjzaSABk2LFEx2hJEHnjFsSia9LnjwCsqwhePzTKSn5GSFGaMfNe3JYIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmiluVeC1nXIDAZao46lA2MUNPviOs6k/HcsaPI8t8tOag8u8
	bqHvNVeVqlqGs0C2DmHN86xiFhYRueHVWjA8SOD9qOOA2QgSkuAb2BnwduZB6CdxhA8=
X-Gm-Gg: AR+sD10eE+cNAwDI7Ld6xvbj13pRAMpOXMAp/XPnZHH2LPHK48js0UlbzzEASlacXyQ
	6E/FukTa2jy75mJc469QbPb/p/HX/hwZTki1GSW4yIZ2VQQcYqtSPqZCCvpXaKMEUfhcANyNJty
	6MPD6U1gaW9ZRkNQBkKpgCaRnL1eHOc7KB4hFJSdwC8HYmxhC59TsVTLiv3U7TYcdffTMScK8oc
	wdt7OfW2r0SWZ0lL0sz2lkY0AsM4RTWVcYFProXHHsEPmgZInnWZLjtOX5XPAwmOHpdkc5p3Vdi
	C3CXaLX/8yDDMRAhBNX/8ZzLpukaeiU/ZzKNKVpUzQahLvA26dHr2NCDK7vEg/S46QtVEcOw90Z
	RuPSZcZCzSqSXQn3K6chpwbut9LyawAIZD1Zl9ayBdOBmEGhTPnNiivTGfDWIyKDzYrdO+Dk+Jw
	W2F9dKaH0xKIeak79m338+GHdJk7AG/e1oY4VjHFxebkcQLomJSFln0D84AcoPtDWVEpB5ig==
X-Received: by 2002:a05:6830:381a:b0:7e6:f582:955e with SMTP id 46e09a7af769-7f1e5e4c9edmr16473666a34.10.1786149300198;
        Fri, 07 Aug 2026 17:35:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7b95dcsm2293101a34.19.2026.08.07.17.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 17:34:59 -0700 (PDT)
Message-ID: <f96179d4-a4f2-4340-9348-50e635d9b5d2@linuxfoundation.org>
Date: Fri, 7 Aug 2026 18:34:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/337] 6.12.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com, Ilya Maximets <i.maximets@ovn.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Sasha Levin <sashal@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260807143418.516897842@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260807143418.516897842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 08:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.103 release.
> There are 337 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.103-rc1.gz
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
