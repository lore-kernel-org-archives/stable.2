Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5313ABDA8
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074643; cv=none; b=BTqZozYDKTsdvsOvAte3ER7idZl71y2zoPruqvRmsaNznuk6jZKDP0xCBURmBS5A4B7mY5G1Jm2inIBVw8Ec9TPiv9IKW/pfBDMkPLi+fj5QHqxINgtHY2Mno2A8WSC1U4HvGJs+J1XVl5xdNmY2Gx2xOUdrahY2bM963q1PqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074643; c=relaxed/simple;
	bh=g4igpkjRW/gzssrsO8VF7rAC1YOodN0DQU+YJi48h8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uI6TkGPYZZP90vSFtFLbRT2EtJ79gbgtFdvVYbhf9oEZu+6gccg7I6pYriU4fSPMB2s9b5rBFJUZ+sqUdyjNb33z01erKmgJ8HATq8+e3MBcEFZ2DoTgs0yO/79PY/0Uukj4D9YlMVSQeg28vGmLmT9qmuLivAynDW/+I4JmB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+1PgjFY; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+1PgjFY"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43b7e186a0cso85570fac.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787074640; x=1787679440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMas4PLE2VjLEhJFKIS7cha7z8zOGMsrrYlzGahYsx4=;
        b=W+1PgjFYkGJb9/jIfa7tRyTFqcdhiDzTFM//hJmXzBjFEUBAbynCAqUjsep92YuFXC
         6PXLlje8X4Ej2TyqNPKsZgJORh4oB3AJltFjX95+qAH1YQ4v20gFa4vLNDKd8HQxnMMj
         bCxlXrHDrzwI8N1BZ6e8YytYFdRHTZ57E2vUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074640; x=1787679440;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMas4PLE2VjLEhJFKIS7cha7z8zOGMsrrYlzGahYsx4=;
        b=qfJfhmbCi7n7Bz7u27TMvJ2nXo2kQ2xCs3YA1Z0lhk7qDSeJGvClFwPgbfNz/B0O35
         UEErxsDDtpzfayOp4hGSbZZDney24mjcnwMwYS5TODTr/lStLh6+oYB5jCVewYruooLu
         Bzh9v+ZV4axVu6wQHn0VTYHljNB7Sxy1rcA/WyqntD2KUDO+kO2CUX0L0u1joJsHWdvE
         nH+acABKJeuW5wz99pFpxnIJBB/86HWgZxpznJ3xstjGjGerZkynuG0oKdgqU7Vr05Vj
         s9Fpm4HQDMjY6L7WS/GG9IpIVUD/FJaigMmIM6EUqJqdHhmcuCdiEXOIY1hl1QnqWWVe
         98FA==
X-Forwarded-Encrypted: i=1; AHgh+RpDVnCKkveMazNBujoyCY+WTZRi2GJDWTcFcuXgs24I6k1T+369eZpQd5VqZQojAdigAZmhltg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxtjkdeClvWoxMyYQIXpriD6M3M7yrQA55235Lb8sdwQ5Kss0
	fuN9yHjZPWcneLnKJXIvM4bmw7sCj0mmOh33MDsOyPl6wDWCEOMMH7CQq8zlKbw4Qd8=
X-Gm-Gg: AR+sD12oPHeaVr5O26EfF+ZNEVs60ScPMYx2bmk5Ar8MuRQCYgyAAEjyeiO5Vbx78En
	Ci7OLMTjOOK6lMiJD2Mr92vS7yuY/GBSPWdDimPxNE8IZuTM2qInxJym46/rWRUEJ89mpZdk6A3
	rDHUx8mKZjsNqKKAs/nkv22MAUlsnWmmFp6KhXwqV8PrdXJJYmeEGppMI93BizSe2HdMpjpDh7E
	uX4jP9JYI4HiDytUNim363QYk73qfdv/RkMMeLi607f/mQfU+G2nWS3ufUyY9eLUfRktNRZU5iI
	DJeOVJzO3xthq7LTf3YROWV5WTlSyPG/rkQD0F1bSOZ1/lkuc1EhwdjhDKOc2keA7ulWmWevavf
	OoVqvBeVlR1LxFAhBzrD3HeIPOlJ7We8IQubOQojkgUjZwgnxE0GbEwqjjeajnNmQAeUETR6p6H
	Gfdd6dXq/p86j4PvofNnb4YDA4UO+5r/QCtey+5xdl+1aGupi/Yvvmb/1rYtNeEBIuaAuZxrI=
X-Received: by 2002:a05:6808:220b:b0:496:11f1:f2b5 with SMTP id 5614622812f47-4b241e1589dmr34983556b6e.10.1787074640223;
        Tue, 18 Aug 2026 10:37:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b29609c26bsm3354116b6e.13.2026.08.18.10.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:37:19 -0700 (PDT)
Message-ID: <ceb0399d-fadf-40d1-ac33-e8552494838e@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:37:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/250] 6.18.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132536.466235697@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132536.466235697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.45 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
