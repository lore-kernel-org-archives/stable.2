Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795D33F5B3
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716702; cv=none; b=lp6Q1WHwFpYvRmJ76T61x/xL5Fs4Eiybd9Ddbr/QIF/kJ5+l1hBtJN1V1T/XI18NdBEdRiRCuymkbh3ZsQ7/m/4i9rgksb7imNRQr5fO0syQCgct2dG2rLw43cPSxznX7bdS9OjNkd5KQsugVfD/s+JWHIl6uVo5xvZEmsGzx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716702; c=relaxed/simple;
	bh=zHKO1XlZBRzXSXgfQgWwKooKrNuhcoEsmgecyBdnxXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVhh4QJ6bzHJTQ3BonHJnfLXsc2eGuO4e8qVSp46CEM2TfiIuyVtC8/0jVhHZCrzEYPoy2+kGq5DjVlbZrxJOc0qu/pI5VBEaP0hwbtZYczvwGUm1PbK/7uiFTL1AoYrQH/irT4WHv17vBuRI0nIiZTY8IIBzE78/uKFt5mtwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xpr6aDdk; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xpr6aDdk"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69e66e11386so11855eaf.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781716698; x=1782321498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASXWrUWStyQOageYC3LoVBOOGZ/iKGTFoHvXDiH7SyA=;
        b=Xpr6aDdkRobcxMwtV07Lg/n7gC/ReNEQq4Szd/35DrsDOevsFz4paqoewZGqAfmXxJ
         Qt1WgC6IBDuM5shdIZMIuheNy3Cvy2qbxFe4z7CGLpDmIddBEsGaGoVqdzOIwdIgE8FB
         F69mMmiTWk0uUoRoUEYQq9wyO0VHXWVIdc51g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716698; x=1782321498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASXWrUWStyQOageYC3LoVBOOGZ/iKGTFoHvXDiH7SyA=;
        b=r1g+rvi0okHIRyHOVaT4/W8armKSAoy18lgUkzY2kabwS/aefDfe4UXVJx6ehQiDmt
         AzcG/wMN5ueT5YQKXKrv3icST3Cos5Zvp78fI6FxvnLvrp1SNhLKnoBD6gH4hBWkKYAr
         vufbiaSFMUplFYGzjxrClwVxU+8UVAegkDVqSG4nGCetkvnFi/bjAfJyZH3LUmpUAOnL
         QWj8qctw2fsTSyZf4YJlIEHG7nxbNgNbbyJgmEFvI3FU0e4ibqcUFmtr6yP3xIawNEau
         VTrVNfIWdMs6WFQ1RHAizSMNtvnXuYqLXZXa5EP6PIjjzeJVK2W6s9Tk1lKHaK7bTxu1
         QaHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9danYtxm+EOey3Oa7L6RTv7i4MkebdanqlWLDxu7DKegjIOEMqCFobgbdn3nr3ViZazzbRilM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FNaFrnZUITjj2d0PVPihsZa6ld2zn+8q+asaUPFPAJ9im+dA
	kUfnRgbRwaxJbbeoTPe8afQR5EldsLYLI6wn1KSyhr6YPHEbxlFUtlOtMhWRMjlrXfU=
X-Gm-Gg: Acq92OHH2ewPrpDTTfkEaTMd+SRndiUg35f+oz296/EzeoVCyIQHH2Ivi/QOhyzAwzm
	u+6i/aFIG/S/G8s4Zmzd2bEnaDHJP2WGLZphNCXQafGBgjRteg9dB+BZvqbwol6YrJt8qNC2QZZ
	6rD4wbyHSoTqU8yhRLAuRnYWzwiZerVP585zLIrs7SImhL9+SJz2EU0Tep5CuBeH7U+QTXxWs/w
	g+0ygiJGgKChO5Ko19Rn8dlP3HQhhGrX4Y5zOWm/l1bcAdnHEqEFe8QUb8Py7aKU6a06ZkCqvck
	FqFDmj9zeWW+NQ7uzACtUJpEaCBykVDzKbMhmluo+eYU/zq4/EwnKTXULCVHKyRHbVeosY9/xJF
	by+nkFChCVbt8oZZbjhOW9EWwJoaTHd5Hq9RILuEJVZLpgizWvdlsKqTX68HKjYz+iIXb0hH4ZW
	VtzW3WzSaj6NDrba4HPXgG
X-Received: by 2002:a05:6820:f022:b0:6a0:b429:4436 with SMTP id 006d021491bc7-6a0c72f9a99mr346616eaf.0.1781716697847;
        Wed, 17 Jun 2026 10:18:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308a66827sm4841164fac.2.2026.06.17.10.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:18:17 -0700 (PDT)
Message-ID: <5f919e15-45e2-4c33-896c-a17782d5e8ec@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:18:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.36-rc1.gz
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
