Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E03488210
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701038; cv=none; b=Je3to3nPEqtxFzBfOw4QV4w6Ikd196CuIiz5wndnHo+CNzGDhtlJ6uMQzCsYYVId03EzWwycEd/H+rbQ/oB4RIwUBwVgDrfl9FV16f5B6vHDp4F78/GROJTHnbuklNdg7cLiwC8rXHHrzXjV7E3Y9F05v66wehjD6JpLUE68udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701038; c=relaxed/simple;
	bh=wskty0mVPYIMPkpNAqRuO1oxlxIJdMZjXtGTYJABBKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgVenptmODCGODXbOt0aQf+yYregvm4bAaJFl+hkisuZEqFPZdZI0bGIQpDzizXgU5u82DepVkeA2HH4S+wmgP13EFK6Seditjc92/AhaKjeO/VjHmvp2bap6E1WFRFcQPhlizrGhvtETM7fLgCmCUDsKZvTH7rJgKszgMt3e0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEq7w4SD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEq7w4SD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e512a9a6bso15401285a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787701036; x=1788305836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+qRUR8BM/qOZCJYtmajcdF7kTP7NMvMBM/jMJHKHeQ=;
        b=mEq7w4SD/7vhHcwRxK78ndrKzqSQAp8iZDC/qAIxh/hkiVV7OqWy1uV8uPP7uEUG0o
         FCbwPIK1LFdr4hgXIePTvFIkeQIXyFjD/CizSNwzdCGO/dr9PxoDKjCqKjaj+A99oD3H
         3l6cb0bEGLFEgS2TOV1z2aeRn24Vk8DfkTizjvq3NTYVbGzo6tDwf0GMz8H+C+43KsgV
         kg/oPUWUrfSacZtgFsm58uXomAdlT/xcKUn2ftsWkcb7gpQXbVW9aYkVTXQPpWF+JItB
         d/w877Y0+/n2PSgYJM9KmX/0WbHdBfyZcIXDCiHwIV9Ila5at3jpNrfxs+UdhmFouBe8
         MiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787701036; x=1788305836;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+qRUR8BM/qOZCJYtmajcdF7kTP7NMvMBM/jMJHKHeQ=;
        b=s51/2hF2+At20swr/vhJqVOa5cYxID/4H1U6ZHuMd/GBXjZpXAlruYwRgGA/ZNcgUp
         Nz0EaSEiE/ZsW34plFuDCO8g4kIQi37Q73YfnZRjejH9tBMmVDTbaqYZUptOed2JEopK
         6VWnTqLHNMI/v0gWBgZ0jemSSgUC96+OTlgRsCsL+2UDRHQNbHfP48hbC65cjbrAU8JW
         3pf/VMj9ILSiJUt4UavGiDJh6OLvGn/TNhqyYVWt5HyT8bx/PiGurUxqfuDiqyUi4vk5
         NALerPBzQs6F8Ws8RYOGXuml/51h4akScO0CcmwMFuefhpgX+o0qTzIQ7msyqIDnm5Yg
         YYkw==
X-Forwarded-Encrypted: i=1; AHgh+RqfSWthVG0gJAz7RZxRdrbZWgCws++ddCQRlVTkDlqoZbmXwizhgF77qK+oi+neaLxHl4CInKs=@vger.kernel.org
X-Gm-Message-State: AFuF++lYKnp9yHNzGwY03sSJApyi+Aita2XqNHW5bqE46yVrzcTDp59e
	sKfnB1lUiC+0DH3cTxpiO7e2czKP3jqSZJtN5ZJFUXPjcl4rwMVsgT5S
X-Gm-Gg: AR+sD10RYUGOYx/JTr/523khY7+YSYmRgYppp0e7cXGuaAzx0Y0KpSaBYwZqfKn2yxx
	1KqZciWUtqOxV9kzNUJrqcft4PC+z/dBZYBNAuORxghyuvE2XtnA/p/ubwwx3T+22YdCx4UoGCG
	6/2fS6f3IE3c7v8PzAVIAqYftHSXJQEA13/5LjXc0+xqhygzSpdOXBoGay5ipvjd/W1Tpv/QUWe
	GIKe1g2way6IgSZ4WEv4wATOaclT8H2qmgOE/8taairb+/49b1fmQrR60GO7lzo5d950X6I5J5Z
	DvljxulaCal8/yFHE2/+Gdla7zo48z0YIUYMjyZh0ZIUreqi7xXyAz6FaxVq5z0zuIQNoo/b2w0
	J0f8xG6rve+cMIGeQFTTl6aSa5vuhtRbG1ISwMGmpbO5m+rT1msdrwFyClNWBeohKSLNE5+xdey
	ANDy67cDziiLrzMh14E/g7kd83L6Pnk1AHWzamkH2gi3sdyjhw1/sPSjx8NmZqsYhT7AN/K2f0p
	z9Y8/TO0kaBe3wfbhMmCgw5Rw==
X-Received: by 2002:a05:620a:618f:b0:923:7821:dc0d with SMTP id af79cd13be357-93780446b68mr257224185a.33.1787701036142;
        Tue, 25 Aug 2026 16:37:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e6156ccsm87926485a.27.2026.08.25.16.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 16:37:15 -0700 (PDT)
Message-ID: <98ddcd6f-b735-44d6-b68a-eed16e68d0ac@gmail.com>
Date: Tue, 25 Aug 2026 16:37:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.986300899@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
