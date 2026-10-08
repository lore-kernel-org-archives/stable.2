Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA948BD5E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452268; cv=none; b=SqShlalMnnOJmmxQZtesGONlKHfITQh43lueUAA3i12AFOJJDJ6fAAftvJmvXjZXDsiu1Qfw25n/EnIHlSezQmx3KJthdEThZmti/YpeIE40Ps7eX3EoxYOB+Ri1/aIU9XEuRKIZqErJI2yqraAKmO1WUq8HvXBDXtvbmMVGlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452268; c=relaxed/simple;
	bh=x9ih1pwK+Rgtf6rB4TZu9gSvmKtzp41IWFqJ8da9HNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djHdJhFMZfV83wzWYT+hkbWKsLy3RFkOlhjsP1rY+b+pE8LVRXWKe8G8qHk36HcHRRgKdYWZVzgLgQtIhkGKoiVsMVIZC/n7cln7azcHprxfFL4X7S1zN2XVIdcCNQBWaxOK199+RH8q1+fpjrPz9Je5Y2wvEvO4OliHgYTm0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5FcaFHE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5FcaFHE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso350528f8f.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452263; x=1792057063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jyvRN3WPnyDcoToF/7upqd8kG5H4NmdfwqtphB+zdqM=;
        b=i5FcaFHE651qhQ+ZMIrvxQfmjdHt8Cind4KUQbuJWOq21D76AdhJE0Xm+7/1y0GEtT
         sY/+8HglKnjfQkwPpLazPv29gn9Kyo4m27F91XGZoQMIxo8mYk78zaUS9fOXFF3NtHmo
         7+lnZUFG0dduHEbG0m0IsgFY51FoD5jEXG2kIVIode8tQfjQX4aJOpnY8mYGQkEotYwF
         8ZrbxDMzKpvxRLgPAyse0Wrr+ALqclBvKBqrcFUFfLKC3jhlJPuHDyO/2EkABqWn1p9/
         eMwJIMPdsbMt05myakTn4DfeA+6zNYkEvONJfn32zE9wn2ULYJRs/ITgokO/7nqYNAdt
         /iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452263; x=1792057063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jyvRN3WPnyDcoToF/7upqd8kG5H4NmdfwqtphB+zdqM=;
        b=Hwrse+k4q2fq1iFbXuy5ynuy1hXXdtn2kv49FJfVxP3EDsnycZ46mWPAcynTVfJuFn
         mRri1oIxDqnzxsReghyAftZo1OWtSNq7uHnwqWq4cGwYi3UVN7/v30bybSwmV0yV/dCt
         B1A1Xm881Ymv4WlaUCTfUSNZ1lS03WLzJSVCQcvwcwnHovaCNCkPoqZdNFdwsfod5Kil
         3QqqjdZa+eGz26rxDMjbXvM5dCXAQyHkDEto9YEdQHHq8j9XmuB9LV55E1Az4Yifei3Q
         GKSyle1Uy6QK6EHxeM9PasQ83+6NUYEAIrl1wO5YhfNXpTq9Lqw2mXMP6CBUxqpd+qX1
         g9ew==
X-Forwarded-Encrypted: i=1; AKwUvBwGDbFp5IsCaij0kT24zET16KYDB+ndMeIYyMHIgBZCh+dRHTWpXZgLDKnpgFksKfT2BAS5ca8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1UOoCRMrpExiK8JzDQObKougLDFHGpftq6akyO6brxrUXLgF4
	tp38J1yYvx2FJ2iBISciKa34xKjY82K4feDJdhH9dv4/I/J0qPc3neo=
X-Gm-Gg: AYBFou3rgvR4S/+S1uzlCBG9VyXsnSi8gujCRABx5qK54VPNDFFfo5IaPeVTP8e/g3g
	CJcEk2thvGXkmcEIfdMgiqFBK1W6hlTkSDfz2hN+clcZ7eXRdT7wLSYDKz0e8EZowPnZkEgsAHc
	kStefV0hX1gNCyEeCJc/qiotlrbgFUruVcOl1sAvGSm/spDi/7/p3BLUBlnlSM4azXFMpw3M4Ib
	zB61E8whTftqJN0IgMpa91p9scMnD/nfI/ek1Aa/3Amn9PlXLy19Dq4rRHiEXd6KF4wrDEkNypw
	8/72P7ZlNQhIgJ/dKAX84cjAd+rRFYMzhYiKPM+Qim00qgKGoNC5AO6Ksov0KxESPg7Hcj5mJ7J
	kc0+b++6n/ESR3ToalUKU5duQ++J7hQHeBMblHpsZ3aTagch0wPr6iCQPWpMh0C455jozX4DWOs
	BZGcH3GU3VWGRveRudupGvweSZJq4ZKQ3Y/C0lpvo=
X-Received: by 2002:adf:fe89:0:b0:487:1577:9e33 with SMTP id ffacd0b85a97d-48c7f12523fmr2488555f8f.25.1791452263095;
        Thu, 08 Oct 2026 02:37:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7af45d94sm3649370f8f.12.2026.10.08.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:37:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v5 1/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Thu,  8 Oct 2026 09:37:39 +0000
Message-ID: <20261008093740.3034881-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008093740.3034881-1-tristmd@gmail.com>
References: <20261007223222.2342804-1-tristmd@gmail.com>
 <20261008093740.3034881-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The rxe send queue is mapped into userspace via mmap. The requester
processes Work Queue Entries (WQEs) directly from this shared buffer
without first copying them to kernel memory. Userspace can modify WQE
fields (num_sge, sge_offset, SGE entries) between kernel reads,
leading to inconsistent state in copy_data().

This is the send-path counterpart to the receive-path fixes:
  - commit 22b8fbded65b8 ("RDMA/rxe: Fix TOCTOU heap overflow in
    get_srq_wqe")
  - commit d6ab440240a04 ("RDMA/rxe: Copy WQE to local buffer in
    non-SRQ receive path")

Fix by copying the send WQE to a kernel-private buffer in req_next_wqe()
before processing. The copy uses the full queue element data size
(max_inline bytes) so that inline data, which shares the flex array
with SGEs, is always captured regardless of num_sge.

The local copy is reused across multi-packet sends to preserve DMA
progress state (cur_sge, sge_offset, resid). Field updates are written
back to the shared queue using WRITE_ONCE() for individual fields and
smp_store_release() for state transitions, so the completer and
userspace observe consistent values without the tearing risk of bulk
memcpy().

The copy is invalidated when the WQE index advances (last packet sent,
error, local ops, UD oversized), when a retry resets WQE state, on QP
reset, or when the QP enters error state for flush.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 55 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 311f285d78a6b..77606c4a039b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -581,6 +581,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	qp->req.need_retry = 0;
 	qp->req.wait_for_rnr_timer = 0;
 	qp->req.noack_pkts = 0;
+	qp->req.send_wqe_valid = false;
 	qp->resp.msn = 0;
 	qp->resp.opcode = -1;
 	qp->resp.drop_msg = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 24f5c044363f7..ab371f2d7791a 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -161,6 +161,26 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
 
+/* Write back requester WQE fields to shared memory using targeted
+ * stores so the completer and userspace observe consistent state.
+ */
+static void rxe_req_writeback_wqe(struct rxe_qp *qp)
+{
+	struct rxe_send_wqe *shared = qp->req.shared_wqe;
+	struct rxe_send_wqe *local = &qp->req.send_wqe.wqe;
+
+	if (!qp->req.send_wqe_valid || !shared)
+		return;
+
+	WRITE_ONCE(shared->status, local->status);
+	WRITE_ONCE(shared->first_psn, local->first_psn);
+	WRITE_ONCE(shared->last_psn, local->last_psn);
+	WRITE_ONCE(shared->mask, local->mask);
+	WRITE_ONCE(shared->has_rd_atomic, local->has_rd_atomic);
+	/* State must be last so the completer sees prior updates */
+	smp_store_release(&shared->state, local->state);
+}
+
 static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
 {
 	struct rxe_queue *q = qp->sq.queue;
@@ -193,6 +213,20 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 
+	/* Reuse the existing kernel-private copy if still valid */
+	if (qp->req.send_wqe_valid && qp->req.shared_wqe == wqe)
+		return &qp->req.send_wqe.wqe;
+
+	/* Copy WQE from userspace-mapped shared queue to kernel-private
+	 * buffer. Use max_inline as copy size since it covers both SGEs
+	 * and inline data, which share the flex array.
+	 */
+	memcpy(&qp->req.send_wqe.wqe, wqe,
+	       sizeof(*wqe) + qp->sq.max_inline);
+	qp->req.shared_wqe = wqe;
+	qp->req.send_wqe_valid = true;
+
+	wqe = &qp->req.send_wqe.wqe;
 	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
 	return wqe;
 }
@@ -582,9 +616,13 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	qp->req.opcode = pkt->opcode;
 
-	if (pkt->mask & RXE_END_MASK)
+	rxe_req_writeback_wqe(qp);
+
+	if (pkt->mask & RXE_END_MASK) {
 		qp->req.wqe_index = queue_next_index(qp->sq.queue,
 						     qp->req.wqe_index);
+		qp->req.send_wqe_valid = false;
+	}
 
 	qp->need_req_skb = 0;
 
@@ -634,7 +672,9 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	wqe->state = wqe_state_done;
 	wqe->status = IB_WC_SUCCESS;
+	rxe_req_writeback_wqe(qp);
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
+	qp->req.send_wqe_valid = false;
 
 	return 0;
 }
@@ -666,6 +706,7 @@ int rxe_requester(struct rxe_qp *qp)
 		wqe = __req_next_wqe(qp);
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		if (wqe) {
+			qp->req.send_wqe_valid = false;
 			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
 		} else {
@@ -681,6 +722,7 @@ int rxe_requester(struct rxe_qp *qp)
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
 		qp->req.wait_for_rnr_timer = 0;
+		qp->req.send_wqe_valid = false;
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		goto exit;
 	}
@@ -695,6 +737,7 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(qp->req.need_retry && !qp->req.wait_for_rnr_timer)) {
 		req_retry(qp);
 		qp->req.need_retry = 0;
+		qp->req.send_wqe_valid = false;
 	}
 
 	wqe = req_next_wqe(qp);
@@ -772,10 +815,12 @@ int rxe_requester(struct rxe_qp *qp)
 			wqe->last_psn = qp->req.psn;
 			qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
 			qp->req.opcode = IB_OPCODE_UD_SEND_ONLY;
-			qp->req.wqe_index = queue_next_index(qp->sq.queue,
-						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
+			rxe_req_writeback_wqe(qp);
+			qp->req.wqe_index = queue_next_index(qp->sq.queue,
+						       qp->req.wqe_index);
+			qp->req.send_wqe_valid = false;
 			goto done;
 		}
 		payload = mtu;
@@ -839,8 +884,10 @@ int rxe_requester(struct rxe_qp *qp)
 	goto out;
 err:
 	/* update wqe_index for each wqe completion */
-	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
+	rxe_req_writeback_wqe(qp);
+	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
+	qp->req.send_wqe_valid = false;
 	rxe_qp_error(qp);
 exit:
 	ret = -EAGAIN;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0f5ffd94643f9..a22dfc6e5ae3c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -114,6 +114,12 @@ struct rxe_req_info {
 	int			wait_for_rnr_timer;
 	int			noack_pkts;
 	int			again;
+	struct rxe_send_wqe	*shared_wqe;
+	bool			send_wqe_valid;
+	struct {
+		struct rxe_send_wqe	wqe;
+		struct ib_sge		sge[RXE_MAX_SGE];
+	} send_wqe;
 };
 
 struct rxe_comp_info {
-- 
2.47.3

