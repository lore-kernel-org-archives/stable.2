Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7C54145E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085780; cv=none; b=VrGFsPqgkmSwdhz/dSj1VSJsPlz6sC81GusNc5VIVSvfUx5NIZI2ZdSRugt071LtWUR1KGmRSHOIO5lDHAqKb6wqedmazfkYTSDLn74ay+Yar6WypFgqOXAzBpZlv+mq5jDBsEMsH7E3TRl5AZaHysP+M/Q88G6XEtsTbwpA/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085780; c=relaxed/simple;
	bh=1l/V2HPrHBo83mQJskJ7kf5HX09X/t5vDwcgY0hb5MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+FSKIzpbWR3yplz+ac9M3OYTNLSFTo/2zM8tDJ8NrogE++wPHJJJqhFYRtdXmzsyKSzaMHKenmObLknjFkygPCeGe7XHznSKFrddwxKO/MZODubWt5kah9YsM4vUPo/rHVXtprVujVW5bCAr7Vnbqja/JaGIoFO4Vu2It2RcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8/t9tmT; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8/t9tmT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b30c94so387239f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085777; x=1790690577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5WXLfd6Su74Y09kNhfZzFqu31KPb1wWngKOf9ppCGY=;
        b=A8/t9tmT9gIFlkjdPeM2qOX02EjORUy0VfNWcQ2j0UPOQSG7UuC4oTzrwYxQbXbFH1
         5C6fIWqvBqSqjFJbGsJzhVFJreB2RqwG/7bIvAV4Tpx4Y1KGGgrxscrbg7S1F65nlVLb
         uo9zTDTH9tbxiPCFaegwUO1A7M0l0Sdqg5fsCXFuJCIDXnk8o/BrZTEVb+xBZbzRGzIE
         A1JZZANkIDrqvWoJeG+yFTAy1Jhurf9RCC4cBu6zmwv/xMFVIuOG4kfg6tWieqiugnYy
         5PkMUUi8FnhaRjAWehOH0LLxyGYvkkJx+gmixVe9qpy0LYlLNoBiRqQCi6h+AN7qNxjP
         jtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085777; x=1790690577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5WXLfd6Su74Y09kNhfZzFqu31KPb1wWngKOf9ppCGY=;
        b=tnIvDRObBQY3BdHiFreoHBrFKn7wg1YKzjV7COWz0OdrG3rWiJOsO10twYiHAm5zVZ
         irL599ZLLPNAgcaeLqSER+ltRhMJpS1ahaWgM5sS3UwOj2xjek0hQNmzhSyjaHRMglK3
         b6WHi/mxuJO+oW7xsXa5PO3Yrcgv/IVxuInh2TlCSQAymDsP+gAn0AkNdRAfjOXEpyLI
         WmC25JmtcbqVwwvoIx2L77o5Hm1+JFMpunWvnhaFW8gAtANHI3dXhdnpQM2S1YvArFHa
         CY9uXmRrFed0B4b7OCIRnxs+/2Wm3QKLiVyRSaapQ+h7AgVteyB8BaT9AKYZB9nR9uL1
         5+yg==
X-Gm-Message-State: AFuF++nnI+OPft4LlHNNC3/EUQ82ZIzBBFdN1xI83IawLoz7ELNOLcxS
	lPEnYrv5FgYPohdA54EPiJCb6ua7kbKvXz9sAqnJ7H1aEGHcU4MKEgEWWeH1eQ==
X-Gm-Gg: AYBFou3HgdQ4Qa2tK6DKyoLcFnoOw8PHJdD4TyBhuIGfJeaW7RxKsTd5HPYV7duU05s
	nvR5UaHN4nv4N45lGRT8SeQvarYDHUUJdEinloTZkIj09XxIeTZk8ApHAOpqOkOSAsu02aqFg2X
	QZ2PdyUUX927PK0pPSmfnbcqJdGTP8HDisUfEiwSaqaxjU/KBdcGC78RNWBMOGrZhwlb+5GlCPZ
	dZvDMzSgmWdc3eYli2U3n51QY6rPa6qd0SkKYKv6osPiEjS3Jg6jlfHTyKWa+p7CTFXlbx1Rag1
	fEu7AqPykTdBqnhj9PARa2fLrY5Rzu9SaQym0n/KtODjTS89tIMOeDIwWwNbFgDFc2KMUB3/PL9
	ywQeYXoFSBclyvwEjp9WHNlgE7Pvy0+x1FffYVRInGSA8j2sHXxc9QgK9Lh4CRCFBdayraPcug/
	1QFxMXBwMAm62kPh+cEaLfLn9Xk0WbRx9tzmJacpiyTyaNOKaaCUh0N+R959lf3z15ukJe6SwUe
	dOyQez7tMGPgKagUVAd
X-Received: by 2002:a5d:5d02:0:b0:487:421:7c83 with SMTP id ffacd0b85a97d-4871f92df61mr17841763f8f.0.1790085777216;
        Tue, 22 Sep 2026 07:02:57 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886278008csm5067831f8f.21.2026.09.22.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:02:56 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Tue, 22 Sep 2026 17:02:38 +0300
Message-Id: <20260922140238.668400-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092225-whimsical-recopy-1b4b@gregkh>
References: <2026092225-whimsical-recopy-1b4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e922bad8b2d5028c51a096d083fea41cd0987154 upstream.

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
Link: https://patch.msgid.link/20260910174832.873352-1-itai.handler@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ itai: context only - zynqmp_qspi_of_match[] still sits between
  zynqmp_qspi_remove() and MODULE_DEVICE_TABLE() in this tree, hoisted to
  the top of the file upstream by commit 29f4d95b97bc ("spi:
  spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal
  platform"), so zynqmp_qspi_shutdown() is placed above it ]
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 204e5d03a6c5..ab62100f0b98 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1257,6 +1257,39 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	return 0;
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
 static const struct of_device_id zynqmp_qspi_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
 	{ /* End of table */ }
@@ -1267,6 +1300,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

