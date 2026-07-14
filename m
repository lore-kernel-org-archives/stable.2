Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2940D590
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063791; cv=none; b=MooOf131RXzo6tPF9qp/wzR5v+ZkMOfldWl7UmabexvC2T28CQqlt90J7pKd+vCV0vgagHtGxgAouwNX2XM/Rgd/paO6dxHlhIYKOLlSE3P1lpK9P8Ul6JNws39cPy9Fhw0ZAqRgXnGyohPnusDg3qfKfo/oQ1D3f9zamd2mlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063791; c=relaxed/simple;
	bh=QwQaj/jWzAPoXmwVaKfwqLR7uLUdgjQGsq85EpU2dPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGpli9skLn0Z8CSQUz6CDXANS+39YxF/yoY2cVvor54PBryN2pK/XAzgj8Yn+CLMwx9+vMDCGEH90u8noxYdkP4OJw82RCppGJUlnrVrqGYbi+NXaUorcV90lFINwOiC92qMVkbTfTo0U8Ee4FTBCa+Racw4iT8caft5MY+oToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbI3KRfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbI3KRfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C5D1F000E9;
	Tue, 14 Jul 2026 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784063789;
	bh=kfAmbHkxOGOZSvyjNYXHGCsXwJ+f1gQZquKSLvKYyI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbI3KRfQvZuVGdAlOnieGxAh6cB8kcdycwYbR/dhgR0VyVdv16RE9PGp6Iqyr9GH2
	 d1RY2f3OVqMKf/k+JSDDo2EB/iujBidjvAwWPaZqkRw6l1es+caLe3OXlOYVa7JYA3
	 PgMY2jWWtLZC4+A0K7UwHJqLv5dbHMfO3jpwuWuTF2pgLvCA31Vflk9Qg7UnqwJkzT
	 Zk5XXACUVob4H0asP3qDA6ikV1kjp9fQOIbJrWVWk3IyAewA2IK3CZQVgbBqfAuZLP
	 JmFp7WIHj8eev1KUPIElQpi9q3DsxQWRTltFfoo72RA9uIm4vNPKxM6towWbPlzq9r
	 uk8gEwyuj6VNw==
Date: Tue, 14 Jul 2026 15:16:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
	sagi@grimberg.me, roger.pau@citrix.com, phil@raspberrypi.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in
 nvme_free_sgls
Message-ID: <alanLCR3Gew9Fuac@kbusch-mbp>
References: <20260714201342.1347823-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714201342.1347823-1-nb@tipi-net.de>

On Tue, Jul 14, 2026 at 10:13:42PM +0200, Nicolai Buchwitz wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> commit a54afbc8a2138f8c2490510cf26cde188d480c43 upstream.
> 
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.
> 
> Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [nb: drop the attrs parameter added in 6.19 by commit 61d43b1731e0
>  ("nvme-pci: migrate to dma_map_phys instead of map_page"), which is
>  not in 6.18.y]
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Yes, definitely want this for LTS.

Acked-by: Keith Busch <kbusch@kernel.org>
