Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B4366045
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979459; cv=none; b=ASsR3G/vDqPwmpKYHMrnBjy859/Zav/mD/1t/HzP7Qd4AVKXsVPFo9QgWRB75cu7m55IJb+4Ikf60R1KK4VQjHQy9Ir4kpRq4L0aYe7QVlxLSehbZXgNiB/k8eilX/Ym656jVfmNhuzQimtDqDko8hiNj0oFJowKnmrBhwL55L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979459; c=relaxed/simple;
	bh=GBJlCUhbFJ2h8LJzp7/8I5Sp8G1WbZOYa7N7EatzZPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCY0JR3n7M9d1cUIIPR9kw2d6teUmffNRzq+Mqskzdum4i5DaD6+Owckiq3zXiIhnff4erODQ6NtqIU0qjQebtVpQ+zPArYlifTEKD1zu6XI2nMTKwpWL/50jFKJLzBD9zdtvhBQhJOGJ99fATxISrWMR/u9phNbzJmN7+XBnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCbXy0uZ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCbXy0uZ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1262168a12.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788979457; x=1789584257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xE4MhgXXi1uL0qo0jklt/DxI0WtmnC1JMz4tFPrlno4=;
        b=kCbXy0uZ5KiprFRbcqXyZCO/2NnSNE7m64msXyfyrpNu3tQnS5l0h/nvmEHyVKmkvf
         wKC9kDsD6IxGdJUqdd76e3j8dJml9dpiCf5razU4ybb9nxz72uRUvprMNdfcd1DDh6x4
         i1L3hN5O0yVotTRNw1+yIx9bvv85jZqZI6bAZdnupHk3YYoATezr6mYdzmlYkKxGafON
         Qyy/w9vg+UZQyloSdPuX/dh4UAykvM7yK4Q0V1z7mxW5t2fy0//cMrDettlXvP8go1Uf
         0RxY5aAeHeUtxevoAvJtSgLHkAlb4LOT7yg4Fi6X/qYsOGCM2Qrol92pRNhB1OSwvGzT
         24bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979457; x=1789584257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xE4MhgXXi1uL0qo0jklt/DxI0WtmnC1JMz4tFPrlno4=;
        b=M0G+rkhoLIiDCsfS3nmldg3bEvR+4H8We/JDGflyu0cd8iQjGh2HddvFpy+e3V3e71
         N/7SmXcYGAUN8W0T5Gq9kTRZjN7+XWHNIJwPwcDrKT0OI/wzoRkCgB2aQtQ5m+aRXzu7
         SaYt3ujphOjjTUcZweQQrheax+exFluxNa/ipWLK6rEISn9YpaYJtKhQNM9dTOOP0DSM
         bP9W+Sl7wI+Dz091zfEJGNVk9TKYZrpvO2SaHDb41E7ik8ZkSO+BAfy6s4FHR/ENTy9j
         /9GWCvb2aS+s+dSr9UxBUYO8hujheHBzN6W6KDushDKqxmtb6lcqH52OH6gD0gfY5YPM
         5/aw==
X-Forwarded-Encrypted: i=1; AKwUvBxKmSPVgFWYJR3DYYKD5YP1DjWKzVUzqlcLtHrxGrlBV7c/ZQUfOBwBqoBX2QnrglZvSsm4IWw=@vger.kernel.org
X-Gm-Message-State: AFuF++lqRRd5HuaDzq/wQ08ju699lS+OArlNXDA9vuqNiRwqZXbkjZ3K
	2mbSeWrx2DjGu8IdUKm5fTS9bPpqNnRthGeA0+h1csSvkEyS82eaUTut7wm8Qg==
X-Gm-Gg: AYBFou2kqlV974mFV2uD57QvLlzuR4QJSzGXFKFm5tnVX8KRMtB64+xjRqKlruMks2+
	wRlSnE+C8gEuYEzPKkaAL+pyLXcJLdJQPGfWU3RjeTw3CC9vjo+4sWS7wgVhsT9dmwqeSY5V8vf
	sPLbPcf9qJb8z6JyzJArhVmImU5cF8ANp7j2EUAdRr0lrJnRNDgkiWYDUAcLjicQsZI6k10ruDX
	9cmA7rKZ95XZaIi3P0M6YUS9Xo/4dpJkfACbxwUj0rbdl35RicMV3mwC784P/XgaxX1OjpsXVb2
	ycYApu4k3pxj8GjN8m3KdBc87gXRAM3J7B6aUD1wm7W/IQ0REIIGRWhfTeg7Jv5NhDFId5hMUJs
	eLAGoVKaUPf959FYTCVe1bxIrcOy0ywHk+8A+byEbSC7vI3FTcZnTtY1tCE7QMwWNYIFrf94FFl
	lPprs4tht3bHi76/exY4jDT+Ol0aydS5gmoWyNXRc0fzNfok+N/w40G0OgnoI/pGgZjZ6p/G4ho
	UWHtC+72oPRf/cdbOhnlnmlBg==
X-Received: by 2002:a17:90b:270b:b0:398:c9be:cca8 with SMTP id 98e67ed59e1d1-39bac13b38dmr11758975a91.2.1788979457285;
        Wed, 09 Sep 2026 11:44:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1c16sm7741767eec.13.2026.09.09.11.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 11:44:13 -0700 (PDT)
Message-ID: <99110247-7f33-444e-b37e-eae8e641c45d@gmail.com>
Date: Wed, 9 Sep 2026 11:44:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260909134230.441546314@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 06:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.5-rc1.gz
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
