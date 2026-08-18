Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD6226D18
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074531; cv=none; b=t4wmdS+m6FPThAg27Y6dFAjjt+GoNs2VVAcW2cTV+RNFM9VMOnrcpE1gyvCFUuwc4CVvebmBwkwsdCpsKCa+RtpayMEEc3fYwaA5PT+LkBAe30HpbMMM82Pr5psQEoA6AMjURandNdgja72uJIbZYfZICKbLoyceKhTefX067HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074531; c=relaxed/simple;
	bh=vRv4p8G1EikQLPTLt8iSs05htgmriR7ULX5yE/7TjEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZpw4R72sONqNwQQBgQj0bQrVG0jfIypyzD78snPQn6Lj3Uha6zLKoSCb9Tks9i85KPj02uLHTtrsVjF0PfzRnYVbHxUhrBp0etDwe3ui6nGPKVZ9/fvZHlO0SRiFI2bQNpeZ/gkTjMr31e33axCjk0pQpNKa4rv44vTXHcxe0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELZTnUqZ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELZTnUqZ"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44cedfaab6bso100066fac.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787074527; x=1787679327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVBcDDnKF6a9m1my7xViaBbBdXKcVdgploI4y5YU0hY=;
        b=ELZTnUqZyggXCUAeNkHgu+4JrNnVPqYHDwDY8fX0X3fFuo7EHbn6qhidfNHwNS2QCs
         Jha9IDb5dkfm3Hdu+V6J6SLdOieO2hVn75jnQDhMvt1qjxSEhs9gLvTa465IMXUc8eui
         86CSrF0f+EVN4eQWvmGi7Gk92r/x1R2kPOsKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074527; x=1787679327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVBcDDnKF6a9m1my7xViaBbBdXKcVdgploI4y5YU0hY=;
        b=kBq4xubxJkNvQvI3DWldLQVVXqVMDVSIEaAo3c38yzDG0nyEhnk5x8LJ4yrGCuYXHF
         PE/sRfaVddikM+sTqR16iNcIDZajDai/Qw1wNsr0n4kk3vzVM8LrBKl16l+go5HLzpIA
         hBm23L741Tn/b3zTm+xyZSfNLST3WRCsvgRGomg4twKV3xnKL3QJ9ZDB8kUbhnrIfzVy
         OZImvP7jZ/kHWz1kEZ2NiDfjq6NXmYQiXdkqrN6olRszEtqMVzepySgk6diCTbpdLdsf
         iPb+lFlWq8pkSttRBGwdWgHiMmYra5l1G+F5Mq9h4OJpgQOwap5aPISbe1OEVwdxGqua
         Zi6g==
X-Forwarded-Encrypted: i=1; AHgh+RpfZC9aYxFWnyW4hOYfn7ykMPQZCzN6LPv/asTeeDykR1tfYJjWIttEKy+ok7M2V2uKw8tu6kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZAuLLccgilN7t+jnylq8Lc9TkNq8YlbdIe/bIWXsHjxTpylM
	Wn5F/84gZZqJzPcWnzCUx9jg6AzCdTThfRm9wojV96e6utx65hheh3LiAnRGL+Vm7XU=
X-Gm-Gg: AR+sD12+2fkSEhNElnDYnZvfAUT2UNDuRqFdCBoqRkcmNz3x4ZvW62Zm/fJ46ETBdUU
	O8F1Fji6DQs5ypTJNIaTOHXa6aZ8rVKw1tItYPd3Ie6OfGpe0ub1d0McWZ3TTSa1M9HuBfSTbNV
	4b/CNd/05eTWwJAdSVz/Azw3lZ4UWuMJNaZ37Cja6kI4hxYvcpJ87druU/X3dAPUbKqlV36ewY+
	1m9Ow2oBQAGl++iPBUnvgOdSc/EulOkHL6oziHG4LJR6YDB2ls+sMs5vQeD/mFNx7oGcVAqBeos
	Yyn92rqDAELmCTv5r3Y/yHOAqwchp+BrJZkkOehIQbr0yiU5/SfoHZFF4fUAl1MiD+EbncYS9XX
	BWDCzuT7l+syQW/896I4Vlv6kfzkLWk1YQQ2q2hpVdEIrK6+52Z9uvH53R08CnA93XtRPeFqlQ3
	u2GQnWytdPw32K6h+fj3hwWFo7EkH9VYe67L4YWSoUrq0MRbutUYpUACVP9z/vhm1OsXYu6w==
X-Received: by 2002:a4a:ee17:0:b0:6ae:9efa:b47d with SMTP id 006d021491bc7-6b0d5fb5dd6mr29851708eaf.7.1787074527221;
        Tue, 18 Aug 2026 10:35:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1166fd581sm5225084eaf.15.2026.08.18.10.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:35:26 -0700 (PDT)
Message-ID: <cea88589-5e7f-43eb-8cb3-5f71dfaf62a0@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:35:21 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132536.752504388@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:28, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
