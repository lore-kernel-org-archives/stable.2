Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D8563FC3;
	Thu, 17 Sep 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654267; cv=none; b=AdirV2fwsV3d7GOrY3W8G0eSOegVaYAZRRfH5guFD8L5azIVOZhMYJqLTfjHGMdZmz8Uk1pt/PUAK1HnA6HPMTX8OMO+4dP3AJIqKdMCJ20RagIuyrS/ZECp5YnKC9I5e9NZhCf+6AbabKkCPN34ESkdPRQWhxhM/Ip+IhNxRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654267; c=relaxed/simple;
	bh=InzlW2ve+YHPEn1pSomI8BT4K/T6CWFhfHphGfISsSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j9asaPkbaGBleQjHHyV7MxudqRGnKYEGCDhhV/zZ7ja2XXuB1ArZj7eCj721V0hPrSrEAi3mvNeEBeTXGJI7Uic+Sy2l+NjyGB1Nvk7Q1usGEEXrv6agTjCETGj+dvV8dtyQ6XAWz89N42SDED5LCy4L5C4wzJXRtx9PyX47s6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=rkqR/xFc; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="rkqR/xFc"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789654251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rp7ZN0Wng14T8faDdgjxE7PW0qy9iG5+mqbGdiSouZo=;
	b=rkqR/xFch8NCA2+gRca2AQaSxjEldo3Dr0HUglwqchvc3GRnl6IBVv+zDApSqQjLLI3ZUS
	srZno6zIDqvDEEzdnjDs78ohou2mQkX7V7vduFxKkb0H/SG2I8MWx0rZPJ05RIxzFkmBzJ
	I9navNkU9Lnvyoh8QZFkAvKoQrk9h3K86XBvQiAJgo7e2ToK/W9dRhWUE0mxpYmh1JYSWh
	ENqYYOk4K8el8TE0z/b7RzoDNFQP8Utj52clbtzgrBCJOCqirVnbr8yjxgReTTF5mP3zN+
	1sKrN+Fvc7KnzcvBLujVP9XmjWHzttR2Ro8/Rlh200wiDVn6g/V5qqfyHaho7A==
Date: Thu, 17 Sep 2026 16:10:15 +0200
Subject: [PATCH] spi: fsl-qspi: Reprogram the clock rate when the operation
 frequency changes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IFKrtVcRFjTM6pSQxY0she
 Pemdvk9eH8GpSSkcKsyJHqLSvAFtq7ArXe/EMpcDI1pLuZqO2R94qZRkBNtGCKyfJDbnmmebGu
 NgXKNicp8Zofxb31ND3L7rwXH8QWUVIZZeAAAAA==
X-Change-ID: 20260917-fsl-qspi-freq-op-fix-f38fedb13100
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4593;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=QuPCZwPZK/7jN3Zazoesh9Cm5AUZ2xXgy7761nWqh2c=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWv1lwf79ocqG7tc5Hj5VrjMYH6csG4r24Hol8+kfjQYn
 6yZ0X24o5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCLxAYwMf1qjIhjny13cdKTE
 Jy/2eNXJ7EjH4uXZ92I+6+xaZrPyDsM/TU0nsVXTVt1md9pU95bBQF+qYp+hwwQbw3092VP0uxr
 ZAQ==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

fsl_qspi_select_mem() returns early when the chip select has not changed,
which happens before it reaches clk_set_rate(). Since the rate is now
taken from the spi-mem operation rather than from the SPI device, the
controller honours op->max_freq exactly once per chip select and ignores
it for every operation after that.

q->selected is only reset to -1 in fsl_qspi_default_setup(), i.e. at probe
and on resume, so on the common single chip select board the very first
operation latches a rate that all subsequent operations inherit, whatever
frequency they asked for.

This results in operations being issued with the wrong frequency.

Cache the operation frequency the clock was programmed for next to the
selected chip select, and redo the clock setup when either changes.

Fixes: 2438db5253eb ("spi: fsl-qspi: Support per spi-mem operation frequency switches")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
The bug is visible on an i.MX6UL board with a Winbond SPI NAND and
spi-max-frequency = <104000000>: the QSPI clock keeps the rate programmed
for the first operation for the lifetime of the system, regardless of what
later operations ask for.

Here is a simple showcase with a SPI NAND where the max freq for the
read ops was artificially limited to 25 MHz.

cd /sys/kernel/debug/tracing
echo 1 > events/clk/clk_set_rate/enable
echo 1 > events/spi-mem/spi_mem_start_op/enable
echo > trace
dd if=/dev/mtd0 of=/dev/null bs=1k count=4

Without fix the clock is set to the high rate initially and never changed:

clk_set_rate: qspi1_podf 396000000
clk_set_rate: qspi1 396000000
[...]
spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]

With the fix the clock is actually changed according to what was
requested by the op:

spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
clk_set_rate: qspi1_podf 396000000
clk_set_rate: qspi1 396000000
spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
clk_set_rate: qspi1_podf 99000000
clk_set_rate: qspi1 99000000
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
clk_set_rate: qspi1_podf 396000000
clk_set_rate: qspi1 396000000
spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
clk_set_rate: qspi1_podf 99000000
clk_set_rate: qspi1 99000000
spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
---
 drivers/spi/spi-fsl-qspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 57358851029b..d2c2090442f8 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -289,6 +289,7 @@ struct fsl_qspi {
 	struct pm_qos_request pm_qos_req;
 	struct device *dev;
 	int selected;
+	u32 selected_freq;
 	u32 memmap_phy;
 };
 
@@ -551,7 +552,8 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	unsigned long rate = op->max_freq;
 	int ret;
 
-	if (q->selected == spi_get_chipselect(spi, 0))
+	if (q->selected == spi_get_chipselect(spi, 0) &&
+	    q->selected_freq == op->max_freq)
 		return;
 
 	if (needs_4x_clock(q))
@@ -571,6 +573,7 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	}
 
 	q->selected = spi_get_chipselect(spi, 0);
+	q->selected_freq = op->max_freq;
 
 	fsl_qspi_invalidate(q);
 }

---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20260917-fsl-qspi-freq-op-fix-f38fedb13100

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

