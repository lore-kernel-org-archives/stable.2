Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497051;
	b=voVtCgHNWXpBoYX7L63LM52Sm3LOuzW27b3bXFwSYA1fTLB1pZtfbKo4NnZSrHmWSr0S
	 /ClTEGPaTQkWKNe58+gINamPSfsvc9NRzx0zI5x/nvmi9c/FVkEdIkq8XRuY5VCDuPgnP
	 DtSBcprA4x0tOC2oDBHWvacdbTRrXkwTv8cY9SpTnymR0s3xc/72H/U3IaSNP2C/pe2MW
	 AAFtjcjJoaIJdp1pyn3F9SRtiJqSYrEqPDisicVT6KizTzoA3JFMWbJ9Yaq/MxSoXVGDq
	 d96Hz+2bPPosX0koYpiKiCyubFFDkjnK9FG7uXQr8f07uLhN3few0XDaxKN2P+A95Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KUeI9/T25TxJPeUMKT2VphJhi0lGf7u+ommdwELtGJw=;
	b=rZWse83xn+nv1NViRpXiQ2YYpH8TVzmcUcm6gq1uzZgFI6JW+XBcmPLTVPX1irjzpgsd
	 ptrYNqCK7JyReiSCvp/MrTEkcypMIuv4guhhM40F00KIopI56hNjcnWKuxzdG4Pi93Q5/
	 GuqxzoTldjwox24zinJC5MvVXVld0hmmNf/KCoFaaWK2EAB1NVTmb9XV2a0R0oR9PxgGo
	 FRorFY1IzKHcGEdcd5vwLrz3PMJXMBVqWGUjGBUPJrQAKfkiaFAr4wTm6P2WP1cYhGMk4
	 FB31XphSN5HMwz5GkmbTufXeGW3wWzzXYlYJIIyKDTRvQxshYPac7JVFoqFxM7HqBhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9JomK2e;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D331606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D331606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9JomK2e
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-540537f959fso4517104b6e.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795497050; x=1796101850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUeI9/T25TxJPeUMKT2VphJhi0lGf7u+ommdwELtGJw=;
        b=Y9JomK2eyW0ShSQIZlemRFPwj9vj1oBQ33PGzbD9vtg+7U3bRJweIREx20NntC0EWS
         H4ei5rzL0gsP06FLz2QLo2kCqCnWwym3wYXq0XTQztEJqZie5B+YqHKLudBDtserBa9h
         6/QM1QgDQiA3Jy+Dzj29Y/S3TQWNvGeuSGdXt2yrjAd6cSuGnWQi6TA8oY7HIqtxq39V
         t5MIc+GI8PMLFb/qKNa835qArXWoyQWO56GVPoYPCtvrK+wbejnkMn/LMEyviq5JyPAu
         nnQ1uN792BoK90rQhBr+VcDsj+zQ/l7wtGaYBvd55akG4C59Ft2ztl/Y3K0VSt2Tznlx
         CEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497050; x=1796101850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUeI9/T25TxJPeUMKT2VphJhi0lGf7u+ommdwELtGJw=;
        b=202krqlsdDl8bR3+tY4qDYvKkVUr/P41BKFP0VvTgm+pjCbYgu8o8prLq1b3TRS+gD
         muQSHKpfozUxUwMx2k6QRNXJCnpqFgWqYt0GffJANnGTia+SXRFY4fUdJmVEVXhHrwxv
         dxYYmuE1NuxkImYZ0i9dU5KiGH5AH/SXXz9ivE1tMQLNUCCNZJZVs4AEhDCk13Ek36dR
         y7+HA51Gv6an3T9fsoj/uGbgTEpUYEkwiPv/15za4/DyAOPpEKsqqqlPxoRoVlPU2cNk
         hM0E/PNB7Ydc4LHHGwDgOPCL6Wiz/l6KVB+wNDYfput2S3jlWpi2pHvDeuhd2NMWBxMo
         UV/Q==
X-Forwarded-Encrypted: i=1; AL+hErHcQGaWAH4vhw3+pS14ghKSw1GayGHR+or5ZHNRTfDMyqwKCSz1agc9K+Hh/HJOXENk+a4lBZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iJJzO2w9SI6lAdplAaqzB0+OyRA/FSh9tyyt3+U8lHUK8TCOu
	M8SBZ0RNg+J3/BS7/Yx4gCSw8w+xXtW2BCKtIiuFB2dD8DCiqbo3p7D1jdcbEQbDmQHVY4qaTQr
	TaD41yeTv6V288MgZ36pTINo5tKFQlw==
X-Received: from ilbep24-n1.prod.google.com ([2002:a05:6e02:2a18:10b0:54f:a51f:b37e])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a0f:b0:531:3bcd:41a with SMTP id 5614622812f47-57a0c094c8bmr12512398b6e.59.1795497049807;
 Mon, 23 Nov 2026 21:10:49 -0800 (PST)
Date: Tue, 24 Nov 2026 05:10:41 +0000
In-Reply-To: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124051041.3099796-3-zhenwenliang@google.com>
Subject: [PATCH v2 2/2] nvme-tcp: set up R2T data transfer in the send path
From: Zhenwen Liang <zhenwenliang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>, linux-nvme@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

nvme_tcp_handle_r2t() runs in the receive path and sets up the H2CData
transfer directly in the request: it checks the R2T against
req->data_sent and calls nvme_tcp_setup_h2c_data_pdu(), which resets
req->pdu_sent and req->state.

The send path updates req->data_sent and req->pdu_sent only after
sock_sendmsg() has returned (nvme_tcp_advance_req(), for every send
except the last one of the request). When a controller splits a write
into several R2Ts, it can send the next R2T as soon as it has received
the last bytes of the previous one. The receive path can then handle
that R2T while the sender is still between sock_sendmsg() and
nvme_tcp_advance_req() for those bytes. For example, on a poll queue
nvme_tcp_poll() receives while io_work sends; the sender can also be
the submitting task sending directly from queue_rq() (the tag set is
BLK_MQ_F_BLOCKING) while io_work receives:

  send path                          receive path (nvme_tcp_poll)
  ---------                          ----------------------------
  sock_sendmsg(last bytes of R2T)
                                     R2T, offset = end of previous R2T
                                     data_sent is still the old value
                                     setup_h2c_data_pdu(): pdu_sent = 0
  nvme_tcp_advance_req()
    data_sent += ret; pdu_sent += ret
  nvme_tcp_done_send_req()

Commit e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset
accounting") already noted that an R2T can arrive before data_sent is
updated, and took the H2CData offset from the R2T. But pdu_sent is still
reset by the receive path and then advanced by the send path, so the
next H2CData PDU carries fewer data bytes than its header says. The
controller waits for the rest until the command times out, and the host
starts error recovery and reconnects.

Since commit 347d50d92e25 ("nvme-tcp: require the R2T offset to match
the data sent") the receive path requires r2t_offset == data_sent, so
with the old data_sent the host now rejects the valid R2T with
"unexpected r2t offset" and starts error recovery instead.

Let the receive path only record the R2T, and let the send path, which
owns the send state under send_mutex, check it and set up the H2CData
PDU when it next takes the request off the list. The R2T is recorded
before llist_add(), and nvme_tcp_process_req_list() takes the list with
llist_del_all(), so the sender sees it. The exact checks (offset equal
to data_sent, length within the request) move to the send path, where
data_sent is final. The receive path keeps the "<" offset check and the
length check, which cannot reject a valid R2T because data_sent only
grows. A bad R2T still starts error recovery, which then cancels the
request.

Three request flags keep this safe against a controller that does not
follow the protocol (we advertise maxr2t = 0, so only one R2T may be
outstanding). The receive path accepts an R2T only if it can set
NVME_TCP_REQ_R2T_BUSY, so a second outstanding R2T is a protocol error;
after it has written the R2T fields it sets NVME_TCP_REQ_R2T_READY, and
the send path sets the transfer up only when it sees READY (with acquire
ordering), then clears READY and BUSY. The send path never sets up an
R2T before the command PDU has been sent completely; if it finds a
recorded R2T for a request whose command PDU has not been sent
(NVME_TCP_REQ_CMD_SENT), it treats it as a protocol error. If a send
fails after the receive path has accepted an R2T and queued the request
again, the request is left to the error recovery instead of being
completed while it is still on req_list.

Reproduced in QEMU with the nvmet-tcp target over loopback, a poll
queue and RWF_HIPRI writes, using a debug-only patch, not part of this
change, that makes nvmet send one R2T per 16 KiB (stock nvmet sends one
R2T per command, so it does not hit this) and delays the host between
sock_sendmsg() and nvme_tcp_advance_req() for the last bytes of an R2T.
On v7.4-rc4, "unexpected r2t offset" and error recovery were seen in 6
of 15 runs; on v6.18.65, a 30 second I/O timeout and a reconnect were
seen in 10 of 15 runs. With this patch (on v7.4-rc4, and backported to
v6.18.65) there was no error in 15 of 15 runs on each, although a
debug marker showed R2Ts handled during the delay, i.e. inside the
window, in 6 and 3 of those runs. With the delay switched off (with
the nvmet one-R2T-per-16KiB test helper still applied), the reject
still happened in 1 of 10 runs on v7.4-rc4 (QEMU TCG, whose timing does
not represent real hardware).

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patch and this description were written with
AI assistance; a human checked them against the source.

Fixes: e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset accounting")
Fixes: 347d50d92e25 ("nvme-tcp: require the R2T offset to match the data sent")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
Changes in v2 (after the Sashiko review of v1):
- Split out the 32-bit overflow fix as patch 1/2 (the check predates
  this series).
- Send error path: do not complete a request that the receive path has
  already queued again for an R2T; start error recovery instead
  (Sashiko: use-after-completion on send error).
- Accept one R2T at a time per request (NVME_TCP_REQ_R2T_BUSY) and
  publish the recorded R2T with NVME_TCP_REQ_R2T_READY (set after the
  fields are written, tested with acquire ordering). The send path
  never sets up an R2T before the command PDU has been sent completely;
  if it finds a recorded R2T for a request whose command PDU has not
  been sent (NVME_TCP_REQ_CMD_SENT), it treats it as a protocol error.
  This replaces r2t_pending (Sashiko: race with a second R2T, torn
  read).
- Tests in QEMU with KASAN and lockdep, using debug-only fault
  injection (not part of this patch):
  * early R2T accepted while the request is being sent, then an
    injected -EPIPE: with v1 the injection fired in 4 of 12 runs, and in
    all 4 the request was completed while still on req_list and queued
    again, followed by an I/O timeout and a hang. With v2 it fired in
    20 of 120 runs; in all of them there was no such completion: the
    send path later picked up the requeued request, rejected the stale
    R2T with "unexpected r2t offset" and started error recovery; the
    host reconnected and the follow-up writes succeeded;
  * an R2T for a write whose command PDU has not been sent yet: with
    the first v2 draft the H2C transfer was set up before the command
    PDU in 10 of 10 runs; with this version it is treated as a protocol
    error and the host recovers in 10 of 10 runs. (This injection is
    sequential; it shows the ordering problem, not a torn read.)
  * the target sends an R2T twice: rejected as a protocol error and
    recovered in 5 of 5 runs (by the existing list or offset checks;
    the new R2T_BUSY check itself was not hit).
- The original reproduction was re-run (numbers in the changelog).
  KASAN and lockdep reported nothing, apart from a known early-boot
  KASAN report of the v6.18.65 test image that also occurs without the
  patch.
- Backports: older stable trees without test_bit_acquire() (5.10.y,
  5.15.y; it exists since v6.0) need smp_load_acquire() or test_bit() +
  smp_rmb() in a backport. Trees without 347d50d92e25 keep their "<"
  offset check in the receive path. The v6.18.65 test backport used
  test_bit_acquire() as is.
- If a smaller approach is preferred, I am happy to rework it.

v1: https://lore.kernel.org/r/20261123225246.1653658-1-zhenwenliang@google.com

 drivers/nvme/host/tcp.c | 132 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4fa4b0199dee..b7a44b56b2f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -93,6 +93,19 @@ enum nvme_tcp_send_state {
 	NVME_TCP_SEND_DDGST,
 };
 
+enum nvme_tcp_req_flags {
+	/*
+	 * Set by the receive path when it accepts an R2T and cleared by the
+	 * send path once it has taken the R2T over; also set when the send
+	 * path fails the request.  No R2T is accepted while it is set.
+	 */
+	NVME_TCP_REQ_R2T_BUSY	= 0,
+	/* The accepted R2T is recorded in r2t_* and can be set up. */
+	NVME_TCP_REQ_R2T_READY	= 1,
+	/* The command PDU has been sent completely. */
+	NVME_TCP_REQ_CMD_SENT	= 2,
+};
+
 struct nvme_tcp_request {
 	struct nvme_request	req;
 	void			*pdu;
@@ -103,6 +116,11 @@ struct nvme_tcp_request {
 	u32			h2cdata_left;
 	u32			h2cdata_offset;
 	u16			ttag;
+	/* R2T accepted by the receive path, see NVME_TCP_REQ_R2T_BUSY */
+	unsigned long		flags;
+	u16			r2t_ttag;
+	u32			r2t_offset;
+	u32			r2t_length;
 	__le16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
@@ -823,6 +841,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
+	size_t data_sent;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -847,17 +866,25 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(r2t_length > req->data_len - req->data_sent)) {
+	/*
+	 * The send path may not have accounted the last bytes of the
+	 * previous R2T yet, so data_sent can still be too small here (it is
+	 * written by the send path, hence READ_ONCE()).  data_sent only
+	 * grows, so these checks never reject a valid R2T;
+	 * nvme_tcp_setup_r2t() checks the R2T exactly.
+	 */
+	data_sent = READ_ONCE(req->data_sent);
+	if (unlikely(r2t_length > req->data_len - data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, r2t_length, req->data_len, req->data_sent);
+			rq->tag, r2t_length, req->data_len, data_sent);
 		return -EPROTO;
 	}
 
-	if (unlikely(r2t_offset != req->data_sent)) {
+	if (unlikely(r2t_offset < data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, r2t_offset, req->data_sent);
+			rq->tag, r2t_offset, data_sent);
 		return -EPROTO;
 	}
 
@@ -869,12 +896,28 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	req->pdu_len = 0;
-	req->h2cdata_left = r2t_length;
-	req->h2cdata_offset = r2t_offset;
-	req->ttag = pdu->ttag;
+	/* Only one R2T may be outstanding (we advertise maxr2t = 0). */
+	if (test_and_set_bit(NVME_TCP_REQ_R2T_BUSY, &req->flags)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while another r2t is pending\n",
+			rq->tag);
+		return -EPROTO;
+	}
 
-	nvme_tcp_setup_h2c_data_pdu(req);
+	/*
+	 * The controller can send this R2T as soon as it has the last bytes
+	 * of the previous one, while nvme_tcp_try_send_data() has not yet
+	 * updated data_sent and pdu_sent for them.  Do not touch the send
+	 * state here; record the R2T and let nvme_tcp_try_send() set it up
+	 * when it takes the request off the list.  llist_add() orders these
+	 * stores before the request is visible on req_list.
+	 */
+	req->r2t_ttag = pdu->ttag;
+	req->r2t_offset = r2t_offset;
+	req->r2t_length = r2t_length;
+	/* Pairs with test_bit_acquire() in nvme_tcp_try_send() */
+	smp_mb__before_atomic();
+	set_bit(NVME_TCP_REQ_R2T_READY, &req->flags);
 
 	llist_add(&req->lentry, &queue->req_list);
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
@@ -1320,6 +1363,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 
 	len -= ret;
 	if (!len) {
+		set_bit(NVME_TCP_REQ_CMD_SENT, &req->flags);
 		if (inline_data) {
 			req->state = NVME_TCP_SEND_DATA;
 			if (queue->data_digest)
@@ -1401,20 +1445,77 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	return -EAGAIN;
 }
 
+static int nvme_tcp_setup_r2t(struct nvme_tcp_request *req)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+
+	if (unlikely(!test_bit(NVME_TCP_REQ_CMD_SENT, &req->flags))) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t before the command was sent\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
+	if (unlikely(req->r2t_length > req->data_len - req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, req->r2t_length, req->data_len, req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(req->r2t_offset != req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, req->r2t_offset, req->data_sent);
+		return -EPROTO;
+	}
+
+	req->pdu_len = 0;
+	req->h2cdata_left = req->r2t_length;
+	req->h2cdata_offset = req->r2t_offset;
+	req->ttag = req->r2t_ttag;
+	/*
+	 * The R2T is copied; accept the next one.  Pairs with
+	 * test_and_set_bit() in nvme_tcp_handle_r2t().  On error the bits
+	 * stay set, so no further R2T is accepted for this request.
+	 */
+	clear_bit(NVME_TCP_REQ_R2T_READY, &req->flags);
+	clear_bit_unlock(NVME_TCP_REQ_R2T_BUSY, &req->flags);
+
+	nvme_tcp_setup_h2c_data_pdu(req);
+	return 0;
+}
+
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
 	unsigned int noreclaim_flag;
+	bool fetched = false;
 	int ret = 1;
 
 	if (!queue->request) {
 		queue->request = nvme_tcp_fetch_request(queue);
 		if (!queue->request)
 			return 0;
+		fetched = true;
 	}
 	req = queue->request;
 
 	noreclaim_flag = memalloc_noreclaim_save();
+	if (fetched && test_bit_acquire(NVME_TCP_REQ_R2T_READY, &req->flags)) {
+		ret = nvme_tcp_setup_r2t(req);
+		if (unlikely(ret)) {
+			/*
+			 * Handle a bad R2T as the receive path does: leave
+			 * the request to the error recovery.
+			 */
+			nvme_tcp_done_send_req(queue);
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			goto out;
+		}
+	}
+
 	if (req->state == NVME_TCP_SEND_CMD_PDU) {
 		ret = nvme_tcp_try_send_cmd_pdu(req);
 		if (ret <= 0)
@@ -1443,7 +1544,16 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		nvme_tcp_fail_request(queue->request);
+		/*
+		 * If the receive path has already accepted an R2T, the request
+		 * is queued again and must not be completed here; leave it to
+		 * the error recovery.  Otherwise the bit now blocks later R2Ts.
+		 */
+		if (test_and_set_bit(NVME_TCP_REQ_R2T_BUSY,
+				     &queue->request->flags))
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		else
+			nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}
 out:
@@ -3022,6 +3132,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	nvme_tcp_set_sg_null(cmd);
 
 	ctrl->async_req.state = NVME_TCP_SEND_CMD_PDU;
+	ctrl->async_req.flags = 0;
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
@@ -3120,6 +3231,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->flags = 0;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-- 
2.56.1.809.ga0b61035b5-goog

