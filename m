Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C2466B66
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787699586; cv=none; b=fSmtEgFo7Vz6mghqnaf4zUnqMsJuC+Ag6me9F5sSlP6wvxMySTktRMgyW8ap0McCkPVUW+yRmSnkaGFdOzE0uRQ0huImQYDWAbw3LPoVaElOpYtZ2Wb8vYnN20XJFlWzGPY4AZzbMGMYvT2EVTVs7A5ihvVeOR3IomiyoRfQFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787699586; c=relaxed/simple;
	bh=EAigMp6mAy3uoMpM831S3WsqDgx3Ym05X+5Typ5TZAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH/MrlDcBYwcamF/HcIDpiUjM5UsyRLE5VoAIZFp+/DuVreDHOJHFVvZnDxoK1+v2eTa0AaZUnGDnLbFyFg2/JLtADY0fVDHpEV/pxTJhaKlDw9qBiP1qrwTDNR9Li5psGrM3MB03aUPQRB7BnvZjQYL7av+1AAZmLTH/ga6EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky/bf4XU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky/bf4XU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so265074a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787699583; x=1788304383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYBbOmVTKABvrkkz+zb/pofYfQFESYc0t56Qnb9KVDI=;
        b=ky/bf4XUg/ksA9VMpSX8iRbJe2m6JdTAhXqtqoSNBmh89m2eQQZ5oSfampfCI3iDHd
         dMjimkI/aBWXFKeqMd9gZxwL2O2Mcpcbil2sWVlCsPp/yEEKQNuZ/R7TuvK0iPAt9GTW
         Q7wfbc6ZDryFinaX51n0oWhkui0Yl3KRMO+fy1jG4eZ3usiuTstFPalPuyNfpBz14tyf
         TWhfF9O7pBG3uphF2hERddE8fywuB8MDUi/kZXYBiVHu6H4kW4MrIt0KKOwbJItYFOZ4
         WtsllrivHHMbHtoHrIBQNnWkE3/inK+6MpXOsR2Y8VgFeqFITaK87oo1xAqt+apQcPPo
         SnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787699583; x=1788304383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYBbOmVTKABvrkkz+zb/pofYfQFESYc0t56Qnb9KVDI=;
        b=g1E3EGUkZwFxk55wDvhxDHaVXao8oVTz6ZJJa657XmwNw1sTu0Yl/eSb2eDJzttjqS
         wTXCEBS5ghSZy7YVLeyQFuWOuXk1VziJ0R15SZGHetHSaJqqdzVm6WvsVNO4uUIRTj8o
         cPLA+dEadvFxR52/SJ/CglzMtroGYPsw035hcG5BVXNF4a3JkD+QOWqUk5cu/zccZRNo
         0iqKGk4hPnimYB0Wq9yFrnFtfAB0rQxsXo+bWagwywiQuwUIqZSqs7Qwn+B8xRQMeiSt
         8YRjy+5slIpOfDz//69vzyRfkRX6hr9y6WSDEG+qZmCpqxX/8JWXmciq1ouqV5yG9Yih
         iSZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpalvRYkbQN6vFCVyioLJ8lycEfYDTZDrjuN4M/d5X3exN+HgIv+psWanS43jYHyp77PND/TJA=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ8T8/d12XE795Y3Zu8inDiBv04A6EHONrrCmDyG+WkKvtr3Nx
	ub17OnxKmCcG2KZcv6uC0XzPzbrYUUDOQda2DO+qsVtcR2keypz261/M
X-Gm-Gg: AR+sD11x4Eqo+BCpTLm59S/NFZIA7cpfOQgRRudLXDD5oTWu0r2YIHmM0vqS6OXo6W/
	QTVj8w1XQsBEc+Ev1M25wj90Pw4NBpMbYUrmMXPozAMQpXraLfooIR3AusFK7PwuSShXl82bl34
	isjQmZkScd1BAnfBIfBxWyW6rEZxqZJkNF7XHvEqro8Xe8UHSLnxnXOA1Kx15b8FMwM+aBYx3qu
	IM/D+IIxCbxQwGU63SCyaEla2GxAT3yN5VDZleNd0XZ0yp2YQnZ/EyQSKpywV7gV5qF7c59Radd
	CvCBbx4OyoDzUIKGiTrVqJGQ7psYCSkft/f6Zd/nOKpKVR/tdoiTvVuT4aOzauSnemIsii2HLXw
	P0oGE6QAPMLJwK3dPYkfye00FaB4EPQtFiPbl7gyurVmCJv637wlYDr4SijbjV4VZ9Y9co455Wk
	Z8puH8+4UjZjYH0Nz33tYFbZqFOWjUjdu7iX2JctfotLGUf8FhObOPSntZWh0cRBF3Lhp4WHBwE
	DLn1xPY3wFSHrA/U7wyCMyP/w==
X-Received: by 2002:a05:6a21:6711:b0:3cd:a1e2:f238 with SMTP id adf61e73a8af0-3cf851546a1mr4332973637.16.1787699583390;
        Tue, 25 Aug 2026 16:13:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm2400417c88.0.2026.08.25.16.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 16:12:34 -0700 (PDT)
Message-ID: <8cd99d70-2dcc-4f05-82c8-8d97e99b4b33@gmail.com>
Date: Tue, 25 Aug 2026 16:12:32 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.887883084@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.887883084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:24, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
