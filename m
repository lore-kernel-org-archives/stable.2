Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C3355049
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085738; cv=none; b=a5/UU9wYJIcke8acPk0K01HRO+Usqbe1Gb4gkmcITHm+OAexpX1DXj7fTOMnQhme1Y99U+xtpfmxy5iwGIFWpayQPwuCi/Ch69HF+/uexWaiVWFYOHDTPNCDjP5iM7TdvSzeufFbvafIoSdzBiHBsM5LVftorxVpzlVgKNow7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085738; c=relaxed/simple;
	bh=KZpeAX7+HHLoyyX9IFV3bYdVXybz+KMbEfHZhfxnlYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjPxrf1CHW1H2Dh/ELNLIbRGZcYhvPw0JaH+w9ndRKrn4QEpF20lMTzygtwVpoj/E/TtTwJ0tTFfEGkBUo2lJ+fh8lcRuMNx4AllFz9otfvpfAqXfmjSQZqzJ7gBU0JVN5bnj+/CZycal98S5y0zkpGK9fTMbXBNLPlfjzFJiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6yvKtTw; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6yvKtTw"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48436686a40so396174f8f.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085735; x=1790690535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPt7u/kzmzLewVflkCz6AMZQnNp8JD4lhbayHx15AWw=;
        b=j6yvKtTwWboto6FplbwlZkbSSIaYOFlQ7RH1dUaaSCwmmzfv5qngoYnJ/fHv5NOK5+
         YGjbjLTjdOnBeSiJSpyYbbxFa9qzF5iBMt/ZbfO+Rt50G8tWeDItK+4Q4YgOMz3Pi8Lj
         UDnwPw9e2IzugMvhB5qOQT9XwsXGpd6CmOMNhMSG+BjKyDIIgEONyv2HQnIFP4gEDy4y
         sfmE3wZZuhwvBGddRoFM5fz8S9dmEj8tEd5iQ5OjoJboDOVaSn+97MUFexEZGc43Oo/I
         QgQLUJWDKiNRM+TIEFkxnQDYkviYL165xSl5SGy8DkH0IcqLudDBxXI2Vvv4xVfQh7Gb
         1QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085735; x=1790690535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPt7u/kzmzLewVflkCz6AMZQnNp8JD4lhbayHx15AWw=;
        b=QvzOHPfXVXi61OO/voZmJ4wGEv3ThZOadJEvrJgs7vFNca+rJCs7OhSvZXcp78XrZ6
         WJ/mnx5lh1TIXjM4U5BGfKVst/0JYpMb6IjBr2lcnu2r2g1rKVRJM3nZiogg9iqv+Ebi
         EUv/gvapkMP5zUpyYFl0ivXMvMO4mahc5QBf8ou2TCkNhksfdmgGj7ldluipGfxrIJDe
         5Usl0esErJeAx/PXZc9xOmEtru79wvSYo+NMvixsMHf/A/smLFkRvWzNUYYm7DOmQOlx
         JHebzBRzkdeUYmnmP+C5eLaXCjMNFkILuj8XsOwY50JCGmSfxmaXo5BPd0zwPFHDBPix
         IIsQ==
X-Gm-Message-State: AFuF++k2eZxt/W1hCwetcJYcUO+rzqdNtetLCkA2QZu3HGzlIxnB9/Xb
	rq9iYPkXsr9PLVFHGwbV2yD4bd7khaVQ6feKOdWPkM00V9OOC9+v7sEWVBcKtQ==
X-Gm-Gg: AYBFou27FTrAOATHUsm8dlcUcE66szTE1a8D379m/aG90oy6dH1sIFrovF7TlvHoWqo
	N6ySjC76Tr4Mjqia8E3JnDXh7/jCv5my7HwHziKpLjw54k8s2hBlIEjmxffRbRb8w30hVnrfCpo
	9ImLpS1BvJazsRsdOOlo2tsf6enP9O/GiNzVfB1jxjheZ9Nbesh2gaI92nx8IxZupbWSf6dqr9c
	xqZ/u4qHhKnoMH7GXEj4BM+XHEUyPE9ugnls0Sz5E54JLWRFcZ9XWnea5bh0PpJJSB+mqrhoOUj
	fkSJfPoP75uEi/RUlXi1rTmzwUrPJ+gNjA50CJGP/MzH8CfMSScN69cd5MSKlLhcTBhAPQUVmHH
	zPAMnM+H02tKj1/suIvkwNHP6T1jZNDm/e6reZJ/cgA43poK+ye4EMHt1kFNkGnZuVtOQrF/cGb
	wWE12+5+u7C0r8AIk+3MkIhDlHjKmy7rrXlDfD3HMiH8PuSJgMCAn04MdeBJVxKL9HcTHDKr19w
	P1Mj9HbAJPbSiI30jQFUPrunwxLmQ==
X-Received: by 2002:a05:6000:1a8c:b0:487:803:ba34 with SMTP id ffacd0b85a97d-4871faa2329mr18887207f8f.6.1790085735023;
        Tue, 22 Sep 2026 07:02:15 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862789080sm5575094f8f.28.2026.09.22.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:02:14 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Tue, 22 Sep 2026 17:01:44 +0300
Message-Id: <20260922140144.668363-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092222-marital-chasing-0267@gregkh>
References: <2026092222-marital-chasing-0267@gregkh>
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
index 143c572b263e..4fa68b11709b 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1385,11 +1385,45 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
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

