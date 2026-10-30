Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379058;
	b=XFLZw66jzxjdsnSbBEH6jee/zpVsHYtj5ruOjNh73yCEG2ynAJ29rjVurZfoa1W5C36a
	 CbyZ+HGAaUeq6BNPVKzFdOgtVhN807t+AzdiRU94nHFfe5MwJ16K8WBpJcB9nup4du3Zf
	 ypn1y2EGCe24aLWzSRwF79r0owHxA+IciuAGwV5zss1Z2OyKHC9b6+KBNJpH2thj0k4zo
	 q/rY1tLOLdFDvOZos0YmzB+bBdMC+KihXUMqLopdW8x1iz2qvMJ2wCc/WkYjTpGJBj/nQ
	 CYQEr7W0VgzjZcB0+BxTchSrDufNckijP4d9Vh23JtucGOJfVOBzNnhc8aawVV28xTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8vu28/cmtSD3JCVbStPihjIaWJ9BLn/rhxL0dl6t/38=;
	b=S/WFuVLr7mVmk3LjTU8qQTgLEzA80ZBeEu6YIVYmZ8usyvXqTskM0ouT4zQqqftn+T0c
	 Ihmio+saazQrperlxgTdReLzsRTBDo5lH9bMv8Hu4C0G4v+4V1uP5jGn2uvk5dCPSVOLz
	 Nu4mn4+0KQBTgrNQHpaqfVFxMa9Lg5kMLa488ZpsaSMh7xiF3pmWBQcvHePWria8mPdxC
	 R+GZGXQP0S9IgJwkyAzs+I4rkc1J5LpB8cElP7UetvKSY365X7JpHucIfFkm5LT4HQQwK
	 aEjL0xgEBj2o6Cxl4Jii8yU10xttuYk2o6nyucUN13q0w2oLpRN0Zf6bylkMQ1N1RYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z90LhytH;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66A606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F66A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z90LhytH
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so12299395e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379051; x=1793983851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vu28/cmtSD3JCVbStPihjIaWJ9BLn/rhxL0dl6t/38=;
        b=Z90LhytHWzPu7s4XBPWFDHfoT3ocmegtcJNLRmfJqcBEsCGlFF+qUJZlvKVhO83xAJ
         3vFAa+jWM9WTnGllQiRcP8wLsKoC9bFBHhTsjiLLW7mvnxzAkHNvk3/FAgTL7mf6Eg82
         JQ1PoCRwHytzmbLcZKBTSd+J+Xd/jzEnQBWJsjoL7GRLipxlN390qg4q3MBzsT4sBP4a
         cw496fBLWljeHzqVKsWE7lDUoN57UA1IBlyJw+oqgRxoF16UIoGvcm0YJUNyDh47BL4B
         6DDG758AJEEQWeUU5qDqwWYtp7ZMjKmsCJIY86kbG3n0gLrNiZfetbSwUfEwf6jK7CAI
         ct5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379051; x=1793983851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vu28/cmtSD3JCVbStPihjIaWJ9BLn/rhxL0dl6t/38=;
        b=pb/MhCc5tLDrr+dGUaE//OQnYIfQigicswLo6WrjoCJ638TKCySQBFAAmDPjOctAaa
         sxDjrekkcouIty8YcAod/4Giat1Hw4tiZCMMtBkCRfQr0KdXSuUPzEkvXJnDQMrSZbNg
         PW/xueZQ43sAa+VjLIPh32y5nh/wASSgH+b+RMl1f+HPpU9l+Y4nlt1pPMf2LziQoeo4
         mzOOZz6ubVXFPHbRp1NhiIIC8j37lOrdW/5mp/mbSeMb+qMeHOHI/msiQM01ZDRlI50N
         9aTaZvBrgGxzLbkG4jxaKZLaCmrI3ciUG8MQRVUvhPuOQftis2jwJcNCaOpVQnW8jFbj
         26og==
X-Forwarded-Encrypted: i=1; AKwUvBzrpn3zuVDt+jXl6PZnG+CcVJPu1IttLFtMmU48tjP3isDWdqQUxyOelSvXgebAgBaoXQ8CIxU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUp64HHXpOV/6e6KKNxN4UKOrD/MlkMP36eB8JLwLlwQLE20D6
	O6JyeYG8YkMS1aDPzsTj0biMMgz4i+FQ10JOC2wRS+YbaD1mDCw0Vbo=
X-Gm-Gg: AYBFou0hnAiVL8kb9XMFoSXflwXU4zbMlmX9ES5lP7WPppWBaGlkGZ691hRCvpCL1bL
	s4LddYEcdwcJWf35WhdpuVIo0WPyGrMoCfjBegFQoDXeFM+I/fYgaTq7XvBszBVE8PBDkoTh0XJ
	SVs7dV0dzX3uHeSM+DeKXNV5VeBHnh0uxWr7yQSVzEo/oN7BV2tWu0wFWpzeALK9HlbbDS0pMGj
	BmSaw4foBg3frfL4do2xnq+b50KDtkpnGGQ46CUcesOsO4M83gykTH8dzrR/q3auZW/YhXixRgj
	q+roVSS6AWGf6HW+qKTqOgYRsZ+YMBg0xawhS6hSeDPNtlDacD5IJvaiMevWOHZjVdLXqNiiseV
	hFl7MTs1+L4ET5n0mV6NuULCwMCY69q5ocM2eDToEkxAU0usprsv1i4r42Mhm/AikhidKcvfXb1
	JRJWnSmDczNSSKZwjWFY+G7fWM0PLj+gEaiJxoS/K/Ev/A63yji5z0cGaXqw0gca1Ygi57FdxFL
	FbL72MFX5SPW4knlbXPLsZUO64dUMKf0D1sEAATZMjMjKMm5eWRAjjYYDgf6Wfa17I4Sb8rEqQF
	3iX81dTDTganxwLD6QfTp47x3AhBCBRU
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4ac14ec66d9mr69100685e9.2.1793379051197;
        Fri, 30 Oct 2026 09:50:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm94366765e9.12.2026.10.30.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:50:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v8 2/2] RDMA/rxe: copy send WQE to kernel buffer in completer path
Date: Fri, 30 Oct 2026 16:50:44 +0000
Message-ID: <20261030165044.2799619-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030165044.2799619-1-tristan@talencesecurity.com>
References: <20261030165044.2799619-1-tristan@talencesecurity.com>
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

The completer reads send WQEs from the same userspace-mapped shared
queue as the requester. Even after the requester copies the WQE to a
kernel-private buffer (previous patch), the completer still reads
directly from shared memory, leaving it exposed to the same TOCTOU
races.

Fix by copying the WQE in get_wqe() to a completer-private buffer
using the full queue element data size. The local copy is reused
when the same WQE is being processed with unchanged state, which
preserves DMA progress across multi-packet RDMA READ responses.
A fresh copy is taken when the state changes or a new WQE appears.

After copying, reject invalid opcodes (above IB_WR_REG_MR), out-of-
bounds num_sge, and invalid cur_sge by transitioning the QP to error
state through COMPST_ERROR. This prevents OOB SGE walks in copy_data()
from corrupted DMA indices.

The state read from the shared queue is preserved via smp_load_acquire()
and restored after the memcpy to prevent a concurrent userspace write
from overwriting it with a stale value.

DMA progress (resid, cur_sge, sge_offset) is written back alongside
completion status and rd_atomic state on completion and before retry
invalidation, ensuring retries can resume from the correct offset
rather than restarting from zero.

The cache is invalidated on QP reset, when a completion advances to
the next WQE, on error retry, and on RNR retry to ensure fresh state
after the requester retransmits.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes since v7:
  - Write back DMA progress before invalidating completer cache on
    error retry, so req_retry() resumes multi-packet reads from the
    correct offset (sashiko finding).
  - Invalidate completer cache in COMPST_RNR_RETRY to prevent stale
    PSN comparison after RNR timer fires (sashiko finding).

Changes since v6:
  - Fixed all sashiko review findings (2 Critical + 9 High).
  - FORTIFY_SOURCE: memcpy into enclosing struct, not inner member.
  - Copy size: max(max_sge * sizeof(ib_sge), max_inline).
  - Opcode bound: IB_WR_REG_MR (was IB_WR_ATOMIC_WRITE).
  - Validate num_sge + cur_sge, preserve smp_load_acquire state.
  - DMA progress writeback (resid, cur_sge, sge_offset).
  - *wqe_p = NULL for posted state, invalidate on retry.
  - Addressed Zhu Yanjun review feedback.

Changes since v5:
  - Added opcode bounds check and num_sge clamp after copy.

Changes since v4:
  - Resent from the correct sender address.

Changes since v3:
  - Copy full queue element (max_sge SGEs) instead of per-WQE size.
  - Invalidate on QP reset, ERR flush, RESET state check.

Changes since v2:
  - WRITE_ONCE/smp_store_release for field writeback.

Changes since v1:
  - Split into per-path patches. Cache across multi-packet ops.
 drivers/infiniband/sw/rxe/rxe_comp.c  | 75 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1390e861bd1d7..b8bc710dc75e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -137,22 +137,87 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 	rxe_sched_task(&qp->send_task);
 }
 
+/* Write back completer WQE fields to shared memory */
+static void rxe_comp_writeback_wqe(struct rxe_qp *qp)
+{
+	struct rxe_send_wqe *shared = qp->comp.shared_wqe;
+	struct rxe_send_wqe *local = &qp->comp.comp_wqe.wqe;
+
+	if (!qp->comp.comp_wqe_valid || !shared)
+		return;
+
+	WRITE_ONCE(shared->status, local->status);
+	WRITE_ONCE(shared->has_rd_atomic, local->has_rd_atomic);
+	WRITE_ONCE(shared->dma.resid, local->dma.resid);
+	WRITE_ONCE(shared->dma.cur_sge, local->dma.cur_sge);
+	WRITE_ONCE(shared->dma.sge_offset, local->dma.sge_offset);
+}
+
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
 				      struct rxe_pkt_info *pkt,
 				      struct rxe_send_wqe **wqe_p)
 {
 	struct rxe_send_wqe *wqe;
+	u32 state;
 
 	/* we come here whether or not we found a response packet to see if
 	 * there are any posted WQEs
 	 */
 	wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
-	*wqe_p = wqe;
 
 	/* no WQE or requester has not started it yet */
-	if (!wqe || wqe->state == wqe_state_posted)
+	if (!wqe) {
+		*wqe_p = NULL;
 		return pkt ? COMPST_DONE : COMPST_EXIT;
+	}
+
+	/* Pairs with smp_store_release() in rxe_req_writeback_wqe() */
+	state = smp_load_acquire(&wqe->state);
+	if (state == wqe_state_posted) {
+		*wqe_p = NULL;
+		return pkt ? COMPST_DONE : COMPST_EXIT;
+	}
+
+	/* Reuse existing local copy if still processing same WQE
+	 * with unchanged state (preserves DMA progress for multi-packet ops)
+	 */
+	if (qp->comp.comp_wqe_valid && qp->comp.shared_wqe == wqe &&
+	    qp->comp.comp_wqe.wqe.state == state) {
+		wqe = &qp->comp.comp_wqe.wqe;
+		*wqe_p = wqe;
+		goto check_state;
+	}
+
+	/* Copy shared WQE to kernel-private buffer.
+	 * Copy size matches the queue element data area.
+	 */
+	qp->comp.shared_wqe = wqe;
+	memcpy(&qp->comp.comp_wqe, wqe,
+	       sizeof(*wqe) + max_t(int,
+				qp->sq.max_sge * sizeof(struct ib_sge),
+				qp->sq.max_inline));
+	qp->comp.comp_wqe_valid = true;
+
+	/* Preserve the state we observed via smp_load_acquire()
+	 * since memcpy may have overwritten it with a stale read.
+	 */
+	qp->comp.comp_wqe.wqe.state = state;
+
+	/* Reject corrupted opcode or SGE indices, error the QP */
+	if (unlikely(qp->comp.comp_wqe.wqe.wr.opcode > IB_WR_REG_MR) ||
+	    qp->comp.comp_wqe.wqe.dma.num_sge > qp->sq.max_sge ||
+	    (qp->comp.comp_wqe.wqe.dma.resid &&
+	     qp->comp.comp_wqe.wqe.dma.cur_sge >= qp->sq.max_sge)) {
+		qp->comp.comp_wqe.wqe.status = IB_WC_LOC_QP_OP_ERR;
+		wqe = &qp->comp.comp_wqe.wqe;
+		*wqe_p = wqe;
+		return COMPST_ERROR;
+	}
+
+	wqe = &qp->comp.comp_wqe.wqe;
+	*wqe_p = wqe;
 
+check_state:
 	/* WQE does not require an ack */
 	if (wqe->state == wqe_state_done)
 		return COMPST_COMP_WQE;
@@ -454,6 +519,8 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (post)
 		make_send_cqe(qp, wqe, &cqe);
 
+	rxe_comp_writeback_wqe(qp);
+	qp->comp.comp_wqe_valid = false;
 	queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
@@ -788,6 +855,8 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
+					rxe_comp_writeback_wqe(qp);
+					qp->comp.comp_wqe_valid = false;
 					qp->req.again = 1;
 				}
 				goto done;
@@ -809,6 +878,8 @@ int rxe_completer(struct rxe_qp *qp)
 				 * rnr timer has fired
 				 */
 				qp->req.wait_for_rnr_timer = 1;
+				rxe_comp_writeback_wqe(qp);
+				qp->comp.comp_wqe_valid = false;
 				rxe_dbg_qp(qp, "set rnr nak timer\n");
 				// TODO who protects from destroy_qp??
 				mod_timer(&qp->rnr_nak_timer,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 77606c4a039b1..450254a131017 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -582,6 +582,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	qp->req.wait_for_rnr_timer = 0;
 	qp->req.noack_pkts = 0;
 	qp->req.send_wqe_valid = false;
+	qp->comp.comp_wqe_valid = false;
 	qp->resp.msn = 0;
 	qp->resp.opcode = -1;
 	qp->resp.drop_msg = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a22dfc6e5ae3c..6205dbc29dff6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -130,6 +130,12 @@ struct rxe_comp_info {
 	int			started_retry;
 	u32			retry_cnt;
 	u32			rnr_retry;
+	struct rxe_send_wqe	*shared_wqe;
+	bool			comp_wqe_valid;
+	struct {
+		struct rxe_send_wqe	wqe;
+		struct ib_sge		sge[RXE_MAX_SGE];
+	} comp_wqe;
 };
 
 /* responder states */
-- 
2.47.3

