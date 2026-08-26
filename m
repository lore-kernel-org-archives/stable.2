Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACF1862
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702708; cv=none; b=MiyUBn9Kjc9+KQ+c3lYKwwGrOBFKtr62lIEpgm5wSD+ZIJkjyi2HIDzY7Z0v+zm8xl6dpvokJ9XhFgaZkHj8p2qEm6Dwhn8YumZPbH3NUyu9+xLZQ687bYwLvwlQVNPEq6SBY1iolrUsuqQ/l1BWX4tkW1SBpczUjwTkF0ge8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702708; c=relaxed/simple;
	bh=6Ry5OlI3DAvR+ZQ5L+BY7qSCopLwoyQxpYMx6yvecJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/KlQZAVBv5KxJs5KQxTEugoQ2p8F216DAeSEiNreu5erCJWFgLrzAzIsNxdIjsvTOjxEsDeIrSzzy0zAs0hi7MVuJX6qyUpikpzmFMa0dVjAB5Dq+Y0Wg6c0TxOYVVdWqVC4fX9+4DaIk9G6wJfYk/XGVeD3YXfGzgpz+YGV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NDv7/pfc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NDv7/pfc"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b190cdc9feso88143b6e.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787702705; x=1788307505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztvec6OqI2y+QcETTkAO5HD4apNeH1K67L5ttNvGvIY=;
        b=NDv7/pfcLVUPO937zWINVRrd5l7ln8Wau5Srzlw7MAZ0LyMyh4nrajzO2TyZGL5UrA
         HpWPAmUcotWPboUrmqc+1nJiXJtMpagcEuUEJks3xuH9ZNg79kLGLGa9BKDKfd212e/i
         +vOw9whHYxw2JlVkickHsEGoekC1pkAyUNlvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702705; x=1788307505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztvec6OqI2y+QcETTkAO5HD4apNeH1K67L5ttNvGvIY=;
        b=GcTxSNvfTKRsdsHZZOZERxRbsmSqx6GFk8MKnIrNlgr4JyL16NEWpdw4OzjBWk+7EE
         yDcIqTTqg/duLqdhWpFIEjJhgE2zZdgw/WA2z0x55gJwq1fzPEW5ERAl2AEji/3fRs9J
         O2hSjvdxEYCS4BStXPhsKZwX7YEg5+A1b93fonw8VGlCAOS2xXbDXKeZjrt/t6sZsKoZ
         19o88DPex018imdPnWLa5UK8rNvjL7kXb7erdKyLwTQszp3mOqpR7+JYu9NO+qKHgZB3
         TdIpjMx5K2WEor7bSdpa9LCh/3nP/yJupyA2JCKsB/UuBdhNyiYZ8k7SrUSQbsn6oK95
         GZdw==
X-Forwarded-Encrypted: i=1; AHgh+RrqkH1ym/01fIMaaD83I8nd+QQlsTvg8WooRiK6TfrxBDbLMcqIUPyzyUk4I0RqF945tgCCgZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nta7rWkNBDKMiqy7/+3r0HLs0VhQgr38Heg5YwFu5GPPLPjiuS
	vxHU5k5JqmeEY3e1kyXwhtyvaic/5PjTzLvG+2ZOGI7FrsKZOan2JNYGWvt44GJYFaQ=
X-Gm-Gg: AR+sD11Gx4b94oUETrsUhbPNaW9aJ1ORfx2EFdxaPBu9xD0EDoshbIwdmeF2v0DjvV4
	WIVjS+p8lBEw9FnhgkiiDI0KUbZxIwOXelgziRUEQ2jKceSqyfBK+e9QakbCyK6q8nVirCQOxjm
	NWPRegQ+ZSXUfYP1IMUlFeKVWP08jAjz2vOisA3CRtnjoJXK+KCqn+nAUxPYmQeBl7IJpcKmCjJ
	w0wHCfYj8hbeZszjkycGOH82zVnsfN3/A0r2B8/HdCFlHplmg0DRwOuiHv2O2du3eBwPZla7Oce
	lr35hnZBfV2eupip3JdP4vGHAKYN11UifEbu4zNZ2G989QVUB0I5AcwFUqH7t4AtrX7tRNm7dc1
	yZF2jYNmMrFZUz4E/v/k9WO/G0zQJGD2PX9Ve+MpDkI5r8XJ6eqDT0OfxiKfA0N7c4Nm3MxlQuw
	iCMJxPQAmh8EW+Cgb6AfW/vvLS3yD+3xHUDTrIOojEqa64/8TqhlTYcI58kMZ/kYmJnbYT2LW5J
	foDvYkG
X-Received: by 2002:a05:6808:4fe5:b0:4b2:5529:ed3c with SMTP id 5614622812f47-4b3668b9c28mr3926595b6e.7.1787702705584;
        Tue, 25 Aug 2026 17:05:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b36a7506ddsm338061b6e.4.2026.08.25.17.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:05:04 -0700 (PDT)
Message-ID: <6c3bd5e4-218f-480f-9ec5-bf8565b33d4a@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:05:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/94] 6.18.47-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.887883084@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.887883084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.47 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.47-rc1.gz
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
