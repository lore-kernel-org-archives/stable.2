Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428399;
	b=IV+SFkyIDPkfF3aHcCtLccjKPb/Isn/8/er4TC9/NcZc6dPQxTXXGDfGFH4hXLWazFCj
	 OzFN5BVNSUGiETwndzOONQJ3YkXW6nelbQur6U27wmhREkedyNASoxwOiKbv67azdfAii
	 iHAa4npahfcV8mjCeUM0eP67CGM0uBBCCAHaNATHRqlmklEBrNgeAurl9PTm4858iyZS9
	 P5SRxAxRHpw45F4uk3DM01HaWIW9K8rAUt8bLMWZF70dRubLQtNeQPYTr92/UyqnnkkFo
	 4qGs30RHIWJ5n+ZNwMZZN7wu2G+ZLO5j7xQU5qLfL/G0lXHP11FmTDSpYuM4vkxVF1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428399;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=rL4KwcEFHwkz1jWWL3y7UWO5qvCLFUUwuudRtrnqRrk=;
	b=DmBi/Ny9BHbb+06JfanG8zpcPkbdCxxQGs9WE4A1zQTPpu3N6u7u3tHoalOyDNiIqOhV
	 S6z2KA9sZnqBS46wucaqTTlU+ftWjEj7beTOsdkrSKNBh9fPNI6Kdl72J/jlyRF0p6P8c
	 iVLvwL3GDFXl8kT7y+QV6leXzL8AoqKlsQYq8b7QPSbWG/+hrThtohYaWf6O7YLBEb465
	 VLXMdAmfS+X32P+5sTayB7GBJMyOJQC3P8d4rkEmJeQGnBfQRrrz8coionFyMyOCZoSYa
	 35l9+HZX19Sk5MAx2494SPj2dEyzpszLE45hyWOKWrVv7P6b73y0+MtJCoRqtrA0bBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asc8jOgD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173F606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asc8jOgD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794428398;
	b=xJeA0mwgM938opf3TWx5Z2mVXdPx19885R/FbN1dfkqjzngPMLCbeczyWoIYD+F66luT
	 tQ3d7PbtechubGcDRXr469lbJ5cYQmJdwcQwfX1PWQz4FInfwfuapDBvRxqXCR02eTNg0
	 pCCjigTCghBXi8vsuUnIE0PrJqvkm/q1qDy5uaWvgbJMVUowX4D4RcDHh68xC9Eb+xZND
	 29j6oaLhW7aWwUAOoA1jWfjs7cihbaATNPONUtVZXkk6E8y6CFIx+8IC90vGev6/MBicP
	 06YiU4OsHdbUckm5M/gsy9GCfu9RmTMIircDztzpkOBA9e4HxMoUZFCtpPcu7cVrHfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794428398;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=rL4KwcEFHwkz1jWWL3y7UWO5qvCLFUUwuudRtrnqRrk=;
	b=feDd9hTkIGVs2T1M5gcMAL/dbMKV0hywus3nDWtN4PLRRQBPDyBOMPMH4hJPWwOVFn42
	 NsE/nE9U3mqMo5TG51JGjn1l8ERVf0v2whg2aeiOoSSLssbSscrfnBjcyHL+HLJSvWSiN
	 VC7XObCGgWZik4e3ELnpPtMygneVhG2yAPKhYVoXrDfisfe3wvd4OMMzI5hjpv2XW4naK
	 UWE5bHWK2InkLq8ab87+sojfr/Is1Qpc35Xl0/Uqm9wqB33us7YgPk6c8L8mSdXh4Tx/q
	 5e/SCA68uauc+PTL7MQPo3eYOcZ7fzTsLcpxmRCHnZUFjq1qFuJ9pmp31rKLepetAXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D60181F00A0B;
	Wed, 11 Nov 2026 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428398;
	bh=rL4KwcEFHwkz1jWWL3y7UWO5qvCLFUUwuudRtrnqRrk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=asc8jOgDYNZ4kdpN/iIR6YeQtwfTDDlmrQem1J8uyZnUdj2/1vuaJT3AEm5eR1nS4
	 Gy3VIWkYaybYQcVUIGXX1XvnmWstie9aOKaczPEkhIqqsVF81712UhqwCAzaCxCxe5
	 B8PnoN9jKxdomqpElGIdSaUX2EdqzSLw1L2POTMcsX+Pi2uITSRFoyT7Tbl6sZvkgq
	 vBIIOu/sOAYNWwNgx3FLfK9UOjN1Ze6/pHuurFOD724dapit6QewSTYsX/yziNZ8Iy
	 xvOnKFp4t0mRLcWkX4Nb7T7+Kpm5bcPOAM/dK+edxj2BgQBEJq/FKCbN/fo/we6F1m
	 EdEKhVAihRCgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 239D3490D9;
	Wed, 11 Nov 2026 20:19:57 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:19:55 -0500
Subject: [PATCH 7.3.y] nvme-tcp: skip TLS control records while waiting for
 the ICResp
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-icresp-stable-7-3-v1-1-c9157e951b3f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xss0faAjb6K8aHUg49QpD00GgI/
 27FfZtNZlYoJ2HFuViR+CUqjymDPRSI9zDdmKTLDGfc0eaRxMQ6ky6hHZk8VdQZV5+Mb/pgG2R
 vTtzLe29e4Muq/OD6v/XZDhyXXw/b9gUrXF2RfAAAAA==
X-Change-ID: 20261111-icresp-stable-7-3-d0249075fa15
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
 Martin Belanger <martin.nvme.dev@gmail.com>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794428396; l=7585;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=y4qvjQvefNgN22weaVN+ZwHY2rvrb6aJx8IrJ8atttk=;
 b=fOxl56Lz4C2MsmVbmO+WOcVM0JU1wU6PHJUoGC0Yghu7ecu1NLV+fMiRSxThQYC4dN8IZ3N4A
 0DY7vuIF5icDKHEaQv7BMuSUri18ubR28jmaD7mJ7oPTy+mTvQrTNcd
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

From: Martin Belanger <martin.belanger@dell.com>

commit 12c20e2903563acfb949342967adb900310a24d4 upstream.

A peer may send a NewSessionTicket as soon as the handshake completes,
ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
any record that is not application data, so such a target cannot be
reached at all. An OpenSSL-based target does this by default.

RFC 9846 section 4.7.1 requires a client that does not support session
resumption to ignore a NewSessionTicket. Discard such a record and read
again, up to a fixed number of records. Report an alert, and fail the
connection for any other record type.

The record type is now checked before the length. A control record
shorter than the ICResp was reported as -ECONNRESET, which hid the real
cause.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Assisted-by: LLM
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Martin: resolved a context conflict next to nvme_tcp_cpu_queues ]
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Upstream has no Cc: stable. Tested on v7.3.4: NewSessionTickets of 64
to 1000 bytes ahead of the ICResp now connect; without the patch the
connect fails.
---
 drivers/nvme/host/tcp.c | 162 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 140 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ce28c9b03817..2c7e9cfa2253 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -70,6 +70,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+/* read a TLS control record in chunks of this size */
+#define NVME_TCP_TLS_REC_CHUNK 256
+
+/* TLS records read while waiting for the ICResp, the ICResp included */
+#define NVME_TCP_ICRESP_MAX_RECORDS 8
+
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
 enum nvme_tcp_send_state {
@@ -1561,12 +1567,143 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
+static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
+				   struct msghdr *msg, int len)
+{
+	struct sock *sk = queue->sock->sk;
+	u8 level, description;
+
+	if (len < 2) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: truncated TLS alert\n",
+			nvme_tcp_queue_id(queue));
+		return -ENOTCONN;
+	}
+
+	/* tls_alert_recv() reads through the iterator */
+	iov_iter_revert(&msg->msg_iter, len);
+	tls_alert_recv(sk, msg, &level, &description);
+
+	if (level == TLS_ALERT_LEVEL_FATAL) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: fatal TLS alert %u\n",
+			nvme_tcp_queue_id(queue), description);
+		return -ENOTCONN;
+	}
+
+	/* a peer shutting down normally is not worth a warning */
+	if (description == TLS_ALERT_DESC_CLOSE_NOTIFY)
+		dev_dbg(queue->ctrl->ctrl.device,
+			"queue %d: TLS close_notify\n",
+			nvme_tcp_queue_id(queue));
+	else
+		dev_warn(queue->ctrl->ctrl.device,
+			 "queue %d: TLS alert %u\n",
+			 nvme_tcp_queue_id(queue), description);
+
+	return 0;
+}
+
+/*
+ * Discard a TLS record that arrived in place of the ICResp. A peer may send
+ * a NewSessionTicket as soon as the handshake completes.
+ *
+ * Returns 0 when the record was discarded and the ICResp can be read, or a
+ * negative errno if the connection cannot continue.
+ */
+static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
+				    struct msghdr *msg, u8 ctype, int len)
+{
+	u8 buf[NVME_TCP_TLS_REC_CHUNK];
+	int ret;
+
+	switch (ctype) {
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
+		return ret ? : -ENOTCONN;
+	default:
+		pr_err("queue %d: unhandled TLS record %u\n",
+		       nvme_tcp_queue_id(queue), ctype);
+		return -ENOTCONN;
+	}
+
+	/* the ICResp is in a later record, drain this one first */
+	while (!(msg->msg_flags & MSG_EOR)) {
+		struct kvec iov = {
+			.iov_base = buf,
+			.iov_len = sizeof(buf),
+		};
+		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		/* kTLS fails a control record read without a cmsg buffer */
+		struct msghdr drain = {
+			.msg_control = cbuf,
+			.msg_controllen = sizeof(cbuf),
+		};
+
+		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
+				     0);
+		if (ret <= 0) {
+			pr_warn("queue %d: failed to drain TLS record: %d\n",
+				nvme_tcp_queue_id(queue), ret);
+			return ret ? : -ECONNRESET;
+		}
+		msg->msg_flags = drain.msg_flags;
+	}
+
+	return 0;
+}
+
+/*
+ * Receive the ICResp. Over TLS, skip the records that a peer may send
+ * ahead of it.
+ *
+ * Returns the length received, or a negative errno.
+ */
+static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
+				struct nvme_tcp_icresp_pdu *icresp)
+{
+	char cbuf[CMSG_LEN(sizeof(char))];
+	struct msghdr msg;
+	struct kvec iov;
+	u8 ctype;
+	int i, ret;
+
+	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
+		memset(&msg, 0, sizeof(msg));
+		memset(cbuf, 0, sizeof(cbuf));
+		iov.iov_base = icresp;
+		iov.iov_len = sizeof(*icresp);
+		if (nvme_tcp_queue_tls(queue)) {
+			msg.msg_control = cbuf;
+			msg.msg_controllen = sizeof(cbuf);
+		}
+		msg.msg_flags = MSG_WAITALL;
+		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+				     iov.iov_len, msg.msg_flags);
+		if (ret <= 0 || !nvme_tcp_queue_tls(queue))
+			return ret;
+
+		ctype = tls_get_record_type(queue->sock->sk,
+					    (struct cmsghdr *)cbuf);
+		if (ctype == TLS_RECORD_TYPE_DATA)
+			return ret;
+
+		ret = nvme_tcp_skip_tls_record(queue, &msg, ctype, ret);
+		if (ret < 0)
+			return ret;
+	}
+
+	pr_err("queue %d: too many TLS records before the ICResp\n",
+	       nvme_tcp_queue_id(queue));
+	return -EPROTO;
+}
+
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
-	char cbuf[CMSG_LEN(sizeof(char))] = {};
-	u8 ctype;
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1604,16 +1741,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 
-	memset(&msg, 0, sizeof(msg));
-	iov.iov_base = icresp;
-	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_queue_tls(queue)) {
-		msg.msg_control = cbuf;
-		msg.msg_controllen = sizeof(cbuf);
-	}
-	msg.msg_flags = MSG_WAITALL;
-	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
-			iov.iov_len, msg.msg_flags);
+	ret = nvme_tcp_recv_icresp(queue, icresp);
 	if (ret >= 0 && ret < sizeof(*icresp))
 		ret = -ECONNRESET;
 	if (ret < 0) {
@@ -1621,16 +1749,6 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
 	}
-	ret = -ENOTCONN;
-	if (nvme_tcp_queue_tls(queue)) {
-		ctype = tls_get_record_type(queue->sock->sk,
-					    (struct cmsghdr *)cbuf);
-		if (ctype != TLS_RECORD_TYPE_DATA) {
-			pr_err("queue %d: unhandled TLS record %d\n",
-			       nvme_tcp_queue_id(queue), ctype);
-			goto free_icresp;
-		}
-	}
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",

---
base-commit: 7595a62d45ee1a2297eafa5f2ef5d0a45142d84d
change-id: 20261111-icresp-stable-7-3-d0249075fa15

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>


