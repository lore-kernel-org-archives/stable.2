Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB43769EB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085762; cv=none; b=MrRumiEZwk3P/AHYP5A94EHKD8JJq6eU4Bph3O5Qqb04ICNzG3FLyl3rUn4yG2Wzh6Ti4mbvzpVy8xfsUnYiMiNQ9/FnIXh801HynP0+jC7EdekBaBLENmhAEfjKCn8bu78stk8CVeVEfo7+Yhq9sqVw7l3R4gTWINZ1xAhTtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085762; c=relaxed/simple;
	bh=JFzGIQk2x3tiWb2GX5XEyDQJC1FWRo5tUlnpMx0hohI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6EXDQUENmUrqvrQdCAYwIEcpx6G4/JzNhkrX8iMm4HFLsKtRbNtNBSUvLvg8tDF3UX4gLRSki0fE7xGfwEcso581JKc7BtxB79ykiB+gQ8vaaJQK/6GHthm9oBsRHVpFcc49GdYvVlaJcbpe/kfTWJibCMSMPaGoTq7N8Sfq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJaXmfQj; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJaXmfQj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac8990caso477730f8f.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085759; x=1790690559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/e7o7a1NUNJR3McVW6xbGyUQwIJSEWhzsOh+L31nP60=;
        b=TJaXmfQj2Wk5FqTt+DGJTcq+a1Gp2D/fmnSRbPKAMpEAGzA3TM2E9lxxMtL0hDXHIc
         xdTDicBDWojygT2TbTPgo00hdd7OLLNU2aKkD2OlHHAZd3xow0gmzKtRVxFrb35lU9CG
         XtfknH6gUO8Z9ETyBpD4GppPEKQgQSoV0LC8H5fxRLpuV3sSlddFz4uaCd/jJPUB4Uff
         MOq7Fhj3XeFjGQbqJxYNjLCxebRkhk8Z16++tpnQEwaU35OsRXzAj0srX5S+xQq0oFsC
         WQxhMJC/BotrwzOSqDvHRJzufUvg+05IoSQckEV+N6quvo4eSp2NhZ9LSAzBjRId0Vr+
         tK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085759; x=1790690559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/e7o7a1NUNJR3McVW6xbGyUQwIJSEWhzsOh+L31nP60=;
        b=0XDn9q7Us14g4JS6Wq7Sf4jamPrCv1a6MMaSBjNr8WRz9pdWH+v4ML1uQe62fRyiDA
         db/mbPrFAqer8hdfvJ7orUTwQRm/bz0D6DUqplkwII1tdBFdzlFk8IbV95kg/mYTyTfK
         8cp7EBxQK49mrCFwul3Ooh0yH6eGqfmryqi6xQe0IOSbU2XShMzp/aEm8U0lrJHb859A
         f9gZ+hDqhF48LZVO3KYGa8QKz3sRMH/GYchdJoazYg6uLUtW01K40+crY9VzNJ+cUrz2
         YYbIxfM10GkAI9blYXGslEHD9QYCvT2NUvOqGQ4D5psunHWyTBf9pt+3PfYLB8ae9cr3
         24cQ==
X-Gm-Message-State: AFuF++lXYNTmRw11aRqu2MsN9Y5k41DvbCQJbd0V6+3vr5xdPooqDxxf
	3tQy2Lg3YVcDAz0XNpUbNflTZaoEPSZJOjemlI1Xi0yVVhSFHT3UqlL2QUwa1g==
X-Gm-Gg: AYBFou36R6bIPT4RRs0IwTKceSrA/d4ciRWUDnJTdWt4ATvg6xO3F4Xg5iXhAUJDO3h
	vSQo4ZyftYkDNXECQCq2RMVybxcEenGTja6xshkuM2HdNDGmACyHAssNxUBurzipccbWG36EEvj
	ta8LWkY2XebPpgy0t3xrXEGKVPvC2xM8zW4pMdZjxe5QNiP4StsB0QVzP/irmIKjliwvmBoZ5sH
	1hAnKS9VCjpdbqo4iqTO0UV41gZ7wJdeQR72p2py0bGY0ctTVN/UBrUozSmtMfM8yswZX9I9hAa
	rC60gC90ovAXqqpOlYoyit5ogKw2FLGqGzXG7mahJVjG3rD+v50XlRC+td73NqeR6wPN+Ammo7n
	JnPUyxcvzE9OJtGtJp0wkZaXc8wzKUVd3nhG6YFCGFmRmkvHJUDY/Inw3jWjI+ZkokUZG52tcig
	tP3vDbe95jAuTJKhHsSGfyRTWrQL2MYU4NMGeiBUZKCmUVH6ZkpnD+pYGb83q2FXv7cZFXGV960
	IQz+uZrbwinForJkg3R
X-Received: by 2002:a05:6000:4283:b0:485:8df0:dca with SMTP id ffacd0b85a97d-4871fa7286dmr19881808f8f.3.1790085758557;
        Tue, 22 Sep 2026 07:02:38 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277e185sm5517709f8f.16.2026.09.22.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:02:38 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Tue, 22 Sep 2026 17:02:15 +0300
Message-Id: <20260922140215.668385-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092224-fog-reps-4fae@gregkh>
References: <2026092224-fog-reps-4fae@gregkh>
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
[ itai: context only - the platform_driver callback is still spelled
  .remove_new in this tree, renamed back to .remove upstream by commit
  494c3dc46776 ("spi: Switch back to struct platform_driver::remove()") ]
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b9ed6d6824b2..f0710f2924bd 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1377,11 +1377,45 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
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
 	.remove_new = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

