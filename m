Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4F3DDDBC
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877080; cv=none; b=CoEE7gdSAXaW+fewHVK3AE4rEembVI4w/HEu9/5+vNDpIlFYexweQ+p/eu4yLs2m+GXafnfsfigxqkPQfagQhzyjxdtt1rqRKNBuUC9Kx2hyhGqxlo3L68Cryhbitbyg5UesbL6wmTC/c2WK0MTqxtkQBEvmQbJIE+cVXYYW7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877080; c=relaxed/simple;
	bh=B8xt2aRjgIyKHTL5QjbEygYyp7ffBNR+s3cJP+JWq3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQY1mtOSkxa1FH4ooJxvM4j/bDDA/BjkKd30jiCpEb6zB4Bh51JCM29ycTW+5zG4PYOxWig8eVLGjqNLdUFpcubu4odYyCbu8/kDZuOSnRrq9PhFY8WllkonaNwxggsl4t986YJIKCV+TIlAV5k7J+0q94qPn29fkk/R8mKQOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrEMsVnb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrEMsVnb"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so31430175e9.2
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786877077; x=1787481877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYbAVM/ImnipLBuIpWK5gcgeKSfoNpq0fNF/pO1kB7s=;
        b=qrEMsVnbZrU4Sd+jNwzzlogUxt+UjEAdBMlBA3GFf99niNW+Xj063zY1JRsEmKM1Sk
         6r41XI9l7U6IHfrpioDySg+hZsTPWn8A2A0rysTxp/teKm2ZC2BVv9Stse+u+HNLOlOm
         VxtUMrJXzDXa9P0aeZ+AhqKqn1eKKHL2L3Nd1ki06hbKOTiemRMt3zjiUeW5k+Y+iI/Q
         07l6IrpcDmsqGoF9YMw2RsEpQjx5cOeTMI0KI9M8Vp16LTE0wjMNrn7rKrNLrzZ/FJKV
         YsLiK3+nPJT9WfKINsKCBntzwvWzR8fD+XC5fAh8SzReROaOAOJDG9WWerP7fsAIkLra
         KbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786877077; x=1787481877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hYbAVM/ImnipLBuIpWK5gcgeKSfoNpq0fNF/pO1kB7s=;
        b=WD64EWw1yJ+HzeD1A472St1cfONloHGEudKVEt+cG8qcl4jiMRh4z1W8ieTvTeHt24
         4okbp9FqqIaWf2U+mSpB0V0UW4cmpmQJL1rzaj0Sb6zCXKWvyNNrx8XsHYCzOsi/IvQ0
         +sPf8UpUIEx3u7qO8sKiB3GI3Qo12k0scD6CCHdFYVa3OGVkccTjV3z1EZtWTI7O8LRv
         zgEwuRvEq7r8vfWPPGqKYUkmRZ9VuEVGxQB3/sSoKXgT4d3u45KWZ9ZwKW1VlBkRhf7+
         J1iBGsyie0WW1IXJOi+coLwOhDH3zVoViR80yMrHNv7WJ5nPJobmngmZbyO9huXjVgg/
         dcCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+806kINMsoUSg3+VtSjzJPjuT2eYm3eq8+mqd4N8E68koFtJ7K4YD7g7DVa4cSaZYN01wL7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lyb+HlBHjnY35lX4odVo1YXUSSyiKRv8x9Rwi3prDxxBoRvd
	vJJZEI55XM9CdFUC4LMspZriSFoIM+hHj1T1VRYSi/ElAXJEzjgoDE8=
X-Gm-Gg: AR+sD11PCiDOqlht4PalHUQWvQijZJvan3S2HLGB5WiA7KKLgQHymu0Ub17PncryzNG
	mls4SPQrwyvjueyiPmB7pFMCGOniI4PbWrsV0ABKj7HL9EYkFDrZs6dueXR5hRoN/THT5mwklaz
	UoG4bDrkV8v5y/6zB0AjKHrF1LQAFrim6JwIayHGfAcuR0fhHa0Y7e8jBvQd2zIqcXY1OzwofA8
	VfLT7IHbk7CXn5AgIBHBOR6hpgU9oo67KN/ObRtS5y13CDYD/AAqembXiv5fPzyjdWivEeIxGYb
	+oLV5puYhhWiQurF9ImKjtFvj0+xO51+03r3/0KMDH1mbWP/m0DzISaUzAaQwxm3tE/WZktuHuy
	+ug7oC3LTLiO+E93PoHS4q8e8Ou4M9ARAC2b6g2U1mFcrywW7fO5nDdw+eKqHgOj88ufiFfEan2
	h//jaEjem19MZ12CmdRKW2vGUuhWobhw==
X-Received: by 2002:a05:600c:870c:b0:499:8a3a:fd3a with SMTP id 5b1f17b1804b1-49991099160mr150681915e9.5.1786877077313;
        Sun, 16 Aug 2026 03:44:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm54841945e9.8.2026.08.16.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:44:36 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moni Shoua <monis@mellanox.com>,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/2] RDMA/rxe: copy completer WQE to kernel buffer before processing
Date: Sun, 16 Aug 2026 10:44:32 +0000
Message-ID: <20260816104432.849996-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816104432.849996-1-tristmd@gmail.com>
References: <20260816104432.849996-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The completer reads WQE fields (dma.num_sge, dma.sge[], dma.cur_sge,
wr.opcode, first_psn, last_psn, state, status) directly from the
userspace-mapped shared send queue via queue_head(). Userspace can
modify these fields between completer reads, causing inconsistent
state in do_read() and do_atomic() which call copy_data().

This is the completer-path counterpart to the preceding patch which
fixed the requester path. Although rxe_sender() calls the requester
and completer sequentially (not concurrently), the requester may have
already advanced wqe_index and invalidated its kernel-private copy by
the time the completer processes the READ/ATOMIC response, so the
completer needs its own copy.

Fix by:
 1. Adding a kernel-private WQE copy buffer (comp_wqe) to rxe_comp_info
 2. Copying the WQE from shared memory in get_wqe() before any
    processing, with num_sge validation against qp->sq.max_sge
 3. Writing back status/state changes to the shared queue entry in
    do_complete() so CQE generation and retry logic see the correct
    completion status

The flush_send_queue() error path is not modified as it runs during
QP teardown (ERR/RESET state) and does not call copy_data().

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 36 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 ++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1390e861bd1d7..0f647721a657e 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -142,16 +142,40 @@ static inline enum comp_state get_wqe(struct rxe_qp *qp,
 				      struct rxe_send_wqe **wqe_p)
 {
 	struct rxe_send_wqe *wqe;
+	unsigned int num_sge;
+	size_t copy_size;
 
 	/* we come here whether or not we found a response packet to see if
 	 * there are any posted WQEs
 	 */
 	wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
-	*wqe_p = wqe;
 
 	/* no WQE or requester has not started it yet */
-	if (!wqe || wqe->state == wqe_state_posted)
+	if (!wqe || wqe->state == wqe_state_posted) {
+		*wqe_p = NULL;
 		return pkt ? COMPST_DONE : COMPST_EXIT;
+	}
+
+	/* Copy WQE from userspace-mapped shared queue to kernel-private
+	 * buffer. Userspace can concurrently modify DMA state (num_sge,
+	 * sge[], cur_sge), leading to inconsistent state in do_read()
+	 * and do_atomic(). This is the completer-path counterpart to
+	 * the requester-path fix.
+	 */
+	num_sge = wqe->dma.num_sge;
+	if (unlikely(num_sge > qp->sq.max_sge)) {
+		rxe_dbg_qp(qp, "invalid num_sge in send WQE (comp)\n");
+		memcpy(&qp->comp.comp_wqe.wqe, wqe, sizeof(*wqe));
+		qp->comp.comp_wqe.wqe.status = IB_WC_LOC_LEN_ERR;
+		qp->comp.shared_wqe = wqe;
+		*wqe_p = &qp->comp.comp_wqe.wqe;
+		return COMPST_ERROR;
+	}
+	copy_size = sizeof(*wqe) + num_sge * sizeof(struct rxe_sge);
+	memcpy(&qp->comp.comp_wqe.wqe, wqe, copy_size);
+	qp->comp.shared_wqe = wqe;
+	*wqe_p = &qp->comp.comp_wqe.wqe;
+	wqe = *wqe_p;
 
 	/* WQE does not require an ack */
 	if (wqe->state == wqe_state_done)
@@ -446,6 +470,14 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_cqe cqe;
 	bool post;
 
+	/* Write back status to the shared queue entry so the CQE
+	 * and any retry logic sees the correct completion status.
+	 */
+	if (qp->comp.shared_wqe) {
+		qp->comp.shared_wqe->status = wqe->status;
+		qp->comp.shared_wqe->state = wqe->state;
+	}
+
 	/* do we need to post a completion */
 	post = ((qp->sq_sig_type == IB_SIGNAL_ALL_WR) ||
 			(wqe->wr.send_flags & IB_SEND_SIGNALED) ||
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a22dfc6e5ae3c..f1d647ddc1e05 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -130,6 +130,11 @@ struct rxe_comp_info {
 	int			started_retry;
 	u32			retry_cnt;
 	u32			rnr_retry;
+	struct rxe_send_wqe	*shared_wqe;
+	struct {
+		struct rxe_send_wqe	wqe;
+		struct ib_sge		sge[RXE_MAX_SGE];
+	} comp_wqe;
 };
 
 /* responder states */
-- 
2.47.3

