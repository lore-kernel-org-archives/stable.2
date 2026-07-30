Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D73F076E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433059; cv=none; b=A8D85sl1f0KgHpRX48AsYjaUNxP++R7MoXScFgq6iAcU2D2NMNTLkjTg/ORxVnEdw6DZu3j0Sm56fFQt+mAuW+HyJn08VIirosq8x0Qp2GXDNg2UxfQm2JceWs16JSpQ6dQ4wknziDewECQzpMrH+BtY1oyJqXDVQdzsNTgvMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433059; c=relaxed/simple;
	bh=KEHws8kTwmKOCb/5Dw26fUo58ySVRtn2uks4rXh1LU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjQt6B/0L3ESwWueAxjeiENKWjv8Y56y5481KoO+ppAPJI7O94CkDb6pp67XCBQXombWZAPAQ/oWGIbUwhnRw2HDWPmZyyUzoXlktenZKncuV5kQZj0aSP7hbv9Q561WVxDky9GdJsOluHvXdB8RedFxQp6UKwIBLYxavLXHAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKRGoKsm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKRGoKsm"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f23e851626so1056826d6.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433057; x=1786037857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsJy5cWyjmORQNt6G3D0DpIqpcWadnp4i2dysW8ERHs=;
        b=kKRGoKsm971Fq7KwBuvLbVTlpuIb8vy0sJWps1OrtFVep0U2ltNlPQ/wid1pWVKysU
         Hu2l7vp3R1UaNroRkrJ7XmasAbJk5ZMUBqSLn7tneXg+1EEeGAw6Fbs50+6PuNbyc8wG
         N1UnReQU2MuegLpefnVgxGhZf10BU30IGITlxP6PVMbSyxmHvFxmkWwwt/KySZuIE7S5
         PigNHT10csgbPE+AICCOZtAHpECBiBWGEhZLvTQJgIBrqBOQYGzbtpCn8vMNCZmfYcuz
         1t8uRNOt/btAjlYje/lNizsfMpnbIfLYbnkZP6dTxjqTkKzsTxtkTSMU7MsZ245woy97
         19Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433057; x=1786037857;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gsJy5cWyjmORQNt6G3D0DpIqpcWadnp4i2dysW8ERHs=;
        b=MNZ8XP8+axV9TG2gJGDJBq/w/yBhcHgLEkXUnSOMW/FGrWPGaTVZ7oXP6x3b2DkPoT
         GsRgG0sLHhwVPmyErXlNDIerjL19Hp5K+xx3TtyVtsXwTt2Pc/rRMlTZiczbLjEIsX+I
         M9fHZDApFu5BRhHeM4FICP5usQ+ts6tF4MLgj33vpNNBkU9DgiRNGKwExoo5dfHfPKBf
         Y8S60cWYI0c+2By/FQRpmmyNeO3zpctg09W66+pTZmvWotR7YuRXHYxVAIcMx7A1zsj/
         6qOH9Xwb1yo403dajhBnYmZMrI8sgJ1t2jlo/YZN6s5WD52e290XFjSPS43ZtlRWcTIl
         jsmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZaqdGBFCXD5RipTEeh1CS8ReWsDdRjz0jN0Z8bWBU4hQzC8bLSL+MxdT2GyserqLLbsefsJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7Mysa7Ym2fifZnJDJ7/iGa4A9mckOYCz3pA+0xNDPdOJGKeq
	A85B2DoOSEnd9O0K7yOSYguqWr8aRMtRqnU336WdAhuN6RZd66zyj4VY
X-Gm-Gg: AR+sD12lYooTdN5X5fu0+rVIEzv9hs9hhTIh5H+ug0+wP0VGLDT3t/FxKiC+9CNhqXC
	zjhx476t4/afPbUtILMYjrDL1WweF3OwiEVvx2k6fFZOFav2pTdC8J25iNGX3ydmQQwkEKRSXqr
	xmSdHvnuqFydaBjm92QAvtrZ+zJuq23P48/aZil0AVTFLuz7yEIt158TG4AfOrLA+W0jIZMthEi
	Y1aN+v34TVZHBq/c2NjVWJzTivDVmE+GNRSo+PfwRYOyiZ51qjUPW5iV3UlcRkCnSR3ZHX0EI4O
	R97CZ/MZ19CkEndVE7UcExd2yxNv9gjkQaZirLhHsFRjtj9XPIaA7RDHkFBz91wr1RmVGdq3H28
	PNkqOwqZvm6kfRBWMLVOF07QObjv/0JVBl35Bxx2rdyjj7L2NmfGQ++7mpEUsn3xXyKePfMQwG3
	GGO95/K/TOybSrp8srpxXgDu3XuvsE5+wRVhgBADXvtq3a6VUzEauL05gVqieRDc32fzlc2UKT2
	jqZeDU9DicdcpJ956vCMPzsQA==
X-Received: by 2002:a05:6214:c48:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-9083bdf2959mr10195586d6.57.1785433056435;
        Thu, 30 Jul 2026 10:37:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908322faa60sm22392056d6.3.2026.07.30.10.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 10:37:35 -0700 (PDT)
Message-ID: <c40caf39-367b-4949-9eca-037a588a4509@gmail.com>
Date: Thu, 30 Jul 2026 10:37:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/602] 6.12.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260730141435.976815864@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260730141435.976815864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 07:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.101 release.
> There are 602 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.101-rc1.gz
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
