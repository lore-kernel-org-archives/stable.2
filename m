Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047910;
	b=3btqrMu5WLk8sa/6f9ViuYwX/oCruI35R2/I4iubCULCRcMIOnLIsBo/AThTYa59aM0U
	 dxhRhD5wqUBeY+YTHVyJc7w54Tul/gj96SnN84nhVFJvCI1lHE/MCI6N9qIfLzdTT4JlK
	 HTopVDoesOUwgZLhfS7CMr/90CVGQls4EJjVOf+sCA0uYbFPKa2nvWfG6a53/oTcD6wMM
	 2y9zmn7FSFaleJQ1flFCztlrUiQsIi1JLILsmTcJP9MCX6TepAVW+e/+w0nlOpJHNpwHJ
	 a7iW/ELT+UaTfWJn+556SfSqwPhzYPKfNw1zW2NUTAsdt/LQVA/Hs+fqQSipCkTKj1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047910;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nWvHdSpTTx/WD7cNoIN5ouHTppWC4RlCr4gVkUUC3Uw=;
	b=jGA8/hHOMYmZHFYMvOcp5p253qso0xDOd/ack4480Bh0Qqt688bYoEv78SWuDbj0JS5F
	 qQa1xbz6cSB2RFSXDzg5qfYUuK2aS4Y2OLy2kvBJkou0HZLj+c/DV+LqRzcc1beMtXrCZ
	 4piNddZiUEiUDiDhWGiptODl6CRv9YclASsHIQr2b2gfLNDGqtZfiM6v9ESw1i5VlcoXR
	 ppTchrIlVA2PNCPbAlJmMUN/HSopLlSEI6h+Z1CBlutDobZcMnJNkKS/Xdq2LulNBkozL
	 k4XsNbCclX1H5LrGIIrQeHfHgypxyox2LAtFXkpcqGC8eJYctmSUqBr1yRNZvK+mjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0oG4sog;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA77606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0oG4sog
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DB41F0089F;
	Sat,  7 Nov 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047909;
	bh=nWvHdSpTTx/WD7cNoIN5ouHTppWC4RlCr4gVkUUC3Uw=;
	h=From:To:Cc:Subject:Date;
	b=o0oG4sogMf7i6va8B8UffEKQHTB5KuKGiYSSH0OgXUk6aa2AvotE0l7p+5/pN/uBE
	 TZrFMJHhSGAl/FwAoKM9Py4s1Nfq65vVVyTg/Fb4hQWtCoNYfACoWBk6o4VZumX3Fh
	 VUFeJefoxs0NIThD313zUT9/dkNXrbemmp8mUk9I+iXg4U9NaLgM7PF9EGJoNv4yIk
	 oWDQ6pf/4G6V5greazxTrIdTxsxdr97FrrazTdR8a3A26BWku33+pl3vvpy7l3o2B7
	 QgfHEaeYR5YGOJTsAVQy3Ri//QijQ1VThnSVCMBBVrbR0SljrEztZUGAEnUBxkXTYb
	 0aHRnCnVWOrjA==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	bvanassche@acm.org,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:27 -0500
Message-ID: <20261107053827-failed-6.6-22d14117ec18@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 22d14117ec1845a81acb3a5c4be325f7e8332f70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053827-failed-6.6-22d14117ec18@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22d14117ec1845a81acb3a5c4be325f7e8332f70 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 22 Oct 2026 11:44:39 +0800
Subject: [PATCH] scsi: ufs: core: Add a helper for clearing
 hba->outstanding_reqs

ufshcd_poll() and ufshcd_abort() each have their own copy of the code that
clears bits in hba->outstanding_reqs under hba->outstanding_lock.

Move that code into ufshcd_clear_outstanding_reqs() and its locked variant
__ufshcd_clear_outstanding_reqs(), and use them in both functions. No
functional change.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/3779e125-9acc-42c8-9489-51b9e3c6716d@acm.org
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261022034443.3034432-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f03a8d39fb7a8..f2e3b782f1fe8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5997,6 +5997,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
 	}
 }
 
+/*
+ * Return a bitmask of the transfer requests cleared from
+ * @hba->outstanding_reqs.
+ */
+static unsigned long __ufshcd_clear_outstanding_reqs(struct ufs_hba *hba,
+						     unsigned long mask,
+						     bool from_irq)
+	__must_hold(&hba->outstanding_lock)
+{
+	unsigned long completed_reqs = mask & hba->outstanding_reqs;
+
+	if (from_irq) {
+		/* Do not complete polled requests from interrupt context. */
+		ufshcd_clear_polled(hba, &completed_reqs);
+	}
+	hba->outstanding_reqs &= ~completed_reqs;
+
+	return completed_reqs;
+}
+
+/*
+ * Return a bitmask of the transfer requests cleared from
+ * @hba->outstanding_reqs.
+ */
+static unsigned long ufshcd_clear_outstanding_reqs(struct ufs_hba *hba,
+						   unsigned long mask)
+{
+	guard(spinlock_irqsave)(&hba->outstanding_lock);
+	return __ufshcd_clear_outstanding_reqs(hba, mask, false);
+}
+
 /*
  * Return: > 0 if one or more commands have been completed or 0 if no
  * requests have been completed.
@@ -6007,6 +6038,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
+	bool from_irq;
 
 	if (hba->mcq_enabled) {
 		hwq = &hba->uhq[queue_num];
@@ -6016,12 +6048,9 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
-		/* Do not complete polled requests from interrupt context. */
-		ufshcd_clear_polled(hba, &completed_reqs);
-	}
-	hba->outstanding_reqs &= ~completed_reqs;
+	from_irq = queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT;
+	completed_reqs = __ufshcd_clear_outstanding_reqs(hba, ~tr_doorbell,
+							 from_irq);
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 
 	if (completed_reqs)
@@ -8056,7 +8085,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = scsi_cmd_priv(cmd);
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	ufshcd_hold(hba);
@@ -8151,11 +8179,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-	if (outstanding)
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
 		ufshcd_release_scsi_cmd(hba, cmd);
 
 	err = SUCCESS;
-- 
2.53.0




