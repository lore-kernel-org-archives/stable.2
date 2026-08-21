Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD1429028
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323929; cv=none; b=YFcpPtaT0wyCPaIkQW/4X66Sv6+b9dwQDAPBWy/7O5dAj6AN45cUlqQwkbb4GH7sA++BboGRa3gGMq5P4fpnADTM1N0/6GAYwkhUUQwi8G4pBhy/wAZHb684rlfJ/HgsQTeXCDBbA8KW+6jhW7WinT07cgWdkw6hyEsswFG07BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323929; c=relaxed/simple;
	bh=VTcM92vj44+5XCO8TjP5rjlfBncjyI8PP1vsSAHNuvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/BB9nGhWtDTk2d+ynAf6qhD1VWLoOPynp7hm9FNy/SUm2t+RsbcQZE+QFzbbNh93SeE6UJ7rJzItN7PMPMpkmYNTP5hmYbSyZ8dW6yK+uBKTjQOAxE4Ye3PDRRRkg63fPcFV0Ul6ebVPe6n8fzft8MyyR8K4uLw6ixuknqrNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhVhhA+d; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZhVhhA+d"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-497e6956acfso930114b6e.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787323926; x=1787928726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Da3i+pZee9b7u3Za9DGDENY+ryDfxHSaO86YOiio4c=;
        b=ZhVhhA+dzsi0qaF35Bp3bskOx54A76ZxJbN0kW8il0SH0E61a2nXxjkYny/Os28P75
         snqes6BmWfJwFyGDX15av08MSCNbw47k02dq4iFIUNpEiXkRNWTq+Z75Yp0joSR4VyOw
         Lc622igHogH149q4oQafFv8lP68Bf44ymB4A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323926; x=1787928726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Da3i+pZee9b7u3Za9DGDENY+ryDfxHSaO86YOiio4c=;
        b=R9zZOdfbBIwbusvpHMqadBlUrCxyDYEben7/uVqg1d/ouJNbZXIb87+JSIhZfM/kDJ
         edoksyrN/ZKOBemE/gGESD9LekrYbj8sXZybSYk/KipRSc1coMP5UQUrg/rH0RVP/A53
         Bzp+4A5SnwnkD3NbbYyChH03gPe+BPvGOwUgNueJbQc8Gz8oQ9PqPEMK8JCqFf8B2fAB
         Ap6iDwVtnXKCWc3fBpxP/baFgqfvpmpbAlg2ljnpY35fiBotA3Cl+wSPaO+kKT5iXgyW
         fM202EYBsl0zKoL2Q/96+I9S1I+jJuWXNGJTM+IsmkgMSMHyGCJLFUSvaGPfO/UAuue2
         4MzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbHZ5Wq9W4Y0/hWe2ojTndI96J/lVSxxbdxPdUvFJ2AVyp5OMYkYxPqj1SzpAS/a62fi7oeCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFMAAfG4uGelCyTmkDdKivbwEPmaBaohEq+tqHeSDEpSMs/tg
	zV/9kpx1MXGk7ce11sJXqHiMTz702JctF4DSZvaHfzmdcYHkP5/mZ5wRgJIY8jeJKFo=
X-Gm-Gg: AR+sD11bBRiwmGZzu6urJgRj5MfQji1SnE5RJjGKkstrQ0Br3TH00KL6H6zJapitFQE
	FEd3PLpwLiFSRVU8yCCe9dH+8XFjJ1/tbSFfeS/MwbWWQFRCsqVQAmV36ZXRDvsfkz8p8bfOvK1
	gLpvuEq/VJ2G4oo6TqhwGnoFG3Wjhv+ui1AcBxClCqY02DVArxTyVm24nvcJyRPTLAHSgcJ61+V
	QbCpcxYxxeqOHq/Q6m1ef/Skhtvm6q2YEfTut3b57eWZ5RmAkPznF1yw767HRoLzdHjFch6zOvj
	a1ZSiDWywoNLS5nkBDIiZj8dgosb9OtzKpQ5u2ozpJqBQ+Gba8xdUkkda95pOphkybG7BLCCvPX
	FxvJhVRBGsb8kLTl24Ge//A7fPu9M/D26l9MUDH4sbFh2JtY7EEkxQqN1gzx07Yozg5FZ3u4u2i
	XCccwKhYlpSkC5CCfrJTrlOFh5+wFnruXP0vCcf8eW1gKSqAghDpIkxQixP5k4Buzs51atyw==
X-Received: by 2002:a05:6808:6b47:b0:4af:9364:b5a9 with SMTP id 5614622812f47-4b2cdbca4b5mr13366176b6e.6.1787323925935;
        Fri, 21 Aug 2026 07:52:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6711e15sm4996967b6e.1.2026.08.21.07.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:52:05 -0700 (PDT)
Message-ID: <b3a59904-0c4c-478f-acd9-e56397d3e51d@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:52:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/220] 6.12.105-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145223.480031205@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145223.480031205@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.105 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.105-rc1.gz
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
