Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C15417BD8;
	Mon, 20 Jul 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564019; cv=none; b=ELP90Ncr9Ml/lg/BzLynmsrYHHGbWSj5TunhQe49VqXbKHyATmAblvI9CdaBvgtc0OFAHPvqAhK7tgLcub39L5WMGfCdF+e6YWzz231HAvloNNjVNKoWaSLAaBZdryZv5njw9qVKvaWcsRhJrz4gyAHqrK4SOvcRLbHVhxgasJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564019; c=relaxed/simple;
	bh=rddefnjqeBn9YU4AjS8AdvKa6BMVHj4EI30MkO6IXjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX6uHpj2afND2v7sgq0nGUMsLeLTnbXbXheZo2kn/1dSwC5nki1b5YHskSGEaaOhmiDFoSXaxESTfOi9R8hOxrNBh8Phpl9HyB1vELHcCW3FZTNnxc+dZYFJMfgKdvWjSA7qgsKEB+GlFOAwHhj1lN8mgkk3iYgPNCZ9uR/rv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R+dVFPYm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R+dVFPYm"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CF8A40E016E;
	Mon, 20 Jul 2026 16:13:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ba4Ohxi7zFA4; Mon, 20 Jul 2026 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784563992; bh=6p5p/OEmMZ2bV4S/814RXv/XJvzxkEsKIVzh8u6Uyk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+dVFPYmt7dZtmQJpxrcjSeLR1ENiYl640KxCzvoPULcx+VeFmyVDcZHwpKi29mIP
	 cqGxeclfOmjhtNf6fqBUSsgJl67MoMU7aiA2Wr9Ay7oCHK2tOxsDL/WGV9dESNHQQm
	 O+xj5c8S7HzlSYnlK7V2x+6jTZWJ4sIsrME2WgE4cM5eIz0Sa0TnF89tZUoOj8Vjgf
	 vqxjEYvuA9axBrhqZvwu9NCcjpSSXR/y29agKt05b0w3wdsVUtXXiQ8azE9lTOC+bM
	 85r7/rAk7EcUtzTKRXV0Y/EBcGRq46+oQI4+8Q8VvbMPKtKroJCSH6hDDuBYD+LnLy
	 oTFiV0H1gGIodL5rfMSYVSfFs3ysFYI0GbhaA61rROLUavYvyrbMrogKbqlZDccd3M
	 i8OBeF0K8MrBZMFTxx15/62hW/31TXylURHwWDdsvji1PHYJ0BbWd2ptAWOXdVFyd2
	 eqFl2dnTiuYb86bb5wL0x5+jp/DSQ9+pfc4FSOdt4ddy2aWIBrd6v7bbGr0BEuQu6X
	 3oPDUjEVDZyQ/LMHnOn8lIBiEFPlAbZBc86HSMtfM4Kj5T53IaaoKXqA+vRv1MR0di
	 o5sEVqIihOnq0E1/ytm5u7clUZzGQ+4ltXOKEIjDfAA1WxfxLMaOV+165UFV0lCjM7
	 Bi+QL7gGjndbFpCHhbSf2CMw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EA0140E00DC;
	Mon, 20 Jul 2026 16:13:06 +0000 (UTC)
Date: Mon, 20 Jul 2026 09:13:03 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Rounak Das <rounakdas2025@gmail.com>, tony.luck@intel.com,
	stable@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/altera: Fix device node reference leaks in the
 SDMMC ECC setup
Message-ID: <20260720161303.GAal5JD89lrQVa44ZV@fat_crate.local>
References: <182c3d64-17b7-4e18-9bbe-2fd97eb231a2@kernel.org>
 <20260717131720.19038-1-rounakdas2025@gmail.com>
 <e1ef6af9-3040-44ae-ad00-5e9011c8edda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ef6af9-3040-44ae-ad00-5e9011c8edda@kernel.org>

On Mon, Jul 20, 2026 at 09:13:25AM -0500, Dinh Nguyen wrote:
> > Under altr_portb_setup() and socfpga_init_sdmmc_ecc(),
> > of_find_compatible_node() was being used to look up the sdmmc-ecc
> > node. This node wasn't being dropped using of_node_put().
> > 
> > altr_portb_setup() did not drop its reference under its success path
> > or on any error path.
> > 
> > socfpga_init_sdmmc_ecc() did an early return thereby skipping the
> > common exit label and thus leaking the reference.
> > 
> > Add the missing of_node_put() calls in altr_portb_setup(), and route
> > socfpga_init_sdmmc_ecc()'s success path through the common exit label.
> > 
> > Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
> > Fixes: 788586efd116 ("EDAC/altera: Initialize peripheral FIFOs in probe()")
> > Cc: stable@vger.kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260708091135.94114-1-rounakdas2025%40gmail.com
> > Signed-off-by: Rounak Das <rounakdas2025@gmail.com>
> > ---
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

I'll hold off on that until the Sashiko preexisting issues have been
addressed:

https://sashiko.dev/#/patchset/20260717102549.13309-1-rounakdas2025%40gmail.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
