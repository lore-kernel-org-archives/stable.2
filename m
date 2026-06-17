Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0A31E822
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716866; cv=none; b=dSULXea0N46oPU/O9XpXa5qkBN2lkx5s62pJsYMFIRGkpSBU66ihGhw0XnrMEtVvfM0jTIwDpF4y0MJShJgAVhBhfLSB53wGjIosEDExpBW2bMKfGT6FSu6CWr+OBpYP78ays7QVYReiXjU8XxdlnSEMtkX3vDV4pi0Oj7nD16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716866; c=relaxed/simple;
	bh=vvX5lku+vTwQ912Ybo7Ytv3Kck5cmXeW97WC6CgF15o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwFiP9ssuSeyAPK0kywQD2OfevRoUMmwAosWcqQjhV6wr/d/QGhwpqHAvBS7dl5JMEUP/cVjjnJ+s2Dk6txh9Ss2KDDzCYb2Z6Iitgii3sHErPodtx62Xt1cvUe0T51X1MJT+9EWAQN02iVveL9W43TbkHXxo//TOc6qr+GwInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIwyCh2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIwyCh2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4A31F00AC4;
	Wed, 17 Jun 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716863;
	bh=sqGaxkJfTv4RDat0hxqIrX6NEfELP2J1nXm7dBxO4aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIwyCh2abuLEo2cnLb+f9psqRgLTGg0nOOje6PEZDFBYIuONqaubspVBksX2gMOzH
	 +w/caHd5cJZjFjyqSgHqXfWfTy8qaKqQd5LjB1QqjyMuZm+uCDRUR9c5sHcdYFVRGT
	 6OgeHQcjE05x5fCghf4EvMMIVgH/VZBMXnemgAbGAMzZYV7yB8NX2MwlSehQBZL85P
	 vczidO1vLXQ2IbNFqq6d6WhhKvrcerH8KgbXvZGSj3+to4bGyEX46VOBfWS2eo+Zdg
	 AIwlbGTRgELZDzCVHb/IDtsEEpljfYe8byBlKwk75Z26dYD1lT76hidDV4yuAF71wE
	 Rpd4EIydxILfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] firmware: samsung: acpm: Fix cross-thread RX length corruption
Date: Wed, 17 Jun 2026 13:20:56 -0400
Message-ID: <20260617172058.253463-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617172058.253463-1-sashal@kernel.org>
References: <2026061553-curly-gigahertz-3ad1@gregkh>
 <20260617172058.253463-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit f133bd4b5daf71bccdde0ad1a4f47fac76a6bfb1 ]

Sashiko identified a cross-thread RX length corruption bug when
reviewing the thermal addition to ACPM [1].

When multiple threads concurrently send IPC requests, the ACPM polling
mechanism can encounter responses belonging to other threads. To drain
the queue, the driver saves these concurrent responses into an internal
cache (`rx_data->cmd`) to be retrieved later by the owning thread.

Previously, the driver incorrectly used `xfer->rxcnt` (the expected
receive length of the *current* polling thread) when copying data for
*other* threads into this cache. If the threads expected responses of
different lengths, this resulted in buffer underflows (leading to reads
of uninitialized memory) or potential buffer overflows.

Fix this by replacing the boolean `response` flag in
`struct acpm_rx_data` with `rxcnt`, caching the exact expected receive
length for each specific transaction during transfer preparation. Use
this cached length when saving concurrent responses.

Consequently, ensure that `xfer->rxcnt` is explicitly zeroed in driver
helpers (e.g., `acpm_dvfs_set_xfer`) for fire-and-forget messages to
prevent uninitialized stack garbage from being interpreted as a massive
expected receive length.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Reported-by: Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
Closes: https://lore.kernel.org/r/20260426210255.73674-1-titouan.ameline@gmail.com/
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260505-acpm-fixes-sashiko-reports-v5-1-43b5ee7f1674@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Stable-dep-of: bf296f83a3dd ("firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 07bb4af1ca5845..742c0093250435 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -103,12 +103,12 @@ struct acpm_queue {
  *
  * @cmd:	pointer to where the data shall be saved.
  * @n_cmd:	number of 32-bit commands.
- * @response:	true if the client expects the RX data.
+ * @rxcnt:	expected length of the response in 32-bit words.
  */
 struct acpm_rx_data {
 	u32 *cmd;
 	size_t n_cmd;
-	bool response;
+	size_t rxcnt;
 };
 
 #define ACPM_SEQNUM_MAX    64
@@ -196,7 +196,7 @@ static void acpm_get_saved_rx(struct acpm_chan *achan,
 	const struct acpm_rx_data *rx_data = &achan->rx_data[tx_seqnum - 1];
 	u32 rx_seqnum;
 
-	if (!rx_data->response)
+	if (!rx_data->rxcnt)
 		return;
 
 	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
@@ -253,7 +253,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 		seqnum = rx_seqnum - 1;
 		rx_data = &achan->rx_data[seqnum];
 
-		if (rx_data->response) {
+		if (rx_data->rxcnt) {
 			if (rx_seqnum == tx_seqnum) {
 				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
 				rx_set = true;
@@ -265,7 +265,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * clear yet the bitmap. It will be cleared
 				 * after the response is copied to the request.
 				 */
-				__ioread32_copy(rx_data->cmd, addr, xfer->rxcnt);
+				__ioread32_copy(rx_data->cmd, addr,
+						rx_data->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -377,8 +378,8 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
-	if (xfer->rxd)
-		rx_data->response = true;
+	/* zero means no response expected */
+	rx_data->rxcnt = xfer->rxcnt;
 
 	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
 	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);
-- 
2.53.0

