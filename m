Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96824D90C5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535537; cv=none; b=O6B8oge00MOBJxP6rX/yyJhhxRIcgQNnYPg4Fkj4ZIQMPXXOni7DSgLkd7IRYVtM4l9wKhuqBzGj7QA+SnlxNe8CaiBQqZeRl/sDvQsCU0MQ8UAuDvQ/QIyQwMFryKQkeULjdYzcKjCkNTb2aUXKO7MUZtG3OozqCSRLvSAYC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535537; c=relaxed/simple;
	bh=5uhsMLow8Lx02qer76mHoXCy/SCAVTsb68IEGdwbSXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFdE90Mlp4RgAdnf1PTJx9clkUCuyUI3cTvbF/MfXBo7RgF1a0miyG/Fx30iTz6oZfk+/6o0r2qV1Z+78BmBO04MKdIT19xr8pks98GjeE0efo0fSp0Ewu5muoBtnvV7nYCEdxic9+lZyqp4w+3HQUWdUpZnvdGEXfK3n3ciVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lL/IgV+0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lL/IgV+0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B5E51A19AB;
	Fri,  4 Sep 2026 15:25:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1A9B6057F;
	Fri,  4 Sep 2026 15:25:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9AFA11C78288;
	Fri,  4 Sep 2026 17:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788535532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v1mdNZgtA3Wo9M3mbbKh8ENXPA2Gg1HukmOKrHjLDus=;
	b=lL/IgV+0tG/cxZy8W9MtDYgTLdFCSAp1pFWMdy+8VxRNCLS4Vqy99w5bAWZeBgC3WbAsI7
	blqA35NXsvUgoOba39w9A/drk2o/XnufvFUm9qtEvwZXyH89zuMxBGlRxzma5+DIc9I0a5
	crtENZZ1VMCcqNVBZnWYcIsIoDuR8wemKMmeTDXSo3pcIyQs+lycebfVFiqER1eGd5OFLi
	ipLCu6FVfYyFP+2mnr9kuKljFNdy8O94U3NXYGsF4sOqqFX4o01wZvJ4VLNxQO0ofi0usj
	rIakqMFrwl4aLVWgMBuzRUXFlIHKwH3dhBvQ7dgT3YvY5rpqeSvsYz80wEq/hg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org,  linux-sunxi@lists.linux.dev,
  stable@vger.kernel.org,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej
 Skrabec <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
  Richard Genoud <richard.genoud@bootlin.com>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Boris Brezillon <bbrezillon@kernel.org>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: sunxi: reject invalid ECC step sizes
In-Reply-To: <20260811060651.227431-1-james.hilliard1@gmail.com> (James
	Hilliard's message of "Tue, 11 Aug 2026 00:06:48 -0600")
References: <20260811060651.227431-1-james.hilliard1@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 17:25:28 +0200
Message-ID: <87ecf911jr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 11/08/2026 at 00:06:48 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> ECC maximization forces a 1024-byte ECC step and divides the
> available OOB bytes by the number of steps. A NAND with a smaller
> page therefore produces zero steps and a division by zero.

No, steps cannot be < 1. If they are, it's a bug that must be fixed.

> An explicitly configured ECC step which is larger than, or does not
> divide, the page also produces an unusable step count before the NAND
> core can diagnose the configuration.
>
> Validate the step size at both points where the driver derives the
> number of sectors and reject invalid geometries.
>
> Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 45ccbce91551..ad314c0e30b2 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -2032,6 +2032,15 @@ static void sunxi_nand_detach_chip(struct nand_chi=
p *nand)
>  	sunxi_nand->user_data_bytes =3D NULL;
>  }
>=20=20
> +static int sunxi_nfc_ecc_steps(struct mtd_info *mtd, unsigned int step_s=
ize)
> +{
> +	if (!step_size || mtd->writesize < step_size ||
> +	    mtd->writesize % step_size)

I don't get it, mtd->writesize < step_size is conceptually
impossible. If that happens, it must be fixed earlier than that.

> +		return -EINVAL;
> +
> +	return mtd->writesize / step_size;
> +}
> +
>  static int sunxi_nfc_maximize_user_data(struct nand_chip *nand, uint32_t=
 oobsize,
>  					int ecc_bytes, int nsectors)
>  {

Thanks,
Miqu=C3=A8l
