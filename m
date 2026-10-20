Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514576;
	b=RS4Uk4sapy2bV3wgrn4HSfqbxAsjvXu3oRFSHCVp0Q+wth9RkRQZx7lmPelOW3lPBtfN
	 fSvjgT2jfTTX31OWb7RwlTscGwzghmrqdSNA1hyJmvYSoVeKKkSR1M2OYhBr4qDE+m5qV
	 /yJIKz8p6JqBYG8j2OR0NYYa6r0wqXT/BhFZHh0Zbo7v4rrobwSely8YF6ycWubd1kif8
	 xSsxNQlk59J1QijfYQ2RMHVo9KuKciqFhFq+eLOxPi3lRKKK8qF7TlgmHcUYueBcHcZCG
	 RwnTqZ5a6Ysa+ElBj/sosDXrQx1/3BJIKjYWou6qisAKrFHf9jCcIsiS1/i9FBpoVaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ipB+gpogUeHkQr3iI5OCJjKITatusksUh2DkAn6oNQ=;
	b=nbPbZI6ItWomMAeH+sR4oLd6ZptivxYiFKhsOsjObtT7NvmVNJpmGy1lUvx3ux0Es3ia
	 uEtupOPhnDKxEf977hz5MW2CY6Blun9f+EOLDMJ1tmfr1QJNsGprX2nJgHddJvPLJI5i/
	 x3L9rv3LS9litEbn1dflJIYAEv5oCWN8KFqjQOFuvPYAitMvTZuS4svswxc0RpU02Ex7V
	 JpXSonu8WLtHaKVWjXxqf2qQgRoxj5fX3pn1q1AopL1pNJohmCVv4VOQW98j3sNFQjUm6
	 l4nqbsDDUsXu+kqGIJZS5IW1TKqf0WoPKPdj3DHEYsSUR9t4qDBkHmDRSKCmjf/r6sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARMHaIT6;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B32606A324
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B32606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARMHaIT6
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eabf243d05so1042411e0c.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792514575; x=1793119375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ipB+gpogUeHkQr3iI5OCJjKITatusksUh2DkAn6oNQ=;
        b=ARMHaIT6mznQ0BVlAKylcPY67gqiGzx/n8T0xink0OI6nIEfMYgqLhTvDcIC/y+NVf
         LA+0B8oJmfWd7JL1NfmjV5qrBzfeYAA022uwNgbfpdp2y0HP0JSLvNbgPoFc7DDNcNz+
         rXtekQdry577AxSaY/HMJZcfIyF+jNV/O9yvycWEax+Hz/b+2CiAP+cepH3rS422aWqE
         AtNfVFU5imAV170S23iOTN3s5sA0hV+Lambh+mFiG6doW5iuxhBK+OGYXDbEoyv+9Sl7
         I0bKsqep8zgm08xuV8BSWb2du9bfAt1oIINId48p5GGXKUFogRXHWKhX7LZ4f2uQllbw
         v18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514575; x=1793119375;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ipB+gpogUeHkQr3iI5OCJjKITatusksUh2DkAn6oNQ=;
        b=CEaN7Bs2QzDwxAnm19Rzf2/4F37uRz/Juq2NMM97rr86YvvFWHIzNyStrlzUT0xfQ6
         ehrUTxhFU/4KQU2uhXmtSwjanQE3YyfSGcYXWVXfDglJP3aZEZX+ZaHtcSyDFoUn/hEo
         WCfLfDuHsMdHOnbCXzIIbT4BxoCus76D5Lvh0dGHXo489BvULtnArgyVlwYChrZWI+8f
         sufru9lTQ0pJz5q3QujO+6fxKP0sF6rg4Koo0PAq4g/rfyv/DLgiJQGvv28pjHKgYglg
         knV+wSciGEeVnGsaM4bT0JwhfYG2brpzzczjOqak+5eBYCp5Nx3UKR5MhVY/b0bsc8Ce
         wN+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwXVSSe7shB7xZFpmf60sIsq0h41zEdQ2bqbsAl3OiG/3c+jQVOm7pFXu6zGObZSRfA4VjhFKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiL0xtUUcpqJ9cP9IS5Tap1G/z4UNHrokfzJ8IZIKr3ba7SEF5
	mInsNDjIMyeoGbx266283r0+UkxK2J3Tb7NRCbCXVWHugThyNtmzwr2d
X-Gm-Gg: AYBFou07Kjc9hU3JfSnY33+oyL5SOCura+3+8ppxsZeoOhAcB8Nn2a2J420YpKCAWL9
	rrAHeHL4uSSjSJTya88Zm8erjeBtbcnPC8/JyaRvvEoTxesn9LESrheWuLtSPjXd0laDMZtrrzj
	CYyU5nVMTJjojP3lBvoYl5ZTv983VCPWHf1/eRaj7d86slQkZwgJkh0VGAKJRj8D7Cb5izXwID8
	uCiOd63Y10ximgCQuipeMAAbpRb9wMjxRjvKgeB5EVbLF9DmSnDrBJqzx5TUD3Z3zo6NG0AOQL0
	YsvFKGz/UpbCxww42YDuScvuMqR4azGx3GfzLH3HX4UP5RWbd4rsa4uVjIlK6vIGhOgzRYs90R8
	qasjJ0RCPM/Nu+MVrDj8UQfyX6HVTxAjoxuV3u5dLd+zFIJ2y6JXXDSQhWda5Vie+rMJ+WZ5OLc
	n0gwZIaGtg6jLDWoG8ZWrkgbVF7xc+MTRgChm1YlRWsTk563WPCld2q+yNHKWThTc7TY3P0ASwn
	nC0X3jt2r5Errv8hyqls1Mp
X-Received: by 2002:a05:6122:3d10:b0:5ea:c51a:37a1 with SMTP id 71dfb90a1353d-5eac51a3aedmr1843253e0c.8.1792514575062;
        Tue, 20 Oct 2026 09:42:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97ec3fdsm26291e0c.12.2026.10.20.09.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:42:54 -0700 (PDT)
Message-ID: <d053ae85-17c9-4bfb-944c-63e4ec77fc56@gmail.com>
Date: Tue, 20 Oct 2026 09:42:51 -0700
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
Subject: Re: [PATCH 6.12 000/858] 6.12.114-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261020075246.861837975@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261020075246.861837975@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 00:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.114 release.
> There are 858 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Oct 2026 07:51:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.114-rc2.gz
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
