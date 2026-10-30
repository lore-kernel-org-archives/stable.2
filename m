Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385254;
	b=K9wCHdL0a1aoapwZySa7wS3w/5cemnO3YnAleCGTe/HPZuI/GJ9NgKMfdMh5gZaf9g4g
	 ImjqlgLcxb5Gh2ly39ncn10cDPvvNGxmwvuH1728NgmE/LNrLBHaMXcKxsEsFbAqF1qQx
	 rmL35t1ezE11fnDVsgkq1qr8P2FS3OIBR/O8vveZJo9ae0M1XPQeV06MCzOjxEw9Pyb9S
	 pp+CRv184+SlJNYzPKDk5Es33hxSHQ3fgBhnBM8mSGnG73ecKh9SkaVC3MjFyiBunrDmw
	 RATkye7OqD6W6O6uUqP7edyk+lx2hfgBUOPg7d78lBPA+HXEs4ufCF8B/LFWzCdzTsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Aur5CvG/rrs86OAInMddXi3+JvGSE98Vw4EUj9Sc8zo=;
	b=ZSRKe8ZvmzdIxJAwvOLYBGctopRdQAtG/jVe4AO/a1/WVbUdS+xDmL9VYY3eAwwEalTV
	 1K8FFf7js/saZlHORX75Ayvmqx42hXA09jfyaLVXe5MVRVdzTaEKiSIOKdFPsVkS7anNc
	 k/RjMxNu8+pd9DtKIqKQycdziV31fIDRcJ5Z2fKpQNiun9nrfVgDKBo/2FP0z/3c6qcIZ
	 RvvcDD/eeY2GHMbtESyUNZflraODW/2cikteaveeZ2NksZREkurcLz2cDtkCBPoKkiVuB
	 fw9hgRumZ/3jt4ALyp094e9pJRMS5V8iB62G/9XF3AssRvX0+1kjAraHmzx91OSXSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wql+O7Fd;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844E606A326
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B844E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wql+O7Fd
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so11936185e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385252; x=1793990052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aur5CvG/rrs86OAInMddXi3+JvGSE98Vw4EUj9Sc8zo=;
        b=Wql+O7Fd33raBYJVBcOmWlXMCiBVxIbImiYQWW5+PTLI9DRhj4KNXjfq9fysUX0pMc
         3mTxshn63HDK719pYVMFygsipkUNODiEd9m3G2i8Q0ZByc0eEOFaMr7ws76nGaMLuuQn
         dqH/iGLpIqs7yaEsvwAUM3NM+nVJAVRbIGgzFDyfk1A6uUM+RZjyENqHsBakzUKKX7Xg
         ILQNqv/hVDPI5OrMeYYtAzj74gd52GjxdBp5tzsCSKz6jODFG0SgIglyV2lSnWzBSNM5
         BpRUjIFV+Rz/o1K/gCdH+R27gUUGQHJTjN4kLGF1qA432P6WPJzW+HRIHRT3qHvmB4fv
         xCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385252; x=1793990052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aur5CvG/rrs86OAInMddXi3+JvGSE98Vw4EUj9Sc8zo=;
        b=0ba2kAPhsWljxHyVH/IyEuhWoeSdCQ+n1MBiDq5JLyavtSh9UlS0nZyW27rFJbo7jd
         GqCn6j902UWe1NdQoi5F4LHc/9f0//XKLosQ47r5VcJ3bIQumDubnUKraZiLa1HpNSXy
         nFmlaE1rlbUyBkri0M1GNJv1qZj5WiI1xriYJfLrL278gdcaPh+8ONGaoFpGfqlkcqa2
         JedlHtjlt477R9exEnsdeGEuMEMXpJHB8p6gzP+bzcbZT44N2RAwFVqyCjEBS7HlZ3ve
         4Se/FZEHQde9LmRsGEYrEZIIb5nbPwT9koXi8zhncyaemntywIz8M7M5SBbBvljnqzSH
         NU6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzRi0mnPSV2+AWR4PBugAXTA8FY1sIiXzjNSCd/LMC4BRQ3iThTvwlgD/QfrqWmrk+811naduM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6bYHgO+lf/xKBrccY9zKnN1Vg/aYjSvQGKDZMSEeajAxoMX7K
	riNVQKSqHFwfcV3G71WiguNNZAjqclg7NYUTAx28hgknAWTskTnKu70=
X-Gm-Gg: AYBFou1LDteGCemLPz2loDu4gEL9nAxg1U/JkTvGNxgIB+ecBGgCfUQ9cHyL90Tu2jP
	I+kE/FlqDrCzxU4e5Fn2j6mM3SNZi+4N3FFkUig25QYLppcBBKv4QFoaeR8ythBsQNlp0VBTE+2
	LkfBltO+9YQ3PDkIerApr6tLaw1nWxmS20QRFBjnC117kGRxs3wQH7PZtmBTzs1J4Bnr7lx6JCc
	/pVYkxn87x3n8U+aFgvWTvNogE68PNSowawepl23gHuUXjMRzukKcdPhJquhYIVb9V/bH8SSOAl
	EGaWL8VG0QaqCTRV8kPlam9LBgpR4fSQpibwaArqUOVs+13T57cOu1gWUQB4Rf8fY7RnbkLiE18
	zhirPJhUCra8+MANe+OTrbBk8cvhqoTwMsrJ5VPUBjSvZEgljV/utI2qRMAd9zcfOqRN9Qa9wGH
	yGTnmnN4KEqjrE71gEVYzI8th2eaXXWtO78jVtoatjXWUZwiDrCkieaTstfyufQD5bdQ1C0eTkY
	SbFm/AvG0eLvh0gzOYMyhb4emnCnFRfl7Q7q2+NYrB8NeE73KuehdnjX+hsrTmgoPlU34taSZWr
	5v2xJfBkvtc=
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id 5b1f17b1804b1-4ac151a9077mr78689535e9.1.1793385251866;
        Fri, 30 Oct 2026 11:34:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm114204175e9.12.2026.10.30.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:34:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v9 1/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Fri, 30 Oct 2026 18:34:08 +0000
Message-ID: <20261030183409.195671-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030183409.195671-1-tristan@talencesecurity.com>
References: <20261030183409.195671-1-tristan@talencesecurity.com>
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
(max of max_sge SGEs and max_inline bytes) so that both SGE entries
and inline data are always captured.

After copying, reject out-of-range opcodes by setting mask to 0 so that
next_opcode() transitions the QP to error state. Clamp atomic write
residual to sizeof(u64) to prevent finish_packet() from reading past
the WQE buffer. The WR-level mask (WR_ATOMIC_WRITE_MASK) is checked
since wr_opcode_mask() populates wqe->mask from enum rxe_wr_mask.

The local copy is reused across multi-packet sends to preserve DMA
progress state (cur_sge, sge_offset, resid). Field updates including
DMA progress are written back to the shared queue using WRITE_ONCE()
for individual fields and smp_store_release() for state transitions,
so the completer and userspace observe consistent values without the
tearing risk of bulk memcpy(). DMA progress writeback ensures retries
can resume from the correct offset.

The copy is invalidated when the WQE index advances (last packet sent,
error, local ops, UD oversized), when a retry resets WQE state, on QP
reset, or when the QP enters error state for flush. Retry invalidation
also clears the completer WQE cache so the completer re-reads from the
shared queue after the requester retransmits with updated PSN bounds.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes since v8:
  - Fix atomic write resid check: use WR_ATOMIC_WRITE_MASK (WR-level
    mask) instead of RXE_ATOMIC_WRITE_MASK (packet-level mask) so the
    condition actually fires for IB_WR_ATOMIC_WRITE WQEs (sashiko
    finding).
  - Fix atomic write rejection: clamp dma.resid to sizeof(u64) instead
    of setting mask to 0, since next_opcode() ignores wqe->mask and
    uses wqe->wr.opcode directly (sashiko finding).
  - Invalidate completer WQE cache on retry so the completer re-reads
    from the shared queue after the requester retransmits with updated
    PSN bounds (sashiko finding).

Changes since v7:
  - Reject atomic write WQEs with oversized dma.resid to prevent
    OOB read in finish_packet() (sashiko finding).

Changes since v6:
  - Fixed all sashiko review findings (2 Critical + 9 High).
  - FORTIFY_SOURCE: memcpy into enclosing struct, not inner member.
  - Copy size: max(max_sge * sizeof(ib_sge), max_inline).
  - Opcode bound: IB_WR_REG_MR (was IB_WR_ATOMIC_WRITE).
  - Removed silent num_sge clamp, use mask=0 for invalid opcodes.
  - DMA progress writeback (resid, cur_sge, sge_offset).
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

 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 72 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 3 files changed, 74 insertions(+), 5 deletions(-)

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
index 24f5c044363f7..f2524b179daec 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -161,6 +161,26 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
 
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
+	WRITE_ONCE(shared->dma.resid, local->dma.resid);
+	WRITE_ONCE(shared->dma.cur_sge, local->dma.cur_sge);
+	WRITE_ONCE(shared->dma.sge_offset, local->dma.sge_offset);
+	/* State must be last so the completer sees prior updates */
+	smp_store_release(&shared->state, local->state);
+}
+
 static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
 {
 	struct rxe_queue *q = qp->sq.queue;
@@ -193,7 +213,35 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 
-	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
+	/* Reuse the existing kernel-private copy if still valid */
+	if (qp->req.send_wqe_valid && qp->req.shared_wqe == wqe)
+		return &qp->req.send_wqe.wqe;
+
+	/* Copy WQE from userspace-mapped shared queue to kernel-private
+	 * buffer. Copy size matches the queue element data area.
+	 */
+	memcpy(&qp->req.send_wqe, wqe, sizeof(*wqe) +
+	       max_t(int, qp->sq.max_sge * sizeof(struct ib_sge),
+		    qp->sq.max_inline));
+	qp->req.shared_wqe = wqe;
+	qp->req.send_wqe_valid = true;
+
+	wqe = &qp->req.send_wqe.wqe;
+
+	/* Prevent OOB in wr_opcode_mask() for corrupted opcodes.
+	 * Mask 0 causes next_opcode() to fail, moving QP to error state.
+	 */
+	if (unlikely(wqe->wr.opcode > IB_WR_REG_MR))
+		wqe->mask = 0;
+	else
+		wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
+
+	/* Atomic writes carry exactly sizeof(u64) payload.
+	 * Clamp oversized resid to prevent OOB read in finish_packet().
+	 */
+	if (unlikely((wqe->mask & WR_ATOMIC_WRITE_MASK) &&
+		     wqe->dma.resid > sizeof(u64)))
+		wqe->dma.resid = sizeof(u64);
 	return wqe;
 }
 
@@ -582,9 +630,13 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
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
 
@@ -634,7 +686,9 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	wqe->state = wqe_state_done;
 	wqe->status = IB_WC_SUCCESS;
+	rxe_req_writeback_wqe(qp);
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
+	qp->req.send_wqe_valid = false;
 
 	return 0;
 }
@@ -666,6 +720,7 @@ int rxe_requester(struct rxe_qp *qp)
 		wqe = __req_next_wqe(qp);
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		if (wqe) {
+			qp->req.send_wqe_valid = false;
 			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
 		} else {
@@ -681,6 +736,7 @@ int rxe_requester(struct rxe_qp *qp)
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
 		qp->req.wait_for_rnr_timer = 0;
+		qp->req.send_wqe_valid = false;
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		goto exit;
 	}
@@ -695,6 +751,8 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(qp->req.need_retry && !qp->req.wait_for_rnr_timer)) {
 		req_retry(qp);
 		qp->req.need_retry = 0;
+		qp->req.send_wqe_valid = false;
+		qp->comp.comp_wqe_valid = false;
 	}
 
 	wqe = req_next_wqe(qp);
@@ -772,10 +830,12 @@ int rxe_requester(struct rxe_qp *qp)
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
@@ -839,8 +899,10 @@ int rxe_requester(struct rxe_qp *qp)
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

