Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09F3B42E4;
	Wed, 24 Jun 2026 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308954; cv=none; b=ZxlKNHs6ckbw3ktcFntOsCGuBy07C14ldwzN91wDzLVqpfn4OrHUQ6KbTUAu3iVrMQX+HnOiuEjJYAtXBy2GV+GK6/VCKbBwNX6eQUcwa6KGfWjkr8EjVtWiGmabjj5A9s7UbIF5nXZN3PuXJX2PVzrjcUEu3GzUJPj/TTFFA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308954; c=relaxed/simple;
	bh=loUJxiJ/NjSSqvgyNBzty0z363aI5eLAG8gds6Fky8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T44EAhJFigHEO+RIQAG37LrYTtoB253CY1KYk5vppkZj7ZwQEt+dm9F2SobEiqgIXGxBuIfvUB9v0etfTOJcLjwSpwEp8H1JZKqmxstG0wo1itSIhyzJIAeJsuCQ32zaVMKRSYxoZWaWIac1cKBOHpW8EDtZc8BCvsOZpVJxRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NU/fd+Hb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pihjrs8n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NU/fd+Hb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pihjrs8n"
Date: Wed, 24 Jun 2026 15:49:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782308950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWlmJ3AjgAQ2KwtYYm4dQAFpI1/acxUE7N9AR5/HyRk=;
	b=NU/fd+HbLdNNDHUgWUioiBEHwPr2IT8tpqh9ffhzVUHw40d3Bu9f8yDdZ68YtpqOGfK8ma
	x72bPJp7Bz+ncZknGeXRrTaEsvYGEGD/eNKOJJBWh3VmdJwLpI+Yppbq/H9lGyQ63xJ3GG
	IQPElvH/CYcwrMyde68ymEi12Yi0FV3V1bEEYs11m5vexKNs2MIBCVDPJivtumiaJTBX7c
	st3kWaPgMbcquuzZmMDCsIo+4Au0smqnSuu48aOch1pu7zkKWFMaF+c9TpiDwTAVqYaxcG
	j0N67WLZrarvNHlBp5lS10L/egyzs2+9B6gsBvN+bISDNqlQKnezJrTdQyQYYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782308950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWlmJ3AjgAQ2KwtYYm4dQAFpI1/acxUE7N9AR5/HyRk=;
	b=Pihjrs8nNq/ioaSvLpyWo7F9SHAPB2bAOqWKH4VR4+9xBRubKSJERr4Y5725DzDBhkhRQL
	rYzkoeMfSzha2aDw==
From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Carlos Song
 <carlos.song@nxp.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] spi: imx: reconfigure for PIO when DMA cannot be
 started
Message-ID: <20260624154905.3d465e47@mail.linutronix.de>
In-Reply-To: <AM0PR04MB68027B9C426D7CD42E256B92E8ED2@AM0PR04MB6802.eurprd04.prod.outlook.com>
References: <20260623153240.57185-1-javier.pastrana@linutronix.de>
	<AM0PR04MB68027B9C426D7CD42E256B92E8ED2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

On Wed, 24 Jun 2026 09:22:02 +0000
"Carlos Song (OSS)" <carlos.song@oss.nxp.com> wrote:

> > -----Original Message-----
> > From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> > Sent: Tuesday, June 23, 2026 11:33 PM
> > To: Mark Brown <broonie@kernel.org>; Frank Li <frank.li@nxp.com>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Carlos
> > Song <carlos.song@nxp.com>; linux-spi@vger.kernel.org;
> > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org Cc: javier.pastrana@linutronix.de;
> > stable@vger.kernel.org Subject: [PATCH] spi: imx: reconfigure for
> > PIO when DMA cannot be started
> >=20
> > [You don't often get email from javier.pastrana@linutronix.de.
> > Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
> > spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
> > spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and
> > the SDMA watermarks.
> >=20
> > If the DMA descriptor cannot be prepared
> > (dmaengine_prep_slave_single() returns NULL), the transfer is
> > failed with SPI_TRANS_FAIL_NO_START and falls back to PIO. The
> > dynamic-burst DMA path uses its own bounce buffers instead of the
> > SPI core's mapping, so xfer->{tx,rx}_sg_mapped are not set and the
> > core's DMA->PIO retry is skipped; the driver falls back to PIO
> > internally. But none of the DMA-mode configuration is undone, so
> > the PIO transfer runs with CTRL.SMC set, the wrong burst length and
> > dynamic_burst cleared, and the transferred data is corrupted.
> >=20
> > This is easily hit on i.MX8MP boards that describe ECSPI DMA in the
> > device tree but run SDMA on ROM firmware (no external
> > sdma-imx7d.bin): every ECSPI DMA prepare fails. An Infineon SLB9670
> > TPM on ECSPI1 then returns shifted TPM2_GetCapability data, is
> > flagged "field failure mode", /dev/tpmrm0 is never created.
> >=20
> > Mark the controller PIO-only (controller->fallback) and re-run
> > spi_imx_setupxfer() before falling back, so the ECSPI is
> > reconfigured exactly like a normal PIO transfer.
> >=20
> > Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for
> > ECSPI DMA mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Javier Fernandez Pastrana
> > <javier.pastrana@linutronix.de> ---
> >  drivers/spi/spi-imx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 480d1e8b281f..64c78bd79d7d 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -2153,6 +2153,8 @@ static int spi_imx_transfer_one(struct
> > spi_controller *controller,
> >                 ret =3D spi_imx_dma_transfer(spi_imx, transfer);
> >                 if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> >                         spi_imx->usedma =3D false;
> > +                       controller->fallback =3D true;
> > +                       spi_imx_setupxfer(spi, transfer); =20
>=20
> Hi, Javier
>=20
> Thank you very much for fixing this issue!
>=20
> You can remove this line also: spi_imx->usedma =3D false;
> Because spi_imx_setupxfer() will recheck spi_imx_can_dma() and return
> false because controller->fallback =3D true;
>=20
> How do you think about it?

Good catch. You're right, spi_imx_setupxfer() rechecks
spi_imx_can_dma(), so spi_imx->usedma =3D false is redundant.

I'll remove it in v2.

Thanks for reviewing!

>=20
> Carlos Song
>=20
> >                         if (spi_imx->target_mode)
> >                                 return
> > spi_imx_pio_transfer_target(spi, transfer);
> >                         else
> > --
> > 2.47.3
> >  =20
>=20


Javier

--=20
Javier Fernandez Pastrana
Linutronix GmbH | Bahnhofstra=C3=9Fe 3 | D-88690 Uhldingen-M=C3=BChlhofen
Phone: +49 7556 25 999 32; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-M=C3=BChlhofen |
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700
806 | Gesch=C3=A4ftsf=C3=BChrer (Managing Directors): Heinz Egger, Thomas
Gleixner, Sharon Heck, Yulia Beck, Tiffany Silva
