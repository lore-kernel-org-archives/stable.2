Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049632;
	b=S+QL5LR1U9UrbtZEnpAYEptHfRWDMwdfZq9la5V+k5eYo8FYzqeTNRqzK7mBGiqLVjNh
	 IDYqS1DF6exDJR7kGs2w6//9LytG1TxteSMzmEt6XC0VNQXT7zhB39V1rpBooy4zqtd23
	 ZkgTLmaW5ktLiflLD2R1NNPUwHBByXnqHvNHK/BNip438bJwpgdeT+K1bn0TjFbu3q3bQ
	 WzEA0hLBiRYvpF5G3wdRCYcY4dqT5zYC4ZnVUf0w/4X0DqTLJ1GmLpAYDDmGPyOU4LMud
	 UIRuC+F2VkmJM/kRLz0NPbCYBIssC7T9cuodDCmVvuSXw180RK40uNZ4wSq94sP510Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bhSyuUoS+H3oulBqno/0+m9J9qppNfz4Q9KYk+a02b8=;
	b=NXQtEtZdyLID3bR+SOkvvGj1it+aSf8S3eJCH8pOd9BYu2MwOSIVmsiTEax7Bnck18EP
	 /oEV7ozPaF9EqELNLWC0ugLUG8hI6GOU2cAXs04NFHOlj3BrGSJzlrdvtqcFV3Ux3kgh5
	 9Zfei5VhpzDSBUIPvCh8c5TQEcp8x+/8WvInmJ/TJCs3TrlLNvCIt/5gZX4FSna012R1X
	 XR9/VbUCkiV94tcKl1F863J1f1Pg6HkatDQQ0N3o8d454gL7quB9ho0c+bksuEXMbIGvI
	 32w713j2+gj5qb+IHfAzqySVZPNV17JkGLEBsiO9K/3CMm0kh8tvqnjSBTDdh7ps51w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oyz+j2ON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44782606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oyz+j2ON
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DB31F0089F;
	Sat,  7 Nov 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049632;
	bh=bhSyuUoS+H3oulBqno/0+m9J9qppNfz4Q9KYk+a02b8=;
	h=From:To:Cc:Subject:Date;
	b=Oyz+j2ONDFM3Hlulg6//R6Md3+DcDYni00hDafl3IrcnmX97JAh+G0Zalfbu4Nl2M
	 VjphEFlNcstRPfrmfXMUGPtIg7rNZ0CWAP5PzXVo/phFrXQv9CxJqQ3im64Q/wTQ7Z
	 fRlErpvZY9NjK3BYM2W+xezPoyGjPkElNZ+pqFjek6iSqIvwI20ARRa/nGnRBL8Bgp
	 iWklnsFVec/NEULshW2j4OrWxQjnlzNJ2TZrJyGMgdW8huhPFR5fT3J3zCmiQzG+JK
	 3DXWVt7yZepiCKFkYbgFrawVYbKRs54fFFydDOdjCH44Sw6tUm+wehAi2TMQOx0SVH
	 58TSs/FkOKYZw==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: amd: fix len==0 underflow and FIFO overflow" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:10 -0500
Message-ID: <20261107060710-failed-5.15-e2f4edfc061e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e2f4edfc061e493fddde16c4bbe1c4f230f41e4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060710-failed-5.15-e2f4edfc061e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




