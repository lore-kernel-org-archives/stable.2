Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481293DF01C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559728; cv=none; b=hMHXW/HPt7lxLxghfeUz8Lg01NGAO4VmL+qaVlYs5KNfq0gjQ3yd8JPtRTFKY8575Jqczwf0wttvrtcYI6mdhjqJC5YCkdEuRBVRsNmhnRnRuoIvbRfvCzINSNJAKBZsuM5EFS4omVt03g91dSU3fdGIhbwxF/CZuxAWpM09vi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559728; c=relaxed/simple;
	bh=GmxDb/FqWbG4mcZMjZcnQbfYzaqNqIOfeEO9EQqrqWA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HLB1HN8f7W3dqFt0Dr5L81vhP9dzb0p4WwKIm4KthWCP7smZTQnKypt2uBSQs0PDe1CKdLuIznShL4ISAeT1o3Dl4J/s2fwkHlwsSJkYpSeR8rlpnptSqwa0dF7bvLkdaqAa7Tc6FAdP8Pcdoneye6+jmzKQFCBKzcQ0PV5tamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qzplJXvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzplJXvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D97A1F000E9;
	Mon, 20 Jul 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559727;
	bh=rVu3/BznTpoSTj9Jt8SrLmwdWnJbyZ2I7BuNPq1uXGA=;
	h=Subject:To:Cc:From:Date;
	b=qzplJXvqfZcSkSr5SwU88srdCG5wn2aTG/VLkz3ruMD2NZlvbmlVRFXEV/JKZPiFi
	 /D2z831qvUy9fSq3yqYFjDKJbaLycrQ/HOdCp5dcbdKRXPBYCRrCfKUDupJjdEEMns
	 VgUGmbdIS1HAW8WxzOix6aPAeXgXTWehvBKm+Qu0=
Subject: FAILED: patch "[PATCH] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and" failed to apply to 5.15-stable tree
To: Frank.Li@nxp.com,den@valinux.co.jp,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:01:58 +0200
Message-ID: <2026072058-move-penny-29fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8ffba0171c6bbce5f093c6dba5a02c0805b31203
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072058-move-penny-29fb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ffba0171c6bbce5f093c6dba5a02c0805b31203 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 21 May 2026 23:21:53 +0900
Subject: [PATCH] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and
 ABORT_INT_MASK

The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
channels, and modifying them requires a read-modify-write sequence.
Because this operation is not atomic, concurrent calls to
dw_edma_v0_core_start() can introduce race conditions if two channels
update these registers simultaneously.

Add a spinlock to serialize access to these registers and prevent race
conditions.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[den: update dw_edma.lock comment]
Link: https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Link: https://patch.msgid.link/20260521142153.2957432-5-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 902574b1ba86..6474cacf7195 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -109,7 +109,7 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..cfdd6463252e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));

