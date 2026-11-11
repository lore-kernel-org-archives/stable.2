Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428458;
	b=w3JTSwEsig+fAxgOynz7bGp5ygDVgd0TqUL55k8tqGvuUYpS/z/+02tX4gN6HNS9a9oo
	 qZQ1wXdPvxigWhpnDj4yjWwM12JMXxN77D6AqWjyAWj+3P0qml4qK66//sWrGSgSzHzhL
	 CfLXIqq4VEg+rcbSoq1PM2ajgKlXYfGqubftValpRd0f+GBdAj1H/1nrxdq0Jm0/vEl71
	 zDYm17uvnYSuxlM2sRgwM6bh8v0QuFAyLthtiGf9XWQRJkEuEA8Ko+OAPTavhlXSCYaIM
	 +WacRY7naDPBdrEJn7UlFjX0N3dGa0ORzKRt6f1OOTsX6dlkltNaTGEh7hknrGTd5OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428458;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4cXMxtzidXGv0WNf5+EEn+FhjoEKK2AECIQimCUPzCA=;
	b=LcZ+7t8kwrHyhTqnmo2Zr8mYIvg0rBivRVFwkXgDarCpvHFf9NDbZtAt3T5jIoJE7/8c
	 4DivZpLQvLjcZPcOpu2gFiHMYHtxG9Q3SlY5S1LrnypFmpEkseeaFb3tb3NuNoP15JTvw
	 HD9WCSHul4XKNmQ3zk/69nLicKxdnWvlj6X/yaHiSUF9W9ZlswSj3CExuJk9foMUyCQkc
	 LTQiLxPbLIhhnxe9DN8YQeKBsBrvvQODds4OdOp8QaHeki5UvoFZtK6qvlqd9z5ASSSL/
	 wdsnGle2FfTT6gRNXZjcvUpwvmQR2TJp2YUPScFOerBJbZK59xQCKwni/yEP6S85Few==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PAp/grAl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D48606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAp/grAl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794428457;
	b=K5BdtyuEPVN+aCm4OdZ+P6K8wIUb+UpEV6uoYKHiBIJcoxLCHUZizqfXdn0nFNkm6pFW
	 PWLBtndqtxwHK6KzTzKT63WkU/DlpAfFJ99i7PIzGMJnbVtm9CMwohKF3IoUh/E6n/lxU
	 0gPMLGpqTzIjyaZ13ZEPy5fCcb7NeRz3TBbFpCx7xBjUPYwhAv+Z0Fntz4Plks8H0vAYo
	 yi9GAkZJTFh0TsRztSwL2kMI5q6ZU/SrSeTe1k6fOaZHQUxRmczP+QaKd6A0BzE7cK5/2
	 JHwLmuZJPaXxErlOQ7s7E8elLFrvyWRZny8maIn6NAX0PCKANKV6qT6Wm2I+ExL/FvQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794428457;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4cXMxtzidXGv0WNf5+EEn+FhjoEKK2AECIQimCUPzCA=;
	b=ml+miB/KL88JJss1FUYLnep5PPpYceRI7V2YcSctuLRhW8bYcFOn8eAM9kvNqIcTytUb
	 gVVJXb+SzvHuQEUkJwZDx2J9K6X+fW2OH9/97V924ofW6c4mZl2JoAr+xFBM1rZgMgt9y
	 lViQss9N9mDoPYbieeDLdqrliwu/yKPvri5dOHKn9UimMQWZytTwbKNodtvdzJoWeTaVQ
	 VpUV0m7+BGx7/aWgynMNYfq/pLaQv5Rnftubtq8E2mJSPX3bGOzsumV20pqctvdBgd60v
	 2PmiZW2Q3QMe9mU5P7G9zf4AtydnA6hnSL9r9YI4Vkenf9GlZ0efrZxZAstqm+jLbQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 25CE11F00A05;
	Wed, 11 Nov 2026 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428457;
	bh=4cXMxtzidXGv0WNf5+EEn+FhjoEKK2AECIQimCUPzCA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PAp/grAl84HyvqvGpytbODnY62wf1NCzFcc2rSb3/BLu9hbcpwukzv5qaAKiFmmXQ
	 Gb7iMeeNaWi2dVe/CxVESnpZVgEgDoiX0NIE+bhB6a1qkKlQy3vBlbe4RsuH4j6BkW
	 D9nY+zWScHME8+VcBy9S34LqXCf4ihHRV8N4yNZPD74QewTG11e4BakX9XJLxtuyfK
	 rycgc/x9sxzlQBPJ/3Ie/YZ4dP03+kJfZMKXOjU9DdQ3TNaBXsZ+J9WuzsWkE3u48C
	 m3h0KuxzJROZBQ0DDNB976YwiZp6H3bhIeUxqrZ9SmOCB9DLP2hxht7tfEmr/MfVmT
	 yaI4TerhrBAqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A4AF0490E5;
	Wed, 11 Nov 2026 20:20:56 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:20:54 -0500
Subject: [PATCH 6.18.y] nvme-tcp: skip TLS control records while waiting
 for the ICResp
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
Message-Id: <20261111-icresp-stable-6-18-v1-1-ccf02268f76a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMBAEf0XuuScm0ij9leKDSVc9KVZytijiv
 5u2+zYLMzspokDplu0U8RGV15TAXDIKQzv1YHkkJltYZ9JYQoTOrEvrn2DHpmaU1l47VL6oSkr
 iHNHJ+oveyeWmzjdq/r++/YiwfIt0HCd+StLffgAAAA==
X-Change-ID: 20261111-icresp-stable-6-18-e3225fe7b073
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>, 
 Martin Belanger <martin.nvme.dev@gmail.com>, linux-nvme@lists.infradead.org, 
 Jens Axboe <axboe@kernel.dk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794428456; l=7592;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=fFcBJ8BcvPYxw3eQJ+fJa/dnr9zY8euGzsjwV6YDuNE=;
 b=hMNlSnVTE8oJblKJYQMgVcwCUlTaR5UFRSLWZCw+b8C+ulcgk6yjujA7KADEPamFRv1aAZjyo
 VoIzjuTyIuWBPZOuSak8KV6TWpwT8lIspYGHnPI2GNtexw4Sf4BRrgp
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
Upstream has no Cc: stable. Tested on v6.18.63: NewSessionTickets of 64
to 1000 bytes ahead of the ICResp now connect; without the patch the
connect fails.
---
 drivers/nvme/host/tcp.c | 162 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 140 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 94495b022871..190eac661e7d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -53,6 +53,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+/* read a TLS control record in chunks of this size */
+#define NVME_TCP_TLS_REC_CHUNK 256
+
+/* TLS records read while waiting for the ICResp, the ICResp included */
+#define NVME_TCP_ICRESP_MAX_RECORDS 8
+
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1535,12 +1541,143 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1578,16 +1715,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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
@@ -1595,16 +1723,6 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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
base-commit: 1cdda838e8475edf89b73ff0cc952005dd0b1fa7
change-id: 20261111-icresp-stable-6-18-e3225fe7b073

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>


