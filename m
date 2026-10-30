Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388766;
	b=5CvaxTSOA4CmI3Kp45XNKndUQesxtn6gUuTyDwpTuC3eb8uzc1CdSZ76ETi80OTaiyLc
	 ns+ZFhoLBuh6w5KKMelKOvqM+TVfoPlBwCwyBfeqrcsTa8kmFPX7y54Xe4Ry7FMjADA0V
	 uwBvz5dZk2Gjez/Y8pim+YPHCNDrtL/St5U2O6BirqXGm0doKsbdksCMMUJt/seLYRdBr
	 SVHosCXygwvsEC0Hk2B4eDPyP6CfyWnJ39IRxzorHTlJuzCmovqw3pUG1NvKysUn8EU4h
	 r2PDRG04JHplKQKXO1WnevbnS/2G3yhiy9JaXlE91oVGCyxKihwlHU2eaJ6sopo23qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UBWddIU4VOdyo92IdAkPdEqsKaAU9G+Z2dZjBcQLsHU=;
	b=vrX4wFrF+jVFvjTiX2bOmPCdCUY7gEJXC1ZvjHDqeu3yX10OJ9b4hFabTF+U0kCyj78r
	 NLRMsZj94lAmbhIZ6bw7DrMdGYOeZqQ4Wi1QgOwR6eVLBerqQpu+t0ug7uwnr73JVSolz
	 R0wM/Y1BEbZJasYkNtpKaJTxJdnfwTAyNWVz8qIZrd9qr2u41iNkO7pQmzq+/XH1BW39h
	 11hkhlJ5xqHSe4r58UWit7bh+LJtNudU8fm/HyqGr78YR9smDq3U415X9cyeNP1BAHF3+
	 X5C8mxC7n85wFTLaI1MMB5fu/APLGLnJrKDfsEQQ3UG047UKwV1o0uRlk8MjHF8JqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NfubqUkT;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4D606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A4D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NfubqUkT
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so10807835e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388764; x=1793993564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBWddIU4VOdyo92IdAkPdEqsKaAU9G+Z2dZjBcQLsHU=;
        b=NfubqUkT8dMP4qd+Qg6UjrqgwN2JNWm4RSEP8LahGoehducgJ5OsnydioTkTx6pNsR
         iUSw7M15ld0Sx0Iaxh4K1C/Lex0pwTBq8mHsZhHrrvpEAGRQljENn95fqu0WUaNzMmKl
         SyDKDmR/KzsfQGw8NstXwASGrEY27I/Wflk9JCdpmgGM91i7EVE2uwrlo5ujomxARRZB
         SHuY8/oMKdBsigiEi4igzTekwqTC0fTm2tQo4ef6yBDbDGbx/7m6zOKmRjWpZaovDUxr
         VZ6egidwvZG1XVuRmXBUDwpt7L3cIUTROehoqnTlJK82RlqVie6D30J5MGEJr5oUDB8K
         KarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388764; x=1793993564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBWddIU4VOdyo92IdAkPdEqsKaAU9G+Z2dZjBcQLsHU=;
        b=Kp4RYoTuzseRq+DFw4wTrv8KAFXcbspSyeo/+zlPQshnhM2rCMXzAU5T0zqR62ZYGz
         0qEyGRUJkEoZvuDreg34d1O/t+QMJ96n7CPJ+8AFPni7cs4CXo9byG4W1ZUaD1C8iSua
         +5KiKdBwIupEkpmAY5KliiBw62aGrko1Zu7/FGXVT0EudLmJAP4lXvjJu9F6FlQiJ99a
         54oYexVJdngqTwrlMWgII5+mHcp6f4POYBYBBY5lvJmKju/Razyeuwu9CBlQnfGOBHVl
         vpJXTBxIPwynCHiqBi/GZVxK1K2CVhnI0oATTcK7sRUaVCAm8rDA/bEDhqLHCEA9yp/V
         cQ1A==
X-Forwarded-Encrypted: i=1; AKwUvBwAzXHkzH3abwWbHY1fsPjdH0V5RLfDmgLCqDXM41ebrN8ZCoN9cY5y+HtvWys8lVOb12xfbS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYId9YTYeS/bc1du+IWYzWbC8k1gEzfsAl6bEzv+ebHa52UsiCwT
	0aGl0w5Qr47/VesTV7+Whkf5m0MAuDrgAiaWF7iuTyyfoK8X1zivNLQ=
X-Gm-Gg: AYBFou0pfYaL7EpR5SHDjB211cwjl8/sUPsJGT8DvHI1d+skcHRBfatqzTQYaxmow45
	HNsNX8YQBHurcUmFS06kZYnMdlle+hIOr3LKgpIRrCc6Xl6cNgirItp1rDwylXsm2JwEzvBZwT0
	ccHjLpe+QT5qaGmvXtg+fdw1bIsOpDhxHaFOJmMGy2URM4dxfHncdXg07tOJXNPo12Aozkhbye8
	CuKpLLQgsmY6uCfyKbn6pWrjy7afXcyaNnezBHxVAVMcQ4qxlWr86+eVpiP9q6XvxDbqfJa6oMf
	F1BT11rTste8Z46Bs5NG58TG0idjxEIWGaPj+n/8F+xZ3AkQ5h6nIDzCZL45/fsGg2AyfJtsmC5
	roqvP0k05mBn4FcgGoRI8v+UnotMm0BWx/Vz39NduXdo+0Gxkgk5R80azvJQRoBBVgKUfyVVl6h
	ToUikZUasPkEmw3E3/+Op/frVSDGpLV7m4/9vBbXqvr7qtwHFD5BHFV7Mc+al+MTNhy/isjBQwl
	Mkv7YgTJNnQHL2mahCRaTvwaSNIuMoV1oFmck75tzt4JlWADlnWpSBT7Jm9oSAcDI/hZCY7JTTo
	PI3kkIdqc4M=
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4ac17b2cde9mr83290705e9.7.1793388763971;
        Fri, 30 Oct 2026 12:32:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm4799150f8f.27.2026.10.30.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:32:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v10 2/2] RDMA/rxe: copy send WQE to kernel buffer in completer path
Date: Fri, 30 Oct 2026 19:32:35 +0000
Message-ID: <20261030193235.3470653-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030193235.3470653-1-tristan@talencesecurity.com>
References: <20261030193235.3470653-1-tristan@talencesecurity.com>
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
state through COMPST_ERROR. This prevents invalid SGE walks in
copy_data() from corrupted DMA indices.

The state read from the shared queue is preserved via smp_load_acquire()
and restored after the memcpy to prevent a concurrent userspace write
from overwriting it with a stale value.

DMA progress (resid, cur_sge, sge_offset) is written back alongside
completion status and rd_atomic state on completion, after each
intermediate response packet, and before retry invalidation. The
per-packet writeback in COMPST_UPDATE_COMP ensures the shared queue
always reflects the latest DMA offset, so a forced cache re-read (from
a state change in the shared queue) picks up current progress rather
than stale initial values.

The cache is invalidated on QP reset, when a completion advances to
the next WQE, on error retry, and on RNR retry to ensure fresh state
after the requester retransmits. The requester retry path also clears
the completer cache so the completer re-reads from the shared queue
after retransmission with updated PSN bounds.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes since v9:
  - Bisection fix: move qp->comp.comp_wqe_valid invalidation from
    patch 1/2 into this patch where the field is defined, so each
    commit compiles independently (sashiko finding).

Changes since v8:
  - Write back DMA progress in COMPST_UPDATE_COMP after each
    intermediate response packet, so a forced cache re-read picks up
    current progress instead of stale initial values (sashiko finding).

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

 drivers/infiniband/sw/rxe/rxe_comp.c  | 76 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c   |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1390e861bd1d7..2021e7301c8a9 100644
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
@@ -736,6 +803,7 @@ int rxe_completer(struct rxe_qp *qp)
 				qp->req.again = 1;
 			}
 
+			rxe_comp_writeback_wqe(qp);
 			state = COMPST_DONE;
 			break;
 
@@ -788,6 +856,8 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
+					rxe_comp_writeback_wqe(qp);
+					qp->comp.comp_wqe_valid = false;
 					qp->req.again = 1;
 				}
 				goto done;
@@ -809,6 +879,8 @@ int rxe_completer(struct rxe_qp *qp)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index dd8ad19ed1d86..b226b9cec3a16 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -752,6 +752,7 @@ int rxe_requester(struct rxe_qp *qp)
 		req_retry(qp);
 		qp->req.need_retry = 0;
 		qp->req.send_wqe_valid = false;
+		qp->comp.comp_wqe_valid = false;
 	}
 
 	wqe = req_next_wqe(qp);
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

