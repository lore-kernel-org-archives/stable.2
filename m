Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474370;
	b=H4NvWN+ouiLIxH4hJxS3uSJn5GovuyjgWuPashg21JqfA4mDsTtVR+gf01pvgg1y/3A0
	 fzQtqkk6Bxka3tWxiPxTQrtFuNxY1Rx1vR3anZwMYQ0cSaGXhKX2BUgYh/8SHy+n7V0ic
	 RCNypATjfxOoxK496soGi5E7U45vc/bJX2wi+9AQibi+amu2zrgF38cnrl3jOOXsvD756
	 Eg2Mk3vwyvLv8/N99kn2JQLaP0a5l2DoFwzrXydHG2BRup8oZttyRcRSlioJE1aJGgkVR
	 kb6nL7OQ6N9Z+FJ3/onNd9C1BOaAd6aZ6ACpRr1XpFBalrwjs+qIKcUSxGC4wmkiFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=;
	b=Cau0XwFpNLn/tIeYF4W/M7HRXzKI5bCqD620DunkbQaw0yzo6ylv055F//LjAOJTZceo
	 +E04yjLttomJRnWOav+54cdfdvKhUxDJVEhdFor/9C2FBK021+QIDfK+1UJ5H9PEQIdYT
	 QSIMzNlbiAO8qwBhBcdzi3CiY4w9a8vnsxiqgBKKkFLe6p9iglYsbGJf9RzlQKV8qAHfR
	 ehqlPTyc09QptWs2tj7mJrOhRKTbn7zRaJu9GPb3wO2xjnAxeE59HeQk+icU/ekPh7wtq
	 Z508MAoaJZh4JfQ/eQII9S8oAIQbocy3+JgzVedP2kHUXANEHR9pNkVnqB54KUYuUPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iqrCDM5O;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB74606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB74606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iqrCDM5O
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4e778acdbc6so4833894b6e.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795474369; x=1796079169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=;
        b=iqrCDM5OuajCZho93O1HP5ed/LmhVxmEoiQLnOj/bGiAeCC5hxDvGh2ST0/YdIC0lS
         S3fq7VtcLfifomBEIjBbwANMOwwxphdAb28FW6726rqPvguIU6tGQpWL9AgDpXIO5rBD
         XVpeYS9gKWUldxcwSp9OTyCahI+yDPy/nglO8UaJmjNlLjYTdiKlleiC3Ej9/zAtM0b+
         wMX01MRmUM6hpuiQsEihv5NECGeVZ0X4SlJKphUWH0CRYbQ/61svjVx0tmYxthhtPpp5
         wxYdHIqPFfgn9Js1/qywtwdZgouG0tpggFzmN3xMZGWiRP3clxTDF7kI0EdEiWdrsN3R
         P1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474369; x=1796079169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=;
        b=v/N8YDiBObBYv4N5tPZ6J3RIj9lyLPnteAGTD10XEGgSgy4rMTfHte/XUrEX4R307o
         qenIft+zmyNN4to9Div41g2h2X7bQf2SDOsyc9Ee9jGIea2On1KzMatvUHEwupMSSn4y
         xn4coOqfayOMY1ImCoQaQA2xlisgb0AGDGI5GgKUbRWsVMtJa1nmNHSmv717ABtJG3Au
         t2XZhCCtKO1UMD+sLwJbiwFo3Ytkz82kpDsf8kWqfDX/djTV+HS/VHQjR9qxzfdLrNvI
         S2WVxO2iCqUSxMFvhM+Bn4ImQHDtbir/L4O3yDaQWme3z0Er1SbveACIteoa36H6kmTV
         11uQ==
X-Forwarded-Encrypted: i=1; AL+hErF/n7YK6bNiaxAptosZd+dhnfeHZ6NOaHoJJLkauSvLNVDwJBkj2iebLMD8xcyDAMKGIF9Isso=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uOeOlq1KbFC/V9wjtoj2Sn60KLmAzjQJORH09qnAdrJnL7BZp
	kiunFdHqGBmWJaxx5J+AFbpvgZRdTtT9QVuDj1klumF7LTyk/Zqw0+luFG8UPHqDtAS8T1Isc6Q
	j7fIgYC2879QSGI1X0rmDN/P6BRgJTA==
X-Received: from ilbeh11-n1.prod.google.com ([2002:a05:6e02:4c0b:10b0:50c:2841:18fc])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3501:b0:567:d689:9b62 with SMTP id 5614622812f47-57a037b96e8mr14473846b6e.0.1795474368504;
 Mon, 23 Nov 2026 14:52:48 -0800 (PST)
Date: Mon, 23 Nov 2026 22:52:46 +0000
In-Reply-To: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123225246.1653658-1-zhenwenliang@google.com>
Subject: [PATCH] nvme-tcp: set up R2T data transfer in the send path
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
llist_del_all(), so the sender sees it; the send path reads the recorded
fields once. The exact checks (offset equal to data_sent, length within
the request) move to the send path, where data_sent is final. The
receive path keeps the "<" offset check and the length check, which
cannot reject a valid R2T because data_sent only grows. A bad R2T still
starts error recovery, which then cancels the request.

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
window, in 10 and 7 of those runs. With the delay switched off (with
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
nvme_tcp_handle_r2t() can run while the send path is still between
sock_sendmsg() and nvme_tcp_advance_req() for the last bytes of the
previous R2T (drivers/nvme/host/tcp.c:1261-1275 in v7.4-rc4): it then
sees a stale data_sent and resets pdu_sent, which the sender advances
afterwards. e371af033c56 noted that an R2T can arrive early, but fixed
only the offset.

Effect by version:
- stable 5.10.y to 7.3.y ("<" check): from the code, the next
  H2CData PDU is short; observed as a 30 s I/O timeout and a
  reconnect on v6.18.65 (target data not checked).
- v7.4-rc4 and next (347d50d92e25, "!="): the valid R2T is rejected
  with "unexpected r2t offset" and the host reconnects.
So 347d50d92e25 changed how the race fails; it did not create it. A
plain revert would bring the stall back. The patch keeps the exact
check, in the send path; trees without 347d50d92e25 keep their "<"
line when backporting. 347d50d92e25 is Cc: stable but not yet in a
stable branch. On a bad R2T, receiving now stops only when error
recovery stops the queue.

Stock nvmet sends one R2T per command; targets that send several (one
outstanding, as maxr2t=0 allows) can hit this.

Reproduction: QEMU x86_64 TCG, 4 vCPUs, nvme-tcp host and nvmet-tcp
over loopback, one poll queue, 5 x 64 KiB pwritev2(RWF_HIPRI) per run.
Debug-only test helpers, not part of the fix: nvmet sends one R2T per
16 KiB; the host busy-waits 2 s (mdelay) in the window and logs R2Ts
handled while it owns the request.

  v7.4-rc4:              reject + error recovery in 6 of 15 runs
  v7.4-rc4 + patch (*):  no error in 15 of 15; R2T handled inside
                         the window in 10 of them
  v6.18.65:              30 s timeout + reconnect in 10 of 15
  v6.18.65 + backport:   no error in 15 of 15; inside the window in 7
  no delay (nvmet R2T helper and marker still on):
                         v7.4-rc4 reject in 1 of 10; other kernels
                         3 of 3 clean each
(*) plus our unrelated smc/autofs/serial/ufs fixes.
An identical early-boot KASAN report, before the test, occurs on
unpatched (1 of 55 boots) and patched (4 of 67) v6.18.65 images, never
on v7.4-rc4 (0 of 132): unrelated to the patch.

The no-delay hit was under QEMU TCG, not representative of real
hardware timing. Untested: other targets, non-poll queues, digests,
TLS. The send-path error branch was never triggered. Helpers, test
program and logs on request.

Found by a formal code verification tool under development (Lean-based),
with AI-assisted analysis; verified by the reproduction above and human
review. The patch and this text were written with AI assistance and
reviewed by a human. Point of contact: Zhenwen Liang
<zhenwenliang@google.com>.

Public list archives, git history and syzbot show no earlier report,
including in the 347d50d92e25 thread.

 drivers/nvme/host/tcp.c | 93 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9b..28a5d6da8f18 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -103,6 +103,11 @@ struct nvme_tcp_request {
 	u32			h2cdata_left;
 	u32			h2cdata_offset;
 	u16			ttag;
+	/* R2T received but not yet set up by the send path */
+	bool			r2t_pending;
+	u16			r2t_ttag;
+	u32			r2t_offset;
+	u32			r2t_length;
 	__le16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
@@ -823,6 +828,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
+	size_t data_sent;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -847,17 +853,25 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+	/*
+	 * The send path may not have accounted the last bytes of the
+	 * previous R2T yet, so data_sent can still be too small here (it is
+	 * written by the send path, hence READ_ONCE()).  data_sent only
+	 * grows, so these checks never reject a valid R2T;
+	 * nvme_tcp_setup_r2t() checks the R2T exactly.
+	 */
+	data_sent = READ_ONCE(req->data_sent);
+	if (unlikely(data_sent + r2t_length > req->data_len)) {
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
 
@@ -869,12 +883,18 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	req->pdu_len = 0;
-	req->h2cdata_left = r2t_length;
-	req->h2cdata_offset = r2t_offset;
-	req->ttag = pdu->ttag;
-
-	nvme_tcp_setup_h2c_data_pdu(req);
+	/*
+	 * The controller can send this R2T as soon as it has the last bytes
+	 * of the previous one, while nvme_tcp_try_send_data() has not yet
+	 * updated data_sent and pdu_sent for them.  Do not touch the send
+	 * state here; record the R2T and let nvme_tcp_try_send() set it up
+	 * when it takes the request off the list.  llist_add() orders these
+	 * stores before the request is visible on req_list.
+	 */
+	WRITE_ONCE(req->r2t_ttag, pdu->ttag);
+	WRITE_ONCE(req->r2t_offset, r2t_offset);
+	WRITE_ONCE(req->r2t_length, r2t_length);
+	req->r2t_pending = true;
 
 	llist_add(&req->lentry, &queue->req_list);
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
@@ -1401,20 +1421,72 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	return -EAGAIN;
 }
 
+static int nvme_tcp_setup_r2t(struct nvme_tcp_request *req)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	/*
+	 * Read the recorded R2T once: a controller that violates the protocol
+	 * could send another R2T and rewrite these fields meanwhile.
+	 */
+	u32 r2t_length = READ_ONCE(req->r2t_length);
+	u32 r2t_offset = READ_ONCE(req->r2t_offset);
+	u16 r2t_ttag = READ_ONCE(req->r2t_ttag);
+
+	req->r2t_pending = false;
+
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, r2t_length, req->data_len, req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(r2t_offset != req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, r2t_offset, req->data_sent);
+		return -EPROTO;
+	}
+
+	req->pdu_len = 0;
+	req->h2cdata_left = r2t_length;
+	req->h2cdata_offset = r2t_offset;
+	req->ttag = r2t_ttag;
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
+	if (fetched && req->r2t_pending) {
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
@@ -3120,6 +3192,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->r2t_pending = false;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-- 
2.56.1.809.ga0b61035b5-goog

