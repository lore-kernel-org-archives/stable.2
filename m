Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55B36197F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410695; cv=none; b=a6viJBd3nbS9OWom5UwJW8Kfss1xqj2ny4wtQocD/+1OmLxQ3I2ti/YrHQ15UxODCrOfcRuD8pVEiY9rHajZ2nE2PZ3F6IydPIYe40ETt6IzE2BSOLnZ2J0D8rFlrPDs6afWTRX5ayQdzWeCsD/Y1g52VVifQcXYJe/Byf46YVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410695; c=relaxed/simple;
	bh=ZRTmTgpXAIHI5PwDlZl3mxTARuuSCtuzR8f+OYUlUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bvxhx3uab9xey/d9DQP1hXd29Pt2qgRVG50ieL170rLBuhCPjy1qtsctKeDRekMl8c/YsE6amwkADUXznCHZRUJ5wwLoodU2pDU8GVN6hCoAZT420NOFVUPuIKfdTfd8PlOIiSwqV/z/Pq2pf1+F3rT0COhfbuIzbUcLzFYX7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SU2I0dTo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU2I0dTo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93a1118fbb8so207102285a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789410686; x=1790015486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkJteh6h5Gfo3xV7o+rs+ZpT2JdE1CQXCwGXk9wGX2g=;
        b=SU2I0dToLraS7qGXxKg26wnzUo43IzqYMHz8Uz2Jxaiz3WSg9xknFRyZj0pxzYVLPM
         Rb0+dLNwI1q+1W4O8VOyv00jP9r2158K0vKZ2Qfa4da9CRQHRDgTE4b7vi44kXOyLzU4
         hdYjJaPSKCd7mCZmERQQltqBbwRc58chMMhT71YToY/9+zpSkbsoO/T4OmubZHdjsohC
         zsxNWZOZewU+9+OpNxfNA/hbRwdQAM6fZrC9Gvuqj6d/C72uFprtHZOilUJKzi4Ys5QV
         1eLZFBvO4tB0CsJFrZZHq3UiP9p71Bk6KcLFwNoENle/WdEOEM1FfQHXmb3fZGwpJ2KR
         Gxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789410686; x=1790015486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkJteh6h5Gfo3xV7o+rs+ZpT2JdE1CQXCwGXk9wGX2g=;
        b=EIdvz5dxqUII81eCd4FCtfyTDRMFeg+YSOcJ8yXixtdqgByAzoE/7beO8l3jmzUzG1
         xSALuZOb2FO8De4meRqiv8HyHsfpSC5WutkJScMciBafX3/sxdv1jwLtG65EtIt0guV5
         49ZdK5cYc47VgCKzoh8MivKxW9goNMwtdszX3b7zHXsbvSQK4lXO1yJ3oV9KuWotOKje
         AYtIr4RVcjsP4a2kqU1JTQ6T8MSpM/Vh+R0P3DHWTFWoOLy0ohMlqbD8Jdxuer/JTuzd
         s0/cD1+6uVkwzKqWZ5B9WJyVdl1VvMbJ1z+XmK7HCiTVm+33tFvV0LgUziVNIGjvej+v
         1sOA==
X-Forwarded-Encrypted: i=1; AKwUvBwwjoIsw0PmJ7eLz0y1WYf7Y3r5L22kMxp26q6Aa2t8jnKyJIPWPxzyFDJ+WBg1AHzVNgyHhO0=@vger.kernel.org
X-Gm-Message-State: AFuF++mbIw++60HusRXnoSFFbvIn/J+CX8JgqAxiZWnwqpER8DHzcmFK
	e+L1aw4CMI/KHkV0tJ8cr9VmKTHhfdIyePmzOhxoTfBnS2g03gABbOOD
X-Gm-Gg: AYBFou2POae3fNhNmwQHjMAV25SzliLRe9q/OfWuKsu0xYSON6oqj04DwBtkl/WY0m/
	N/YHLec5NGTHGhOKUr1V3/xpgt1b85if5D16uesbwpU8PBLSW7NYaenH/FEmPutm6pfg4vquh9D
	yx8d9cCwVfWCObX8fApIY70TYdPcmSUtVZxSThJ7jufoqM8ZJUuR/EEk3jb7aQlJ9Q+lvhS4p80
	W2q1sIyXYdp4Rr/peUBr06QNDfeNFEsxFX9ztGiz2fCPh1Y9ITAJ4/YQSaUhNBCDLBKC6zzMmqW
	0OapwrjiIKpw7wMIO4/CMQWA90Xm2A01lo0+lQBDHBqE/C8MRRwTlU2Npdek8bsquQoWINVrJMa
	HAp58pEE3CvDiirKa9xGSuKvVTiYClQjv2tw7AhwGmXRukDA7ZB+aXaClvRFwQ+ALsofQGklo08
	AjoYlHRJq8yt3M0LzZV3C3uLjgDNlo7AtqgFUFr3Sk3m5OuAysd5lH2cVXG0RFgfs3sfPqlr6E8
	P1sxPCBWUjZsuOO/5TrCnIOYQ==
X-Received: by 2002:a05:620a:268d:b0:939:993e:bffb with SMTP id af79cd13be357-93a29804240mr566801385a.22.1789410681357;
        Mon, 14 Sep 2026 11:31:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ed67a93dsm960651085a.43.2026.09.14.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:31:20 -0700 (PDT)
Message-ID: <f687d3d9-b4da-4549-a40f-fd9254e7fda0@gmail.com>
Date: Mon, 14 Sep 2026 11:31:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 0000/1815] 7.2.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065648.999753832@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065648.999753832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.6 release.
> There are 1815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with arm/arm64/mips:

ui/browsers/hists.c: In function 'evsel__hists_browse':
ui/browsers/hists.c:3191:41: error: 'hotkey_act' undeclared (first use 
in this function)
  3191 |                                 memset(&hotkey_act, 0, 
sizeof(hotkey_act));
       |                                         ^~~~~~~~~~
ui/browsers/hists.c:3191:41: note: each undeclared identifier is 
reported only once for each function it appears in
   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/trace/beauty/clone.o
make[7]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:95: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/ui/browsers/hists.o] 
Error 1
make[7]: *** Waiting for unfinished jobs....

this is caused by b8ad2bfb11e0868b595b4cd9dfcb9e80f174b2d5 ("perf ui 
hists: In report UI ensure thread is set with reference counting")
-- 
Florian
