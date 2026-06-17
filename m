Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0833368A5
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716514; cv=none; b=iPNlcTr/l8LN2b4YM7j2IrRJGO5YkGP++cdvr+R8VSPc+X5HVQJ89V5auwGNYD4ZuQ5muQ/7cYihqQuwGn7rSkVRIuhPX2Hv5Tzvg98RnsmB+BE1tE3m0MN22EcVorVrG9C8+ExqXxwFlepiSuX/iWp4LIw1/pfwVWPNyfFt4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716514; c=relaxed/simple;
	bh=DfopIBMX/TQrYURkHA/8/q1uNAzuMF8sUBfrpC3SFio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVzLEJF7DgYP6LtkWla2Dl3t9J1GG3mYFPronGBA/LaBSF5TZ/lFkubXjurlCUkFaCM+ZzXheOUEVvWfpnSSkO5cGrz3TIbu9eLUxNLuHOZIuDHUahKegJLF2akP4ObMvdJqSlX3CvUXc0i6qpoxg7FgHQKCNlMlM4x2OfPgTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NY9qIHcK; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NY9qIHcK"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6d37b7098so5355a34.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781716510; x=1782321310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTV+yTlG0bYfe+/PihUammSNlg4bVXG5fdMlVuGlrtQ=;
        b=NY9qIHcK57NSvS2SR/CPyrNzKhoua6LtAy8jR+ILI5Hh0s01793TH/D3rAuyvteu53
         xJTq+V+x8oxxbrIFdRvY0et4iXja+TeLZvo8FXEGpnn5EcEK4ixmicvQPyUjVa/RaVIp
         rWc35M8F8Hl8/NydAc1IDf1uTMHm2lTZ+cqlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716510; x=1782321310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTV+yTlG0bYfe+/PihUammSNlg4bVXG5fdMlVuGlrtQ=;
        b=aM2eu5JEMtEurR+uddtEy3Zu5EwG6MQxwkkweZYIWF6JtqXyWAOrNzQvyCdpSzIbtT
         g+dsPVUzZw8F/xsoVFOwDZqR/T+d9zULgdGhpyWbNUvhA2/mGLKocamNX6oXBgwcrdUN
         yr3WVu4DrzqD1/oIptev6hvX6Wu904nSqBf3rDLkF3uVcu9INZ30DqL1nUtEAejqzRBm
         YSQDIGJ6M+3n4h+APidLr2FgIWI290cDZEiHQ9KyZwrCdeUJ9koQBEvud8zt5dztIYc3
         Hduz72MmxPN9my+zPffb6rEhQtFbjaW9RaQFidchpIWQDsjZDrm9DPQ0e3caxHtSrxhG
         CdYg==
X-Forwarded-Encrypted: i=1; AFNElJ+BjDz5SUCCyYD6gir/KkI978ZsigtMpcn0Z5xeVoZfJkbaeg/DmPx0H+qVNHHVqzicQFxgmWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyVeFCOGWHPciI/M2LlaPPfv6zlAYCeILU2xqgywkO5fEYDxP
	0uBVh58FSuQIvxZ3Mtz2Z9DjfpsQg09Gk43vS5EsT9CfhDDsQ4H4XamidnL0IWTB2uY=
X-Gm-Gg: Acq92OH95Eb1LsdtgbZo1s7G+5nP/zSFfGrYzuomumpen9kiY5JPAwLqwatRI3guHu7
	6PrSP3giAcCGZDINAMthnc+1kJ4Ysosafx5PZwKf2/Xn5LlRJgqnpeog/IzXOUfk0pXPZVwfOVO
	/gInUNPzI6kbopVtDd6oWy2f0jvEsl7BklKCAZimO0s78/8xBhUwf+HZiRilwfTT7kNwcbO5ITv
	6IqfWPSI2RYejdBQFn4NvqgkXBfIeRrRPsf9l28Xv1nPQ/cSa/A9pi7Pb6AzA3N6c1PAJzVoQp8
	iWwL+IJYhqDwRMX0Uklh4S1OZ1H2grUIqAGM4QEY2qkItHlku1IIfX7Cq1q0ZX6tVUrJ+kfiyZ8
	pgSMkvTDO94ktm3y/NueJHwvlp+W0O5Q/7Ayxu8aDs886Rv2RMOoqJ2AKAL9Vp3e+3a+iCJ0+Xq
	AJ0RhM1GzT3+E63GAlHCBN
X-Received: by 2002:a05:6808:178c:b0:482:6b96:5ad0 with SMTP id 5614622812f47-489429ace36mr3857167b6e.26.1781716509971;
        Wed, 17 Jun 2026 10:15:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm6566221b6e.1.2026.06.17.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:15:08 -0700 (PDT)
Message-ID: <e112ac49-e518-4efc-b481-a557ee929ee6@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:15:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145523.335696673@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:55:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.1-rc1.gz
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
