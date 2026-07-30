Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731C3C1090
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446495; cv=none; b=nVyl1FuL7ajYG62DBPogPx9V6mglT3iarhEhLF6c0UIFyERS9VL2tuVXyWZ6Ifz0P5dWfuaDf07Po90TATFCKsK5HSFESohYIfoOUCddMXMJgcK5N7o6dR9WAn/uR3UCbfIMKXX/iTM0aG4mwtwbWkjd2U672kvVZL02e56ju9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446495; c=relaxed/simple;
	bh=XGZ3teLZsW6bleaVDyrRN2bX+EDnEaGQp/CXMLH++vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm3As/Fu1eq+8Yk2hPveyqN8ZcuOqgAEZo1sFYrfsI4R8k620f97ixDIXP6xlS2O53PgSENri33R7FaSR9fz0PsE81y3wNYVfFZ+PZVewidcS0K++7I+R7bddnWqKEMDGll9bxFIJny/sngssxSX9q4Bl4/NrK+8U1o/9FZkkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdnuqVoY; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdnuqVoY"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4569e871502so112494fac.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785446489; x=1786051289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqvVjFhW43I+Lsz25gTZoUhjay7ZWDClmLf0v2lBeo8=;
        b=FdnuqVoY/5PJxXkmGdKSoQx+Y8n9O249i1pXxYaIWNFFsP/bxz3EsAZqJzaz53KM8k
         suhXd0yc//4eQsOLbBrXoaK8ZfHNTD7QjaO2Lk6sfN10lBHb9R6tJmTEHzK7/Q3pMgNO
         dhLqoU0V0eyYnYhxFKxntCs60AbA1MIWnoY7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446489; x=1786051289;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqvVjFhW43I+Lsz25gTZoUhjay7ZWDClmLf0v2lBeo8=;
        b=UKv8V0iYsSimcrrWthwQr4GLn3v5GNY0G6ZEYJKP78W2cvqoppMvNb648zQO2G00pL
         L2q0bfO13tw9T3Aj61ln2SHBIJFWLxcoS8PAX6Wjz+TrxEGkvTrYV/1OuOfb9JSFDz6Y
         W2wFKVGS7rOgds5R3J+9X1rxj7txVQ60Wub+cJTqAuo22uG6leCsfkCLhKydojHYD5mr
         2vFJkRjIxJ6sfm29mHCs9u8MMvO2NcJxuKLNQ2Sk9oc0x93GKC92wcPcR/0qEu4tRFqA
         GjQFM7KBesyPdP6Sc/vgTP0kXniCX6LLoG+phbE9Sh/rQ7i1oTU+q5xa55oqI08qi2jv
         cbww==
X-Forwarded-Encrypted: i=1; AHgh+RrYEJVy5jMsheytInfq3lWEYeIrChuY87/VJQrHiM8/RTejTcoyev4k8weuHOFEvS5t32uB7Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQtWTAAdhRQybHGXqxZvFrqoRS7HWyOdHUCN46uZRijCdu5Kb
	7u0akVbpn1SG4eyzwQ1AG+T65ocf+YKxQxvWN3yZidYEjttxaFngNhO9zjzRNJ3Pca4=
X-Gm-Gg: AR+sD1220nYSWMtoxDY7tZeqQ9/vWp49G3irFGTWUn2+q8Z444Rr697m82RUg3E44ey
	IKlqh9hMm6Yfcscy3jBR2NG6j3ItpXTTZAxgDkvL77LeKJBgX0IBfLxv4gWj7FEaz+xcPoPnto1
	pMIkYxO8sOE7Yy0mfvoWTk9LEkyv9ay5meMWyj/iU+ODBMKcWo0G7Saxms/7DJ+QEjZdN1R6+mj
	D0+rE9p2gp/oQ7e3slk4SP7hc9uvpwFnzA4ghjbjWRmBZbvnbGdvL8mFqjdhl7qlTo1SkuX3gy2
	mxQ2yP6tXJ3b6cvaw8u51JtshZWAmUiEF/WU9qfv4wnkxuFjwJecAWarU9gwQQ5p0Nt5LNHdKpx
	XlwQuNMUN/mHa/+wQFo4qFD0/4n/hU0vkT7ojJ2ZU2B3IOOTYmuA5i9sk04SQYrddyNDMDmYssl
	+jvFoddRPjI+29boU3IghbYQ6kLCi0v51p+XdbZNP/0huvvy4Tx88ma3NAqaFa1RYW98LDVw==
X-Received: by 2002:a05:6870:326e:b0:456:cdf2:ae66 with SMTP id 586e51a60fabf-458c19ba670mr3132128fac.20.1785446488932;
        Thu, 30 Jul 2026 14:21:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c2947cecsm3159426fac.12.2026.07.30.14.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:21:27 -0700 (PDT)
Message-ID: <51185023-01cd-47b7-bbc7-388711a6f57c@linuxfoundation.org>
Date: Thu, 30 Jul 2026 15:21:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/602] 6.12.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260730141435.976815864@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260730141435.976815864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 08:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.101 release.
> There are 602 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
