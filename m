Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218554;
	b=w9q1Xu2cbVPX+GhVMYOPHqrQRvzb29Eatt8G6V2Mt6LQZXeLq/VDjchx2Xyuln44gKbW
	 yzVz1jScpHYMNpD9V9+b+iju0XyM5WwVCIWmc18op+FIbvv4uWzQ+oJsTkzKXRkGXVk9s
	 XqbN08/VkAU7b0TPRHnrxLcy3nMXfQye9evHU5uqO8KFIUXZMLeEuABV3cuwS+L3Tu6h9
	 Q/lfgk/WYo/lD2dwD4zXQr/9HnhMxbGA5PVtRFrTykmBd3BMGVvLvEigB3goDngut3+v7
	 1wSgB9ikNFlLPnSjkP3PQ2pRdgdaR0on0h2RTwnTiIxUeTijDk8dvyJXlxisZJouG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sE7YL0Mu7zAtP+r+dItmrpgUYmZe1QgZ8AhEij2E0bY=;
	b=H8EF7HK4JjWMMn+oUQsRFrdcaYwWr7ZiRYnhnfZ+0UhGqPqaCfCZgMACw3Mi9Xpy948x
	 Dy8L5eeItyrUUTbKpdJ7HbwLCLtVvd7accI2Q9bzk03LH4MrCThpXduWEcYYybaaSjoWr
	 uiDJ3nkwpU/KX0D7ZT++9ZlQ27BYuIg2ISt4BYG58sdv2M8OYar6BDwrvOzR6l6Xr0lLn
	 59V/JZMz/Burd4EYISsEH/sp4acXBPIXmoI6YxQUlts8wLBDB/UEq9YUFHkYu4D/TmX2Q
	 OHP6CucxCt1qhq9kiARkB882xq+dNh5BVxOAzu8IhPt4J5bnE5fFxbfKPBxp5m1C4zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bG7XSkYB;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE072606A33F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE072606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bG7XSkYB
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5366463571cso18859761cf.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218553; x=1793823353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE7YL0Mu7zAtP+r+dItmrpgUYmZe1QgZ8AhEij2E0bY=;
        b=bG7XSkYBkwwgMP269A8xYjsaFH+uLKqQJIdQBZXRjpfHMIIb9tAu3xbQw19i+0ZZZw
         duWLzjdfOEJWrHrH53HDvcT+zhVzmyHGzHN9GlLXcC3RDP68WvNG/JRCFvTXDjD+PomR
         EoSo1+qz2ZGSFgS/2HAqOhHZtT8ytoZ+4AuenPf4Y12llLhX+tWCiz8yhsGMvuB9fcSk
         EPP6Sek4wII29a7wxxHyNUZQVSyIYoKhMspqIo2OQ6P26Jzl+sbIH9qrzEpdQgFc7EPJ
         zrxygZINHngixt6Y7KN5i+2CTxa60xHD/V2c3FFDqp5Qpe2dwXkRKgZEhMQtqsj578SS
         HH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218553; x=1793823353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sE7YL0Mu7zAtP+r+dItmrpgUYmZe1QgZ8AhEij2E0bY=;
        b=eoXMUEHLXW9Mk9Ud1OsuAc6f4OyrN79rr7HMS25esBW+mbK0C9I1+oaa4jmSmlel4d
         oGAn4i7qvz1v69LQWlMf5pQOkqHuokQTri5TQTXIOdgD+qbpxGWBwokYFDYK7xjiKPhG
         gOIEugwjNc/0xsNLFL1L5pB+xB1XoTXDA+6a/EqTLzu9JXUzdZBAVQKOaS3+Pimrsneg
         HR06dzv4s0VUL8w7jr6lT8kwR5XBAuowkaYmgFR1enddnvcNKk/Fzj2ZQbFoc4vgMYpi
         WqXOrWuviiDxKWUP8Yaa4f2sXS7ugqLcFKC/Ot2CsUgyEStVQ1udnOYSQSbLA3icp6if
         nEYg==
X-Forwarded-Encrypted: i=1; AKwUvBx4F/nzGlXCeJLBg1gbIB/g3rZjjRN3gCCKsMiXXclLEGo0WOSx2TaDOaZOg4h6KI0WZPW3sZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtV+Eh1kDSqvKlcJoIYL/62mQyHUhA5Ce0QXbylVR2GRuyKr+3
	DgfwhVix4UA+V2KCI6W0ARXOYvl1W/Xqg6KhVJZowVu88MkIPz19LiVp
X-Gm-Gg: AYBFou0gJmBELaFLaOSRACxOnPnSP/doPiMOGqRUeT3Igi54ZT20fWwSqqzuSSc0BaC
	BDwimRxObrof4Oc6G1R5Rxnl+PyutzcCB7iiQ669AX+dMHDcbiN+xHyobx9xCDnALLhA8M1fVfC
	4cabP9FoM0geCfndQxsYArZOx45nqqnJ1gAOVQCtCtPhFkuUrJ5peJB3lyTkZEylHTYxVBDqt1/
	DrccdAxVrJ6zW0WmtzGKDHBWmBSq8McmTB4wn0ZAtgFG53vluMV9b7htdMpwSdrBcO5U7qVEc6/
	EPbj44zCT0uA4hoxumGidwi4+M4FdPOKibjYNKy3kkbvj13I7WYEsAqH9bEb9hin8SK8qQckBE9
	jih/iDuv4k4OMSewlPxlUSkrnL8IXV1FG9lIhpI0/YhW3fYQ39z2rvFL0YlsJVmLlPe6QYaVWx2
	2COMnGa5OxPfD3jRWDjxzommHaSm4uMZQxFIrR9w63/r/5ejL2zqvNs2Kq8N8UkmqbHJ1SKQLtM
	bhD4h/IH5ig9GE0xtTcBevfjvwkUim3JEEJ6dGfjwO3LxijS+5q8W+WTKWgMgDn0+SDFn6K0iYF
	OwbeSDQyNE/m+X75cKiXLUbOUDmAKzP0SIWZ6CXyawR0C79JewAGHpfZ
X-Received: by 2002:a05:622a:506:b0:535:2794:851c with SMTP id d75a77b69052e-53fcbfdf35bmr60489901cf.39.1793218552723;
        Wed, 28 Oct 2026 13:15:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c38easm112809151cf.7.2026.10.28.13.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 13:15:51 -0700 (PDT)
Message-ID: <131ac3f8-8658-4b78-bc0c-746cc49cc526@gmail.com>
Date: Wed, 28 Oct 2026 13:15:46 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/516] 5.10.273-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028170003.522232767@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261028170003.522232767@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 09:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.273 release.
> There are 516 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.273-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
