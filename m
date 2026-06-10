Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96F3FBA7;
	Wed, 10 Jun 2026 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057322; cv=none; b=gLX5RZZlEPXHqdZ6Jcl+FvuUnPuCu3/U9A/oMiCxnQlACUxzXDPYIxUeDVDshOCEd+6jC4O8D1MFj0RqmdjjLyJ+owYJ2UMNegORs+HoTRemKFFoF2Pq+WVnsk7Ox2QWDz0jstO4wePAB+FP8X7GgXItoHaGejqZabjkGe0TgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057322; c=relaxed/simple;
	bh=cLfrJfe2amlqfGJu18td+pRR7VgnZs/+mMKr7Mvje3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfJpOADaoHyWJpR90Bg3Rcjy2mLZNR7WgoXb8O4zUqp4+EomkkXLhgn6RM9crv/pBRI9F3hcEJk80veLiQTE8uhHegglTb+QPcXXcvLkE9B+whmQfAfHPzryyVElozA8cKBZCSVGfMIHVWCcNU9Lm3okRDLvfOF7ULx/+g/OBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GE8t70Wj; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GE8t70Wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d/
	tS08MSBumHtqSKFA4artjeTLd0KLUl4Lxq+fjIwh4=; b=GE8t70WjvgMMJO07Cn
	6oLDedyLzdn2XQuV5TzMaK+vEmWlbXeKbeVk5snIqn8aq4gAitkaTLbu317IUNzV
	rSL1znCepydlIi8apMa/Gv1vWkDiIX3l7sK8zWCY+g5vk2GdDcMFMwyQOyJKf3LE
	vJaHj1Y0kGv1ix1dhT9ZSYaos=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHRv0JxyhqeF_yBQ--.1233S2;
	Wed, 10 Jun 2026 10:08:09 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Wed, 10 Jun 2026 10:08:09 +0800
Message-ID: <20260610020809.2695490-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.44.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHRv0JxyhqeF_yBQ--.1233S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4xArW3Cr48JrWUXw1fWFg_yoW8Ar1DpF
	4xKFyjyFW2qF4jya1kCw4j9FyYg393Ja4qgwsrKw1fZ34agFyvqF1vva4YqF4DCF9rCF42
	kFsrJrsayF15ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_c_-dUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAQqYBGooxwp2HQAA3z

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 233db2cb14db8b1935dda52a6affd97276462b82 ]

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid an unclocked register access.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Cc: stable@vger.kernel.org	# 6.7
Cc: Dhruva Gole <d-gole@ti.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=2
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Context adaptation performed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72262b6fb62b..da8401261bbc 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2013,13 +2013,14 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
-	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+	if (pm_runtime_get_sync(&pdev->dev) >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_disable(cqspi->clk);
+	}
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.44.3

