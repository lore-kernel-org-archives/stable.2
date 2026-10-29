Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293007;
	b=2Y1hkwkyWjlQHYoRZXsGl0Sja3PGw5wbxkhgjSKuANQVXgAP08XyyAOb1d+QE6N31wYQ
	 6D1qHdGW9PNLVMqgKqwBZk4cIgF51sQTnf6zBqMifHn6HpwHNhyH66FbnpGAOaRTXPGzt
	 Lb5rrL/GWpFilGyU0QlyLmig8jqCppqJHu5likxl/wqWiyBWQGUalJdqkxU3rj823pUZd
	 XMEv0RCqQy7SRMND64Sf4P0yP9NFkvheWU6SfJirmp6XqURgRPwEAAvorkSC8zAHTFOH3
	 JPqvyNFlIWMNxa3Tz8JEGmm0v803PaBEewmcxvftDzfBs0dQveyW+ubn2eyomOsYnLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WWvawn1VUbfsdNDOyAeUMwlpIb5qvBLu/P7NpzoOW3w=;
	b=KOMJCmcU2j+FIkMu0oyXWVBZIaiexuAs6bJwuhDwUgpo64++rvl10GFOtfemWSdNdpaI
	 Luld7MKSDCdw5wX2XArreknqRYUyZ0QmMa4Qnkv2x2VsSW8XnKvc49Ly3ZMJZ6GtSpdpZ
	 KoKykyv4w/8LPdhJwGxdmPw2uRHzkoH7WO6jD6tKn/lCJDwz3G17uQKvbE87dvXqEFDKe
	 4iUtTmSsdlpGj4C9InTnK9/i8LhdSncajIwNOUd0cmCYGRLSMG4QMzbduxdju4ujD1kQS
	 N6ddoJ1fn6c9BMqHSu2wfNMywcfz8B/5VYh++y3gGwFzuxlr/arrQ1b5grs0/bDhLwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2kmdhM2;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B55606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B55606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2kmdhM2
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso15774125ad.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293006; x=1793897806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWvawn1VUbfsdNDOyAeUMwlpIb5qvBLu/P7NpzoOW3w=;
        b=A2kmdhM2exKNnvyAFa2M6blRrTjpiTL5CQR1Bg6lJMTZfYTIhn+APCFDkU55Q14HXO
         xs8Agxc6oD01+dFPI2ZbWfXL356FzDVJDA+bCR0X/EXIFEmFchaCPSoOtq4WRRvlFt5f
         QARHIyjpAx+mqYGToD/TtwgAukt+OEi5CxRaYTfhSttLwsB76eYyxGQiAL/5Fb3mRzga
         fIJAk4FXQ1VCHLP2x6bejZipvWurroHiEUxWCFbsNxdy9kppOSPKgBGovXwAGMUYfKhk
         DAMjJPhEUCn9d/gvputZnNFIf9UGMkMtxUu18x+DfTf2ehm+ZJdGEn9Y8uXS+/R3zVRO
         olCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293006; x=1793897806;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWvawn1VUbfsdNDOyAeUMwlpIb5qvBLu/P7NpzoOW3w=;
        b=qejOzTpfOe4LwhNnFmk54sov+WPX8w2Ye9J/n8a+ZXAeof4ZKMjtWdkSjE8pDq2VIV
         GHeX+XSpo08+DFWxJQTtg02RCC9nu/EKAmX8l2HoRrY1TLr2XMAhMrahirMvxtAIt/Lt
         nY9g1Z0DAXwApyE/HJ4RQvd7Q3KMwYwynQCTeiH7c+Gzpm2qsVfs6ZXmHCq6hRd3i44s
         RmCka5d00h3Ihb7ZrvWqOiHGKxOZ1sQRAyZ/FSWpemfteW2dY+TBrDECYddmjx7a9GnE
         G5IMAwscnYnCAFo+nGUtoomWvFrEj+RrWSUGw2OU3DVERP8rK5Utqcc6aIunKun8t27V
         He7g==
X-Forwarded-Encrypted: i=1; AKwUvBx9lGXbYqiyJCKNCzKwKAGojudttw8dVxWn7JL4gR+MWld+Pw432WhA4y6cnfXURt2gQyQ6v+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKY8eregsepoKZxjvJ7F+vGhQ7NThpRS2GdkwRoE+UzXjVX8CN
	ftDbiQdpVEAjYTgbu02qbjW9feajdbVOmwXVZ9P3om3VHwC+p8z+TJtk
X-Gm-Gg: AYBFou1r32u9m0aoyTB8Z+FJi30kliccR17u1ihsgnlTm1nghnK/gSzC8oW6Wl10ZsV
	VcD5J7I1gu9ds05FmQEoGDOWfHp1K4kfDx2WHYu+5sPDzYSrMPtY74jRMlWDCM55Yi2xy4YUbwH
	FaqXH6tnDaWzRMdX28An1kGMmyWqfQ0MDJZTHcd3MpufdKnc8usIS2nDwT61Zppr2/ppF0mNPO9
	Eq4xGC5gpNAD/kCjAZJnqavmsHWk6KMoExPWCix5OS6SBHaDZvx9NJLgxhmrCaO4b6z2ixwMD9t
	ELEAgz1+FUkdFwM59TYDrGItzvL3Wy4353dssPmBv/j1HKhHMuhN/zxu05xpyEXLP5fTgcRZwKb
	51CpFAnTUBrq3XqqVrxtUynDItL8pNgnVk50/FkMhOKfVN8arydo0DCxryeNR0eOCUMQhvNh2Oq
	LK6F183SvXGq36bSTKAwzX5KZmx64QOiPqYrex+DZtG9vRUb83mp6HCiVbejAiaJ93lJkXWwXU8
	JScuzWgduhw3s64zQdRbF7iG+uzA/eCnGc5vAWYaYWr6t94lf8K5M4ttwAQNV08UCCsedQEWce8
	Qv0BDCn4bnSbLCrT6s3oUKeOSSP6pfPxMYHMTfiF3voX2/pH5rgyJBeHIqzfirs+N5cJZ/x3uDB
	ztQ==
X-Received: by 2002:a17:902:f54a:b0:2ea:9c9f:b24c with SMTP id d9443c01a7336-2eb0036c512mr50551235ad.23.1793293006075;
        Thu, 29 Oct 2026 09:56:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3630293esm91935ad.29.2026.10.29.09.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:56:45 -0700 (PDT)
Message-ID: <ed8f6758-7fa4-4d6c-918d-160bd97f86b3@gmail.com>
Date: Thu, 29 Oct 2026 09:56:39 -0700
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
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028165942.107695352@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.14-rc1.gz
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
