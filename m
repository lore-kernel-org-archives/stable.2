Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B6429016
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323990; cv=none; b=D6r6ybjYMp0iGi+zxhOojX0HLJvxseku7mpsDLbEJpHgRKh8fFwjZ7cnj63n8SWoIZL3VHABzcpA0GgyzK18+BecmxnMLlOLr/SsfS6Slp1hlp+O0OdtcCBiAm+CE2or6ipeNOxkGh+H3k3Z/RWIPFU5B3bJhn0HPPkGOZn2LQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323990; c=relaxed/simple;
	bh=f80evFUKcYBwSkEcmUDXzlyi5hNw03mAxg46c6N9LnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMgz1RHpwanh3kWHE02MYlcSf9qS+Lu8d0F4PC/CkjX3GHDas8VqmEqHdaS7+mtBt0AsK4m7olKMvgJ6V+rYu4xfW71eaOI22cLZ9R9wdcwAEg+IRrbv6vAXPhYjT+HYhr6zRI/dp4LpSdN9d1KxIsxpDPO0SsuaXaj8bwTqlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMrkbbiS; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMrkbbiS"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cf70de986so710405fac.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787323988; x=1787928788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRw6+Ijntw5BuwKAYSl816AG3AcfEQ9/cpfIZBBwBps=;
        b=NMrkbbiSGDOSMzRnN3p8OxhZzzlO/SKiz9cJLffuPu+k8s264Jbp3Jxt4hFMddy/dv
         kPbKBzcAIcsQD2Fjn6TIiO0wBUNE8fttNA8zRo2paY5T3PnESNgeiK4dp6MODKB8OxzT
         2/ZLBxhqiFvHwecexLGDQQWxheywPg7+OUW4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323988; x=1787928788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRw6+Ijntw5BuwKAYSl816AG3AcfEQ9/cpfIZBBwBps=;
        b=mtT1F4z7N0IciZvr7IULlpV1hfaxhf0CXoYFC7vai1MPWNLXn4k50o1n/g3/tiICBZ
         4lmQ5Cxdm/8s2pfrCvYnUEFJ64KBgYc4pRHOvEfijEwVEE+w0BAcMmeevJPSzwUHei3U
         8N81ZMEU2QRJk88WIhVfUS7++c5QUhBCrukU1c8FHPh+9Apr7kIjQ2lfoXSXyRMuyKRl
         ONPfE4t8+Syj53nCS7Q+oTAnMD1Gt2thNeGj3kKf83Y65ya3qZRq6DKmYbdQon9I4vd9
         JCqjQn+H62Y9Cd65yMFvFNJ7BZ9K1Gev+Vu5nJKZGD4AJtwdP+IpioRET3Yo5clyRYDN
         9uvw==
X-Forwarded-Encrypted: i=1; AHgh+RoLVqFhHm7f96dwdv0IcZaWu7tx9mHoK/ukt3fEUGnohc8tXT6sRI9iJXDeMOMBm7NcPh1rDJM=@vger.kernel.org
X-Gm-Message-State: AFuF++k9ne+DGFeDNSd6Gx/I4zL6YCM6C6nkL+A1pMjzZIr5dbDlURgo
	Q+wQJjPG9sjjGMsdX+Wk1Gqa5tzqSNn3lmif5lOBUqOIHzY/ZvJ0hgA21UYMZ5UyujQ=
X-Gm-Gg: AR+sD11YW+1GDYMCFhyHQnBegJqtmTBONsmpdFTqxKYGDwntaX7aiO8SOsMrhcYBh/r
	1V5zUSb6zQsj28bCW8kRfDQ5RibyqeTiBAIcBzt7waP3mhxRgFZUCRbnbUmCvX7aCsIRwhIwuTp
	Nx56KDP/rAeeQDw5O14FrWZJFsku+1yAAHKFagdLCqPwwXrF34pXmo/Ec6vKtnZxY/R6IyO9Dhc
	vXRxn9IN27HVMmqQQo3mARRyYktiaWixZnbpnsqR3jXgrVs5P/yLJeBOY0ZKxsA+I48eFSKX56x
	8XhLUo9qyDN2Cn/yZOmumeIkGiIBoKw0KKIwaZjGNqmv4jDawYPLAKRak6thYwT9xFGFcrWQPHb
	AmLt/3nEJv8lnnbbYfKDWNrQonvDzzHX75DYGlbSJI9TUJ5lImBjQPXGF5I58jq68FOe1fTodX9
	mR1a5SL5ESA6IiuyPhmMGHUFmxtynIYyrnkxULThhxWPZqQwSLIBDuj2H1XKJiO8gmI+Isjw==
X-Received: by 2002:a05:6870:8106:b0:44c:d6f0:7f70 with SMTP id 586e51a60fabf-46351421357mr6721721fac.17.1787323987661;
        Fri, 21 Aug 2026 07:53:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a54fc4esm4525536fac.3.2026.08.21.07.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:53:06 -0700 (PDT)
Message-ID: <74071f91-c410-4c29-9852-1644e3f1dacb@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:53:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145211.194104353@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145211.194104353@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.153 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.153-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
