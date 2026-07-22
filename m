Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4D3546D3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690414; cv=none; b=sCtVKyREdxLmhGoza/PJ6JKLMzFdzjdHnW1hsI3rQYHFSe0IQv9klszKFyP9AaJ3fxAqEDimKpQ3aVA5mckI5z323pTXMaWCJ9d9Phx7UY+gql7TBQhE0RDhEi4PcnMY2p3ZbWVknQ6CO7hkMknXOqZzoKeD0v1RGvRYqRUD2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690414; c=relaxed/simple;
	bh=EcYK1dQ0d79+pcCrsZiejBUQ5+IjzufA/hI1VLq+GiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptyNZHjowQotS5EMQWs30KgjECGj6ea45aeQOVEnQNYPYwoI7+ns2SvJMnVz8lyx0IQW/26Y4YD6gv4mxNb8cWoOVop/uKRyxHcdIHXimN3RNL7N/8hyxjkKMoL+kN69waPLQ8Gq7pxQwk1ipbvhDFoqge21qZfPQWPFO/wB9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FQwc8f35; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FQwc8f35"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495635a85d2so20591945e9.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784690411; x=1785295211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+DA7Kxw3MpuRlUEVtZeBzxGHuQyYqMlY/rVO/muq64=;
        b=FQwc8f356sTULTvHNp00wHSe3NcBWW/ivj9BS3DNYGSuRiwJLnHvCPQq1hxcHvFmbM
         /b34c0BtgZ/WFaTBWvAf1YyGr0rtSFDe5loVZmKs0Xq6KQPi4u55dukhHJjxvOwuA26N
         XqPUnyIrCZG37yLZ9sP4/SKyCx+Qfdr7cp6OT0MIfTsd4COZryNsSh1RgR5OMR4t5QhA
         xXFHGbo15YMAc9zu7fibo8KFDXWrwgkaxBwn58TXBTXtIcKNDAurzr3WltaLUWyMcaWb
         5D0eHQ7jiWH5oQvgYqB89q5T8BXvzmXFFV3PmvxHNHaR30SgIx713YZecLZLWJcXuCV0
         UQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784690411; x=1785295211;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+DA7Kxw3MpuRlUEVtZeBzxGHuQyYqMlY/rVO/muq64=;
        b=EIUDaVOLv3G2PzSOVRPaYWHteU3sloLNnIVMmeHH2iBnpAZ7txWy5aLYz9GBCpdy1X
         enonhvfy4y/A/F8e+nAzae87/Br6bFjxFdcma7nhug5WFdQELzm3pZbZZdXlFeXGrX/N
         Jar+lIWhySt4U+fwAvTbX0bwmbV3KyqAkgAbU8BSmr1suavPXgsMsPkomLoFG3MMuY0Q
         WYRiojsqqPyzDiYerzg2t01nZ/BMvjezen6brfZ0Ed2mII5J46CUkKcuIVnzNwtMZXQP
         6oghSKdm9Ft068ceF0Z1U1v7YtqN28goosaDe1b2ze8hKeChi0FcgiOOJx7cxVDhV+YY
         ahKA==
X-Forwarded-Encrypted: i=1; AHgh+RpvR7UgUk117RrwmyONpFIBY1q7bTih50n0fCfgRyyDN4El3qwsemPdfu5qqPl3HupeXzTCKrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMJOrnKpepfeF7SFuAqN+ATCGI0jY3D+3i48Ku/5tDtOvugCl
	RrG0wuFcYt0SCUkvm6gpctpOTg44LRJ32wHxjVb8jp2m/gDlz03HRbw=
X-Gm-Gg: AR+sD104a4/LdJwfqASM8F0FiorvDg/ViavwRctp93jThmRWtvim12pKvfvZDUWos4P
	Ay82SiLalvJGa36iK+NwR+zzSSDMeUL5VwFUtW5J2nOgDoFkJQtE4C5qSMw6U9txB3JBNKe0cvo
	qzpDRvZIj1Dpk4uBuOCeGXDAJ5HdYNpBFGm9m01Ow+yUJoM/mHJrvOK+nCm4Ccf1GZMS6Nus7FM
	EiGVEose7oRqIV1cJ5hfqpVzO8AqkOTTRY6cfdR5fkhJZ2buNEHHKz6MICfkSPcpNYgeh4u8jJp
	c6teBs301kmDoTIEQnXDanzGMjl7NwPl85fKiLqj0iijRWut7EahF5TqcHVAQlFrdJhvQf6OI5w
	pXiSO3SJKtKijkxYOtIrQSydec7kpcDOrPk8ZeqxqJOmNFcmhMK1G+UIXWZGRrQna2l30vgC+Q+
	Yxbirh0iZMiV/Qr8ApcGDurV4+6fOBYe0UMENHJ716XFKcd/RRKEAOdg==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id 5b1f17b1804b1-49553d85ea0mr190568355e9.14.1784690410868;
        Tue, 21 Jul 2026 20:20:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b0575c3.dip0.t-ipconnect.de. [91.5.117.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f2453sm38586155e9.3.2026.07.21.20.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 20:20:10 -0700 (PDT)
Message-ID: <6241a377-7ff3-4fae-b955-d81f4d7ef56d@googlemail.com>
Date: Wed, 22 Jul 2026 05:20:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 0000/1276] 6.12.97-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152446.065700225@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260721152446.065700225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.2026 um 17:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
