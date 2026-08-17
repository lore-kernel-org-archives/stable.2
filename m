Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C773B95E7
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997912; cv=none; b=s+B76WoA/4bng03Gu6Ekoosqw94cMpTgskrXMiPuWGxrAfeNHc1LVYrOISp9h76OP/pW/ZOYwK3Xja5zYbYDMZ4J3UNuS0YOcuBKwBOZ4uwHJZL7IqVvgUWvFl7vPkIScr8N2Vif7VVf3nNlg/9kGuoIICNVTnaKVvSxFTtFWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997912; c=relaxed/simple;
	bh=TE1hIpoaPcqTZGDR04S+7oNnMFv7ZuheYACMnpIQF98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfo7RpOQ0bF3gOc6/b8Q95EsKUYBbKKHQ4NnrB/D/GVpGF2LjNOOM4dUPaZwQKgd6uCwF2jAfLDlx4o0zyKO2PRqiD4h8PVsqzwAw1QOvFjU69BONfmBLRro7811aPMg1i+xr3hi32RC+MVumS/5PR/Xhr2AzrI5aTbfDuW5hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOyBwsly; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOyBwsly"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso3909964b3a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997911; x=1787602711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zY/Y5PhSQuxWDHF9kHAoPxjL55SbtIZKrGskYEz5Z4=;
        b=HOyBwslyXz6SRN3Hzk89GdKVGWtc8Rv2dseBFne48CC5UxkU3jgmd9sgVQDYRcPBVU
         mZH5KQPvXkEz6fhV/rj8NG4VnbITMIyw1p8nPNvyKYW8xLEm5+K+j4NX95RspxlHCuwj
         vP6cAAs4TMY7rh5h6eWKtZYLdlWoLbSycADogmJUMHlm1H2JCbwJJkkPVKw/6BHNTSrZ
         CPC6+fUbvKkwiw3vsF//6APdSd8ski2SnjST0BnjqO94iBPcQ9//+QASqPC95Phd/IfZ
         AlC3ObUl5Qaq8e69Pz+NXVbFegECIROKlUFZOocPdX7ONgZDhUtCb8eB1joWFtoq/ECj
         Nqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997911; x=1787602711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zY/Y5PhSQuxWDHF9kHAoPxjL55SbtIZKrGskYEz5Z4=;
        b=Ul1WveW4Vs3GSrRdN7x3r7+9ppStqAfr/caakQ9YXSeNFE8VqM5jHJGWMZ2gkLPZGM
         cIU8ny5XdW5FH2Q3mt3xUjpCo6mI7fAQowar6dHuf1IFp1FJ44yuEhT6C4MT4C1ZWy0W
         hVoAVmMo+ZtQniyqo6ekqbVNoIjh04NWuYiVt3WnOQSdL5NW4zB/c/giZHEfPnJtY7Cs
         TI8BOebbkfb7Pl4t5dXe7y3jX18ad4TK2/k41pLrwThkjnvqC2f24ST6fPL/M6MebFou
         6xyboAV9B/5KXQzp6Eqlo8a4F60wzJwSV+ZzM6BjMjYlVqqM2mB7pZvRn1BcZY5SsUrL
         QS1g==
X-Forwarded-Encrypted: i=1; AHgh+RoxvBzFLCvMjcf2q9MIsq4VuGkFz+tajNkkpJzh7kgq04ETEJMJOZl9AEA5ytPxVE33s3FpXs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGYMd119jsz4BeVeS+Udc9o0XtlP/AYjPwVSv7VBRfbV0ICK8
	9xPr17rDsJOD9VOXtoCKqUWcEA88lziFsAYImH+QF+3VtodjmNgdDd+a
X-Gm-Gg: AR+sD12snUUwhHe2d8KDmmkxwulbJ3n7oqDPr5EXah+5ZYAfcvv/f7tgAruLw/3NniU
	DvUADtJcNrHoHCgnzHlh84/YqH7iuSrnBdkd5df6pia8Jow65BUX+/fv/aF6bWrlrB6o/62mN74
	ISYjTQh1kB3GsoDhfZzQZ3hlu9l2xQr8Fwj5OQcJF3JO0pm3a7srKyIRovadbyHwjDFzM/z8Go4
	ouAUffRvJVpGzRB59bI0xQUepP3Y8QOSgyHh0A9U6bTUL9J/cC1k2CZEVE6UqWf/xd8fPrFjWL1
	lhxxyi4wCWITsLRdMUCKMRh6mxRJlh1V9gIPfC+9TTb5KmsTYmm12/gh/fDQAVg9OzP6TVbJ0Cs
	2nZbt1QsReFEBozIFDdhIdD6QwtdUbaSu56ht9BaLtM/mLlwKWSc+XZmfn35EmAWMFndfrt1fzR
	z/baZBgCm8tSmb/1Uy5TBw6lsF2iAfvbbwvIcoX8o6nmjHQUMidPD01XkGRDR4v8IJ31Iv5FQLp
	AqYQizO03vJJqc=
X-Received: by 2002:a05:6a21:a4a:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3cc71af165bmr32004977637.3.1786997911027;
        Mon, 17 Aug 2026 13:18:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e5c8sm9203221eec.16.2026.08.17.13.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 13:18:30 -0700 (PDT)
Message-ID: <8858686e-14bf-4420-bc6c-5646b0223dfd@gmail.com>
Date: Mon, 17 Aug 2026 13:18:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/181] 6.12.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132535.394764707@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132535.394764707@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.104 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.104-rc1.gz
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
-- 
Florian
