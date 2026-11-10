Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346123;
	b=pMRcyBzLRRBC5szmYfYu1EhE90ipEXmzqLrTVBBn5Fzc3JnEtXdyTaJeXEL3BxBVh4GV
	 OUI7MIKESd2NA++HRaTURZtFnCUhezs6K1uvwVD0zaCxoKFvN8gSpIumil4JOKHMnPQ5g
	 KA2E3xRaTFGxrTqpUfGdeW6ZddcjftLzwNAbZXJ5cSbie9GoXV/bBf4InTvNuCUal4mla
	 Bm3cAtwj/DXsVIF7ARBAoyF+LWPSOdfXI/vQ9zFYckzZxl7XERM1hKBgTFnEo1+Wuccda
	 xhCBpZFHDNLH1KGoYDoMrmTXtJHf6qyiklqViJchDFq9psdee1rHrvoq7PHvc4pF2KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EKT4tI2ge01dtfvhDaLe7hGRod+MiKD92LA8qx19wFk=;
	b=j3qTK6gwmmWQ5aVzbevJRNzvywZXredG8NnB/Zm3GxLJfA3viae9pB/lswdLGyZ/+Eld
	 8K8VQq7uSdeiSUESnLx0zuj0M/LttU1zxw0OCOB+MDEsDn8oMPcPZ6aFzHP5wG1kwC5gb
	 XNICi+Hyy+KbtSeN+dPPxkzi+6ykLGqj+h+YyNoMtgRzOzq206WQKYMfjPYZJRl9ZvDvD
	 8Sq1mVKcwkDyJ4tUuq2H5Emt5gnuJhgcT28suWrzYHYTLLJTsdHNQpPnZlKf4ddWavH7O
	 5UlwTI4mQDLa7+KpR2ZlsG9pTnG8v6c2gh0G/3rxP8+deh32I0SQ8llw0IkKmArZy7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnPRKjtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnPRKjtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C331F0089F;
	Tue, 10 Nov 2026 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346122;
	bh=EKT4tI2ge01dtfvhDaLe7hGRod+MiKD92LA8qx19wFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnPRKjtX59QvsI1JZe6oOI6QPGJlLKT3i9uxFA2KjykkYHNyrkmaRfCC9+vo4IopU
	 hJ5wBEO+fH399t5adwv+ZsL22mP/TWZ8H0LwYUohti1sED4sFu9jcKlHrTFI9wwmX2
	 jGEDwOr9vosV9zi33wMBaPG9D071mR72Nx7JV7rooo8etD7jv0O7kVt08mn9/BlpoM
	 kFL3l0eRDP56GNLhHbn27JtGgpqyaM5rU5fPUOhK0QDGZwsywFe3MWK/vpqpbHJL1o
	 sVRQWqWp4VyfH5TRA1QVftDcv3hZ9VtMlN3SrF7xKWQJBJS24liRKH8Ie22gr04TTJ
	 xx+QjwX+n1eZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
Date: Tue, 10 Nov 2026 16:28:39 -0500
Message-ID: <20261110212756.3925664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053827-failed-6.6-22d14117ec18@kernel.org>
References: <20261107053827-failed-6.6-22d14117ec18@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3ffd18aa9675d..c70ffdd299a2c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5601,6 +5601,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
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
@@ -5611,6 +5642,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
+	bool from_irq;
 
 	if (is_mcq_enabled(hba)) {
 		hwq = &hba->uhq[queue_num];
@@ -5620,12 +5652,9 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
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
@@ -7694,7 +7723,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
@@ -7786,11 +7814,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

