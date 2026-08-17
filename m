Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC91419303
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985412; cv=none; b=Qz1UXiPRFUkqoa/R6W8jBrWvRIrXvvzFJQcF+oy74ZTiIg6Q0Au8tcMbcN3q8kcmWZnuwVNZ7LB2b0F8M+eefd13ddqL02SLWt3ueGHe20uol4/zXyTMP1pBDyoMg0y1n2Lp3HNQqhQJVeEGX/aRS44mf7MiptT99BVqenpw7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985412; c=relaxed/simple;
	bh=OjVP2UeqV+/uwx9h4iMCB5MSvlTrb0jTxwrkDvH7M7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/TOC81ZzQ9Bm9uhrXue/tOCxy97viKdruo2Tb+lLhyFSnlM4orLe9VGxRjCp18jIKCz4q8Zxcbfwh2B0ZaQwOJlLoGZt5rDqRMHKMmsZMl86TcamKc0aFhQ0xQFz/lHYCy8kgZQEzNLKqeJMkFwO9taLocW5eSNSiTapjoEkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=GJuCVGvl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="GJuCVGvl"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efec2c28f8so20808496d6.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1786985409; x=1787590209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6cuuYCzWxNZq7lzPSX8I2phdXL25gl0XeNUwdzBzNVE=;
        b=GJuCVGvlwEv8iJcIkFGEAWPuDUfp40jglMG2ToQlPgVxDriniw/C/urWoWXWQFW6nc
         lIDVXSeowChx26oYAuXYoCzYRuhXiDJCg4er7qNKMmNZZV0F6hn8mxP8UVIE58R5JOd2
         4Y4+t/vzGOzMx6YO7i60xsXZU/5K+P5dELisI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786985409; x=1787590209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cuuYCzWxNZq7lzPSX8I2phdXL25gl0XeNUwdzBzNVE=;
        b=lAtYQ5K6FYPAl/g4O14cTDqpssKSj1c46u97Tn6mxgkUtsOpm0fwIsBnfyfoMnzK1a
         wwkNhndfrh82CzRqS21FoVhnxwSYAirW/7HSZnLJCwFa3ngJF6DCdto90VvXiAD1Lmp8
         apSmYDDTC7oTLvSmsTuevMWjNLNFoEsQh81AdEdJI08XTPjkfsXp1MvqNkUU6/7Z9FFG
         tA6X9Dg5+2RGPiSeHOuhQle1GrT9OPMu3h+cVe5akCnHmbDh9LFBGUUNhIGe6uWyqpxE
         /oogCV1/y4zlEVigCEb8eVuMAgiHbBssLtL7nwL/rpJonBnWIF8hJiYoZxA+n5gbiLbU
         XqAw==
X-Gm-Message-State: AOJu0YwmHZBQMBK/7RGLoaA/BEefhZOPtnIrSPlERL3UrMfpdgAQaSxv
	7qQJaRsQcT6CkSeftFQHORUuWtDKt9HiNenjMwp6i+Q+n7f1rY1eSlAjUYXjl4VOfewY6hug3/k
	SjbNAp6cl
X-Gm-Gg: AR+sD12xjkR3muQt6RpLuC+f0VupOG+6CKn11qQQXF1WjhbQvfwTsE+79hwtK2PWh89
	4FUe/+b5s2le8J5R/huh+LJx/Ntst0hJDswZl6hECALTIp0wuzna66KT+KyPT0hkp3DFKklOmU/
	Yo3wsOws4Mf9tjrsT93OOSA7faLtZKjL90X+b8wMM/e6lB3U5vbg7LztAzQWs7BczmvIjUL0V2K
	C29fTCIenC3GOw+Hj8cZOlMrrnbBmHHjzrfqY6OYm+HwhnfukwKKmsiARUu+o2GFO5+0UpkGInq
	nsLz8SlZr2QtOUZniTrvtUP4bGL69svHitu6XbeeuVrTvugbFhzHr41qC0KLXJ8SZ2Fyka2jO74
	4AuHM1siCzmP9Q7EuhBq80atGPIXOZzNkYIJhJc3CbdDWEW5Js+HnpYJEkx1JlQF3rZBSS7mgL3
	VSH0aQbw267pKVTgMkk2hUodI4GUm8B6VzWnXRE3k5XR0+1A8Lw0TGsSPMvMtapi3A6LP/MZRGO
	N/O
X-Received: by 2002:a05:6214:252d:b0:908:958f:4f2 with SMTP id 6a1803df08f44-90a91c7b53cmr274029526d6.2.1786985408929;
        Mon, 17 Aug 2026 09:50:08 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.3.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4583a412sm12867376d6.12.2026.08.17.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:50:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 17 Aug 2026 10:50:05 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
Message-ID: <aoM7vdn9WMQE3fM3@fedora64.linuxtx.org>
References: <20260817132536.752504388@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>

On Mon, Aug 17, 2026 at 03:28:45PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.9 release.
> There are 271 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
