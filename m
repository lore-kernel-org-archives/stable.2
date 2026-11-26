Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668566;
	b=5hu83tSfZhbLhGA1QlpULURz8RgBcBgySoibOpy3lCd91P8WD6YkKIChd1RG6w580woH
	 s1LhBKiv8V183q6BpVph4hT3NY1ptnzy8of6VN4YpJqtEXbmoi1guUwl0C0/b3xmU2XLs
	 HiTGHyM4wLvFPPC8qCYfYIq6eet89nQKSY24Gft/rol+geMTh2ZJ7zGL9xsOXPspwUB7a
	 PEcyhoErRmNmbSNXiHSADapcf2SKsyKDbKZBFqe0xwe/fbvgIYfbxqOH8ezAWx1TTvgPu
	 gsNAhFzyTYGoTDP2rLJaKKK7hiR049hKYt03V7vFClZI/f44esgR4h9GfVZH4CnhYAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e0mTq7NceCYXpVgOz22ifQfJiLTunmgoE0HdndbZ96c=;
	b=dKPN9CAAVfvvL2ALe0rxKWb+Zj4A0boXe5xkfbF6PO8LDU2xUigOJohdaNviJBE3XL+R
	 SONR25jeVLO2ATVWoD8xgUwl8SK+crzlf9rxOq/fg9PmuGMY1joTY0sA+qWNib24qfwaF
	 73cp/1rKomPHWLilw7DTjp1neZWK1KkRl+zfaDKcili1PEeAg4Q5u5hlgpqgSroV7As0u
	 LHWHI1pZLiK06nbHan7P8BPPuAiwXTOoD989U4Aacly19v4HDd2hb3TyTwq9IwSMaS9xy
	 d6UmhaGCKIA5mqwfagHkBZBoFiiHYxKIP6v3O0aqlAlA5QREDJIwfpr3F4jtP9Cw4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oqg4SqNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15AB606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oqg4SqNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB6C1F000CF;
	Thu, 26 Nov 2026 04:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668565;
	bh=e0mTq7NceCYXpVgOz22ifQfJiLTunmgoE0HdndbZ96c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oqg4SqNvcLcRlNGarKjJN6RAFVHBgdklrVcrQ9f+8W+QKVvx6LtyqHdEvFKAAwqus
	 KGwxPrmQGc+PuFpbpAT4DycEKeVom4eq2OIxaQ9tbCnEcNZO/yVkZo7jf9oNFCCw71
	 YNB1LCl/GidM7+5kQMruKMjZmiouDcoR34ZwtN+FTqXQrxkOF5zE1F5RdunrbyyUHl
	 vvGviaf1Og6umimjILU/xQCUrQzUIgf+Bcw5nS0HfqYoHwBPI5Lyrzg4c0p1eTXZFP
	 hdavzIcNy3oFmecsGxDP2weSin9VmgVWkTIun7hKsslbxNKwHBioxXOIm3nBkIs2Ai
	 19zENjkJXduRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] smb: client: retry writeback after losing the connection, share or handle
Date: Wed, 25 Nov 2026 23:49:23 -0500
Message-ID: <20261126044607.2007410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112550-molecule-expand-ec89@gregkh>
References: <2026112550-molecule-expand-ec89@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 59d223256f5912263a1a8d2b5b0c5abf9542cf7d ]

Writeback still fails, dropping its data, when a write gets back an
error that only means the client lost track of the server for a while:

 - -EHOSTDOWN from smb2_reconnect() when a soft mount's server stays
   unreachable for longer than the reconnect wait, or from
   STATUS_HOST_UNREACHABLE,
 - -EREMCHG from STATUS_NETWORK_NAME_DELETED, for which the receive path
   already marks the tcon for reconnect,
 - -EBADF from STATUS_FILE_CLOSED or STATUS_INVALID_HANDLE, e.g. after
   the server lost a durable handle,
 - -ENETRESET and -ESHUTDOWN from STATUS_CONNECTION_RESET and
   STATUS_REMOTE_DISCONNECT,
 - any replayable error on SMB1, whose async write never retries them,
   while it retries writes cut short by a reconnect forever, regardless
   of soft mounts.

Reopening the handle needed by a read or write is worse:
cifs_prepare_write() and cifs_issue_read() retry cifs_reopen_file() only
on -EAGAIN, with no limit and no delay, and fail on anything else.  A
server failing the reopen with a status mapped to -EAGAIN, such as
STATUS_INSUFFICIENT_RESOURCES, makes them spin forever, past umount -f
and, when netfs retries from a worker, with no signal to stop them,
while any of the errors above fails writeback right away.

Retry writeback failing with any of these, as already done for
interrupts and allocation failures, with backoff and giving up on umount
-f.  On -EBADF, have the retry mark the handle invalid, so that it gets
reopened, unless it got reopened since the write was issued: a late
-EBADF would otherwise get the new handle replaced too, leaving it open
on the server along with any byte-range locks pushed to it.  Subrequests
of the same request can fail -EBADF concurrently on different channels,
so record the bad reopen generation atomically (keeping the newest),
decide the invalidation under the handle lock, and have a reopen publish
its new fid before its generation so a -EBADF is attributed to the fid
that was actually sent.

When writeback finally gives up on any of these errors, record -EIO for
it instead, so that fsync(2) and close(2) don't return transient or
internal errors such as -EAGAIN or -ERESTARTSYS.

Retry reopens as the read or write needing them gets retried: as above
for writeback, otherwise per the hard and retrans mount options on
replayable errors, with backoff and giving up on umount -f.  If any
channel of the session got reconnected meanwhile, retry once regardless,
as the reconnect may be what failed the reopen; the next attempt waits
for the reconnect to finish.  Never retry reopens on interrupts or once
the task is dying, so that dying tasks don't spin there; for writeback,
issue the subrequest without credits instead, as done for dying tasks,
so that it gets retried from the netfs collector, where no signals are
pending.

Don't reopen for requests that predate a umount -f either, unless it is
a first attempt on a connected server, as with issuing them.  Once a
reopen for writeback gives up, fail the other subrequests of the
request right away, rather than each waiting out a retry window of its
own.

Reopen handles for reads in prepare, before acquiring credits, as
already done for writes, so that reads don't hold credits across a
reopen.  A read whose handle or credits went stale before it could be
sent is retried regardless of mount options, after the backoff, so that
prepare reopens and takes fresh credits; check a write's credits the
same way.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
[ sashal: Dropped the upstream goto defer checks and defer: path in cifs_prepare_write() (that path isn't in this tree), and rewrote cifs_issue_write_worker() into the wdata/cfile form the new body needs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |   4 +
 fs/smb/client/cifssmb.c  |   6 +-
 fs/smb/client/file.c     | 220 +++++++++++++++++++++++++++++++++------
 3 files changed, 196 insertions(+), 34 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 68f56547ef721..0717d417f4cbe 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1462,6 +1462,7 @@ struct cifsFileInfo {
 	int count;
 	spinlock_t file_info_lock; /* protects four flag/count fields above */
 	struct mutex fh_mutex; /* prevents reopen race after dead ses*/
+	unsigned int reopens;
 	struct cifs_search_info srch_inf;
 	struct work_struct oplock_break; /* work for oplock breaks */
 	struct work_struct put; /* work for the final part of _put */
@@ -1487,6 +1488,8 @@ struct cifs_io_request {
 	struct cifsFileInfo		*cfile;
 	pid_t				pid;
 	int				umount_aborts;
+	bool				reopen_gave_up;
+	atomic_t			bad_reopens;	/* 0 or bad gen + 1 */
 };
 
 /* asynchronous read support */
@@ -1501,6 +1504,7 @@ struct cifs_io_subrequest {
 	int				result;
 	bool				have_xid;
 	bool				replay;
+	unsigned int			reopens;
 	unsigned int			retries;	/* number of retries so far */
 	unsigned int			cur_sleep;	/* time to sleep before replay */
 	unsigned long			retry_deadline;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 8283a7ac44c00..ae81d00fddd9d 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1949,12 +1949,14 @@ cifs_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_req_submitted);
-		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+		if (wdata->rreq->origin != NETFS_WRITEBACK)
+			__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RETRY_NEEDED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_retry_needed);
-		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
+		if (wdata->rreq->origin != NETFS_WRITEBACK)
+			__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4da53f84196f1..2af9b249dc55d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -94,6 +94,135 @@ static bool cifs_io_aborted(struct cifs_io_subrequest *subreq)
 	       tcon->need_reconnect;
 }
 
+static bool cifs_writeback_transient(int rc)
+{
+	if (is_replayable_error(rc) || is_interrupt_error(rc))
+		return true;
+
+	switch (rc) {
+	case -ENOMEM:
+	case -EHOSTDOWN:
+	case -ENETRESET:
+	case -ESHUTDOWN:
+	case -EREMCHG:
+	case -EBADF:
+		return true;
+	}
+	return false;
+}
+
+static int cifs_writeback_error(struct netfs_io_subrequest *subreq, int rc)
+{
+	if (subreq->rreq->origin == NETFS_WRITEBACK &&
+	    cifs_writeback_transient(rc))
+		return -EIO;
+	return rc;
+}
+
+static bool cifs_writeback_dying(struct netfs_io_subrequest *subreq)
+{
+	return subreq->rreq->origin == NETFS_WRITEBACK &&
+		fatal_signal_pending(current);
+}
+
+static unsigned int cifs_ses_reconnects(struct cifs_ses *ses)
+{
+	unsigned int n = 0;
+
+	guard(spinlock)(&ses->chan_lock);
+	for (size_t i = 0; i < ses->chan_count; i++) {
+		struct TCP_Server_Info *server = ses->chans[i].server;
+
+		if (server)
+			n += READ_ONCE(server->reconnect_instance);
+	}
+	return n;
+}
+
+static bool cifs_tcon_reconnecting(struct cifs_tcon *tcon)
+{
+	struct cifs_ses *ses = tcon->ses;
+
+	if (tcon->need_reconnect)
+		return true;
+
+	guard(spinlock)(&ses->chan_lock);
+	for (size_t i = 0; i < ses->chan_count; i++) {
+		struct TCP_Server_Info *server = ses->chans[i].server;
+
+		if (server && READ_ONCE(server->tcpStatus) == CifsNeedReconnect)
+			return true;
+	}
+	return false;
+}
+
+static int cifs_reopen_file_retry(struct cifsFileInfo *cfile, bool can_flush,
+				  struct cifs_io_subrequest *subreq)
+{
+	bool writeback = subreq->rreq->origin == NETFS_WRITEBACK;
+	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
+	struct cifs_ses *ses = tcon->ses;
+	unsigned int reconnects;
+	bool free_retry = true;
+	bool retrying = false;
+	int rc;
+
+	if (writeback && READ_ONCE(subreq->req->reopen_gave_up))
+		return -EIO;
+
+	for (;;) {
+		if ((retrying && cifs_io_stopped(subreq)) ||
+		    cifs_io_aborted(subreq))
+			return -EIO;
+		retrying = true;
+		reconnects = cifs_ses_reconnects(ses);
+		rc = cifs_reopen_file(cfile, can_flush);
+		if (!rc || is_interrupt_error(rc) ||
+		    cifs_writeback_dying(&subreq->subreq))
+			return rc;
+		if (!is_replayable_error(rc) &&
+		    !(writeback && cifs_writeback_transient(rc)))
+			return rc;
+		if (free_retry && !cifs_io_stopped(subreq) &&
+		    (cifs_ses_reconnects(ses) != reconnects ||
+		     cifs_tcon_reconnecting(tcon))) {
+			free_retry = false;
+			continue;
+		}
+		if (!cifs_io_should_replay(subreq)) {
+			if (writeback)
+				WRITE_ONCE(subreq->req->reopen_gave_up, true);
+			return rc;
+		}
+		msleep(subreq->cur_sleep);
+	}
+}
+
+/*
+ * Record, as generation + 1 (0 means none), the newest reopen generation of a
+ * handle that a writeback subrequest found bad (-EBADF).  Subrequests of the
+ * same request can fail concurrently on different channels, so keep the newest.
+ */
+static void cifs_mark_bad_handle(struct cifs_io_request *req, unsigned int gen)
+{
+	int cur = atomic_read(&req->bad_reopens);
+	int want = gen + 1;
+
+	while (want > cur && !atomic_try_cmpxchg(&req->bad_reopens, &cur, want))
+		;
+}
+
+static void cifs_invalidate_bad_handle(struct cifs_io_request *req)
+{
+	struct cifsFileInfo *cfile = req->cfile;
+	unsigned int bad;
+
+	guard(mutex)(&cfile->fh_mutex);
+	bad = atomic_read(&req->bad_reopens);
+	if (bad && bad - 1 == cfile->reopens)
+		cfile->invalidHandle = true;
+}
+
 /*
  * Prepare a subrequest to upload to the server.  We need to allocate credits
  * so that we know the maximum amount of data that we can include in it.
@@ -129,13 +258,12 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		cifs_negotiate_wsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
 
-retry:
+	cifs_invalidate_bad_handle(req);
+
 	if (open_file->invalidHandle) {
-		rc = cifs_reopen_file(open_file, false);
+		rc = cifs_reopen_file_retry(open_file, false, wdata);
 		if (rc < 0) {
-			if (rc == -EAGAIN)
-				goto retry;
-			subreq->error = rc;
+			subreq->error = cifs_writeback_error(subreq, rc);
 			return netfs_prepare_write_failed(subreq);
 		}
 	}
@@ -143,7 +271,7 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	rc = server->ops->wait_mtu_credits(server, wsize, &stream->sreq_max_len,
 					   &wdata->credits);
 	if (rc < 0) {
-		subreq->error = rc;
+		subreq->error = cifs_writeback_error(subreq, rc);
 		return netfs_prepare_write_failed(subreq);
 	}
 
@@ -167,12 +295,6 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 #endif
 }
 
-static bool cifs_writeback_dying(struct netfs_io_subrequest *subreq)
-{
-	return subreq->rreq->origin == NETFS_WRITEBACK &&
-		fatal_signal_pending(current);
-}
-
 /*
  * Issue a subrequest to upload to the server.
  */
@@ -196,13 +318,18 @@ static void __cifs_issue_write(struct netfs_io_subrequest *subreq)
 	if (rc)
 		goto fail;
 
-	rc = -EAGAIN;
-	if (wdata->req->cfile->invalidHandle)
-		goto fail;
-
 	if (wdata->replay && wdata->cur_sleep)
 		msleep(wdata->cur_sleep);
 
+	rc = -EAGAIN;
+	if (wdata->req->cfile->invalidHandle ||
+	    (wdata->credits.value &&
+	     wdata->credits.instance !=
+	     READ_ONCE(wdata->server->reconnect_instance)))
+		goto fail;
+
+	/* pairs with smp_store_release() in cifs_reopen_file() */
+	wdata->reopens = smp_load_acquire(&wdata->req->cfile->reopens);
 	wdata->server->ops->async_writev(wdata);
 out:
 	return;
@@ -221,10 +348,22 @@ static void __cifs_issue_write(struct netfs_io_subrequest *subreq)
 
 static void cifs_issue_write_worker(struct work_struct *work)
 {
-	struct netfs_io_subrequest *subreq;
+	struct cifs_io_subrequest *wdata;
+	struct cifsFileInfo *cfile;
+	int rc = 0;
 
-	subreq = container_of(work, struct netfs_io_subrequest, work);
-	__cifs_issue_write(subreq);
+	wdata = container_of(work, struct cifs_io_subrequest, subreq.work);
+	cfile = wdata->req->cfile;
+	cifs_invalidate_bad_handle(wdata->req);
+	if (cfile->invalidHandle)
+		rc = cifs_reopen_file_retry(cfile, false, wdata);
+	if (rc) {
+		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
+		cifs_write_subrequest_terminated(wdata,
+				cifs_writeback_error(&wdata->subreq, rc));
+		return;
+	}
+	__cifs_issue_write(&wdata->subreq);
 }
 
 static void cifs_issue_write(struct netfs_io_subrequest *subreq)
@@ -272,6 +411,12 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		cifs_negotiate_rsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
 
+	if (req->cfile->invalidHandle) {
+		rc = cifs_reopen_file_retry(req->cfile, true, rdata);
+		if (rc)
+			return rc;
+	}
+
 	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
 					   &size, &rdata->credits);
 	if (rc)
@@ -324,29 +469,32 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 
 	rc = adjust_credits(server, rdata, cifs_trace_rw_credits_issue_read_adjust);
 	if (rc)
-		goto failed;
+		goto not_sent;
 
-	if (req->cfile->invalidHandle) {
-		do {
-			rc = cifs_reopen_file(req->cfile, true);
-		} while (rc == -EAGAIN);
-		if (rc)
-			goto failed;
-	}
+	if (rdata->replay && rdata->cur_sleep)
+		msleep(rdata->cur_sleep);
+
+	rc = -EAGAIN;
+	if (req->cfile->invalidHandle ||
+	    (rdata->credits.value &&
+	     rdata->credits.instance != READ_ONCE(server->reconnect_instance)))
+		goto not_sent;
 
 	if (subreq->rreq->origin != NETFS_UNBUFFERED_READ &&
 	    subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
-	if (rdata->replay && rdata->cur_sleep)
-		msleep(rdata->cur_sleep);
-
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	rc = rdata->server->ops->async_readv(rdata);
 	if (rc)
 		goto failed;
 	return;
 
+not_sent:
+	if (rc == -EAGAIN) {
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+		__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+	}
 failed:
 	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 	subreq->error = rc;
@@ -1522,6 +1670,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
+	/* pairs with smp_load_acquire() in __cifs_issue_write() */
+	smp_store_release(&cfile->reopens, cfile->reopens + 1);
 	cfile->invalidHandle = false;
 	mutex_unlock(&cfile->fh_mutex);
 	cinode = CIFS_I(inode);
@@ -2740,14 +2890,20 @@ void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t
 		spin_unlock(&inode->i_lock);
 	}
 
-	if ((is_interrupt_error(result) || result == -ENOMEM) &&
-	    wreq->origin == NETFS_WRITEBACK && cifs_io_should_replay(wdata)) {
+	if (wreq->origin == NETFS_WRITEBACK &&
+	    !test_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags) &&
+	    cifs_writeback_transient(result) && cifs_io_should_replay(wdata)) {
+		if (result == -EBADF)
+			cifs_mark_bad_handle(wdata->req, wdata->reopens);
 		wdata->replay = true;
 		trace_netfs_sreq(&wdata->subreq,
 				 netfs_sreq_trace_io_retry_needed);
 		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 	}
 
+	if (result < 0 &&
+	    !test_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags))
+		result = cifs_writeback_error(&wdata->subreq, result);
 	netfs_write_subrequest_terminated(&wdata->subreq, result);
 }
 
-- 
2.53.0

