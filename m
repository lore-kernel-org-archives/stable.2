Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB64848B5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661980; cv=none; b=oqS5XJEPiBR3E6E1H6KWO8njn6YO3UOFDwasQtqTTcUmRr1q9MDUm9kg4ucMGiX5rBZciyPStf0pLHvJaMRYdOzkzcAP/2/LPG/NJjwY4KJQkFhsCJzr98UOx94k6a3Dz8Jb9k3juwuHXM4ax43zBaWZQNZTys17khA+ZEn9ITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661980; c=relaxed/simple;
	bh=sBK9rAYvIWibzdWVpiEd2/Z/LGtFEqTtl0liEEnA1+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnC6qmBMqH7AnikSglwfCWkpH/GxE94skv907VAhcTiWZjH+lMlm3HGVAY9Ujd5M9lvR0pPwAglhmnBzNZMlhQjwsDeax5UuxsgcrfcGgHMnPhbnZvcBHfTn+dOqezFsQZp8yRWUDBMBoRZI5Ua715+ny/I0IYH/UyJ6umc+F48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwplOKYo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwplOKYo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so12330695ad.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661978; x=1790266778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3Q3dw1h6lNTZbcjfSRox23JL1XpMzI4Vd4A66LaGv8=;
        b=HwplOKYoxJhe1KJJOEsXC6M43wJ8UnI0iw1dx8vf75gpBB4QaUiRK4cTBYCdosYS9C
         0Asu+buG4fmTdYjbKsrKDN0S6Fm8uYxw4rOZc7AsiCGnzBhUv/lNjXV1fgkjAiGPWzWT
         EgPEx1hFo5WbXYhMCoff2G1cANi620pr0Uv2aZt+Oq9pw/LkwGddbk5gTriCjwOY3sLX
         LcpYYvxKMo4z4cxQvRK7JE5Nxhga6TP+gkfk0Fqt9Eozca+ibPwdwLuAU9dppKr7eUmf
         NiIfzDOkLgIPzbz8A97FmQTnsI60xbVsFlhMSY/rlamoNHXVW7cJAFeZRWozfCBecFoa
         NqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661978; x=1790266778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3Q3dw1h6lNTZbcjfSRox23JL1XpMzI4Vd4A66LaGv8=;
        b=TFiHT3GPBUf8QXocapG+XS8nhqMxsO2ZQNoDyluDlHJS/hMsewhFcHAaHausRUmw0W
         zgIbD/EoQVUWMhapVPs0Pm++Fiut3SO6Fda0z1/gM/4bDEx0xbM6dmokE+y53j/VpNAn
         YgzLQhx3m7ROYjHqN9SbaHqnDai6y5di43G9f1hniu9asWgIW01iFQkj2MxbXdQqHwjX
         vdqC8O9qbIjyHvWBI+Xz2ntnsawh37U90B5/A1Hm5PxEmartb03zEEjch8Qrfkyptz58
         FvlqnirOpcD+1a9x3blxcPZpeOkAj6jCm8Ci1GWmL0RRwDyaN5dSGgWklrGGOM0x8Uup
         06jQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/Wx4y8wqwKLekd9EcC7AKjfOdghuFd8ruA2mpde5bKd7UVcb1tTV/JRxEDBBRs+fRqWpZMgc=@vger.kernel.org
X-Gm-Message-State: AFuF++nOW4tMicXebMMKbIL5Y3V4hv7sE8OeTlMKvXXLGelr8JCzQVQ4
	/o0EIIyV1jlxv/CihbDjSBsX39c1tO44SbC+HNJ0DkVcDwFVBn4XF37G
X-Gm-Gg: AYBFou3SbW3Zk8Rn2V5ZnoP9fEDb37+fvtTwPsYjrVm9BAm3rpyi29tjLaHOaYcKdtX
	P3ofJW5CxRdkB2um2yzPvDik4OKe4gVobrWiwCPY4VjcJi8Y67VxTtXGE/klgMo9PEgy7iGJNPN
	f9nTirUBSHnvowGDNKU+Mb038UFJBe4YS9ggq7yrs7OX/W/xHlv9b8nTG+dr/TjUJylkbSgsrWM
	jy8CgoOqbalzDlmiJW0buGzM2gm1MwQa79/HEKngEBuj2MWvN8OHday1L2S5+SLMGezdaF/luCP
	O7YgWBfNxe6XFj/RgJd6s4/CuRVCxQjVZ1yZfWo1gYp9zUU6zsbUcp9lFRj+b2yN+epMrt5TEUg
	Tm9p/xffhdOHsGBEm4eTn++RZq1iM4TLRnMCBxr8HDQric9+7RIfcjZc5CgEGPVZcnzHw7nSim/
	Pt8sEL3Yg168PyJ1ier0ipLk9EqClxG8fVZ3pyNmgbzifOeM3lQhPwI3dYDp3eYWHDR3Uy8yBxJ
	W1KC3eQ2MTtdP74Cbh/VR37bQ==
X-Received: by 2002:a17:903:32cb:b0:2dd:ad74:ac80 with SMTP id d9443c01a7336-2ddad74adcbmr14361355ad.27.1789661977897;
        Thu, 17 Sep 2026 09:19:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89c3316dsm29772185ad.0.2026.09.17.09.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:19:36 -0700 (PDT)
Message-ID: <6edcfdb5-f73b-474c-96c2-96913ca5ed25@gmail.com>
Date: Thu, 17 Sep 2026 09:19:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 000/733] 7.2.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260917151350.597953846@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260917151350.597953846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 08:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.7 release.
> There are 733 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Sep 2026 15:12:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.7-rc1.gz
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
