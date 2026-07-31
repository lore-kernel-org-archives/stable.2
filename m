Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327445A2AE
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540158; cv=none; b=gR4lopETFLj/jzvDmYNSoICjpts5TSQbtWlA0hil9r4fA/DvrsHgLlIilTod+fH/0Tn25fap7KxTCTzrucvokkoVqp3zn4czGW0ohRqJ6gMdW16QKluzHHYV5S5gnIZHx2foN9UJOw+XpnUTPxqxz6hOfArQ/rv3GFt2hkQIIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540158; c=relaxed/simple;
	bh=Nmz2rJPRew4myJhDE5zms+zHCoWFtHuTj//LAkatoMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOdSjaUmNkr1U5E+jlMyGZVaCbiv0dhQFHg+ddltTXQRYK6UknT31/ZMo8MCAG2obpwFVN1YCNTBcwIkaVCPIAopUZ49YeHgYPnvMQYI1qIyIt/6ZjdL0fYU+8ahCO/7//53J75CsMZGVG1+SC79FRDkW7kmuJQxCpq5GveC9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghTSFx9i; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghTSFx9i"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso935290a12.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785540156; x=1786144956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LltF+iQAYfjjcEhnwprlcO3IY3gQv3vBiaNLQtnKShw=;
        b=ghTSFx9iAjgdWOqM/yAJzn9JcEz+7ny9/io16kKlNGBotshxFsmXgMhiZK6XlV1JBw
         xcU/x6lVvahPUIH8NLcEhNJ2F6BUxsa6zB4zlzYoYh9zBGt9LaX/wSpLuo66WrlKhVDm
         NPD5jeH0SOP3SiQIe7UoIGtVGEXWA83wkiXzK3pi5gfCMocQjULPUkOvNeEZjn9gH9TU
         JRG9HYlFaynftOp4lWdUQ/2Sq2vw5lcNASU/uTcv2dcy7eH8nppuBiDOchSYI8CtgLVI
         oz3vlx17IdDVP8NX8+DCERhLDTkSLbUnFGXrS4Uv99l+3ys3A3ss7ZR3Z6kQUc144JN9
         FFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540156; x=1786144956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LltF+iQAYfjjcEhnwprlcO3IY3gQv3vBiaNLQtnKShw=;
        b=ClulSi/oWL40SEgkEIqka89BA2h6M3c0ut6FhefIfQEFCNR4uDd5YpHwD3MFGtg3m6
         yDgNyxLIriuzjV0hfhHX4344a1v/FcFRtS9SRdxV3jzY6gsTpIawDNr0eLih422LVTB4
         3dBO4rTj1ShYDzvD6MMqWKhtojmAoYkXAub37eM+bMM5e0cNPUiSzH2wy8euSDhcbyAX
         +x0VTWr7hcOQIhCaUyjqM+d2Bo521VG2B57HDqfq9l/qmCasL50fmgcab3x4B8ml75/D
         KoMYsGljs4aW22CuCxjMcX23+hp5PV1ftD5Z4EGy8pGDTyNomCjmpUm3p27tvmjjTJqm
         Xl1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrOT0yvkBLVU42jQZ8H45vEqM6/0My5kCwxDMfh+ooaMnV2JGLDTwAFlJtNAp8xFNtrTMgN514=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBp+6knVTxkTBUjTi2kx2D+MliZ53U+cSr5L2LGMaQYSba7t9A
	YsmXwOwtvBaiUb/hJIQs02CT0u8xqm9Yx0EhMkKgb+HAKJCxLjJQLsK8
X-Gm-Gg: AR+sD13dLF+G9/j6doEyzAQE3gWpOXC/thB92abJrBmdxTdLnFRtyKV28vXMdNVfUu+
	pcsEwxe1X/GyNy12VlCdO6X5tLyUFKrBzHAsBbCJe2UzLhVbdNwQIyT5aJOqV/HO34/FnvkIf9t
	yDbqygBpiQT5WVg8r6l+tbehfX++htOWw2k60QMnZ/1tSwr5BDV1OrkyPL+3I+XR+xks8ZYBVg/
	zHSvO1IRKs/+7aYh2mxPcyp3nSdYTUGf7U5TAQ9DFNRji1v1daTDcVm7xCY3IbSKd0pcbRrIkh8
	vU+S9KkA++DHHwAufeJyvGHc74LcldYWWV80zkVxX8WyTMNyh6RiB0DODZmE753aNFKw+mvk0OY
	Z4SYRIOkRvJXD1RQ+WtUsD0GciPJaO1e8HfuSeWLXPHpxT9PVE/kGuVyIZUysft0TBoGeMYTn5b
	Yq/vIjbQO+jHBYsO+uiQY1MhY6Y2ughDH0I2EayKit9SJxXkgBGImBZ5PyQlP5B5ScCJSxuJves
	QY9PEnhefQ6SVY=
X-Received: by 2002:a05:6a20:258e:b0:3c3:a546:12a2 with SMTP id adf61e73a8af0-3c92a824e52mr1363560637.52.1785540156116;
        Fri, 31 Jul 2026 16:22:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddcba2bsm10855613eec.11.2026.07.31.16.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:22:35 -0700 (PDT)
Message-ID: <7734bcae-2c5b-4d27-ad7e-8fe9a57b7444@gmail.com>
Date: Fri, 31 Jul 2026 16:22:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260730141444.267951807@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 07:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
