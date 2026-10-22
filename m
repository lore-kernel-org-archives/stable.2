Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640689;
	b=QZW10gRRLoWq0GdKSGl0vEtbQKOG0palTx9thMIhPZVLhJS2GQrjJCFnD/7grEgevBpO
	 C2jf2qeCLq6ebJ1tMjmK5WUBlV/NaKCJwLwc+F0vhkdTPSQnbSIODQGIsPhxSP0z3xj7E
	 loqULu8PnfZ7WcGIRfXVVXoEXpfCwXeQR903rZV+LlsNsr5/vddgprWPDqwRw3VbF9Nrt
	 CGg0dxfLQyGBY1bhG8xJgdbmoATXAtpKYN93lbaqqm9sw7TxDLqa0AXbVNVlX9wpmEtTm
	 wXzWeN43KX9gMfrKEhwZiHaW0ife9vyt6og1CGbMbPtOU3dwKv3+1bahWLY+oVA+PhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8T5L2Doo4hafhgE4IIDG7Xgemkp+4Eg0v8OcH6PLgGM=;
	b=HEu9oW0Pev+X+KYVr5O2M61twrnYCnMal1kf71obl37KgFl5q2X3Z5sggIH/u1g3h0Uo
	 93SmMAsJdYeJ6iHSSZ4KYgfJBy2jM64dRBK59y6PowMFS5zDjRGEK4Afdu7HKavFE39rV
	 z1BZYRh4kyQAPfZQrAWDW7UZj1WIvLqeec2kY0xTTWYRzD3W/pa2krn6ziI2RHqIxkE57
	 rOayWuWC/21gYf9KVOuTpvu0yb7E3/FXFIlfEATL1GELC8lxJEwXysJ8hXJBgzLstQpyI
	 0Hc1BVwg8KgWQWiNR8xK3Hd8pi2V0c+APqPhvV9MnG63aUcZQjGumTC4qLm+1IkE/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kqW3zQRB;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC42606A330
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC42606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kqW3zQRB
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so1314739a91.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640689; x=1793245489; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8T5L2Doo4hafhgE4IIDG7Xgemkp+4Eg0v8OcH6PLgGM=;
        b=kqW3zQRBOvd8I2Jq+gdYfLCHqX9hdeBCX9rrNtPdsQ9l9EWTsenYVI3Xi1yPaMw4Jl
         MyCLwDwZDu15WwiOzm6CarutKDjUNyBO1gglmooNCunQP2XX2KUhgbzCSLDvN3oC1FTq
         4GpJtC2T/DXCD7jggVgnvEhOn91VGe1HL+SPjqrKsMi1Y+Wijtwez/rhmizLgtwzXKPo
         5qeF4iyCOhiQwj/q4/kYzqHO9TPJQmcPqvCuNpTt6veKxmJb2rhKupB244xNsVxq7GfH
         HJqbkYUjk0ylTZ0uV9iD7kq4+gio5zYYapsT+1XmfrCmaAyt44RJRmcoQy9F0z3QlmHw
         b1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640689; x=1793245489;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8T5L2Doo4hafhgE4IIDG7Xgemkp+4Eg0v8OcH6PLgGM=;
        b=vSvQrX8ao8kSxjlyjmzv1DTpqhl8zMLFHtz4BXMmCxYt5MJo8EjPt+dBUTYkUh77Jn
         XYHMmnMPV9MSn7iL6Oy6l2EL2eh7qeEY0+aiNpEuHJj8Etd+wySbmLVLGAgOBxD+4D3s
         F3b+tem9SWGjW3hjkLbBdAEX9x0kzbfCYYmDG3T+5OgoKTUzGRu1BlPEC7/adzL7ZUJK
         qYgbe7DLgB+jFjOlptVbyt1SsAYpdQHQZUVeFbZC7Q0YKU7pAV7axNH7SXbJqPdbCi3L
         wAw6qTWt2ecPcZH2dVP63E/10fTZuNMJtxSQucWcco5KvvVmJEiM+Rbya2PNKKaGypI7
         A2RA==
X-Forwarded-Encrypted: i=1; AKwUvBxudRyZm2uWsic7+D2Lmg5WgMg33vP9qyiUkjLRFwoGnIoqOPA2NIwXjjbFlpvbbac+xb2dVeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr7VA/lQxpuDkntOzPXzFPDxauV0yL10OCFFgRY8btuA+gEyLa
	cNqTkEFbqJnUFCaX9O7fTBP542thAsOjP07Dg+BxmtqqrKgKezbxQpQitdUz0+UaYi28kDFnaZv
	2izTU9BkubYOIk+7rY5H9lA==
X-Received: from pgbd23-n2.prod.google.com ([2002:a05:6a02:64d7:20b0:cd6:261d:5bde])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5251:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ad86dc12eemr3420030a91.53.1792640688818;
 Wed, 21 Oct 2026 20:44:48 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:39 +0800
In-Reply-To: <20261022034443.3034432-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022034443.3034432-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022034443.3034432-3-stanleyjhu@google.com>
Subject: [PATCH v5 2/6] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_poll() and ufshcd_abort() each have their own copy of the code
that clears bits in hba->outstanding_reqs under hba->outstanding_lock.

Move that code into ufshcd_clear_outstanding_reqs() and its locked
variant __ufshcd_clear_outstanding_reqs(), and use them in both
functions. No functional change.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/3779e125-9acc-42c8-9489-51b9e3c6716d@acm.org
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 12aafcf1f9b3..1db572f84971 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6052,6 +6052,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
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
@@ -6062,6 +6093,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
+	bool from_irq;
 
 	if (hba->mcq_enabled) {
 		hwq = &hba->uhq[queue_num];
@@ -6071,12 +6103,9 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
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
@@ -8111,7 +8140,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = scsi_cmd_priv(cmd);
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	ufshcd_hold(hba);
@@ -8206,11 +8234,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
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
2.56.0.218.g1ec904b173-goog

