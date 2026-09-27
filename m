Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EE3955FB;
	Sun, 27 Sep 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790543909; cv=none; b=WPABIicYitdFjQJ46u6j7/Fiv3PUbS2b9DyXmuBUgEFxNXbMy6QgH6LoXOoi0x17JErz5jLWK+E/izLl7OHFcr4orUvOVE9xiMgdG7fgNGcRq+smLmU+D7jHjjS+Qm3aqxb6z2K2T0DlaaKiQnX9h+GxiZEPkiUAWlrR5TGSTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790543909; c=relaxed/simple;
	bh=3Xm2OgF6EvOwvmY+37kzihjU6MwV9MF68oCLDz6U9uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrGhoyMf+PWe4SaLzzhVbZ4BJDQmD8YwfFJFRr1EyjBH1q/zCTC6QZ9LiC/k1oFB8jn3dbHkqrf1utBUOVKXjHaEBNchihPG6Su2xCt6U1v3qtiAYHyjEXexm1fuVAP7CMKJTAQJIoRCpf3ErjyiW1oQzXxt63Xo/uqLHvcxcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E08bXgTE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E08bXgTE"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 591AC40E01F9;
	Sun, 27 Sep 2026 21:18:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jl1zfltDxXTc; Sun, 27 Sep 2026 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790543886; bh=OvcD92nceyxOvg0pCMu4E+gtW8El/qctXapjhCl6v6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E08bXgTEjcDIBF7gyDtDP6ccYUz2Jk98AsIfIDQdXK7RXjV1BNcP9lEtoJubrtJU9
	 OQNaP/Z4TsW+5jXF1e+Qs5DdWEF8zWgfKnP8oqxGbQiEjk6QbrJKA+RZiGLIvomE8Y
	 8rH1p6gNt0MlXWX36X7KwZNXEHj4/yUXcgiwYRdu/QrHQ+38ktxY6wijNV0j75GdG3
	 Swkz34Y5rv5fpeMfdHsd967HGmnLQmenEwEO3/GskziEOuVADjWwEw7WwTyJ8+gyJt
	 9K0mu09BJPHxaQ65XxEvHnaCh4JNqL6yvTb503TN5ONS9Nyrs9lwihhL8Qu5DEYscs
	 qyqG6ySxmm1IIOMXm/81DltlmVjbKPesVsNmneFu7L7urLL0aMySHr0iOhSVXtYlTX
	 ZywkxgH7arv4g555LFjCR7wB4YrlYIrrYOIzBA4oH6dr0szmjC9JyDMYM/DF5g1g+R
	 26+0pTeQx/8/kl+1WZ7UXkaWVLShyt5+N3UXynrwqc1g2rv/4qdHr95QFeR3cYfVP0
	 7MOGRmpum/FXRrQNj9V1QEcp/R//Q0b1iC8g9AkiC01Mj4sB4GHnXQsFDPkpW22y7o
	 HVvg05Q02yifSN4AbpgCCJHqmAuObmGRpPSneoWEnoYQQUBPbDiNYS80YrNMXSUf7w
	 EwTW4idUDOWZ0x+qWCPKd/7Y=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3478840E00E7;
	Sun, 27 Sep 2026 21:17:59 +0000 (UTC)
Date: Sun, 27 Sep 2026 14:17:56 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Pandey, Radhey Shyam" <radheys@amd.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/versalnet: fix remoteproc reference leak
Message-ID: <20260927211756.GBarmIBAlcc9pP1nRX@fat_crate.local>
References: <20260913053532.1324671-1-lgs201920130244@gmail.com>
 <cedf454c-1840-41a2-810e-16f0cfee452d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cedf454c-1840-41a2-810e-16f0cfee452d@amd.com>

On Wed, Sep 23, 2026 at 05:10:26PM +0530, Pandey, Radhey Shyam wrote:
> On 9/13/2026 11:05 AM, Guangshuo Li wrote:
> 
> Nit - EDAC/versalnet: Fix remoteproc reference leak in mc_remove()>
> mc_probe() acquires a reference to the remote processor with
> > rproc_get_by_phandle(), but mc_remove() does not release the reference.
> > 
> > rproc_shutdown() only balances the power reference acquired by
> > rproc_boot(); it does not drop the device reference acquired by
> > rproc_get_by_phandle(). As a result, successful driver removal leaves
> > the remoteproc reference unbalanced.
> > 
> > Call rproc_put() during removal to release the reference acquired in
> > mc_probe().
> > 
> > This issue was found by manual code inspection.
> > 
> > Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Thanks!> ---

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
