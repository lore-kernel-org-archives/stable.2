Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A299226D18
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074580; cv=none; b=rNLIoNsl0JNj86wcMQ2biMshZdqDGmZh167wXJBxHFR9JLSj5NgCMVUuG5mJiHzSOdChT9WWsh9HGqe7cUhDGvgO4PVfKN1z102BZiX0bqW0aX00gyiPc1jukPXQxsPrhSyBQ4TVOa0DVgrOXEnUqiKlzT8x+5qEOaeS2/sNqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074580; c=relaxed/simple;
	bh=g4igpkjRW/gzssrsO8VF7rAC1YOodN0DQU+YJi48h8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWnFHf93BlLtE163coPRy7K8IunSbtoLFMwb1y6eZVtPLP94k4h6lnbbVROUZoNAULC/dN/Pm3GnZf6xK7nGrjv7T4r+bvu/+i2eSEmbHPuH5DV4WNAAHPC12JE5V5hTZZN5A1TkD695gHJbsQFjGDFltwjc/ZRv3Cnv+HgKdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGHe3J5r; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGHe3J5r"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4b28d7fdac4so131555b6e.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787074578; x=1787679378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMas4PLE2VjLEhJFKIS7cha7z8zOGMsrrYlzGahYsx4=;
        b=hGHe3J5rzfa3V28ZsH/2cFqy5TMyioqKs4eYzsbCBSYkOpUmoVDzK6LKhSRSohaKjx
         /UF0H4tbVvcJY2qGCBGoUd2xoPdcqnA4tBSiwWG3W1UiTs2UzXAbuyGe33v1XB8pelof
         gfO5AteUibAh1Za8r7HCU2keOz8u1Y0oSfu9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074578; x=1787679378;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMas4PLE2VjLEhJFKIS7cha7z8zOGMsrrYlzGahYsx4=;
        b=l/wMzCDn4WCCdYciTLlK3eRD/LnzCMv2mWQ66dd6BSHyoWe/gqPELrGNj3dSH+iXax
         /rI7WxYx6+Ff1rf6nnr5Y6WoMDtkszeLwT9gqrYE2aXcGmZtAqIultJlnHleTPdP7/pB
         o7poG4cFP/9oK8L7/8Ib1nzNOlNTLcLFOY5xTsQJnujJxuDVhoOi4A72LdQyYK48nAXe
         vnGxg4GrxFfqymYDUm6lh6dss+LHY+yCMRNUA2apRSaoBRhAWVJ1h/mJTmyGKBXQBsAw
         znaPsr8QBnqSv12mOkHqXxJhglZUtFL0tGXhAyWNqz4ii8g0e1fD2zfYdW30BoZh2GSf
         M93A==
X-Forwarded-Encrypted: i=1; AHgh+RrRNGQkvlkilSrVP1d+N6onA8LigLkyJsdH8Ou1F9vO5gELCZ+cqYA58foRE4TyRflVD87HMWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDm4kPr2GoVCyn/nYlxlT7+2E64GtMGnJ+JJ3nyTrkLG6dWrT
	dkeXaxEE18WcAryx+Ys/04k9NFtANLOe5WJAG5Hf2U9LzMrl3MzaDjABEsJ71qrDRxI=
X-Gm-Gg: AR+sD12EHDQFBb2IFdzJ6v8JEODl48y+pLVdaPxBEHMiSxgHcCE4FNVdaITUCpXmB3q
	98c+mL7MxmyJbkWNOiLjhVxKQXPIFfOWlnNVqUOg3GDJYmfTGLsp2qKEJ6lZf3cDk0ReGPZb/vE
	0ctoWmJkaX02MmkyWfo9KjCVfwsKkqXHNb6JnoyazmLaJG+KcjuEBNCxY5puR/F6ie3txYsJydX
	oXXAMpvxgg/vl3qGa8yt71czIk+2r7b8MhT697nQC8r+hPIHWHoSkEtksK42K9JEcjk0cX1tOFZ
	cjgg4gR4MTxmA6/AMP3zSsQVGTzSp9NEwWUSdsqP5xnX1MWibQLydHQOR96zLjC71uFYaqhZtZX
	PNSMR5MDBSRTdaj96llX2cjx+xBYMsmdcYkontHMbxkJJnVHJ7DHxrsSaVoEHbucunZ0mA4vwUR
	6f6+gFoOc0m0QvnHGY2HPweTml6vE/lW8YvJJzKtJA5umrnE7jNwgFmkp6LnOuSAo+iT32nQ==
X-Received: by 2002:a05:6808:1484:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-4b241e09a94mr34744190b6e.15.1787074578056;
        Tue, 18 Aug 2026 10:36:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b290a46307sm4505829b6e.3.2026.08.18.10.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:36:17 -0700 (PDT)
Message-ID: <6eb71274-31eb-4836-babb-7f84c29968fe@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:36:10 -0600
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
