Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C481FB9
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001464; cv=none; b=lHKU4gbjjRIB7NJsdpTGsFx/5TA1JD6mEHHwD3VmYoVw6vCS0tv42+ooMwxTRYrK36QXqsaSGVF7ouT8aIyoQ4g5FUXmBmxo1NJ9In5SO5kAlafKs9NChhNG6TZPYR4HxcQ6sMV16MILKiFsEm4GvDzt9C6Mpr9W5SIQnYsu+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001464; c=relaxed/simple;
	bh=Ve7taSANLZuMYoPDi3+82QT4KBdCFgR0shejjYB7kY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpjIjZecGSk4j6aSkQr8lMzeNAlu6JQKPKSpq33HU3NrTMYM86R34ewE5O4ea26FFJzeNi7LwYajkxBTO9iXAKPmeGH1GIJn9Pf8cdaPeMzhNlgCCl+hiLEl+Ax/DcejTPxawQ5gZ5IyHLRLMZRocn4FNuHsQ7hH6oamy7wvd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCT7nv6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCT7nv6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B751F000E9;
	Thu,  2 Jul 2026 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001462;
	bh=eGN0W9GqOz+nTHlByNW+rSC+GtM2Q7ANNhzo3cBVLxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCT7nv6ZJK04r7SlRBVwdWAOw5vhfcXg9oBSIgrQCLeR/5IVs8sXPjpvpPDwGnzlA
	 ulnzSuQJhkScm77eNGaEt8zK3ZcBv2z6oRU04E41iujQ85yJDODnoSr13yDMz5rPLu
	 UmMiMkfMLz/glciTOR+VrtZYLPTz/gzZ7rsCHD6I=
Date: Thu, 2 Jul 2026 16:11:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: stable@vger.kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
	mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 6.6.y v2 0/2] mtd: spi-nor: macronix: backport Quad Input
 Page Program fixups
Message-ID: <2026070239-proponent-lazily-990a@gregkh>
References: <20260702021842.2771498-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702021842.2771498-1-linchengming884@gmail.com>

On Thu, Jul 02, 2026 at 10:18:40AM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> This is a backport of two upstream commits to 6.6.y:
> 
>   commit 798aafeffb36 ("mtd: spi-nor: macronix: Add post_sfdp fixups
>   for Quad Input Page Program")
>   commit 797bbaa7531f ("mtd: spi-nor: macronix: add support for
>   mx66{l2, u1}g45g")
> 
> Neither commit was tagged for -stable when merged. 6.6.y also predates
> commit 09e5a29fa3ad ("mtd: spi-nor: macronix: convert flash_info to new
> format"), which landed in v6.10, so drivers/mtd/spi-nor/macronix.c is
> still in the old INFO()/NO_SFDP_FLAGS()/FIXUP_FLAGS() macro-based
> format. Both patches have been adapted to that format with no other
> functional change; patch 2 depends on the macronix_qpp4b_fixups hook
> introduced by patch 1.

Why not just move to a newer kernel to get support for these newer
devices instead?  That's much simpler and I'd prefer that over taking
much-different patches instead.

thanks,

greg k-h
