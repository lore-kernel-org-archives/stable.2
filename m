Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79633F589
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085821; cv=none; b=UJvc74C/dR/hxSGNOIoLPtWwSK3aHehJvo3ck9p5c/sX5xyxVGN9RSgnvrgAsguhpVIkzH6crHkPwwWyyLWIVl9CJG3dfQHtLbNSCvKSnvgHE9z0Zgo06QWxmxgeW224vFwN3wL6EWIO9PmrHwOOS2yRzTwDeEFajIZ04XELVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085821; c=relaxed/simple;
	bh=rIemxOOxWeIyMf5vvkr5XaHULz7xopIMSpU9mw6kJkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsaDqzvSeI/Z1ib2fiUQf5eR7uZFgR3RG3zy9U/jQ2dzdnxDLdd+yCcHuuyAQbIpfJqg7N92jPHQBcsRXPmtV9NoVzHit8tjTKklC9EtRYQivxPNhwwfKI8urXP24iPy9B7nP+uui+UHQstdgSrgxGXhH97DsP0quA49LdAlfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS8vGcfh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS8vGcfh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e82ea30faso2627055e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085818; x=1790690618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gaBw9cHd2AoEde7RLnFiRt5/QcOMY27gfbbceHB6xOM=;
        b=oS8vGcfhYKiJ6IAL5Sm5gmB5GJS/hIlbHwLTyNn6EccAFw0yDhENjKoNlwy1mJM7fd
         ZT/I6hyNqlCqvOLcKw2rL0GtQH5UYJyh8BpGurAHjM33I/Uhw1nT3lPBeUEsw4XsibkC
         alobwi7E0sVNVgTXEME9RanfNqRvMiN4a5h+NG5cr5HP+NHRxRu5M0MsQAVoeEaLnDDZ
         BlS0ibYjC1MWUPaheDTHG8wVbYTbkMHVct79ZFK8QiXbVQ62NFI4bqj7m5x9wZjf779V
         1ji89ervBUaoE6FFiirQfrkJuUfjeA4NepwlUt2hLSO/o3M+KMIhqJAic5JaYwVg/SKg
         iNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085818; x=1790690618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gaBw9cHd2AoEde7RLnFiRt5/QcOMY27gfbbceHB6xOM=;
        b=sGB1e3ZaBPovDJIBaU08apXTbxg2MkthKdNNmE9CZ3zbpJ1EvRQXk1N7k/ksI3VQc3
         57RSVzh6bc967R0Bkp9M/qZrtqRrkfif0z43EXISscDu3YGkX6pu/bZhlp5mVGbkXriW
         68bTN6Lrk51uSM8CFfnEQATV0Dj9cB29/wu+MOEJFQeEjOIN7k8+743aP+MoD4YnqQrm
         s6f69lHKKS5NGbOblo0RXey3337pe5f/pc0XuZiqCKn8wIhxQQ0JMp2qVXjzvrQhNYRo
         UQH8mVqUF4w6H7OR2/4aOdz7gti1TOJsPdLrf/CiRTE1gKY0GdS9fa7HJdghW+1YfGsG
         DJGg==
X-Gm-Message-State: AFuF++nOY2XqZkyqrj/v/ucp+TKHGIq0JaO2Oi+GvgZXDLoYB2G6/eRP
	vbVpWlwUEnmKdY/mH/bFV7NQSYM9X6ndX7qE7SYUi88tQH7qyoNQdc2gwvaXZg==
X-Gm-Gg: AYBFou010KIXoVkRH0bJL0t4kfZtvmBm+qB6TF9dpCOsTT0RxJyYIPN99iz2/eTkESo
	JEojvORgDseqqEdZXsfzx5P7d8ARxwNjhdRV5KKkqaXZr8TDFMUZuFxYp5yvL3kmQ2ih7T2erKj
	vQKB2G+QttvsH7T23wEpg0DGKgDFuKnue1g119Cfxfoq0CwKSjd5twy0Qs7Pank3azCfcjGwYtk
	vOQLmQcz/7kyMKADcy8MZJK2gsDGJgCbTdjUbTuQa3bLswcANQ2DsnL2+waeAQ+/kh5UV2MadR4
	Uj37hxCqXclUuhbDFImJHsFO2tcCn28x7Laz3n/xC+IpBiNGBnIolmAEpgKKOLcbDFiGkhEqGsO
	cjOQ+9j9HxpfCUU8fCHLup99Ru7lYq0oGZX2/bTF8Hd9BHAKzcPHrp43HwZgbtFLYkEH3tcwtLW
	9T7UDXllVohXAnnpYUjvTqIw1V4lURD0I1wPn09F7ci9EzAVkEA6zTMb+U2+Gkan6GxOBZh6Kjk
	c1shfKrdFRzcjc3teb3Co1vVDce8Q==
X-Received: by 2002:a05:600c:a15:b0:49e:7c8b:fdef with SMTP id 5b1f17b1804b1-49fc7f27299mr178118715e9.2.1790085817581;
        Tue, 22 Sep 2026 07:03:37 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaaec8ebsm50745105e9.2.2026.09.22.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:03:37 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Tue, 22 Sep 2026 17:03:18 +0300
Message-Id: <20260922140318.668429-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092228-clasp-turmoil-85b0@gregkh>
References: <2026092228-clasp-turmoil-85b0@gregkh>
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
index bbc918815634..13f3abef4349 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1220,6 +1220,39 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
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
@@ -1230,6 +1263,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

