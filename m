Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A044028CC
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536900; cv=none; b=cV0hqWwJsZXQTKkdG6YGANalgVQnK++X4cSarS4tkeSYjtA61fDDOSMzzOXM2rbsmqyV0tpWftwdfQjodTkO/J/rGZTx+KnCB2JtZFOzne8nZ7Zf9rOS0Sos+sw+DkKJCSwgJdtx0JPfxyioiImHqqdWsfNRXKDKAY1Z/h/HPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536900; c=relaxed/simple;
	bh=7+MpybiRpOVGHD7vxHccp3WYL8c2B8HWWwxCQ38h4U8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UZX6A+SS2A4DJqS4DRhZ6pWdhzUO0WyJA0KTOcjVLJa4+QzypGZ3T02pi0sqNk1iu/0lzizbgdgGO4WIHCqn45pkPMDSjlDBwsYUW5tLqmggvUP8nyuSGivU34depSNZpD8+dRCklbOPO8gNtyXb5fYbLstbBH0jJDRbXzHEfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wZcgeeU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZcgeeU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E71F000E9;
	Mon, 15 Jun 2026 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536899;
	bh=12tTEfzWcs1fI2qtmSkFc6lJycvqtbZ5N6Ctbda3rqs=;
	h=Subject:To:Cc:From:Date;
	b=wZcgeeU63cu58UHs5UVAKwYePMJr8OFOaCMIniJbpeO/n6NpGqNInM/9NxbgEdp5B
	 ipAsa0pykc3Q+Ld+lwFC5iSiX8JBq10z2FSGTuWVFQqGWgAWutqLj1LX/EhUDBPJJ3
	 E/Ot7AWCT/l0hrmfzkeTyl6sojcwsEb0sBos7md4=
Subject: FAILED: patch "[PATCH] firmware: samsung: acpm: Fix infinite loop on sequence number" failed to apply to 6.18-stable tree
To: tudor.ambarus@linaro.org,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:49:44 +0200
Message-ID: <2026061544-rinsing-fragrance-9ee5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7fe40c32a33905302341797b5d12c541729dd08d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061544-rinsing-fragrance-9ee5@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fe40c32a33905302341797b5d12c541729dd08d Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 5 May 2026 13:13:04 +0000
Subject: [PATCH] firmware: samsung: acpm: Fix infinite loop on sequence number
 exhaustion

Sashiko identified a possible infinite loop [1].

ACPM IPC sequence numbers are tracked via a 64-bit bitmap. Previously,
acpm_prepare_xfer() used a do...while loop to search for a free
sequence number.

If all 63 available sequence numbers are leaked due to transient
hardware timeouts or mailbox failures, the bitmap becomes full.
The next call to acpm_prepare_xfer() would enter an infinite loop.

Fix this by utilizing the kernel's optimized bitmap search functions
(find_next_zero_bit / find_first_zero_bit). If the pool is completely
exhausted, log the failure and return -EBUSY to allow the kernel to
fail gracefully instead of hanging.

Furthermore, drop the allocation loop entirely. Because
acpm_prepare_xfer() is strictly called under the 'tx_lock' mutex,
sequence number allocations are perfectly serialized. If
find_next_zero_bit() locates a free bit, a single
test_and_set_bit_lock() is mathematically guaranteed to succeed.

To enforce this locking invariant, wrap the allocation in a
WARN_ON_ONCE. If the atomic set fails, it indicates the driver's
mutex serialization is fundamentally broken. The warning generates a
stack trace for debugging, while returning -EIO immediately aborts the
transfer to prevent silent payload corruption.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260505-acpm-fixes-sashiko-reports-v5-7-43b5ee7f1674@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 3fa9fe283be4..19db3674a28f 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -12,6 +12,7 @@
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/find.h>
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -390,34 +391,48 @@ static int acpm_wait_for_queue_slots(struct acpm_chan *achan, u32 next_tx_front)
  * TX queue.
  * @achan:	ACPM channel info.
  * @xfer:	reference to the transfer being prepared.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static void acpm_prepare_xfer(struct acpm_chan *achan,
-			      const struct acpm_xfer *xfer)
+static int acpm_prepare_xfer(struct acpm_chan *achan,
+			     const struct acpm_xfer *xfer)
 {
 	struct acpm_rx_data *rx_data;
 	u32 *txd = (u32 *)xfer->txd;
+	unsigned long size = ACPM_SEQNUM_MAX - 1;
+	unsigned long bit = achan->seqnum;
+
+	bit = find_next_zero_bit(achan->bitmap_seqnum, size, bit);
+	if (bit >= size) {
+		bit = find_first_zero_bit(achan->bitmap_seqnum, size);
+		if (bit >= size) {
+			dev_err_ratelimited(achan->acpm->dev,
+					    "ACPM sequence number pool exhausted\n");
+			return -EBUSY;
+		}
+	}
 
 	/*
-	 * Prevent chan->seqnum from being re-used.
-	 * test_and_set_bit_lock() provides formal LKMM Acquire semantics.
-	 * It pairs with the RX thread's clear_bit_unlock() to ensure the CPU
-	 * does not speculatively execute the rx_data buffer wipe (memset)
-	 * before the sequence number is safely claimed.
+	 * Execute the atomic set to formally claim the bit and establish
+	 * LKMM Acquire semantics against the RX thread's clear_bit_unlock().
+	 * A loop is unnecessary because allocations are strictly serialized
+	 * by tx_lock.
 	 */
-	do {
-		if (++achan->seqnum == ACPM_SEQNUM_MAX)
-			achan->seqnum = 1;
-		/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
-	} while (test_and_set_bit_lock(achan->seqnum - 1, achan->bitmap_seqnum));
+	if (WARN_ON_ONCE(test_and_set_bit_lock(bit, achan->bitmap_seqnum)))
+		return -EIO;
 
+	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	achan->seqnum = bit + 1;
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
 	/* Clear data for upcoming responses */
-	rx_data = &achan->rx_data[achan->seqnum - 1];
+	rx_data = &achan->rx_data[bit];
 	rx_data->completed = false;
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
+
+	return 0;
 }
 
 /**
@@ -477,7 +492,9 @@ int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 		if (ret)
 			return ret;
 
-		acpm_prepare_xfer(achan, xfer);
+		ret = acpm_prepare_xfer(achan, xfer);
+		if (ret)
+			return ret;
 
 		/* Write TX command. */
 		__iowrite32_copy(achan->tx.base + achan->mlen * tx_front,

