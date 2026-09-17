Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2F2FFF89
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605927; cv=none; b=VAVFrU85y1fGqLC/lZdo0Gd5vollb8/lUc1OWZqdzIR2Pxl5oZ5onIrYLgRjVdDoiGNQvPZ7llF1h8ENCJmeA7xZh18DUglRwEV6Bgvnpjl35OZNU6oGFDpTSUUf/PjggkMpyfuPtf1vjVtoeD53P8YT6X0bLCTUtF4UX3w+6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605927; c=relaxed/simple;
	bh=pSIUYIx+0OkhedIaRJFFytc27jwrdIPiXSe8d8kKDuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSLovZ98H5Uh1pHbMsU6MgjFUDPKt5Uim2z71EpIdhJrc970pEy3DkGwyxbX6y5vk+mQot1x8sOnIyRxtDvYlEOPGD/38Ju7Hhk5RoOaEPJ0syXRBm3LMrwErdpjYuIUBDM2h5AJK5plF8nvvYW4vr7uACynEBsc9rS1TCzxHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku1amnl1; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku1amnl1"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86212a185dcso292821b3a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605925; x=1790210725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vK4WS6l3ITRV/oYCqfxSRTjx+VRSZj9i6Ex84U5fmjM=;
        b=ku1amnl1rOi/dNSYnVA2p0mOi5pzTP431ph81+tN5amFHqXTbk8mwhBTq+LNgqYuqJ
         mTm12WgP+ZSQ1NJSanS892fNSAzKxxX5qg6g32LJXpbUr6G6/FaGQSW1V/js+81J5ArG
         9Wl5iERzDpuqkqpStr4tPKIYYaeWaMcpG5hKwZF4Ta8YmkRz5NJ+rYV8NRJiHfoQpft3
         1uFgP18qMuenlIGSrxzB7vFj68kXvXXWtS998CsB/ceoih1kR+IyAeuS+dSKtYbfWXnO
         pJvJClVR9xWd21s+lgkLAt94hAdoDOYfCWgm/A09AF/LhF5RXA3RgYsWobfw4VGFtK0m
         ZRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605925; x=1790210725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK4WS6l3ITRV/oYCqfxSRTjx+VRSZj9i6Ex84U5fmjM=;
        b=fjpcXET3l59C3w+qPRZNxlkkxRmiP1+A4EWaAjVjSq7wkfF7NoeVUBhkxyy6/MYKRW
         a8dcwB2IGiTsDIKKw8Xicpm5jw2jxCtJ+j28XN/upTGMkeG631bxzAj7t78V6p28yxR7
         eORfOkaGRXKdazfqR1GyNpTJytU+ve6daIeDNZCUzOcCdwx2X3X/r7MZACY9hYoH1wNG
         AWtOsscvUnvvkW2w62MSB/n7tqXOpK0LeekF+53Y/3NKCBHjaQpza7aTFuL/oAIPHOHh
         /iStTufE9Y4S3VKrX9DWpPZ5ZiO95GflVUwbgViOSfUrgZlBm8DHlrNnujnoPwhoZ2aP
         O0qw==
X-Forwarded-Encrypted: i=1; AKwUvBzFkHVZZYavSrlqg/TWYl6pVUpPFPVROyrSSMg96i2F8AljTVP7ZeTIvX7o+IxxktjfUYTp/PA=@vger.kernel.org
X-Gm-Message-State: AFuF++nSP2GXlFrDZ7tlXz1MoIecjbSYRRW3YwPs8JTgyhOkwYmoBiRt
	GG3o7UBwF0IlS3f9t0CJAkRbInzNpUSaZ3GbegwhWTGBGYNFIgT1xTbX
X-Gm-Gg: AYBFou1KakCpb1vodE9J4uzg53CKlD/9Js4tTxHZPhDsktv9o1PkL80lu211Y7vVJMa
	XCxJX4O8Ag6vfH18ZgyOkCxMHD3+/idGbsR7sal6XN/LXe88aIQB8t62DkRi0caNGPFy9ZCiqaQ
	ER96Y4yFfNgtoHGnJm0TJjD2odgyf4u6et84iiZLsp0Zflz2yjCgtlENUo2hDN+zQDzhrwccBay
	DPhsnUBEBuRa+vqkHpH6Anon4dFt7bcaewzsgPhtjfQCaegfGsXXcBt79D+Y39LTuHngAX5LMXr
	+uUv5UeTxN1jqTl/qomQy0D6nykTbqpP3Qt6UHif3RfK5qSZIv9v/byHSJA84EwMCTdeayJfket
	PhX4NOSvyMA/6IfOPPdm2EcWlx62W4tniCNrLPCGglnai0MYsRgLQDToOneyGTAH0q1Ew7V+xVJ
	nYZzn5G2tAOXOeMtoJRRaYoWV0sHry7mnN/UYoD090O5fi3NkWe7niC++nwu514vqyO3qh6Qyy+
	HoZtZB7oD5Z
X-Received: by 2002:a05:6a00:4613:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-8723b87eadfmr9178684b3a.7.1789605925335;
        Wed, 16 Sep 2026 17:45:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1da2fsm1952194b3a.52.2026.09.16.17.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:45:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:45:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
	xingyu.wu@starfivetech.com, ziv.xu@starfivetech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: starfive-wdt: Fix runtime PM leak in
 starfive_wdt_pm_start()
Message-ID: <dfebf1ef-0496-4b4e-acbe-847064bf09e0@roeck-us.net>
References: <20260916170704.2086331-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916170704.2086331-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 05:07:04PM +0000, Wentao Liang wrote:
> starfive_wdt_pm_start() takes a runtime PM reference with
> pm_runtime_get_sync(), which increments the usage counter even when it
> fails, and returns the error without dropping it again.  The watchdog
> core does not invoke the stop callback when start fails, so the
> reference taken on the error path is leaked.
> 
> Use pm_runtime_resume_and_get() instead, which keeps the usage counter
> balanced when the resume fails.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied.

Thanks,
Guenter
