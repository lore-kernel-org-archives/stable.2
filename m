Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9A3A1A27;
	Tue, 29 Sep 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669515; cv=none; b=l0uvbbsGs8abGIg6hcKpO48LPFboqKGwjwF/XhK8sZofFwynuHUKBRrSQyM0qL0LRDXb6D8pPxSVI8ANryjQKC7z4tFn2WKfVg5viA6MbZBLoKLowKJ23KamfjF1FZWVDGtArKtrutOMRQissT5s1U26U/lT1lfkt89FMCbFYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669515; c=relaxed/simple;
	bh=b73MgKAItgyySTf5hj2SKjxwMgTFt6atIZwbtYvoawE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An3i4cTHbWUi5/hlCNh78nEksxF3nyAm5BvJzs7EvqNh1UnalArQ5IF8xndz8lHkJ4ijC6dAoaSoJ5VzZe16SjBLJnpmJU4a7NRsU1ew9mzc83oqL/oYisfErIvAS9bau032JCM4a9Z4Xs3ojC2PTSZ8fLyoQ1uSJ+WzKvbri74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=m25LuwV0; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="m25LuwV0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790669508; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9dAYlMmHUMWnpZ8EauEtsET/Sbn7dlIX0ZQljlomImo=;
	b=m25LuwV0mW7FxR3A1R2874gjQUAAVvChoHAhLGEeCsvhc9VMzCmwk19o7yeq3/SVtKO16VFqp/F/VTC5B5HrDy6UOJuVzLHnSL1XlkGZpyvSEUqH9T6VKGunhkj1pH3F3h93RKIiBdoTIi3CniXFdUNXK9rNlVDcjunR0L9bpX4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439846|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00409814-7.17852e-05-0.99583;FP=10549486485565427603|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jRBNq2D_1790669507;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jRBNq2D_1790669507 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:11:47 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: pthombar@cadence.com,
	wsadowski@marvell.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path
Date: Tue, 29 Sep 2026 16:11:45 +0800
Message-ID: <20260929081146.41041-3-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929081146.41041-1-liuwb@xiaopeng.com>
References: <20260929081146.41041-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

transfer_one_message_b0() falls back to a 10-byte stack buffer for
transfers which carry no TX data and points both in_buffer and
out_buffer into it.

With a transfer longer than 10 bytes the SDMA branch of the loop moves
up to MRVL_XFER_QWORD_COUNT * MRVL_XFER_QWORD_BYTECOUNT (256) bytes
through those pointers and then advances them by the same amount, so
both directions overflow the scratch buffer: a read transaction copies
SDMA data past the end of the buffer, a write transaction sends stack
contents from beyond it to the SPI bus.

Size the scratch buffer for the largest chunk the loop can request,
keep the buffer pointers pinned to it when the message does not carry
the corresponding TX or RX data, and only advance the pointers which
reference real transfer buffers. Also zero-initialize the scratch
buffer so that padding bytes sent for TX-less transfers no longer leak
uninitialized stack contents.

Fixes: 5cb7651f78e1 ("Marvell HW overlay support for Cadence xSPI")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Reviewer notes:

- transfer_one_message_b0() only runs on controllers with the Marvell
  overlay (marvell,cn10-xspi-nor); the loop chunks every transfer into
  SDMA rounds of up to MRVL_XFER_QWORD_COUNT * MRVL_XFER_QWORD_BYTECOUNT
  (256) bytes.
- The scratch buffer stays on the stack but is now sized for the largest
  chunk a single SDMA round can move; the old u8 data[10] was too small
  for any transfer longer than 10 bytes.
- The pointers are only advanced when they reference the real transfer
  buffers, and the buffer is zero-initialized so that TX-less transfers
  no longer clock out uninitialized stack bytes to the attached device.

Tested on x86_64: with this patch applied the driver builds, loads and
unloads cleanly; no controller with the Marvell overlay is available to
exercise the b0 path on hardware.

 drivers/spi/spi-cadence-xspi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 1f1cd4535..3687853e4 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -268,6 +268,7 @@
 #define MRVL_XFER_FUNC_START		 BIT(0)
 #define MRVL_XFER_QWORD_COUNT		 32
 #define MRVL_XFER_QWORD_BYTECOUNT	 8
+#define MRVL_XFER_MAX_LEN (MRVL_XFER_QWORD_COUNT * MRVL_XFER_QWORD_BYTECOUNT)
 
 #define MRVL_XSPI_POLL_TIMEOUT_US	1000
 #define MRVL_XSPI_POLL_DELAY_US		10
@@ -1107,7 +1108,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t = NULL;
 
-	const unsigned int max_len = MRVL_XFER_QWORD_BYTECOUNT * MRVL_XFER_QWORD_COUNT;
+	const unsigned int max_len = MRVL_XFER_MAX_LEN;
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
@@ -1130,13 +1131,16 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		u8 *txd = (u8 *) t->tx_buf;
 		u8 *rxd = (u8 *) t->rx_buf;
-		u8 data[10];
+		u8 data[MRVL_XFER_MAX_LEN] = {0};
 		u32 cmd_regs[6];
 
 		if (!txd)
 			txd = data;
 
-		cdns_xspi->in_buffer = txd + 1;
+		if (rxd)
+			cdns_xspi->in_buffer = rxd;
+		else
+			cdns_xspi->in_buffer = data;
 		cdns_xspi->out_buffer = txd + 1;
 
 		while (t->len) {
@@ -1163,8 +1167,10 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
 					return -EIO;
 
-				cdns_xspi->in_buffer += current_transfer_len;
-				cdns_xspi->out_buffer += current_transfer_len;
+				if (rxd)
+					cdns_xspi->in_buffer += current_transfer_len;
+				if (t->tx_buf)
+					cdns_xspi->out_buffer += current_transfer_len;
 			}
 
 			if (rxd) {
-- 
2.50.1

