Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557151;
	b=rqZOQaJwvcvFYSUYULKHiu7MFY5CAM1WQ+/qomi8Zp5ZFn85Iq3dPGcWYHGWfwWZ9cF0
	 hL+w0BN6bQCNczOyx7Fwdou18ynhKWL5VDFVauHogSlNH0MKyryAPJwo6orXpa1v3Gxq0
	 GaUqjEMt3JYE0+aCDFCZIN9/F1Lfw9g7vB+mgr9XxU+I7j7ugV+R5DI9LBR6z5GbKT4Uy
	 MIOw4KJUJ6IdMir5dXzz+wiaj84PMmcVOZRMd8gCPfhTjaajMzbxHqGSmjhSAKcgyNId2
	 N1pawUEOzPsZsL6Aa6h/r3Fv/29dx77IBNz8rMeTrMQPQ0/ykj88ZJ8Q+i5+Q77Yo5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
	b=P+yIupVUgd/zAHMS49MptXMp1Bk0N97Hk0o40vjdituAXCi0t3Pcr9lMzudhauaLpNbV
	 T3oCZlo7qLzGWVErSsxIJuigH/B8/xmoviFayQ0sAWFTFLD7TY7kXhHij/YcG4J1bfGS+
	 GAaaVaItED623AIfjxvLxhQ28d832Q4D4/vNOlZZkff9MVdfQW0en4mlXIuyCPbbTMc7b
	 8I/ZCsLV0XsqIPslrJWS9dXZ8Lc9q3vKOGKmkCxvOWnmRc3CN1Pv8s8ZnEPAHmkFOZaP5
	 jbex6Q7giUNLazSTft97IS1UdkgMJ9Poxsn85hJ1mr6ZSwKf6JzTh2Ezd4ZeNG0ah4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FHl5FeOi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3E606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FHl5FeOi
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c05727a58aso56632e87.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557149; cv=none;
        d=google.com; s=arc-20260327;
        b=jVBt5yJpwLysjBM27susiy2Rl6slWlU9fso+waz0DKvjYivEZvUbSK4t5Yh2G5unQO
         NceNKFWmyFz7g+KdHDyCOdC8z9CiAhIfdl+i4jCqeUsmA8AKx8fyNi6D7assPelfcidZ
         IqQbdy9SmcUx0xZoBKN6/8BkzSjD2fHKHc/wR0L3ymVC8GkaycuDGM1j28d3b0B0og3H
         7wooN00ch/NFs/cLNeuFzBlSRAsj3SkyMdbUNjWxivCYSKcVA49tpHHLh0/ukpL3EOYq
         YsM1Svyl4OdHGDTMSHfmHKVRbrG9WNlfa9waF0chCb2NVx3K5h4f8jWIDUSJx+8ZcPYI
         l3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        fh=Vq8uPkgX1Jfmav82o+g1haBG+txX09rDf+JXnQ4dM6Y=;
        b=ahGx0uUWc0xOwbbhwZhHVblniOb8OJOAgsMdPrfUiJDrDRsAmZDWjEF4J2BjX+Yi/5
         ejzyBFCDjquKcA06g8qz/fYpNNp03+pDt80fZtvl5xpEA0m4c1wuYpo2qOEUYKx8/5jZ
         /2FMvT9SqUhxnXRkPzASh8pIo2lnsyq4ojGZrHR4ZUMAk+VIAi1itJfsn9mbpX5Ieb4T
         IkX5yW8z/YMGaooTnjHuapKMoaP33pElIOmD8DmrXMKbwkRT1Xtc2EktdU7y63qkrmjD
         wQCsG87JlbzbD6MmpRjSV7nf5H/0ZkXKTdTLa/DlWp5j8ir1mxHr+OGUtTWqNEbFrlkm
         lqnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794557149; x=1795161949; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        b=FHl5FeOijEJd+VdBtfrSXvIzf5TZ/XUmT4e+4SdIe4MSTR84j8yWGY07hR712hVUSz
         S3NWvU13WGbrjZo/yvud+wVPiRXHNSuhv0WsTXzx5Z9an4bjC+k0usNYURpdj2lMahRl
         gnsrpehRXhWm9KcEMxopNQ2yrhrPdimZesOW5j4U14jAJr47b6/72C+5zIwK2caWbZj/
         s91BmOR6K90dlVXLYweHA3CeDFFXSEbsYN7XjtTEU9sFZ/FTnjCPHmaBFhDfqjymwytI
         R1YteHu3cP9OP1lpbg5OTTNXcc6E5j+R8BHkxQmaO3OvQOtu+KumIURAWjpN8KwyKijp
         AQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557149; x=1795161949;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oqtjBd2wESHyMO5oAovp1QSWx1cXP9Xallbgkc48A7Y=;
        b=sdvV+6B4iX7lQAvfbH5nvh6l9Wh1PMCg3ytfSUCNgGSaHtpbQT06STLE58dmqolq4z
         01O5Q+BhjsJvpmiF4U7LmQbggb/iXEp7IyH3p+NZJ3DUvKx3Gcy3mR2qklVLP3Kaeb9X
         wWO60lWkmggaQaz+QxBD9MIMf4AvZaPN9/YQhKvsvbpU3PLwqftM4Q6xydwQVp9oRJF8
         SdvRgWyor1z8kX4thKX/wIru2DKeVvUbW6fyiE5UCxmUKn7r/XwPGXcvfSD4YmYWk/6s
         neX2rc6lXmyv8OgnYT/giZBa7qDLdYDL9bJvbPJ9C3/kw5whKAtwdKVFUDn2XRRNQcQ2
         Msfg==
X-Forwarded-Encrypted: i=1; AL+hErHZ178XEzaVlAzfNlR45m67q64Dv5YdwnKeG8sFEsmU3sSY6t3n6EdPj8HgZub2/UYoRSn8e/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PTZJ503PvpAvjovDmKhzJ/Su1ipgWVxk5N8H6NYP6wA0jJF/5
	su+zNRRs20LK3rngFRUDKD2dzU/nszgUMC6dN60kdlfs70mTAGJ1TmNwr9v7SMeInpBlN3yAfD1
	Tw2ESiq4ee6JT8Vo46dq3Kp3UjxYo42M=
X-Gm-Gg: AYBFou21/oo7/VhdsbrFoyFW++fB7g8fav2A4RHD9tyhStckiUqTczwCoNe/rF/2+xU
	dGG1YWc/6M4oMAtrfmpBKBg15p0TEeWo5X+Z1ISTUQ/cWXut7BzJ5JJHrBFnQQ5el9Pp5JfyDIf
	IzNfueDDHSoSR0eQuijyMB5yE6aXmg8mlH+3wZJvK8NX8ikbkWfDLKoyfVvGmdFgMtLNtMv3p6J
	O3f/WzOblelg09OB3MddqGlnR5IilXMcAoNZNw4NVgsB05fC4G6k7/UfeF5DaP0OaEobYvq+O/0
	yrf3osU9LnTq/4YYG9M4jrzKMWfPamDgoE5VqjedgvMR52aPxMCWagM3LBPPgE+LAa8xbnfkaJO
	s71MTJ/3f2voP1B0xSl9LAQ2odVRXZwix/VYXt9Hyp1IB/Z3UKjkqK0bKRmhb6WXlzxYRLjY=
X-Received: by 2002:a05:6512:402a:b0:5bf:b65b:8598 with SMTP id
 2adb3069b0e04-5c1709b1f34mr794456e87.3.1794557149007; Fri, 13 Nov 2026
 00:05:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
 <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com> <472df1c1-e1fb-454a-96bf-4a01dcd383aa@arm.com>
In-Reply-To: <472df1c1-e1fb-454a-96bf-4a01dcd383aa@arm.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 00:05:35 -0800
X-Gm-Features: AclHuK_Zihm1Bupd39qxey-TRk2fUNcW0Um962FEVnw_RYjI9CzqXZG7YgfHzoU
Message-ID: <CAEy9hNUW+o_6jN8=7RB7e-6afyiZOzLZ9DQpFOKTQCoPfvDD9w@mail.gmail.com>
Subject: Re: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [...] What we could really do
> with - which might now be viable with the recent atomic device flags -
> is a specific indicator that a device has got far enough into binding a
> driver to be past the point of waiting or an IOMMU. The
> BUS_NOTIFY_BIND_DRIVER call is in fact in more or less the right place
> for that, so we could potentially do the flag management from
> iommu_bus_notifier() rather than clutter up the driver core with yet
> more hooks, but the flag itself can't be in dev->iommu [...]

Thanks, that makes sense. v2 will add a device flag that
iommu_bus_notifier() sets on BIND_DRIVER and clears on
DRIVER_NOT_BOUND and UNBOUND_DRIVER, and test it instead of
dev->driver.

The flag alone doesn't keep the binder out, though. Its dma_configure
runs before BIND_DRIVER, and while the replay has dropped the lock it
finds the replay's dev->iommu or fwspec and goes on to probe. So I'd
also defer the binder in of_iommu_configure() and
acpi_iommu_configure_id() while a replay runs, using a separate "probe
in progress" mark in dev->iommu that is set only during the replay.

Does that match what you have in mind?

Arun
