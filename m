Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3D40097A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739451; cv=none; b=HUey0fn7dZuqI768o80dYZE2qme4IXmW/WguVilK66OhuX0vy6xhtezqc9mtOG43pppKGuZ2j6uiuV5B1jeAsGYW88TH1jwXwtJxqaCoPWN4tg3or3wsTxwRNlEpXSeUy63UkZQbNt5Pm1O5qv/bNczWzo5Jb3z8fLzgQYFQ4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739451; c=relaxed/simple;
	bh=uCX/YMZs+bW0+HV3qZk1hPOpTSniASdlSrxjEiGbR2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYGXr+oy2b1IxIsHj7aN3QzDRumBHYvBXGZcqvR8OH+VUDpEHkznKXz6vJ5LJw+6ACw5byl/Gn3zgKyQKLLhikz4FlteCGUFKjlAln/gTvqp9+sLJ6F3scmCxJ7fYHm+AMWFIWIJD1jBwnecQ3CnGVEyoUqWPtiPOtGT9kFEAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVqqj+ov; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVqqj+ov"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1507714a34.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784739447; x=1785344247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujUCo8FHFBDihMIuGFqtWgMTJvOgj4wPRWijZvZJVaQ=;
        b=XVqqj+ov0DV4vHE8rOdydM4v1y51wWxnT71gHGYoV2SzR153UGp7QXJzeEttUWV23c
         QMocIUCd754KVk1QGl9nipop1t3E1ykKWefxPc8ZoHR84d8OmFfbrEam/Ie0xFG+xVC7
         MNNfQGnP7IuIZhP+iSegXJmkz6X/jLdcCpfwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739447; x=1785344247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujUCo8FHFBDihMIuGFqtWgMTJvOgj4wPRWijZvZJVaQ=;
        b=ZcVCjruz3EuGu9qWv4oWScpjuRvtGf1M/XNUprtG/C88oYMMLJznMNFgJszUF21lxU
         hQPjobs2cXay1VjBsCgyW92CZxUGJf5F/oyKLP28mGpDF+rNmygxg7YbtDSyLVrZ9nrx
         FSa21Qnc/4RmFlmYqT9kigPd7WBeGH5/vmC4R51GX0tCOv+PYMrrax0Zrw8hNh25innA
         rKouzV8WrUy1M2DdqGggzTVb3kRAOKpFw1Dp+P9AxM+FdIhNn9qRMNb+Us9Q/VHg6Etk
         O/n8S5zSAcGlXDxft/XlX5Qr0iBc0xmfQe3d7vzWEy0bYclDYlpAdU3BNurUu00y5AQ0
         bAhw==
X-Forwarded-Encrypted: i=1; AHgh+RqxD63FbiQcn3qzplrYXXDMDoBan7b0RyHCxUYGoTJaNG2nz7/v4Q0ncPBrD/kf2yBwVLy2UdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAFzTUGmadR1VCZSbsdOtQMbQjMIjTjmEF46YHZoDH8otaYTB
	B62Tyxq3TIU/nYA1a4WDRml5aEKRZyCjreLGcJ+F0sOx1CvAocFkD2aXkCraZ8FIfoQNIJNEipN
	OhEGHT5w=
X-Gm-Gg: AR+sD11fObc/MBhk7KYEhtHvxK6YOeLFnrLnrKWfvLoF/65xvQTeaKbBiDxxyN3+NH6
	ZVZCugXklmNCTR9jUsZrS7SKqzDkqBCi0YExtK+WrmA5LWyMSIL/5jOGecnutmrTFuvqeLMclVF
	0OL7PiYvgqElJRB4Y0oO2Qud9ukGqsVtXE7s8X1uiybZB8DRr8PBM9x5Rx4c7hVBqdG14MIYkWJ
	gNlto/dT2psyCqHZPH9g6CPz5NnjilKHiKoVEJ7hL9UQZm0KqMuAh137tSbvsy/xoLD/TRz6iBq
	SOETorTQ4pqodh3eoBpwPS7/Cr/tHvi6Ybr7D8BQS1g0pR+jHgAbR+SEquyoeujcdBO4l9X82Xn
	T9wNDTTOxd0DdE/3bAktNetXvuf/9KUbjzaCjhlCmrlYVn7I1w2KhZ4ScG3RDtaNxVMXoV8uHXw
	+ZAGVTx6hYn0E=
X-Received: by 2002:a05:6830:4390:b0:7eb:cc5f:a6df with SMTP id 46e09a7af769-7eda4d39912mr12668713a34.18.1784739447526;
        Wed, 22 Jul 2026 09:57:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0b3ee5sm1709410a34.24.2026.07.22.09.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:57:27 -0700 (PDT)
Message-ID: <d98c92e3-ab03-4732-8343-333222fb83d9@linuxfoundation.org>
Date: Wed, 22 Jul 2026 10:57:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1611] 6.18.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152514.750365251@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152514.750365251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.40-rc1.gz
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
