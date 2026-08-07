Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579C470EB9;
	Fri,  7 Aug 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103407; cv=none; b=heYrEKiLDL1GrzFb5GsIEQlw/L4XHnM90XKtRNGfSu0EH0onKUSIQz+3loYvxhXgdrKcc2OsaefrkJnk9znJyhXgjN3OT7EtW/5OF1zVFx/2BHtK7T66r2I62SupxRRyM49yy0LVNZNk8sTpdsZjhcAazqtcx6fcUcSolAEJ4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103407; c=relaxed/simple;
	bh=A+RYlvea3muHJkR3NxXPPCl5DxXF4LYmaoormXO+aiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaNdRdq7gjxbLHN9NVNsHsxi9s4Ckywyl3CGHj5+1xFQWYqaDVhZi6xsW6O2eSv456yUgcdYAjyXzf32dRBn3hMg9kUWC4RyK6EHjfxC6eHKl4bifu0FYv43tyAbO8/tUY5Tkwb0FKiI9gnqbvhbwkYKjDbFsjuJD+k8Ivrh3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rjQAs3/T; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rjQAs3/T"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3BCB1A14A1;
	Fri,  7 Aug 2026 11:49:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99A20603F0;
	Fri,  7 Aug 2026 11:49:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0228F11C37727;
	Fri,  7 Aug 2026 13:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786103391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=45YoHV0abmLlyEJ5V4MZxscl5HAFA4m1pFJTxKtyNYI=;
	b=rjQAs3/TFdOCSimPjBVtospIF0ua2TsXzsYwZBwSClTI52i5nhT6vn1XSfIc1wFfWCTqk6
	3uQoDaajiugfMaZOAIp0pSjHXi0yeEkHrvx7joocwlHMCQc9BXa1dlY7ixW/yWTzcByxDV
	hT7/VL7f7UG+b4zg3av9xU0w8pPhJ9E7gZ8xlVhH0EyZeZMp88UERSo0xnddHAG3HpdJWk
	y0KGIiU61dMeE9ywbuOJIhvxqlExbJPpLqyhZrFfmPH1632fZPjvMhpPJTL0uP/63VMzTF
	4cAp4nBSu3JPhSS17inuqUj5YxemTlv8tCHFbxZI8LQfSV6AfIvUx/XLwEQpMQ==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:49:20 +0200
Subject: [PATCH 6.12.y 1/2] spi: cadence-quadspi: fix runtime pm cleanup on
 probe failure/unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-cqspi-pm_runtime-v1-1-5973a0a208c4@bootlin.com>
References: <20260807-cqspi-pm_runtime-v1-0-5973a0a208c4@bootlin.com>
In-Reply-To: <20260807-cqspi-pm_runtime-v1-0-5973a0a208c4@bootlin.com>
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
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdcZXJdVHhQmncQsOM9n4V02JN1hytqH57z1sA
 B0W9Tll0vCJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanXGVwAKCRAGvnxbVl7J
 RebpD/9y6WEl5paNTzBhMfoXihk4AnhJYdY79BFtefLLd8svEluA9LHAvY1Oh4S+zs+we+pwXmN
 GolAv79ZyMf2XtafjiZZmqtNcirFfq5mtC2bPC+Lk3V1MohEcyfJktSe5FzKgtYpt22yY2P60YX
 VW/eHzZ2Rmjgyy65AbSBePxfoofsirYVUjq6hMsVFpjjoUz9qd7meV6EpGnMzKV4dxK8Vuh0I3V
 tGSTOaszIcQiBRKVu4XpbGiIme67jZApTeX1wu7A+8uHQdGs8ollbsI0SYZV7CLSe+spQHb+ezs
 R7uxNcdPlyi70ZUv7pS9Vp6yicZRfpPZcLQ3kf1uTLj6KaX6i22tWN0/g5RcMEZpMNASqvadnxu
 zhwZC6bqfmds2i9GjOiWjuFcTAMjKO5hKihDMZHa9e9OskeWVdLJJki94aaB+5xW86Y30L91vub
 Oz/KkIhY7oBBYJ7Fq4tMRI4sgV/KDsG85q5X7iIvEZoABBZckNU3YQXIpUHL+rLaamTQxDs7yYl
 BZP37dC6w2P8CPYHNzO7H32lBzyxzR3xD7v2VF1gwNvvP6riT0LfEVZO6PzTUOEMGqj/VRIeAif
 K8LKv+cHHxWnztjKfHuvHc7vJlxU8tQ+fvFqVxjznf3Dcju6zLzl61vs9rISGfEB7s/myTghZ5H
 QdfEoH9UojBhKPw==
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

