Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794429761;
	b=v20DJaYE/Z5uvU6lI0tYqMpJECJQFEFc7B/BWvE5hOp5kSmcFgUroTbkh7AQqBQDggCf
	 VbeK71yHTuo5Q1zuoVBDkdQP6uJy54BtSVomOd2KuptVpDdnj6TmPk0uGjPmwmTvZ4unq
	 6j/3bd4AOlLjczj3DuPMZ/qEGUcB5ZkNPRSOHT252/2HvbutKLSi/nNEx+9SjNbQIdrrD
	 eUvX/qTIesPkhFKfawMYFjYCh5Z4R2lGpGzQ8W9UdMxGqU2EG7T31w1U8LLYcXUHhMpjY
	 g28jR2qXj8/MD7ar4BUx3ofV+xw3izwIiVIB4RNgTUeCUh04iCBLtJ6seQ7l7OSf48A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429761;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=;
	b=3/Kf2jpvGGtMxxXbJAReOhoIr8jAfi9M6i3wyd2Go1kJRACHY7BwU14l/r2AZstLNCAk
	 0fxeOEzRycz357e18AS+fnrVaeyg2a5apGaFnH8gejMUyWZT2UuLa0QrxHDm2Vow5+g4W
	 DeWcjB+iOTF+G8m+GIyj9dLxyHmFlwqgjsU+4Yh9V+SHGU3u9mW2oOKOBf+f7yHKElNt1
	 Ji/Yiq+sBbt19LpawyWZfdjtW1ZOh+OYmNA4JBEjB/YI8FSol4gXWl4sjQLhx91QVPTsm
	 twoBwfA++oyNFccDwxIqNjzXSEXfX03aIytK6I2qbYzTUyNYkNu537hj+fyzazvGYwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUnNgSjz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793F606A321;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUnNgSjz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794429761;
	b=Wf3zfFA1F5mGvXrst1uzCp02riRYOVQphksjnIq3N5afH2JqRXkYvZeXGoN5YxYoKIL1
	 YnKissn7GTEBOmActeC2jyqSvtJMOTZaffrv8/JqBVFLk9Gd8Eh8Nq+ngrH0soWVeHd/P
	 AjBiTOExKx8x1vY+wo8dOKBQknWgmmMV4B3i9xO83E9u5T4oKANd2jBwQ1M6ggI/YJpFb
	 yhi5hPsGWh6UKKnLKlYkCTI5KxPHc1sEMwtjT3Sei9Z1ylVzZ+MmoEsQjkw2fLbwjZXcS
	 0HunBOCYSgjmY8KzEWZgdnA/AW+O2e8zyRwaaK3Dczvg77eEyBKrh5zic7cgfVaEGdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794429761;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=;
	b=TzfnAPRSwJ96efIVYgpYRjAZByKrb/IX8BYlQiHrvm/Ja2ljO+qOTVvJhsHbq3Kb5bSz
	 /xqXXU5dJVdVIfPPEgDlVYzq0d0KWtDf9yQ9rHENo5V89NOgoqe4CpehzHOylYrGPaP0L
	 8wxMgS48FD9QU3mbO8H0BMzsMTHNJPwjLw7CnKqKLFIVnCGCmPptT4e0UAr5CK/vVc6Sd
	 cyXbs8qeguwoW8ftnSwoLijPCRzIq4C1MMHrxk/CiJdOO//VbLgZvjNKjhLP1mrvzoHko
	 D6wX83HtZKjvlMxc5mcFoj24SM9PZ1zcCXhtFfH8HMM41JBiJmk0q5Lk+4f+M6lDxKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BA661F00A06;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429761;
	bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BUnNgSjzOLRdv8ucQUrixpAOzbqslSFpzv0QHJmDKr8rUUxFaTt/n4WAYMGlbjqk3
	 D77TYCgbSJMRTGuTluXE3WKd9yTSwAilktVVjXdfZz+LMJTAYw+7dNymPWGASzt7uU
	 UOhtTi9yfNO3j+jyEocU3vpoNW1U9zE0OMiAjfwY4SDYKuZrYIk0ttuAKIJGadboQl
	 TEYSWLb7deeftglApJ6fflqU6t1ohzPHTEltr8JE204YGTJTWFQAyKddecA+8ieV/f
	 lEO8zEtDV9WgHEy6b8Or6NNh0RD5hO/xC/4DNo9mUUGA1GN8z1zZZ8ukT72V0MtkyL
	 APgXMILjEqPpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94CC2490F8;
	Wed, 11 Nov 2026 20:42:40 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:42:39 -0500
Subject: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS record
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
Message-Id: <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794429760; l=2965;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=dSfexLwo67gflGLyNcBaaPITAwXJ0vNQ1LHo8u5k2cI=;
 b=CE/SMiI50fYM2KLpbRvPoeTipY7fRKGrogVnilfikot6baI7SWjq8ZPpW+hTM+r4ti4jsDTpr
 MYuWLqeeVx1BF3cbKn+/vVjvdhnfyeI1ZFzUdJPDmsyyg/qrt5YhUe7
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


