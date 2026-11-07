Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050894;
	b=Xs8f/g4iKexO7uCxdnh+3l0+jxHBvIjZujSItPjAMaFRY22WxZ/UjxVtVFiBVwtbsV+B
	 Yyf7pNKl9cAzhTS0nSITnEejMmnyQ89GEWbp+p8f0Qdmw+QnIw70Fk4mw95uzg8Dx1hPo
	 MgoeiZXTFSLWrV7+19e/nXbuGGR19Qq8I8+7F8PsG9gpMznAh5SRZk8BkEG6t2a71rqgX
	 XFW9EHsFAChlSmVrNuCs6XXPmvWkGxfZJjnKzn7003CXXQlRSoVJxJAi6iHrtGRtIO9ML
	 kd5ew5nWQ1WuzFMOyrZHdGYwchEe4qIk5INN8v5cje52gTSoo22ZQQTNXzdwNh8fl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7XNFfLFVmv9aNjKgRAgonLrmiBNEDBZ3plr2ao52a3w=;
	b=oHtdZMLoht/boQ1OnIXTJRbjRGMJqOKJ/oOcR48y51y/KQwK6ucE5HZk9OwceDYVMyKO
	 pC25Qk4S5b6C84aB3ojYYiZbNIGkY/6KUHHI8zFzfV2I2uPCZY34KPWygFrhtgkusvTOb
	 tIAlf7pyAk479K2kp2y8kBqcY0SpefS11RA982pW4bpKfdZ0EdACMRa78shssacbbnwbi
	 WF5LT0QVMD9ANMHOsSbdgmN/Tf8L8CcxjObD92jJZSGySpFkOVmmeh0cG0UX+cdhtqfbc
	 2S4kg/72m9IhDgkhfTcBXuSR1VZDcRwYh1PzrQ3i/aWgzIzl96lFvzcP4uH1HmyEYNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAo3UyC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C610606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAo3UyC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412121F0089F;
	Sat,  7 Nov 2026 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050894;
	bh=7XNFfLFVmv9aNjKgRAgonLrmiBNEDBZ3plr2ao52a3w=;
	h=From:To:Cc:Subject:Date;
	b=lAo3UyC9z0eMdi4NZnXggKM2FlZOreHbKzCyahp+UFku3NWRcXkQac+dvl27EbUkt
	 mBRvvAybvh9M85LtEAok4t+YUJqTVEIsiPQgZ5Y4I8dYLkRSYTEKlYlm0wysYw/sq1
	 yw4xUjnSVPwnbdvnMJ8WOKidL1rk6yKliQ9wmtL/s3SZPIdsCQM96HGyVWXl4vkkWu
	 B6kKnhwfpZoMUDFxBN2SM94J4Lb0XHtbiwfRqzICgowVNBm8TwiXrZpsGUI2FZzcYg
	 bNT6O81DVhtW4hF6/Zk56JL9mIvko0KRpp1rZYXAHlbWrajOaH4b8haTZoJRvM99kO
	 /JlhT1jS+F1QA==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	bvanassche@acm.org,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:11 -0500
Message-ID: <20261107062811-failed-5.10-22d14117ec18@kernel.org>
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
git cherry-pick -x 22d14117ec1845a81acb3a5c4be325f7e8332f70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062811-failed-5.10-22d14117ec18@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




