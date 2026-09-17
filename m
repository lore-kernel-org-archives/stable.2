Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B194E77F6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664234; cv=none; b=AtXgewjDyzxBOaTAuKUXGWKql5wIGEVo7q34zBspNvmnzTQy8f4OxLfTDejNf1IsrRQtGLLks1RJWg/eUMDZYuf/IBx8FRB/lAgtuyKvjdRFP9zvbRaC9JrDLZkJDtcC/JZEqPzGCkmFy3zG3RBrDmYt/Se8soOzoqDO5os0g1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664234; c=relaxed/simple;
	bh=zydFOkLusCsvZen2mb4Pq9HJvg/Y0I4yNFZXUL0us2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohFfxtWnk7GaUmGi0GDIe9Z2g4gNUMbD4FSvAAW0jHOl+qqVCXd03l9lRoloKjiVbO+E5z9WsrvLYE1ij8BVULlpowDw/nJrMRrWN7Kmp7lrCvFsSc+RE+/lGQnFb71aMcs+34KENllnDWKZZVd/ALR/Oz6xc6BzImObKwNpmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeI8fBzU; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeI8fBzU"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb766bfd6so9251091cf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664232; x=1790269032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nD+nNF4AReTcmzz2bWEK23wh0b/1V/6DLReQB0yfH8=;
        b=QeI8fBzUWYvgw0Nz+sCzeNQpdmafdCJfwGHBb/OWanS3WIEYR3XsNyUsMQlOio+l5W
         piOcmF3DFirdegouY+Rc9T+klOP4YoCTCqyhQlhDVMWZn2TSfHs5The6llY/5FQPoqT/
         c7viRyJYYvO+lCWXyghBeFoWzlRrot6MiN43pg+J9lZe2XDJ1kx5Uejna1GGqttBnikH
         MhC7iKhF9WFVpxh0DLFtMqzJX4SlRJvJY3Q0j5dS+22ca0e1NX1cBDPCuGCqiLczCnT6
         u27qzB0XzSIq9ViQpjUr4L7vzFAxRnhKFwXztG2Z7IP4GtrShWjoc6RnApXLJDgQBG2L
         trsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664232; x=1790269032;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nD+nNF4AReTcmzz2bWEK23wh0b/1V/6DLReQB0yfH8=;
        b=vNIDACnsenIr2nBkW4eZEKNqsYv25yUdLuiDJXh6a0xbaBXFErwGuwYc2EaUZGVLET
         yooeWrwK/oqpP7+mSlFTZoeb+QCNxzJJPd/8Bsp+QwVh1p93q/mkJGw8qZFV/ivJxmBQ
         pt+GO1f8HNGgYU/yHmowddZYMdF/2IZXPzi5RMw8yWyo0yvt7eGZUdkU6riDMeJ68aJC
         sK1FGBdoqwLG+jQT9ClOCOptpXv8hAumxnqcV52AoeO8pbBNJDrjQxcU5VShYA4W9kB8
         4Z1Ay4zYt/dL+KCBoMDuVbn5cF0hISJHpkl3DndL+Rk8RkGfxe4xKO0Wh5awZ6pLcdTp
         r7tw==
X-Forwarded-Encrypted: i=1; AKwUvBzm4LMHsHtpgng0dh3mQP36Ee7mdSZZQzlFI2vU8J8KIJpeyYHxMTStfDYBw/ht/lHAGEJBeNs=@vger.kernel.org
X-Gm-Message-State: AFuF++mI/SEJNQMnGg/j9wHvyuqvLoObr8Y/ZVl7LbjqG367pq4NuYf6
	w9r9qzEbL/dbnezwrtut9KTHDogf5Z24FPMFry3Gip9ET5X7G07oe/9A
X-Gm-Gg: AYBFou3TuLqTTyOg2vBfToHURTKjcGjRcspmQ1tWkx/mnmtWXzLZ631kBVl+t3OfgY2
	CljOlCMeBArY+wF+Vjah/mUrUhOn6/9D1Slxmg7+Xde6c5mETdOqbxpJZYWYWzYPvdxZgHPd3KJ
	QObGvwNHM2yHLaRmgMl16FcRrxnPGENY6m/SskXxtTWu6upIIM4qDz/S2QxH+C3n0sh3I5SB9o0
	Yaoi9wIV/zTKo4TO0yjvedg4Ge4NCvCGtYdB+3fXn/3yLz3muFn+kfQ6LyBgPPX/3oLRCag93WP
	8SdfMojAVTZ8qPq/VsGYxlHUbpNx7Ge35Q6gQKEvx/9NR4PQcoBk8E4ha3tOsUpZ5JZH0ekbXFb
	RKVAMDBl1D9IKbvof/Ku41e9DdCz2JQQgiSzbAmE3O1U5e+5b85WWksmi7IB0lrDchV0HJ7ab3d
	BEO2+ZwSmyUe69h92ey18DZyl1/4rZ48R7BA4/Zl2vBV8Tdojd6NzQu9UoPF63FJhWVZ0BUVtYg
	9Iuyh6RArrd89F/KQLYFThCJA==
X-Received: by 2002:a05:6214:e8a:b0:90e:7c37:230c with SMTP id 6a1803df08f44-9123d701242mr168976896d6.1.1789664231623;
        Thu, 17 Sep 2026 09:57:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cd40d8sm1989826d6.35.2026.09.17.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:57:10 -0700 (PDT)
Message-ID: <d1d113fd-2943-4262-b8e9-b0dac7e373b9@gmail.com>
Date: Thu, 17 Sep 2026 09:57:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1102] 6.12.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260917151539.408551884@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260917151539.408551884@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 07:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.111 release.
> There are 1102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Sep 2026 15:13:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.111-rc1.gz
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
