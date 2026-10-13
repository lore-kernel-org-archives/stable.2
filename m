Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E249B5B7
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916457; cv=none; b=RKfzYhZtSDLF6hPOsjbdcxA3+Gv/5r4oLFf0QPNww3r2t9AjjyfcQWvKrDta/afn8heXYt1Tvu9gF3XBNWIZsWD3RrrOyZ6wpJhNKSluzz7MJW0d8rEg93UpNijsZYqGBjVOhaKSSzVc1g3xxgWfTLEEsJLDKZCIsyvHMI8YFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916457; c=relaxed/simple;
	bh=gebbGvmgTzGyJx5X3pGdjNejK98oYXopgYCQYWylHfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpoph4nZ94kQkAM9AmWwbpCbe+ciSN+5S5HC63gG9V6r1u3IawLw4EggwCzbwDPqw10Z6FeMCdWzWJnEi6elrrQsO+GBaiJMfUOUgP0NbId52s4+YebyZR3V+sL0gFa/Ehr5AbdW0/vCibL0Z2EKxob0/+WxWrXmW5Wbl89M9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da42ybrT; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da42ybrT"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b52ba422cso37667446d6.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791916455; x=1792521255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBk9Jd0lNDJeCaVR9wht3+TY3PnWo+nDczzO7C6GQJQ=;
        b=Da42ybrT0bVHGNPgqt3mh8KHJWOu0TQAAVHza/7urfTU2E7PCYCSoELXT51EOe7ZBi
         61wNKpRc38NNnfSC/mMA3utv8cjdv3eTNW5E0z57UWPTpKm9QNXIT9WNDU6bEGa2KJlQ
         5Q1YnmSJxmiYw7/np0L7K/p5CBUskOeC97xojAUD+JcdFuDK34F++FEyaqaE7GZ58iiY
         5DDcZjkk34N+ZOQIS7JWjfpm51Af3z+ZKtd44Na6sF9K7J/9L3DLJfW4phXLAd6odt3c
         OTww1TgmNzK+L3QDvFe/TxJBaAZZGQxYOQrPiBD/IML73/5SsDRIuYezH4K2sYcXapqK
         Ceug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916455; x=1792521255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBk9Jd0lNDJeCaVR9wht3+TY3PnWo+nDczzO7C6GQJQ=;
        b=CUKiOldjVHcUWSaLoE6uUy5KmpAqS4Tf21TX/Cf/WXUMu/6IJngv2TtifNilAll9+U
         SVIFNLYQjJ02YKq0ugyWMpyhH/fk+uQ3yp/FMqSpUI4x8YY6hCWtLcFxMmuFZubYbXmS
         goHrc19l5qn5uljdqMdKIAl/d3pVwTjqmcFJC7HWf+XM9bul5VOKz4nIYFx4tPQW83w9
         U6SF2qbJpuxPA/FjlKGK9koIQVyXJnsKGWnShzUYVKzNUH/JsIKGDrClloDdS8J4qmys
         Iqm30fFTIVzMRd8RgGmRc50EPmYrkbbw/IpTxsVJYXkBIjNDuCQiVrCtja7mCgO7hhqY
         R1IA==
X-Forwarded-Encrypted: i=1; AKwUvByUSQbkOpSZHLBTMrXVVOV9augpCMzCUAHehMfAT1w9CP/nvzZAi/vZM+Q08Xkma8PsPtdBGro=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBsNmx8BoFFpIFRDfcA7Kx/Cz7BtTuXJ4/nwshNl/rC18HLScF
	IFpp9F2SWug25FVZnYZPEgJRtQZoaTjaNXljQd0asFyak9Z0Sji6dl4p
X-Gm-Gg: AYBFou2cWwlvgaZ0ejhhbobEj/Py5not2I13j8vVwQVAyRAcK+rY2KqwAx3R71KI8ak
	6eib6bKUu2+EX8SuwCi0Qu5RrZ+j3bdSnH6c6w9sXjnX9mnKTEYulkPHceqs5hdOOarioO2wYlD
	fr9qUt6eZV4oZn1kQTnbOvALHqhD+isFgvcO5p73l8JkSWIRbhArHlx1NtSB0IkmiR9ATVl2N3T
	63csCoeBG0P5O9pjcxoKDLGDDsRrdmVVQtgOoaiq9/k4vlHzenI9KT3t+RAuPkjvU2giVm+P34u
	9LbAkKlqormAyKxfXsknUtaxvEYjmtwyChl97OX/IZMvipYYXmTghYlOWH1ugtiaBSvM1y1ZI2I
	DS2kV/bqoazvngwhhZy4tk58Fqwzz159h3NwBPAML4y3OydSaTFFsx+2sPWuSGIXeHyDzJoebFy
	NWHvm0o/nMsBof1Erd919BUD6VWOqN7ixZUFqOTr/pY+4wIq12MpnIjE9vq7gwN7wd/QAOei9zD
	Lesi6pI8b7d15QmSelQ7DOq
X-Received: by 2002:a05:6214:2b8b:b0:919:5ec0:bce4 with SMTP id 6a1803df08f44-91b55576506mr229759486d6.37.1791916454936;
        Tue, 13 Oct 2026 11:34:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b92b86sm32027046d6.30.2026.10.13.11.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 11:34:13 -0700 (PDT)
Message-ID: <c2380f00-6070-418b-8fea-5c48bd4dff0c@gmail.com>
Date: Tue, 13 Oct 2026 11:34:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/497] 6.12.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261013112907.864180619@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261013112907.864180619@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 04:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.113 release.
> There are 497 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
