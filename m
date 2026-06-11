Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24725B0B9;
	Thu, 11 Jun 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159861; cv=none; b=iuEysodcNBiH7zmhIFN7CIMVrk2+uPA8HDauFwD/LPem+VR1XuQFYO7Blf+No5Q6ypoT8h2jeWnE9DxxmEZoroFQEP1JeZ9cHQKMsba1DldI14/glCOk7JZI4dElVLqpEq2eJP7TUXBqkDOBHr8hriwRDnVlwxARwL1z68xS2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159861; c=relaxed/simple;
	bh=Eeq9S5dJSEaZkUN3/e9n9FlbRu/629zoxI90oAbQJGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGy66v6F7dV6lcBfTqPEA5yD03nz5Dv6z9gAffC4tM2bj50W2UJrCg2Hfz2yR0nDxKI8hR7L4M2BXPC9h9jzGEALqN1XNfhLAGXwZ9IB8vNFS17tECPptNN/kiJ6aBC0vZXwa1g/22QJ8ioOO78aL38ijmKCTkE7p54hw6cPwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RwmxpiOE; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RwmxpiOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k4
	PQhwFSLv+1p2nsZ97XbNmbrHAbiI1RCwE+ou8p1ac=; b=RwmxpiOEk2mCxYBGjT
	vCMrMNdtW6GfzupGAxI7etU9O1E8E5PjsuL+yOaW5IB17ECy+5GGtQxQ5nD6SgLU
	pvmd91GWvpgdXeTC6gNjwCbEhlY5bc81+S2eULCXilN9Hrt4RMcD5ps2Jd8/8hI9
	mVO9tcX5lmYzfUd0xiZlpjo78=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD395ifVypqDRVvCw--.712S2;
	Thu, 11 Jun 2026 14:37:20 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Thu, 11 Jun 2026 14:37:19 +0800
Message-Id: <20260611063719.3528053-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD395ifVypqDRVvCw--.712S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4xArW3Cr48JrWUXw1fWFg_yoW8Cr1kpF
	47JF4UtFWjqr4Uta1kCw4j9Fy5t397Ja4jgwsrKw1fZryaqF95XF1Fva4YqFW5AFZrKF42
	kFs7Jrs3tF15ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMZXO9UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5QEjjmoqV6EGPAAA3F

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
index d61bc678b6f8..0a32e28eefd5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2055,7 +2055,6 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
-	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
@@ -2063,8 +2062,10 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
-	if (ret >= 0)
+	if (ret >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_disable(cqspi->clk);
+	}
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.34.1

