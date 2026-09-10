Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4237AA6D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046622; cv=none; b=IxH8Tvu6LTcuYM1Jat3xS3DYhCnabe+0dxrC/uh6aFfu1gk0R7R5rarnE+yVDEuowo1yuQV4ajEab6ybxhaRqocdGvbuIcqabkiQjXBp02f6CMnJ9GPMIEUyHNUXuRfHchQNYggDL8O+d9mykT8egWQF0dqt33iHhNC2KFpif6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046622; c=relaxed/simple;
	bh=bzvb6RCs7mk6d8viIS2mvyhsZVXrEUE9oWsTWeJFFm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I49quhxhvIMD8jsToVZFGFqg06o3xPA57lf5Rsmey1xBgh9sANCCBY8mz0hp08LbKRXqr9o2cQm7tVvEG9diSErMG4wb+Fs2cFZU1dvU6XsHNtdUe+ohfo7ry8Z9q6bf4Zn5Zd7ZrDKF0ILT5dh1/nKbxHUn2iNbxLAwQQh1Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lny3KDCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lny3KDCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DF71F000FF;
	Thu, 10 Sep 2026 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046621;
	bh=5buf6nL1SHgSkUgw8dSYROPsVJ/BFOPOzvuawm6A3QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lny3KDCO9WNKHYLvkyVr4m5PB797+idmUACfxuX9OymaMSF6Ph00EwB7zYHKrvtdk
	 jX0AW7LwYxB22QX7kgmM+hfkYx/JSfOWwgV17ddnQNsPw8zQCDjYaLYebpOkU3Oy8/
	 UieZgHLqMK58T0gOf5t024m31prjXjgQVaU8svYhWaPS5N6R75WUg9+CpvJY0dYxti
	 P188IzG178mTzEPreAcMqyT2lWG0paUoywaXA471eYZMmrjyBiKk5g5I4ITo7regi9
	 wSCWpT+KJlmHiPdsx9uiQ4ZXiQhglXKtTxRpy2Rv+DbGWGQv/jBWGk0tR5tfyDeFVR
	 d1Rj7I8AOnyDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Zhang <william.zhang@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
Date: Thu, 10 Sep 2026 09:23:37 -0400
Message-ID: <20260910132339.247410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090832-duration-catering-fe4f@gregkh>
References: <2026090832-duration-catering-fe4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit c6182a187b33cd00a763ac2490c0f5210b2c4742 ]

In general the controller supports SPI dual mode operation but the
particular SPI flash dual io read op switches from single mode in cmd
phase to dual mode in address and data phase. This is not compatible
with prepend operation where cmd and address are sent out through the
prepend buffer and they must use same the number of io pins.

This patch disables these SPI flash dual io read ops through the mem_ops
supports_op interface. This makes sure the SPI flash driver selects the
compatible read ops at run time.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Link: https://lore.kernel.org/r/20230209200246.141520-14-william.zhang@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 7d8e5c66f6d17..9948c2a459c12 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -20,6 +20,8 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
@@ -318,6 +320,26 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+static bool bcm63xx_hsspi_mem_supports_op(struct spi_mem *mem,
+			    const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	/* Controller doesn't support spi mem dual io mode */
+	if ((op->cmd.opcode == SPINOR_OP_READ_1_2_2) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_4B) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR) ||
+		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR_4B))
+		return false;
+
+	return true;
+}
+
+static const struct spi_controller_mem_ops bcm63xx_hsspi_mem_ops = {
+	.supports_op = bcm63xx_hsspi_mem_supports_op,
+};
+
 static irqreturn_t bcm63xx_hsspi_interrupt(int irq, void *dev_id)
 {
 	struct bcm63xx_hsspi *bs = (struct bcm63xx_hsspi *)dev_id;
@@ -408,6 +430,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->bus_mutex);
 	init_completion(&bs->done);
 
+	master->mem_ops = &bcm63xx_hsspi_mem_ops;
 	master->dev.of_node = dev->of_node;
 	if (!dev->of_node)
 		master->bus_num = HSSPI_BUS_NUM;
-- 
2.53.0

