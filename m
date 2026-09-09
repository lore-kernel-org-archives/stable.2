Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEA4AF69B;
	Wed,  9 Sep 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951486; cv=none; b=bkdLOmfVMORKeCX/RloZs3BaxK+yYnotUnT/oPscsNFPS2mYwBV213GgPOWxhADRXFrFp+HfhGPewYz5RjofIJRcQ864FAzHcA0TNhCy3JuUQnrskwQ0UI+JREzDxyRgMGhviI6HL/L7fSeeaThjU1jGhrmH3urhhhq0VLiwhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951486; c=relaxed/simple;
	bh=IB30haaMQc+CRjCxPP5ufooWqCGMlQrEvA2ADOz2CsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcxPMDQygHcYJVHPWBG8xw9JJtylyFVRGGbKZc53cGE98PntAosESPwG06zsyhdQ47rNeftRZaPyziwjkCM+1Fao8X4fHbqKiCodcG+qimQ+K+F8NJpxjCwJDd3nfw68i2JcDtmPTVIGdOWojzKmZwim2pb+G2e3DsBXx3zXmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfsz9S9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfsz9S9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF01F00A3A;
	Wed,  9 Sep 2026 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951485;
	bh=LZMz4NgLdZkzAN05hF6jIWp6y0ebT0w6T9WIRbFYJHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cfsz9S9eYt50PcqDw01unIXgIivixip+nXw/NrMYuKTppXIiAwGj/6zydRsvyEkra
	 AxBXtESsK6q/htK9j0xvSYu5SCz8uNTzRkREz7zc3sSiqW/+qLnxo3ewCSt+OBH5hC
	 RaCGIR0nPQDE0BbECmeHLgwpm9qak7/BCDEuf0C1D3D84FHWFX6ASf/rnupJ8aF6Nf
	 jWGZVcFOXgRI3Gnpz6yH8C3+ZWzK8AdGgTlng3q0+eiUwCPLOBqtNn9PK84rluwZgf
	 MofkHZ2lc2DYHLbM1Fq6WlIakY4gnJ18HT3fVUDTkrh0xGKNByNt8UoVKAYyJOWMYv
	 KgQP2yiF+mcCw==
Date: Wed, 9 Sep 2026 12:58:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Roland Waltersson <roland.waltersson@netinsight.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
Message-ID: <aqE7uftz1jdjT_w5@ryzen>
References: <20260904134310.1465051-2-cassel@kernel.org>
 <ap5vFBMRkoe0NF73@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap5vFBMRkoe0NF73@ryzen>

On Mon, Sep 07, 2026 at 10:00:20AM +0200, Niklas Cassel wrote:
> On Fri, Sep 04, 2026 at 03:43:11PM +0200, Niklas Cassel wrote:
> > A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> > JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> > 
> > The failure is seen as soon as the ahci driver is probed, and booting with
> > iommu=off does not solve the problem.
> > 
> > Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> > for HBAs that do not support 64-bit addressing.
> > 
> > For HBAs that do support 64-bit addressing, the registers are read write,
> > with a reset value that is Implementation Specific.
> > 
> > When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
> > addressing, and a 32-bit DMA mask is set by simply clearing HOST_CAP_64.
> > Thus, in this case, we need to explicitly clear the registers to 0.
> > 
> > Fixes: 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585")
> > Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
> > Cc: stable@vger.kernel.org
> > Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
> > Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Hello Roland,
> 
> Any chance to get a Tested-by from you?

If we get a Tested-by, we could send it for v7.3-rc3 which will
release on Sunday.

If you are busy, I don't see any problem of sending it sometime
next week to target v7.3-rc4.


Kind regards,
Niklas
