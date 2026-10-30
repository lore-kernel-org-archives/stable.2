Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373362;
	b=dorRQpoaM/t6Kv5/dNbyPFbSR+TRDCi6ajCZBa0dOuY0Dn/iQJi4YgpiDoUOE04WuMVV
	 dUfRSZqBGOD+gq/qTR4Cshy4F8BSDITpDRNiQ30lUGtiDNC7pzyGsv/nh6xSv/ROd/Nk8
	 PHBGG6gEam3v5bgf8ledQcOOYc4zPOIuneO1tTsLr8Ad/z2L+enWbLjb7t65fjt3cZYwt
	 9L3dT9wVyHs6nPYwR/6c1TN6PbwVrQsp6EPKOcExyGnGYElUffGIhCNQraE7VesJ0yf2/
	 AnMlSMeiLw8VHJMRPDxoPUnnPT8MVlwXxFGFWUvGCev0YOX5raTtMIVLmrTFf4f3K1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9hy20bYD+vyf+wARFCkoc+n16woByLH6uDkrofMlizc=;
	b=x0J0sqVoN+DX1tQoEbhi50kBxd3EVvjKgBpWrryCTqbAaDDF0L91HyNQw3W71mraNVzK
	 MavH0ZCa6c0lipP0cHavvq+T9hV0XgZhATopvilNijQ8+J+yp/0EQgbfzWbbOOwBCD6pm
	 ch6nm/ssPrf8D8TvHA5DST5EPxfO19H0ktWWwDEcs2Dlfe0nMcy3EL5PFQrgZ0Ff8HB6X
	 PDnOEeGM1NSblcqBDBN4QEIjUR6rmGFel0kupKsPk0R3EIojKupvP/gXWcGd1C7dhcbYz
	 hovX9kBPGaAFgT6f/bO12P4YTnuxZDIRBKAOAW6kBuQQZAMrALkMhttsLm1rm3SAyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhXY0w58;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68D606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F68D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhXY0w58
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso3184029a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793373361; x=1793978161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hy20bYD+vyf+wARFCkoc+n16woByLH6uDkrofMlizc=;
        b=PhXY0w5813QXVIi/xupdkazKBGXzWRtex5lusgRXmsAvdA+0M98fz6BTnyQs4oRVCN
         gDp5aO/jiNcOzQPR2v3VylhnI49HVj4o0+OxQ8mq+QA+Drv3LUVyN79NzO+oJD9O0XMN
         vzBVA/JQ4jZmoRl/cHausJH34fNtKcRjanYKJ/5ELJNUDNqKGxRCoW0nhFZN5PVwYAz2
         /yGuWekO51lFkMz3UCF4K6ox/5nzVhG30bffhiK95u6dkmY2u+zQuKC5ilEJR3h4fRn1
         5tzrdvMock8iMQsLEkKGQPgcyqT8sG3iW7MVjI5htuLf+l+tSVQiSvswIouB3tJIlTtP
         DAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373361; x=1793978161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9hy20bYD+vyf+wARFCkoc+n16woByLH6uDkrofMlizc=;
        b=Xo7hrfwdALFvgv1St164gb6AyVif9ELIdu6aTQ9XDxtbwsPVo22PXfuNZO0lDuiawy
         LBWFOBy2eHtwg1VsrNEGuzvTrWYbkdJOVjc60gcb0omKk7iZ5+n9hIJW9lvBJAftwzmQ
         mmO8NY3j7gHQEGYR5NIrrCnL6jEhoSw4nHOHalPyLITMWXn3MnBgyeRg7y2/iiB0WMRk
         rZOMrrX2lf0EKifvXKhqZWACHfDxPTj+RGIyTe/0Sge4ZwOaEUDuIIob/SUgFtefxmsB
         kJFJGZHSwd4pzWOXrQQQegdNCsSORFmoeC84lSGIt9e5H3qQoUYdF0VaKtIBlMOIMadG
         5Rhg==
X-Forwarded-Encrypted: i=1; AKwUvByTUlvmqMGIEUh/44LeBoUkYTv4mL1o0/d8lQIzUmPAv154dyaAoN9cWsOTv33z46wsd6Gmgek=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd/bAEO2E7kC8MutZwt9Tbnz6ShBFWrlu2zz+VAS5HrsTGMmnU
	JXiqdIvY0ORBiCk19eYx8rBCiHmmXx7oAn1aCA4zQZt+lkdcIFksyKY=
X-Gm-Gg: AYBFou1cfblddEgxYX/yENxSn4g3lHpJMwHFDIhdS+7GZihIYVPOp2duHTf8cME0Tpi
	moDQP3eBzSdXgpp9MAjpRzHDxTzV8nSwtkRpyyMx9qrG43N/5iQgLRoLBVOAp0nzZ7KxE/V+Rf3
	ujPuvv32PGhactCHvRqVo7hGwyhR1dbnR3uWiMKRXVR+pYX0vcJPVx8RZaZnRkBSa9yXWHFSSqI
	CP/odweXyGyJELATAv3oF8ntplNp3d2G/Avqjhsz3AuVziN8eXtnPMOdGYqrofMcVMHqyMkzFD3
	QjVFI2W6kjOcYXdEPrkkFgxe4Fuo1sNcZ8h0PEuZIiOy5MdE/R3k1crT778yyQjYboaxX152kpy
	lJcmhmwh7ZE2+Jb/oZbcucdvqo1JMwwdZXr5SRi/yGspbC+bYD+lhQYjgQe483aGTCNJ/PMm0Xs
	KAj67Eid2+/qJvcIVjhRwfoZIgy+9k6pngOiRsniklDO+kDWBXlhY02Lx1P8cqjSJhRHgUTMb0L
	Xn9PESnkKQr0BoK0UXpkdBtH88jiugl1RH4LYtKShEg8zmi/vVSsPiORfswynMA2Zg4uZxjI48E
	kYZQijupqew=
X-Received: by 2002:a17:907:9803:b0:c31:71f4:819d with SMTP id a640c23a62f3a-c49d14e567dmr530992066b.30.1793373360728;
        Fri, 30 Oct 2026 08:16:00 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae0f4sm3268511f8f.58.2026.10.30.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:16:00 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Bob Pearson <rpearsonhpe@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 1/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Fri, 30 Oct 2026 15:15:56 +0000
Message-ID: <20261030151558.1458444-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030151558.1458444-1-tristan@talencesecurity.com>
References: <20261030151558.1458444-1-tristan@talencesecurity.com>
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

After copying, reject out-of-range opcodes by setting mask to 0 so
that next_opcode() transitions the QP to error state through the
normal error path. This covers all valid opcodes up to IB_WR_REG_MR
while preventing OOB access in the wr_opcode_mask() lookup table.

The local copy is reused across multi-packet sends to preserve DMA
progress state (cur_sge, sge_offset, resid). Field updates including
DMA progress are written back to the shared queue using WRITE_ONCE()
for individual fields and smp_store_release() for state transitions,
so the completer and userspace observe consistent values without the
tearing risk of bulk memcpy(). DMA progress writeback ensures retries
can resume from the correct offset.

The copy is invalidated when the WQE index advances (last packet sent,
error, local ops, UD oversized), when a retry resets WQE state, on QP
reset, or when the QP enters error state for flush.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes since v6:
  - Fixed all sashiko AI review findings (2 Critical + 9 High).
  - FORTIFY_SOURCE: memcpy into enclosing struct, not inner member.
  - Copy size: max(max_sge * sizeof(ib_sge), max_inline).
  - Opcode bound: IB_WR_REG_MR (was IB_WR_ATOMIC_WRITE).
  - Requester: removed silent num_sge clamp, use mask=0 for invalid opcodes.
  - Completer: validate num_sge + cur_sge, preserve smp_load_acquire state.
  - Both paths: DMA progress writeback (resid, cur_sge, sge_offset).
  - Completer: *wqe_p = NULL for posted state, invalidate on retry.
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
 drivers/infiniband/sw/rxe/rxe_req.c   | 64 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 3 files changed, 66 insertions(+), 5 deletions(-)

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
index 24f5c044363f7..f4a258a66485c 100644
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
@@ -193,7 +213,28 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
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
 	return wqe;
 }
 
@@ -582,9 +623,13 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
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
 
@@ -634,7 +679,9 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	wqe->state = wqe_state_done;
 	wqe->status = IB_WC_SUCCESS;
+	rxe_req_writeback_wqe(qp);
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
+	qp->req.send_wqe_valid = false;
 
 	return 0;
 }
@@ -666,6 +713,7 @@ int rxe_requester(struct rxe_qp *qp)
 		wqe = __req_next_wqe(qp);
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		if (wqe) {
+			qp->req.send_wqe_valid = false;
 			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
 		} else {
@@ -681,6 +729,7 @@ int rxe_requester(struct rxe_qp *qp)
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
 		qp->req.wait_for_rnr_timer = 0;
+		qp->req.send_wqe_valid = false;
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		goto exit;
 	}
@@ -695,6 +744,7 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(qp->req.need_retry && !qp->req.wait_for_rnr_timer)) {
 		req_retry(qp);
 		qp->req.need_retry = 0;
+		qp->req.send_wqe_valid = false;
 	}
 
 	wqe = req_next_wqe(qp);
@@ -772,10 +822,12 @@ int rxe_requester(struct rxe_qp *qp)
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
@@ -839,8 +891,10 @@ int rxe_requester(struct rxe_qp *qp)
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

