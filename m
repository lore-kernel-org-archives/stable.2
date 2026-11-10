Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321157;
	b=vfMb45ifpfqbvWXDzIsYXb/GfcBP1MgyPbskZyDQN2c9cSfIv+yQ9XJEgyo3+85uw52L
	 dvvJDIeEYww4+HcmDAnmq+q1CJVBsP54cauc4IekUaRwkQdretU69KlICVyOTwRpcHRbp
	 QUId1x+I6EmStDQdLYxMxFSXpvKWGV1k2Vd4SlRasGZg6HYGWO8MSWI/QPIqGZoqYNLio
	 MzHRBMMgNWOUPbtz2nSg0qoa3X2OwY2JqsRl+BH0xYElObZYK2IaglxIeNmiJNNAf2PEn
	 4KjS71P0euctCSiu7NJdnQQdDNkjjbbOt0tfmVtI9nzFEJp+5rdMjeF2KUhecF0izOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321157;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=WiJbtImCGtCDtksbAdjOSBGm2MNtIJsPvCdE4RgPTvI=;
	b=36wrQ3eHCOwHaK6msbvBE2YTNs1A8CMSpnU4IEtmcp98nGo39db2IIKn6nM5AvxJWFZC
	 XEXUZ5fShD8OMAwQ5uzU0CyU8GYFcFsTOYl9hOHX6fPJCG+YWpxap+1JYo3GmuKotWCA4
	 O9lmQR7crvSepx9z3CGYbimYE9GzkrRJ41BR/j2JnxSPUWQPYbHVJVq3JW9jbcwRF6ojB
	 U98Jy9RgMzxUVVHH6orv/B9XOB6wGRPaYmA3D3KwkvN+hxECTFUQWT+T+bKj6D8JMmQdH
	 ZowZySDnw23J7U2OeKco0YW0rNuzDW60I7oKKFcuOsDyRZDU9D7AuRPqAWCYZTnfbtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Yi4cEGyr;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B5606A330;
	Tue, 10 Nov 2026 14:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 756B5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Yi4cEGyr
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 542cd9c44;
	Tue, 10 Nov 2026 22:32:24 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: marvell: Fix potential DMA buffer leak
Date: Tue, 10 Nov 2026 22:32:24 +0800
Message-ID: <20261110-9f141e6bc8-mtd-marvell@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c5dfdbe803a1kunm14d8f7f016cdcd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBhOVkgeHUgeHR0aTE4aGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Yi4cEGyrTSWNWL2mU/L5MBq86NhDW0yruf3+vN9mPP7yb8zhVPOVnOuFroF/4USBDiCWs3f/jbqvGPmKZRGtwsppggVgMBz3T13E3BER2PLRmk0yAzdW+HG2lolgHOvPi1y3BhNoPAGl5H4RF3nG7/i11Ukb2J2ZqitSuMnRLpY=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=WiJbtImCGtCDtksbAdjOSBGm2MNtIJsPvCdE4RgPTvI=;
	h=date:mime-version:subject:message-id:from;

The bounce buffer allocated by marvell_nfc_init_dma() is not freed on
probe failure or removal. Releasing the controller loses the buffer.

Use a device-managed allocation so the buffer is freed after the DMA
channel has been shut down.

This issue was found by our static analysis tool under development.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index e5fa5540e80a..1adf4dcee93f 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2862,7 +2862,7 @@ static int marvell_nfc_init_dma(struct marvell_nfc *nfc)
 	 * for DMA transfers and then copy the desired amount of data to
 	 * the provided buffer.
 	 */
-	nfc->dma_buf = kmalloc(MAX_CHUNK_SIZE, GFP_KERNEL | GFP_DMA);
+	nfc->dma_buf = devm_kmalloc(nfc->dev, MAX_CHUNK_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!nfc->dma_buf) {
 		ret = -ENOMEM;
 		goto release_channel;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
