Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA59352008
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567902; cv=none; b=CSHwojKuvsQ/uxff1qbRFivYk2nu0c2sLx2TNEnoGrw5k1YhxQSrZZlBVZws7WoxyIwPjm67gb1/1YGoXRCdfahVtMnBp1AfNjYFLaHPWRrhAShvKEDPN8JBIMMDrkDxuF5eBG0A33XmaVk5dp1JHjJ80keQ4PyH3sA9nZLeLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567902; c=relaxed/simple;
	bh=bWLjaucef1W8bO4X6kzN9fJi7s4MM2c5rAnTy5vIDbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1n8QXpwunXHziTtejBlJtnYME0U9qlMvfxxGoqpl3BgyrbmFyKEKMG8B+Xq9E/TztIKsEyMfzmXIuTDcZGFmmYaXyxYg857lcnGN6LCjqicRIZhzLZnq6Ww6LRegizTgnL/O7Lwv+F5TxPSQPnPsYCBYwsDxeCP8EajMEn00nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKbr0cgq; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKbr0cgq"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8804be7d586so1088744b3a.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790567900; x=1791172700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVmmbfYt/ak4rGYmpnhDkV7vbXCxHseRCZMu4+w4fDQ=;
        b=nKbr0cgqZA7iBC/MGSTnqBRmz9QAhgFdDkz4c6sX/xsvcNeJjG52Ocr4VYDCiQvzS2
         Ws32EcmY7/bIWJL8/HUxVQR9owRE7T79WzwqqKq9hSK1BpjRJK95Xb+K8hA1JuJ2dGKN
         PKxsVXltj19MZ3N4PuCpl5h1JUU092OkmlJHH80ImH+FGdklqjxAXV6E+sjH+jAPPFtd
         NHAm8RMmmLbb53kjH5nPO7ImvUMp37itCqf/hKtdLun1MDE92/yzBHfMg4nn6h5AsrxK
         xBuzXkE3JpZmG9moxwV2mdNEZmWAmwB+SMYEjCPJOfhluwy+5fTxK+ejZsjZDp5h2mHB
         SugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790567900; x=1791172700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVmmbfYt/ak4rGYmpnhDkV7vbXCxHseRCZMu4+w4fDQ=;
        b=R1HPIr7mny5ZeQbHmjlJu2+c4zdvN7P99vlqMd35TSNJdqwTIIvSi5675d9mJCMmV9
         LKal21s0FhTgsQICoHFLpifcUO5V/37XBmKKj5Bo86MHvXYoqSbsyN7FF0/z4t5S9pJD
         axAo1aCVTbRRWIUyHkX453BUvgVDXpn8LOkP5luOUbT06cBujEPCm56sA0dHLtsTJGn3
         rt8jVr2wfnhKilidCySzC2RVnCKT9wYTs1iB0V38r4v2pO1ph96bGmbEjD2DWN+8XPRp
         ZbVUf1wAIxf3T4SeXiArTqFiPglzWcw0qptN+l6HWbuCS7rM28sVnebofyydFpzGjbDP
         Yfkw==
X-Forwarded-Encrypted: i=1; AKwUvBwDHsM25KFzAf8Jf3PfTDtlp1cg6ULRQtx0tf0/EUO63NgOj3P+JDd4FANww4efkBKcMli/yyI=@vger.kernel.org
X-Gm-Message-State: AFuF++k9qsjQJnTI3ljrJWGrrpnTqULDgshrs6flDziM8VVsPTsF1/SR
	fJkHV8dGu6lRduxUY8mEAuNpvsDLc+1ldAVRKVffEZ1Tic2rBcvFbxjtdZVCd0TwF6cCiY59SKI
	Hau8i9O9FzomeMNGZYIq3RQ==
X-Received: from pfbdn9.prod.google.com ([2002:a05:6a00:4989:b0:883:c2d2:244d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8c5:b0:87d:3894:1983 with SMTP id d2e1a72fcca58-87e9eb629a9mr8717027b3a.28.1790567900338;
 Sun, 27 Sep 2026 20:58:20 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:58:15 +0800
In-Reply-To: <20260928035816.1294326-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928035816.1294326-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928035816.1294326-2-stanleyjhu@google.com>
Subject: [PATCH v3 1/2] scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During MCQ host reset, ufshcd_host_reset_and_restore() stops the host
controller via ufshcd_hba_stop() (HCE = 0) before calling
ufshcd_complete_requests(hba, true) ->
ufshcd_mcq_compl_pending_transfer(hba, true) ->
ufshcd_mcq_force_compl_one() -> ufshcd_mcq_compl_all_cqes_lock().
Because ufshcd_mcq_force_compl_one() is its sole caller,
ufshcd_mcq_compl_all_cqes_lock() always runs with HCE = 0.

Despite the comment above ufshcd_mcq_compl_all_cqes_lock() stating that
reading CQTPy may not be safe with the controller disabled, the function
still calls ufshcd_mcq_update_cq_tail_slot() at the end of its sweep:

1. Unsafe CQTPy MMIO read:
   Calling ufshcd_mcq_update_cq_tail_slot() at the end of the sweep
   reads CQTPy over MMIO while HCE = 0, directly contradicting the
   function's documented contract (commit 1373df88d535 ("scsi: ufs:
   core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()"))
   that reading CQTPy may not be safe with the controller disabled.

2. Spurious error logs on empty slots:
   Sweeping all max_entries slots visits empty entries where
   command_desc_base_addr is 0, causing ufshcd_mcq_process_cqe() to log
   unguarded dev_err(hba->dev, "Abnormal CQ entry!\n") messages.

Fix both issues in ufshcd_mcq_compl_all_cqes_lock():
- Remove the ufshcd_mcq_update_cq_tail_slot() call and the redundant
  hwq->cq_head_slot = hwq->cq_tail_slot assignment without
  replacement. The two indices are already equal after the sweep: they
  are equal when the sweep starts, since ufshcd_mcq_poll_cqe_lock()
  consumes entries until cq_head_slot reaches cq_tail_slot, and the
  sweep advances cq_head_slot by exactly one full ring. Both indices
  are also reinitialized before the queue is reused.
- Extract ufshcd_mcq_compl_cqe() and invoke it only on non-empty slots
  during full-ring sweeps, keeping "Abnormal CQ entry!" logging strictly
  for unexpected empty entries in ufshcd_mcq_poll_cqe_lock().

Fixes: ab248643d3d6 ("scsi: ufs: core: Add error handling for MCQ mode")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs-mcq.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8106d55f4041..df293b66350d 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -312,20 +312,24 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 		UFSHCD_NUM_RESERVED;
 }
 
+static void ufshcd_mcq_compl_cqe(struct ufs_hba *hba, struct cq_entry *cqe)
+{
+	int tag = ufshcd_mcq_get_tag(hba, cqe);
+
+	ufshcd_compl_one_cqe(hba, tag, cqe);
+	/* After processing the CQE, mark it as an empty (invalid) entry. */
+	cqe->command_desc_base_addr = 0;
+}
+
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
 
-	if (cqe->command_desc_base_addr) {
-		int tag = ufshcd_mcq_get_tag(hba, cqe);
-
-		ufshcd_compl_one_cqe(hba, tag, cqe);
-		/* After processed the cqe, mark it empty (invalid) entry */
-		cqe->command_desc_base_addr = 0;
-	} else {
+	if (cqe->command_desc_base_addr)
+		ufshcd_mcq_compl_cqe(hba, cqe);
+	else
 		dev_err(hba->dev, "Abnormal CQ entry!\n");
-	}
 }
 
 /*
@@ -333,7 +337,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
  * controller disabled (HCE = 0). Reading host controller registers, e.g. the
  * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
  * Hence, iterate over all completion queue entries. This won't result in
- * double completions because ufshcd_mcq_process_cqe() clears a CQE after it
+ * double completions because ufshcd_mcq_compl_cqe() clears a CQE after it
  * has been processed.
  */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
@@ -344,13 +348,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 
 	spin_lock_irqsave(&hwq->cq_lock, flags);
 	while (entries > 0) {
-		ufshcd_mcq_process_cqe(hba, hwq);
+		struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+
+		if (cqe->command_desc_base_addr)
+			ufshcd_mcq_compl_cqe(hba, cqe);
 		ufshcd_mcq_inc_cq_head_slot(hwq);
 		entries--;
 	}
-
-	ufshcd_mcq_update_cq_tail_slot(hwq);
-	hwq->cq_head_slot = hwq->cq_tail_slot;
 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

