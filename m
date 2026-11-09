Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193588;
	b=ijIuGT2u0EP7lR85IxdLXQHJ+lIP5TKgBzfs7rurr/oEoC6YJDBpdPfkyjAsw4b72RAi
	 G4/yJ4hoiM/DsvIqvmpmFDe8Xf4dPyvNxB7B9hYs9b16tjCvB9bABbj6Y1Pv6QdELgILK
	 48GcDCdSlJQvcy0Y2g+1ssIch/HOUqByFnbuTzMkWKBMYHdJhIbA0P2i/PlpA9lxIh5Br
	 mWAM7DIkY/XYjvDLHoUvTM7FdIjf2xDoYi7wwyxgw9+DSTyho+WHbZjLESrEz1kN/sEdr
	 Xg/nFOCDrB9DKKVOzy6Tj737A45cNba7D4HqgNO7x7UjeIRmnPrqvf+VCYrTll+5lHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193588;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xnlTJTEiB3aLPboCiIjlcj1pRp8iyQm987gKfLhgv9M=;
	b=tC04TiqZyr9IgOyKyBMFD04BFAuT99q6YVuXsnMi0FAeCDCvJF/mliN/lEalpbe8bNR7
	 fHSqPndZJWBtioUOv2Jn0r7X9WuscVEEzEEUt4IDoDYuGGnysOv3bpo5c3RB3vvvbO3Fk
	 fa5URd2/I6IUbkbAEpAS+S3SVVYGOXi7ythFNWbuGCVBCSBBAuO6C+rmQgE1DHRjGEQAL
	 U99yIQfaTTKBIj0mVJEN9kAffF4AHz83yMeOJ3v3bE4nX+tMCHqR4uqcJReJnpV9e0fNm
	 1+t+aru9+4LK8RSFZetQj7KfloBePvfvqdTvADGjcJncuJgbOVEhv54IWWxCHMPdwew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=h9Rk3BgP;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EF606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8EF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=h9Rk3BgP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193585; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xnlTJTEiB3aLPboCiIjlcj1pRp8iyQm987gKfLhgv9M=;
	b=h9Rk3BgPmttb8ojoFIqNiLYzjk7yu6rybWHQevOauXfeNQKVADZmVkFSiV5O/XTouvdi0dFOf0G6GIwx+MEiW4kDE2qs7taZYy2/ek23p4EHdC3KsrQO9tJild0Cu5+flpU1q+L8mU0TbSs0ZTHLW20StenX63O2b53C0xaO+7k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743712|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0132805-0.00344454-0.983275;FP=11193109253693785298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jziAnN3_1794193584;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jziAnN3_1794193584 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:24 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15.y] spi: amd: fix len==0 underflow and FIFO overflow
Date: Mon,  9 Nov 2026 11:06:23 +0800
Message-ID: <20261109030623.419563-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107060710-failed-5.15-e2f4edfc061e@kernel.org>
References: <20261107060710-failed-5.15-e2f4edfc061e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit e2f4edfc061e493fddde16c4bbe1c4f230f41e4a ]

amd_spi_fifo_xfer() unconditionally decrements xfer->len when a tx_buf
is present. The SPI core does not reject zero-length transfers, so a
transfer submitted through the SPI_IOC_MESSAGE ioctl with len == 0 and
a tx_buf makes the u32 len wrap to 0xFFFFFFFF, and the following
per-byte loop writes far past the FIFO window.

The driver also never checks the transfer length against
AMD_SPI_FIFO_SIZE. The core splits each transfer down to the
controller's max transfer size but does not bound the total message
length, so a long transfer overflows the FIFO with out-of-bounds MMIO
writes (tx) and reads (rx).

Skip zero-length transfers and reject any transfer that would run past
the end of the FIFO window.

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Cc: stable@vger.kernel.org # 5.8+
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Adapted for 5.15.y: this tree has no per-message FIFO position tracking, so the check is a per-transfer bound against AMD_SPI_FIFO_SIZE, matching the per-byte loop offsets here. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-amd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 39dbe99..ef9161e 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -176,6 +176,16 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
+		/* Skip zero-length transfers to avoid len underflow below */
+		if (!xfer->len)
+			continue;
+
+		/* Reject transfers that would overflow the FIFO window */
+		if (xfer->len > AMD_SPI_FIFO_SIZE) {
+			message->status = -EMSGSIZE;
+			goto fin_msg;
+		}
+
 		if (xfer->rx_buf)
 			m_cmd = AMD_SPI_XFER_RX;
 		if (xfer->tx_buf)
@@ -219,10 +229,10 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 		}
 	}
 
+fin_msg:
 	/* Update statistics */
 	message->actual_length = tx_len + rx_len + 1;
 	/* complete the transaction */
-	message->status = 0;
 	spi_finalize_current_message(master);
 
 	return 0;
-- 
2.43.0

