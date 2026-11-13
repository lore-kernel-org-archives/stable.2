Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611345;
	b=l9MokHjGVpD0BZgd0Z6X1UjZu3PrtPi4RNyMx9/AdKtfp3QJIf8W71W1AajxqhEYwMiu
	 h8kfhrmrbfVHOD9257OBVXofQTSwCntmydk8DCxOM9zGHv38sNEdr9jgFpjuXJ+rIZDCf
	 F+26i9jHgLCgRP0Y9lYkPeWBBj06PJM1vBscIhgF32xgGtBwr2/qk5ZyUbWtgzpjDPEBr
	 Tf0aJ1n5wL8mJBuLsFUtFD7fi93aX6uxo+iBjADflfIuYBimaCjVCVmhHjBG9OSdJMDJ2
	 00lYjX1J2JCYsRBONiKPHf49UwNaeOz+Y4/kT1O3/7EN9l8EF4aSz7oUefcS6a/IHTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5DlzMUMtEfBl4sH+z/6/msTIw6TRSjv0D6qDnAX+XMg=;
	b=mqb+pU/5yTbvxURuJKAgZ16Fb1yAxIUNqkUReBmpHp/1OO/HnVuNtaQyAEPMyVl1jBYC
	 SEgyTF7ZKW4UollCWAYu+JuD+5DHZkeKokCcRcnUNB5Z1ZKlnHU9xOWZ66a2psTQBdgQ0
	 WlYK6HtKnXHamvOWuDYTzfDwIOYBEHiIW113RjAm+7ahmdDPbnTANFNhTWO0inwRb1eai
	 90+bLak0zvdMHB9mibiEF8tHWxMBSyB9JgX5vQuji+JldvTe+fF6310l6QZCFONyYkBXs
	 UippNnUrL0kSpAftxy4U8mXlaqCaU2eMqx4UPbqrTw/Hd2Llgg7EAbzg1EfqpxGZbYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=XDxqczw+;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B31606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B31606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=XDxqczw+
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so4387070eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794611343; x=1795216143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5DlzMUMtEfBl4sH+z/6/msTIw6TRSjv0D6qDnAX+XMg=;
        b=XDxqczw+fhNCa5AT80FKOoJM6Ou3zh6RfXXx+DM/pNL8ZMxraPW2kO3doqaHkVmNF3
         uDe28tAUfDd1xKaE8lrESwZxTLQrTEO587sFSdjD9nVv5CYdVlXFckIfZILP2Mc00zI+
         fyJjy/CKt7RywPBU8e1v5SiBILoWKHGLoIKFn3m3jkXkYJ59L9YBF7KguyzMRkTFmmBg
         2r1310P1aFqsutcsuq/r+FsKbWN/nxE0fyCJxGYZ6iJDv2fmyQHlhhQdfctS6CXF0wgF
         FYfN07y5mx0Obeji+cDo3Cqr7H79D5Zsw0nyKHmP4Xav54MRv+Xcdwmy64eWcP2BJVjt
         NLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611343; x=1795216143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5DlzMUMtEfBl4sH+z/6/msTIw6TRSjv0D6qDnAX+XMg=;
        b=U5O/vt4mRz9jCcSJNPKBqUpX6/ZweG+cXp6KxdhJBVtkRF3BRkyHR24UpiFndsT4oD
         8PCDt1zNd1mm/OcnkoMhJ8UQUEo3dC83+aod25ACKBthUknB4QynXW4JSGhWa4dElQK6
         bOCmFMDmDj+UJ8cdUWhQlojap1wBuaPLJ8DZFXEkwx6C66/HaQITP3pGecWrHZTsJTxT
         6+R0GuhnrPpsAnGFoRWc1pafc/jyymIOUnVxLWWImNxX/5qleB/rmIJ2W1FFm0pOpDJL
         lGCZenKhTL5obV6Gpuqu55NEk0haK57lduZJ+M5Ta9sDIQEUgULaWdQfln6UzgrhZlHH
         88ZQ==
X-Forwarded-Encrypted: i=1; AL+hErGiNGF6hYomlGYMHCoUU3sD77qy6ZFGB+JL4MB9zuH/DI/a3frWSP/r5E8pECeLkYRpmdzxx0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I78W3KH5DhXAgs6A706Ry4R7BiFQawNj7wuYkUze0w8uYnf2v
	vPgq/iuoGmWF3s1/mQsUpLGE+xIddICUb4p7S38j3n9V6aMcykIarV/iUF21JsXGTPQ=
X-Gm-Gg: AYBFou2PIfs/ESZsv5TkRFxXaN3LmD8VoZtrg0kRTklIi+5MuNC2sq0mm82VxTE5tyC
	K++E1xaJ3HUDUgxI1gEgB1hwwzlI+LIDgboCTU6wyOCOqSRqL6edlb1Tux1oTcELmxXsgn3rAIo
	17tJXz8xYPpWen1eAkJEFzcwM//HxhDtkf3KZjFgNQxNb74153azLDLpupU/IsAIe/imJLlAQl3
	RgFyx3kcfImk5Uaqv+uLyayMtfGmc8abRKe5vhXyhApVWwqtDNzVBDw7eb8ohs83PxY17p0kYPp
	20eY55frNVRZADGGSjn2dhUthomyAjvfnz2ZA4VRq5Q/CG3LVDS2WygFGkEU6SGBbQkDoeDxVLi
	caJp1O5ZS96FfiKlv/3zB4ZHZJDzWdkEgYWVX+0Rk/YC6nQegxPaYnVyX7GQt+Y1gXjztFhreyT
	4NoqI7D+AHNsUdY+11sc44Bia5uRr0x378rYs0kwOLFA7V7GIwfjdSxk5sOJSVPcRrgORa+3kKW
	u84asvGRVyirRc5moeZGGhe1S2htOZ4fHlD3lVgR1mWV5SOws/yEogRr96REpWSmpuhTZWDVrNQ
	/raAvkDgzUoNdwAzPDpkrRdOwbDbb+7dG3FC3lA02bQXDJUdUhsRWav+OYiyNBwAdcm3n0uk+Q=
	=
X-Received: by 2002:a05:7301:db16:b0:376:9e80:2bf5 with SMTP id 5a478bee46e88-379680cf4b9mr3687174eec.38.1794611343074;
        Fri, 13 Nov 2026 15:09:03 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm10737887eec.2.2026.11.13.15.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:02 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] RDMA/rxe: Do not re-execute completed local ops after a retry
Date: Fri, 13 Nov 2026 15:08:31 -0800
Message-ID: <20261113230831.2682071-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
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

Local operations (IB_WR_REG_MR, IB_WR_LOCAL_INV, IB_WR_BIND_MW) are
executed inline by rxe_requester() through rxe_do_local_ops(), which
marks the wqe wqe_state_done and advances qp->req.wqe_index past it.
Unlike wire operations, nothing is posted to the network and no ack is
expected.

The completer only consumes wqes from the head of the send queue, in
order. A done local op wqe therefore stays in the queue until every
older wqe has completed, so it can sit behind a SEND or RDMA WRITE that
is still waiting for an ack. With nvme-rdma, which posts REG_MR + SEND
for every I/O, the queue regularly looks like:

  SEND(A) pending, REG_MR(B) done, SEND(B) pending, REG_MR(C) done ...

When a retransmit timeout fires or a NAK arrives, req_retry() rewinds
qp->req.wqe_index to the consumer so that every unacked wqe is resent.
Its loop skips wqe_state_done entries when resetting DMA state, but
rxe_requester() itself has no such check. After the rewind it walks
forward through the queue, reaches REG_MR(B), sees WR_LOCAL_OP_MASK and
calls rxe_do_local_ops() on it a second time.

rxe_reg_fast_mr() rejects the repeated registration because the MR is
already RXE_MR_STATE_VALID, not FREE. The wqe is given
IB_WC_LOC_QP_OP_ERR and the QP is moved to the error state. The
completer then flushes the entire send queue with IB_WC_WR_FLUSH_ERR,
including the wqe that failed, so the consumer never sees the real
error status. nvme-rdma logs only "SEND ... failed with status WR
flushed (5)" and tears down the controller.

Any packet loss that triggers a retry while a later request is queued
is enough to hit this. On a soft-RoCE setup with a few hundred lost
frames per run every controller reconnect traced back to the same
rxe_dbg_mr() line:

  rxe1: mr#776 rxe_reg_fast_mr:  mr->lkey = 0x3084c not free

Skip local op wqes that are already done when the requester reaches
them again after a rewind. Advance wqe_index past them exactly as a
successful execution would and continue with the next wqe. The MR keeps
its registered state and the completer still reports the wqe in order
with its original status. Only local ops can be in wqe_state_done ahead
of the consumer on an RC QP, since wire operations stay pending until
acked, so the check cannot match anything else.

Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 4f353abd76f5..fdb55366d668 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -723,6 +723,20 @@ int rxe_requester(struct rxe_qp *qp)
 		goto err;
 	}
 
+	/*
+	 * A retry rewinds wqe_index to the send queue consumer. Local
+	 * operations that were already executed may still sit in the
+	 * queue behind an unacked wqe waiting for in-order completion.
+	 * Re-executing them fails (e.g. REG_MR on an MR that is no
+	 * longer free) and would move the QP to the error state, so
+	 * skip them instead.
+	 */
+	if ((wqe->mask & WR_LOCAL_OP_MASK) &&
+	    wqe->state == wqe_state_done) {
+		qp->req.wqe_index = queue_next_index(q, qp->req.wqe_index);
+		goto done;
+	}
+
 	if (rxe_wqe_is_fenced(qp, wqe)) {
 		qp->req.wait_fence = 1;
 		goto exit;
-- 
2.56.0

