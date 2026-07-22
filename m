Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DA43CE48
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740115; cv=none; b=sUJiq1ZUAd9ynW3sU7WmPx4I0yiCEZpKgujNX7FRHcFqP13g/2sWn928gpWmacZ7LY5tDoadM/JrvL1zqKJbD6zpw0Xe7Xq24YiKRMRJY+HvWVsOKoU0qAplaqait7CWgIgGLw3ivN3vm2fVajGh+Wbrnww+o+1FqlroKPA+qBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740115; c=relaxed/simple;
	bh=SKWrcJccyeeVXyRR3KfRN6ZeFEydVVeyRSv1oaGQyoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeNPcXZKkI+F9CA8J0/IPTOg0xf/htm///d4mfnRUJntbydGxWiAVwuii66rGWuBG0GTEmXVX/5S9+8WUgeN5sNgaDKrhTZSokzA0Ccd4NaqtINh4AbZYMcfX8t7uj/6cVKwntFTZElqGtxBFFl26cOpXP3enTmsY9ih9gLDyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVrjByEG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVrjByEG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f829d75aso6201358a34.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784740111; x=1785344911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX7yio4N3t8Y+JNUzWpt1aRHfRlbQ7M/0cs3qHVOkuI=;
        b=OVrjByEG9+MGtnHgLwHcMOwI8ES6+KOGM/j5fd/hrn39Y6AV0TLXpugjW8An6XuXLA
         xu66c2BkDqmAQLNzoPANSHQa1JO7smSPrxfHTYkv8RN/ZqQpMkwL42ZHUzepP9zEpCD+
         eHzawq0PDe8FG0vwkioWSO2u4DcSNB5T6vxUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740111; x=1785344911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xX7yio4N3t8Y+JNUzWpt1aRHfRlbQ7M/0cs3qHVOkuI=;
        b=D9C7h4PS8VQS8ztquqO67oXiUWDLu1zsGjDym5Bz8sao5W+mz7+dx5ZVW4SSiiswfB
         NXs6QQlP9BdYfJztFCyFQjG9Om7+AyrU3b8920fq4Y/vPWR44Sf9c8S8xBlisrQkvvH5
         ZbWYJBRIO2bOwVRG26fomyIy9Jpko8GHkfr/wQB4gk4WHd0gtEv6Ghc6H3NT6lHSIt5U
         ySrhnJQXYo9uvnSHYdA9J+Kohu24nfRFmtnsG9cuMAK9ikPdlz8Lz6e7GiGAkvNvmU1v
         s3xaGHhuE6ydJus222UUFhMFfqGYSzvmWUbN5Kyy40GuzNu5S0H+OSMQOY+1941gvY3w
         17jA==
X-Forwarded-Encrypted: i=1; AHgh+RqCPf5AVfXhSdPpSRt1PHj+/S6yZdD+/Jw+AUF/cUtQnjt2aLX1aq4sNbSpIS5RggZkbKSoSMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2Vlvx513c6dIA7BIb02EKAEHgzW1zh4OqoUM/nvcuaDhABAw
	jd8Ls0A4KYHuNkgoie0h7DVg2rgrLho6LWVTZmN8S8X+EODOcr/fEb/aW++laduiZs8=
X-Gm-Gg: AR+sD11pXCj8sFSiSkfBFLU7EN0GSqXpC1lvgQSkb1X9ezTUbkoCdSl+lajuLcyoEbV
	plTv5JdobCmnpkwrVdBWw58AXPjlSasHCp0pnD0+sK0Cov3Wzm97GeirfsnIbvjmy0NhPmG+0X4
	sSdiRdx2T65bOfQsaU/cM2ik5Be9UMcXYWsm2ToaEmI1RRXz+T411JjQR4uiN10Zb+qMrWd0l4I
	wcfJuWPJDpHhPYVLCRbQ+vQof9OMwmR+bKnltQHp2KbkOldGl3p+Bz35cZfyQ8Ph2Q2QqoNTGlf
	oFdSzkvdu5SPYK/nNcqgbLVdP/WWcWSRP+iJSHKabfOrn2EAj4IlWQrqHMq4RjXsHU1exlsvxX2
	apWhrBORbo/jSNwBouD023CfBiZ55/Q0ajKCYV+2iTYtLkhIOddn+j767LPi5CmNFht8M7vUfl/
	gsgh05mbXopak=
X-Received: by 2002:a05:6830:498f:b0:7e9:c59f:9515 with SMTP id 46e09a7af769-7eda09578cemr13239991a34.23.1784740111179;
        Wed, 22 Jul 2026 10:08:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db53fdsm1710163a34.4.2026.07.22.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:08:30 -0700 (PDT)
Message-ID: <48638deb-7d0b-407c-94fd-8eeeed3f2221@linuxfoundation.org>
Date: Wed, 22 Jul 2026 11:08:27 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1266] 6.6.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152441.786066624@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152441.786066624@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1266 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.145-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

