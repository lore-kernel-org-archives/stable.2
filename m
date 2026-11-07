Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050651;
	b=cg2LhG7UJV6h2rPl/+l+TsbfxUw+EmykooO7dpmPNDMicAqnOTYkqjc0l+jYwPxCfOoR
	 oAZnTgXVGCF9j1g+sK+78E8oIHAZgsN+feTb2vwvcNhWe6/m1i9FTX2q58z2BWBdsG8Cs
	 qMMGfhRjG6scvRUtYoV2nPlhHlystxKpER5M4uuw2CgOEmV0C0Zkk9I+pP1fatFxhy0Bc
	 P0tMu9t3jouEei3MCOgnfqULN3+PRCOW/SW5qj9kfuH0b+ozBNtlKNdWf5RWljsl3cYWc
	 Wpqj5Kx6Hqd6F0SoS+MAQ1J4JsVyEmd8XMGrPy3CFl2Swh44Au1Jp0Os0QF55Y4pqvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050651;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F1qN3DA0OMnsd2DLH8GmV6UiOtfjbmivi0UCouHra/M=;
	b=YEZbqgbYLEaj4BFhbm5VyicY/X6yCZBYvObpOIscmnl6fvNMh/sRHrphHYiGJ9m4k5iu
	 rM5VxPie2xt1xtA6Yg1nHo5WedU4GpLNe4GnLWv8TxUsUE4EDdroYr8auDeG+OsfEs76H
	 GwAR09qHUUUH/hu+0+uDlrllxOPZTShaZt0R2I2h3bHilbPDjI7IGkOBqJhf9LfaUmDux
	 CkwzYVBkNxCWsoYyzR/jmdiSJMSGui2JU+RN6b3FEPJdCL2eshR4Ee7xXR881IwSwA0x9
	 XiIhgB8B6QiNJQ2KI/Jo/GYES0LvmdOCM2JLx8WWu+cytRQq8s1RSS8R03+D4psFumQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxxpC4cf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31532606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxxpC4cf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B571F0089F;
	Sat,  7 Nov 2026 11:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050650;
	bh=F1qN3DA0OMnsd2DLH8GmV6UiOtfjbmivi0UCouHra/M=;
	h=From:To:Cc:Subject:Date;
	b=OxxpC4cfHyRC4wRTEvGAdNlJdtUNgi+TXP0DraaLbl/VGZTZ0BHakbD9WLsMO+4YV
	 r4/JVF7cacthhogDxXX6slsSCwKgVKjeoF6PWhcwdGlVE9J2reNUPjBlaIWu/xlgvs
	 YYwUIhGpgyTVvV9Gwfv4fQxkVVlR5MTXvDJtWP+1T9KWJ/W3yY5/4F+3JOTNF05byg
	 suLQSWxSB5Au+XCGbD1QIt0NBpuyMNp+6K5iwgzuICc5av3M3v3dRn8v6iNjGRrbnz
	 gP47nH9JV4Pru9S18a23CCUWemFypvcpeyCUkw7QX8bF0uyXvOVe0JOMVTX4DL8W88
	 x5J6PsC5Gw8ww==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: amd: fix len==0 underflow and FIFO overflow" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:09 -0500
Message-ID: <20261107062408-failed-5.10-e2f4edfc061e@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e2f4edfc061e493fddde16c4bbe1c4f230f41e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062408-failed-5.10-e2f4edfc061e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e2f4edfc061e493fddde16c4bbe1c4f230f41e4a Mon Sep 17 00:00:00 2001
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 20:39:13 +0800
Subject: [PATCH] spi: amd: fix len==0 underflow and FIFO overflow

amd_spi_fifo_xfer() unconditionally decrements xfer->len when a tx_buf
is present. The SPI core does not reject zero-length transfers, so a
transfer submitted through the SPI_IOC_MESSAGE ioctl with len == 0 and
a tx_buf makes the u32 len wrap to 0xFFFFFFFF, and the following
per-byte loop writes far past the FIFO window.

The driver also never checks the cumulative FIFO offset against
AMD_SPI_FIFO_SIZE. The core splits each transfer down to the
controller's max transfer size but does not bound the total message
length, so a message of several transfers whose total exceeds the FIFO
overflows it with out-of-bounds MMIO writes (tx) and reads (rx).

Skip zero-length transfers and reject any transfer that would run past
the end of the FIFO window.

Tested with a user-space replica of the fifo_xfer length arithmetic
(ASAN build): a zero-length transfer with tx_buf makes len-- wrap to
0xffffffff, and skipping zero-length transfers avoids the wrap. No AMD
SPI hardware was available, so the FIFO bound check was verified by
inspection against AMD_SPI_FIFO_SIZE.

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Cc: stable@vger.kernel.org # 5.8+
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 71a6e5c475b03..ddf89e5353c55 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -322,11 +322,22 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
+		/* Skip zero-length transfers to avoid len underflow below */
+		if (!xfer->len)
+			continue;
+
 		if (xfer->speed_hz)
 			amd_set_spi_freq(amd_spi, xfer->speed_hz);
 		else
 			amd_set_spi_freq(amd_spi, spi->max_speed_hz);
 
+		/* Reject transfers that would overflow the FIFO window */
+		if (fifo_pos + xfer->len >
+		    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
+			message->status = -EMSGSIZE;
+			goto fin_msg;
+		}
+
 		if (xfer->tx_buf) {
 			buf = (u8 *)xfer->tx_buf;
 			if (!tx_len) {
@@ -369,6 +380,12 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list)
 			if (xfer->rx_buf) {
+				/* Reject transfers that would overflow the FIFO window */
+				if (fifo_pos + xfer->len >
+				    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
+					message->status = -EMSGSIZE;
+					goto fin_msg;
+				}
 				buf = (u8 *)xfer->rx_buf;
 				/* Read data from FIFO to receive buffer */
 				for (i = 0; i < xfer->len; i++)
-- 
2.53.0




