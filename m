Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAA3321AA;
	Tue, 11 Aug 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438208; cv=none; b=NvPcL1pNw6HwvMbzTI3tDEvee2OK9isOvaUqh6bXG2H9D6JZ8mNhttD40nu6JYcIDeYdae50DMhgzPBQJYZWomofCcerQVzl5K8CeC4UHdU/awrnedVNdAV0QoAhLO2BnY1plzAN5uLsU6Zo524j83xbLIZfEOVTtSswInI3AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438208; c=relaxed/simple;
	bh=7/NNmBvfNtvPU76QkxDWI8CXM29DRO0e8O0x761vwDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=tOMLziFN4X9WbTxwax148/o5yWG8rot1Ul0GcTrgrNRvph3mF38Pxg+LPfpuz25PC0AyeTutpB+ZWf5m9V98AA5JU9JPg4w2zotDHvdUSLxee6lSlU0GdjLHroDcrs3cuLYHQAyRspkjFQH3VdNjxfjiULajA7WyzsuQcswRN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id AA1D4116;
	Tue, 11 Aug 2026 10:50:03 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 10:50:03 +0200
Message-Id: <DKLZHP07AA40.X5MMIPHUZEVX@kernel.org>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: scope the exclusive RWW lock
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <jianhao.xu@seu.edu.cn>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
 <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>

Hi,

On Tue Aug 11, 2026 at 6:13 AM CEST, Runyu Xiao wrote:
> spi_nor_rww_start_exclusive() is used as the wait_event_killable()
> condition for RWW access. When RWW is busy, it can return false while
> still holding nor->lock, which blocks spi_nor_rww_end_exclusive() from
> clearing the RWW state.
>
> Use guard(mutex) here so nor->lock is released before the condition
> returns, while the state flags still hand off ownership to the caller.
> This keeps the mutex scope aligned with the other RWW start helpers.
>
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

There were questions in v1. Please answer them. Don't just ignore
them and just throw a new version of your patch at us. We put time
and effort into maintaining. See also [1].

-michael

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
