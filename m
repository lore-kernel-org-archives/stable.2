Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA85437856
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221419; cv=none; b=YgBVTELMbsFC+gW7nQ/pkIZPyzYeXMLvLTFpmI8/27d9iwOMPor62DxOFtCpTuURARx0OxiP9jtjU6O4repw4xjd8uWH/IIMwXtK6hZZmMaXUMuEB9gIazVvocVizizPY2ajKKRSmqcDO1AkDRrY6VUGDjQpk1u65uqmH8SFgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221419; c=relaxed/simple;
	bh=EIqvPqeCjm5Dc9Jmv5QrM5AqpBkwUJmjdkmGX6+T5qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piYc5ch78VIB359lGffNkfBA6E0pbj3AHUEGeqCN5GopB/nQpax5MkuaywY1zRbdPv9O8+Rv1skn1AA5R2Pkawy6WklysHPDe4c+AioHNgzNKjdszUrKUHcW/2wIuaM3pJaGZHT4vhfWQy+w6xK/e59KuA2hMnDLC1gwOwRr3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq8e1K6j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq8e1K6j"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso76722885ad.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784221414; x=1784826214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKtPinLhhVEt3RyIPNlUBx5bJFVV9VU0HPG4/JBg7mQ=;
        b=Tq8e1K6jwDOwheo2CX7TXvVdEJfcDGhDvLWH94TgHH5igv4RFhrzjygGEGYU6x1x6w
         J0Q7pUjWWU+M228E/7guNSqmWZ7QX4D/llKkDcOLRXM63GGJ06yU7I1LYurL7CnFBB77
         kvO42DA2xd+/fMG6tTZ+/Xu8Js98WiheJfZtR0Jzj1hOBex+6g1VUJCXhyDT4BizA5us
         B/u7eb4PwmrwAY0LN71nH6T837J7K8pjcNuBcuz/SOVDha8dx06oriMJMSVmSLAM1OpG
         XfBl/X/AtcAArSsv2pjvvazirQB+tnh1oVBy+txkngHOPkiWLg3Vd39NcrMoL9ZJKG/9
         qFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221414; x=1784826214;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKtPinLhhVEt3RyIPNlUBx5bJFVV9VU0HPG4/JBg7mQ=;
        b=U8mqefCv8rTKaCpGR95iGFdwMAjPMIbIlSr6RPHgtLh7JNU0lFNIu6UI8Pz3/Chg2R
         raCxN27l9aVTeiinvGwhpQCLlcOz9V7OM3EQeHOYo0L9PC93q9a3AOz9+2s/Aem9ampe
         mqSMOI0I6ut5juIzSocmHHDU00sxwj0uOP008fz0BT3kmkA6JIzpyrzDeyh8R2qgU2S8
         lO9Al5+gD6D2wv6SZOzR9j/GcdTJtQLEvX6Ap4pQXcDp98cxda0Y90XGwEJ5EVoOwC86
         gBYn8XNg5rAoiCv2Nwy6VSEtkyH2b79lFocFekgCIeHdzfNzX3j5nv7RNGitQgoiubBi
         ZTqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCDT5EnMWKhwezZv9IW4opxHtQ6nErJmSUzRruwFy8vWSYS0Mmxm/mDLiPPoJwMrBYXpC7/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxb1+XhIqcSeH2BOaZuaHzMTEUAXZQHOnBvLaj74ezjXMaa4RO
	xWaSYh0uIn4RQfpuOLFn2+7/xOIgg2pvYSmnJNDWTUzAk76rw8jNM+/h
X-Gm-Gg: AfdE7clY+MehmkWpSA2myOP7csdySTM2vVPOTW3LpGzxdLq5AdJD/OoBKm+cAsfxU9n
	rvd5DFhjyGkOkxbyopVAhQN/8G/fZyPolXA3h0Hy7P3+S39L0RcgwJ3Ja/+QjEKzYu7uK7KcPrF
	j8Ds5cQPBSugeKoUrRIoz/C1z3egEWWeBCSuvQasTundSb7lMG/+fhugRx1pzjJj0pXzZI8mCna
	yNfagrrebed+Ha49yhXni4ECrpvKePkVP9vntdJmJZ9OhaG3cJpiHxnG6JDMuPHqm2qd541m47e
	tVxYAshs1+R/oY2fHbKK51XXlQuE3AZuFQhkL3Nw+dE24nI5UyCT12tdiircxeIFKW/YIQGj0GX
	BMfhtHYtTzRfKRSXPpXGiqoT7eEcI2uDaWujJYugITqCF4v0wTxLQgunlY3cTkUC2PgeDYlOgxG
	5ARkH18A2g5eejy0QrQHr4OYBmZZSKPg1rUqByDJA=
X-Received: by 2002:a17:903:1a2d:b0:2cc:5f48:5764 with SMTP id d9443c01a7336-2cee9bacb60mr142293835ad.44.1784221414399;
        Thu, 16 Jul 2026 10:03:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1012c343sm23542985ad.25.2026.07.16.10.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 10:03:33 -0700 (PDT)
Message-ID: <c577fafd-c2ff-400e-962a-f9e77de3c434@gmail.com>
Date: Thu, 16 Jul 2026 10:03:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/349] 6.12.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260716133033.287196923@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260716133033.287196923@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.96-rc1.gz
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

There is still a fix needed to get perf to build with older kernel 
headers that I will submit shortly.
-- 
Florian
