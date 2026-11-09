Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193595;
	b=CJFALtYMqyPmDtF7diGAfrLDCvr7tyhxA7GeNvflS6JG/pnKhC1M4hB1CyyVLHeywFyq
	 2wGomVEKeyIE4Hky/kbfTv6bYAd7saVmvbqPw/A3Uc8fhrbx3gkDcWVNeGn1FGsiwVBWo
	 JqIujKu4qNvMA1Sn7d6Q2p/MDfT8gUgDTfvndQMs457nw7F8TWoZkMQKvFp4XlQgDWh6g
	 WZSg5OEg+HT9pXP8eoW8KbDvOrO0yRiHV4YnaEO0Lt+a8GjiVVXanTVk47f6r/zoTNNxL
	 0auNKcvi8KxeeZU4aC/dOAb5IL/z55t4U3U3ZHulMyXdHDk3wLfsB370c3ZcuTSM2wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193595;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u1RzFQWPYGD8QWAuXnKu8F/lwTVjaC0hQdzf1z/TQEM=;
	b=CBwKk9y5z3Ao0pQJT/iXQVW9ejj2Mt6azyJ27kJy0k695h03vG+qXE7Cjxxg5HFAcuiy
	 sDCAJluIR9jt9oZfN6FacG9AyuBdsURrcyBXIMr8SfL2zLzmitHxD+X0zCqKxTpVoN+Wj
	 ZBmhS+6qldpoDr1VVJQp2POPxWpJ202NtbCUWDBZnCHwQJMCr3OqaYVzY/uxh766BDOun
	 rF80ZNr8wceLpEnUtD/UtIvsCPtPrpyqrptJQvRJvMuXRf5O7EBDvERd1TqvkaB9zQ3af
	 8Vp7+XXtK8VGXL5M1K5EeplAbckLRABGNpjJpNIvXUNFVEp4tD9WEj5nlAz86Gpm3GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a0p0HDSb;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBA606A320
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 03:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FCBA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a0p0HDSb
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794193585; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u1RzFQWPYGD8QWAuXnKu8F/lwTVjaC0hQdzf1z/TQEM=;
	b=a0p0HDSbX3JAEPLvk/6ppH/qUTOt+9EFw5BkDKc+O5krPqBvxjibC8355peeYrKR1Q0vAO1N39iOODRi4XE0A0THMcyPj7cvyxAb/fDdPCCBJiMpcEXo0PYnt5PV0xTHykFrvnDBuV6DpFT8RDY3AAQ4fmq6Keto7f0471Njmak=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436962|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0132805-0.00344454-0.983275;FP=11191983353786942674|1|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jzgkbDC_1794193585;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jzgkbDC_1794193585 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 11:06:25 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: stable@vger.kernel.org
Cc: liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10.y] spi: amd: fix len==0 underflow and FIFO overflow
Date: Mon,  9 Nov 2026 11:06:24 +0800
Message-ID: <20261109030624.419576-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107062408-failed-5.10-e2f4edfc061e@kernel.org>
References: <20261107062408-failed-5.10-e2f4edfc061e@kernel.org>
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
[ Adapted for 5.10.y: this tree has no per-message FIFO position tracking, so the check is a per-transfer bound against AMD_SPI_FIFO_SIZE, matching the per-byte loop offsets here. ]
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-amd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index a027cfd..f5433b7 100644
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

