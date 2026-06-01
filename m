Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C3188596
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335044; cv=none; b=DWCVWaf/TZoZMpru1Xfgh/tnB5CH/yYE7QhTu6IAMxaHyv7mFy9ZGDIOW5NTm1moo/EO2Ct6NOMAsZw/XeczliB1AmyZYJRhStdSdUefqaYKJ051ZWnBUn/UwLPCbRwmhsJq4FxRcCELtB9rcPtjA6esOyTjmtBhr5rBHz8KVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335044; c=relaxed/simple;
	bh=kVfhB7fiqpX15B9e1Tu0EUPsVLPPQuD1A6f1Bf2rIRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CYFHA2K8wZNkyZPi9ui4wujP003BMtssh6zARZ9XEB1gr2ze0NlHPNGsMWlL+p04sEr7b8Modl7qk58ohBcAGas30rkSOxvTU9oM8qZXLOS+pl00vmRefWpD7l1PGWHQ+q5Knnp5Gy14CyH3AzcFmVRjA5OLPzeRn6hZBhiMD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI9p3oTa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI9p3oTa"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91563382988so90318485a.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780335041; x=1780939841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9PVT73NwZV2mjPO8f2HRljt0Q/UvloyOhDI//UxRJI=;
        b=OI9p3oTaHHsW0WBpZIqfJejBv+F3sq4Y4oIyL9Z7t1KeV4Ky9DhNDQUXYxHRp5y0xR
         8wF775ZOLJk0S+MVp4qyLG7smE7oUpaS9C8/5sKNdyY9fwGiY+9dawFHQbO9moaQNg98
         vkmJs5GARR3SvTMLRz4uNvpPMlF0ta+fc1YlRtVBQjpPnzo9uPti7qEhqqJPvvDu37jk
         cqpEVY6P0qrM8EDuVLNIyMKu+Xazw1rqp65bvtKSUUcm2JYTRbV89Sg0+o0C3QDBg7P5
         2JyO1s1kEG6gd96x1vbKvPv9XeXrSZtd1cz0N7Cb2j1SQFFxUIowxMvyQaOGyKel3MEv
         5rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335041; x=1780939841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9PVT73NwZV2mjPO8f2HRljt0Q/UvloyOhDI//UxRJI=;
        b=YKejltpobcNrBgbLu9G8aPzS7kGXI85UOJHrtF472wBS1BghbK58kuc6DbEyCB/MAz
         4zeM36gdKeiVfcrdYHTiWcAV6KNkdk0peI3gSRCSJgC9NgDde4zxdB+ebXY+WDvhoByT
         OGoUwa6v/YqFFn9v1uIEzSc70iNdRvGQf2DT3S1ML3jhuudgJTWSjtmaQWvm36lnV3TZ
         YUVmUaflFNdIaVCOnZYf6zfvjocxPw1Px76+Pu9DE5FVm4cHS1o0umbNErdSdnJeqG9x
         /DGlZqY9yLlvoBEmc03XDMhA6NEIYEZQEuj971lYyXxTPgeQDGXfm8KnQdW0oeFIZn5J
         gjDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Sa87te2TmKC2XGUpaKKPmGjoYYS9J+7N+UhQT14QAyDyf/ULkiafesyf4Jqx/gf8Wm5NXyyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qZ4tn+Bs8MTBoQESUhspfmsBRqXVbYPf6TrD2+iDBB/8vm73
	xik0iyC0RcDYTV6AKRuFeALtJcHgMqJC9Ofcors3WzYAGvobHXgo+j7K
X-Gm-Gg: Acq92OHbDxfbEikAiwgOt8eb1CIdUhPetQC+9dfa3PpBngzax/RKHE/ixdh4dAXruq1
	ZrNbkECdmEqLzq27X8qkrw+yo4Vq+KDw5XkJ3DlalL8Uv9BY07AcUjLLzVjPaVCyRb2I0FaQJNJ
	lasLzK3DdtlEHRML/W8xxE35hkNKaj4GCvINq8Nt8/ydHi+k54tBKgkyLvm+iac050euXUSBQie
	ld70zf3fvpLciReqiKRpVhqbtICMsaAvYGDfha1ZXCCxtDEyTOkDg2QYpL6GaVwAF9AbEBmtWW/
	UDapVxMWIzlj5lqEo3tWEQ52ieOjBZv75eTzaXb8WmmBuF8SoFVS9Ui3xMSVb/ekQCqEIGJ5L9p
	CY6AEzlVauatEg1Ece1vsEmILTUfUF3wuwFXn7TSu/JYyu5ss85pZSxL9t1olPsch7ua8ZrkCW8
	GphZn/YLfkf51u8hDKsFIhsGezw/xBNX0WdZnPaqTjW80C6LtLnwvdAr3hTg3miVMGPnzVOys=
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id af79cd13be357-9153d999728mr1802258585a.24.1780335040441;
        Mon, 01 Jun 2026 10:30:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915325fae79sm1064758785a.26.2026.06.01.10.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:30:39 -0700 (PDT)
Message-ID: <bf8eda29-9c02-42c1-a55b-023b5d30f84b@gmail.com>
Date: Mon, 1 Jun 2026 10:30:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/969] 6.1.175-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260530160300.485627683@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/30/2026 8:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.175 release.
> There are 969 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jun 2026 16:01:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.175-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

