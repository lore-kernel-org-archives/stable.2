Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70A3CC9EA
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446439; cv=none; b=Vrz5WzCQn3dm746QAxcGJ+/MEnu7rAmRhRoiY96q3//EARIuhnW25WIOURk/Z85IIlUO8c/N6zgJiRTDGGtgRd2qLgk01P+6o4SE1kKcY78TEI/MnoWy5AvzV7BCyulpZlYXfiJVUQ1S6P8wf28I7iPeR+TGVHIRMa0oM061PQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446439; c=relaxed/simple;
	bh=zT10JIzlCbI3uWQxtNeRi0PuQu5AB2ETLq6smUtHfRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0DPcLmSKf3FkkmQtWPKMVRtUNqeb73t7Q1zcNmFDdG9ht8wIc8uHdzSVE0OdtCDno9Zs+i2kEiPHkoeQA2Q6XynrHLQ32ALRxau1kcUZ9iPDe0+kjhj7GOOcJKhspphyHzH74Afv8hzh0vrbmoxuSXfRq5Y+ba37evZ5H1EKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AOjLafYR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AOjLafYR"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb68bdf53aso133535a34.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785446436; x=1786051236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voCLBuUeQMgrtWerws8E6SbHXuHnpUq0yvX2L0ODNXw=;
        b=AOjLafYR7BPNNRILIOagSPFoWESFb4rq6IM3kVaXYyBVVTbcKgIwGOhkypkgddVtwy
         UaJ4SgWZge4BV27W6cZXt7UXIZSe9MknE5u+qUADQCnyW7wl11DxIQQFscew1jVPwQCH
         ImxQvkffeDdgX1cMbjZ0xWHn9bkBNW1tfcvOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446436; x=1786051236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voCLBuUeQMgrtWerws8E6SbHXuHnpUq0yvX2L0ODNXw=;
        b=Bp/yWQzTrniWicNARwre89HR1R+Ni/RUY1mngd6sALKQ69vcIaqpRu79l+shHJsIJF
         KV4w/0oky8xn60hWc2CRgD9PgTBi3dLcenEFciMHdoP7kMBlIlNsdvntE8rCX48kUfyB
         66GA2t/G4Lo94cQycefh7hRV/XRn4owj63ukO2rohAD2PaiZ5va6mlE47zDN8kj1lRbY
         aqTuAtp/op/hn3ZIGnSKQmfkuM3CP1MVptxk6U7Wm+F550rZg/v/U0gM2Yp4cResT5VB
         OIQZoyv6sujC8vkjZuLFl/LTl51c4mcdpjFrt2MwFMVzBpQxrg0o6w4aeE/GLa551T+3
         zBKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYpaQDm7dYXwy06zG4dVmwAzKl3Hfk3QbMo29N4zNhremCwGNBpiIvOoR6XU5nrtkFlTHbc6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkGVgStPP7ud1Q1ImVkPUKKDENeLKHGg+TchxOT5eLDkk2+8z
	mYeAujodzooXWub/2pTBk8F6/DLUA2YBqyi5fgKvK/ERHHW6nFREGh3S1cS2JyNHk1k=
X-Gm-Gg: AR+sD122CfWj6IAnIdW0yGsehNbkNmgvu8i1GVnj3P9HunM2lag7cy2UEG3xkoLWoB2
	DnEZI2q/Yel0WVhaKvurhMmPjnGJtGr7JFEF81Ofp1Syz0uSjGcOp3ycyK16od4VmrWJo3BfGQb
	yV3pWFcGfV1qLLaAISyP6haZxVN6nNH1Xd/hRMxdy37bOOLlBAqE4HcIr9J5aW7SNKfJnbTUSdf
	Gd6fMpIGFR375GWjbbiUd61a2GVYk3p+WHzjF93Aw83iJtlCRExjE7Amh6SgqAbfIRew7bhw8vG
	3URKGSyU059+hx+5KQ2k0tgt4zDrxTYlryp5u3AAfRD8IWTMq/yIYKcn2/o26CWe0P1JnwvcZeV
	ig/NDR9ifin4DH+WL13fEYGyiztBAh2KR7XKoes8JUydJXmAFPHmx2xfLN7soTNp1oEIh555n34
	LqWbDAO22LLsQRNRHfrj7fKrG2kDy4jnsJPhLUzj+P3cOiH+dMIiCdvr5m2H9DQAbsk5E6Gg==
X-Received: by 2002:a05:6830:f95:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f02c164df2mr3084911a34.15.1785446435690;
        Thu, 30 Jul 2026 14:20:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c29ceb9dsm3150856fac.14.2026.07.30.14.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:20:34 -0700 (PDT)
Message-ID: <11e028da-6541-4414-aead-0d218ac2cf8a@linuxfoundation.org>
Date: Thu, 30 Jul 2026 15:20:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260730141445.110192266@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260730141445.110192266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 08:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.42 release.
> There are 675 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.42-rc1.gz
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
