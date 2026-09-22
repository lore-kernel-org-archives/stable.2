Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7C367F21
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085801; cv=none; b=HsdQW+8SKnS7ERyrjqK1bWlA9yflOkIvv3mkE0P0kp5WmwKwIGa2iSCUumal0V62eaAD1TGLwSInddOjs9Drc1LYRidLN6aAKSwSSgJxiXSZNm7DfN0m0sqS0f6ltCiqabaDui45Z8j3VMljvWLlmhcUcqh40WohXmeCM0MHa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085801; c=relaxed/simple;
	bh=SP/tglKUY4Xx1E0o5WSy/fI13AXXBdAA4aok4BUrzgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQ4roSkHrWCe04HCA47dJioLHhlqlnDSNJsC7ktdJltmrN9cdSlNfkh2q2vIcNGO3okQhDNjk0kWir7roGxeYyqSEa7kC2YilvLjhvmaZEXZBN+i3fuWtHsGtDFROvY2dtIZB2NPKVCoV9bvrIUto+5KBZ+/06EgeJZP1usNXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+v8ZFqh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+v8ZFqh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d0726cdbcso2334485e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085798; x=1790690598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ED+I63/uxCiASGWW3fDtg1yGBgw7cOwlr2JNK9CfDI=;
        b=s+v8ZFqhHXuoMI4LKONLsfOLxWpZXhSg+0vEoWS2smeWx1wGxUdgSitAa4ULK5a+XL
         0d7ZrH6iNgnn3g/wEKmp8IfdrXkrl3nACVw1E9ztr94ymxN8V0RsHtlIy7AVMo28GZCH
         oOxKi5go0vMJK7odUTwcBQLDJ40Wkoh0zy5h4tWJRWUkY7CtaEZu7ewXUQbewiddqpHk
         1ay0fE77ZsUtEUBWR2g6cO0r5qJ0GnHs689WlZOZ3PLFnpWRVq/7hHJps+rK4W/2YRA+
         lBfROnHGyWExikWG63YR7Zpoz1ZSQa0LrmiOOiYQ0rgELHmUMG8mJBzSprQwerVQzr4X
         V+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085798; x=1790690598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ED+I63/uxCiASGWW3fDtg1yGBgw7cOwlr2JNK9CfDI=;
        b=L0JUQIoyNMIGYxefRx/bklJs1A48bELV0i+Zte0FcqNWZQBSwqd1bK0G9wX+tQi3eK
         Jq7FlCG0XNRpu0i8TbCj1pvHqKrrbnw/WXoAjMjp6U4NlY0AOZEDTGrw+zHhbXX/pfai
         1bjjRrQVv/waaZWuwhMNISWzHyRQQOryTe/cL3PMAEpKC7mGwvBhYd1umJd5LecN/OND
         mUqtqLpCA/BydEnWsMntqvAzJY94DfIHG3Wz3TM+QH36i691Z8OVypr/uisafTmR8SDJ
         D/bztfPSFHKRj4FWQlfDy3PNCeZJpahH3aGEiA2TW9zaMYXSjTF1+dZbO5SzdKSLr37P
         qLzg==
X-Gm-Message-State: AFuF++leVVJ9L+GLA6c865X5HEnRVP9+FQ1/95LCh7SRWVI8H+Nqa/+K
	61n9vvWZM8/r57tB8x2GIpx9IZjGXuMTPMb/k7QYaSebzpyZyvOHMJyAxd4+5A==
X-Gm-Gg: AYBFou1Q6NfEsCeuWaXmT1HaAULM/rW/3xr0rNqAHwhMF2kv/yu8lptPL8YC+5ntOMW
	iqCB8+ELnM/kCrO3XvGhq2IfhGxQ/J4IaPhpoDBWmADE+S/OP5tMA5bksqf2+VGTllNFKh4tUzg
	NtOcoWEUyJiKl1xg4Dd7XljmWvL42a4XgS/DB5ToUXt+cfieiGunt2hifWpKjASCd34Czx9YGiN
	wv2K+9z+m3mAC8FZrpceDeCCHJJ/cAY6Yr1+E7ka02/Z4HMlUUjXs+J2sYNycmwbmvV1F+YLO0S
	qizvgyGGVz0OjgpdoTVout+yRVuUMs9nwaXAIfycBZAHklRwcepy1v8LDlKU32uwNgSTQv8PMfV
	rTEaowdNHcOhy8kaswi8XStHHzy4cRHa2HdfRQvXxAPMKUUkaeUOiHKpkDZ/zGZE2wEKydKnMGi
	mbKvo/E4bLtnb1MdVx5dp2S8FvFribEWDqvfjVO2WSpwlxCd2nH0PKp0vj11o7Mflky7iR7sCFs
	iKcvPB6/uybIvgaX0I=
X-Received: by 2002:a05:600c:1c13:b0:49e:7186:f36e with SMTP id 5b1f17b1804b1-49fc7dc1e75mr227118065e9.1.1790085798039;
        Tue, 22 Sep 2026 07:03:18 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc061fsm75957275e9.4.2026.09.22.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:03:17 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Tue, 22 Sep 2026 17:02:57 +0300
Message-Id: <20260922140257.668414-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092226-spiffy-drainage-530a@gregkh>
References: <2026092226-spiffy-drainage-530a@gregkh>
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
[ itai: context only - two differences from mainline here: the
  platform_driver callback is still spelled .remove_new, renamed back to
  .remove upstream by commit 494c3dc46776 ("spi: Switch back to struct
  platform_driver::remove()"); and zynqmp_qspi_of_match[] still sits
  between zynqmp_qspi_remove() and MODULE_DEVICE_TABLE(), hoisted to the
  top of the file upstream by commit 29f4d95b97bc ("spi:
  spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal
  platform"), so zynqmp_qspi_shutdown() is placed above it ]
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 90060e5a314c..590ecd79cb50 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1236,6 +1236,39 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
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
 static const struct of_device_id zynqmp_qspi_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
 	{ /* End of table */ }
@@ -1246,6 +1279,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove_new = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

