Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A862423E99
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408464; cv=none; b=YCShM22TaNl/HW8Zub71/qEcDgjdq66tNnIZ5nVk2l2AA0Q9F8XejPY+jeF+sS4ajzHJ8wF+GX62vt/lHbEQvctoUEtkWe65cfzYX/ICCryLMvrDYIcvjIXEzdPOLLTxXxAF16LzBY2NPVOODYqh2Gx5LUTCmmFVJkYU63kw5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408464; c=relaxed/simple;
	bh=LpK3MlRuVJxJxtDhXN32lu/uryl0DBZALWksguoyIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnPufNdrvwF4pY6nIAHe8xI/KfBXsI1O1Rpn1eGbclvMp/YHZxsAQP33QSdYVkFe+Gy7aD4J9qJCReKLWDYxmbBMpCcCsgOAXx6wHGpzEaIk7GL/L+IGGKsadLfr3PHE9S7e4vrtlatd2YFA6jbgwo0yC7yLmt/MB70AJ7byJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFuql5PL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFuql5PL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02718da81so18794485e9.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791408462; x=1792013262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtBP7HWDVtqSxKO/0UtHBQZZgW6BHdDPHdI/ZgBGR9s=;
        b=PFuql5PLgLxtN+P1t7XxG4dZbhte/BwfW7gcXmXTJq81fkfusR/8RmgEYn0g/xWzFM
         3dnk0D9euvw1Uoj0uGwvL2CHIzHK4eRypx6A0i8/Ls9W5Mk/sSGmpPNPNQ0ssoGTkzvK
         IB7VUMTrT3s4vdP/tCC20br7az81OGkDKhVYikrCGg0NKkXOl/LJVgxjlYCaRTxg9uZ5
         YDK2GR91nf8f7rRTm2H1SAz+GjgBKyKRsXoSJJLJuM1jMFfxwOv0Cj/agJmtdSbV/vqI
         0jL/LzMRVw6SHRx7aHajkYgOuu+5nnppoVev3aE2Spz5gnmJcAIeFNF5rBaEh1UDnk1L
         SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408462; x=1792013262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtBP7HWDVtqSxKO/0UtHBQZZgW6BHdDPHdI/ZgBGR9s=;
        b=LprRUuPc5z4tmWQ0gFCL/C4u4UKsDnfoi5wAIBrMRklG4UiAmq2WTpX5y4erC4dvOZ
         +4SSK/e/dvogaFjNCtPutkSao+SIT+CU9pIPdsCWzvRSv/W7igo7qE3YvbQTWvsl83Y+
         gdMkoQf9Lb+4UXy9RPzjs/thqQ8o7GXvb7YnF/JJylChV2eBrFUxI909aS8G7eRIR1B/
         mhM06IsPALLUI8ZTejE0g4g2+wE9mRTXGXuWi0ucJz9x/H3rGrawfPtdwKDgcNeOierF
         xXF8DJazEq3GYex3wCs0xT03fR2CU1vS94w3N1pdkZ4sguo+JLq/F4CZRnkFB2Md/0Wt
         2IwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKcmlNFZrlwutwVZNSEFDAhfN6yTlMNEvxh0j84/HaDuaSGYBMHqbE4W4K/r7TiDpLyiLMoss=@vger.kernel.org
X-Gm-Message-State: AFuF++mX3gfJcelSzJyHFxat7BMlYbC2OC6yiDOOCGVCMXMohnLnYz7x
	NWN/dpv980PvnUdyTSLfoncB6FGIZvGEpTSfpPeCWUGllnbMsI86EpM=
X-Gm-Gg: AYBFou3xiycbKwsw5bSm0bL5WKNI4QelUoqLqydKTQaY1z9WCYAbXK9Q4X/1yGN4dEH
	IfEMe//bdqIcwd5thJOAkRkVpK4+mYhb9tXgRxayzr4+Nth3cmrJXY4jmp+ABEY6OAwxCTfV/d4
	k/rTYkMly/CnSAJmjndgxNMEshBfSd24JngXq6f7fesi2MSuHOQ1AV7RtvAFhVz8xSDAV5oL/AZ
	7Kd1fmnHswaMc8rr3MlhpmlT0HfbkOQvUVc1fo3bJv+3wd9aiQL4DKCzC8C9Psi/92WpwGky/V0
	G4RytFaFOWf/IleydSC67/9i35Y8+RG7U5LJuHtGsMNf5PaTNC0yE+ezGg5yEmq43P4OCtb5PwR
	QsQZRE3CuZIlFWdtkZRzcoU6g3xR2u6vlwLsrqzer/18lZTyqts8FFpM/yfwPJrFYvz+6D0Qscg
	NBYLe0ESrrQ3gBgkCHjQTmQMapU1DeBNwRSekHyD4=
X-Received: by 2002:a05:600c:5254:b0:4a0:1b15:8852 with SMTP id 5b1f17b1804b1-4a180310d31mr58481475e9.16.1791408461660;
        Wed, 07 Oct 2026 14:27:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843cb261sm20466395e9.3.2026.10.07.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:27:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Moni Shoua <monis@mellanox.com>,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/2] RDMA/rxe: copy send WQE to kernel buffer in completer path
Date: Wed,  7 Oct 2026 21:27:37 +0000
Message-ID: <20261007212737.1989004-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007212737.1989004-1-tristmd@gmail.com>
References: <20261007212737.1989004-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The rxe completer processes send Work Queue Entries (WQEs) directly
from the mmap'd shared send queue without copying them to kernel memory.
Userspace can modify WQE fields (num_sge, opcode, PSN values, DMA state)
while the completer is processing them, leading to inconsistent
decisions in check_psn() and check_ack(), and potential out-of-bounds
access in copy_data() via a corrupted dma.num_sge.

This is the completer-path counterpart to the previous commit which
fixed the requester path.

Fix by copying the WQE to a kernel-private buffer in get_wqe() before
processing. The local copy is reused across multi-packet operations
(e.g. RDMA READ responses) when the WQE state is unchanged, preserving
DMA progress across completer invocations. The copy is refreshed when
the state changes (via smp_load_acquire pairing with the requester
smp_store_release) to ensure PSN and other fields are consistent.

Field updates (status, has_rd_atomic) are written back to the shared
queue using WRITE_ONCE() before advancing the consumer pointer, so
userspace observes consistent completion values.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 54 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1390e861bd1d7..f57c4396c28cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -88,6 +88,18 @@ static inline unsigned long rnrnak_jiffies(u8 timeout)
 		usecs_to_jiffies(rnrnak_usec[timeout]), 1);
 }
 
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
+}
+
 static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 {
 	switch (opcode) {
@@ -142,17 +154,52 @@ static inline enum comp_state get_wqe(struct rxe_qp *qp,
 				      struct rxe_send_wqe **wqe_p)
 {
 	struct rxe_send_wqe *wqe;
+	u32 state;
+	unsigned int num_sge;
 
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
 
+	/* Pairs with smp_store_release() in rxe_req_writeback_wqe() */
+	state = smp_load_acquire(&wqe->state);
+	if (state == wqe_state_posted) {
+		*wqe_p = wqe;
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
+	/* Copy shared WQE to kernel-private buffer */
+	num_sge = wqe->dma.num_sge;
+	if (unlikely(num_sge > RXE_MAX_SGE))
+		num_sge = RXE_MAX_SGE;
+
+	qp->comp.shared_wqe = wqe;
+	memcpy(&qp->comp.comp_wqe.wqe, wqe,
+	       sizeof(*wqe) + num_sge * sizeof(struct rxe_sge));
+	qp->comp.comp_wqe_valid = true;
+	qp->comp.comp_wqe.wqe.dma.num_sge = num_sge;
+
+	wqe = &qp->comp.comp_wqe.wqe;
+	*wqe_p = wqe;
+
+check_state:
 	/* WQE does not require an ack */
 	if (wqe->state == wqe_state_done)
 		return COMPST_COMP_WQE;
@@ -454,6 +501,9 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (post)
 		make_send_cqe(qp, wqe, &cqe);
 
+	rxe_comp_writeback_wqe(qp);
+	qp->comp.comp_wqe_valid = false;
+
 	queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
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

