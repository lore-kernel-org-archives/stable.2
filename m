Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85532EC54A
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992851; cv=none; b=aj/NDq93rEKU+zMdl0SrYnS4c1S58Kt/ZaLSj1sK3sL5pKFxbK4+ZXARuZRADSmkD90yfyhvXSY8Mn/v6OtDL+zXmE5d6Bhk41ubC9fjUG6i5cNEirnmPq2VbCDrVvWP89BqH2fIUb3QIH3yxUL8mXX3dEpopj5zzwQ+pgu/wjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992851; c=relaxed/simple;
	bh=L0Nr1deRYZWpi8xXHW3KEPTuBWUM3hQ+5z9+zteFQH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmeEHYukwczUgNhfOGlXFyYQVCpfNz/Z6vYnmL8DsiTeWb6pshVB/rLGanaMzejpPoZJwMPgJO+Tuf/xr81OaWuFCNHl2Xhjk78eRAew+zTt1EodhGrKiIPgwb5aUQq/sHPHlolf4jKWS09XLWmqqUJ3aeMr61/bCvDgpeHOu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPHhlcRP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPHhlcRP"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0006ea8eso26683661cf.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786992848; x=1787597648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9ShVqtKyC4K+v2kyZVTQgSatBC2/+xjxc8q3bLKXFI=;
        b=nPHhlcRPnVwpYun5e4P8kE2WfrpDYpH1RLN6FMB1swWl1VgchsAGZ8/kK6Kyvrvxqb
         4VaTs96+5d7TRZDW+ojm4KsrnAqvQAmLZuwZh4/gx95z2E0QVVvbfgdFjNIYiumZaan3
         A08Qa7ytvPdPu9ZUa++qVqvW4O+zzQums0III32O1U0RoUZ8zTqhiJOynN1OFgz8RBQS
         DYBmXo7hTb2edozLd70QEKLQ5L9t1wnCm09Rh5nm5jX3xJfMEAXJGNR3ZdrjUVmf7usy
         wexfVpdITPUfm32nUZBkl8tXLTZFiVIxGxLmlS/iw2lP+wFw6xsuFdjm9/KQenvrpqlh
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786992848; x=1787597648;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9ShVqtKyC4K+v2kyZVTQgSatBC2/+xjxc8q3bLKXFI=;
        b=O2Zvl06Hky5ur/wF/nX7BueAZYrtH28/okfaD6QYEInlAOSFk9PhSVw27/BKgj4wsZ
         on3pF42dObEhA8SCxdHoN5pcUwqafjc8EDlrgo1Lq4n8mE0s2RgNk47tWGJcQDrOgR7C
         C+dk9UGORO00AtbkRZknxDd4NxtMJ1okQairN5M6iZW82OITSjrkAZgsU5Wg6PLEVcxB
         txKXomelgL1wqfRio9LrR+6HQAUDgkvaLBn/oLVhdCbytawGoo6oYJ+5blnzdK4Q1deF
         U38yLj7nz/67pOam8+Smmd2mjimdFtZETsUlbNY9EPpPJAlzMnyQGzNXWE7CRX9OVxJs
         mlWw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6lCrETWzRYqDeheqv2lmTWCYzmjkSqR9AqerolJU3svWZBfIf+1CaEjSmaR7i8tDDX/8JjBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIFxPjApa302WGabIJBzv6Yj/w/d8J50Y3GvizGlRoCehpPo3
	q6B5zsDfuZnNd2o8AnrLljTdmlTY0ofjRoY4pf+gGWiPrdxofbeD9fvE
X-Gm-Gg: AR+sD10JXYtbOGxhf88gMKA1R42sHEIHv21p/xZHyKPx5QZhk17PvUU+tMctNyA2+JB
	XDGOmycNAK8hy6A6qTfs+Cm7hLR0ohl8VivLW97riXom+6ERMR8TwkaRPswlaaFEc4C+R4kP7m8
	b5PVfqhSMaZFw0MRzurz5VaBr5KBU5LYoLoGuOvy4sxJvTqMyWrMJKP+swDO5JkE92JytiML7sI
	2NLEv+XFXhN7Xoj2DRBrQmKU+uyuj8Kg0IpoT45n5l70EjGbRURDRs3VRql50KV0BKIeyNpst97
	HjRn0a/tjIJldmgXpSkV+/1CcPYh0D4mTiV3f9IU07WQrMzUYlQ6ii9bV6za79RkmlTtOTT+U5N
	hGQ76VrtinwJ59AZjd17tKaZHTAguSVa0paWBRmJK53iI8SB8IxVKI2NktZb2N+CoXBjZhEdEG0
	L8eEvA9YA6zO2vxZ/zmgQ1RLmaL6r8uOxqCMPFCL4wS5LV1dUyWdHpyBvjNR9aWD1nVIHG5H/wp
	27b5Rtcwhmjz+M=
X-Received: by 2002:a05:622a:c9:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52d8542c8c3mr287850681cf.21.1786992848515;
        Mon, 17 Aug 2026 11:54:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db6216c51sm20553811cf.14.2026.08.17.11.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 11:54:07 -0700 (PDT)
Message-ID: <13de6032-0c51-440e-9b09-fc999b753880@gmail.com>
Date: Mon, 17 Aug 2026 11:54:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/389] 5.10.265-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132538.796021292@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132538.796021292@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.265 release.
> There are 389 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.265-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
