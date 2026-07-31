Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69B3E4506;
	Fri, 31 Jul 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495288; cv=none; b=madZ3Z4fXh8S89mo49B9nFLf+jOWBOSE9/Jy391jzdnQBPPH2o2lxNHBIzazIn7BH+gD4sJYMhfd9p+xmDit4V1ovwUS695IG27MM0TVFp3AihMDpx1/MsQHpOyfOIbcIe2Wzx2cJei6VVNb7aBCzJ0OvuumvK7QD67CYsi5Dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495288; c=relaxed/simple;
	bh=Ov5O6+IUmIoxKUd7aa3NlEk6KfvP352nl59N378600A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pja9JvgltFdhuouPy/VaUoFtikVBHS7XPXxMlcFJds16DPRRqrOCYju93rujSpLnBloVilEmY/+4PQE04S8CLCHsp9OFbz1bnAWZvvaPS4FcqHu3i9h9f06ozdVNzNdlHz4FbH/nJP2+P+ri9qd0CthONuLMId+wSJv6E2Z6CR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h6+at44Q; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h6+at44Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 281BB4E4104D;
	Fri, 31 Jul 2026 10:54:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F18D86039A;
	Fri, 31 Jul 2026 10:54:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 538EF11C166EE;
	Fri, 31 Jul 2026 12:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785495273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=amECKdhGa2WRnIHdDlpYZ0s3e5gaENTiWLRcewHI7Vc=;
	b=h6+at44Q/iXoGCqTHY77KYmzpxaV6jBOD9rcBE4Sb8uxuLKqBCl5qB2aGXGpgMoIGIbo1Y
	kzOL4CmrTpUWTYC50pAKrRx3nYFlv0wJLKM/S1ADGHVNKYE93OTxFnSCyA39yk8nwqR9C7
	cN2In1s2nFNEbdA4V4TP1gbN6CRx2wsn7Qg5xQwUREDVcn3M3Ic2lsEzrJDrBFHryxUYX9
	8S764pF+Kc+r2lyGQ4946GNdCm68W/skcsg+I3qkUTR9Kr+dVLFu+mwwJai3hiGY7aQgQk
	z1C7IBT/brUcDNTW13qBrWKejGmDMDRE4aTOVG4llqdTA4zY/KEs6wQqacjuyw==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 31 Jul 2026 12:53:47 +0200
Subject: [PATCH 2/2] spi: cadence-quadspi: release DMA channel on probe
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-cqspi-pm_runtime-v1-2-ff0bfc9e8e56@bootlin.com>
References: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
In-Reply-To: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
To: Mark Brown <broonie@kernel.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=Ov5O6+IUmIoxKUd7aa3NlEk6KfvP352nl59N378600A=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqbH7cxhUAbjsWz9JT2i+8tHDrYgSoWpWb9FLTV
 fzqulYm/fyJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamx+3AAKCRAGvnxbVl7J
 RUx1D/oCUC7SSU/kWiRiALg2CmA5lJsLfguUEoDYNbUAxUJ5WWJUTeYMQccF49kQTDhRSunYqDH
 RucdtMuF8+DxueVFfU6h6gVZLwCl2N24BkX4/t1orAEudqK1HvR3h+Dn8t96tfovikac6TCGxr8
 /kW5xkeL/0XR4TT1S5YGVGWiU4HJiUHPWpncoTdudFpKo1a2j67x8IC9wf8Qdzhf24zjOxx+11J
 e66UXozWEd7uDMmhSb+RIXAP/8VLUJ8ewjZtIF3F17PmapaVkGrgQZyemF8j8bSD9L7wiRqAMIO
 ZG+A+owd4QATuHzyoLQEYlpYTYUPcrBNCuHT6sG+Cq6cL0Y28VpX16740W0JaHV33m1my1r9tdT
 nVmfXq7YUHo/UCS96ZzSoJ3M+2/PuCr6BbAd0/gFWzzYzk4xXcc/QDW5x54XmxpTEzNV5cy3BpF
 AO1Dqghykzb8F15gjldQIRHVwLRgBKPJz/WwcO+cL7PPE2yc1w/ISL8310JVBcDXzkoZLJDcciU
 XLwzREayrt1sQR5S1Q1AZQeFYYr5LlTEhyOeqtDx6rszXZYYSEP6Zcu2om9p+km/jPKu2sX1H3y
 qoGgZ/G1kbkInz1ci1PVQh8B/gdmd2bozOf7vNS8hNkpmpp0ZX5EbQouWF+1skW69emikYR5RFK
 VyjVA/2rrr3v7Gg==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

When spi_register_controller() fails in cqspi_probe(), the DMA channel
acquired via cqspi_request_mmap_dma() is not released, leaking the channel.
Add a dedicated error label to release the DMA channel before the
existing runtime PM teardown path.

This fix is one part of upstream commit f18c8cfa4f1a ("spi: cadence-qspi:
Fix probe error path and remove").

Fixes: b85815675fc5 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d749dee54015..66304664a1cf 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1982,14 +1982,17 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto disable_rpm;
+		goto release_dma_chan;
 	}
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-disable_rpm:
+release_dma_chan:
+	if (cqspi->rx_chan)
+		dma_release_channel(cqspi->rx_chan);
+
 	pm_runtime_put_noidle(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);

-- 
2.55.0

