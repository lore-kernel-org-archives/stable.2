Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF470E8B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747128; cv=none; b=DnGvAQh/yKeXCGnx69QEfynhdI4rXA8yNcq05pmeVaScnlE26g9zwcEfFTOFOXcnO+I1D2ndR7plWlW36ukUJT9fCDTLRAqxM5QI+ydza9mo1O6DAIIdBFOEKOvCEXl4+iyBCKRbyBnIJSruyBYph+65IPx8ViTKmObZlGqFn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747128; c=relaxed/simple;
	bh=RTGSP1PrbQsR7MQ2Uj3+W1TKDMrOZZvw8Edchm0Erc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih6QIxAMMSxWxHcy3idwbVr+qdK7hLjnTE7swUwKZ956bXuZ0jQbgxvkOj+avmXcAZ+atSnjVfmiCHYaVsSv2sXE30qPCYGtiYeLxAaYh3xyANhyu4o6pzAXntsQyi+pGbusoE6dQSkQrLoFl0sq97qJSCHWsBTONoT6HEIqXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfY7U2Mm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfY7U2Mm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2829310a91.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784747125; x=1785351925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5Fg+zZTeJl/Ra61hw9jhQ9ZtWgPeAP9paote82q4Hc=;
        b=ZfY7U2MmbXfZN7mj3Ui7E16SBdDDuvQA02s0zG4faxRC8bqv47hi/SUnXCsVsvKqma
         f8uiw9T7ZLhGw1uaC2R8S/QaM6JdoL+9j2ZeHHEY6ri3QC5hHZOKnF5CLtXg0nyp6bOU
         XOXoGsXvZDYiwfPad0S1QFV6Sb4T8yPTU79V4e+Hz3NcpdBdM21H72E2gp4XauQCBfJ1
         u3+FYXNmnWy8ete8d327PBNNOFtlhgW3gMphnbcKntxQK53af1yneCXBXz4Jqwk2XNno
         sxpPy12BJo0E+b51SGCibX2L+3OyLUgzbmvnELkQziNKFajLNFG/Wcc36oHr4EU2MpmX
         HzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747125; x=1785351925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5Fg+zZTeJl/Ra61hw9jhQ9ZtWgPeAP9paote82q4Hc=;
        b=DO+zZwEHDM/6V/I1xVDK7IF93keMimkngiAr/1Z7jFbKB07Yw2NXbkHcCPeNBXTKkZ
         WAYPusFR0FcugCbTHAV3QtQl5ZYvZlDwuVsM1xIe1CRQHdaaw+7ruglArCJN7m5bH6Yh
         Dv6sS1Jt+0RLwWDgXG1EHnEjLKgBNkkFqK6sEAiw2deCFKGQbFcF/tdoSEZReRekviBy
         wUsYGsZDlT07not+VY1R/OXvkX+ol8cWNE6X84f3x74l9TTKF++dLeGWpkONGHVNS0d/
         itLRY/KYDwOyE56hyiaguTFz/eCL4cGpsgp5q9gYbJtGmm0JwM4lcLjGW3ZmIwbl8tyK
         lV/g==
X-Forwarded-Encrypted: i=1; AHgh+RqxnO6Rqe2ym5ldUH0ryOwDYsPP80RCLVE5oIDWsAXkjKben1f8Xn0TKZD90UxvQAVWAB6/Pa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/31+lsCLEdj66hB+WOBySPgYCsPlRSlmNRXOuK8fO/R8zG1s
	JjqjaSY1UjV64132z9QV46vnUrVAvAe1RmIageNC8FhRuWgcrErEzD7w
X-Gm-Gg: AR+sD12m67wAxzSyDLw5uWlk8gwo1ZGzyBaGIjrreCQYO01j7pX81CG0CbU5GkYLm1J
	ytbVhiHh6pzwMZybBRmxMG+C4XHQpOW7k0py01ZR+e9kxxpExdzluSuqB7g7aANMeSHCugCot6D
	d9C+ZcEMhpo/t1u8nY/bT3HDUZCXoY6U3O/IQ3j6GmcWXMlrHXCKxs6klXO/z2E+2ey+j2mRyBI
	ASPMTKKGPVpODbMErq2fE4YqLOZYpJ1COZBvCyUNlhVbSp2bzGttapQW5X5d39kO5wbaWu2l/VN
	POa0HOOA/07MPOSdrj8VmYlgrxf5KrPE5RrruNWFjtT8DlFVopb9AKyMKY639f3uhGvLT3iaD1W
	+fCnP1x8Bd9R7+r/AzSXcKeLrCobZ1rtb6aA3Xcc4zC+jci8ccmSCTMGoem/hr7bRWCWNRaGZLP
	ASDx4yLDMMtkfh2KQ96+UQSmUYKaqu4hsaoEsTzkw=
X-Received: by 2002:a17:90b:4e8c:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38ec648eb01mr10353a91.19.1784747124698;
        Wed, 22 Jul 2026 12:05:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm14365136c88.2.2026.07.22.12.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 12:05:23 -0700 (PDT)
Message-ID: <d9f821d2-32dd-4412-a694-a2e0a515c9a8@gmail.com>
Date: Wed, 22 Jul 2026 12:05:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722142947.085426486@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.5-rc2.gz
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
