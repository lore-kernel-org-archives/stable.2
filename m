Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1238445AF4
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001575; cv=none; b=hqyHlw+X5m2/PN50er56UKHs4n53r8NBdbqgfIUwwGriAABx3LcaYgdt+HjYCH+SkQ++lAzWFp0aFnR/xQuAAE3kezinVMCe4bohSXh4hjzHTFR6EYSTaSePuTM5a55ajB2/X3B1oQp90jTTDyrtn5wI+gvsJzA2E9oxu31alTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001575; c=relaxed/simple;
	bh=LfKFQ60MGbt3oQUU4UeDzk9gNNM573Bv+YOc2QstpIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVA3IzktGG2DsJFPG77SgfhAB1BtwQIVe4wRqEhSEWVEv9f1ErpFJ2zQ+q4si76RReviEScP9ySjQMRkuZOIj8Sbff9ujeO9x0aprZjuU3P1w6gqS1gTXNq7Z3LXAT6i64EIuuwhXWoQJGbHw8uWwuWoxFrevaEMh7o+kOV3dgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/4bA3UV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/4bA3UV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d5655cc850so24487965ad.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001573; x=1787606373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ys/YTvaoT9w4FLM9XG0rthYcw3gybAoEJJ0PsMkecBs=;
        b=U/4bA3UVQ1BmqWfzSuBv94duqhxzDiolyTsWBzJjR5aDnfkeKfyNxXqTpHiHjOVbrf
         VsA6MpWzR4o1P0DNCWDLZSmfr0E3XK7fhZbe1y7z4TyFCrKd1Ifw5wfeI9E2Mpummsab
         3SWslZzZVCDEanyP+V8Up6iM/lBEiJ5xf82JCtIPvU2D+6heXNWt3vEzoE7GfmFOTJzV
         wq+Bu0EaAZnHkbM3wnMaaU9V4iRjHRO0FRi2bCGIYQxIHdYB9Wsa9UoJLJo32RtqPxG5
         kipnUlMKbpNRFzly+dIEGWbeozC6CDCO6frOccJ0zBvV0N8YI2wtG7dscHNih+cIGE1T
         GqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001573; x=1787606373;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ys/YTvaoT9w4FLM9XG0rthYcw3gybAoEJJ0PsMkecBs=;
        b=IuBiU5Xyrqg8/C9gd+IfybWWAhwFLhFhU7i1WJsjXHOk9dXN22JyUg08/hG4nb9mzU
         lvOXONG298TgkXhNv4rJrImhI9zgXUj4hxKe2I4qWjLnbCSE4zn3NCCnlnkzIwrzB2Fb
         IsGC5QCow02ncM418tkYqtW5/S4sUPDDPZjVXXB0a394dwRoOb6ym8QNGZ8M100fPxrg
         Encd81hSKiq1Y5/gYnJyPjB/Sz/qCZN4SBwzNEac9QJmxnQup3b4AsqmZNp/JqIawY2b
         41aQ4xcPO1dJH79/Gb4amdMMu2ZiSwp485QGMGJxcF9Y8oT+OhYhHCP0CacORoEyPEQU
         VjGw==
X-Forwarded-Encrypted: i=1; AHgh+RpZq/hfycBd18BgK4Vo+CKkw7zcWfzzrvWCGhrWhXgFp2tDr0xrOQnOYM7VBlmS+VVwbAenmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz98c6Yy6EZv1Nxq6BQ0wR54pe49minoqsSUg3rL7WFbc86JK66
	pl+el7szH6z/5fQDWzfcnt9aT8Elh0mXYSzfTWkC9JZXT+XpFzH2cq8j
X-Gm-Gg: AR+sD13bZuRw6vzXaY/jP8G0jc4hWcJeEXPAK9ovw0Bu+9tHxrw6LfMF0yWK+A60mwg
	QEsrj6DLSkuEG5jO513mmkFtokFkudTkQji42EC4sYbE2N9grGpLj0wZe61HBhU4ezlMyoikTIn
	5Kt8IWFowW3gGaWYon7INh6sBNird2ftBwDKkffJI/VFYkGdcBM86/0ynjzQ+u/mq7k35oO8kiY
	0dIM1KuJnvUEyhvOS3tQS65nW0aTvs9zzywZXSLhRaq6vFFUW33SxCnz5gOThNXuX0THO+iGcI+
	41LmXPqnGie3RjvypgRdzlE8WSeOsOUApKO2AX3fnbKy3d4HlOQO5lI7C0opEAyVsCcLViXYnRf
	mxVijM1a2BInz6yJC7anmhQTXtQi2XQm50zMTc2PaysOIfmLnLzBFecnasbo09AkXY2l/+zG10m
	qegYd/qiLyuu1uZ2KPj78dRuA+vT9uu1iv7Njrred3bTajdoG8aDMcJO/QM37KDeUbr3neGJ52n
	B4imHlZfEdZULs=
X-Received: by 2002:a17:902:f68e:b0:2cf:4c0f:5129 with SMTP id d9443c01a7336-2d5c54102c4mr26838845ad.17.1787001572992;
        Mon, 17 Aug 2026 14:19:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dceb20sm8182102eec.3.2026.08.17.14.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:19:32 -0700 (PDT)
Message-ID: <fc1827c1-fe81-4336-94d3-d49a989de2fd@gmail.com>
Date: Mon, 17 Aug 2026 14:19:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/156] 6.6.152-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260817132534.666299318@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260817132534.666299318@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 06:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.152 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.152-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
