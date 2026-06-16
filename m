Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA425B099;
	Tue, 16 Jun 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572349; cv=none; b=LqskbC0vpOPY2hGR6T+aFVMfpXvMxx6y6d0L0Vb7vJew4BveZf9DwS7R42MdXARuAJgIVmAL0ska2ygMI8OHUB14seMWCoR/NN27zoP4d6Xon8Woi9uuF3e8AOAcznhTZ5vvI7TLNE3wkRZL58D5U8Vah6QFn3jgciq9JP9J49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572349; c=relaxed/simple;
	bh=bIFSzHFQJ1Ht3OB6Qluc0K74ppeTDN7kz5C5RbAYvSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hsk5t1gcFH4wDPeOVH/d2i0fzDgyCVt8I5CBX4ayiuN4TxOSb7J+M3ZduzP626hbBR71VGAQkCx3Zrh2aALDjtfsRaMrpLrKRFUbwBuWVaNsnPtQwYNP64zSTbmV2/ArkoGqu74v+sp5SUg/Ei4qGlfWzHXyZVGw5ub9E3HCswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jun 2026 10:12:26 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 095CB2091480;
	Tue, 16 Jun 2026 10:12:26 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 16 Jun 2026 10:12:25 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id 5D3FD15FF;
	Tue, 16 Jun 2026 10:12:25 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] spi: uniphier: Fix completion initialization order before devm_request_irq()
Date: Tue, 16 Jun 2026 10:12:23 +0900
Message-Id: <20260616011223.201357-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver calls devm_request_irq() before initializing the completion
used by the interrupt handler. Because the interrupt may occur immediately
after devm_request_irq(), the handler may execute before init_completion().

This may result in calling complete() on an uninitialized completion,
causing undefined behavior. This has been observed with KASAN.

Fix this by initializing the completion before registering the IRQ.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Fixes: 5ba155a4d4cc ("spi: add SPI controller driver for UniPhier SoC")
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
Changes in v2:
- Rebase onto latest, no functional changes

drivers/spi/spi-uniphier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index cc20fd11f03f..86fce9a571da 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -656,6 +656,8 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	priv->host = host;
 	priv->is_save_param = false;
 
+	init_completion(&priv->xfer_done);
+
 	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -679,8 +681,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	init_completion(&priv->xfer_done);
-
 	clk_rate = clk_get_rate(priv->clk);
 
 	host->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
-- 
2.34.1

