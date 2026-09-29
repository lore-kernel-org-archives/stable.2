Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE13AD516;
	Tue, 29 Sep 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669519; cv=none; b=oO4mzHCDp+/5gphkLg/qJXAkTtYuDNSqHnWnfYvX6FXRr8dDK8Es0TPboCuir0dRPJOpY9Q3g8ypYNE5wr0lBgYKfpL8gyXHdJdPoze34d1TD70zFER/NHUZQI+u3Eo+piGwf22A9LforGMNVDi06a7hdcYUZZNxurZxM4ICPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669519; c=relaxed/simple;
	bh=YxiwJ+Ofz5uqqOQk3bEWRpxMx2qQBZ4c9JO2fQwANVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPMNUhTwgSfd6pKNJj/omd2IJnjvnuQntxMuSZ9+dySfckML4BaMDwaY8eaVskeMa9rEzwNAQx4TTCbJDD/cJyukWRn5/aJ2TAZoBsg8k/Ey/t6Rk0w3+s8U9OLE/flq81lK8dHxIjzDCInfQddnSVb8GKS+Gw16kGv7biTu0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=vZHAtVJS; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="vZHAtVJS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790669513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yNdwn5xy6zu/8shhb//9FSk5g41YR9PBF1d7FFh0UXM=;
	b=vZHAtVJSKmGonPsEFMDsrp/dbs6fFsDjtOQZ2uyyfyezaIOgVlsPpnIa7j+wt/rmVvRuz7XX6i+NkR5Bah4RvPyR2N4CljpoaFgUscUJmBZs0Oh98RTrJbHo8X5XATlZZXhmDZSLYZijWahi5zBDo0t3/o0KXtJBHaC8BmCvD2E=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437544|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00590453-0.000327095-0.993768;FP=10266479451471236313|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jRBNq7R_1790669512;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jRBNq7R_1790669512 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:11:52 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: jth@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] spi: ch341: handle transfers without a TX or RX buffer
Date: Tue, 29 Sep 2026 16:11:52 +0800
Message-ID: <20260929081152.41753-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ch341_transfer_one() unconditionally copies from trans->tx_buf into the
TX packet and hands trans->rx_buf to usb_bulk_msg() for the readback.

The SPI core allows half-duplex transfers where either of the buffers
is NULL, so a transfer without TX data crashes the kernel on the memcpy
and a transfer without RX data makes usb_bulk_msg() store the received
data at address 0.

Only copy TX data when the transfer carries a TX buffer and fall back
to the TX packet buffer as a scratch area for the readback when the
transfer has no RX buffer. The packet buffer is 32 bytes, which covers
the maximum readback length of 31 bytes, and it is not used by
anything else while the readback runs.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Reviewer notes:

- Both failure modes are reachable from unprivileged userspace through
  spidev: SPI_IOC_MESSAGE accepts transfers with either of the buffers
  set to NULL, and the driver passes them on as-is.
- The readback fallback reuses the 32-byte TX packet buffer, which
  covers the maximum readback length of 31 bytes. It is only used by
  ch341_transfer_one() and ch341_set_cs(), both of which run
  synchronously from the SPI core's transfer handling, so nothing
  touches the buffer while the readback is in flight.
- Pre-fix reproducer: open /dev/spidev0.0 and issue a single
  SPI_IOC_MESSAGE transfer with tx_buf = NULL (memcpy from NULL in
  ch341_transfer_one()) or with rx_buf = NULL (usb_bulk_msg() stores
  the readback at address 0).

Functionally verified in QEMU on x86_64: a CH341a adapter was emulated
with gadgetfs + dummy_hcd (the emulated device echoes every SPI stream
packet's payload back on the bulk IN endpoint). With this patch
applied the probe completes, and tx-only, rx-only and full-duplex
transfers issued through spidev succeed, with the full-duplex readback
matching the sent payload, and without a splat. The emulator and the
test program are local test tooling and are not part of this
submission.

 drivers/spi/spi-ch341.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 6448a44a8..6c6eb4ac7 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -78,14 +78,21 @@ static int ch341_transfer_one(struct spi_controller *host,
 
 	ch341->tx_buf[0] = CH341A_CMD_SPI_STREAM;
 
-	memcpy(ch341->tx_buf + 1, trans->tx_buf, len - 1);
+	if (trans->tx_buf)
+		memcpy(ch341->tx_buf + 1, trans->tx_buf, len - 1);
 
 	ret = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, len,
 			   NULL, CH341_DEFAULT_TIMEOUT);
 	if (ret)
 		return ret;
 
-	return usb_bulk_msg(ch341->udev, ch341->read_pipe, trans->rx_buf,
+	/*
+	 * Half-duplex transfers can come without a RX buffer; the packet
+	 * buffer is not used by anything else during the synchronous
+	 * transfer, so reuse it as a scratch area for the readback.
+	 */
+	return usb_bulk_msg(ch341->udev, ch341->read_pipe,
+			    trans->rx_buf ? trans->rx_buf : ch341->tx_buf,
 			    len - 1, NULL, CH341_DEFAULT_TIMEOUT);
 }
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
prerequisite-patch-id: e48582f6ffe124b3806593af6e22b74682c8a83f
prerequisite-patch-id: 369f74b9a7ecde56141b13ec671f9200345a3bab
-- 
2.50.1

