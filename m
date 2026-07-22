Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011C4399E8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744066; cv=none; b=t1TQjXrEzT6D1L6PpPTkBaWKinuqRRoUVUcDbgrM2KQMj0D//lasyG75Jgr3jQZd3ZaBARY3gRv+5OxdAemqa151O38yl7MbGoOcVCVfrfiuPJw+wwoz08grmE1iq+Vp9uLJRtP+D9Fga08rOZYn1kE/WTZ6O8I4nbvxOnJ/CDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744066; c=relaxed/simple;
	bh=YOPoIUclH28ukZ9YepMYS8Y9xPg26QbGbwJ2RgkS8iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDW6QJrxRFBRpOUvzC+SxRsYd8DZdZvERJuht754u3qoDAXvLhclVmYeZdubLV6sj0qZhOWxfXnH/s9c95kmteNtQo9S4mjtxiPrIUK/JJah2O6EV/U1SvT9kvgPprFwwJ4hEUhMik/5FEc3AQTtOQsydhINE8PHVOxhbqiT/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1xd1xtK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1xd1xtK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf50c6f235so51693835ad.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784744064; x=1785348864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1nxlzxXGxOHYHNh7Zjh3tlK7oPbDKB3XdsU0h+O300=;
        b=K1xd1xtKbit1D9ey/bpGbv5iTLm5V6sZ4OgdVOmbSPaxTfXUy4aAW7G58oJwmaMpng
         UZXWckyJpHJeDXWQMGXQjJMLmIKixigekcAm+Y1Co/h+guWdcnygvBFTB5NaDUp/ErWh
         wgg2YpHxhO/1dtvJ+P+UuZ+yrQWGvjbv4Nw3sT5ftj0yTo86UAHu9MMm3DGlVaDuj7hc
         UsBtlZ+cCYiVmswb7hhK1+ywRJYC4RwsmgbzLzuPiC2K0cq/25JFE74VPypQQgwXHSer
         p0G0zjZIGuShfmikNfo3mKsKdbhRhULQQm/TRtYu8+92IBJHRjd8+0vzTDo7eRXIqsV9
         CYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744064; x=1785348864;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1nxlzxXGxOHYHNh7Zjh3tlK7oPbDKB3XdsU0h+O300=;
        b=YFGPiN4xzeId0av9RJVx7qJgEZ0o3e4k3xCMnQcXxGg7FsNw7oDYPdYfgk27pVgOp2
         vIq99XIl8Fem/tqYakbemB7LXy59x8CmNDRMPhx56RFc1nEF6bJDCVfYmMJdhb3D3rsK
         2p9emrvwNjA5nC57HT9lMhXQCCKo3nYRXGLzHX3JHgASTudNdGNAI/eJhIE9sfYQFxKK
         x7Rj6nsVfEp7pgbl3xbMCIOX5cjREEu2DgLjhkyB76Ze6iFO20Fqcgr9XBrUoQg8LXyG
         z8Ro/yzcR09V1tZPwdK7A0KCmdRrgYGWu03EGvmKUrAfb4/tnt5VABcM3Foaf03B7X56
         pUVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Coizb1gxGAwWl+GFPMPm0EIWlPXM6kiMAPCSGyF5B0OnHBTV2Awv8frjf5fbAb+Gm5I36fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1k8Xvo14pU5YtT/oAU3t4H67ShWMES5zDH1J9xUzV0Ugohws
	0wc9bRqU8wYeYz7rbOHapMzgZVdfeLaZnt/DWdzaM2xj1d1dCldy/Sm9
X-Gm-Gg: AR+sD12RECv/NWrJGYbUe3KKT/Zt7a6Zz1U9MEGLKOEU4KF/t2KOHIUMpAf7URumeE1
	mTVKwXJ2GxVbVLgJDVOCDLBdnuB20yJsenkS+Tgf2R3bP/BELigWIINYlPTIRyNIj0T5PYMbYRu
	O/Oxi4Vu8oWufLJu0ofvQzylj27bju7nggNJ7A4GYERwqouv+EZG85SWVSr1uaaxEKpYOZVjazs
	oGdWoYN6KqJFXwvg4XVYSnFAnc+RpsyNKFSt+pOQtgJAj22pWGND9JZznVZOripdA1OCHvPSnIx
	Y5CzbR7LVYWdFg9kOOqCjcM6hzIbknECZrzmEKL6hEa02rVQeYUhwg8oeVmW8Xs9s9PcRLHwBBn
	PrSmVsjFxBFWBoCIyVMAbaZB7ErCN2iHwv9HRec6P+K5K71z90Wm87t+QtrbubEXAn1Pwp8ulJp
	T+/Ny11eq4Hmd5U1+BTJApwZqTBQO+
X-Received: by 2002:a17:903:37cf:b0:2cc:5fae:cc56 with SMTP id d9443c01a7336-2cf3495ffe4mr257798985ad.27.1784744064473;
        Wed, 22 Jul 2026 11:14:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6781dsm12391494eec.9.2026.07.22.11.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:14:23 -0700 (PDT)
Message-ID: <36bb4bca-985b-44f8-b3d8-2f0eb092fec5@gmail.com>
Date: Wed, 22 Jul 2026 11:14:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/812] 5.15.212-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722142759.100285390@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722142759.100285390@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.212 release.
> There are 812 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.212-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
