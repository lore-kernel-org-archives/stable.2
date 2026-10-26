Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020912;
	b=dH5avFpAAqOpJnMGBF34RVdubyXP4kMq7p3DJpVh9TUdmS19szkDeu8JXDzD+xVydDkK
	 ISxegRP1NuzJ1H+5CaFslNKwbBsW5nWCm37yzbHneze21Yp8BRWMeBf1TO09N5vaLcueo
	 HAbFMB/0GfZwLnsLOQBhw4ew5ItU4Hdj2Jhu0N/rlsNahQ82a+AdB208CuSeiewQH+scy
	 OFFW83WcxZVuToBASyzmbvDSpJbp6rJo6SfdEupDRxpOwJSM/U/YGRqk3EK+1IWMoRv2K
	 vyv/fhlweuNL5mxcOfDLLUCK4N74v2AHzVIZXu3rNeM3Wg/ytk/XvDiEWfpaCyzTPSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020912;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JudSgXLcJ6+6LonVY2e4IdR3mh1sh7zUR10EIzFcThs=;
	b=DXUmuh1QDcRM6uKU3MCcullUXRcjZ1gh/Ji2HMIQD55uDFtH3NdPK/LjZ8WIE3D5DOTl
	 4aI6o4tVflzaTSScARJvTiZzybFrHe7XFWqE7MPVyf69JSqhG8sNxRKmIpnd1rGdjMsoN
	 ZC6PiCPkj8gdZlkNv8+zdWYGPyI2Km3XpN3JDlmn6T60nWu6dlWDAfxKRl1T/jlEj+iJR
	 kDqX2pWwRbm7lanqCbh79H71uG5f/l+AR+XEr0GJC0IcSMEBRLmJEC1QB/QrTtnZix9Op
	 3xvwKYcvSx+G6JZVEobFywIAidaW/pXVmZ41geIX+YNSRXQDV3fiTDpHyIAC5HlKycg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rL+LFenj;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E34606A31A;
	Mon, 26 Oct 2026 13:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rL+LFenj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793020908; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JudSgXLcJ6+6LonVY2e4IdR3mh1sh7zUR10EIzFcThs=;
	b=rL+LFenjxlNw1X3GFOWGZxAoSvxuru+takJI9cskKx8/X2T0k53vz4GmYYui65+faJ7y6OHl0Ra0krnrismulhA2YQ+f+ePHFzTrTgLqSHWjb56dRC912dwLT6js3jOpSsVNX3Moqq44dxmowGTJigBiC4VkUkBB6/zcx5QqwVU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07575639|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00077706-5.23839e-05-0.999171;FP=14943764304330181682|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jpwPFyQ_1793020906;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jpwPFyQ_1793020906 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 21:21:47 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: ldewangan@nvidia.com,
	linux-spi@vger.kernel.org,
	broonie@kernel.org
Cc: thierry.reding@kernel.org,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	swarren@nvidia.com,
	linux-tegra@vger.kernel.org,
	zhugl3@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: tegra20-slink: size words with spi_bpw_to_bytes()
Date: Mon, 26 Oct 2026 21:21:46 +0800
Message-ID: <20261026132146.3806906-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

tegra_slink_calculate_curr_xfer_param() derives bytes_per_word with
DIV_ROUND_UP(bits_per_word, 8), but the SPI core sizes words with
spi_bpw_to_bytes(), i.e. roundup_pow_of_two(BITS_TO_BYTES()), and
__spi_validate() only accepts lengths that are a multiple of that
power-of-two word size.  For bits_per_word of 17..24 the two differ
(3 vs 4 bytes): a length like 8 passes core validation yet is measured
as three 3-byte words, so the copy helpers touch one byte past the
buffer, and cur_tx_pos/cur_rx_pos advance in multiples of 3 and never
land on the equality check cur_pos == t->len.  The ISR then recomputes
remain_len = t->len - cur_pos, which wraps, and the driver keeps
copying 4096-word blocks past the client buffers until the transfer
times out.

Use spi_bpw_to_bytes() for bytes_per_word: 24 bit words can have
padding.  The word count then divides the transfer length exactly, the
copies stay within t->len, the position counters land on t->len, and
the wire carries the words the caller asked for.  For power-of-two
word sizes spi_bpw_to_bytes() returns the same value as
DIV_ROUND_UP(), so only bits_per_word of 17..24 change behaviour.  The
non-packed setup already used the 4-byte configuration
(SLINK_PACK_SIZE_32) that bits_per_word = 32 has always used, TX
padding stays in the upper byte that the hardware does not shift out,
and the RX paths already mask the padding.

Verified with a userspace replica of the transfer arithmetic covering
all core-legal lengths for bits_per_word 8/16/24/32 in both
directions: the shipped driver and v1 overrun the buffers and never
complete for bits_per_word of 17..24 with lengths not divisible by 3,
while with this change no copy exceeds t->len and every transfer
completes.  Compile-tested only; no Tegra SLINK hardware was
available.

Suggested-by: Mark Brown <broonie@kernel.org>
Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
Cc: stable@vger.kernel.org # 3.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v2:
- v1 clamped the four copy loops to t->len.  As Mark Brown pointed out,
  the compact word size itself is the problem: 24 bit words can have
  padding, so the core only guarantees lengths that are multiples of
  spi_bpw_to_bytes().  Size words with spi_bpw_to_bytes() instead,
  which also drops the clamps and lets the position counters land on
  the equality completion test.

 drivers/spi/spi-tegra20-slink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1fcf57dd30..3f507176b0c8 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -261,7 +261,7 @@ static unsigned tegra_slink_calculate_curr_xfer_param(
 	unsigned total_fifo_words;
 
 	bits_per_word = t->bits_per_word;
-	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
+	tspi->bytes_per_word = spi_bpw_to_bytes(bits_per_word);
 
 	if (bits_per_word == 8 || bits_per_word == 16) {
 		tspi->is_packed = true;
-- 
2.50.1
