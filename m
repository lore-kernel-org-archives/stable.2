Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230243;
	b=L53Og43hbUy9Fap7+jqSGeTxWF8MIhJdfxM1nFv37CsNzpFG9zxIf3/1VpB8WvPvpyHs
	 9edFzlwMWttvjLkMGR2KsQMAxBV7xa4uJA5daRz6Z1bUwCtyIR5+QtyLyq3hzU5d/LyYS
	 KYK6WvOYxl5rFDmzCLVsWUQzFjbAbBZgfx9dn97aBP/+p0QAHaFwNQuDiDOgAbwMn6y7L
	 DKR78xU9rX1M22exu2M22d5TqlMMZQ8GgljRhwSTE34tO7w0OL81rIzYfNbsJUiKp3Lxx
	 lImIDaPNqLkP+Ue23cwKsom/2mr8nC5kL63wjZ2buzHKnDQxpVzoD0xqSAzvI4glIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R9k+w7oblnXJNcegGF9hKmQI/r1FxkDOTnMI2L0ySfE=;
	b=wngojJOHGHQbjIqlRZ0A3vRmJcAqdx7kcgB/ajDY5yGxaBdLFlQImF9V47RpECRYLlo8
	 mK00Qjh7fNGDUryyXjieYokpz0tBVT9IBi60x0IoivLfNMsy94O0f/N3DVGwlkH6wMKfi
	 MXnQp6rXciTsgfjAEMv/fSOzMLreAHwsVcCgh3G1BfDBBx1v/ApIrzFi7VyPgaYe1Ha0y
	 qJXxp9Ph9MQT9T0r5grfgDTmuJ9a9i/RAlaFB4YakPr6FzdsfUCpunFM/n2B7f8I++aI4
	 0go61JUi700hDoUol7dZVk0i08+SupBDoE8otbC/LSevLZ622nQBFuk1IGyF0+VZHfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q75NymhU;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD03606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q75NymhU
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso749908a91.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793230242; x=1793835042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9k+w7oblnXJNcegGF9hKmQI/r1FxkDOTnMI2L0ySfE=;
        b=Q75NymhU49qYgEu7adMh5yyofljn1Fm0N7UkaOUmvxw4wo6FBpLLrHAYq4WJeKYfwr
         EX+z6FNJ1EBV4u3+AjAll2MBf7goD1I5cYn9sCpa3XEX+nFcIo8LDvd5BX2MvgeGlSHt
         OfNMoipjnSwmFlz18swI6oPV1e2zJaWZ7ODp7bADMUJHPADg7jWMBNKeLhXOgdJIR2n1
         4fhMFLnCJY/s8NSKSS0jh1EjVUhW6GUCP2hKWwv79yxpfOjqM/+aVuDvZxY3YqEUI1cq
         t28YvqbCgWCQBhZTREahJyOXfRtM1wFPVMnDoE2KoOdhJFigbxprZnxMyeGS+ZZ7GjND
         GkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793230242; x=1793835042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9k+w7oblnXJNcegGF9hKmQI/r1FxkDOTnMI2L0ySfE=;
        b=yO218YOVcU6/yC+FtMN7SbSlgwmoYFmphc2Ze3VvLJTSu0FkvCAChh8TPWtUwrK8Pe
         ymK/zySddy1IXluvuju2c/G7A/c5z0oaA4w5bUTfWuxnZru1iu9HbjcT9C1gCAYjF3Vk
         1b5HERVghCSjBcIHTRqzm582kxbtTjBPE11BFVXszoWiCqPI1B9T8FkQ0ne7nYEQpNGB
         MbR0pj1VM6gDjCXSf4jTcDcxftRg+GnWDE7VK09e1gOoDWowZaTaQijo/lNMWCk14JzK
         bTZSNkQGtP9Hf8/viRdWhLaQpIqT4wBQtmV8a5ckQosiXC1eCDD8nVhcDhdlFCbN5Yj7
         1g4w==
X-Forwarded-Encrypted: i=1; AKwUvBwCtd/0MyZl7/AxsAeVe3d3hBCWTlZRFSLq7f5+So5lMm7u1pj+gq/F7ttn5dNsB93ZW69gE6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+kYyd1Bdhb0jKNGZ+b4fFEdWx4LtDUdaa93BIDVyrlNhDDrbG
	2FBmdkm0fTpLje5sRq64yt4rIT77Chti4XFvwIailP4dmjlRoFsGPD/d
X-Gm-Gg: AYBFou2XZVYuD0pmBagYH5OFR8g+QeZW+CQP5q74DP8Ln4rUs05vuq+jq01/i8S+/L2
	fRPr7qwT1zVgQfFLclwnxxSpCWvne1guZnQ8wQ5Pv9DiZjktlFs6g3x9fGRYPxETa6d/ipOxajU
	XlEkGbxDAvG5X0BqJpVVMF02D1YeXUI1uYHbG/t3mgCp9hq3ZJztV/YnacpGPqCrcG2nYevk2ce
	RaxrxL4Vwx2DxLGk9KCumAmbJnT1XTUlE0enoZEAJkOtt03Y5vDCPboyBnEyzLdZpVC1m6dkFY3
	dkUVKApDB6fOl9TJcKN1WYuyDdGMCOrYA2dqSRjgjwjA99JJoPOJ1bI0MhT8ZQ0294bgEG3qn+K
	MbjnUZ8WX257vJ09Xh459oGT+XZqsHiDchK6WLXJ3GnPKKR8rLRQlVSONTp5gZhfkgKSPAQ8teK
	fgE9B/cFxjSPtRlwGpOoiW0Dgu30F5uXY7Qvee5jNLWw7zJqdpkaOi1Ovr0Oy9+o+KLNCJiM3tD
	Tdd1fVICf0qxfRHnxx+DAoXJ6T2kP/9r+t3nQlETSG34Ui1LfhiBVpLTOx/Ry95jWc7cNY1pzax
	tCjWpFNZNGgIa++zcE3w5IpYaWUk1mRCpgXq4/vLWY8s9V8DYu5y1+Yq9w==
X-Received: by 2002:a17:90b:4cd2:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3ae57f96d53mr2559235a91.9.1793230242204;
        Wed, 28 Oct 2026 16:30:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ac44asm1305555a91.2.2026.10.28.16.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 16:30:40 -0700 (PDT)
Message-ID: <2c58625f-954f-41db-aacc-5340ee06d368@gmail.com>
Date: Wed, 28 Oct 2026 16:30:39 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028165947.349197979@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
