Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344480;
	b=voeafS08SU/FIXV5VMi8k0RjWoiuImZCG1tEi1lgocm6ugmlW6EoMKNznDyvwGfopebO
	 yOdXcnOy9agGp3ud50nb+gJ0dv8Wys2wdXOo2LXu6MuvkEbyZ8tjc/nwuBMusx8Ys0HJ+
	 8Zek4fZyBVaHU0tKks79/y1zGK3ehZDsXC8OQG5nngK0inBXFYhfeqeSe/jUeeV96MfaB
	 xNdSlmUNoazG+B+2GmH9hlE+Dv/0BlqsAJ5wWWlh0qX1A7g8KkTcZ0hNSqKQNjAh6b+pu
	 zCoiJQ63N6kmH+9IdeAJ3kRpToSA3wtVeaEfXfqKx12l3Yu5+e4N4zeedbltxhrcnlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hLDryZYe7frd1jsb5XtVdEGKIRIz2gYYuTAhwzd/eFc=;
	b=cY2uEZ8R6KUjURuOG3vnrIsG4e/N36UdjRpbb0EtcRqLqk3voZDc3dAPoJxi7sCx5jhM
	 FghXfbVTw7WtrDu8A/tZlcNzFw7Pzb75r1eCkIHsKfQqG1U1RT9/TqDyebf79L4425jTc
	 eM7zWKNCkx1+xSA1c3nADDlOIsz/RRch23RnbsGb9SD/Ef2F7RlgvzkJA5O05qPNTgb+L
	 zU3xukMF8CBcuvVB0cqV7hUR0i9e5VO91zW2hz4PRsCi+vlU+EeHUUFFnHBGrSwR2kM7W
	 x1DvPfGt1tDs4LR7Sq8Ncp36HXBfz9NEKcb6gt2+BOrw/CQyboOYhHV6BY8OBnvqoSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7XIfi6t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D39606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7XIfi6t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C211F0089F;
	Tue, 10 Nov 2026 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344479;
	bh=hLDryZYe7frd1jsb5XtVdEGKIRIz2gYYuTAhwzd/eFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7XIfi6topLqSHeRLhgiSLVGNB6EUc3HywNF7hmgLtqp1gAJo2hiwVJWmobP1VfIj
	 uUUdGZpJ/a0rRC2qX38yrsbQBnyl9FhSFOn0dLCbY61qcwrE/dSdFzUVPLdUVstVmg
	 Iwcqg/VovrLY82doG1XDMskeorfEN8QE31kOM3onpaoafNJvtnyH7Q1Jv+E+Iw9Dkg
	 OMaGCcD7i+UJG6LxVcna1x6q/qS0N1gCbeaXLM2IGldZO3OARdACJY5w9B82lJ7Q2T
	 3l5FcUAJ+YS0GDaQkjPzfq1vLHRtw1ckFZy3KeED2cjjV3D+1tv50qMIVJtqXvP6CI
	 nitIW3eRw4Cfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
Date: Tue, 10 Nov 2026 16:01:18 -0500
Message-ID: <20261110205856.3866490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051352-failed-6.18-22d14117ec18@kernel.org>
References: <20261107051352-failed-6.18-22d14117ec18@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 22d14117ec1845a81acb3a5c4be325f7e8332f70 ]

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
[ sashal: Retained the lrbp argument instead of cmd in ufshcd_release_scsi_cmd() to match the existing API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 97f86b6905b56..d595072f7c0a4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5694,6 +5694,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
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
@@ -5704,6 +5735,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
+	bool from_irq;
 
 	if (hba->mcq_enabled) {
 		hwq = &hba->uhq[queue_num];
@@ -5713,12 +5745,9 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
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
@@ -7739,7 +7768,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	ufshcd_hold(hba);
@@ -7820,11 +7848,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-	if (outstanding)
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
 		ufshcd_release_scsi_cmd(hba, lrbp);
 
 	err = SUCCESS;
-- 
2.53.0

