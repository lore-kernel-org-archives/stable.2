Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723B3CA483
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446390; cv=none; b=ObhWL7dhhr1se8/SWllPvKZ9GIWNe48tCpsHmtvVEg6AdeXcYrjLHOpS266jBF/hTtCCGuy3/03W4OrvlBDQJQwxIwfGwX9mQwvyvlMUaPqFuTTB38sVEyXsDNR5u60rNPhnkZN3BRKZNFxmJDG0zIOfTOqpbMByq2zAiIDXfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446390; c=relaxed/simple;
	bh=G1XI+5GBTx+oIkqPxinIwBou1X2aVA3QOE+MAiC5iyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3UcVWI5ctRp1bHRK0ZPRPOjXOwpX745woahxuMQHUkx7C98/GeFJr1IXMgSAmoSITZQtlqYb6jWKFm76fz4ZVcq3qG0KipGE0/tJlxLk8MJh0b9EHb80GbfC6TuTFSKtkmNklnlursOL09gxQ5Lcs8+p9paZ9UUDyjJb4UgLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9iM+Rbi; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9iM+Rbi"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aaea785032so109216eaf.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785446387; x=1786051187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssRbo33iKLdgp+nHO0enQlsAP107KZkbYC4ZS/Agj6U=;
        b=E9iM+RbiLIs8Lu9U49k+3uXr0AdHwNyDacBjbPO4i5i0qMZJoTA8v/FpVKMehR6n0/
         PXg3v/VBlwBxJGHHTwe287DEBSvkzpnzTvtiqkLnPKlZnfjFM0809eYeibHZzg3r+CZt
         SB/Lg1G1KsbVCs0HoTAn34mcLJDrSlJ1+84dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446387; x=1786051187;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssRbo33iKLdgp+nHO0enQlsAP107KZkbYC4ZS/Agj6U=;
        b=BVklfFw4ngr1crfG/IZxJSUFVf1le5yg3YelaRDNJmax/MkkzxDrzJqyx/4WtfpOk5
         hmhYFJGEHNHToKU13cZYGEhBt5qbvTgKqOoNzYuWytZhQYoDrj+F8X1qvgB4QMO+ZfOd
         dGJMHTUK3oSDIL4IjSeFE0vbjKWGM2zH5fnj+rSLEuaxccaQFWvNP12prk+s9InVdd2C
         +91g6ibVdtZCZG4CDipB+xtqWEPY3b8LadaV+Rlafl3o3mSC88bCEfbXY7dMqoZCo+pf
         HZitJy1MD95foCfj1lY7KcLU0VWzWqmoH7XTGTmPB8uukd1SMuUN6iBqXRhtL3Rplh7q
         Q3wg==
X-Forwarded-Encrypted: i=1; AHgh+RpaC9xqoKLslnqfT4ykEezBhc8y1HDx7wdw6chjnrYRIt9VmKGVIAo1YE+BQ7ONNZ8jn3nsS1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdKBp7v6DboSDNFK6HB7Q0xBpb1KTunuGnJ7Oq5MsT2BOVDw7
	KmB6khslshNDUtfthCOr+aS10hIieOQL+5/yvDyOJTm1QnDp+wF/j+XyroYVCjM6E8M=
X-Gm-Gg: AR+sD10Aq5fBklTeSBlRpWb10v0Y3ew4xfZOlDSy7VNrkVe8SElxqqJPvikt54zECRy
	K3UWGhIKGV744nts012afo2r6fLT1IBkcQssb4KcyYcMesQ2AK9wk3WcWcmVOHQCEuqoRvG3JI7
	qRY+o5q73TqpFjjAS7ylQ33NoecaZ7khpon4FozjPaox95+/N73cyQP56Q6VqE1NT/Ci1uhCQyK
	jhx+CecCs1XtfQTKtr1j9sDu2BNSjMz0FCCrAiGmJk40mx6H2eX6sVCij2XxwUwN/U2FYAzszz7
	Zqlzg2h22ovaCqmoURW6Is0v+gbJqLOExGBQEZu7kAEx9YTxfNqaiK9idt2d1avTu/UpnmaJ9OA
	CrE5FxqFRGH13h6xtKlhv/YG6XGR9k/ebrJviZ6be3bEglDHBfeJhFNemAsCc2vYJ55HAGpc13L
	XJhZbrAqu6aWVJPHx7Ix7UDW/aD4Ty1OJNBIxxkLabhIVcSPIvJo1dVrJCSx/yrKrJIFWQDA==
X-Received: by 2002:a05:6820:f013:b0:6aa:cce3:ab61 with SMTP id 006d021491bc7-6acf7faaf82mr1374038eaf.9.1785446387072;
        Thu, 30 Jul 2026 14:19:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6acbc29ab04sm2278140eaf.4.2026.07.30.14.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:19:46 -0700 (PDT)
Message-ID: <640ad2a0-8303-4478-a210-45fb3dc9b1c8@linuxfoundation.org>
Date: Thu, 30 Jul 2026 15:19:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260730141444.267951807@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 08:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.6-rc1.gz
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
