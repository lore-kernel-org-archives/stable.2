Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC628EEC0
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702555; cv=none; b=vFvPVHmtDEXRcox78cCJRI5PwAlbSW/SdZjnAPv4hsBKLI01vIDTa0WX6e2iGoZbnyk7YAsKPL4JfSUQZYdR7RMWuN4cWuge1LOoglgti3IyXLlwO1YkBOE02VNaLCIysPfB7+q20FD3ub2ApI7fh57svWEpJ4fkn2PqOCNcPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702555; c=relaxed/simple;
	bh=3Qzgcnb3krqYX1TRCLm+K+5/oXakkUWqY4aiFmCuYVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDOMopwivFEL53sS7P9nqt/afPn5i1Q4E5l1Y1SmYdPiGKyX22iyuT0b1HXXSTHSe+5v0ECDMoV8RyOnu2AomEVjJdOGkmseIFH0DbclygDyfj2x9Z3TXw06JyPH/9G3M3HTTL3dT2d+0piJiLQqmG87ne2a8uCMMTuHVxBmR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug+pPxuM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug+pPxuM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52b3934af3fso4504331cf.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787702553; x=1788307353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHASJ0p4N+FbxqsXc0cBSjdXno6a8UBOq1hc57eHVdw=;
        b=Ug+pPxuMJz9ccgvQRkbgIykvLXxj14e1mgpbMSlYV//20Ro212rWDbPNuW+Bqa7NuR
         U6mhRzoaMm7ciifnviHmeTPT5cIkdMIzPaJLi8MUXsgG55faLWCgt/jJksaZGV1oNEZr
         9hOKxZhyHrdpEoOTmflM9sElHXDR7hv1GTChK+gYeH9flEKOSE+2xYuRDcr8Zf9qLdBi
         g5pDlmRy1tXVoMVAezIQ+WOdn59YlSVktJJpasgBF6nOjiWPqQ3evFQR2Pld4GauucPV
         mtz3EYqVnqA6UGHV94+S6T59r9ye1w+7+EkYvTlFdp52dJQM+/LMlH6aWNXwg6ryj034
         HoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702553; x=1788307353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHASJ0p4N+FbxqsXc0cBSjdXno6a8UBOq1hc57eHVdw=;
        b=U/TLhUx46CTxqo+UboAyuw2d2yvUdsHDOqdPkggTWmjvsF+qQ3Y4R2Omp4e6yTWKiH
         EAvPyevx6DU/Jnc4R0+/A5S4nPvUPCm16+mn7ywiWgewXzkGgpK4fkjO+YM7Os1EZofh
         56631rxFOYwgZtAAqgBNlN7WT96kkrR55vMKft74HpYdZTKwnjkdLxQBU0j+avZ4slV4
         sCPDGL16GsL+h4jH/W7OPF5P9YljHdSfqi9SDJ80Z+VQ3y3LTlerIcYypkOdmcxFWmQG
         vKmHzKHVgnv9Ou8rwM77wQc2RzrOuUSve1wIsxkxZlkP/P4ZB55r+3TD8lSvSfcrjI6S
         5D4g==
X-Forwarded-Encrypted: i=1; AHgh+RoeSiChXh3ROVVTSw1Ru6NnoK8BJG8sdDRVpmiJiao1Uyyefx9b4peG9/jL9vh6SotbIp5CyB8=@vger.kernel.org
X-Gm-Message-State: AFuF++mn2QGgeih7gvWcflpiVlThH9YsrVMT8eziadPp2U+Z+yT5hYh5
	M+OcAwdIBBG/5BBExDVcTLOlJ+TL4uFG8c5mSM0JBYhjWZCwsMdxBlrh
X-Gm-Gg: AR+sD11EQs5ibrVGJkyY2k9Es19piHoWtv05/JGrj3HKXzybepmLcTT1rsQCfNmoQYK
	FQbUrBdObO4JvHPjdQuIBq20DOTOiZd1QgM6q25aADrzuJRfXtk0gFkKyFnInSzc9vNtWaImKp/
	Yu7uRBmL+x8F0A5k0kPivmkVbEu2lZqdVuA9Wz1WGmFV7ScdLH/4I1CI86LgoW35rLje1vMu5PQ
	ha7TcA7uxCQdQs3GUHwgmX3e/H8h19d39Qm2095cGCq1tv+DZpGE26WhvNd67EgV+yiOxTguRB8
	Mgh/SxpmbZ/VOl/0EMrMFhapRh0xxDoO1PMgL+pa1WvDlFiyaNvgmb7/XkGnu+/BC0VrIgem31i
	eBGct7F4BN1x680y/Ig6mnLuOs6l1PJH7rrWdhPIg7I6ldARlfECiJYnnCn0PvIFU3AYADlRuxm
	MWrOCUT+GVbs2Wtd2fBOuvWfwJBoDEeouQK93Ipyjy5bn5Ete+A7sMZTSuU14nmiU57oUP2sB7p
	Palh980KyDnnD9tZ3W1RXs6vg==
X-Received: by 2002:a05:622a:1c1b:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52e422cdf84mr32079211cf.12.1787702552384;
        Tue, 25 Aug 2026 17:02:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc650a197sm11302996d6.23.2026.08.25.17.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:02:31 -0700 (PDT)
Message-ID: <221f5c82-3dd9-4552-91ac-3661675c6eaa@gmail.com>
Date: Tue, 25 Aug 2026 17:02:28 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.560541185@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.560541185@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:24, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
