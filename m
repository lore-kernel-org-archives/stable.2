Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296089;
	b=0CmCFTpbZbTLu7huQ5QGrqiqnS4sDcC3VgEhqBvvlSlmTaW8v4/vI2kyW/T78tJ8aDCM
	 NIh7wmNLWKuVV+uD9YDi0ylBA+ZP8Q+iFhWgxei6qOWON+4J48hwpfQMmSccYkoVVovtb
	 PHmMbneQBoIxOR7sbAXFH4iqvWnvGNdtvUxQto22KEoH3lTAF8LUYopwtZ3PbO9VwkskR
	 FaF1ws5czUVWNNmp7exAmfk+yUVVy+Q+a7+UPa3BPgbz0CfsJLMDJxYflJWyAs3E+/1Sc
	 gfOFV2oBzhaYbsFKGVz7x4FhxKwN0nmHWxJpFlHpn9SVwKQmC2HRQuK4sDiuCzbPMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HaforV2IeP0NmgJIChxLqIjhpAm5azYdHH9oA6zE+e0=;
	b=Tc9Rye3NlFR5v2U6IFVk5biAG1sGU4S3q2gBd3jf/bRbrBHY5RSsc8kXj3YLYWisHqDJ
	 0zGBGIwSarNP5TusWSzA/kr2tlD1BZ0Gb+0NdGx/n89ein6cDFTGavnwv4gduewfjMppX
	 t6VNtT+BkFSKYJQGMkNKLmPTX9SngteSDnsD7S38OzbunU8tar8WTmb8R48OzZGxPgi1w
	 +yaY6ZD738N5YqIpGxhLLM4jVueoGpzmnqd53tGgkWh5KZer5IAK7c5MViqTZBRV+HE5L
	 zMNVM1JhkZMDfDP7xNnIT8aMto+DCgRWtRAm2Aj6j2TZ+0VWH/DPCBnX3kCbMBL3zow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FA2D9tZm;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD5606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CD5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FA2D9tZm
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2b8cf037so188815085a.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296087; x=1793900887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HaforV2IeP0NmgJIChxLqIjhpAm5azYdHH9oA6zE+e0=;
        b=FA2D9tZmCK6oAVbTS8dOfxg/WL+DatLxwaoHj8OrATdWMmlmQhigB5xRcIIjzyyMaa
         zyr6Pt0Zrf/BhlDhIYuF0yOO0k+C43TPJVQ/9hGSbrOug0gVa6g2AOrhS3sNxOzuxyQc
         9+apWGsHRfdr6ZBCp9XwhF8YgmOnOkVHdehzukOrAiBFag6P/fnB3vaOP9E8gCV5MUUQ
         MiTmlcBJwcgmE7i/Uv06bg1tjd+CIavQY79jQwqcJzVG9acy6zaj484ULNOdSj7Xy4EE
         ugL0N7OHhNyQ8ZR1rDmDBC7SXneqdl3wkU/Y7aaPpYQlg0X34EuB8QEyeXx8Z3UFtcQm
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296088; x=1793900888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaforV2IeP0NmgJIChxLqIjhpAm5azYdHH9oA6zE+e0=;
        b=JZgwsmsQlBqe7YZxXKaoKf3WkjjwozTCnXC6TjpZH9d4e5hm/mGCtKSVDAqJxe1R6J
         ekaUPryLzfES3NACRKunOkjhrhOoWc8SJMtxt11JKO/x52347SQoA2NeL+Nq2NCk1WpQ
         dalQckEQV/TmwKPSHSqAiQ6C1Vxe6fGlWeZE6Ba6snkKz3eSu+3F+vYkuDldus1ZnUtu
         r4NvlrPhDuljAaztRHqs1tUfepfufAMXDQtFL4hQzc9Tjkoo+P6Ou4WbmIOfxJxsVQFg
         2pGpiL8PJbYums83G1T3bdxpsHdUGuvdvWdMDgMISVLZGJB4pEFOfktqwcuhYOGxGFlh
         MNtg==
X-Forwarded-Encrypted: i=1; AKwUvBy3AfAEs2XYmKGTPURfKenKFww0FbVqRxs5RSPg4C9mlycO+oMvtZ+Nrq32dNwFP20PYjX5hUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHVaaaitNlefnjYeDgrtBuZBFHQxbEoACaEvHDIu3ZpJauuH6m
	C7UM1vQXYNhMQntftRg27GGRcrR3cXZM0aR36q1C4Ztip2jEqKVnD7eu
X-Gm-Gg: AYBFou23ijo6rnGvktF2v7mFbBn32PGcZakHntmIj8+1ZYqcIm8RwdF6T0X9VnpB95w
	+EpaebJz2Ny3eUKSyssDlP8rmYKN/N+NWKkm4UAcqjqApERryrAoPGMq0FiBYYBzPfjV5me41Gi
	hr2tukJaXleAjsYkxwMIhCH4Pa281nLawDn35sYd8HCqkvekbaM9sR8ur1ahJB/SmNzpFAvocjP
	RTSZ+n24TWL9UMYRx/70TYdnI+xpjZM/Juixa8Mvw4ZJ6+9B6/7O8gnICxuEbL/8tZvNWu/dPy0
	jVAB4AaIkD5yF7tfi6BeBl2eFDBRHWExdeBP1X1Xmz3Ph1ZSTfRVqWF0zG2zjV/hpmKSI2jxg6A
	WXsxyKB5uIwLbnFsEyq63SGT37GMpegBr2qBM6rO0aW2ZVC25WGdh9xHsJHod/J9sOyF8YxZH8t
	iS6+OhCzomt6Ho8Are98QrIF80UIhuhgyEMPZ63WwR/pLJVr0VGN5mW/j32blRZrn/cOdKlzVxi
	HcyssiUeQarFgF0OghcnzEtTuk9kXbsKf4IX2wZVNux75j8In/r/OIBtk4/PhBPtjs4rWPA64xR
	3a2QKV/Y1Kwx8f5Ws+i8Xq3ucMMCUdKab6fytfJ9Mg==
X-Received: by 2002:a05:620a:44c2:b0:93b:e578:583d with SMTP id af79cd13be357-94408aa1416mr958437485a.21.1793296087475;
        Thu, 29 Oct 2026 10:48:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944210e6a20sm4958285a.4.2026.10.29.10.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:48:05 -0700 (PDT)
Message-ID: <9921a8c1-ee84-4886-a96d-6a38f36ae46f@gmail.com>
Date: Thu, 29 Oct 2026 10:48:01 -0700
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
Subject: Re: [PATCH 7.3 00/38] 7.3.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028165940.394092994@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028165940.394092994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.1 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
