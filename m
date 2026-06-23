Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2A2D0292;
	Tue, 23 Jun 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228844; cv=none; b=GyzHmNUWorO7CDIHHFimN1uFPQav+9UcM24ef4DoEyJwge6EuSFOnC5WIbnBQryV1+SujE85OqJnW5P2n3FDLD/QFzZKJhDTEFLtogdzjAo6yxNEutxkvKcHHF2478uFrWDIlAOsWQOLJryrFaKA9FzkBvgfB1RhikUYZ62QTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228844; c=relaxed/simple;
	bh=KIGMXV1ysUkZBWmLEztr4ct2azAMq3XRA9CeTExnvPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fD4SIgZcUoEvRwhd4oQWIwxYLmLQM/PVkq5ss0e7DxEUyKHpeCqE9qB4dTJAJrnuRm8fVAeibnwQCiCxrJnj7lPirP6skhBqciTAYthosYziPSqavF6AZICBBnVkSW1KsfFhMVfhJwkT+1V3phWMsOATzZue16KaBUDVzpw7VC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3IRwOiQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYBITV53; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3IRwOiQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYBITV53"
From: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782228841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N30jbjOnhkJGD+w2i+qI4kPeZO6t3rjCiUISLMQpg/Y=;
	b=C3IRwOiQtcpvsVAXb/J4HCQe6YYuqkJ0a9x/ZqB62wtZiuua1EtBqS6a6mSsewv/iIw3wg
	qXpZvPAdiY/4ADCuzjnCyvQNAYZUSkqJbD2dUHpzDQOmB94pVD/cEJZR1nwE1X0jYFcvZN
	I8/H33sDQRS5p/Ss+xDz9Hqbu5LC7Ni52VKRSPYb1bQ8a09kKDoCPynJlSZ0lADDaWpsKo
	eDeSI0d/DGLxmKtsXOAEPfLMZA8I1lxkaE/5MxTo+OHvRxXd4e073Cw4QJ1q3VvqTCBcbO
	/hD5Zt5IbKo1vfLykZMxNVjquEglFlgiKkj7rWyo7W5EQ1qzMa3gFVtQJ7MY0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782228841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N30jbjOnhkJGD+w2i+qI4kPeZO6t3rjCiUISLMQpg/Y=;
	b=iYBITV530mQ9xs4Cce8uZdb+PRKKV2fEmKxx4HXTfeKCY8IE6i1sCVGaPUIDl518yWd6p9
	FaNEnf0Ia87RpLCg==
To: Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: javier.pastrana@linutronix.de,
	stable@vger.kernel.org
Subject: [PATCH] spi: imx: reconfigure for PIO when DMA cannot be started
Date: Tue, 23 Jun 2026 17:32:39 +0200
Message-ID: <20260623153240.57185-1-javier.pastrana@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When spi_imx_can_dma() selects DMA, the ECSPI is configured for DMA:
spi_imx_setupxfer() sets CTRL.SMC and clears dynamic_burst, and
spi_imx_dma_transfer() programs the dynamic-burst BURST_LENGTH and the
SDMA watermarks.

If the DMA descriptor cannot be prepared (dmaengine_prep_slave_single()
returns NULL), the transfer is failed with SPI_TRANS_FAIL_NO_START and
falls back to PIO. The dynamic-burst DMA path uses its own bounce
buffers instead of the SPI core's mapping, so xfer->{tx,rx}_sg_mapped
are not set and the core's DMA->PIO retry is skipped; the driver falls
back to PIO internally. But none of the DMA-mode configuration is
undone, so the PIO transfer runs with CTRL.SMC set, the wrong burst
length and dynamic_burst cleared, and the transferred data is corrupted.

This is easily hit on i.MX8MP boards that describe ECSPI DMA in the
device tree but run SDMA on ROM firmware (no external sdma-imx7d.bin):
every ECSPI DMA prepare fails. An Infineon SLB9670 TPM on ECSPI1 then
returns shifted TPM2_GetCapability data, is flagged "field failure
mode", /dev/tpmrm0 is never created.

Mark the controller PIO-only (controller->fallback) and re-run
spi_imx_setupxfer() before falling back, so the ECSPI is reconfigured
exactly like a normal PIO transfer.

Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA =
mode")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
---
 drivers/spi/spi-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 480d1e8b281f..64c78bd79d7d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2153,6 +2153,8 @@ static int spi_imx_transfer_one(struct spi_controller=
 *controller,
 		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
 		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
 			spi_imx->usedma =3D false;
+			controller->fallback =3D true;
+			spi_imx_setupxfer(spi, transfer);
 			if (spi_imx->target_mode)
 				return spi_imx_pio_transfer_target(spi, transfer);
 			else
--=20
2.47.3

