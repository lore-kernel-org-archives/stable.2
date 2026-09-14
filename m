Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6164908AF
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406809; cv=none; b=W4ztefiWA0IXyruls0WOA7ZX1CgnUxKuCZAnm1c9D2uYi98y3pI20JrgXsh/yIGsKID3SWfYpAgOotQKLF0VZfcHd2Veoi1saPJaMCKj8GKwr7GL6uZbNos180EQCYD5feCUMjZl7CVZdovL8944WLjgeQdE5ESGPMekHIV7G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406809; c=relaxed/simple;
	bh=pU8YoxfaiYcGyjJ2bzXSTvUUJeEHYPgFb5yIn8TMU+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGT8dO1mFXvAUEZNDQkObA0+wvEhpl5Xl+p1eyNIaf2DNb/hjD/F33mhTV7HRYtO6vXnjH3ef7ytEqyXQdZHO1wyXAz5rZ6zsTCfWZB0E4NVcht43FA49rQgNSCEcN9rEmbIPsV48qEzHkp7mtPSvRnxetA7T83VQgzdI2hqhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMaNdIe5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMaNdIe5"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so2759063b3a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789406806; x=1790011606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glDU7GH43DqZJrOds8Mk6qv3pqgdcJGDTfDGiTxJPj8=;
        b=RMaNdIe54u4lbXgKVC/jQYdBF42D/paAE82PDjZe1J6caXLEMSyuH5frSe5hfmf1Rr
         qv7vtvIn3//zKzNJLP9v3N16fK3RlCnnPvZy36YyDPECP+ACjT6Pd6y7OgjFsGiGNbi7
         S3NDGNMTAPqAb0kDuiJnNKPUkdXQlli+yk9poC/aLEDAI49OkncgS95+1Lp/T5GUy65t
         FOkqdCkVaJMD+hcF/K0Nk4GWB186+7kfCq/Zk2O9YA0FTwkrzu+lovSO+BJKSby4U43E
         Y4bgT6Gkf+ZyAsaS5HbNFdZUn23CjAXr8rNtRCPX1Brtu19S/622BsWrEDS1KwqBEjqJ
         aXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789406806; x=1790011606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glDU7GH43DqZJrOds8Mk6qv3pqgdcJGDTfDGiTxJPj8=;
        b=VFvxr12vzpZL66tmMzPAw7ETF0Gx0HFvmbJikykizfQqqoKcWpEgiv6+PYFLfdmUce
         /NAMEBzxoGcvoDIvHZV488Q81cCRZFPi80kc6QKNB9CQUe/BC0lZOgqeTLhbxZ/Ibtkt
         Z5rJQFNeqQKnTIZO7YQF/M2bO5FB8PBV5zpLDgQDHptZptDVmFIgmo5c3MpD428CdFZX
         5Od0L9Wmgv3oBBg9Rp/5tZ/qMDKsNMPzKpGVmYY2qCF1FULGrtuzntKxkF0n9+vAWF+M
         42spAZQZBaU2lrJg+vG4px4ulXSfGs98xVaf2zj6Issr9nmQXrbRffuWaoxCoP65+Yr8
         cC0w==
X-Forwarded-Encrypted: i=1; AKwUvBz0FJ80KSu6ulD2JtPscmMNJnBO/sRMZdoVT7ADz5fRw58T/808sz4aGeA2wSE9axM6b0VMfO0=@vger.kernel.org
X-Gm-Message-State: AFuF++n2/jkr5gdk8j279oNcMb0uXst3Y6T7EeDfKjTCr33njrBGqzY8
	14TxNahr9qybdniaG4unQ+wbpjHDmPtP2uaC2uw6rNBtiqOSm/7LCD4hLerrDQ==
X-Gm-Gg: AYBFou38V6rdw86V9BM0kEYq6xnfxNjloaQTua/TYb4DqoY4FLVGPCYkWfdUWRZ5LgF
	PloShnJsAT8ru34+OT+ufuoQkzPJzQZsiG+AR0BCfAnX4SSdZT4G8ULKcbfNJYGPQeea5cjBSAw
	ff2aMhC46yWbZlmh90+awfwJBTQYNQQ9tktG+nAT4kihuPsszxsx6p6rbU3Ah7ib6mx0KFbziR8
	i8i+3lSavBybZ5/glcBdqzNjS3EKUKLNaI9IVBAm+ZnPPfE8sS1P4gMw7eHX/NpPNXkFvfoR8aL
	Utt7wHKK24ir+CAA8z6eI/rDVsYa2NxuRiwCQV2/LeiMOClaETT18tbKvRuHIZrPSonusI2mMxq
	T1LZF+9765Pr+kxH3iaIt6setHEas48w06WuifOytLlKqPyPHisXHSDdW2hG+OT0A8BjP/5MJSa
	d+c8eOpcMfh92JKfCtsV1bOdhDDycD4EMbrtK8SYk3nVXhMAQebe0lmZpCU4eCntpb1YcYICB2R
	HM358w/u2Y3DbMKmxIaI8BTbA==
X-Received: by 2002:a05:6a21:918c:b0:3cd:61d5:f342 with SMTP id adf61e73a8af0-3db404eff3emr8925150637.9.1789406806046;
        Mon, 14 Sep 2026 10:26:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6529a71sm5483635a12.5.2026.09.14.10.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 10:26:45 -0700 (PDT)
Message-ID: <f37a16b7-b9e3-45f4-8ecf-409a4eeee674@gmail.com>
Date: Mon, 14 Sep 2026 10:26:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/935] 5.15.221-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065526.833703348@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065526.833703348@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.221 release.
> There are 935 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.221-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
