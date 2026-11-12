Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518017;
	b=yRZ6cjoxnxEfzvipMctOFUSZ0EeVfdlupJfsEGtN248yKakQ3qTJQvNiJO0GyCm5Jeej
	 Y9dlO5FOKB36tVvHZhYtgXxaJ2WzKQIfRjuwaS2yjeqr1WrJEa1SVXaIEKDBbFcmIb1Dt
	 f6HLfbDEeCRRzd1X8FZNpMY5jukGDnzQIe5xFmxBiqXCwvzV6HKqQ4bFUpGhnHx4NlL6g
	 qUkqw35Y84TR1KEuHFXF5FRIJDygn/bV6HyK1fPNRot2tcNiG1J8VTVZyesQ9BKF3WJ16
	 YWNQs5vgKa/vjl+76kUCLLyBVULR+9iAf3oYw3mvKmGwWLAvVUEMEj0hmgnVqcrjuYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518017;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4E7h/dAcMh6DgfFM0bzw+E2/CsKrlRcwNwCe15KVRis=;
	b=XvoxSRX5oyY6sU6AK3vfUfmchHzGuEqtkLSTjm7xs4ctdzObW+zU5S/WOWq4ltZ6iWhJ
	 GiC/7CPAy7VSwiw12+yrcBxAxas4UELscx2Wp/8VZ1XOaTo2heMYDRW1tDadILrwtSXP5
	 qvIjhA/+rAbvF+9+GszKznA3uhArbpXCmwpNiasQa3o2YoD/QauKByycAOPS3+FJAk/3L
	 CdRCKFxBycMWkBfDtwBSaJRyMnl5lGtBTRk5oCtI8Z5atWRr697d6M7wrHr9kDCWzI5gA
	 s0j7hJUQO/p3weF4tOpwWLnDgnOJvuB2+S9sAjNR7JWqsj19G7YW8vthqPSZ32lPLNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVYBeRnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEF606A883;
	Thu, 12 Nov 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVYBeRnN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794518017;
	b=Y+LiVqoqUXtsUj4jR/WY0KbyvVYS+As7t/wdCTjImdRir4kQkMND2q6OJz2RIXwAxRCM
	 8FZbkee4ZnIbbMo0PIOTrEj1b5BVEYnUJs2cDET5EElIpPAVIAkHirU55R/B5+WDSLDhJ
	 3OpwevmAv3BitgMd0eQtwMpUHOEvWsAEk0ru3h0cMLeTrGId3PV8HCInGleMdTtA5rLZw
	 vzgYdHoxDVMbln5PTAHXDCHILMu4iPgS+lUxP3SSOtAcnjfFpDSexWTcunagIk5azfGUa
	 Me1G2+SGCrKYiONEGR38+UJQm4uRLMCtV1f1yflh5WiABe+0KRqw4/MnVz5/dYUOXMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518017;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4E7h/dAcMh6DgfFM0bzw+E2/CsKrlRcwNwCe15KVRis=;
	b=tUx3t3XEJX+lCLSlWSqhjZ4kvyez6OQiNiYls2RlZkr81a3ftIn9IAtyl5wupobambln
	 RmtXWoFzgOGXDiPb+aCqg8y2UKXHJCGwoGPxabwiUAr8HtY19kM5Uew6TX80MYrG1tUNS
	 7X71j2/mH9CmxfCBmCwuIyOjyfzQyeaOfYNzH9n5F2zpvRPEfToqBV15c/yKaAMFRKJYH
	 lf51tc/N5BwW6Lp5m1hClkTUt8U0yEx7o09TtSmc350Q9ietQG/Dl3MRbvCW/yKg1DAjv
	 4orJr9APvz1Cql/kRM8yT8G+6Tvyt2fM275SY6iw5x9b9GGmmr/weC68C+kyglqwR5w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC5A31F000C7;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518017;
	bh=4E7h/dAcMh6DgfFM0bzw+E2/CsKrlRcwNwCe15KVRis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SVYBeRnNHa4byo5+KMl6ejx5wFDcEYXAvt0QIh6ftBFp2sp0MsYLRRav42xPHWQ7j
	 HvL46hITZrOD/Yv3SwloHyiTPyB2MKRaNs3To7kk3k0cHRjgs0N4A1af8p2OMV7Y+N
	 jgN1QbDquwLaXIXr6hTEqj1KGbQMpNBB61HhVe81SyV1nE8o1EjUXxR0e4fc9oAROE
	 0BfsD44eotXyJlfMnHbawiT+OokCD2DqC5vpzLUEXRJ50sj6Jzv2zyRACYQbVX9Bco
	 j2uchYHc9Fo74SVHiXjHbm9o3tJ8eehqZnE6byE2f6aNliv6E/DolLYZCuBYwJ1oBP
	 AZcG0apPf56Eg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 68666474F6;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 16:13:36 -0500
Subject: [PATCH v3 3/3] nvme-tcp: consume TLS records without application
 data
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
Message-Id: <20261112-nvme-tcp-live-ctrlrec-v3-3-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794518014; l=7069;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=BXkzTnuE1CdiV8DxLxpXS4wtJqzfrr8MfvY7b3eLfds=;
 b=tMT7D7LfgIfbDrB4BZFfVXM1SOfBdkNW1WY14QcdsyoQsFYX9OtBuhYi9yEJaVDppjF7ZkbrS
 0+7coV9v28BAQZYb91DiLOxb7kd90UWAprZJc5gnPdsutALk3UIpDlC
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

From: Martin Belanger <martin.belanger@dell.com>

A peer may send a TLS record without application data at any time
after the handshake: a NewSessionTicket, a KeyUpdate or an alert.
tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
It returns -EINVAL and leaves the record at the head of the receive
queue. nvme_tcp_try_recv() then starts error recovery, and the
controller reconnects.

TLS 1.3 allows a server to send a NewSessionTicket at any time after
the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
time.

On -EINVAL, read the record with recvmsg(), which reports the record
type. Discard handshake messages other than KeyUpdate. Log alerts, and
fail the queue on a fatal alert. Fail the queue on a KeyUpdate, which
nvme-tcp cannot answer, and on any other record type. recvmsg() takes
the socket lock, so release it around the read.

Handle these records in one helper, also for the records that arrive
ahead of the ICResp. A warning alert ahead of the ICResp no longer fails
the connection.

On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can both see
the record while the socket lock is released. A queue flag makes sure
that only one of them reads it.

svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
way.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 113 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c3bf345c4e92..45e66adcf57d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -123,6 +123,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_TLS_RECORD	= 4,
 };
 
 #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
@@ -1450,6 +1451,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
+
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1462,10 +1465,31 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	lock_sock(sk);
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	/*
+	 * kTLS cannot pass a TLS record without application data to
+	 * nvme_tcp_recv_skb(). It returns -EINVAL and leaves the record at
+	 * the head of the receive queue. recvmsg() takes the socket lock,
+	 * so read the record without it.
+	 */
+	if (unlikely(consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
+		     queue->rd_enabled)) {
+		/*
+		 * On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can
+		 * both get here for the same record. Only one of them reads it.
+		 */
+		if (test_and_set_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags)) {
+			consumed = 0;
+		} else {
+			release_sock(sk);
+			consumed = nvme_tcp_recv_tls_record(queue);
+			lock_sock(sk);
+			clear_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags);
+		}
+	}
 	/*
 	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
-	 * still enabled failed inside read_sock(). Handle it before
-	 * release_sock() processes the backlog.
+	 * still enabled failed inside read_sock() or while reading a TLS
+	 * record. Handle it before release_sock() processes the backlog.
 	 */
 	if (unlikely(consumed < 0 && consumed != -EAGAIN &&
 		     queue->rd_enabled)) {
@@ -1666,33 +1690,88 @@ static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
 }
 
 /*
- * Discard a TLS record that arrived in place of the ICResp. A peer may send
- * a NewSessionTicket as soon as the handshake completes.
+ * Consume a TLS record without application data. The first @len bytes of
+ * the record were read into @msg and @data.
  *
- * Returns 0 when the record was discarded and the ICResp can be read, or a
- * negative errno if the connection cannot continue.
+ * A KeyUpdate needs new keys that nothing here can supply. Other handshake
+ * messages, such as a NewSessionTicket, are discarded.
+ *
+ * Returns the bytes read after the first @len, or a negative errno if the
+ * connection cannot continue.
  */
-static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
-				    struct msghdr *msg, u8 ctype, int len)
+static int nvme_tcp_consume_tls_record(struct nvme_tcp_queue *queue,
+				       struct msghdr *msg, u8 ctype,
+				       const u8 *data, int len, int flags)
 {
 	int ret;
 
 	switch (ctype) {
 	case TLS_RECORD_TYPE_HANDSHAKE:
+		if (data[0] == TLS_HANDSHAKE_KEYUPDATE) {
+			dev_err(queue->ctrl->ctrl.device,
+				"queue %d: TLS KeyUpdate is not supported\n",
+				nvme_tcp_queue_id(queue));
+			return -EKEYEXPIRED;
+		}
 		break;
 	case TLS_RECORD_TYPE_ALERT:
 		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
-		return ret ? : -ENOTCONN;
+		if (ret)
+			return ret;
+		break;
 	default:
-		pr_err("queue %d: unhandled TLS record %u\n",
-		       nvme_tcp_queue_id(queue), ctype);
-		return -ENOTCONN;
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: unexpected TLS record %u\n",
+			nvme_tcp_queue_id(queue), ctype);
+		return -EPROTO;
 	}
 
-	/* the ICResp is in a later record, drain this one first */
-	ret = nvme_tcp_drain_tls_record(queue, msg, 0);
+	return nvme_tcp_drain_tls_record(queue, msg, flags);
+}
+
+/*
+ * Read the TLS record that read_sock() could not pass to
+ * nvme_tcp_recv_skb(). The caller must not hold the socket lock.
+ *
+ * Returns the bytes consumed, or a negative errno if the connection cannot
+ * continue.
+ */
+static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue)
+{
+	u8 buf[NVME_TCP_TLS_REC_CHUNK];
+	union nvme_tcp_tls_cmsg u = {};
+	struct kvec iov = {
+		.iov_base = buf,
+		.iov_len = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
+	int len, ret;
+	u8 ctype;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, sizeof(buf),
+			     MSG_DONTWAIT);
+	if (len <= 0)
+		goto fail;
+
+	ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
+	ret = nvme_tcp_consume_tls_record(queue, &msg, ctype, buf, len,
+					  MSG_DONTWAIT);
+	if (ret < 0) {
+		len = ret;
+		goto fail;
+	}
+
+	return len + ret;
+
+fail:
+	/* read_sock() left a whole record, so none of it can be missing */
+	if (len == -EAGAIN)
+		return -EPROTO;
 
-	return ret < 0 ? ret : 0;
+	return len ? : -ECONNRESET;
 }
 
 /*
@@ -1729,7 +1808,9 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 		if (ctype == TLS_RECORD_TYPE_DATA)
 			return ret;
 
-		ret = nvme_tcp_skip_tls_record(queue, &msg, ctype, ret);
+		/* the ICResp is in a later record */
+		ret = nvme_tcp_consume_tls_record(queue, &msg, ctype,
+						  (const u8 *)icresp, ret, 0);
 		if (ret < 0)
 			return ret;
 	}

-- 
2.53.0


