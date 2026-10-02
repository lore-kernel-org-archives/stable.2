Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AB2798F8
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961126; cv=none; b=KMSXaYlQrR0aPsWI1BbaIq2X98o0Z+SFIvFTJ7Fq/HgfyIumvJaAiE4DxpnkXvW0mwSecwfiUUlpdK/mnIbgEX7z+HZYxdzqHvA64jH8Heo4HOkU6O7JteIeSumSvyiUSJBBB9tfqtml85mUuubyqqXQJaV31q9D0I+A1m368gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961126; c=relaxed/simple;
	bh=9iWiLeHeXnIJI/lcv7EGA9Q9oUsxmKM0h3HsxY6J+1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dmQFgN2N+yWJiUkf0yMWOQO6dn0PKVV3rCQcra0ieGpMkg3q8rKl+KWPu2iH2CStlH8i5BWKSSVl03wNPqptJw+TxUX8O5QU3jYYzTuwsqYeAsyO68uluSR6JxL9Htob60VfLyvrsJSO0kDfWM5b3CAy1WMfDS6HmytNuAIa+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAzfggcU; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAzfggcU"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9178b9b7ecfso1524786d6.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961110; x=1791565910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=78WQxbjUnQrJhyVO1dcpGQV/qKspNnaK49GmbKiN3lI=;
        b=FAzfggcU7g7AfSkWfoLc5t8GEJpg83LmuvdDC1OhWF4rQRwhbuKRIVzLmylO6QunxU
         +0uK2aRUAseC0Fr0hCHlM905ZFyA/8AZK/RwqdRqtO0ICUp1YwbPEgaVpFXD7QlgHVzG
         q8bRG4txEDLFrEVxzWRrkH+xS5hYyIWRS4D+moZrshOuhsQWUkZlXlz42uWzCyUfa2Ra
         oeNGpjwJG7QnFQne9GxXRtIlWCvOUrZEIhN+zGORXziQxPGFnkJtp926RtQm284J6PxO
         F89K3rD+EzQKqRwsGQFSpehNlVQS0BPfacKn9QQvuHotsbdKUrtO0wOEw5l2xYcN/M55
         uHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961110; x=1791565910;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78WQxbjUnQrJhyVO1dcpGQV/qKspNnaK49GmbKiN3lI=;
        b=ryOc+ByC2Rmy4AyXQoL3YRJssHDVITl8MZDZvy1X0M+12pwJnfKR6u5p9ihisUGZ7t
         gLC5k3kydLLOhubrg0Fz9lRG04q4KUrA3Ey9RO1mYskTt3kW7yEgPO8EuryXMRYSR+Tq
         iTo9/P2JPalveO9rbc79w6Uq0z7o31pUt0aiVED7lpcrPZFoAGqPeNpUJhsMH4bxeKcy
         b06Sxb8Lf9tZIvDB94j0kQWa3FnPk0Jkn8ntJm93IHJgAMRUHNt9pV1mYGyk2YumfpDu
         f8+dNmChpaOEaIRam97iggSJ4xqtw/DGmd89Pg6RgvChi/GL9ryAJvXYwy3txp4dyfkS
         qrXg==
X-Forwarded-Encrypted: i=1; AKwUvBwLVDmvtjKzM7kzgNDInxrZaZK1W5o0i4FrHUV44pLDbyZG5d8JvfIXTiO5qAZ7T7H1ifA5FzU=@vger.kernel.org
X-Gm-Message-State: AFuF++ni2IBvFcnsBLW4XC+Dl3mXlLhxGiZirElY1f4TeBquUUkZ6PXQ
	lRTTQ+/MP9le8mERgiz2YUCKjVUam3HWfQlDs5oGBkgMY7aDPqaVqg8s
X-Gm-Gg: AYBFou07RfCh+d9z1YT6cYsCx8NTFOaEQVZfKvsATtS6a02+rTNn/QUoB1ciThsBboD
	RhbAQwDOH6KISZW5MCDlVX9m7rzAPfWSn3r80qDHBFP69nrj8Jrimm5+BOSzmL6IDK7RPc53p9B
	03vZR4/H0RlM7zydKEIaJ2LJiH5XPfKS1IZXf9vEIBtNMeD1VK/8Vqai8Y0Xrzgtq9BqVkJnk6N
	PwZluKzoejHZl4+h4Z4RRxLNWyR34K8MOpFF4lFn9E0atcPmYxJ/2ZbENrJVUxx2n/Gd+7Jz/jP
	BapObIQSjGD/ITodbEA4LgaI76sFM5MoA68k+mjpGLd9iRA3gKyI/RCshFqaJSkMjg/CZdok2h2
	I3V9Ngxljhonm5ymFWQ0Go2i0G1UqNYWMIJMxr+wi+zHnd2PQHGNRj4D6cMQ1vSGNuTTMKSM838
	+V61YyGLsAwpImiG3kYQXTYAEbY3TDPpkOFnmZBckk+NpwnvdYozYfQIjRC37R1dAVWq0v6JQ0d
	NBVTUpI2LwXTjCc+aQxQpY7Jg==
X-Received: by 2002:a05:620a:1728:b0:939:8373:b552 with SMTP id af79cd13be357-93ce7a955a2mr596693585a.1.1790961109773;
        Fri, 02 Oct 2026 10:11:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a63d8sm266316885a.12.2026.10.02.10.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 10:11:48 -0700 (PDT)
Message-ID: <6f58df26-16f1-45f4-a5a5-c8e97c936944@gmail.com>
Date: Fri, 2 Oct 2026 10:11:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 7.2 000/457] 7.2.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152346.024115587@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260930152346.024115587@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.9 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.9-rc1.gz
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

