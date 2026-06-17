Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFD2DFA25
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716565; cv=none; b=tBSfEYR2U0/eYpP8X7Pykbgdn0YG2p5nBh9+IX1/XfFLZQt6qh0SlRsLIAO/usrJoa5Bn4oIy13cfUhP/9QirJzPbjWLzGk7+E1/zY0QDc8YDq/buEI2D54aLZ5qqEWY0dj3lKxxIjqdQHYgdNzA84VoxsewAWY+YPyDvMZsEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716565; c=relaxed/simple;
	bh=VLKV5gdnm0shYQ2A9HFU2FqDC5E4UCpdCGHSxLKoBbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaQr+lipCglhAGUo7cjUnaGbf3VnlTfokL2+3PWm85n28lPxSo6Ozc+RLh8yvW5wVNPqPSfal6iS8UWp4EmwwCJaC9shKDr7guoqzvsmgABCFaG9umw4xGS6Q0D3FiESSLpwgJZidTOjhkgZd6o2guvkS6MDIenP6We/K+dD1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFZFY+Rf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFZFY+Rf"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b554044fso3064a34.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781716562; x=1782321362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29lQJSUvYDcMCTBEsR/0mMzg0Mzs+ypLDfHFqaF3Xic=;
        b=GFZFY+Rfp3Bn5cv6z/3oFbQxKQzz3flb0lY4aO9a5zGpasEXjxoQMf5T3e39yyWaDe
         5RfPnjrPwm++aHF5a9uvI8Je/EUbMu6/4cFYXcjB/eTag49ZS010hZaexGSeuK9sq9Wc
         u3X2bJB4v8MSQGVN5heaFmwTdFUf3JWT8gbuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716562; x=1782321362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29lQJSUvYDcMCTBEsR/0mMzg0Mzs+ypLDfHFqaF3Xic=;
        b=Iw2lcXoZXQBaQNpwl3pktmcJMzx+XBmXdtW0ANeWaUiK8JbPk02QbYJ8ZBrnXab8Pf
         vTmdPkxAckrnGxk5cPcy+Fps3/VL24uHDiaQkjSKgQV7IkoKDEKDX4KJmAGFXvM9Am1U
         DL/wRp8hK8iGex+TNt5MlxtskQMhD0V2+20pV5wK3zOI8ZVcgDtDffZaytT4GSiHyoiW
         DHL7H+OQtBR0Djz43AAad5dDS22byDdMhoEudno3lV/S1HsPHpLSA0iK56ghl2sZZ15B
         PFOC/ODJEweHPMaILBQijygkzZToANSvO8PFJWiv+7puSi/JnEdyqp1b41IcgUAQH0aN
         XxWA==
X-Forwarded-Encrypted: i=1; AFNElJ8W4ombXIQtHNCDfSgUntJsnkrgO9Y9GocM206dscdEvMqAVWRLrtEn20c4VbYFWzh50J5sDck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHrhwJ/dyxRa/sGv6elg7E1Sepb8f9rKTCMvCgbUo9Iu2t0i8
	K0sKgdsnVbSrenZuu/Nw9nmRRvaTDjtm0jaZTeXMytZJs3RFsiUlrNXPq001gORGNjU=
X-Gm-Gg: Acq92OFSVG25lhK1UzaKciNEU3JRXaKA3pYHga9tjRRqa1ow46SpkbOxvt2SfPf1i0q
	z8I5pFxO3QJhHprgcLuH+PGHwKs5zBldhqgRHRa0IboFepQckpvFLyl3X8O99X6bJHk5DVdus1r
	VpE9X8DWcCrovR5LY/RIdRrzREkGgawcZCXdjqSbuhI+y7CGWhp94zxgi7+HJ08ypsSyxRA+i2t
	0MRTktpGjcPz+ps4Gr3427HuCPVBIP+f6VMPoMDqutgTl42LiQJ1uqvke8zrKQQf/OTMxDHoVyW
	FSxLkFu5H+ta3+0JHPmZvjf27CzpWykwi8er+iStNe8nut0qqx8qa2v7Q7fux/ZXSTpsE64DDoJ
	3hRy5y0+odrSPkEhPhtYKvMyUn75EdFI2eZLUOQr4b1Tj7YEcMZcfcee1bZ6X8nwGpdSmw4C0U4
	bG/jyMvZoeROKBpSd8meNS
X-Received: by 2002:a05:6830:f8e:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7e90c5bcebfmr3399266a34.8.1781716562094;
        Wed, 17 Jun 2026 10:16:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a1df1sm9641059a34.3.2026.06.17.10.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:16:01 -0700 (PDT)
Message-ID: <c7acb5f7-fe12-4cc3-937a-0e5b2476a74c@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:15:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.13 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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
