Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031C3A5E89
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266124; cv=none; b=rRfx08QdPHtce0o/WNlFzVrc8+HGPcSt4w150/VMGaKUzWytK0cEKzKYN4cHLEXBiNb8lsWZTs1u/UaX+uf2OExbfN4wfOV/n4y0MrE5BinmZcAvNgFX60wThkHuvYJZPrlhZEQeDz7hlmM6FDUgvbsx0x4Sia5NYwrdH9u55dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266124; c=relaxed/simple;
	bh=g91u38xN99MONpcrbIn5syL3q2ufwOt2rP0LwyuIxnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQk4PMhGJkcUaN67A38+8RelVyjcO+HZLiYHKel3/Q2CHyJTysHuU/ZGcNU8nh06NIZeyVFZyDNoxsfNqEjUwtj6TGZpZZM7HW7Is1Qkt1Zh/GKKwTiESUILe5t4CckoJQVJNu1K7CMjJeTfdykQg49URP61WYW+yD5MB+h9KBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cKynUxEC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d2ppvs08; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LSDaNk6/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fJkBrgaU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cKynUxEC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d2ppvs08";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LSDaNk6/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fJkBrgaU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E24A7C17B;
	Tue, 28 Jul 2026 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785266115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ds7mhuvVXaRCHBX/aoqYAMjx448HlrhwZPRVdULw3/k=;
	b=cKynUxECIaxrPhb9wpgxtswO9qJVXkaYD5sqiW0BkY5olwl11m7HhsyFtEHcpGu2NLe9cG
	6NxHgeHXbzgLnqa/vsvpZ2VdgrF8BC+j6hoFhYLRb3gkr4CxfycqQ8CUw9Agz3hfFWQVly
	hk4QX4EXLRHwQXSuSM/gOKSJ6wDf1Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785266115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ds7mhuvVXaRCHBX/aoqYAMjx448HlrhwZPRVdULw3/k=;
	b=d2ppvs08I4/R9AcySD4Gwo+vjhUP0kuv2eQc1txN46wvbdgNgl+S0ierSJVJzkg/nAMwYF
	qqkh8fqSRICvRHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785266111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ds7mhuvVXaRCHBX/aoqYAMjx448HlrhwZPRVdULw3/k=;
	b=LSDaNk6/MeCrpdVXLzWVY3i9dB6gW9ZNAtutGZA5+5Ju877vbhJFaghEa0Z7c0H3ivLlnE
	XB3Xjwg03gcIfByoVwYpbVGDdTQRRd5bCZ+606FnBZAf4FJSiOusEOfTHxD5D8qeg3xpQk
	MQFXqXB2kL1xe7HtclAoGER98i7Lr+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785266111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ds7mhuvVXaRCHBX/aoqYAMjx448HlrhwZPRVdULw3/k=;
	b=fJkBrgaUpMcueacNcZoxrPY3SJEVREc7rMZGfJb7RRF+FOizUJ9yTmFHUWZ4LVEIrBBt5m
	K4dCtgNAf1Q6w4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F250C779B1;
	Tue, 28 Jul 2026 19:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4B/kMr7/aGoFKAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 28 Jul 2026 19:15:10 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/net: don't overconsume buffers when using MSG_TRUNC
Date: Tue, 28 Jul 2026 15:14:54 -0400
Message-ID: <20260728191454.1850326-1-krisman@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

When a recv/recvmsg is issued with MSG_TRUNC and the incoming packet is
larger than the provided buffer, the net layer returns the full length
of the packet rather than the number of bytes actually copied into the
buffer.  As a result, io_uring advances more of the provided buffer ring
than was actually filled.  Use the actual filled region size to consume
the buffer, but still return the full size to preserve MSG_TRUNC
semantics.

Take care with multishot, because that seems to already truncate the
consumption based on the available payload size.

This was reported in https://github.com/axboe/liburing/issues/1619.

Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 io_uring/net.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index f192e6016c19..6be16aab21c1 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -883,7 +883,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static inline bool io_recv_finish(struct io_kiocb *req,
 				  struct io_async_msghdr *kmsg,
 				  struct io_br_sel *sel, bool mshot_finished,
-				  unsigned issue_flags)
+				  unsigned issue_flags, size_t consumed)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	unsigned int cflags = 0;
@@ -907,7 +907,7 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 	if (sr->flags & IORING_RECVSEND_BUNDLE) {
 		size_t this_ret = sel->val - sr->done_io;
 
-		cflags |= io_put_kbufs(req, this_ret, sel->buf_list, io_bundle_nbufs(kmsg, this_ret));
+		cflags |= io_put_kbufs(req, consumed, sel->buf_list, io_bundle_nbufs(kmsg, consumed));
 		if (sr->flags & IORING_RECV_RETRY)
 			cflags = req->cqe.flags | (cflags & CQE_F_MASK);
 		if (sr->mshot_len && sel->val >= sr->mshot_len)
@@ -929,7 +929,7 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 			return false;
 		}
 	} else {
-		cflags |= io_put_kbuf(req, sel->val, sel->buf_list);
+		cflags |= io_put_kbuf(req, consumed, sel->buf_list);
 	}
 
 	/*
@@ -1057,6 +1057,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished = true;
+	size_t len, consumed = 0;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1072,9 +1073,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
-		size_t len = sr->len;
-
 		sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
@@ -1095,6 +1095,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_APOLL_MULTISHOT) {
 		ret = io_recvmsg_multishot(sock, sr, kmsg, flags,
 					   &mshot_finished);
+		consumed = ret;
 	} else {
 		/* disable partial retry for recvmsg with cmsg attached */
 		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
@@ -1102,6 +1103,15 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 		ret = __sys_recvmsg_sock(sock, &kmsg->msg, sr->umsg,
 					 kmsg->uaddr, flags);
+		/*
+		 * With MSG_TRUNC, the net layer will return the full size of
+		 * the packet, even if we only filled part of it in the buffers.
+		 * Adjust the returned size to consume only the real part of the
+		 * buffer.
+		 */
+		consumed = ret;
+		if (ret > len)
+			consumed = len;
 	}
 
 	if (ret < min_ret) {
@@ -1128,7 +1138,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;
@@ -1216,6 +1226,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	struct socket *sock;
 	unsigned flags;
 	int ret, min_ret = 0;
+	size_t consumed = 0, len = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished;
 
@@ -1245,6 +1256,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
 		sel.val = sr->len;
 		ret = io_recv_buf_select(req, kmsg, &sel, issue_flags);
@@ -1252,6 +1264,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			kmsg->msg.msg_inq = -1;
 			goto out_free;
 		}
+		len = ret;
 		sr->buf = NULL;
 	}
 
@@ -1282,6 +1295,17 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	mshot_finished = ret <= 0;
+
+	/*
+	 * With MSG_TRUNC, the net layer will return the full size of
+	 * the packet, even if we only filled part of it in the buffers.
+	 * Adjust the returned size to consume only the real part of the
+	 * buffer.
+	 */
+	consumed = ret;
+	if (ret > len)
+		consumed = len;
+
 	if (ret > 0)
 		ret += sr->done_io;
 	else if (sr->done_io)
@@ -1290,7 +1314,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;
-- 
2.55.0

