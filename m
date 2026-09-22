Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B919434406
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065846; cv=none; b=PXMIDBfU3LRTsqmcxeaXPs13KHVht4cRJVT8uWOgeKvtK4YAuLp4op82iB0AyH0nbFqFwG+kIa1Vvjo00aV26KoBQNTYzYBjd2lkrU9WZANhim0XDzxhcSeB0EuywTZg5ULuWxaQurqjLnk23ai5dJTpkJMO71Vue+Qim0WRAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065846; c=relaxed/simple;
	bh=FI0b4G6zVCzPAyihM47Y0HwEBHWjK4IFXJXXnMZqM5k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uPjK5oUxHlWZnSt6u5o/RT+WRGZSaDfqLXOZ5hU+N3EiOmBFOQu+ckhnO/1InaBAU6sIqM4SsMdDDV8+XcHJABDy+FSn0xCOQC4xhsxHiduMuKiwV69Ge7iYhKjEzPdRQS10w5OYR+2SnX1Eh4c25y7SpDnVhClsj/Gdn4dC+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/xYco4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/xYco4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED8B1F00893;
	Tue, 22 Sep 2026 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065841;
	bh=fw9cGU6mU7yMIqk7uVm+kRRKuzgPa4hzwyMt4PT/LAo=;
	h=Subject:To:Cc:From:Date;
	b=W/xYco4JHHu7nejjBl7eRIEhrzcpZw+9OF5cs8wLr8sRKkt+/sfoPMxkUEXxHvu2P
	 8w0Q/YngKWVTfB6Dcc0l35tgwiEbIHM0H9zGh7t/iNRGh+q0qBtS1UepdHdc1OSHCi
	 lmKOe6hGQZMGp9YC6/fo003vb3U8y0NFIC3IzCh4=
Subject: FAILED: patch "[PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown" failed to apply to 5.10-stable tree
To: itai.handler@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:30:28 +0200
Message-ID: <2026092228-clasp-turmoil-85b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e922bad8b2d5028c51a096d083fea41cd0987154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092228-clasp-turmoil-85b0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e922bad8b2d5028c51a096d083fea41cd0987154 Mon Sep 17 00:00:00 2001
From: Itai Handler <itai.handler@gmail.com>
Date: Thu, 10 Sep 2026 20:48:32 +0300
Subject: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown

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

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 4d55090fa443..15e9d3ef8839 100644
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

