Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469B43CE55
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740707; cv=none; b=aDfGzY7doEC6K0fjuXl4Q4GluOwPguMFU7QBIOlJmjsxCTzsaCwdgk8mWfikXK4ZFWaSvkW6+OKZr0/Ga5rh2e8R/KrK3MfnPkJn0FE4vhAcy/XKS7SIILMYpXx6sOHuZCH+SQnwI+c8CeJvme2hciheiq0/IWt3rHTQySZCH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740707; c=relaxed/simple;
	bh=swp9CXdQimYMhmwp1w/RYh5hvJ2ll9KjC09Ba5I0m5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1p7xSY8YJbJ0csGjw2EovXYaQg+zWcbiSCQyGQ7+J1E8GlLO+5xndBUJkNSBX6Z/A1SqkcERyzZn/x2FN/GEbrVT/Dfn4tzyBwe27Pgy9AwKwMJpg31p1JoXt/Z9tGIsMfDCig9UaT1fRN8ny+nC9wNlDrRjARtqLq0C0RJMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4I+APUG; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4I+APUG"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso4809109a34.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784740704; x=1785345504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkGADoG7kLhndNpq/P0s/Y949e7MLNwqaoLrtmet1cg=;
        b=H4I+APUGumPnVOu73QtgXoZE8Jbe6DbGMitMftDTglr1iX9R9zeL94IpNqsA0lu49F
         WZ8QFQv/n1CybxbwYsf+HMu5z+p4J/N1Xi6VtA75xmzHwYdByqkvTijQIy83Rl5RNXGH
         Jpuaew6Ad2zOPI5Z/y+pzur7hlvFEZ9LSeP0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740704; x=1785345504;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkGADoG7kLhndNpq/P0s/Y949e7MLNwqaoLrtmet1cg=;
        b=SyIgU3QYQAWhbgecl/ogQGi6z20GijK97ro2bfJMNQ1c+eW34mVnNlMkz0pHAlbxTy
         HMtX1eHJEgKK66eH5tYe+9cONr6JK4b47EbLiya+N+L9diJvn2uLvASACnH0c5+DAorz
         2jDRtftMZZyLPJ+ncV/MIwdkv1SDX4CGTqtKYLSBOU0p68mxqzkEnf8J2T1U928xaApJ
         9duGrivTT4LooZVuFrQ05URhPfXwuMSG9Bb2FCk0vbas/HYr+shwYdEjoJ/HPX4AKeFW
         PQVubcou3xBSIs+Ow6rmapN3SQz27V6l2QDYv8mudXvaozvnP4l5fMfOCD/zoFzCPg5K
         5IBg==
X-Forwarded-Encrypted: i=1; AHgh+RoS4/fLMnKWFoQ2374DCYLIY7PHQUekR7ZWcI/zhuhUJNwmaazsbC9WTfdlsu/3IyiaJjpPIV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBov6/8rg9NDLO3Kg4tS2Awp1gHLmX9GwTzvZZTaLQBiNGRSZ2
	qDU+c6wkvWHnGg4OEYFwdop7325wtnPsaXbPFTu7dOqyQCIAMBlVEw+dm99RSN9yKPI=
X-Gm-Gg: AR+sD13cEJZDcTWLJFTf6lc89AwvuM7Io1mlRR+Npn0xmPrk+j9yZk0eroRi74anHjY
	q1VFKbdkRetagQgv6aa0zRmhWNnIjlNG7UnZbq6DTHeskTsY6A8iegXrTNRFledWhXG603e9WXC
	SBMCGL1iYCIcJc1OgetW1TdsIWCa03qNJsI5mUgPDI6tk/yna31FhT81dpftjkXGHoRcwVisvkM
	ZB6f96c5gqsyEMTKvOGYMu6d3QpZmNYVSDwZY4kfMkS6Q1jShl7lXC4/kyoQn/4hsh+H++Gr6xk
	gzBthKR0rlrGZqzHBOCwMrVDaRXy2nl0ywcxb228IUhISDHPAHSjBCH79FEQudUe/ongNG/Ny4x
	z2/21+RbQoHcrrHAzZIv8MN3juOSSA5ubhdfYCy29K/FKOP9zqGzX8zc+gzWnLfMqzYYnXAEsL6
	RLXp+ewpSVFy8=
X-Received: by 2002:a05:6830:3499:b0:7e9:e0be:583b with SMTP id 46e09a7af769-7eda073ca12mr12517809a34.9.1784740704278;
        Wed, 22 Jul 2026 10:18:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0f876sm1727222a34.7.2026.07.22.10.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:18:23 -0700 (PDT)
Message-ID: <cca4ecd7-4514-4a52-a254-8a1f77375ef2@linuxfoundation.org>
Date: Wed, 22 Jul 2026 11:18:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/843] 5.15.212-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152405.946368001@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152405.946368001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.212 release.
> There are 843 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.212-rc1.gz
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

