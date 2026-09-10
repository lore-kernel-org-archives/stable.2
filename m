Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD334FB9C9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062564; cv=none; b=aCmBYsyJjnHOJhs1mVybVlXq19RKrX6So+EYNY+AZTN358mRr1cLY4jyjX8FhlJdmMnl7KwTjdV5qPpcx9z7ISSxCDRT2pQshxhMywJkEWvpsRV494i8S0BClzyOQehy79XgpOfRSlCKTvFfCDaZaIs48TibASplkBJOnk68ass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062564; c=relaxed/simple;
	bh=of8Min8jQHatci7yA4a8bBMCHi4+w1P7IxV3FDsHcSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AzkGeSDTjPUbPKJnOt9YvUnL5gweu6dawK/LBAvS/xqB+iNZ1XXwvTJfXfaHFu4zr41OuRkf2TjdYwH3HDJdqQc2KyTK2Tmd2zL6PMKPLmxLUlDpVdTBw62q5Zsteyrqu1/rOdVAS1+jVHI+jZN3dnUekWeaWKZle9jEB0S0TeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D222fF0V; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D222fF0V"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d157f691cso76175e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062553; x=1789667353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+Y33ifQJ8/eGSJF9NUK/wyESJTtkXuplimgmPx5EAw=;
        b=D222fF0VFhPhtNu/sKleerGwFQCqTgdBtWy64cfY8Z0Y7loMIBRuy/IjLfBY0PGcW+
         7oXAqdlFNWSlIlfk/pVEZV4gPuQOf52iDGR7vpn6HWplLzzA8PT4Hm2Y8TsfELYQ6ryY
         HPP3x+AznopEH/I3uFR6702KpQS5Udl5WUIpAPkmWKMmQs8t+HMuqnBOIFZlDiL3W+ep
         6tVbpvRYy+bNVs+R/GP5S0xkQ3uIIe7vELof2jasrtUuRgUUFLzVwAp3Kxrl2fumfaVO
         y0lsvF45tQ3IviuHZmTmmyHR3F0uQOwb3AiujBM2fdhrfeH4syjljkMJifR1tJCLTHsL
         QZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062553; x=1789667353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+Y33ifQJ8/eGSJF9NUK/wyESJTtkXuplimgmPx5EAw=;
        b=ZK9GjFdQmfJLHuTeRboZBPUp28yLyOKt/OxTeXp3y6kUE5JxLOhb9WAdZ5BE9OmUqg
         sd5oQJ05tR/k34fzj26Ng3O8Cr8TbhXjoFjJ/l2IrchXpsH3o6LubalK+FpLmnuu1U5p
         koyFhLl4o0/eCK6aAm1lRHNWd+jB7YMCrsTemk6ljaawJu9W5qSeP3xNHk/a5pdOe0lP
         kdgStBRfE5p+wu5eErlf5hdJkldhoaaS2gTjW7p9fuWEBPwCUxvEEV+rr0eRqco7P0i+
         5y09cS224ClGNM/e4/7Xs+FFJOvoU72VsVwUq09aJG60kMKQ5vFDWHIXrulfPuHWUqbt
         qYrw==
X-Forwarded-Encrypted: i=1; AKwUvByn7BMmcwEoYLEzx9JfeSdvj2sZYSLuVryLcfBA170R3IPJUG9X5Y+hRjQgXCt2HQAjOZ88i+s=@vger.kernel.org
X-Gm-Message-State: AFuF++lS1PwGsddH5uvCbC8x7qgLu8WM2HswTppPlEzQ1MBC92SEDS1g
	4zeYQ5FMTXavktS/bb5FmNnBIKfy/QprrEcgEDk5ueOp3a4yNRoACh8N
X-Gm-Gg: AYBFou3VRmIYHL9Elu3RNntG4gUvWiM3xEV4Eij1P21Ci04decr0nqA8wkKOsuo0u6k
	F1C4WaIakNBRTEcZfekjDVCj0AI7BM0LDxTqc6ehIpoyOxCv5SYS06S3zuRU6TjM/9tiT9e4FwH
	kS1BRI+k6IPqsF0Z75/t0U1ajV9bEm1M8iz84lryEHTlYeQWFnTB4kuVICEkgJWznQslHNr4Cbr
	muQPyApp/8ZGWVc83O0lHxgDjX/VqRu/PuyV44pBpnf+ODatimKe8+0XyS25ObgfooZWXXO3YnR
	o2RKaSGcIcRk73YrmywC0BS9TFXK0ZK5MHFl3Da+HmWFZdARN4kxD5QWkIgOe71mn7z/5yvLin+
	Gks49T+D0AQFitfkRM3ZxuImi920cq4YYr1O2S1IcZtm+mcEylIf9vUfwSttinfAJGR/VQ7v5tZ
	BqI0BKhYz/mhhqFqZYt9+eUcFTRN8kZ1udgroFF+qXZVg2IhI2qKPXOTjUTGJp7kw7mNOrVAr6J
	BcT0mKqYwkmhTsTMTk=
X-Received: by 2002:a05:600c:8b71:b0:49c:ff81:e062 with SMTP id 5b1f17b1804b1-49e619d6a4emr1272515e9.2.1789062552366;
        Thu, 10 Sep 2026 10:49:12 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm94881105e9.15.2026.09.10.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:49:11 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	Itai Handler <itai.handler@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Thu, 10 Sep 2026 20:48:32 +0300
Message-Id: <20260910174832.873352-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has no ->shutdown, and platform_drv_shutdown() has no
fallback of its own.  Unlike pci_device_shutdown(), which clears bus
mastering when kexec_in_progress, nothing on the platform bus disarms a
device that can still write to memory.  The normal kexec path never
calls ->suspend either, so the quiesce in zynqmp_qspi_suspend() is not
reached.

A controller that is still executing a DMA read may therefore keep
writing to memory across a kexec.  QSPIDMA_DST_ADDR still points at
memory owned by the kernel that called kexec, DST_SIZE is non-zero and
the flash is still clocked, so data can keep landing in RAM while the
new kernel is being relocated, and after it has started executing.

That destination is a physical address which means nothing to the new
kernel, so the writes can corrupt whatever now occupies it: kernel text
or data, page tables, or the initrd.  Nothing reports an error and the
resulting behaviour is undefined.

This can be observed by reading GQSPI_EN (offset 0x114) and
QSPIDMA_DST_ADDR/SIZE/STS/CTRL (offsets 0x800 to 0x80c) early in the new
kernel, before the driver probes: without this patch GQSPI_EN reads 1
and QSPIDMA_DST_ADDR still points into the previous kernel's memory.

Add a ->shutdown that stops the controller the way zynqmp_qspi_suspend()
already does.  spi_controller_suspend() stops the queue, waits for a
message that is already executing and makes any later transfer fail with
-ESHUTDOWN, so nothing can be cut short by the register write that
follows.  It may sleep, which is fine here: device_shutdown() runs in
process context.  Unlike ->suspend this cannot abort on error, because a
controller left mastering the bus is worse than a truncated transfer, so
a failure to drain is only logged.

GQSPI_EN_OFST is then cleared, as zynqmp_qspi_remove() and
zynqmp_qspi_suspend() already do.  Skip that write only when
pm_runtime_get_if_in_use() returns 0, i.e. runtime suspended: the clocks
are gated, so the registers are unreachable and the controller cannot be
mastering the bus.  A negative return is not the same thing - it is what
the CONFIG_PM=n stub always returns, and there probe() has enabled pclk
and refclk for good, so the controller is running and must be stopped.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
Changes in v2:
- Quiesce through spi_controller_suspend() before touching the hardware,
  so nothing can start a new transfer and a message that is already
  executing is waited for (Mark Brown).

Note for stable: before commit 1c26372e5aa9 ("spi: spi-zynqmp-gqspi:
Update driver to use spi-mem framework") this driver stored the
spi_master in the platform drvdata rather than the zynqmp_qspi, so a
backport to those trees needs spi_master_get_devdata() in place of the
platform_get_drvdata() used here.

 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 4d55090..15e9d3e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1373,11 +1373,45 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->pclk);
 }
 
+static void zynqmp_qspi_shutdown(struct platform_device *pdev)
+{
+	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * Stop the queue and reject any later transfer first, so the write
+	 * below cannot cut into a message that is still being executed.
+	 * Unlike ->suspend this cannot abort on error: a controller left
+	 * mastering the bus is worse than a truncated transfer.
+	 */
+	ret = spi_controller_suspend(xqspi->ctlr);
+	if (ret)
+		dev_warn(&pdev->dev, "could not stop the queue: %d\n", ret);
+
+	/*
+	 * Only a runtime suspended controller can be left alone: its clocks
+	 * are gated, so it cannot be mastering the bus, and its registers
+	 * must not be accessed either.  Any other answer means it may be
+	 * running and has to be stopped.  In particular, on a kernel built
+	 * without runtime PM this returns -EINVAL, and there the clocks
+	 * enabled in probe() are never gated at all.
+	 */
+	ret = pm_runtime_get_if_in_use(&pdev->dev);
+	if (!ret)
+		return;
+
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	if (ret > 0)
+		pm_runtime_put_noidle(&pdev->dev);
+}
+
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

