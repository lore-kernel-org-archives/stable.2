Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553264A8D
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702571; cv=none; b=Gst/oDHKTpIbGDZy6+qx9SYrdKDACTJInUF+pDxBsqIUCPh9fi+PT+7sLpNyDIgIC63e9ZSD5RVjAUQ/AtRy8KB/xGZtEUfy+4UtbRNlp2GV8JtYqF6P9NodwAuM20G2A1H5+0Jzns/gu8+h1HKwacmvbFVzLCDgV2dhoLmDWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702571; c=relaxed/simple;
	bh=ReTXM9ynVhZlhP+tUhPkijcFLiX/nfvGB2OubiREl84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSD0Nb4kumFirw98nLUiSj1G0kE+gXendxkW1aJzjWNEgUMI4QYRqslqKH57qoMtR6R5lOX4jvhnp30GyjYLl98gfX9c4PNW7KnTO5BK/LqyR84QkxS8gCrrH03bD1OUTNTLzir8KvWa3yH1wnBej/TCnfZvH1Um1FfZh+81i58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhQoy0O8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhQoy0O8"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448b0ff4a57so556654fac.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787702568; x=1788307368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDg6Q8lfyspr+N0uaaIRNBvtV2V/3UQDK74a3w2PV68=;
        b=EhQoy0O8A64alKAJS6R4iNwgdYuwAVfJexshM9I3p2IP8bVWODVVpKhrVT/GmERrgV
         N3JlbrYMkyoFKdzm3MVspV8MM7idoeaujngI/FqB/w1ewif/jM+gsPfYThxXu4NtYtwS
         SHPw4JrfIgGDTqv27qYNUjSOJ4n1aY8ApittA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702568; x=1788307368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDg6Q8lfyspr+N0uaaIRNBvtV2V/3UQDK74a3w2PV68=;
        b=UN5/Pz9p/P6Q6hq+mGlBAVE/YOh6UlROqxK0xXDRfUqQVCnjq25o9l1XdObbRHdQOo
         XSOPaY8mI4ouTV4fXqwlY9ij841wPL1nm7myiNuBslhxQPTyjavFLLR16dVePrZMUihC
         3FSwFxdGG8FGr/hEimFR5DEXBm16gD35RrYoI9opwZcCjRIPuKf/PiB1vUKlFKNfKR/s
         B2oxHuJ9FSgss2ARJeU667MnnWQP6m/KzCh0MVaHA97IvbPZwSUMvYQ8f1FU+RwbhK7/
         UOHeUzIQb65gQ16ulWvfYi9uH7xuXYcexHV5/JHoyR0K336o0gx8cA7bPSCTBBuaHzbz
         i1Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2TfLZXmBjDOHPVBR4e/wQFknnjyX7UF1TwTdemkHc5cP070iE4A/GAmEvf+MoJDYnyokF9lk=@vger.kernel.org
X-Gm-Message-State: AFuF++l4ddw8NAkBDqqIfLoeFs3xyoYwcy6aEEdymFfQmvZT8jsYvokF
	+7XrCAvlKOWsGLBznUy8cB19CHZ+m5+4SEsD8blK3ETWL57lk4m22HMznZcs8Hc22dg=
X-Gm-Gg: AR+sD13BdwnEAKvSlqgwCHA10nGFKYk2LP4eTjxW/aYxUIGuyPCIK6kAlXyAuIzf9Q4
	CWftrRQZJmakbvMBxDGpef7hjQQXynHAQaqufncpO69Ba81HGR/AoSup2YvqGkn9wo9HlzMSPOZ
	4r7YBjdN8xN3/a6qWXXSVW6ZVSSlwCRBiccW3bOUnvRff/VlIUjyduWEfT9dQBCux6U9U/HsXF/
	CzDWCdlP+7DuR4tqnbT9/aS8zZDnP0PYXp2TLSkNrusC7S5H5zAjMGzJz8GuZpv+zbdyTDG1MIp
	9IoVR94aS6Awtw5AKM/wQ46oDCLNI1BU61O9a7KN+olXqp1rcdSb01Jf5wHjpM+3/xGeOD2MckL
	o355pBHn8wkKOrpS0gDJNmAU209jRj4gp6EyKg51Zt86Q6rOTxv7gp1DGtiQj0Zx31fFDvBGzX1
	ztGbV/KeQDfUTQoMKPaDGg34H329V/KZlf19vCgUxZPOzx2np93SHnNmjMTtiBHuSXaMqd
X-Received: by 2002:a05:6870:a0a2:b0:456:4c93:a7f8 with SMTP id 586e51a60fabf-465981b1c08mr3490510fac.6.1787702568147;
        Tue, 25 Aug 2026 17:02:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465adf69375sm780609fac.7.2026.08.25.17.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:02:47 -0700 (PDT)
Message-ID: <0dbf9d9f-f01f-4e28-85f4-a134486a0ac9@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:02:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 00/82] 7.2.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.560541185@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.560541185@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.1 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
