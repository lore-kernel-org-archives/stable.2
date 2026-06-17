Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47213FEE
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660843; cv=none; b=sCGmkLNgMpfQjbqLAsLLLXb054CPNEDcAAcAZk/lPljdwwkpJsxunep9o1l25hWwJHENbQnqumjLc4mDg3HX5J95OJUctA3FngNAHoLUE+2gWQUHhAIJFdz9/+ZjuvM9Th9fOsl7BXm6m2WYK7Y0yBKdkjP5uhYtw5pzYHgCI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660843; c=relaxed/simple;
	bh=kTtGBZ6G/4e+tdgizYjk6mT0Da4ru19EKlz1zkEXstc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q95Ft/QJqCVaekUvQ0aJemqNv64g6cVReueDT/RQmroTGC+tUWynck7SDaFQ6aQOegCEc2kZBEhYME98czNphlVe/jwacyyZakBelYoBKz8/QLIbVH+bRsrXGoeGUDqDU50lLiLgVnMRFN06JLJjBloIsmJWecbNSKHLa/jbv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kINFI/Ud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kINFI/Ud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883071F000E9;
	Wed, 17 Jun 2026 01:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781660842;
	bh=qOCL0H6seGVLnjrf63MQMBRezF/V9x0Seopk4bh3y8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kINFI/UdeBSffEh6kzNEnWgjFbihEwmHsDRdDLmwcIcSzrKwgTSPriPNHpXcWKD4K
	 5W6u9kkYlu8a86AdAQ5Sz0tbMSL8zA7ADaNqmBpYhZrsOAkGnmBDBsxff0HcAumR7h
	 vJrW6vJTP+ULf4jQv+nrfWSJ11EeyGCZuBe8P7rxmxySEUMFHPCdDHAkJBb4vaJhWv
	 jICit4A2dvyfkcvvWpwOjzLaSDYmoIhRD3Ho2x3PUJBQLI2HzAUr5bAxiVQXtxkhv3
	 VH4RJrpjYDMDjqbzG0UW9IkDDOgpLXuHg1Oh5HFHg3Whz9XgfICj5Yo2gPMX3XXQFa
	 RHqhSnJy3OpZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] firmware: samsung: acpm: Fix cross-thread RX length corruption
Date: Tue, 16 Jun 2026 21:47:19 -0400
Message-ID: <20260617014719.3671631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061526-attention-sedative-060d@gregkh>
References: <2026061526-attention-sedative-060d@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 6572cd7be9d177..769858c535eaa6 100644
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
 				__ioread32_copy(xfer->rxd, addr,
 						xfer->rxlen / 4);
@@ -267,7 +267,7 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 				 * after the response is copied to the request.
 				 */
 				__ioread32_copy(rx_data->cmd, addr,
-						xfer->rxlen / 4);
+						rx_data->rxcnt);
 			}
 		} else {
 			clear_bit(seqnum, achan->bitmap_seqnum);
@@ -379,8 +379,8 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
-	if (xfer->rxd)
-		rx_data->response = true;
+	/* zero means no response expected */
+	rx_data->rxcnt = xfer->rxlen / 4;
 
 	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
 	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);
-- 
2.53.0

