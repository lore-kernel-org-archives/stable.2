Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518016;
	b=bOzhayLjy+H662OFbI2wN+9NvixjFUqaFmKvg1Iuo7mxCZHULWLVv+Oz6XpbwjE+emWc
	 5gmcmzGH2fOinuQa5FUOUbu4fzNPt9uLqmQoEd8Z2F9qa6uPw4qEHoI17XPlh1TjdxLuI
	 zV+Af9Q1SoT5UoP4Ym5uMkD1mzBlj0t8bqOtoUv77dhHms8XCucZmkDBCVtplm8qrRIiO
	 7gebfbV8I0emy/1YhM8zlAeO72u/JBbyHxfZ1EstwT/z+sK3ScvTnAMiz19Hoztw62UE5
	 hYbyKFwpstUwOVHMh86RiGwS6iahpEmXeTdCrP0RoHAtfNnukhWgTeDwjURM+vLZ/zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518016;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oBONeLVOZAjg146hkW/eL/Bs5UiN6VoYvpbS4XR6Tow=;
	b=3b9mfjlFS9uDL0SHwPQ3qba6SOxYge4sF+xTehF/OlwO8IKHLC3KkfwGrBOGMOrY0Slh
	 Nob7QVpcKBRFCxVcnvaVDAxGv7VdALMHqYNd7APnbEH5o1zYEG9Os+KziGINRNs3EirtS
	 TFtmuQr8hkTfEWLQCAe9GcsModXezEUIekiLr310pZR66+2/0Tr0Vknp6tkO71I1JyEkQ
	 DbYOShjn+k8Ubz1C9Qa7nZFl3aDYa2RfHmS/XsTol+FmtrSn3is/jxBYcBsAxC/WaQHCI
	 8KjFYCgZkK0O4m+wNDrT9Fo+Fcgea7MJeWppHkKHCQCfelbQlv0TE4kcvKo4JPG53Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfBH5uya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8703606A321;
	Thu, 12 Nov 2026 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfBH5uya
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794518016;
	b=E67WD8IDyjInM6ge0gOmOb5GrB5a+GGN03snIMxgtBVyhu9LZz4GJ6Pl9Ch/253f/X6X
	 nBQ3+Bbw5+ZuNpDFR9eBsECQZ/1donhAqzlG7uQ6j903wTVZ8Zz5xwOGfEpao5DyvIF4h
	 dweQPCru1Bqu8TujcKCxFYmggcDDwQnu8PkXZzJC+6zkv8TxDkP7qUE7C1gVIrIwxhA93
	 uGEl7UAUACuiq6c94/qsZNCog9eoXpZ2ynVC8djRQB72EH8ekdTCt8Eshv0oalr47FgZy
	 +BNyygVmLrq1Zo5bvpX5HfBhp7VBlfsn4U51LUpYWiqh5PcCDfiaCAtKT3j+WYjv3LA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518016;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=oBONeLVOZAjg146hkW/eL/Bs5UiN6VoYvpbS4XR6Tow=;
	b=BBWKBesygLDAIRW9v6lkyswQi8DFDMDoy/cGQOpAq9+yw7RaQwBGJeBBPwUVzOECXTPO
	 K8Rn6toQ/kVry8UFvVg1xO7vxrKQ1YmVdphZwpT6YSIf56hS03jnoYPqCkaKmpYFn2Lll
	 IaQaYmDavEp6EETttXPuxXdigCQdRTcHXMsxOdMV+CAg83TWIa0IsnZX4rfYcRd++jERI
	 qqPNVliGn3NWGRPtGxduTJUHnmDdpP11tyniLBp2SA8RNJWszrE8FbIv7R3V2Rq+J0cLV
	 vCnpMRdzKU3SqXW+QcAMoMc2QZh7oUc+U7Z2j5uXmpgmJxUVmZvjw+XqGxjDeSaHT7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C62891F000C5;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518016;
	bh=oBONeLVOZAjg146hkW/eL/Bs5UiN6VoYvpbS4XR6Tow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JfBH5uyaBWotc1xDZSspL7Fg8DV7MdMoesoPPYDjB1x7hglqjWiZvM5Rjtj4auREP
	 u5jOh+iu0IhGfSOovMU1rUDoL7BUw2skUbyXyd2vZ9hKAtiVCl5RQdDxfTf2Xh6jYq
	 fRqjoAFaNV5gPc/jpVDf5/2y9WQuLzteDn0dr6csHckDTBxy+WgPNxWGPcOcuBbKIP
	 n2mMZ9ewyQFU1iItO5FSh0ZWnIKDEamAtiauomzFSKcZSO8PQXPROa/ieBTGZrd241
	 nIxapgTOKH6t4tN4Mwubg24gK+jbtKWW08mxdP2Unh/8/FEPoBLlzpe0kG7i9gx7J1
	 t9H90HR8e0E+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F501474E3;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 16:13:34 -0500
Subject: [PATCH v3 1/3] nvme-tcp: use an aligned buffer for the TLS record
 type
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
Message-Id: <20261112-nvme-tcp-live-ctrlrec-v3-1-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794518014; l=3013;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=Ma7L0R61+9cK+Zp1EpkyOdXzdsPbkTNSuJ4iBIcEyCk=;
 b=MyASM8GqlsM7/OJqtpmmhqczhiI+As6ScjBdZuIN1wAotPnjJEKfAJOtrw82/M9KVvRjWm2Bw
 5sM5FDAl0K+BCN7P1C3Aq6pNxIshloUN2ddPkC/jCKVevCf3Oc2FHAh
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

From: Martin Belanger <martin.belanger@dell.com>

The buffers that receive the TLS record type are char arrays.
put_cmsg() and tls_get_record_type() access them as struct cmsghdr,
which needs a stricter alignment than a char array has.

Use a union with struct cmsghdr, sized with CMSG_SPACE(), as
svc_tcp_recv_cmsg() and xs_tls_read_record() in sunrpc do.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7ecc6c007f8d..749d77b4e172 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -77,6 +77,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 /* TLS records read while waiting for the ICResp, the ICResp included */
 #define NVME_TCP_ICRESP_MAX_RECORDS 8
 
+/* control message buffer for the TLS record type */
+union nvme_tcp_tls_cmsg {
+	struct cmsghdr	cmsg;
+	u8		buf[CMSG_SPACE(sizeof(u8))];
+};
+
 static int nvme_tcp_cpu_queues[NR_CPUS];
 static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
 
@@ -1653,11 +1659,11 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 			.iov_base = buf,
 			.iov_len = sizeof(buf),
 		};
-		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		union nvme_tcp_tls_cmsg u = {};
 		/* kTLS fails a control record read without a cmsg buffer */
 		struct msghdr drain = {
-			.msg_control = cbuf,
-			.msg_controllen = sizeof(cbuf),
+			.msg_control = &u,
+			.msg_controllen = sizeof(u),
 		};
 
 		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
@@ -1682,7 +1688,7 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 				struct nvme_tcp_icresp_pdu *icresp)
 {
-	char cbuf[CMSG_LEN(sizeof(char))];
+	union nvme_tcp_tls_cmsg u;
 	struct msghdr msg;
 	struct kvec iov;
 	u8 ctype;
@@ -1690,12 +1696,12 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 
 	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
 		memset(&msg, 0, sizeof(msg));
-		memset(cbuf, 0, sizeof(cbuf));
+		memset(&u, 0, sizeof(u));
 		iov.iov_base = icresp;
 		iov.iov_len = sizeof(*icresp);
 		if (nvme_tcp_queue_tls(queue)) {
-			msg.msg_control = cbuf;
-			msg.msg_controllen = sizeof(cbuf);
+			msg.msg_control = &u;
+			msg.msg_controllen = sizeof(u);
 		}
 		msg.msg_flags = MSG_WAITALL;
 		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
@@ -1703,8 +1709,7 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 		if (ret <= 0 || !nvme_tcp_queue_tls(queue))
 			return ret;
 
-		ctype = tls_get_record_type(queue->sock->sk,
-					    (struct cmsghdr *)cbuf);
+		ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
 		if (ctype == TLS_RECORD_TYPE_DATA)
 			return ret;
 

-- 
2.53.0


