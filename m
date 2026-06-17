Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2134CFB9
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718725; cv=none; b=nUsuRTigyzpGmbH/SgkGEP6DS5lwfgHtsWoU9rDle7v21Kgl8ONHv+L69EYQ1TBdwocjI+6yMt9xTFVi0MRRlSbEHu35CSMbA7SK3NLseC/L3DFtCuWr7c9e7qOC/Yn5l7OkvyZUkP/fR9TKtYgYKJW86y23Kr7R7R6FDLFj/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718725; c=relaxed/simple;
	bh=PEDeP+3iYt/HPzGVNcclC/hxeIHvnhbZu62uk3NwHZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhRqAuybsGW8etG9S+DV1JNRTXTXCZIvYT1m1zW7d9QhtWlAXoYmTQLFCa58hRSNwuumOgaWwf845twtn78euE+ZIyRn8PnDxySSvUeyrb4x3T9iATWUnpaWHT1Kef684G0Fd3s1DMNerkYRLrjeW13aytJulT2fPTfEUsQWYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcQdW1S5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hNG4rV9h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lcQdW1S5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hNG4rV9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcQdW1S5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hNG4rV9h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcQdW1S5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hNG4rV9h"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7227A6C320;
	Wed, 17 Jun 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781718722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MS3y2022rUeqns8XjLc8PKqARySUNGJDfrHxMEf+i6o=;
	b=lcQdW1S5MT0bl//TKF6Jiu+mUIFhZwFh2evlPjhXVtUo/yggRReBihUqv0OyuIXFIYBLqF
	ALWmL6W+BYDU2E90pXNOBVa7X+hyN3x+525NWXzfc8XKDAObeo3vG7QO5ePOwl2XoSQVXS
	D/F+xDvYmiTVGPoGETSEN3akw1S7G3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781718722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MS3y2022rUeqns8XjLc8PKqARySUNGJDfrHxMEf+i6o=;
	b=hNG4rV9hyv63cjEvmcrUC/avRdf0hK9baYfmikyf4tLXwr6GVNzJ9PCKDE0moH43Sh+SXS
	X/0Rc5KllFNK07BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781718722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MS3y2022rUeqns8XjLc8PKqARySUNGJDfrHxMEf+i6o=;
	b=lcQdW1S5MT0bl//TKF6Jiu+mUIFhZwFh2evlPjhXVtUo/yggRReBihUqv0OyuIXFIYBLqF
	ALWmL6W+BYDU2E90pXNOBVa7X+hyN3x+525NWXzfc8XKDAObeo3vG7QO5ePOwl2XoSQVXS
	D/F+xDvYmiTVGPoGETSEN3akw1S7G3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781718722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MS3y2022rUeqns8XjLc8PKqARySUNGJDfrHxMEf+i6o=;
	b=hNG4rV9hyv63cjEvmcrUC/avRdf0hK9baYfmikyf4tLXwr6GVNzJ9PCKDE0moH43Sh+SXS
	X/0Rc5KllFNK07BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 220D1779A8;
	Wed, 17 Jun 2026 17:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jk2hN8HeMmoMawAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 17 Jun 2026 17:52:01 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: stable@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH stable-6.12.y] io_uring/net: Avoid msghdr on op_connect/op_bind async data
Date: Wed, 17 Jun 2026 13:51:58 -0400
Message-ID: <20260617175158.2977825-1-krisman@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,msgid.link:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

[ Upstream commit 3979840cd858f30f43ea9f4e7f7f1f56de82d698 ]
This fixes a memory leak due to the lack of the cleanup hook for the
iovec.  The stable backport differs from upstream by dropping the
io_connect_bpf_populate hunk, which didn't exist at the time and by
fixing the merge conflict due to the introduction of
io_bind_file_create and by using the older async_data allocation API.

Both IORING_OP_CONNECT and IORING_OP_BIND reuse the msghdr object just
to store the sockaddr. Beyond allocating a much larger object than
needed, msghdr can also wrap an iovec, which will be recycled
unnecessarily. This uses the sockaddr directly.

Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/20260602215327.1885109-2-krisman@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 io_uring/net.c   | 36 ++++++++++++++++++------------------
 io_uring/opdef.c |  4 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 94b6a15245af..446d98225196 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1718,7 +1718,7 @@ int io_socket(struct io_kiocb *req, unsigned int issue_flags)
 int io_connect_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_connect *conn = io_kiocb_to_cmd(req, struct io_connect);
-	struct io_async_msghdr *io;
+	struct sockaddr_storage *addr;
 
 	if (sqe->len || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in)
 		return -EINVAL;
@@ -1727,17 +1727,17 @@ int io_connect_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	conn->addr_len =  READ_ONCE(sqe->addr2);
 	conn->in_progress = conn->seen_econnaborted = false;
 
-	io = io_msg_alloc_async(req);
-	if (unlikely(!io))
+	if (io_alloc_async_data(req))
 		return -ENOMEM;
+	addr = req->async_data;
 
-	return move_addr_to_kernel(conn->addr, conn->addr_len, &io->addr);
+	return move_addr_to_kernel(conn->addr, conn->addr_len, addr);
 }
 
 int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_connect *connect = io_kiocb_to_cmd(req, struct io_connect);
-	struct io_async_msghdr *io = req->async_data;
+	struct sockaddr_storage *addr = req->async_data;
 	unsigned file_flags;
 	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
@@ -1751,8 +1751,7 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
 
-	ret = __sys_connect_file(req->file, &io->addr, connect->addr_len,
-				 file_flags);
+	ret = __sys_connect_file(req->file, addr, connect->addr_len, file_flags);
 	if ((ret == -EAGAIN || ret == -EINPROGRESS || ret == -ECONNABORTED)
 	    && force_nonblock) {
 		if (ret == -EINPROGRESS) {
@@ -1781,7 +1780,6 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 out:
 	if (ret < 0)
 		req_set_fail(req);
-	io_req_msg_cleanup(req, issue_flags);
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
@@ -1791,15 +1789,15 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
  * which in turn end up in mnt_want_write() which will grab the fs
  * percpu start write sem. This can trigger a lockdep warning.
  */
-static int io_bind_file_create(const struct io_async_msghdr *io, int addr_len)
+static int io_bind_file_create(const struct sockaddr_storage *addr, int addr_len)
 {
 	const struct sockaddr_un *sun;
 
-	if (io->addr.ss_family != AF_UNIX)
+	if (addr->ss_family != AF_UNIX)
 		return 0;
 	if (addr_len <= offsetof(struct sockaddr_un, sun_path))
 		return 0;
-	sun = (const struct sockaddr_un *) &io->addr;
+	sun = (const struct sockaddr_un *) addr;
 	return sun->sun_path[0] != '\0';
 }
 
@@ -1807,7 +1805,7 @@ int io_bind_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
 	struct sockaddr __user *uaddr;
-	struct io_async_msghdr *io;
+	struct sockaddr_storage *addr;
 	int ret;
 
 	if (sqe->len || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in)
@@ -1816,21 +1814,23 @@ int io_bind_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	bind->addr_len =  READ_ONCE(sqe->addr2);
 
-	io = io_msg_alloc_async(req);
-	if (unlikely(!io))
+	if (io_alloc_async_data(req))
 		return -ENOMEM;
-	ret = move_addr_to_kernel(uaddr, bind->addr_len, &io->addr);
+	addr = req->async_data;
+
+	ret = move_addr_to_kernel(uaddr, bind->addr_len, addr);
 	if (unlikely(ret))
 		return ret;
-	if (io_bind_file_create(io, bind->addr_len))
+	if (io_bind_file_create(addr, bind->addr_len))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
+
 int io_bind(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
-	struct io_async_msghdr *io = req->async_data;
+	struct sockaddr_storage *addr = req->async_data;
 	struct socket *sock;
 	int ret;
 
@@ -1838,7 +1838,7 @@ int io_bind(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 
-	ret = __sys_bind_socket(sock, &io->addr, bind->addr_len);
+	ret = __sys_bind_socket(sock, addr, bind->addr_len);
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 5dc1cba158a0..bbb62d2ab2a3 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -205,7 +205,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.unbound_nonreg_file	= 1,
 		.pollout		= 1,
 #if defined(CONFIG_NET)
-		.async_size		= sizeof(struct io_async_msghdr),
+		.async_size		= sizeof(struct sockaddr_storage),
 		.prep			= io_connect_prep,
 		.issue			= io_connect,
 #else
@@ -501,7 +501,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.needs_file		= 1,
 		.prep			= io_bind_prep,
 		.issue			= io_bind,
-		.async_size		= sizeof(struct io_async_msghdr),
+		.async_size		= sizeof(struct sockaddr_storage),
 #else
 		.prep			= io_eopnotsupp_prep,
 #endif
-- 
2.54.0

