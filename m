Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103014;
	b=ER0jj7Dwoa4AYduV9/gSPlYZQttznyp3/dF2pXipt3M9NYnNRa0LMe7FfJDbErrJZMTD
	 V7wL6xfXdpURkIlWp9SMKZ1E0wVV7pLFZwexoOZDruKIYZO5NTaLCpEjO7ZpyYCBVRxQN
	 lFqMPrwFz++H/TBZm7PBy0Xin7H0dYUrYwMrxr21FtKW2wajLI/gl1LRiHlaw50yy7Fzy
	 kWIpE2/w0b/ExnuWuw51jGlb/HN1G+fSIhM1jmP/LLmdCS26y3F9+92yRv3ZkeiNAcdWX
	 jG9c39djTwjfke69/4IAmySOU21eF9DAodpR2WtAlJMKivhe5PXgsXBySuW7IS4gAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=77kGzCaY5Zn+zy17jl8aBPxR11Z8jaWMp533IDrucQU=;
	b=GTjbUTPYo1v7PycZw+CZJgZSA8ZaYOmyy0H3T3AlIAYpm+qRHv3+BlTyDFfYNb5I/cMy
	 omsZi4lq2weBaVo6X8P66P+JOezCJfHH/nosTr+bM2iHFoGCgpnC9cImwLX/vnu7OJCxV
	 NO4lZIskjYS1luAixgVWlgCMZ0sIIqPwHRZZuQfl1TDLLDRNMQ90lor3oMPUPTNxiuwCV
	 Ik9MCi+dQPTVB9GZA1UlXdfEQ+g+d6P/HlhJIgtJ1UGf1YXY4AbQIdiKvbXIb+/OEjW54
	 RKqd0n1Yuc7WJeSAHoSY6dH5OUElnSP7aWeZl3/28HIowY8taKgO4wttM+RfGIn19Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Wm58OX0F;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FB606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3FB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Wm58OX0F
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862d919fb1cso1381001a34.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795103013; x=1795707813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77kGzCaY5Zn+zy17jl8aBPxR11Z8jaWMp533IDrucQU=;
        b=Wm58OX0FTqOz+qih5WuCaouA4q9BOUKC3i+nIQiu/2UubvQzx2Ax9TLng05RB3h7NM
         42RVCzPsKkdew5a86Ap9h2t/XDGrBdErrd4sc7JHYxCQhU8DxICP2dh65ELGt96Sn3gu
         jLh3zmEx7nPXXmZIvd03rLkT0P6dNDb/+/hRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103013; x=1795707813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77kGzCaY5Zn+zy17jl8aBPxR11Z8jaWMp533IDrucQU=;
        b=zZTKrwU9RAO+XIBHKeRTyN17xp7bLnAdmmnIGeNMd8uNt17to1SGTWCweSQZW1cN6u
         bmK2pcihNWsX9NVzrdCfBh3jjfcd36sBr4bRpxGGApciI2TKqHBcnxihL2LFpQ3X95gM
         BtZZ8xHn28nD0JOpfkXnA2HXrnY8FRa0ZWx4HHr9pudSNLNfBFnvElxUNNO3MEan9+Ck
         /0miQs4Fw0RNZxm7XLvSt0YR5Zv5wzt2HcJyw9VWhvTc91eNZjEwf4yP9gwrQjbTDuii
         YvdGPCi57hx99jHI5lu25rNk1oPOF+cB9HkSCnfkLf28fDU/yvaqiJnz2nXCQb2a5DAY
         Bcng==
X-Forwarded-Encrypted: i=1; AL+hErHrbaujBQBhAoDSlTokP35RldP9Ik8CMSi4fybQ1hlq5Opc36KitIPbKGCaW44ciZOGVIp5lxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ank19CHUBuC+LN9jfliMhB2WsbDl8EShBb6Fw2Xp2Bjbhdp//
	nTwAyMrzOWnhHbpKC5K60eGQ5yOr8i8NWQ0fKYqJNA6oFcPVUgRYhhc7Ajp3dbPiAoU=
X-Gm-Gg: AYBFou3GOPo9sEjxthaKm0FG+s/flPpY/Vth6xXU/Q2iCoI+JJqqZV9YhI8N/trekaW
	JkLPefV8aw2ykob3b9mafifoKH6aq+Uh8aTh+o3egUDvOmVoMZxvh8vYnk1Rg+BQU0Fu8V/KUzM
	hzEJAffgcrmpC55Kn25TVDzLxE3z43stsfm8VxPAWYNH7DzIn7fa/3d7ZLWdB5LSATybQmZ/Jwt
	4fEZdKHhppbVWmq6qFVMdf4XN77mp0mMVUFDHjj4FfJbSJgJ5UT+Tw2+B32u1t6k67C4Ex8+T2B
	Ybs6rTIz/biiBLMAS08ChFlYX9/uUP6s5YZLuuWSDJmaHnJ+iPLKt92HyDzagO+fYee4jwbIYhv
	chCyxgOya5oJRYV9gVGGVHjUxIo00zUOx8AN77LBFWAAtWoVot1Hng8eM/dkxZ2SgVX8U7cqtbm
	4O/RI+jDd9VZ/Uw5NdvG+xorpwk1oKi5wBfrOJAma5Bre4DOByxh1iF7nI5ftvHlr27I97KK6dr
	2C4Q1eG/Ml7537Mj0qMFDXexhZvAbgYwm1XfccB7pIIy6HH+0n0IJWn6ekSZKh2kkLLwz7BBZ3a
	W64gfOH3US6pea9OAtHMr5GB/yQmWmlm2wfmIMU=
X-Received: by 2002:a05:6830:680f:b0:862:c9e8:5776 with SMTP id 46e09a7af769-8631549ef6dmr320170a34.9.1795103012660;
        Thu, 19 Nov 2026 07:43:32 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d4737sm4557635a34.7.2026.11.19.07.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:43:32 -0800 (PST)
Message-ID: <4b1b2d2a-90f0-4384-8d91-cf843f9459c6@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:43:29 -0700
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
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150121.603863898@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
