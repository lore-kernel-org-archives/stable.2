Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716268;
	b=mRhIlzk/56FOYWhNBZVpJ45+Bac8QmWru0pJrnMicaIFlHiYQPCdBY8MWOFRMOEVFCGZ
	 YjcpT2vZ9nuBhAT27ABj0hj4wF/aTza8VJ666rqFbBQ5hPqC9ugaxu0ObCEI+jmaFMzeZ
	 3ejf0c6m491vBjwA6qjPatt8WNs8l4yemlCuXBizuNKutrJ9up4x6Iq043XkhL4SB4qb/
	 OHFd4CDEPDLk2+i6m0+TD/Rcc77lrAseJs6vHIqXi/wRRnCRo4QOTsJC4Al2fcuKbN4vC
	 3lWkWf0LUyaGgKdMagpM+9tfw4brQNku/dVUss/9Br+8FmhsxMG0XeJT6HKi16+XI1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
	b=xBbUiAV58y42LxC5ZNi2UwWJ2X2n5cEVplt/3Nkx57BGbigP1/ILH/wGXx/YpRCawVYF
	 u0aqrvCf+K/ISoB6ZULF6eVWmnOsdfCoJzKdzun3mq2kOkzdAOP+1Ly5DcyGAnHwetEkt
	 tzINBeIAQCyWSpUkuu6wa/KwSSBa3QqDU+IK+3qtD4DYY+bNOw4f8G/fyaLSS8U5iX/9P
	 4YbDuW/O32XKy701ANJDCvu8fz7g53PyqDbpQePf7EuWFHyiAkBea2BXpK2oi8hon3zVt
	 12CtKzIkZOua6PH7913faq/35S/RTPKrtMwFbx4gVhyuLXJhng3l2TfXbw2Imju8FMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uZnFdR+L;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05013606D823
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05013606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uZnFdR+L
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so5584966c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716267; x=1794321067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
        b=uZnFdR+L3OPiUEGDCpAZ63X/Q7vx/nNunWYSlDlH2EK35tSe3/smu88ZJx1AAwhuo5
         Q3CY1EAeDaqHnBoDcUJf+EULvzzko0oZXnKZzrnGGQwHTPuAh+o3bw8khaiYMnrkIv8t
         eMstjo6slcdCOXlnXjN1s6rYEEDvcCJWXrVkoSD/QJYsKUgURH1wYAKmqhkZ/hTIMQQl
         teAmWmffecIYuTso12x4VaZ4o678Rc+KMOm906DK4yLeZdXtJrz+xd6Js1hkpyR/cqFM
         lLT4B9F2fL5tjKpWgo0RSY72MlPKzPHeTh+czDsAr8I05RofyJ13fG9FTr4P1goSvM2i
         ryNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716267; x=1794321067;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
        b=UC0nn3NwtfTOEhs+yVKMbqJ8yIQ7aG45NA3ejQkpBN41X9iU3NStjk3zPZ0kbMvBgI
         0I+QTG0S/oADFn8kzC+8ftYmVbcLZE2tm9H6kkKfEfA6IrGBMv7N2zhTV6qXnQ1AVPO9
         j5jMDbg6DWgWTYZkePmpo5oiHOua8+dpq4R0KxdAl42OyEE9LwMJ3X6wjf1onpcgE2xl
         X6AamxWd4bkgQasNKJ8HADbzT6QsTOW0ekJGQsq7vIK5PhSeX5Sh8GY+tMrxBp5/2VIS
         ngzStShtXigouBtiXVMicz0/6vuj5yqFLITe/cE9OemRkNeD/ViwHBy0jn5lVx3V2CKt
         5rfA==
X-Forwarded-Encrypted: i=1; AKwUvBwIA0Kh9sIyfUL8c9xWXruo1h0f1iHfWcLW+ps6DEsh7/pL+H6rFqN0kwpr4XmzMdPntOv7hPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fhUVNE92n8+hApWc8CJX9OXAB6t5jZcBLwRFRevqh7YKLW92r
	Z7RVwHGtSKepie/Pn4xocgLPDqoS8LNsTH68kIA8WklKu+391hrihWVpNpUKnOQd380=
X-Gm-Gg: AYBFou1w8MDZJsGoa18FBveDnGG1Ckqfs1VWq8pjkzfH9IxSfJyZ93RcoD/mkq/Wjec
	USdUIm4LqZAQk9i1VyjgimpDQfXSwjrnmvgJ/Smy6OgIeVJ18Q1pvD+Q5dnEoc8bfBisBlDpLrZ
	dhWvFeSrPOSFlDtEx+SFKs2obmiL8u6wHfvX2717twif+p3czHxaehFUSS74AHBOsayhNp03+6+
	kv2S8/w+Eiv55FOo/okSj71D+YN2RSotaiG/z/xgdVxKM4NT8TJ6ZgyrxK+JV7FwfpiEVw59ypH
	oY/dUn+HggG3hp/Ws8jBhmNrcjQLZkoPn6nckIKfOwGatnxedCK9Flqg851/Gz1M4hKJANt64Ic
	DBgVRlxUsSGBhlXl9skDsuwI/rCuk6squ6mYYZg/i81mzzEhDRpEQbHUK/n5d3ke1IcVQdMIkpS
	M/CzZU0VC7nW2FFT3zgSTQzpFcdc2PFsBF0IxibWwXC3rbK5QyqLbhEoDUb24RVLNNGtShCHSV+
	emOp2VQMLY1WqAcSvzlcNpklKQjbNObzCWQ6MU+YsfBQ5Y22cmWNC8XYyGDDNKTHv0d7sZtnPvJ
	34NvEW8HA8A6/FgIPhUpQuuQNqjj6YYYatzYpOmXfjKhuVT3gjVYN9CM0+cCLxYTvH4loHYa4MA
	4SEYss4wvDDHEzYn6vZRslDw06gSP3Xc3NQ==
X-Received: by 2002:a05:7022:f908:b0:14c:d84c:7182 with SMTP id a92af1059eb24-1ac5da75597mr17665992c88.22.1793716266905;
        Tue, 03 Nov 2026 06:31:06 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: arnd@arndb.de, ben.hutchings@codethink.co.uk, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261023153645.37546-1-dennylin0707@gmail.com>
References: <20261023153645.37546-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] block: Return the soft block size for compat BLKBSZGET
Message-Id: <179371626606.3691261.1284483179085449929.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:06 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 23 Oct 2026 15:36:45 +0000, Hungyu Lin wrote:
> BLKBSZGET returns the block device's soft block size, while BLKSSZGET
> returns its logical sector size. The compat BLKBSZGET_32 handler uses
> bdev_logical_block_size(), so it returns the wrong value when these
> sizes differ.
> 
> For example, on an x86_64 kernel a native query of a RAM or loop device
> with 512-byte logical sectors returns the initial soft block size of
> 4096 bytes, but an i386 process gets 512 bytes. This makes 32-bit
> blockdev --getbsz and the BSZ column of --report disagree with native
> queries, even without a preceding BLKBSZSET.
> 
> [...]

Applied, thanks!

[1/1] block: Return the soft block size for compat BLKBSZGET
      commit: 57cd1a08717690e5ea01d7ac7a96bb33a2dca117

Best regards,
-- 
Jens Axboe



