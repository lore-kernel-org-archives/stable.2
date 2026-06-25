Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7ED30C15C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431900; cv=none; b=p0z7h4r97JfprLw6kp4hwd53qE1L6Pr1J0zyCsKBpjGcZpX2fFfLsPQB5qM65tPVKdZi/kaayTiHXR2Hz9AiRovB73V/HXLnRR7mrW2RWcw2Pkct/lfHhZQsTqIRDGQ+zPyYubgMWV35qCzQDd/NboedRzl3v8/fMg13gt3lmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431900; c=relaxed/simple;
	bh=KRxEHiQTYyU/OTzawB04E/xqAfA4n+zG76v5h7G0d7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9sPip2HxcKJpR6X3W0Tcn1xDK2G946FrUQp6TCVZpxBq8G+PeQZwnzzxNK9dclJRk4eFLsGiyvSQONaCqeaHSfa/5NNMDzEOx3OiVS/zQa3CoG3Vv4mCj6ZzcJhIuAdHIWw7vlbK+XVrt1q8RsGKgqZmi8RUU0OuS4HyI00HT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoDo23MM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoDo23MM"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e94b0aeaa1so171953a34.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782431898; x=1783036698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vi0Fj97kSm4gOIJe2y0udY4DdlKiUQsQ1VFiAjycuSA=;
        b=ZoDo23MM76KeLVDD/4m3oOceHeEvMJtz6D/GrZtOfNjC/qCI0iomcOyULvNMOTb/Tc
         6rEoL3sg/tFLR9ntIYqsYgDl4VzmQsGWy/7vxZW7Ay1A4D9L6TxzVKk/lRIQX2eSea6V
         wCB4XfBZKlkZbvMmkadzuUZlo3AGmML6udAqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431898; x=1783036698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi0Fj97kSm4gOIJe2y0udY4DdlKiUQsQ1VFiAjycuSA=;
        b=iUc4AR+JwujKjrh8+xL//SacKlFpItlNonTN2JdpcgwG+z+cAjPmom4zxEMQotyTgg
         gJiW894v5DKSvRzO84R+5cx6h9dss7d0f1iGe/bcMDpIVJapISFipRptn8Rv+w7RsW/l
         zH+Us6NmiCAaDMjotjkGlmyl9pa+SXBpRa6vbMLGpfgAU2zHnSReNAHhBZMHQH1TnSgf
         y/d5+B3pp6IYG2ufaNsriuaYdVHP6C0r94UvnlBN1y//UsLDEsF2zN8XHcGb3+XgA0lf
         NZpT2gQ8lXxwK1h9FwBgDzqfWGnbzEmlcM07re2QxgmLaMTRQpi0hhg1p6g5OI8oki7L
         yjIg==
X-Forwarded-Encrypted: i=1; AFNElJ8Vzl2pqamKuF8BFKPsOerEmSgJL8y+MEfeC5PiBSR7MeAQ1tMxB/wNBWWJufz9MdijZnoU7qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgHKiCObJncSUh1SObwg3N80ZMKb6jOdsx68rrHZjx6X1MNsH
	ut/sUO/hDEfAsoiieLHkLqwzB80NhUtCv5xwaffU4EntjorUfv/NNisiFZW25CImepk=
X-Gm-Gg: AfdE7cnU/rsBj0Fit2s0PGIRss4rznGwlF/SV7qMndD/mMrmOhudZbOLGCidJkBa/+Q
	JgZFXOEfxyfJXWoF+MeW4O+Rt0wFIS3LpLn1yAxSWN99ZA/AIVg3fUj7fgqsKqaKFXg3bz00QU2
	E0X8Q8dsX4Z0EyYl3OS4/dL+HBU/BAzoECGwkKeLtNG7drRWIrXYrLH1Vsgt/L2SXJI9l30LT/L
	CAbjxjm8STIiEhsbr3TM8qWS7qMsfwKyO6tmjkYUUDPMDM+3H4reJ9kXrlKhqGT9Glj/Gs+S7+i
	pNqBoo+RSohk0rUN9bhw1nZ3GU4dW47wmVpjINy//OBqSM3dvsjb2zUIPOMhW3GsxfNc1pgZIyF
	mLZZNvPCgL6ejuMT3Nd+Ynye3PbIYb6KSrRrvh+zhZcxXUhzQpn4AeRVTonsGy175S0ReM5fzcI
	AJ/TzCSnzSzoVJkFoR6pkl
X-Received: by 2002:a05:6820:81d1:b0:69e:41bf:fdc1 with SMTP id 006d021491bc7-6a13519c65fmr3834055eaf.19.1782431898247;
        Thu, 25 Jun 2026 16:58:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44778b6159fsm10484577fac.11.2026.06.25.16.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 16:58:17 -0700 (PDT)
Message-ID: <4c2de804-4f3e-43b3-bdcd-ea06c97fbc77@linuxfoundation.org>
Date: Thu, 25 Jun 2026 17:58:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260625125637.527552689@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 07:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.14-rc1.gz
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
