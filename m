Received: from mail-pj2-f28.google.com (mail-pj2-f28.google.com [74.125.227.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC540DFA7
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190013; cv=none; b=W8EI2B8SLGh0WKkG2OoE0JlGqOQWUrRgTJ44hBsdgRbPFaKQqZ2WoBmLqgbv0Wea1MNt8l6keqNquFH7NdCEuhkyGn7zP+CtfSfOrwTRrVlD/Xm4FEUV21jD0ZWCJimorWEH8BhmK66SEu+yv5phJifAl6MaR1gXHsU0tbLFweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190013; c=relaxed/simple;
	bh=dIYxx7dcorRCck/K56ttjlPJHl0ldcGdQEDj9lKWAHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epzRj1PTiTpXzbnnfoZNP3dUNXhCONl1vOkAyhMRvTliPEpHQneOzv917WZHNxEarI09mC3pcggvRmJYB/tWjCibTUDMlIgKfH1j87H3L6i9ykUkS4dMGU4u6RJ6JgRByx8zfU/sv3k6SaOMFWKRDoJyTfkzKIdypmnwSJEC4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5eKUJUj; arc=none smtp.client-ip=74.125.227.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5eKUJUj"
Received: by mail-pj2-f28.google.com with SMTP id d9443c01a7336-2d91c22d27dso5314325ad.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190011; x=1790794811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ih7vExqheyZRzWcSD/M9fF0f5NUhzIJn0g8tstyB/pc=;
        b=h5eKUJUjHhOD9CL2T44KpeSMf8hR7EIk0ZYU97GJQt5runCc35KzHjggngZcKEka78
         TzKQW81ZeiTON2ySyDKxA55swBl+bMVIulIGEg2SKAWMlXfopmf+Vc9Q1nGnXMcvMaJO
         sHK+1w8Cxi+xTJvQS0qgZYeWv7hAfImAztXnWdYwGi8tddxYjX+YPqM5buTg17b0Xusr
         JpGwvPVnQzVmUdOdGJLhmhc7k+bXNPOgXIOYi9cVC4dQR2QrJn8TJPoP6bF+ItMQWuWH
         GDJV5qwVoa/mTxUyOWmTYwucjXwPOxiigvgwOxDzjJaB4VEWDOkX0LjMopiNTW/PxdCE
         fKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190011; x=1790794811;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ih7vExqheyZRzWcSD/M9fF0f5NUhzIJn0g8tstyB/pc=;
        b=uoPVgbF5iqb0RPh6ARnDyt8PW++6ScgUFSv9fwKxqhCye5Ts1+vgkXJBZRuu+jkfTJ
         Vk0vmwKejdLcGxf+4xkJoTjIV0Ycb6pT636ZlYhsK1nbfnxMoaJxeaDEdQuBFZzV9Q71
         w/DsTXYTHwMXKXsDruYHsvEeoQpIP0sYtPBrNElH5BNvzfMqCluSW+jmvSJHqpE93MXM
         GK1ztvQQcHubXZZzAjBTAUt7auYNGMcGIGgzImUYNKrEhZGuVlDkgyy/4Fc5aSt5999o
         FuxRCP3dNyRdzg+jeGoRbrtvLetR2efgMzc1ogfvcbY+mTkw0ALfMoXBO6ZW0WQOOWse
         gzMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhDHWgMH9V9yoWJJKjaE8AX3MyZMHW7ZYNFQY/x0fola2MnqtfzHA04rK02hdyAqP8ww+U414=@vger.kernel.org
X-Gm-Message-State: AFuF++n/bEDcTgLP1iP7YZ46C8T5C2JjWZqiUpJ7hUedqqapz7az5CkO
	sU1sSzAzAKHl1yiqG7CTNjswZtDfQcWzqcJkww9YQtSFtlenlPr1PkA3
X-Gm-Gg: AYBFou3Yu6RjLs0TfRKc5/UHoxGHbyDi4iiJ7gv2iwz/mJcRvzls+TGSG6aSScst6cq
	OnztZGUIL0UFufkJmd3WwKLfVMYr1gZNa0PDmr8/vMrIectodDdTzcUucN9FMpQxTMGFUeJ/Fsf
	DtNnELWAi3HNu8qOoNgXkhDDggEhowRYTYU+glOYlBjC0ew90vevRJkpG9M45rE71z57m2e7UFP
	HW+4ze6vGFCuEySe63rNJgTV0a7HPLQNInZ43qpJ1dq9t49k0o98QcDGReHMSEXk5QC915o2TvL
	4c7NLicr02MUkvms4nNiGQirRKzD8mDJ88l0q1O+pDseoQ6wWiMruXFGBtA3Td+QyIucAppCjEW
	BwiIVkjgL+ZBQDYo+/oywkuEngwW/noziBCkCit/3VV3SgQbsMbEwCysBV3FaNY6eXUiS0c1tPx
	/lJMkGiVUod1jrdv39gzWLCBXScFqDnk+fl5ehlabWL9OXXb2ANopqxkn7FbuKOP2lTDBkrLAsK
	/v4/spSLZ8I8HaIey0ELi8=
X-Received: by 2002:a17:903:907:b0:2dd:c053:d740 with SMTP id d9443c01a7336-2df7dc387e7mr822995ad.39.1790190011161;
        Wed, 23 Sep 2026 12:00:11 -0700 (PDT)
Received: from [10.14.5.0] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm15827145ad.48.2026.09.23.12.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 12:00:09 -0700 (PDT)
Message-ID: <e0e7baf9-185a-4608-8dab-ddaa693d26bc@gmail.com>
Date: Wed, 23 Sep 2026 12:00:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/398] 6.18.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260923140643.441954610@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260923140643.441954610@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/2026 7:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.54 release.
> There are 398 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Sep 2026 14:05:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.54-rc1.gz
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

