Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B5435A9E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324110; cv=none; b=JbsIi83i62RTTFxekZrIIoJGtZ5c2aalDjPNetddVdSrnMhOiD+evjBSGMs/tCulHU3AZctNXJoNbHwJG0MGGLy2kGpofii/k1eRZV9wAqRM0P1v3ZeLYATV99VoenneL3f1BI5gru8RiSBhARxkaTwlpbBD0/KvcaIRXMcS9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324110; c=relaxed/simple;
	bh=WlII++3uV9xkwc7N++Z05mAds6dpc2dOKTEgBDqPksw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXgl3eJo9pgpY4Q4O77s7+33tdVaqELJXs0TgaPSQg3vz77o/4asgczpOEDO4Tv2Ts6sFOrSqKqEdZ1I8jBsfmLf7hDpRVKSRXI6TFcbBhPA2h8x2tQwlCKIjeu954GXrVR27JP5/DoyK9yCQqr/6GS3EFrJSPvY99joWzPaOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUQXO2kR; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUQXO2kR"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f3fd905828so1059102a34.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787324107; x=1787928907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAvKZiD5KByJeDCeOU37FeBtAgTWUBB1aLiIutgJAhU=;
        b=SUQXO2kRtgXNKlsLs/hqmy3NZdXoxIFoXWYPHZXs+5GCQkRS+KWSQkn6KDs+b+DCcZ
         KlsZ7kUWJ16k0JKJ1fRcHQetHDlU3FHwWgxY/FjGDQ/9FLs7gMli3SfVhQ0bfMqPWaNg
         y3lVep+WodBQkreipyEMvSi70YnQjPbvvFosA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324107; x=1787928907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAvKZiD5KByJeDCeOU37FeBtAgTWUBB1aLiIutgJAhU=;
        b=VK0MKTUgPYnwHRu4S6Th403a7LYoIGTp0xOfPFEhoY8aRObFi+qfRag/i46a91vnLm
         tNLswQEHcl9eGo8HDNi9wI3BYSs6oMeXKT/I5p1E4kZdK1Ro1wjJ6cSohEPoZsyrr2Ix
         oWvgUReuOEe3zL5PTJYbyNEv6ER0TkCnrVHSVtLo4ibRpyrxLxV4jl72w9ZJc/KmhPlK
         3l4HVokfxCYMTnsBYeeZWZalzXszXMyM04H+C+9hM8B+hbcU7O5UCi6KsXhzal4zDMmU
         i+foPF04Co+LdICiFrFk+SZ+Mu5jQ3K/fMPalApaxh8wuZkWd1DYvfL7ZLmBJkC5hJQs
         6mRA==
X-Forwarded-Encrypted: i=1; AHgh+RpymepDk+VQXp1WrC2kuOGOYcskC8cRqrVcflr+iAbFiw3eqXHuwSjAW7Dkym9+B9/zgLk7uwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpb5LGdUE+cZU6bmQdxPYpkzaGTAADnrUt2w2ujQPSwHDjrYaH
	+vKjJVkjRUf96KXJL4SFP6V8qncc2mJ5YVgXteWqUKJ3YXrPi0ylkRnUZUqVflAFc3Q=
X-Gm-Gg: AR+sD11UAyWqXlyrCQe7CcuCSTKRd2Fj0M7qgsTW3yWY0zh8wUzXDSTplcJTYsJOf43
	0SHQexJ/UXYNASXHzBVt63TFbIEIjvI3SHZreNBrAUnCiHiuaG9eoVlMyCOuVOc6raj5uGgt25p
	HN0xyDcRnHcVlxG4GjPBSLPQG6PFSRR0/i6Qi4vs+f5V3fHRGE6UU/n04KtjpY3acjMVuE4dOlh
	/sJ62NuXXryggmPgrFzluXnE49pFeh/Jt28/SBpD1+mHrljWyqLjIuzqXxZqO4EQZ0++DxVOk+r
	dKgh4O6pBIdqcy56T7PGmbLKUrSmTsgVu7nF5+6gaMS81PTxDPbCOYOK5RkaxvX7tSdcGbi43CV
	Fal9neE2YTM0xRajQaWy5+NAoIcjn1ZH4792h18o2Vt1TM2lDaESx5Q82q2krimw3PMi76878r5
	OoayESmnL9LfD3f/Nv8k98DYBAZhLTwZOJn43M/nAPAIv7UzIQMxm8gcYnU7NqPrIL19A+jA==
X-Received: by 2002:a05:6830:370f:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7f461408acdmr8596894a34.9.1787324107685;
        Fri, 21 Aug 2026 07:55:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe70786sm8005724a34.4.2026.08.21.07.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:55:06 -0700 (PDT)
Message-ID: <c1034097-fedf-4c3e-80a4-ea0d29b72cdb@linuxfoundation.org>
Date: Fri, 21 Aug 2026 08:55:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/272] 5.15.217-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260820145231.229664293@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820145231.229664293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.217 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.217-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
