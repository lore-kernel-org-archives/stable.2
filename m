Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9973ACA60
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044779; cv=none; b=uZx4Wemw+O+TXjtUHGRZTt6PDEfJ1C6uTzZ7llqgzwMn8WACUBV99GHQCi1UPbZF4MzKe33Z8IElPM62ktorQzxWVH48ClKTqGMPlSz2591AE8JTz56UizWmJbL17JbK5LcU/AaTqcWR3aZ2LsFzStn9PvVMUGuB3HfAkx3n8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044779; c=relaxed/simple;
	bh=bzvb6RCs7mk6d8viIS2mvyhsZVXrEUE9oWsTWeJFFm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im0fvmRt/vUYQwYZKJMAfJtwHxwzrCPLbNJDy/lFbZiIxSAYOELGbuVDU50x+7K5ye8QbS6665abwKoySgcRoZAbhKcHEyyA+alOt890ufr6SgVOK0kkyTzKikmM80Kp2m/73wb3vHCmC70wNhIYPbP3tIeDgjyBH5AICSFpMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9bNte9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9bNte9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6841F008BC;
	Thu, 10 Sep 2026 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044776;
	bh=5buf6nL1SHgSkUgw8dSYROPsVJ/BFOPOzvuawm6A3QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9bNte9CamD1yc9Vmhql3+GhVbFps0fLoJb2PkI34AT2IAc98H5+vG4WW3OQc1nAE
	 epzjt+R8G5nHEgOebOnooGny5CFzLQ80XCv4u9iRVxvgqBML4QHYsSUdD635njhLxg
	 LIrgJPxEFuV/+TSebTd2cyoThA74rqHGCwUNUuwWffhh4qtkLglzxE7SiQBnTr38wO
	 nsp/yYXWvH/CsETK26Fxg6ePf0cZukJYD4CxuQKMFVLVQ9F4EGlnWttc2Fa0r2icc5
	 Q2VV6KIbR5mPlqbnSTlAEEq6LIgr4MsASI/im2EyMpu1xh6ECLgJUKo2m/JpfOU5Ao
	 njkRI38e5mBDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Zhang <william.zhang@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] spi: bcm63xx-hsspi: Disable spi mem dual io read op support
Date: Thu, 10 Sep 2026 08:52:51 -0400
Message-ID: <20260910125254.183393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090831-flashy-precook-e8f5@gregkh>
References: <2026090831-flashy-precook-e8f5@gregkh>
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

