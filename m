Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415337E5D9;
	Fri, 16 Oct 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159454; cv=none; b=XV2uHRViNcYY1A7W2kAsbHddSWX0k5hvA3rx3Edaucys9tPdyDxHtzWLiHkREm3N8cEli2yQn4BSYM8PYTviOqphJEDU+yv7zysWUTl2R5XXC0YCgjJ2DYURqL3acjWGxMSPr5tyBgppljuyp8IHcKNCnUCLqdoKSIn4Inxetzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159454; c=relaxed/simple;
	bh=xV4TVAWofMnQVMNSmbxvJ/W+ijl/Q6S5uJJqN3iUJok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDGB7zXx7WyTSmo6CZFqhdII3RL039uxQt2Gz5KzHeDeAN3ChT7s4/y9kGiIcgRhtbvMsEd5Uf802p20yfr3NJ2qaeTE6t72Zm4AENPzSSn4VUao1s+wTPs0Exlm6oV2Y+G7egTTILgN0hThaJ5XReVMrRgcD2jbVhyquYHfKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IuEps/GS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IuEps/GS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KJM0CgT4xb7zXt8wshrwxDE5N3S72S+N5ndebAadhtQ=; t=1792159451;
	x=1792764251; b=IuEps/GSkIFPbiNebdsOpbqySv09ydhWTJUflinmQzH1NAXQJ5RPCAGbs1EEl
	4o5Fl+ObZ72vWN58E28iVTPyrIt0Cuteq2grmmk0hOjKsO+0zvZwNG2JktmszDtym3mTJPRgTZJe8
	2hAaBvEhokE12e0qykEEjYoVkoXz0vjEfEYaKqjne+d+OxeEPaEdXobIg/H9YQe3OjjFlm/RBOH3t
	uwcgJB4ZBPrD3JGqcmpEem2UdN6oB4iZgjVo23CDhlb7ERBejvqYrc/GldRiqJYC/KYarKscF9RLZ
	DwVVwqBQ0ASo4Yhu2+Y5Hh2gEMHyK0tk+go32BPioT2qWy3KXg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xHiXY-00000001cgl-1nCB; Fri, 16 Oct 2026 16:04:08 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xHiXY-000000041rl-0qR5; Fri, 16 Oct 2026 16:04:08 +0200
Message-ID: <b208cd26ab1b7aaa42de2a284332e11b4abbe7bd.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: maple: use the matching IRQ cookie
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Florian Fuchs <fuchsfl@gmail.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu
	 <jianhao.xu@seu.edu.cn>
Date: Fri, 16 Oct 2026 16:04:06 +0200
In-Reply-To: <20261009040248.1136356-1-runyu.xiao@seu.edu.cn>
References: <20261009040248.1136356-1-runyu.xiao@seu.edu.cn>
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

Hi Runyu,

On Fri, 2026-10-09 at 12:02 +0800, Runyu Xiao wrote:
> The Maple DMA and VBLANK handlers are registered with
> &maple_unsupported_device as their dev_id. Passing NULL to free_irq()
> cannot find either action, so the handlers remain registered and the
> IRQ core warns.
>=20
> Use the same cookie when freeing both handlers on the error paths.
>=20
> Fixes: 17be2d2b1c33 ("sh: Add maple bus support for the SEGA Dreamcast.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/sh/maple/maple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index 5585f220e..7df88e00c 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -863,10 +863,10 @@ static int __init maple_bus_init(void)
>  	kmem_cache_destroy(maple_queue_cache);
> =20
>  cleanup_bothirqs:
> -	free_irq(HW_EVENT_VSYNC, 0);
> +	free_irq(HW_EVENT_VSYNC, &maple_unsupported_device);
> =20
>  cleanup_irq:
> -	free_irq(HW_EVENT_MAPLE_DMA, 0);
> +	free_irq(HW_EVENT_MAPLE_DMA, &maple_unsupported_device);
> =20
>  cleanup_dma:
>  	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);

I'm not 100% versed in the IRQ code but looking how both HW_EVENT_VSYNC
and HW_EVENT_MAPLE_DMA are registered using the maple_unsupported_device
cookie but not unregistered using them, your change seems logical.

Maybe Geert or Florian can have a second look and add their Reviewed-by.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
