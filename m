Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC8463B95;
	Fri, 21 Aug 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303297; cv=none; b=CTLI/HNEd2nP0lQuKrOjQx3tGJNZzbJUsc4U50Qnp4+CSO4zzWrJaLDqHKHIklvUOpBXqvhrxIJAwofEoBgIWtPFvlgOEged6FlhK6/cLn1iaAfMJxQVc5mlB7kPWc1og6w8hZPO/30SfMeyh3tTpbdg6zCPqgzocL3G2FFGLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303297; c=relaxed/simple;
	bh=oOuoI9+wnuoEdfiAh87q5nMwG08Hxu44X07/rH2VMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFhSQTVOy3hBZRVUK0aOjvwYpGMC5v+/fxkr6Uol6tHgWkgPKjmTbJWXOqqvPowX2u0kdr4TzT4Er/b1fiFDyxs7c/85wRdb4U8Q2L6x5HdufVQ+TjrNU4lV2TUX7yFqq/uH39rfqMJbhm//5xo0/5lwb5CZ1K6dbB9pFI4G2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=M2jn6TbV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="M2jn6TbV"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8F07A14C2D6;
	Fri, 21 Aug 2026 11:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1787303277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGEJQB9358mwZctsDDONapSyTxRcKMMADgC4+MXroNA=;
	b=M2jn6TbVDXHVkr/DG2auw74KFiKThPfC0XasZSWIF0/2H3vkffPYarZ0Z189yUSvAFBHf/
	QbLJi8iGq8/DbVwhhl3Z+c5DH2i0qrzOvtU7quhd+lgDZveIW05P/3uIoPAptls8dYDr5E
	oOqeQZU7+rq3031TM9LrHcMu2FRVn0CvkLU0PheUnT6lGAg/RscCEnLnNWAqzpZxFkv8i6
	5ZstEmf9todvM8Gtz1f3DPH91+qfKMcPuALJTE2R6K3FFDITuuY7Uc+ft9D1qhN2Dv4z9V
	u4S8i4qdypfe+OQdqztFxRKI9jUWypUnpz5o+4p92UwGFectm2NXZQS42rRXrw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 622dfed3;
	Fri, 21 Aug 2026 09:07:50 +0000 (UTC)
Date: Fri, 21 Aug 2026 18:07:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus [stable backport question/offer]
Message-ID: <aogVVwPlOmCqFsg_@codewreck.org>
References: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>

Vincent Jardin wrote on Mon, Jul 13, 2026 at 08:11:58PM +0200:
> i2c-imx rejects an SMBus Block Read byte count of 0 (valid per SMBus 3.1
> 6.5.7) as -EPROTO and returns without emitting a NACK + STOP, leaving the
> target holding SDA so the bus stays stuck until a power cycle.
> 
> It was triggered by an MPQ8785 PMBus regulator on a LX2160A i2c
> bus: when the kernel binds it using the pmbus/hwmon framework, the bus
> locks up and it does never recovers. It was confirmed with a scope, with
> and without the fix.
> 
> The same bug is occuring with two independently introduced spots, so the
> fix is two patches with their respective Fixes: tags and backport ranges
> 
>   1/2  atomic/polling path       Fixes: 8e8782c71595   v3.16+
>   2/2  IRQ-driven state machine  Fixes: 5f5c2d4579ca   v6.13+

Silly question (half for stable people, half for i2c-imx maintainers),
but the backport for commit cb2fc3785769 ("i2c: imx: fix locked bus on
SMBus block-read of 0 (atomic)") to stable brought in b460b15b3cc2
("i2c: imx: separate atomic, dma and non-dma use case") (also 6.13+) as
a dep (all the way back to 5.10!);
with that commit in, 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non
dma mode") applies almost cleanly on 6.6/6.12[1]... So should we grab
more easy fixes?
In particular, I doubt I'll ever hit this SMBus 3.1 bug, but
5f5c2d4579ca also was a real fix[2], so would it make sense to jump in
and get both 5f5c2d4579ca and 07fd9385f0d8 ("i2c: imx: fix locked bus on
SMBus block-read of 0 (IRQ)") for 6.6/6.12?

[1] just a trivial context conflict in the struct there, but it starts
being more iffy on 6.1 and earlier kernels
[2] ... We actually ran into that bug on 5.10, our kludgy backport being
the reason I noticed during today's 5.10.266-rc1 testing...


Honestly, I wouldn't have considered backporting either as b460b15b3cc2
("i2c: imx: separate atomic, dma and non-dma use case") looks too big to
backport to me, so I definitely wouldn't have done it before, but that
ship has sailed (it's in the 5.10 -rc right now, but it's been merged a
couple of weeks ago in higher versions stables), so at this point I
don't think it's worth reverting either and we might as well keep
falling forward...



tl;dr: If maintainers agree, I can send these two for a future 6.6/6.12:
5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
07fd9385f0d8 ("i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)")


Thanks,
-- 
Dominique Martinet | Asmadeus
