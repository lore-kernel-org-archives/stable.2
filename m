Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF14A8435
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822065; cv=none; b=CO8zRAmP8+JdX3GqZgq3YuYR9kEbHKpRbROuG2daHa64/siDPTFPl82M5aoIxuv8+7cKqv4AhVCvF2AhgUSN/Gqwk+CsHR8cGsBHu0HeyrED42qBHtQoE7NDEPb2U5hO8eVJot0h3Q7Wjd7mhsJc3JSo2osmb552PBhCdSc4uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822065; c=relaxed/simple;
	bh=M0JGwBW7mrHwnbqHncSpPEi7zCT+FqGhYHkZknEXRtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1FyJLw7k69ep6PDm8hASO++Tg+uxohq2039gQuOT/mWmCaGFxlHPhrrr93gI1HWBBHfqOzONw4hKF+K2880Ja9cy7+hL1/n6aCspd99bWZli8VRvBi4IBQEBlfAfuNJ0GCA7s/8T7KeTJAFLPRHwKJ8mGCyvk1jy5XXDrXEzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILN3AUGV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILN3AUGV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33e6279a1d7so282009eec.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791822063; x=1792426863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=100dkfxHGFXdSa4nJokPxTSjLK3e/Vooj6icmrrZBFU=;
        b=ILN3AUGVqW1TneXkRl74p0z/V8QVEr7BoVgyiM088wNeAXxxANgNdj2u5AsZ6EJsgj
         bpxO+zkOmA7xem8gSd8GYRlBYmyMeaPGYGHzq4AxYnObTHZnzRDSztzt53zPAtDJJKcu
         QbsXB/fW8BzI5BuRuEIr6bGPHUFN1kLXyH1CjLTV1Gl9HbuKynKoB1uRvFIjCARA5boL
         S6tfqHINAWQ93KgrdmflHspFVuw/B9Z7htzpr6emmvAPFfbVtLmYp/v3uPoKj3/nHbzf
         s2p1nVMTQsYjypEe6eIIoyoC1v0M3mLx2DC1vHgVXTrMbdc02Yyt37OfQPGK0RHuuKeZ
         c2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822063; x=1792426863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=100dkfxHGFXdSa4nJokPxTSjLK3e/Vooj6icmrrZBFU=;
        b=0neOs5CZIPr2wV9IIFSyjxdCXu90vLrqceslYTJdvwM9T55k5Dx0WnoR0kSdRRU6JY
         eIIsllAbLC2Mac/2sfj3rdp2iqY3LzP6aPl2Zjb/m6lv2rPnq6shsNY0SQTMJ+fxyc8N
         J/aSaNX75u5trfhyYu08qZ0V2VzJz1u2BxTtzV/bF1BxaaPPR1ZtmExnXGKJvKxH2veH
         MtpawcpjwlTxO8G8XXHEf8LGMzqs664ynGLYF6nBNTPsqx9y1jXjP1zi9RZWsg5rdGfs
         EwH9H6PdZFbcw0ycXCYvpaNJgLfZdiqxHHvc2OILXJTy3gQ4sJjxDn3fujmOHpPUwTF1
         wjUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzS9sm/KTKSIz3PEfXQgt3C778XDtko02oKXb7zCCZJ2dzhm5/R3YsaRIkz32mwLMCFqs9hLcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6djVadX85LMLaH+iHM9dDhaBi1juEE4HgLJdiDL2CI6Urabbl
	YqvoKaLd2KtJ2yVPrrwFhV7SfRkAPgez84UX/o3aw/kcxSTqVLbqOr8f
X-Gm-Gg: AYBFou35lS4Yt8EItsWd9ji6QjznuKgttWpJsgqHq/Cdp3CY9QACAHHT+lljpBc/2df
	9S30zrwmYNEO8et5iTSG64Uc7GhVWyAsaMdKYzGNiSAQoxo5bgWttp9cnx/efdUQksdU77zu8Q8
	S7sPQatG66HmbKZYszYChUMSknDkj0PZ7cK9Xj6FCgX7BY1m2r2il/HlnsJqMg8WOlferqSNQYs
	7ok/eAOBuSy3/xbvnLaRZ6cYcNwVV7zPMRzwR6pFrCYk8eALov39DfymFUQW0O4FFabbac+gfWY
	mP0Gczjpxupvz4so4GpsX3prT1XH+3hifUPkicbkqkD+eHPm4IYrPeerI+WAyNYNgcFpwuF7QD7
	1Twg55j5gtRBxkz9SLRouGvfzCHjvs1FBKM7MX+cqtPzkKogV1l8f0J26eepUPZYUGherp7MjI8
	6Y6XAUVjVD3oUkDHDpdAld17FOE4A8Wbf2cjzXwGazxEQuTo7B+QQDiHA60g0xQNj9hupBI5UqY
	nYnSBNO4Wdp2e13pVEV8xTE
X-Received: by 2002:a05:693c:4002:b0:35b:232e:c0c7 with SMTP id 5a478bee46e88-35b232ec517mr3252116eec.13.1791822062882;
        Mon, 12 Oct 2026 09:21:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm46550456eec.9.2026.10.12.09.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:20:59 -0700 (PDT)
Message-ID: <f29aa81d-80c5-4ec6-9117-f928230b35b5@gmail.com>
Date: Mon, 12 Oct 2026 09:20:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261009140946.008206689@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261009140946.008206689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.10 release.
> There are 428 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Oct 2026 14:08:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
