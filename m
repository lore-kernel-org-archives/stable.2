Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614539A807;
	Fri,  7 Aug 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103416; cv=none; b=Us2JarJZo8o9mcI3MIcR4Xc0S9a53oAgXSxJrtyHASvtG900PplCDIzyNu/V+xTgdL1Cpm52aTmplOa7wrfinZYXSGpaZeNUwqiN5KnY4BANlw8sDE6ZTGoGLGOnv/IlvicnVdNR3/JapHGOoAQC271MUuTaKVdd1wHDv0eJDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103416; c=relaxed/simple;
	bh=Ov5O6+IUmIoxKUd7aa3NlEk6KfvP352nl59N378600A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4VkoYWg11ZsBOttxZ84l19myR0qUsID46AE9DZdcGbktXJnOfEGmDLJizOBet/ZsdwPYByhFFXE86pQl+GqUOV+UumkAsFih7iJkdjKYa1x1PrgKQXv0V4hic9UwuIWuT2cGVSpZtY9EhNg2dip+9AZ8xNRhmTXSR+Gma/Fz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4hYXkr9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4hYXkr9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4C9881A14A4;
	Fri,  7 Aug 2026 11:50:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 218A1603F0;
	Fri,  7 Aug 2026 11:50:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 551BB11C37725;
	Fri,  7 Aug 2026 13:49:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786103396; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=amECKdhGa2WRnIHdDlpYZ0s3e5gaENTiWLRcewHI7Vc=;
	b=c4hYXkr9KDRL3Lg0Vo9fSaWjVWLWQ6TnV679Za34oV/VW1KLMbZy3ZCMe4wSI9LWQkFm+W
	nhTh5GM2cChXE9DWTEfd+eZrqT+04DoBIGfmWrtKuTPnFyzQhxrcuRARbLSDqCCMvmcX6y
	+P70odqTQLKoZy0ZNyycadBTJkT5X07Tsu/Pu6XxJf42HJDtOLbo6ksCmMKHBOmkFmOnS1
	pQLotRud8R/lsryRRShq1/+p4KJb32NK0fdHhqIKgICqN2F4n6KJJVzggZ6lY0G46MoiHy
	Ghl2EHWce4CxZN1hWpp4yTX6PpMyU+wWJ2N9O5zQp2YkdWhbjrFLN16b+I6E3A==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:49:21 +0200
Subject: [PATCH 6.12.y 2/2] spi: cadence-quadspi: release DMA channel on
 probe failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-cqspi-pm_runtime-v1-2-5973a0a208c4@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=Ov5O6+IUmIoxKUd7aa3NlEk6KfvP352nl59N378600A=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdcZX6j6wpnZXX+UE9uVB23fgx0nHArdMa7Gvr
 mQj6EScisSJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanXGVwAKCRAGvnxbVl7J
 RaqZD/9W0rqepOXwdjEaITiIKREozCU+pSG5rNF+kDqOZG7/3OQYsTXoxrwJ0woogzGdjIjmsqh
 HsDKkXHuZ8E1wU8mfXo5u/0A6PtE32iBrZVSY+24NQjTZMfr6lmc+q23GE6e5g7uYyITXoDZ+GI
 aY/fvdZZ5kOrMuBeu1Mn5WaJpYUjIEmtavc5deRLXBHlOgZgNWH2+RJp/Ua+4sK+1bkMu6nvx4s
 Ff7gPQzMDYSmocN8wvNJR3DyWWk+bpeb5K4BcWMYNplGHdD2erA3cMQ5I1ALoL1ITXh1njoE2Tl
 0GpcNgvJeYZMpHKv1QggYUT93YiVMfT7RWaiTyDB+ulaJJ5ZqaKS0Gzk1yOgPin/xvhEWyvbtPL
 FomCa5hmPs93W2qFL2/otLUYowlWuMLqpadS+Uv/dPIRU6V7JICaoLEKe09uEQS214x54y1mZPL
 FWIURVSpg/YGrCB8DM1GL5Jj8H9aRJXwuAL9bRCFohmGiI4zLRcctF4jXwnhNWt+lj5MhvFdPjU
 jKJiyd2eIebHFqhQamYrCp1pEd/nDrVd381OKNnNCT+RgVyvnvzZSRt+hYa6DrGIXjGkl8HY8nj
 k6ef+4FeOKGyfuZm+FWSfq+HJnkwS5Va600m8t9b54ELSZdnTDYtqmhc6wUJ+fnPXEjReEMx8X7
 Q0RfMtPLdiEpgEQ==
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

