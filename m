Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2143F4CF;
	Wed,  2 Sep 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390071; cv=none; b=Jr1IMjpyrCKDvR1qIQgIlDJt3JzUwbJeQQ+1NxQs3AKE7qLPOiDlsFBUxAE+XPjFZB4OV6WOJlxIu00s490nxIqqpeW3jc8W07PftqRilyXDZ/zJ5MnAy1TgMWOw/1BoLinar56YMTZnXW/63ps5407OY5bfu8gOeKQtmAbawug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390071; c=relaxed/simple;
	bh=yJQo2pddZekCEf1xnnMVWdqs3Wr8r6zNGbVN79Wh1wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv1XXCABpPJ+CcmKqnbBvkQgnXxjQOuLPbYEVPtuHJllb0yBZmE194Ho97w3N/gBu6xDPgI29Rqor9pjtxQTwcqL0TkphCx8ettYJ3Jtyrh3MVqDaTJZ65BAnciII/ylNMpGi7YcLnnr6whbmOsFVOJziHa+j8wuRRixlnbVX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA87121D87;
	Wed,  2 Sep 2026 23:01:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B5F113736;
	Wed,  2 Sep 2026 23:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yUJmNayqmGqzCgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 02 Sep 2026 23:01:00 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/net: don't overconsume buffers when using MSG_TRUNC
Date: Wed,  2 Sep 2026 20:00:41 -0300
Message-ID: <20260902230041.1320658-3-krisman@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902230041.1320658-1-krisman@suse.de>
References: <20260902230041.1320658-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: DA87121D87
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

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
Link: https://patch.msgid.link/20260728191454.1850326-1-krisman@suse.de
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 io_uring/net.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 647156c9331a..f8110dc9f860 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static inline bool io_recv_finish(struct io_kiocb *req,
 				  struct io_async_msghdr *kmsg,
 				  struct io_br_sel *sel, bool mshot_finished,
-				  unsigned issue_flags)
+				  unsigned issue_flags, size_t consumed)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	unsigned int cflags = 0;
@@ -877,7 +877,7 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 	if (sr->flags & IORING_RECVSEND_BUNDLE) {
 		size_t this_ret = sel->val - sr->done_io;
 
-		cflags |= io_put_kbufs(req, this_ret, sel->buf_list, io_bundle_nbufs(kmsg, this_ret));
+		cflags |= io_put_kbufs(req, consumed, sel->buf_list, io_bundle_nbufs(kmsg, consumed));
 		if (sr->flags & IORING_RECV_RETRY)
 			cflags = req->cqe.flags | (cflags & CQE_F_MASK);
 		if (sr->mshot_len && sel->val >= sr->mshot_len)
@@ -899,7 +899,7 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 			return false;
 		}
 	} else {
-		cflags |= io_put_kbuf(req, sel->val, sel->buf_list);
+		cflags |= io_put_kbuf(req, consumed, sel->buf_list);
 	}
 
 	/*
@@ -1027,6 +1027,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished = true;
+	size_t len, consumed = 0;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1042,9 +1043,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
-		size_t len = sr->len;
-
 		sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
@@ -1065,6 +1065,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_APOLL_MULTISHOT) {
 		ret = io_recvmsg_multishot(sock, sr, kmsg, flags,
 					   &mshot_finished);
+		consumed = ret;
 	} else {
 		/* disable partial retry for recvmsg with cmsg attached */
 		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
@@ -1072,6 +1073,15 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
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
@@ -1098,7 +1108,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;
@@ -1186,6 +1196,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	struct socket *sock;
 	unsigned flags;
 	int ret, min_ret = 0;
+	size_t consumed = 0, len = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished;
 
@@ -1215,6 +1226,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
 		sel.val = sr->len;
 		ret = io_recv_buf_select(req, kmsg, &sel, issue_flags);
@@ -1222,6 +1234,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			kmsg->msg.msg_inq = -1;
 			goto out_free;
 		}
+		len = ret;
 		sr->buf = NULL;
 	}
 
@@ -1252,6 +1265,17 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
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
@@ -1260,7 +1284,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;
-- 
2.55.0

