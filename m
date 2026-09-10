Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB14756CB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040052; cv=none; b=Xy8RWk0xNWVpE/sPI0JNvr4J6lHypv92Cn2DjMsb1fVcX35Fn/43N0if4xtlEjej6OlFc26GYjrZ1ojtIWADUR0zL1oB9cvObYE/o5XjFut+pdjLxQxlpUwtLaM5uHherVcLPGTreZHUhfsiqAIHq/t6TyQnEdJdo5MzilqhzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040052; c=relaxed/simple;
	bh=CJUuoQ2iTfwcG6oeIrw7E+rGr4DRPBFegg1mGe30BQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnquyKHQ9tJYka0C2gDoAX2J22qfp+HVsxP2ceyATZEuQZbylSD5oiG6+hEZN55ghdQ9Pcnq17s60q1SzWz5AgvU5+F+44tJkD36Dmac/ugimTr/K+YSkKL+Z3U1xxsuvWu2KJz+GahSU21wC5zArmN3QVBXhZqpOsThK4XBkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTwQvbQX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTwQvbQX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd82be878so4157495e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040047; x=1789644847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbLnIWJycW550lJgcztROooyzxfaoCBFJTCFjxtrh3I=;
        b=JTwQvbQXoYmvd5WjFiN5Cty9lyfVXerC+Luhp2ACyu+xoyfBKzm31EJTDtw2LT7poj
         yVeXDCIMxUVJ+ex54TjCMPvBA1PBQkA1FifH7jU0pIoGD8sWBWGd+9rY9nWHAKVTCu6u
         UgkanNZafDTiiYpQ8pYGSpt6xWegucV9netyvnN0Tsh6TRVkyoB4xRbo6wOJcvgiIZXZ
         EpItQhLtQewTM3/+j1ZPVFKMIRrYSe0iPwoP3lCjffqWUpW7NfStBVYUHwqc554CnN1u
         XqBhW6sXy7sEI7E+r5OsvWq0DhqaBY6K7mD8flIN3ZkV37GAvbd3C35wo58RWvHwkABt
         GBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040047; x=1789644847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbLnIWJycW550lJgcztROooyzxfaoCBFJTCFjxtrh3I=;
        b=eDxaLVrnH/X34AWpOhdEXxwpezpjZwNbcwJDzMgxPRo2Bc5+yHQKU++i9okCnRmVU2
         YZyXvWgy6IO2uyKHuVbr+Njog+B/Djj5cn97X974bh9RNn5+fCwGNkqs8GHjgvReWtMF
         75sA1WfNyqCN3BzVffgxKHDtQWNCGT7vaW5YFpdXhAAT3RRaNLK1OpkQrzK7OG89EB1s
         ci6kglc0EAyChTqHOfTujK/4TcN4qOMV3SNPIBGrTEc9vF8N1ASc5n/1P340nFmZxs9t
         I34r546p9p063qPw9/ENJnPBq55DnNqnWwY6WwEhHD8Se7qpyP8GgJzUI7xFCAk6OYAj
         27oQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNAowggNAPhlw2WOWbn6SAyQw4T/d6tWVNLnDDiTq1B2PjxOib3AtU7REW8fVwL8Nc150/V4E=@vger.kernel.org
X-Gm-Message-State: AFuF++lnkK3bUzqfHoirXf3j771wYgXQcMGVJh+MpC64aUUpwopMtxQd
	PnPzn4pRFgrw2oKHzIiWBTXz8dW2oChCSyP5cVBIL5TFCDN5SkHpzmdIHVCDIqDt
X-Gm-Gg: AYBFou3lq+K41srgYdUYYyh0x89lcd9bfG2DtYK0+R6wUiOrucKqUmh/B/j7RQ5cIPq
	W9/msouOga6rCLUmgPV7YOdPARWozFXL40jHvFP7VpD0SCtmjtcdo460vzAjvERO5qryc6P2M66
	biJodFJzgd9XSc+Pn3DbPBpRtuzK3scfqdSx327Iz4kA5/+Pd04aQRJifbGlU3IKaV182jbpRkP
	qvu8fja0q9RKxa8W64PqeDG7ut+18u64UyolshSLWpUVdn277iIZHBuEW+YFjBJRQOdRBfuu/RU
	M/Wzm/7Oo15JlfsWPZke1qZcfLT21ofuQsSzPJ8mhRuML5p8rHc5s6GTYXaSq/cVmbEGIkxftU8
	gAM06GHWR6exmoAsmFS/5YZi5Lp/Vnwq3DuQOogyAHWr2aMHrJQpBEvllKrWGGRdv+hkjm1cp5F
	uJ8LzfYt66D563sMfvwtVv7kE3enGCBOI13Gca7Q4vDqK7qQWtdz1tQaeI15DCz0yqO6sH+9JVJ
	8H4EZv95bukl7tLhBg=
X-Received: by 2002:a05:6000:2c0e:b0:484:3328:1ad1 with SMTP id ffacd0b85a97d-48590805fabmr30378346f8f.6.1789040047066;
        Thu, 10 Sep 2026 04:34:07 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm49155813f8f.22.2026.09.10.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:34:06 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	Itai Handler <itai.handler@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Thu, 10 Sep 2026 14:33:25 +0300
Message-Id: <20260910113325.717882-1-itai.handler@gmail.com>
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

Write 0 to GQSPI_EN_OFST, as zynqmp_qspi_remove() and
zynqmp_qspi_suspend() already do.  Skip it only when
pm_runtime_get_if_in_use() returns 0, i.e. runtime suspended: the clocks
are gated, so the registers are unreachable and the controller cannot be
mastering the bus.  A negative return is not the same thing - it is what
the CONFIG_PM=n stub always returns, and there probe() has enabled pclk
and refclk for good, so the controller is running and must be stopped.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
Note for stable: before commit 1c26372e5aa9 ("spi: spi-zynqmp-gqspi:
Update driver to use spi-mem framework") this driver stored the
spi_master in the platform drvdata rather than the zynqmp_qspi, so a
backport to those trees needs spi_master_get_devdata() in place of the
platform_get_drvdata() used here.

 drivers/spi/spi-zynqmp-gqspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 4d55090..24f680b 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1373,11 +1373,35 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->pclk);
 }
 
+static void zynqmp_qspi_shutdown(struct platform_device *pdev)
+{
+	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
+	int ret;
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

