Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB13F1AB8;
	Tue, 25 Aug 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662506; cv=none; b=jv8GOOpcg4TLvcH7E/eRpFWxACio2ixA61cJ+QQjOZhf2qtjx7ZsQCwzTPw8RvQlYMbSY9tD0Lhg9Uou0S+NKapPWNXSGv1xh3H2pKz+Vri+bfSASzJ1YH5uWjySU9WsMBdsYmkALpR+v7I3Xp4Y9wnjD1rw27s2WynHTSskvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662506; c=relaxed/simple;
	bh=VLAy0C1DrIqO9piddMV94geRcYhGFe2jnsWYgr4FjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igRZdZl0Yj59PdUVnO56qycmHndRvGUm8gzi9v4XNZwf24Yh4kG3+N4YMljnEhszY3db3NSpZ9rkkU4WR+GC7Wa/hB6Ddg7UnHO4xQefKhcFNSug0bPyGbgQFoW8gwrv7ZPirO0xwadIucHWfk5fB2TkbtQdrpO0YJFEklVdiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=34qD/RmW; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="34qD/RmW"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DD6F414C2DE;
	Tue, 25 Aug 2026 14:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1787662494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLDj2hZCve2ZWWLDxKombVsx7zXm/NyM2HtS7v1LdNE=;
	b=34qD/RmW3+YAfFU49MNmHd7+ykPxdE3JfNqfWQGiB7qIcaGMHrcpvRq4xnu2MOVwCKGEcI
	wMQD841PBTKqMyrQCUmnj5PVf1Ba4K+8EIVmcrNNwGwkloZ12UHr38dDA2El9tZpXBayNw
	Tcfg7mpgC0VK2f4yq54KKSZtHXBbg7P28Otj3GK0/rPVKQ4auwEr1cHA/JZZCUmCG7g2mt
	Fu45QbiuoeeyZsBYbzQcUYP9JgS0e0SESGZCW/v9aU4BFcJ9YVxCC9QArt9gJ30cND4nkm
	ces1Us63jDfQcluY0mPH44hR/ZlfYjfjUIBR4PKgDSgs0fcaXSsk/9xnE2IjHA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2988523d;
	Tue, 25 Aug 2026 12:54:47 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:54:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Vincent Jardin <vjardin@free.fr>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <ao2QiAGMU3g5dQB8@codewreck.org>
References: <aogVVwPlOmCqFsg_@codewreck.org>
 <202608250009.7e963743cf842d4e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202608250009.7e963743cf842d4e@kernel.org>

Sasha Levin wrote on Tue, Aug 25, 2026 at 07:49:30AM -0400:
> Dominique Martinet wrote on Fri, Aug 21, 2026 at 06:07:35PM +0900:
> > tl;dr: If maintainers agree, I can send these two for a future 6.6/6.12:
> > 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> > 07fd9385f0d8 ("i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)")
> 
> Thanks for the offer, but let's not take these on 6.6/6.12.

Ok, thanks for taking the time to check and reply!

> 5f5c2d4579ca splits the read path, and the split leaves the block_err
> handling in the atomic variant only, while the live non-dma path ends up
> back in the unfixed handler. On 6.6/6.12 the block-read-of-0 fix that
> shipped in 6.12.101 and its 6.6 sibling landed in the shared
> i2c_imx_read(), which both paths still go through - so pulling the rework
> in would actually re-open the bus lockup those trees are already
> protected against.

Yes, a backport would only make sense with both patches...

> Your premise is right that b460b15b3cc2 is now everywhere, but
> 5f5c2d4579ca also carries five Fixes: follow-ups, four of them tagged

... but now that you've pointed out the others I agree it's more trouble
than it's worth (even if they all apply cleanly after trivially fixing
5f5c2d4579ca's backport), so I'm fine with this
(And that can be reconsidered if more people report timeouts fixed by
5f5c2d4579ca...)


Thanks,
-- 
Dominique Martinet | Asmadeus
