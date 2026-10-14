Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFE53977E;
	Wed, 14 Oct 2026 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987508; cv=none; b=eh/MSfoazptqiZcDthLo/3ft3D7qRpYpCJ8/rzqW/i55MTSbRp1pMbsKecDYYxwo8sQD+Mb9EYxBigD7FsF9rRE/WkaY1vyANmxLNIr9Y6Qf0wWtuW/62f7slbSf4JvdEi0XReiJ1d3yEGUun8nl9zSRf1jBeMGSIDADIAVApe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987508; c=relaxed/simple;
	bh=WYOaFh8XOBPaGXfFebVPilIZk2ReTL8zZxieJ+itK6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HufklUfdysDOg8mvOhN5oLu9O2CJ+XzkyrTeWf8RIlUclykhcZMkt9axX7/NN37Jdsb6p0VIWNXTgRoKlaPKwc1NgwQxVgOf0Yn15IvyCd6XTTYjOgvrMiLsFAgm3U+9AfrVjeKhWOXJWeY/o2ck3gi26IaNTD39KIdoj4h5iPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=YoNaGof7; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="YoNaGof7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791987497; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=rqJEEH0fViPcPhb2JZnsUi1FBDLYvCQ+qr5BoZ41opU=;
	b=YoNaGof7DsjeFTnGuNWlrjpnACmXsqykxj8kXL9Alze5ZftioatNVSfaaFU2XsZP282gelAGPqMS08U5tcJvTqpU1sRKRXh4DW/ZbIV1e/SyHkU7FmeB1nO/sd6Ktp7jcPssdLtVfRwCSonLFn7cdjhJemDsa76PvheC9v22CHE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07443063|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00855511-0.000224721-0.99122;FP=11048006070672494033|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jd7Rt-l_1791987495;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jd7Rt-l_1791987495 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:18:16 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 22:18:16 +0800
Subject: [PATCH] spi: tegra20-slink: bound copies to t->len
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-spi-tegra20-slink-copylen-v1-1-0ec779a6357e@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIACePz2oC/x3MQQqAIBBA0avErBtQC6OuEi3EphoKEyeiiO6et
 HyL/x8QSkwCXfFAopOF95ChywL84sJMyGM2GGWsVrpGiYwHzckZhbJxWNHv8d4oYG3Jemfs1FY
 N5D4mmvj63/3wvh8s5CbZawAAAA==
X-Change-ID: 20261014-spi-tegra20-slink-copylen-46e6ca26f937
To: ldewangan@nvidia.com, linux-spi@vger.kernel.org, broonie@kernel.org
Cc: thierry.reding@kernel.org, jonathanh@nvidia.com, 
 linux-kernel@vger.kernel.org, swarren@nvidia.com, 
 linux-tegra@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 stable@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

tegra_slink_calculate_curr_xfer_param() measures transfers in words of
DIV_ROUND_UP(bits_per_word, 8) bytes, while the SPI core only
guarantees t->len to be a multiple of
roundup_pow_of_two(DIV_ROUND_UP(bits_per_word, 8)). For word sizes
that are not a power of two (e.g. bits_per_word = 24, a 3-byte word)
the two differ, and the roundup in the non-packed path makes the
driver copy curr_dma_words * bytes_per_word bytes even when t->len is
not a multiple of bytes_per_word. A transfer submitted through the
spidev SPI_IOC_MESSAGE ioctl with bits_per_word = 24 and len = 8 then
copies 9 bytes, up to bytes_per_word-1 bytes past the end of the
core-allocated rx_buf, and reads past tx_buf.

Clamp the number of bytes consumed from tx_buf and produced into
rx_buf to the remaining transfer length in the FIFO and DMA copy
paths, so no access exceeds t->len.

Verified by arithmetic against spi_bpw_to_bytes(): with
bits_per_word = 24 the core accepts len = 8 and the driver's word
arithmetic yields 3 words of 3 bytes, 1 byte past t->len. No Tegra
SLINK hardware was available.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
Cc: stable@vger.kernel.org # 3.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-tegra20-slink.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1fcf57dd30..2d4568bbb959 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -315,6 +315,8 @@ static unsigned tegra_slink_fill_tx_fifo_from_client_txbuf(
 		max_n_32bit = min(tspi->curr_dma_words,  tx_empty_count);
 		written_words = max_n_32bit;
 		nbytes = written_words * tspi->bytes_per_word;
+		if (nbytes > t->len - tspi->cur_tx_pos)
+			nbytes = t->len - tspi->cur_tx_pos;
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
 			for (i = 0; nbytes && (i < tspi->bytes_per_word);
@@ -349,9 +351,12 @@ static unsigned int tegra_slink_read_rx_fifo_to_client_rxbuf(
 		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 		read_words += tspi->curr_dma_words;
 	} else {
+		unsigned int remain = t->len - tspi->cur_rx_pos;
+
 		for (count = 0; count < rx_full_count; count++) {
 			u32 x = tegra_slink_readl(tspi, SLINK_RX_FIFO);
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; (i < tspi->bytes_per_word) && remain;
+							i++, remain--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
 		tspi->cur_rx_pos += rx_full_count * tspi->bytes_per_word;
@@ -375,6 +380,10 @@ static void tegra_slink_copy_client_txbuf_to_spi_txbuf(
 		unsigned int count;
 		u8 *tx_buf = (u8 *)t->tx_buf + tspi->cur_tx_pos;
 		unsigned consume = tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned int remain = t->len - tspi->cur_tx_pos;
+
+		if (consume > remain)
+			consume = remain;
 
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = 0;
@@ -408,10 +417,12 @@ static void tegra_slink_copy_spi_rxbuf_to_client_rxbuf(
 		unsigned int count;
 		unsigned char *rx_buf = t->rx_buf + tspi->cur_rx_pos;
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		unsigned int remain = t->len - tspi->cur_rx_pos;
 
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = tspi->rx_dma_buf[count] & rx_mask;
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; (i < tspi->bytes_per_word) && remain;
+							i++, remain--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
 	}

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-spi-tegra20-slink-copylen-46e6ca26f937

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

