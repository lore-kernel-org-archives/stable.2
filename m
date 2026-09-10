Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BACE489FDE
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044781; cv=none; b=I5/HXntOGO6U5gWSQ5CTGxUXNbrbdlu3okmS/v0LNxiaDH/USKbbO+DnjlFz8VOjHq9JPjEPBMk3o/o5YHNf8M1WcOMDbUChxnB6rN9CTJahivAlknOLx3NEWtnuVtle2PTvRTqJuA1YxT5kBd7ZofPUN6/EpwxXQY7+HpzxWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044781; c=relaxed/simple;
	bh=vvYfpsDe2KbetiQ3K76gDgutEoU30cGc6wu1lV+QADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfZ0NuN/AyO99Y1FzsQ2ruZMbgcJw/8mPQWfI+2sN+xQDGJvNobV3yLx7qSqkjohezNfV7tksHNOvanYaELuac2tKtvrfJeMW9h52vuDsPeMwXSNgJNHMg8McvOSIrpzvoow2qk4JeQfiqRu4en49yD8HC2fjMu+2mdXgnfuTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1pwZur7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1pwZur7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A701F00899;
	Thu, 10 Sep 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044778;
	bh=IjobrVW3sTn+KH6hFT/g60yk9WLBkL2zoemv+GXiOvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1pwZur7NIPxZt4cbm7WcNlDzxb252TR/L56Ze6F3pKjchufxgxeS4IdpoHQTECpP
	 cqa+mhDDQtUA/gqdm3JEvFGw76iNOSX/Vsq+BvkyzI/8kGf+SD/vdmJp7/Gk1hmmdP
	 E9S9pAFzQMlL9jYzMg02gi6HdzXdz1jh1Oll1bzx/dBAoWyMbKrYiRpLArO43TSlru
	 RpSc97cS4tNC21Nos4uNKTUwpbJFr7SaT4EL7L/z4LKMnD/vW3LyLVxFScSYxo2llQ
	 0Q6dm7BS1PEj64KfFZA2/ewhmYMjQhq7qnWWEuzisPAulmPhvI1VraGc15DbDGZn8r
	 cXHcGzNS3TfQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Dhruva Gole <d-gole@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	William Zhang <william.zhang@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
Date: Thu, 10 Sep 2026 08:52:53 -0400
Message-ID: <20260910125254.183393-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125254.183393-1-sashal@kernel.org>
References: <2026090831-flashy-precook-e8f5@gregkh>
 <20260910125254.183393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>

[ Upstream commit 9e264f3f85a56cc109cc2d6010a48aa89d5c1ff1 ]

Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
members of struct spi_device to be an array. But changing the type of these
members to array would break the spi driver functionality. To make the
transition smoother introduced four new APIs to get/set the
spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
spi->cs_gpiod references with get or set API calls.
While adding multi-cs support in further patches the chip_select & cs_gpiod
members of the spi_device structure would be converted to arrays & the
"idx" parameter of the APIs would be used as array index i.e.,
spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Acked-by: Heiko Stuebner <heiko@sntech.de> # Rockchip drivers
Reviewed-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org> # Aspeed driver
Reviewed-by: Dhruva Gole <d-gole@ti.com> # SPI Cadence QSPI
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com> # spi-stm32-qspi
Acked-by: William Zhang <william.zhang@broadcom.com> # bcm63xx-hsspi driver
Reviewed-by: Serge Semin <fancer.lancer@gmail.com> # DW SSI part
Link: https://lore.kernel.org/r/167847070432.26.15076794204368669839@mailman-core.alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>

Stable backport notes:
Limit this dependency to spi-bcm63xx-hsspi.c, the driver affected by
3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure").
Convert its eleven existing chip-select accesses using the accessor
already provided by this stable tree. Drop conversions in other drivers,
SPI memory core and trace events, which are unrelated to the target.

Keep the stable driver's existing transfer implementation; do not import
upstream prepend support, additional helpers or drivers absent from 6.1.
In the existing resume function, use the spi_controller type/accessors
and the local name host. The old spi_master names are compatibility
aliases here, so this preserves behavior while allowing the target's
spi_controller_resume(host) error-handling hunk to apply unchanged.
No functions are added.

[ sashal: Reduced backport -- upstream 9e264f3f85a56 touches 92 file(s), this
  backport carries 1. Not backported here:
  drivers/spi/spi-altera-core.c
  drivers/spi/spi-amd.c
  drivers/spi/spi-ar934x.c
  drivers/spi/spi-armada-3700.c
  drivers/spi/spi-aspeed-smc.c
  drivers/spi/spi-at91-usart.c
  drivers/spi/spi-ath79.c
  drivers/spi/spi-atmel.c
  ... and 83 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9948c2a459c12..16e2873c4d4b3 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -132,7 +132,7 @@ static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
 static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 				  struct spi_device *spi, int hz)
 {
-	unsigned int profile = spi->chip_select;
+	unsigned int profile = spi_get_chipselect(spi, 0);
 	u32 reg;
 
 	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
@@ -159,7 +159,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
-	unsigned int chip_select = spi->chip_select;
+	unsigned int chip_select = spi_get_chipselect(spi, 0);
 	u16 opcode = 0;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
@@ -168,7 +168,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	u32 val = 0;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
-	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
+	bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), true);
 
 	if (tx && rx)
 		opcode = HSSPI_OP_READ_WRITE;
@@ -236,14 +236,14 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	u32 reg;
 
 	reg = __raw_readl(bs->regs +
-			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
 	reg &= ~(SIGNAL_CTRL_LAUNCH_RISING | SIGNAL_CTRL_LATCH_RISING);
 	if (spi->mode & SPI_CPHA)
 		reg |= SIGNAL_CTRL_LAUNCH_RISING;
 	else
 		reg |= SIGNAL_CTRL_LATCH_RISING;
 	__raw_writel(reg, bs->regs +
-		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
 
 	mutex_lock(&bs->bus_mutex);
 	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
@@ -251,16 +251,16 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	/* only change actual polarities if there is no transfer */
 	if ((reg & GLOBAL_CTRL_CS_POLARITY_MASK) == bs->cs_polarity) {
 		if (spi->mode & SPI_CS_HIGH)
-			reg |= BIT(spi->chip_select);
+			reg |= BIT(spi_get_chipselect(spi, 0));
 		else
-			reg &= ~BIT(spi->chip_select);
+			reg &= ~BIT(spi_get_chipselect(spi, 0));
 		__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
-		bs->cs_polarity |= BIT(spi->chip_select);
+		bs->cs_polarity |= BIT(spi_get_chipselect(spi, 0));
 	else
-		bs->cs_polarity &= ~BIT(spi->chip_select);
+		bs->cs_polarity &= ~BIT(spi_get_chipselect(spi, 0));
 
 	mutex_unlock(&bs->bus_mutex);
 
@@ -291,7 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	 * e. At the end restore the polarities again to their default values.
 	 */
 
-	dummy_cs = !spi->chip_select;
+	dummy_cs = !spi_get_chipselect(spi, 0);
 	bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
@@ -304,7 +304,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 		spi_transfer_delay_exec(t);
 
 		if (t->cs_change)
-			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+			bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), false);
 	}
 
 	mutex_lock(&bs->bus_mutex);
@@ -518,8 +518,8 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
 
 static int bcm63xx_hsspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
@@ -534,7 +534,7 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.53.0

