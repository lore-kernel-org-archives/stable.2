Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B83B1B3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703952; cv=none; b=Q6uDJO+0BniujvTRQ1ZRJ6lMmSQvjplXGjb8a21Kv641eJ0VEal6QfU7l6k4OXpnfn0L/z3UWomOTd3Wsu6RRAJVbDRmuEqZQnFINoXbGfJ6HSphDw0Sii7BxYJLVt44Cc6g78DAHB5fuJWTtC/geE3uz9SInlW9MNO5NLpjMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703952; c=relaxed/simple;
	bh=6EPTE+PvrSWJYJ19AnsEhk14cTbrAiZFrjKOTIB5f7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8PGf+uXq0/XTHpAZjQ9THAVt1lJQyGP79f0NDpru5aTh33wcFTvgwUmehXONfaWHrxXQ//Jh6/kS1YT31P5jDv+hT8DHni8c21Lxa6/euOPk47LIr1fFTEKkmO76rK80rHYVqTy9HVisVFdhd4PdmuS9CkTlEO+Q18DZWEodVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGdFDn8X; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGdFDn8X"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b28d7c729fso343918b6e.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787703948; x=1788308748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXT+YTQDfQ9AsMeTnldVKDSpywj3RSfjjaW3cp6Ogs4=;
        b=LGdFDn8XveefccO865fhALcK/VQCtRBimc2PjJDGKMShx0234kYdmAzHC2Sfo1LsIh
         1yVmfREI6M3FWoCikrl7JmBv6OF3HsihsIasSKq884tAhHrHI6Pp5wY+HQJfqMY8m6QD
         GDso4M13scu3EqvUo0jIdoeDT6lEaH7MgKbWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787703948; x=1788308748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXT+YTQDfQ9AsMeTnldVKDSpywj3RSfjjaW3cp6Ogs4=;
        b=PQrhjS1PvjnKMkIBuUK+oTcjvHtvAGVm+Tq2oaDnaicDRbz6ctK8vzVXvIbGQpFaeo
         2uKJxw96d8CSMIXgOXHrHbYeyBMQuycLJZJq6XqdUGtLz/PggAG7R6rpY6THc7MLJslN
         3jGhd1WcZ5J4+Y2rhoZtVqwB6bqIeJkWgT49TG6Ea2R6yS8IMtK9IVpFgxOsXrwZW51H
         q/XgzhPIO5JAhZ3QoT4agoYMyh4G4KGgKqcGGxGX8bIIFNHrkHve91YGbYwWKj1CAJFX
         f6JwDHVpp3po6PhIM7y3EZscm1OPU7n1Ck+glBCQ3qtfe3/B2gSKEYmMWvdBzIPBdGTj
         U57Q==
X-Forwarded-Encrypted: i=1; AHgh+RosK4StNdMYYWit8IWjjkBt9p8QgwslZx8bSBEKRgga6ZoDf3d5A4OXYJD8uKLgzQMgQ9OVIDU=@vger.kernel.org
X-Gm-Message-State: AFuF++kx+/la0Tl49VNpU8W/Dspf9cN14Ir0b47uRq0PMI3RagYmBnyp
	ZGXzVcqwn3HHvdBCG7EOLRXgDgzqHeIBalO7Ypih7gHSCT+wpXEaL30HltXT4XWBkxU=
X-Gm-Gg: AR+sD11vhqYZ7b9XVYt9ZZ+Iw/a9JCIWaUhpc6swjWkI9VoG3wJf4pYkNUiyQ42cXGk
	IDAcNx7kdEY8MDMnzN4hMXqWGt9uWQYa2zgO/25vhXkcsr+FWyYK2haN9IFQPnNBFojuAScFzUe
	cq0CJBeHbaOSNocRCHNL6ekoYym5gJnGYkOhkiZnRWouthT8TDbYZDfv/63GpgLHFKqqi7+ovvj
	TLTTvqB6ZNUWQubLlarPc/0pt7PbdzH31yXY2y/qCB6CsSGE/47JRYGpBE8m+CkYDRawFIxLKoQ
	U7e/+r2W2YH4f1253C3bNVfuMmnf/d6tO9enYJ6VIc77vG47KRvp7iGzb2DvKlHURRn8HoqKN4H
	Zx/341orCZatDbeq64GqCVaMhE7Dp0U0X+iFbcT3FBJqQUsJvisBLUObUwVDds2rJ7PZo7qfaFv
	egrknwTpOQha/5Zv0LakGLoIEiteFMeMgeJtudddsnTtThNZbcXVTQEJZ4NNT+AsME90sdeA==
X-Received: by 2002:a05:6808:4fce:b0:4aa:cad:cb4d with SMTP id 5614622812f47-4b366c78a5cmr3592683b6e.19.1787703948248;
        Tue, 25 Aug 2026 17:25:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b36a7506ddsm371339b6e.4.2026.08.25.17.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:25:47 -0700 (PDT)
Message-ID: <8a8b25fa-b7e9-4ca0-84ce-67233490fdb3@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:25:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.218-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.568214149@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.568214149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.218 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.218-rc1.gz
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
