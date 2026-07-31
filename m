Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFE413D62;
	Fri, 31 Jul 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495285; cv=none; b=gqC4VIM63A4PwC6nycBumlugssyH3Muem4YFqaQkqfUVRVckowit1ixnpYSniU3RLU608Fqbo24ZQGCw7+eKjS/CAkzFYR2LaSNotvSP8P54ZWV35pftRypxUkKoMs6VtBaRp+Os1FPNVdprazOBkl9a3KZb9Rhn5togemqBJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495285; c=relaxed/simple;
	bh=A+RYlvea3muHJkR3NxXPPCl5DxXF4LYmaoormXO+aiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmRayhS4DqTgobeHfXj/5XW+QH3hUSW8yDeGf1krw6S9tb6gsBlwwoDv6YDBZHAVPCWsUgMLi4NVX6RhkLeouSXR6J9a+BuWcjT6Y/MclhS6t29PAgdn1mUJsTYkNeP3VVdUK0lQj9zwwgRMFyAh+7BbgLbYw2qPyrfxWWLXH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yq+wPqUm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yq+wPqUm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D685B4E4104B;
	Fri, 31 Jul 2026 10:54:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC3AF6039A;
	Fri, 31 Jul 2026 10:54:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C70EA11C166F4;
	Fri, 31 Jul 2026 12:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785495268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=45YoHV0abmLlyEJ5V4MZxscl5HAFA4m1pFJTxKtyNYI=;
	b=yq+wPqUm7JqJ7Oyp04a4li73hxVfdzyPkrRn54X4nirKrNtcA2DFmIHbaorH5OcPqoA7NI
	Dgo3I4K9++MIVzcKhO7gtGtCQjBGIMlt08j1YiREXNJcfOBBOizhGWCgzCjW7zKPVStIj2
	zalXP6rF1vtiInMWpsbxXW3P7uyIY4BCMXjqndfNMCd1tXiICwcWydxXOvZtiCvDhOrh7P
	bsX8OdRynOSWMk906JluEvjBnhOm/lT6GwDpkFcWT6LODZ12oXU2OPUCBrSlfYrGyArKae
	KI7gkJ7ftjAQAPXDDAUZOzGWbaUAlbI2Tb0ejZYQ2SlINGvaqkTMb+DNLcOnjw==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 31 Jul 2026 12:53:46 +0200
Subject: [PATCH 1/2] spi: cadence-quadspi: fix runtime pm cleanup on probe
 failure/unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-cqspi-pm_runtime-v1-1-ff0bfc9e8e56@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=A+RYlvea3muHJkR3NxXPPCl5DxXF4LYmaoormXO+aiI=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqbH7bAOEBCctkWgWD1JTAVWQ/bfNfEb8sCMLOT
 3Iz3QZNUmuJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCamx+2wAKCRAGvnxbVl7J
 Re+hD/9wmKNLbQL7lUIoyWv5sJel7kR6Qu2vRmfSWsL3jk3Q17HBAShLevsuZJczTA+hWI6TST8
 4KkiB7uZSwPF3X7ZI889a76HC14KJ6o+MFc3Gx4OKZyMtmVeaoHB5jKZW5BNIY87wVVp56X/RIF
 BT90I0PoSn2s2P/Rnr/w1nhbQ9JhkjCRGHaHiVazPOFiUxvGtulSmhX/fP9bxkzUA1+TO/6zqor
 bmsm/euIO4ki50X0uCmm0f97/YJSUkutlSuytzG5x8Mp8vCKil75qQtF1hKSSWjVUYnV3+Boe8z
 7HN/jx8Ed1Das0BD1Cuy0uZoMOVDCXkxzqEzuo6pNQ0gIDznhcENknI7+Dx1CUQxsiKumDL1aNK
 cJuug9VFx7e+G0vpCJzOVh7tRIh2MOmTxcDW/wY6LNY6kG9Jm9d5kq1PIQnmFc6qI6o08NJTAl0
 4jUJeJa3q2DERPZL5bCiuNlBwMaUhMyNYvPIDuLWxa46znIWJO2lLuSR4dsYC3jQvlASv9AT08V
 nYzy+/cd2SHYBHG1ChEkpxClLU/GhPkg6dB7W8+JLtz8qIoVUSkT9xQn7xPnfv20J7DSPxMFRJR
 Y6sG2wZvJNgbb+kH5xxSyt9d8aiN3qeVJmgbSbow/ttHLeRSWcdlYBmErpUuCCv/U0OoOAMPgQa
 Kbkt27Wv4Pdle3w==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

Currently the probe cleanup path is imbalanced regarding
pm_runtime_enable() and pm_runtime_disable(). For example, if the probe
defers after calling cqspi_request_mmap_dma() pm_runtime_disable() will
be called without a prior call to pm_runtime_enable(), causing an
imbalance. Furthermore, the cleanup path does not undo all the runtime
calls made while probing.

Fix this by enforcing the correct correspondence between
pm_runtime_enable() and pm_runtime_resume() and add the missing PM
cleanup calls.

As the history of this driver in mainline is convoluted with several
rounds of fixes it includes the fixes from two commits, namely
commit 5ff4d5d1af0c ("spi: cadence-quadspi: fix runtime pm disable
imbalance on probe failure") and commit 5e8bb0cc72f1 ("spi:
cadence-quadspi: fix runtime pm and clock imbalance on unbind").

Fixes: 74b0b4cf13fc ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index da8401261bbc..d749dee54015 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1862,7 +1862,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clock.\n");
@@ -1983,16 +1982,19 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-		goto probe_setup_failed;
+		goto disable_rpm;
 	}
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
+disable_rpm:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -2026,6 +2028,7 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 

-- 
2.55.0

