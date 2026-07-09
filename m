Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE73EF643
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589767; cv=none; b=bTJN8bBKyuuMKGlyQ8DwZGlXX8qqxNiR2IEya3L252wuZwGGBBJozuSebJnrAsJV6c3hGe3OP8CclyIWxuM+364h4VeLnTcbTvWuof6Df5URHOjeSaOy9JaCnejtdviFsMvrmDhmsGgX+zwx6clzD4YEK6Ur36Ed4ncDbE0C6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589767; c=relaxed/simple;
	bh=dwacK58PZYD/fisEELQvD1XNGY/AUHVcRTeEXysE7x4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+PfngMnBALApqh+6R+0xFgto/gpLTwSwvGQVEzalOlyuwVRynEEamXBEhp+wvpGWqu1Eb5ba/ZAFAKzEtMQf6XP26Bik8+AK3enpYAoiokK0aC1aa7PUUGyIx6J9zn3POcnLFoTeyj+UlYcbtcBDQQyevBKPUX4Qm6dEYRB3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhVa7mxM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhVa7mxM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47d70879764so1144713f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783589764; x=1784194564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GvQrm5Ns49lCPx3T22+ey6qMomLJzKoL27egFokIkhY=;
        b=YhVa7mxMlmUJVYRO87a8r+q2cIkPAHW5k9AQRPLy0HMuoUDdzIWQy5KPOrImJbDhsM
         mtO8ddVMN9MlakHcVIBN6P4eS0Ru/l/lywKp+cJH0VWlAv72+EiP6eAY5xNspw/EGQbi
         IQHkM2iWmiNjoSEMpT//Y/HS05ZBamd854l+0iSU8j2MD5mW2daByB/+FxIZccBaup0c
         fReeWXmwfpsCaj6Yw9VO43jqU9PF2L5unba6p6FA5nY/Sn1ONsQpo7zOzYEtnoLwP7TU
         U9nyOmvtKCxfRMppKzhiAE+wbRm2lJnqDMXjKh+FioJV8D0FOttkeyP+rEh0cPEXDU5q
         2Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589764; x=1784194564;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvQrm5Ns49lCPx3T22+ey6qMomLJzKoL27egFokIkhY=;
        b=Pv82uyqLFWqwqTPknjLdkVDiZfqktI6C5RMR2QQRh8NySLQFdJ1VdsGaLg4UJqEZdj
         3C/4dGFbntY7SFTKCO80/P0yyOfQp3WbGO2ErYw3cqnfFlXQS4GBTo/dJMcXbG1kpgWu
         2MmhDxNFHdrLi6Z/ODKdy4fEyTOK4TGAokIQifhJnaqBixRTRCOqW2SaRhV4n2h0dQxI
         KBEDhUomdnglVkrQuNbPt+oOjAPTlX2h+zXW2PwdOGGXjN6IeU7ZjaK0s0+AFa+/FCE9
         wl3X6d/LRDc5x3/o+5HUrAqllp95E6P2y5KTquvWE8edDkFEtjM4nUc0mfZ74ksUgogK
         ThnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPhld1JFeG5kQZZylpIxEkX9XpFC/drz2Q6rYMmNU57sW4fkN8vMo4S4gETkDCbMjZV2Hhg0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0OnKvB+jElFDTftybNu1Y4EIY2HySfCVbinjc4ANlHBuhBuh
	15xvYAJO+uNZT+N4GPHD3z7Lmt8tjpPpuH/p3frXPIVUFXeBk2xQxyyi
X-Gm-Gg: AfdE7cm627VE9ck3dzvah/EBD5vJKj6aSAaaYDHyxbmL43nBx53Ty1Pw/6FmXj0MfTL
	Com9+bKC8bCvfEh8Rw2ib43fKXokD/JijwPTz3Eiv4Nj2N0CRCugV8UZWs/CuijODyQZBj30n7w
	OkKA7e6wWlGb3HeZRjoQrlE12iahsGhtWti7XzCjklksUzu9g419xYMfNi+4JZOQcQMqr2/bLYB
	+9gbu2sVJ67dAmp+0zA/QZz1IPg3LTJ3EDO3Kmz6VttBOrRLg0Djn87+1eucZVRTTpE6J8h4q/+
	nqnM24MfljRND+vtsF3YQjw7Ck5sGzT3DXTPNcVMfauMxfNThWS68dklH1VtTJBGP8QYyptyxmI
	49xZRkD6fMjs0cV2dFV2smMPQv6y704EyjfOL0NT/+RnTbfcjY8VQkIAIbF93FKt6J5HkY4pvJ3
	9k/FH3HcLTneMSAR4IsT8G8u2lVeyL8xWS+WyJWr+J4VeUUW/4DgJmTGVkixOsPylU/zNcNLf/
X-Received: by 2002:a5d:6f0d:0:b0:475:3a97:8e47 with SMTP id ffacd0b85a97d-47df07f5453mr7632216f8f.29.1783589763769;
        Thu, 09 Jul 2026 02:36:03 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm51655410f8f.21.2026.07.09.02.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:36:01 -0700 (PDT)
Message-ID: <a8f8eac0-2332-4f8d-8b4a-c13570fa5a0e@gmail.com>
Date: Thu, 9 Jul 2026 11:35:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/129] 6.1.177-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260702155112.163984240@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2026 6:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.177 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.177-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build fails on MIPS 
with:

arch/mips/kernel/smp.c: In function 'stop_this_cpu':
arch/mips/kernel/smp.c:396:2: error: implicit declaration of function 
'rcutree_report_cpu_dead'; did you mean 'rcutree_prepare_cpu'? 
[-Werror=implicit-function-declaration]
   rcutree_report_cpu_dead();
   ^~~~~~~~~~~~~~~~~~~~~~~
   rcutree_prepare_cpu


Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

