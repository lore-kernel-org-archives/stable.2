Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A93AE1AD
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001544; cv=none; b=c5k9xx6UWJmbjAG9Zqfhul4c+N9+9OaZy6TfHd1b8rJfkqrLlPjkXKbSG6ekiYCWPaxGCqu+xl/UdBD2aAzH/lzrnCttcCeX0CCjTWm0ZgejNx6B/8C/qNI3ukaBMkrl2dEGOv2uhuqdQ5gb0wGuefgrOcsh6pCgw6xrzp88/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001544; c=relaxed/simple;
	bh=ctSpOgg3OTBlJgkxlyU6B0eTcy3Hbwx8zqDs6L/Yndc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF55KR8aexxdl7SaVgLAtPwOM6gXY+HNzBUz1JXSiIJawZmaziA7zQu45ZlIW4otgxv7XdXPdA8SC5Sr418N6wbF4nz8f8+ut3AxvZcGAbyc1arUSiEld107YgegiFyWMmrX2clF71O2Y8M5axJm9vteXSNfTQ86mmPeMG097lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRm+j9nd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRm+j9nd"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2220408a12.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001543; x=1787606343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoEump451F5wZQU3lSV2OnKWKG1y5qtyIVMVnMIXcNc=;
        b=YRm+j9ndjyytidjnpynKOfOdSMawuHW8sHPciY0TAN1qiDRZm98ysXMTEcSdxlu+cP
         ZkOgjJTF3YVRff7H2D4V9JjGLpC2LKkXTKtv839T/OkEgQk3lchw1B4BAXmzIRj3szO4
         IgWBkQNVgEatV+m2voaDJg2DgzFVrNAAawBy0/27fYyDlGLLq23V6o2Il1RYzo/LXnqN
         cjPMV1uar7K5SrEkm21MfC6C31Eo8cC5avSrZJvKn7ERdKOuNMGa3RC3AbAYV92cZ+ES
         uclCFEKIzG86Pjp+nhZPmETZrIPPpCkmuJpjtf2fsKvBn+SwdbLyRxkaybNtbZ5qW2bW
         qwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001543; x=1787606343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoEump451F5wZQU3lSV2OnKWKG1y5qtyIVMVnMIXcNc=;
        b=kW5jn062/+QaaoxzOqz7o4pKHscTiRcN6GWAkyaLm+E/ATmnUtQexYz21fM3yvab/M
         iaSVcMi6hAMyP5pVhW5s4j26bCCaWpcRM57MnBxzMJbVKwvOu7U4efCYRqFK79VG09UZ
         B98cjFpWqYHFb192Vg5WrIliqYP4lC8m004JIJnh/8M98y+O9ejN/k1n+Jcq20lrdG6B
         1YD/CH1IeiM4t7A1sE/GhDvnr8JL3tZo4rgs14EE2qkARqpNj0sk8m5VXQApgff5UayC
         DGpI8AOHImEMSTTs/3Cf3NqQznD6o0AaywSTp471L2HT9SXowjmti6K2rIJFcSMfvHWp
         NfLg==
X-Forwarded-Encrypted: i=1; AHgh+RpwYBB8f31+Lk9gabWxzNuTjlrgdFB9qHaG8YwFw1a6lmZL5KFoGGCempHCRSe5aDjhoH5I/+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+RKRXvHlFvuFu4BvKFKRD2hlXjft8h/M1ykfbkwKdgBXbORN
	WMY6KBHZ76DLoks4Fk4NfNue4rUsSep8H+5dEGZmZkOd7oybWbsEh2GW
X-Gm-Gg: AR+sD11+jglj+OFFCqs45YFvr2S1n1SrwB7vaLp0c0eFU/tYkx8exo6MEubxtO+oW4m
	oQIQL1T++LxyOcaDInXowhEE79zM8siG12VTO0Mw9UZLylDp9WYs8McjAsCKGy2fHh5q6zPtlGI
	rMTLiSqj9a5KQW1wLUXvuK9gyq29Yq7915qZyXEWtPdK7x9QTFYc9QZSarzGKCSrT0Mz1VLKOrl
	at/dBECboxSNVahT//pslrt9KRhxNZIrhAeMRF2qzhfxjNDQlDodyGzs7ad9tVmWqU3ldv/rLi2
	2lDh4Wwaxrp09ndyNzCUcl4eGbr7E9WUwTJOuylHfwzzD5GDKrqg4TsskuuNFLxayMWsF3u5iJO
	L+rl2h8JQ9RjREQU3rK2BPYNQTveZsV3km9TlBvoefPR0ttjAr3YWBImysSaUlRGTRrIIcXhR+F
	U2dbVRqrJ4rkdkfAXkFiO2A3oK6OGwGl2MCZ2UBgJyRsLyWkRljDuMGc0JhMxpgeMuE6GaPPujV
	yBlc/KK6TmtS5Q3Mw9WK8sM4A==
X-Received: by 2002:a05:6a21:3511:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3cc71a26092mr35765658637.12.1787001542568;
        Mon, 17 Aug 2026 14:19:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dd08d6sm13309702eec.4.2026.08.17.14.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:19:01 -0700 (PDT)
Message-ID: <50925f24-3272-4a6f-b981-ccba54fc9dc3@gmail.com>
Date: Mon, 17 Aug 2026 14:19:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132536.752504388@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.9 release.
> There are 271 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.9-rc1.gz
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
