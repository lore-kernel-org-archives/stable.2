Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF0284896
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149513; cv=none; b=sz+42t275Mn7jvDS0RDRRDafvkZrzlnT2XtBSsG2P5fUzj3LHacGS9vdl5SOO83EtY5kflLwSbbM/NDENmf748tZlYDWGed9FwYu8VX0Ahlsia4je+0JNm9P/2SUiiMkynh2UtEUEPpZ4kzGKRfK8yusnBCwphFxQuZQfRRo8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149513; c=relaxed/simple;
	bh=Yi3apHusaoa8sda+E3euSgrdABkSXubVEZD5TKsM1vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHuIw77PhT3poiZnHbPMr8B2I36K0n8jD+ONfXI4KEAw9u2qMuqb0EtPZvPtbWVMpYf0IzN4nH4kgBnxntW0UADz2/lGn+fIOrZDsngiYqBmS8/rfk8T8JSpbAGhnhi2ym/TLw4cu2GROHNsQJhBEKtbqhtz3tzU1goNWQItlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJvPobAf; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJvPobAf"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so155601a34.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786149509; x=1786754309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9FQoV4IbWecbqvw+TMh5taUA4ZJ+Y22rOmFU2DLpiE=;
        b=DJvPobAfpnJtJj7NAbP+jNaddcw6KTx897be1CEinx0rgUOrCDgIo4AXdcMJEKCAZy
         fVsxHP9BTSCdRx2Q+/+VQHpvRduWkFJ0pgg1LmvjhvULt/LfOdP8cC/xCm7wN0E0jlci
         VDXZ726UWVLgWZu2Go1i+eLiTzE8tNxceb2XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149509; x=1786754309;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9FQoV4IbWecbqvw+TMh5taUA4ZJ+Y22rOmFU2DLpiE=;
        b=nLbVZOV49IACvqCIc9W+Ehj229hSXllFrGB6uywaOhmbLM76NpPQIWqFPcns9xWyfm
         Y6H2053jgtJeHrvYlDRFxJ6/eHuafet4epDb5Wt1/2NkQcuLCvKTysRA4ST3s7TSlgFr
         UAQ4R+MvhgcfzlNtYzdAZK0Ogpxwpm/bx7bDiwUYJ1GH6vIdJefZ49nejXXtb/YqumdF
         QkgQFSXzohlB+Bl2rQG46N07LzFqoLHPbRGpjHzjZVzGbW53n0Na5awomx8G8kK8B85Y
         jVOxb9TGpVVlQuCgLTOMaI+UkMKEQqCbGMmmU3JKyByMqpOb0WcWO8Reh1oHnjex4gAv
         34/A==
X-Forwarded-Encrypted: i=1; AHgh+RrKeba1VfOKY0DuHeX9M7ruB/Skd/9KZRS4nh5NcgtC5YsLXX7qQKSo6OHQJGXtE9zf0nWvoFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTe7r+WI5TYeYqZydbC0FOlIdC1yzQAeO5IoMKdD+RIa6ESRu
	OpKnpGPhKUq+sIgN3irAa82MrE/95EK5U0C1kztEyeuKVvwj0KdeqWruVcmdFdpwFUg=
X-Gm-Gg: AR+sD12lCu1T6WH8XN7e30WBOfN5n764efWxE4LNCD5LqGZOlamJCZfx9qBpt52CKa9
	l6DrxXpBihhVIglsAlVyeuUwtVeJiaJVKjcBiT2rxpU5/i6aOpKuYTXAsoz7TM+Rr8MsvNL9aYU
	r10K9B8JX5TwnHg+siTGaXl8HpItWHimqtiv+jj+YDleffR2IsV9S49FRYY7AMoDgRxK4855m8H
	K6Z70vJ+TNtVKQUOAawTLjEoYc9WSer1oRQftJvHcxF9IWOHu3tV/kY8THstypUNcCmz+1USRbE
	Ut6FB0CDklSiymkMR58U0BEN5HEZHUepEeNc40hHttFjjbrdVT5XDdaYo8S2RZ7zJbHYwB/rqt4
	a58d/9v8itTSHlwX+Q2IUGVS696tIFLr8ECH/WmnQBFPEhKt2gDClyqNMkzkUjC3Qk7L59fs815
	98xhHb0u1l3VehJbyOW4lmbdasgiqqJbEuKI0dbFtbIIhFZG/89hCTj9+ut2pz+zyr9+EmwNtIM
	LJZlz26
X-Received: by 2002:a05:6820:2918:b0:6ae:4be6:64ee with SMTP id 006d021491bc7-6b0421f92aemr2421437eaf.34.1786149509450;
        Fri, 07 Aug 2026 17:38:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bfca2bcsm3617439eaf.15.2026.08.07.17.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 17:38:28 -0700 (PDT)
Message-ID: <2bc86579-1882-43e1-8bf2-d87c8b37ba8b@linuxfoundation.org>
Date: Fri, 7 Aug 2026 18:38:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/261] 6.6.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260807143415.358597922@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260807143415.358597922@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 08:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.151 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.151-rc1.gz
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
