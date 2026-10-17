Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEA382F1E;
	Sat, 17 Oct 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262087; cv=none; b=Q19ueta1wOigr2+iwHinCHLbi6aiQRDeakmn4szeaUnJZbxjGRr0bEg8Pys0vSg4SS8SAuZuXGFrSBLZojEvNMx8Y9hZTiq84zNBngMM60JQCFP6YnkvikXhYb46NWtzGLhwd6I15movcL76k7xTwSFV2YsJWwkZr3tBkkw1BOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262087; c=relaxed/simple;
	bh=WjtYC0JJVVHPGFt6KM5QwJv500+Juc/Cr2pUlgFC7Vo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0u2JTXlqr95jKsTdZqnxHdOmlrP8ar0akoWcKvUskLjhkTgS7Q/peKlzne6FNekOcys+SD+mJWEu7MngvGXpd6c9efaW4mYkb/giAsgAqg228Bh0OKXGwF/HsPFXOF6UavH0rEGhgskKs9CUtPJfGLt8PNmvaWrrciWup6x0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hfX7dMXl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hfX7dMXl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=U38TNxbjZWPafcS+7I1nkZg5tbz0P1qs72gc4jTBwsI=; t=1792262084;
	x=1792866884; b=hfX7dMXlEcQAegaKx9bxeQR1JIanTBYyqYZlNJTX4A/JLSFuK+4mCSpN6yCFi
	rE9ZPlLa1wxhCQQ4fjKGrZoMpDUp52Y1dLmHSFEJjC5z/OFqHpy8nFIME3eOI7v+wjcdDXy6z2CBL
	QNnTeypSbB5WfA9TjyfQHxA2ejG07hCkoOzTXJvetRuLhXT71vyvtQQ3tLk+3qxr5xhl/SEUcSLbr
	4XKL+k87gnTfkEKQj/4vQXxAeuLIuELNm1wLDyK83IMTeIb+MPeN43a0j6sL2IGK6sW9nR8KF1b6U
	1wn6OT2AWedUxvoLnE0UxGw8fczRPxOYFP1dzUobyrqq9tGNHQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xI9Eo-00000003JjI-1CiV; Sat, 17 Oct 2026 20:34:34 +0200
Received: from dynamic-002-242-066-005.2.242.pool.telefonica.de ([2.242.66.5] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xI9En-000000049Wd-42q6; Sat, 17 Oct 2026 20:34:34 +0200
Message-ID: <e94382c5fad225eff08bd7126997eeef05d0287b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: maple: use the matching IRQ cookie
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  Jianhao Xu <jianhao.xu@seu.edu.cn>
Date: Sat, 17 Oct 2026 20:34:33 +0200
In-Reply-To: <atO85d3tjAyPiPRF@lithos>
References: <20261009040248.1136356-1-runyu.xiao@seu.edu.cn>
	 <atO85d3tjAyPiPRF@lithos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Sat, 2026-10-17 at 20:22 +0200, Florian Fuchs wrote:
> On 09 Oct 12:02, Runyu Xiao wrote:
> > The Maple DMA and VBLANK handlers are registered with
> > &maple_unsupported_device as their dev_id. Passing NULL to free_irq()
> > cannot find either action, so the handlers remain registered and the
> > IRQ core warns.
> >=20
> > Use the same cookie when freeing both handlers on the error paths.
> >=20
> > Fixes: 17be2d2b1c33 ("sh: Add maple bus support for the SEGA Dreamcast.=
")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > ---
> >  drivers/sh/maple/maple.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> > index 5585f220e..7df88e00c 100644
> > --- a/drivers/sh/maple/maple.c
> > +++ b/drivers/sh/maple/maple.c
> > @@ -863,10 +863,10 @@ static int __init maple_bus_init(void)
> >  	kmem_cache_destroy(maple_queue_cache);
> > =20
> >  cleanup_bothirqs:
> > -	free_irq(HW_EVENT_VSYNC, 0);
> > +	free_irq(HW_EVENT_VSYNC, &maple_unsupported_device);
> > =20
> >  cleanup_irq:
> > -	free_irq(HW_EVENT_MAPLE_DMA, 0);
> > +	free_irq(HW_EVENT_MAPLE_DMA, &maple_unsupported_device);
> > =20
> >  cleanup_dma:
> >  	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);
> > --=20
> > 2.34.1
>=20
> The patch looks correct to me and works like intended, that it frees the
> corresponding IRQ handler in the error path.
>=20
> Reviewed-By: Florian Fuchs <fuchsfl@gmail.com>
> Tested-by: Florian Fuchs <fuchsfl@gmail.com>
> Fixes: b3c69e248176 ("maple: more robust device detection.")
>=20
> Just a little addition, it looks like commit b3c69e248176
> ("maple: more robust device detection.") introduced the issue, where the
> static irqaction with IRQF_SHARED, was replaced by a request_irq() with
> a cookie, but the free_irq() wasn't updated.
>=20
> I tested the patch with a forced failure of maple_bus_init(), which
> gives the WARNs and keeps the handlers registered in /proc/interrupts:
> Trying to free already-free IRQ 69
> WARNING: kernel/irq/manage.c:1880 at 0x8c0522c4, CPU#0: swapper/0/1
>=20
> After the patch, the IRQ handlers are unregistered in /proc/interrupts
> and no kernel WARN is shown.
>=20
> And tested if keyboard, mouse still work with the patch, which they do.

Thanks a lot for both the additional review and testing!
Since I'm using b4, it will automatically pick up the Fixes tag you provide=
d.

Will apply the patch tomorrow or Monday.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
