Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851A4418CA
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706463; cv=none; b=QPKQwBafISobdrEaeL9UDNIwOzHmguFDT8xMyYEBdKU9fPIxAssBN2+UQ0ds6OIkGEPHsKAJ3i5qW8tiDTx1eve8v9vpV093t1EUb/C3PM0lWRGxaQ5OQb9+XTDyM8s7pyIWnYlkQOsjTDsCgKjF6RuLsGnrpKZUS7asmB0W57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706463; c=relaxed/simple;
	bh=bqLx3nX28SL2qHf/gezFKamBv6QZbKZDaue2le2/l3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNyQaeZUbDZhlrfVAVt7x4NyVkfe0U/QvM+vh9VfCwmrm+m7xajWqxB4STgkGXEbDz8otbzQcvtFQ9tc93/1Z5vC7xaAcAoxYjACUKZI2evANlpXC1VAXtZZT72AHtO1f5/1dZzEQjVq71XRwYeh49w/BKxD4sd+zsyy10c9K08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULBKAKXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULBKAKXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A8B1F000E9;
	Wed, 17 Jun 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706461;
	bh=zxLMJu/C5IB7taIxgRB94E1ZyljoImqsyFauFYsCuNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULBKAKXfR12lruFJMEFve4yxL3PhvL6PWKVaYiRRVS6a8OsBp6eHrHcnTwOzU+MjE
	 MBxcZ1Wv+I4YsTvAUdLftOTTjxfPW+PX9/X43FkuzeTNqOQeFNTtEhjkD3FHXpzsSm
	 QIAmYIE0Ew1YXOjzsfwHz9ceGDLFQrVDaxcdvM04vKAckoDhih9DWfwdXVvF1Ipho9
	 mcCnIFGCpQQx9INRJ/P65IxbZT9eogeYNcfhkUA1yXkhP/BgUgMojo4EYIOlgTeUNv
	 KOth4zkZ4d88j+S2OOy7tIjsTr8ZAfgh3/9Cr0kBvwXuhDXrluGEBNO4b9on81Rkzd
	 mCNXeqIxD4Fzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/5] firmware: exynos-acpm: Count number of commands in acpm_xfer
Date: Wed, 17 Jun 2026 10:27:35 -0400
Message-ID: <20260617142739.3938338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061551-lung-clutter-0849@gregkh>
References: <2026061551-lung-clutter-0849@gregkh>
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
Stable-dep-of: bf296f83a3dd ("firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c |  9 +++++----
 drivers/firmware/samsung/exynos-acpm-pmic.c | 14 +++++++-------
 drivers/firmware/samsung/exynos-acpm.c      | 14 +++++++-------
 drivers/firmware/samsung/exynos-acpm.h      |  4 ++--
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 66448c8037aca6..352a6e64d79ddc 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -5,6 +5,7 @@
  * Copyright 2025 Linaro Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/ktime.h>
@@ -25,11 +26,11 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 {
 	xfer->acpm_chan_id = acpm_chan_id;
 	xfer->txd = cmd;
-	xfer->txlen = cmdlen;
+	xfer->txcnt = cmdlen;
 
 	if (response) {
 		xfer->rxd = cmd;
-		xfer->rxlen = cmdlen;
+		xfer->rxcnt = cmdlen;
 	}
 }
 
@@ -50,7 +51,7 @@ int acpm_dvfs_set_rate(struct acpm_handle *handle,
 	u32 cmd[4];
 
 	acpm_dvfs_init_set_rate_cmd(cmd, clk_id, rate);
-	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, false);
+	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, false);
 
 	return acpm_do_xfer(handle, &xfer);
 }
@@ -70,7 +71,7 @@ unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 	int ret;
 
 	acpm_dvfs_init_get_rate_cmd(cmd, clk_id);
-	acpm_dvfs_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id, true);
+	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
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
index 987b59778ffc4a..16c46ed6083716 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -205,7 +205,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
 
 	if (rx_seqnum == tx_seqnum) {
-		memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
+		memcpy(xfer->rxd, rx_data->cmd, xfer->rxcnt * sizeof(*xfer->rxd));
 		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
 	}
 }
@@ -258,8 +258,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 
 		if (rx_data->response) {
 			if (rx_seqnum == tx_seqnum) {
-				__ioread32_copy(xfer->rxd, addr,
-						xfer->rxlen / 4);
+				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
 				clear_bit(seqnum, achan->bitmap_seqnum);
 			} else {
@@ -269,8 +268,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * clear yet the bitmap. It will be cleared
 				 * after the response is copied to the request.
 				 */
-				__ioread32_copy(rx_data->cmd, addr,
-						xfer->rxlen / 4);
+				__ioread32_copy(rx_data->cmd, addr, xfer->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -425,7 +423,9 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 	achan = &acpm->chans[xfer->acpm_chan_id];
 
-	if (!xfer->txd || xfer->txlen > achan->mlen || xfer->rxlen > achan->mlen)
+	if (!xfer->txd ||
+	    (xfer->txcnt * sizeof(*xfer->txd) > achan->mlen) ||
+	    (xfer->rxcnt * sizeof(*xfer->rxd) > achan->mlen))
 		return -EINVAL;
 
 	if (!achan->poll_completion) {
@@ -448,7 +448,7 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
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

