Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81679239E7E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700402; cv=none; b=RqK/BMb9/Ps7f6f3HI4smOJ8gO2WV4U19yxUETzYzBuqmgKjBe5Gq45gMNXw7jyt6+dYHN0LjIqxHCykN9f2PVCQeH+siMx2QzmqFKipjNCAq+SSghzpPZdRev79ggONIgywcqKWtMR4IBFRGLsKbVwU0elNh6ERzbl5JXWlZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700402; c=relaxed/simple;
	bh=kbIO0rmlOt3152yIOy1V8ipWMvnwrMnvw5GIgp5oWQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyKamcNVtY+237ShLWkwSuDgbZmCOroW4H+2Mz0sCgVlyQaKP0wWRrK/zKiLXOTtSJF79+IJCHmizxC8I3+DUazDCcAGBJ4XIBdW43nqNny4XUHiiFpi7uFOq6ccn/64jpFE6OsjqME5+TlTPDCS3nnij6d49BS9deIt6WtFuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXQQObRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXQQObRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0AF1F000E9;
	Wed, 17 Jun 2026 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700401;
	bh=tURZ0Jx3f1OEWj2mIdE3A8rnCoI6JtRVfJLdP6NqxsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXQQObRAb0uQiCI00VR87S5wAK9Dv/MlHaeWtspEftEO29B9vMpywRUnYtayg8BSa
	 RQZhUyOIkyIdo6iaJdUlp6fzAohNiQfBcb3D6aPsPCCfrisQVO3yTZE29B5DZIM9tD
	 KaZyPcR495cgXG5H9ZFm1TFGc/8mYhn1vhqTKd8iGfbeEXlDSdIfIOa/6CK/qTohHu
	 vKkrnNP5rDAhgEgui7MqPL5K9wnz2WkY8pHoSfw7MZLMvf040RYjMeLbMElshEe9TP
	 f+XTASaIJpeYeRW2DSkbPRXcWyRqS5t2p2R5ForZ1Lgfeu+XghsIVdYYfSeQRCQUIf
	 cZGxtzZ9bhejg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] firmware: exynos-acpm: Count number of commands in acpm_xfer
Date: Wed, 17 Jun 2026 08:46:37 -0400
Message-ID: <20260617124639.3857566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061536-unchain-squabble-5291@gregkh>
References: <2026061536-unchain-squabble-5291@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 00808ae2e679a97dccc5cf0ee4474ba1e2e8a21a ]

Struct acpm_xfer holds two buffers with u32 commands - rxd and txd - and
counts their size by rxlen and txlen.  "len" suffix is here ambiguous,
so could mean length of the buffer or length of commands, and these are
not the same since each command is u32.  Rename these to rxcnt and
txcnt, and change their usage to count the number of commands in each
buffer.

This will have a benefit of allowing to use __counted_by_ptr later.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260219-firmare-acpm-counted-v2-2-e1f7389237d3@oss.qualcomm.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Stable-dep-of: c889b1464788 ("firmware: samsung: acpm: Fix false timeouts and Use-After-Free in polling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm-pmic.c | 14 +++++++-------
 drivers/firmware/samsung/exynos-acpm.c      | 14 +++++++-------
 drivers/firmware/samsung/exynos-acpm.h      |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 52e89d1b790f01..58edb3115d5fa3 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -63,8 +63,8 @@ static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 {
 	xfer->txd = cmd;
 	xfer->rxd = cmd;
-	xfer->txlen = cmdlen;
-	xfer->rxlen = cmdlen;
+	xfer->txcnt = cmdlen;
+	xfer->rxcnt = cmdlen;
 	xfer->acpm_chan_id = acpm_chan_id;
 }
 
@@ -86,7 +86,7 @@ int acpm_pmic_read_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_read_cmd(cmd, type, reg, chan);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -119,7 +119,7 @@ int acpm_pmic_bulk_read(struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_read_cmd(cmd, type, reg, chan, count);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -159,7 +159,7 @@ int acpm_pmic_write_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_write_cmd(cmd, type, reg, chan, value);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -199,7 +199,7 @@ int acpm_pmic_bulk_write(struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_write_cmd(cmd, type, reg, chan, count, buf);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -229,7 +229,7 @@ int acpm_pmic_update_reg(struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_update_cmd(cmd, type, reg, chan, value, mask);
-	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 6572cd7be9d177..07bb4af1ca5845 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -202,7 +202,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
 
 	if (rx_seqnum == tx_seqnum) {
-		memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
+		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
 		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
@@ -255,8 +255,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 
 		if (rx_data->response) {
 			if (rx_seqnum == tx_seqnum) {
-				__ioread32_copy(xfer->rxd, addr,
-						xfer->rxlen / 4);
+				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
 				clear_bit(seqnum, achan->bitmap_seqnum);
 			} else {
@@ -266,8 +265,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * clear yet the bitmap. It will be cleared
 				 * after the response is copied to the request.
 				 */
-				__ioread32_copy(rx_data->cmd, addr,
-						xfer->rxlen / 4);
+				__ioread32_copy(rx_data->cmd, addr, xfer->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -422,7 +420,9 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 	achan = &acpm->chans[xfer->acpm_chan_id];
 
-	if (!xfer->txd || xfer->txlen > achan->mlen || xfer->rxlen > achan->mlen)
+	if (!xfer->txd ||
+	    (xfer->txcnt * sizeof(*xfer->txd) > achan->mlen) ||
+	    (xfer->rxcnt * sizeof(*xfer->rxd) > achan->mlen))
 		return -EINVAL;
 
 	if (!achan->poll_completion) {
@@ -445,7 +445,7 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 		/* Write TX command. */
 		__iowrite32_copy(achan->tx.base + achan->mlen * tx_front,
-				 xfer->txd, xfer->txlen / 4);
+				 xfer->txd, xfer->txcnt);
 
 		/* Advance TX front. */
 		writel(idx, achan->tx.front);
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index 6417550f89aa97..ac634ef9c6780e 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -10,8 +10,8 @@
 struct acpm_xfer {
 	const u32 *txd;
 	u32 *rxd;
-	size_t txlen;
-	size_t rxlen;
+	size_t txcnt;
+	size_t rxcnt;
 	unsigned int acpm_chan_id;
 };
 
-- 
2.53.0

