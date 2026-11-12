Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518017;
	b=xHvjdqdtquYKhH1/ClVrc+RjnmGn3neO3KqNeFRoCES8u0nPuyYP8NhEs8t7Ipod7DP4
	 BaLls0aBnw3I2OvyzVp+KTq+m3OJyMpKNyWrWnh2K+4SAwvIHpv2+nhKKygI/CUuvzlL+
	 Txvj4R9EVCH7S+l0Z7HddhSsnFs+FCoXCkpquJTV4N97JdTRJB0aG2Ht1QLKkhcg62dsj
	 zvDkqiOBftMFkHE14v1QcVLxWJDQaSqw58HRshO2hFwR+kNaUXurziu2kPbjfdDIZYB9G
	 7LN+de3jGC9wOiAquHEttF1bi+pLURaNBi8uVx2zYGWE8d2KLEsNtniex2LfvuTErjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518017;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=;
	b=z/xNgbDsQ09vp9Kke4xbJKPbfgJIzJwGQQv//68sCZmieQSQYKWgkSuIMmSeXVi7ho3I
	 rt8v+5wc9Oks0nPqJTfxW66wrkrpd66du0gkDHbjxQH0tSfUjP4K6yNXzMFa/gvWEElD0
	 kugMKCYVVEHJDvYRzJSW+GoJcfBFG2VAxkG26Md6V5w61O+AbNt+cy3q7H8cVjNPtXbZi
	 8SEY2PKk1J5jCHkjxhtazfrR2q7kj8N4yYs7K3dkj2gnFrzmgQ9l5N3CBATjAqUwfPZBa
	 IlN36iMs8WYMpk/GsoO+va7xO6ob2sh0eL8uOhrcXyIGrawZpbOEH+9wROn4Tz/VZQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoaQusyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AD606A31C;
	Thu, 12 Nov 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoaQusyt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794518016;
	b=cEXquLdEyvIGRwwYUyRWpv3HWEWynaEpxAE+dSQ1tQ30ALr8rJmRoiZSQMXMUoDQsYy+
	 B1dAprOTsrGCioXIbVGbQPnBTn6VkZWXhCZt1g6qskWrYYPZeCbm/wyUU11Vyp3t9Q3o8
	 G/tTADzNdcm/1QWOyV70h6aAkNilz6VIMH4nbkH2zBpAQsh9JrZTb9rZmR7x6HZX6zh0T
	 rJJhAvk+kzXBy8kUUXFvUf29whML1f2m6HAE6QyXNT84UGhvPwpLE+UmdnnlMvZzkyX4/
	 +vDgQYDDmrrJyJ3BlzTPE/S6uI6TcYB21VaYP1RVPN3kzbba0TB3GyEfU+lJqM6oPBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518016;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=;
	b=zzoy8XpMyqKjWTPtJxupE7zrAaLSVeDfoI7e1lqCl1FQV/wlPCsANdaE7wvuhJx+tP4p
	 xPrZERAP5+lUIGkf1EBfS2nwy6L3XHPKYBEo+izYRnQNHI69YEBp2v3/UqMfcdV76vlH3
	 aMhN6Tu2bHS2daptAaiuwHvNoKbLt3L6PZakr5kpElNFY2cFQImYZwjm87MJIQuzobIJ9
	 Wz2pgzzzqLSK7XDLcTJcYeKc0Nyt5Qr12JPTvDCskI9PrZgGWNxKlNHghvjMNP6+pgGZk
	 e++wES0MxppoteIsdOW94Ri58Hg0M59D0yrMdhJm+gBdZg77pFrfd71mAH1rxEJD5hw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C81301F000C6;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518016;
	bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AoaQusyt2BVmU26Bjzoby+BLG8HPImBPTmHmQNn6aI7EjHVWu1VR1+UvY3Kwh5S5F
	 gySqB/g72Laci3LVoa7BlmGogc1U1OXh1U8WXGbdoA/WjSfsLu3qeWLJxzVJ2fOL9U
	 +WhVQEHrBnJJwHSQ7fJqYJKHcl4IJ78PszAaNVHJZO7BOb9qCojH0YCrD75/I5O7r/
	 ELBIgRokUMcCiDgITGN2+IOc5Et+63Ztc32w1AK4Bku/h4nuunW9RDIg3Ni+DYPo1i
	 2ZHE+ZHgVa/GVxINbt8VAeUj+gHcSOuf/USi4NhulAZY/zSu+BXAmKTH4/lQQzSOkI
	 S5uuu78eMickA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5422F474F2;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 16:13:35 -0500
Subject: [PATCH v3 2/3] nvme-tcp: move the TLS record read loop into a
 helper
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
Message-Id: <20261112-nvme-tcp-live-ctrlrec-v3-2-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794518014; l=3310;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=FtiyVAi+tsuAV1pkCkNXF2SIPBQlx9U9Q/ZMmwpLydA=;
 b=gdK0ysAwmRSX1Xpm0gP+jOGFmNl7djrblDhVNI0xnsSTYCivmFu0XRZQ9SkmW/M0/K+wPI5lm
 VAbsVuibUvgBaUeD5p4DV2xBwvGLj3GDGoEmAgqD0v77xAkZLvHWj29
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

From: Martin Belanger <martin.belanger@dell.com>

Move the read loop out of nvme_tcp_skip_tls_record() into a new
helper, nvme_tcp_drain_tls_record(). The next patch uses the helper
to read TLS records that arrive on a live queue.

No functional change.

Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 60 +++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 749d77b4e172..c3bf345c4e92 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1629,31 +1629,16 @@ static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
 }
 
 /*
- * Discard a TLS record that arrived in place of the ICResp. A peer may send
- * a NewSessionTicket as soon as the handshake completes.
+ * Read the rest of a TLS record whose first part was read into @msg.
  *
- * Returns 0 when the record was discarded and the ICResp can be read, or a
- * negative errno if the connection cannot continue.
+ * Returns the bytes read, or a negative errno.
  */
-static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
-				    struct msghdr *msg, u8 ctype, int len)
+static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
+				     struct msghdr *msg, int flags)
 {
 	u8 buf[NVME_TCP_TLS_REC_CHUNK];
-	int ret;
+	int ret, drained = 0;
 
-	switch (ctype) {
-	case TLS_RECORD_TYPE_HANDSHAKE:
-		break;
-	case TLS_RECORD_TYPE_ALERT:
-		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
-		return ret ? : -ENOTCONN;
-	default:
-		pr_err("queue %d: unhandled TLS record %u\n",
-		       nvme_tcp_queue_id(queue), ctype);
-		return -ENOTCONN;
-	}
-
-	/* the ICResp is in a later record, drain this one first */
 	while (!(msg->msg_flags & MSG_EOR)) {
 		struct kvec iov = {
 			.iov_base = buf,
@@ -1667,16 +1652,47 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 		};
 
 		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
-				     0);
+				     flags);
 		if (ret <= 0) {
 			pr_warn("queue %d: failed to drain TLS record: %d\n",
 				nvme_tcp_queue_id(queue), ret);
 			return ret ? : -ECONNRESET;
 		}
+		drained += ret;
 		msg->msg_flags = drain.msg_flags;
 	}
 
-	return 0;
+	return drained;
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
+	ret = nvme_tcp_drain_tls_record(queue, msg, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 /*

-- 
2.53.0


