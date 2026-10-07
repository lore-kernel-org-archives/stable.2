Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DB3EC808
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412354; cv=none; b=QXE67kI6cJ1zeAjd9Iz9zYujpsP5VFLo60dxlRr6ehIRjA6WlWiENWI0xBWkq+Lvm1opbQBE9CBw4JnmkXsAvdReX3BDnEyv+yAo+otM6Ul0eYp/IXdnWO9VRqHnoITFf1MO5aMjXp29QKXIouY7d/ychByHk1uL2VZbtrAt3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412354; c=relaxed/simple;
	bh=8+U5D2e5SYzZrGrK1iL1HrfwBcX1Qkb57io62ZvQyms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjBlDOj2/f/2ee9ef3+R0LUMHg0/Ecu400dt2rjJvHaIRjty7CnzJjDcF3vNm+8aVZxoJWPuQm3x/BbSl3BJaACV7A+XTk6hRMfHdF4PI3OPTorOcOFed1l4+0MqtKSoCQbPk1gyHlXeiAX9LISR9tD+zwdka4DNB+LIqj95S5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNGdMFKk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNGdMFKk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afe0081a6so1108580f8f.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412351; x=1792017151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijnB+OFRCY2MBDBmpyYwGFKzVgbk/JgZe3RlorNey9w=;
        b=BNGdMFKk58gaT3jjcwzDxxRlH8sWxuMmQel35qZfTOGZYQZS4E33wksR86SdYNoA+S
         S/jlJqf50D9+xlv7m20j2tunQSbngJubUkozLyPqPwguJPdTHZwzEjtBFLXn0oPSPoKp
         Nw//cyiiGCxhWUVnqQGxDPPVSDFg+XPlSWBH8qGoXp3b3HkkB71aJW47Ij9f59PsZKJh
         gumS6QxXhAUB8jwyCGudqjt5Q4DxEeVmQMAIWfwELFDVK6PP+X6RffgWeW8w4iUADJrf
         uENasNX9J/zGyAikFmSEKn3qIQJZrXxreJRlbD6xSrUVB3etpUhAjMQGYHkP7YO7c5rt
         0igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412351; x=1792017151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijnB+OFRCY2MBDBmpyYwGFKzVgbk/JgZe3RlorNey9w=;
        b=NfeBaLk9plalCYqaLomt3Iqcp2BAey/+0gI/7+agim7WA/BgHK/QdbLpZuL9DeUVfO
         H+dxgulJ0DLTBxEN7Cl0qejLU1hv5xs52mUpJEjozRF/xyYaIIXmtDKKJkQPaKVK1MU5
         VRD4kTiogwEd5/mhLUQgegJZ5VDLDP8azfooDurBmOvByh+yQ5LuZl2P+2iPnxtv7qHl
         b5PpM3E96G7R+UlkKAto/VN0gyl5l/xGbgWscOFzFmGgPdA0KqRXLjtjGSzEiWDz+dLc
         pGgbO0FR7COBQIDtKO0iqzyTn6wPe9a4xlYcFlByeMy4rha3ovfrhsIz5V9VgVcN+DPI
         7OpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGi1dIS7tUAo7rPoTDKPFkWiLYIY06H71W6zMky1y1SRq/T7fJYjQliKLX6zzjuX+pnKbUIyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjAuI+5LKJuVxLS2TKVHez15EE3QwkPFGmMuIEyGkNlU+hl3W7
	MXQ/2SK5B66p2asbw40g+rKQS+i1skV+FVDjS3dDqGusIutQy/scHQs=
X-Gm-Gg: AYBFou1AFn/I7y3umsDPl3zcLxUx3RP2I1iGJpdnwGga/eZSOAayNmdD9OxB/AVS+NB
	6K2SOGXIGOznA9lY0ZxQHAuVmuMrJa/RKopqJwtHNLg80WRNSfBlu70uh+JgrmvF2YAYoexOQUQ
	uSIo1bCo2laIpXwjbWBSphB6BV15E85Vjk+AsxMO+bG6IZermry1AQF4WbxUk/OtEeJbb54zeE6
	4/L0lIIEPSACIIe04Q3VeHOJTkszFhLtDaSU36bLbS8Px6eS6bpmlYiFpousRn5IilMMkqLM2ch
	EWR19+EfmEcRPudCm9AceQ/62mWJOdX+IF8rTtvnkOTezlBV1DEYP+PAsyF9oiP9fSzHQBObDIw
	0t2MdrWXr7Tp+kGZjMpVFtWGBtSh+o6MTtBSgqNbZGQXgT+WDNaaZDZWBpxsRspteSFX7qYB+wi
	jL0mEiWxJSkW+3nbF7zXrxInIAwQu9iMCW1K47uwU=
X-Received: by 2002:a05:6000:26c8:b0:48a:fc9a:3765 with SMTP id ffacd0b85a97d-48c7289b124mr7353204f8f.46.1791412351306;
        Wed, 07 Oct 2026 15:32:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1fec3sm7743500f8f.37.2026.10.07.15.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:32:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	bob.pearson@hpe.com,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] RDMA/rxe: copy send WQE to kernel buffer in completer path
Date: Wed,  7 Oct 2026 22:32:22 +0000
Message-ID: <20261007223222.2342804-3-tristmd@gmail.com>
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

The completer reads send WQEs from the same userspace-mapped shared
queue as the requester. Even after the requester copies the WQE to a
kernel-private buffer (previous patch), the completer still reads
directly from shared memory, leaving it exposed to the same TOCTOU
races.

Fix by copying the WQE in get_wqe() to a completer-private buffer
using the full queue element size (max_sge SGEs). The local copy is
reused when the same WQE is being processed with unchanged state,
which preserves DMA progress across multi-packet RDMA READ responses.
A fresh copy is taken when the state changes or a new WQE appears.

State transitions from the requester are observed through an
smp_load_acquire() / smp_store_release() pair. Completion status and
rd_atomic state are written back through WRITE_ONCE() before the
consumer index advances.

The copy is invalidated on QP reset and when the completion advances
to the next WQE.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 53 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1390e861bd1d7..ca31093fdf3aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -137,22 +137,69 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
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
+	/* Copy shared WQE to kernel-private buffer. Copy the full
+	 * element (max_sge SGEs) so that inline data, which shares
+	 * the flex array with SGEs, is always captured.
+	 */
+	qp->comp.shared_wqe = wqe;
+	memcpy(&qp->comp.comp_wqe.wqe, wqe,
+	       sizeof(*wqe) + qp->sq.max_sge * sizeof(struct rxe_sge));
+	qp->comp.comp_wqe_valid = true;
+	if (qp->comp.comp_wqe.wqe.dma.num_sge > qp->sq.max_sge)
+		qp->comp.comp_wqe.wqe.dma.num_sge = qp->sq.max_sge;
+
+	wqe = &qp->comp.comp_wqe.wqe;
+	*wqe_p = wqe;
 
+check_state:
 	/* WQE does not require an ack */
 	if (wqe->state == wqe_state_done)
 		return COMPST_COMP_WQE;
@@ -454,6 +501,8 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (post)
 		make_send_cqe(qp, wqe, &cqe);
 
+	rxe_comp_writeback_wqe(qp);
+	qp->comp.comp_wqe_valid = false;
 	queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
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

