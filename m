Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F0399D0C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400473; cv=none; b=apfS+Aj8jwDfG5qGFeVzUZs/d4w737AMqY5OJkznQz2p+nQ+bC+BBS/Oaq9DAS5/Egf2g8kYIJF9NAuv1cbQZQf3L7pJDlNTO3YA4m9FnHhnnYa9BEPjDf4Uruf8LoiwqILrVZBwkDF/CvrtXV6mTGevWMWl5f9zwrQqIbkzKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400473; c=relaxed/simple;
	bh=YxMtMKdJRVqLnvTqrwryqwIm4gyNBPQBUx5K/GDgWWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRfYsHd8t8byPPZsz9EOnwvh8eGrZxvdxRbA3h1tm38t5RQiNeLSmkvm+AAFP6C5CzHHeZMsq7KtNg18lsS2si3XUgJe3RYAHQDtOKB6YPcdD1Lb1wrdbN06roiCQSRJ6Dmc61BChw9pOVOdCp1yuLWCwz88P6B/M67bk0AFXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdAxjv0k; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdAxjv0k"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c999f162c9aso182060a12.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786400471; x=1787005271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EhH8yHW1aCCAUDKyGcbi0td9RK/+xzXgFbOGp2XJPSY=;
        b=fdAxjv0kaDzCpefatoZIEDQUVgqht++vYn543XUp5QJu+v28f5DE/LMNX1NMf98vOo
         Kmd/a0WP/ba9VqKF4QXJpKEF8PxB4jcPto1ZscN3MyT6hJMEOfWrZ7cq5onsJ4Ipqr+E
         /cJ2bKmr+buSw9VDxpFbyn5vjI114fPIY0HMaNUMlAzHnG6yjrLtAtI1MX5fzb1D7T8X
         s8GTGfIzcfjfkJHoHBPurVx74BV4reoYeEzBjsbXAIEKigNVDetZSGV/aeHOzQz3A7eZ
         L+5nU9/byvG3IxTd9HU2hoqfxwoNJ3ZBCIY1dKh8mwfKunoCWUz6A1l/8CMmJtAGwQhT
         Lyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786400471; x=1787005271;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhH8yHW1aCCAUDKyGcbi0td9RK/+xzXgFbOGp2XJPSY=;
        b=B6T984EpR7Y3Miy48Mxcr/UVsj/jMlwBJhAeA6Wtk5V7In0SeLHlnhRbojBaPwTQ9p
         4wRGqqqYdFxevL29J6W78D/H9iX195cJS6dH4ah+CeDm3y6/+X1A/BV2JPYCcCTnBuJY
         KerOdl7UgE3kPZFixJ8FjFBZUeA8R1KSm4E/rwDmwX2sWxSsodbfinAdn3+7EXJLGkAr
         ZhGYWQ1SNLts8OxTEpTGWtq8/6Ck+317n5kmM6eBNq/e0NPhXCgICeCJy/nntCSJ6I/3
         3iz+fwFj9cwOrOLeSUt9XTP/+9XcW1yL4z2i0STV8jFya2Mjt8Edxb3o4jTbzVvjIj9W
         dhNg==
X-Forwarded-Encrypted: i=1; AHgh+RpyjL+jpI+V8FrcMs7AzzRtFQNAb933rinufibzayQBiPGWiJSDtnWmTlfrmS/LabxixllRCkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6/YU76CTU97wSF2Ob07VVSEXVtauVMW7GsxPN33dYZJbGwtk
	eyxlyen3kUcTonJCNi1qjI9l8zii9zqAIenKG86FLS6Duium98PEpv/b
X-Gm-Gg: AR+sD11yeNX+4ODwjPtOzYP5BrIHm9J2E2zj7HsNhTFApV2o06lx6/fvne+wrEy31Sz
	ES9/1hOTOJ0SLF5MzDqRLATTj0npFgUsr7nh6WtUGi0AH1eGEAUN2/dipbo4Avv3VfbhAHnsiSs
	RkGphUMWcBM+MAQgrbkZZDrZCb3s81EmVvOvD5sT/FuQ2Vq9yKTatb61DZIJT+4p1iJEeETICHz
	5tndbFeI1arCR5pjPBHBgIrk+Y06aN6Snv+Oc68M+YUhAjzLUm3SUFsJq8DCQ5RGuuY7YVx7rnG
	mwZCB+A+OrQqekg0cGHEpGuT6+ZwPGWOHsh0fJbpRxFhFV2PB6BNt0RHgz4rkqiQdWOcd5icy7K
	dkcVRHM7ijOZ8cNix9uMFxu/akiLAGUWAz+x2WktxC5kBU0uR+MUJNlfNcEAA8lRod4k9prXwd8
	6MJLjkfEfLv/inSR2d4NpFoA1maieKS/CqsMsBdrcpIPCHHFncsLFB13AeJ7sudZmIrjxLjVLRn
	3FUbUv7aj9G4EI=
X-Received: by 2002:a05:6a20:cfa2:b0:3c4:397a:69b8 with SMTP id adf61e73a8af0-3cb85e6c93amr61041573637.21.1786400471483;
        Mon, 10 Aug 2026 15:21:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101a60867sm38773947c88.9.2026.08.10.15.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 15:21:10 -0700 (PDT)
Message-ID: <012b8d8e-3add-4694-9a30-57475e1a52b1@gmail.com>
Date: Mon, 10 Aug 2026 15:21:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/261] 6.6.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260807143415.358597922@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260807143415.358597922@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.151 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
