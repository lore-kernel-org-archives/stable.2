Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27323EC808
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412351; cv=none; b=YzvH947z9gnk0PpRggyGAU27Kok8iCBnxWCRFMPQIZ4Ah9W7b0ooP61W4xObJzuZPPnl9AcEPLz5BcDE9sLOWt6IlfvopPtdzvjNBS9YPCrEB60gNnKEB2o++8OGR7K++CMRkp8iUVfJNc5raGsLcLqrYKx4h0H7uJpEwVly8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412351; c=relaxed/simple;
	bh=eqCo2qRnfA4vab3NPA7vegOdnDJoFIu9N3t2rRi1Y6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMwdbb3oI3KqitWKFUtCe5s44Ja8ZUDDivQEsxfEJISd2zRL1hZMFIDCc5xDuIoj3bxZPnUnL0q69plJDJuTCTuOmmw6Fj0QFg698SHOdE5a5zSzX+nhfdKo5fpwoP7jpt11Z8gns49jYwS2oD8qDHscBvTfAhGHvopSiqvVA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji5wZR4o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji5wZR4o"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-487048857f6so1974181f8f.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412348; x=1792017148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eJKNdBnTPZ3hgwXGaLanmX1oM8J06Yj2qpGihu5c/k=;
        b=Ji5wZR4opdbrmpCXFbGEzdUxtNfXV74euscJMAWjIyzHzacjaxwKiaFeIZAELtupvC
         MhyYtvLZiVMU8z95AfqYZVyQ0X08TgR44xM3OUw06O7w35whN1CNgyiBNN3YQQZwbcN6
         PLbaGhi4E7a1kXe3XLsJAdYKAuTkVwmWrXQBJ/PfZeUyvFkAUZFn6QrbvHrwLj61NT2s
         bYUUAYi5GTStTWkP9dBT6/L0poUp6Q6cdvYSzttNnGHXk3s8hCU6H4nNWrNr5iW5MeFL
         PdB6CA5Vu9vWJ6nwLdbHMkxqOO3rGYeATc+G+w/KtSMEiHGpVhNlayviJLAQx49L72dK
         Io/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412348; x=1792017148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eJKNdBnTPZ3hgwXGaLanmX1oM8J06Yj2qpGihu5c/k=;
        b=JUSkIek8BKoaHikxOynCY1I88SItoEGv7Uy5cAKY8Ri5oA69FASWulGPwFeVQ7WMY/
         V+4lYGMpI3pQAx/6CjxLx/n1eO0xQoYVWM/NSYgQWsvtV61eDGI92OjBlDoDwOOdJcRp
         P92grd5Sz/wsry6uoIdjbirl/IbeyOeRt67T2ap2eltRxj+VgdigIxZma6f+XWXGxe3e
         pD+oINPkses8h07JqEJhy68bx960lIsgYS9ccQIKjctEPaJy2FFe6xwc4jpEkFEVfXNG
         BiUBrKV6Z6+/Lg6GQ7kLmoNMJoVNS9BWHCkpwXsy+2e2FHee0g4HuzxY+DZimfzDD261
         tOXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlEnv0FCq63BMIIk1PaLY/EULCOc4i5hpuc80AxcWPQZxdVeKRP4qT75NFESBYlgE98/KLnIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAZ0i0tKdYPLk1md+BGtlaKLpdVjtFlJ6FbsCVxONnHoBBqNhU
	5/U1n9P9J581a1ail0AWr9J8C1NKr/XMHmcehYVXPARF2s0eZswDHZBVKgiy
X-Gm-Gg: AYBFou2hQ8JUpCpvjiX5IlGbSUAAWZk8bq9ulFLY/1Dd8/vpm1aF5bIco18TDkpeWEJ
	Tz04aDsuDJFJ3hIQ0krs+YmVM5kzHBobGNwdnrw/Qpf1u9ltK7r72jwhLphQfiJxhv9DPP0mGVb
	VLDm5Y+p+KwovItUUvXyLZpHvHEOeup0qnRyaQxG+5/wW8xKz7yqiroltSJLTlenFVJ4lID7qaG
	pWi+kbXaaYHAKLH4GRN4e4d32H+ga7ZEvMS/zr0p1wzx4A9N5cUYZVNajFqVi3tgJzawC7YncCS
	QSbOwjoZNYfa7rUevhU8uC7pPWd8cBUenvexRWWsXGRKFyCip3JtW/hO55u1CP/LOBqsn6VjOst
	s7Oeg/j1VfalMdixOIYi88avvBalBl3U1sNkpcuwlvWNZo++rTO78JDQt0ifg+cpDGixWW8+XMN
	gEAeEnyVRBR5M3uZt+uMRKprIjEmM6NkPsFyoBnlQ00Dxgl13kJw==
X-Received: by 2002:a05:6000:4550:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48c72896065mr4171779f8f.45.1791412348125;
        Wed, 07 Oct 2026 15:32:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1fec3sm7743500f8f.37.2026.10.07.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:32:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	bob.pearson@hpe.com,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Wed,  7 Oct 2026 22:32:21 +0000
Message-ID: <20261007223222.2342804-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007223222.2342804-1-tristmd@gmail.com>
References: <20261007223222.2342804-1-tristmd@gmail.com>
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
before processing. The copy uses the full queue element size (max_sge
SGEs) so that inline data, which shares the flex array with SGEs, is
always captured regardless of num_sge.

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
index 24f5c044363f7..2abb2131c0a90 100644
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
+	 * buffer. Copy the full element (max_sge SGEs) so that inline
+	 * data, which shares the flex array with SGEs, is always captured.
+	 */
+	memcpy(&qp->req.send_wqe.wqe, wqe,
+	       sizeof(*wqe) + qp->sq.max_sge * sizeof(struct rxe_sge));
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

