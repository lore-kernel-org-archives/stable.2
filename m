Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345478;
	b=OGtOYCAFTK5tegQNvSBHr2zXVQsVW+U1Yqb8xgzB3RSKXHVyDe5vKxQA0yJ1bFI5gt7f
	 N5aPMO7u/6AHchnKLs/WsGcE5UwwMCQzdiiQqAh4BVxKbdJCX+SSj+0XZBkTwVS+Odj5x
	 D2fTs7RynfFic8zjUpzj4UKHWcDhH5O5KusCXjSTXEB6dsFr38sh6yfxz2GnQsxPDd9uf
	 L53xYJQVn4N4y9iFCWk7dCcMLZNnikjt7QGT0CcUPNNAP5igLims3/KxtrOYYDwTgGGxa
	 311CkGKDCV3b4AyB8w0yaSd7wwi3KzAw9bHiZs/PcGW9oCNagycy0rzWgW7zxfo4ihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KR+9ARKChn4zAOG4ecdFmuHq7zwJhdfs8KPdNcLxFaE=;
	b=WBIKuLuV3mbbWNEXstU2Pk5JvILPi0PadSIu0/L0RVzcXuo+GF5tUkNRfN5UeGoEuolv
	 wjqVxkBOTpoVMsQUDwFzAkV8zWznuC3ztEQAtSLvD/4u7n1Kq6WVq5TA9Txyd2oqNUixR
	 iRd98EFJTdVbPdHNt34z/YCG53kk7p1IiM4aptYaY6dccF596WBn1SYFGva3tsmVfxUIz
	 fNG6PuHMbknetGJi0XlUB55CStzsQr27NK99fffH2JgoU0XJdgHXuvCSc9gT1HqeSR4sF
	 VfFQx0SCs3B6KV1u/Hk7HwIc2bLEMzik29s+CEBLeM0JsFg6fxhtex3X/lUAR90SB3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNhdqCml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45B606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNhdqCml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC61F0089F;
	Tue, 10 Nov 2026 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345477;
	bh=KR+9ARKChn4zAOG4ecdFmuHq7zwJhdfs8KPdNcLxFaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kNhdqCmloE8XHNKlwzEzqNaPV0YY6jO/7kNwZrha/rKJHODuKnN8JlJq4Ucs1F9uS
	 45qMg0Oi+PWKNrQQB2Becv8jljM76B7KzoJu1T4K9awLgTM5IBrBMzPdkeMobRe8rt
	 FUDLDwocRTsku49FEiVEfDEPgOdKPibdRNQKMbZNF32ppqxNoFogQQkFqU1JpnRTB2
	 gyoeaxuI5ut6eRgEZ7fqM02n7EsiIZm61WP85qlqkFgI5zYmMz2WnPq0+z2mTEVXoC
	 NZMGAYIw6KUOz3H7kzFm8oSiFENzK4+LgbSfW6GaMMu7arm+1YHkvi5haGDBOaNWb5
	 zs4A6iE0OijhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
Date: Tue, 10 Nov 2026 16:17:55 -0500
Message-ID: <20261110211631.3892165-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052536-failed-6.12-22d14117ec18@kernel.org>
References: <20261107052536-failed-6.12-22d14117ec18@kernel.org>
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
index 4a78a5d9cd8b4..798ad0338cd97 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5653,6 +5653,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
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
@@ -5663,6 +5694,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
+	bool from_irq;
 
 	if (hba->mcq_enabled) {
 		hwq = &hba->uhq[queue_num];
@@ -5672,12 +5704,9 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
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
@@ -7662,7 +7691,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	ufshcd_hold(hba);
@@ -7743,11 +7771,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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

