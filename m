Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BA526A9C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572593; cv=none; b=qJv6WU5m6yjQHUQWOtDqvBP/uq41PTae97R1qcV93uzFObWfowMCi0EzTWMgl8g6HvDAbTT22DW7csZb85aCXBqKCkTWa0IN7KrRqSdwKG/WFusJz2Y+nvcyUvwaNquCTVJLhHGTKQViVq/Kp9NEczM7qFddqE5c9Ja3RKEC/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572593; c=relaxed/simple;
	bh=vtBt6XEwzKI4ttZa6UTbtdgWGAyvEaCNjtI5klTzu5k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=izr3PteLB1A4mVmOJNYBbMmmCX3InVgHGJvN8cZb4QJfiPm+Pn1Ms2j3uDgsxBkprkEeWJkTPuooZn1M2kEXr8l8teEtTxiHPdudYf9hvP+4TJY8+Sm3qH2K9qReP8Qlux8i8h7TciYIHjdlyI0abrQwE8Gylc8hO8VGQ/WfA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OIDzpwpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OIDzpwpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB41F00898;
	Wed, 16 Sep 2026 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572589;
	bh=S5KBguCiD92nckI5rWtULvWjW9uNH2Ty/W0F2q2WPB0=;
	h=Subject:To:Cc:From:Date;
	b=OIDzpwpMdyHCYqqgzs9VLgOPiNsrLPinSDLBASeFaXQY1RJ5B+uBmqwcuu7Yapk3c
	 +Immomd4dFFkSFhYCMf1aK9aHT5gQyqmnZOmiRyIBcDZtM51luTnvKAYDlYiJS6F0M
	 cgEmG1+0CeODU7rSqdxQWHx2ftoKPrWVG10y/XYg=
Subject: FAILED: patch "[PATCH] io_uring/net: don't overconsume buffers when using MSG_TRUNC" failed to apply to 6.12-stable tree
To: krisman@suse.de,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:20:50 +0100
Message-ID: <2026091649-cussed-imperfect-a5fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6028b543884f8735e057ec9eea4908cd61cab230
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091649-cussed-imperfect-a5fa@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6028b543884f8735e057ec9eea4908cd61cab230 Mon Sep 17 00:00:00 2001
From: Gabriel Krisman Bertazi <krisman@suse.de>
Date: Wed, 2 Sep 2026 20:00:41 -0300
Subject: [PATCH] io_uring/net: don't overconsume buffers when using MSG_TRUNC

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
Link: https://patch.msgid.link/20260902230041.1320658-3-krisman@suse.de
[axboe: fold in size_t unsigned fix]
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 647156c9331a..050ed274170a 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static inline bool io_recv_finish(struct io_kiocb *req,
 				  struct io_async_msghdr *kmsg,
 				  struct io_br_sel *sel, bool mshot_finished,
-				  unsigned issue_flags)
+				  unsigned issue_flags, int consumed)
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
@@ -1027,6 +1027,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished = true;
+	int consumed = 0;
+	size_t len;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1042,9 +1044,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
-		size_t len = sr->len;
-
 		sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
@@ -1065,6 +1066,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_APOLL_MULTISHOT) {
 		ret = io_recvmsg_multishot(sock, sr, kmsg, flags,
 					   &mshot_finished);
+		consumed = ret;
 	} else {
 		/* disable partial retry for recvmsg with cmsg attached */
 		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
@@ -1072,6 +1074,15 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 		ret = __sys_recvmsg_sock(sock, &kmsg->msg, sr->umsg,
 					 kmsg->uaddr, flags);
+		/*
+		 * With MSG_TRUNC, the net layer will return the full size of
+		 * the packet, even if we only filled part of it in the buffers.
+		 * Adjust the returned size to consume only the real part of the
+		 * buffer.
+		 */
+		consumed = ret;
+		if (ret > 0)
+			consumed = min_t(size_t, ret, len);
 	}
 
 	if (ret < min_ret) {
@@ -1098,7 +1109,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;
@@ -1185,9 +1196,10 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_br_sel sel;
 	struct socket *sock;
 	unsigned flags;
-	int ret, min_ret = 0;
+	int ret, min_ret = 0, consumed = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished;
+	size_t len = 0;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1215,6 +1227,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 
 retry_multishot:
 	sel.buf_list = NULL;
+	len = sr->len;
 	if (io_do_buffer_select(req)) {
 		sel.val = sr->len;
 		ret = io_recv_buf_select(req, kmsg, &sel, issue_flags);
@@ -1222,6 +1235,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			kmsg->msg.msg_inq = -1;
 			goto out_free;
 		}
+		len = ret;
 		sr->buf = NULL;
 	}
 
@@ -1252,6 +1266,17 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
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
+	if (ret > 0)
+		consumed = min_t(size_t, ret, len);
+
 	if (ret > 0)
 		ret += sr->done_io;
 	else if (sr->done_io)
@@ -1260,7 +1285,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 
 	sel.val = ret;
-	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags))
+	if (!io_recv_finish(req, kmsg, &sel, mshot_finished, issue_flags, consumed))
 		goto retry_multishot;
 
 	return sel.val;

