Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4C19CCF7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703745; cv=none; b=EbTZNG8ifmZayBIo5VBXSWGXFe4WrRdOphoGpdpTTbuzy7BTweYYEVmMpYm7f1qWsphhhBqMmv+YzlFaYhbHw/sH9+oWnW5oZ44iucdrzJwJ8lCcr6+BL9KkWvNPN4lnefcKw0Uu5hGlAE/EP5s4S4XbeHJ9a22PZWY0Idtg63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703745; c=relaxed/simple;
	bh=XB1RY8T13jA0T4cjU9BDqQGF3UJei2ApS2wdW+xsHXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkEj1RQYLPe8WC/JsYmgOI5MtOLuUTpUYc9Olt5GaI8JtViWO2XB/2YKm/ebOuzbQHt+VHh1bl5+5t3RGG6s1TrPDzKHsdbj8M32AE7M/89+b8iVF+xobv5HAmSctvqF17JgzzKoccWck3PJTGh8cDQxOsNn00rF7Af2NSCAwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZq8WmUL; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZq8WmUL"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4ab47c40e7eso410613b6e.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787703742; x=1788308542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFB16aiDvphHQjOhP/WCc8GaCWukTfgWxSTCoB27V7k=;
        b=BZq8WmULaoo8hvPNClBQrJKaPD3dWPP9/LrfurU9jrl27WObgVVBIqif5GZ8NkJMev
         D+MBRD7ss7F6QUoMvTRWoWvUlsCWAe/azUQtJGjDwwat233H2TE/TyVhl4Jtuz2A46to
         AjoYSPK/GA7A/iZRHZATuT0TDDIAiX6vRg4ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787703742; x=1788308542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFB16aiDvphHQjOhP/WCc8GaCWukTfgWxSTCoB27V7k=;
        b=szJL2e9lgypsRFcIE8mvz4Va+tR9J04TDyVkfIukZRHMKgSwRW6gaclFQvdDg6iBI2
         R+m6pG2J2zV95qDBVmsz4wBmNYTa56Z8X7OfmytAI1KbhBTtYbNK01ySUBQRSRYxx0eE
         jDHXLjOXH8R6vJ9PVttWO26UGJrKigWz93n3E6JEnR5Awc3rCg/1HCAJbT3Dv3w0Ev/5
         AopGwl+LoSlbmfO7kdccxcEHNDJ5lHftGuQHS6BxnKw3+j4S7ohwLplzM96EPIBAT3vq
         Whw0DIt6MrotIHl+y8o7T0wbdJIF+k0DdhWAk7bNh1dNgICHJleTewUJLMLcqsjIkPXy
         rqPg==
X-Forwarded-Encrypted: i=1; AHgh+RqvRlyu4SlLynFUM+4tUFPDmRiZFfQcIpyV2bVyUjo2C2akLlNZ3fBMCGxqjKCNuQm36vDf98Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lHBhGThWqN1G+4xezw70icVozAClOVm0IhK6a+1h3EVbczm1Jx
	AmUWoCCDXl896n4rIbbJ8z/4G1KxDlXLGIBCLjhiFtBVqZIq+eIhutpB6OiRC4EsMZA=
X-Gm-Gg: AR+sD11ofWNp6nvNBJrOGBN7/Ry7wH2RQmmMynbo4662dka4UdeP2syL4DnjMcSSn/v
	PvwZzozeLBIhCisc/lZYtyj5b2FZhYyvXP/5U8fGJ2ghL4HgMFiYFKkzvhh53/YvVXID+nqLWPK
	I2vnQDko015kWMe57w1hl0sJA4OuTtR/NU7KI5mudhKIWaZq/KSE3L8anK5pUjjogOAq6X0F/Qp
	zFwX78odNJI3+J705iIUmeslhjopPCvZEpO2H8Mgav+W01ojL8pGE0AjJ661POwhcrAprF7OGkO
	fT4HtQ5R9Gh4ISKHlRwQpRF9AVVVmXStU+AfsN9afSSAiIda0fpMunXF+yarAIFxGWPbXpCpqdg
	onaVM/q2EDQj6LkksM/1FvrwTnj/Oe9/lDshICexwCJmsktQhn9tPetOwfVP1Ra048qP5Hpell7
	HswN/vGRSCUAwIB4iHeYwbpbXMS+0hvdx8UFLPPHQzKalgAMBFY0YtO3HycAaeLGJyyeFeTw==
X-Received: by 2002:a05:6808:2e4a:b0:4a3:ff0a:e407 with SMTP id 5614622812f47-4b366b1fbb1mr3801973b6e.15.1787703742192;
        Tue, 25 Aug 2026 17:22:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b36ab734ddsm310256b6e.14.2026.08.25.17.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:22:21 -0700 (PDT)
Message-ID: <905b62a6-d038-4509-a80f-94c73a00dc84@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:22:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.677185791@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.677185791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.185 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
