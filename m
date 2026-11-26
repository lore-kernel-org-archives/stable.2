Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668430;
	b=TKOO6Wvm8nWRKMeZcp24QqSiDpqxEWyKcAQCOV4QCiaTLRJb0rVLzbdqUt3PpclNtlTo
	 jBqx06K2gzqH5cVWRXitF6l/JMCN27RFAEYbRq0R2yZcgwOOO8H+6MrXYvrQReD6PJyE6
	 kOcJaYAQn/RfsVWnc5TPimtWmpIMa7g8x8TD5cgYdFyNs8EfHOqN5xSw+OLeSYshapTpL
	 JD2QRJBV+QAynbrdkyQI50At3FVFOyDnAbBH4nAsBjqo4qBGqAl9dzZrv6W+lkz4cL3vW
	 JXVEqY6f8bGIKJ1EPCX32qBmVUKHYOh2RxSDhEGIgD1KPAMHBEBmtLXF2C+VuUCeo1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wpv2ma+aWQ3mtj3uBkdAWp+gART5t9GqEa8Fwi3uuJY=;
	b=nk1ELeKrswKfJI1EIQCmgRQ3Dwbmz1MhayVelmH2Km+cvcRb+xwe/D2U+OL+4idaYZJU
	 wiz31f5JCgiVi9CgT7VHn+05gVPaUIoPh+q3dcw+QFWPOhoTl2MSgVNTo8Gn7lqB6EhWc
	 Um1M4TMnuPMTbCJI2GJ1dXvQW4jfnKJbvq9ukjK28BIF27oQQeP4WlvgVSGZZfcvYXSCS
	 g4vu+KA9z0SwEN3UKn+g0dOjx09BSy7UwvoCWwwbN8hqLcYcuR5GV2L7I346Ks1/W0aBM
	 w4akuzj6jMhG7H2uaqAf0mBPBJ8u0QOcI/FR06vig0WvC3QJs9wCjwRGRg8E6WzS1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aahcQV4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aahcQV4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A40D1F000C0;
	Thu, 26 Nov 2026 04:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668429;
	bh=Wpv2ma+aWQ3mtj3uBkdAWp+gART5t9GqEa8Fwi3uuJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aahcQV4wXRRZjjvretHfIxOoToJKHpsEKDzoC+O5YaMtd8I7ZRdVCMje3ENu8eU/b
	 tdKc6+cqxesGYcBqqn9so7FNrvKcWFtUaAqKIobMM+XWFSEuOfA+8rCNIBP693S2lQ
	 Qdr2n8nBUrxEyBBvGULX4MDSTDiQLXK25QSr+bcjHOwXroFjjxjRW08LNXhqkOU6R8
	 uPGdxAbeW6fOKsCq74UxKBkwUNbdLE49ZJzpf/ze8DF5tLsJhbmuOBkm3jVEq3YYAI
	 TqJsnNN6QcCFv8XQgWb0aKYolK3XpO3vVgMHXDB8Rca7JzD6sAk25TntGZ8MFU8Rzk
	 XEwd10L/tld/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 5/5] smb: client: don't replay handle reopens inside SMB2_open()
Date: Wed, 25 Nov 2026 23:47:02 -0500
Message-ID: <20261126044608.1960941-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126044608.1960941-1-sashal@kernel.org>
References: <2026112529-flatly-mammal-3d12@gregkh>
 <20261126044608.1960941-1-sashal@kernel.org>
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

[ Upstream commit 9bd8ee0c16146a3d0a401b39dc4cb1a84144c956 ]

cifs_reopen_file_retry() reopens a read's or write's handle with backoff,
per the hard and retrans mount options, giving up on umount -f.  It calls
cifs_reopen_file() -> SMB2_open(), which replays replayable errors on its
own, also per hard and retrans.  So each reopen is retried at both
layers: up to (retrans + 1)^2 opens on a soft mount, and, on a hard
mount, forever inside SMB2_open() without ever returning to
cifs_reopen_file_retry() to notice umount -f - a worker doing writeback
then can't be stopped.

Have cifs_reopen_file_retry() tell SMB2_open() not to replay, so these
reopens are bounded and stopped only by cifs_reopen_file_retry().  Other
callers of cifs_reopen_file() keep SMB2_open()'s replay; SMB1 opens are
unchanged.

A reopen reconnects the durable handle or, if the server lost it, opens
the file afresh.  Without SMB2_open()'s loop, a retry must open afresh
again rather than reconnect, which the server would reject, and replay
its last create, with the same GUID and access and keeping its access
fallbacks, if that create may have been processed, or it leaks or loses
a handle.  Track both on the open file under fh_mutex, so concurrent
reopens agree: replay only after a create that SMB2_open() built and
that failed with no answer from the server, or only a retryable one to
its replay, and leave the state alone after an attempt that was
interrupted or never built.

SMB2_open()'s own loop retried a failed durable reconnect as a fresh open
with a stale GUID, and smb2_open_file()'s retry without
FILE_READ_ATTRIBUTES as a fresh open, skipping the relock; have both
reissue the same create, only replay a create that was built, and don't
leave SMB2_open()'s own replay state behind for the caller's next create.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Fixes: 79520587fe42 ("cifs: update the same create_guid on replay")
Fixes: e255612b5ed9 ("cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  5 +++++
 fs/smb/client/file.c     | 45 ++++++++++++++++++++++++++++++----------
 fs/smb/client/smb2file.c | 18 +++++++++++-----
 fs/smb/client/smb2pdu.c  | 45 +++++++++++++++++++++++++++++++++-------
 4 files changed, 89 insertions(+), 24 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 219f991fe435a..db0e9fc14fb28 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1414,6 +1414,8 @@ struct cifs_open_parms {
 	umode_t mode;
 	bool reconnect:1;
 	bool replay:1; /* indicates that this open is for a replay */
+	bool no_replay:1; /* don't replay this open internally */
+	bool pending:1; /* in/out: last built create had no answer */
 	struct kvec *ea_cctx;
 	__le32 lease_flags;
 };
@@ -1466,6 +1468,9 @@ struct cifsFileInfo {
 	spinlock_t file_info_lock; /* protects four flag/count fields above */
 	struct mutex fh_mutex; /* prevents reopen race after dead ses*/
 	unsigned int reopens;
+	bool reopen_fresh; /* durable handle gone: reopen opens afresh */
+	bool reopen_replay; /* reopen replays its last create */
+	int reopen_access; /* desired access of that create */
 	struct cifs_search_info srch_inf;
 	struct work_struct oplock_break; /* work for oplock breaks */
 	struct work_struct put; /* work for the final part of _put */
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ac2fd53e27f2e..f2ab7618034e8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -37,7 +37,11 @@
 #include "cached_dir.h"
 #include <trace/events/netfs.h>
 
-static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
+/* flags for cifs_reopen_file() */
+#define CIFS_REOPEN_BOUND	BIT(0)	/* caller bounds the retries */
+
+static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush,
+			    unsigned int flags);
 
 bool cifs_io_stopped(struct cifs_io_subrequest *subreq)
 {
@@ -176,7 +180,7 @@ static int cifs_reopen_file_retry(struct cifsFileInfo *cfile, bool can_flush,
 			return -EIO;
 		retrying = true;
 		reconnects = cifs_ses_reconnects(ses);
-		rc = cifs_reopen_file(cfile, can_flush);
+		rc = cifs_reopen_file(cfile, can_flush, CIFS_REOPEN_BOUND);
 		if (!rc || is_interrupt_error(rc) ||
 		    cifs_writeback_dying(&subreq->subreq))
 			return rc;
@@ -1564,7 +1568,7 @@ static bool reopen_aborted(struct cifs_tcon *tcon, int aborts)
 }
 
 static int
-cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
+cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush, unsigned int flags)
 {
 	int rc = -EACCES;
 	unsigned int xid;
@@ -1582,6 +1586,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	struct cifs_open_parms oparms;
 	int rdwr_for_fscache = 0;
 	int aborts;
+	bool fresh;
 
 	tcon = tlink_tcon(cfile->tlink);
 	aborts = atomic_read(&tcon->umount_aborts);
@@ -1655,6 +1660,10 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) == O_WRONLY)
 		rdwr_for_fscache = 1;
 
+	if (cfile->reopen_replay && rdwr_for_fscache == 1 &&
+	    !(cfile->reopen_access & GENERIC_READ))
+		rdwr_for_fscache = 2;
+
 	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
 	create_options |= cifs_open_create_options(cfile->f_flags,
 						   create_options);
@@ -1663,15 +1672,20 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		server->ops->get_lease_key(inode, &cfile->fid);
 
 retry_open:
+	fresh = cfile->reopen_fresh;
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
-		.desired_access = desired_access,
+		.desired_access = cfile->reopen_replay ?
+				  cfile->reopen_access : desired_access,
 		.create_options = cifs_create_options(cifs_sb, create_options),
 		.disposition = disposition,
 		.path = full_path,
 		.fid = &cfile->fid,
-		.reconnect = true,
+		.reconnect = !fresh,
+		.replay = cfile->reopen_replay,
+		.pending = cfile->reopen_replay,
+		.no_replay = !!(flags & CIFS_REOPEN_BOUND),
 	};
 
 	/*
@@ -1685,16 +1699,24 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		rc = -EHOSTDOWN;
 	else
 		rc = server->ops->open(xid, &oparms, &oplock, NULL);
-	if (rc == -ENOENT && oparms.reconnect == false) {
+	if (rc == -ENOENT && !fresh && !oparms.reconnect && !oparms.pending) {
 		/* durable handle timeout is expired - open the file again */
+		fresh = true;
+		oparms.desired_access = desired_access;
+		oparms.replay = false;
 		if (reopen_aborted(tcon, aborts))
 			rc = -EHOSTDOWN;
 		else
 			rc = server->ops->open(xid, &oparms, &oplock, NULL);
-		/* indicate that we need to relock the file */
-		oparms.reconnect = true;
 	}
-	if (rc == -EACCES && rdwr_for_fscache == 1) {
+	cfile->reopen_fresh = rc && fresh;
+	cfile->reopen_replay = rc && oparms.pending;
+	if (cfile->reopen_replay)
+		cfile->reopen_access = oparms.desired_access;
+	/* indicate that we need to relock the file */
+	if (fresh)
+		oparms.reconnect = true;
+	if (rc == -EACCES && rdwr_for_fscache == 1 && !oparms.pending) {
 		desired_access = cifs_convert_flags(cfile->f_flags, 0);
 		rdwr_for_fscache = 2;
 		goto retry_open;
@@ -1874,7 +1896,8 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
 	spin_unlock(&tcon->open_file_lock);
 
 	list_for_each_entry_safe(open_file, tmp, &tmp_list, rlist) {
-		if (cifs_reopen_file(open_file, false /* do not flush */))
+		/* do not flush */
+		if (cifs_reopen_file(open_file, false, 0))
 			tcon->need_reopen_files = true;
 		list_del_init(&open_file->rlist);
 		cifsFileInfo_put(open_file);
@@ -3104,7 +3127,7 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 			*ret_file = inv_file;
 			return 0;
 		}
-		rc = cifs_reopen_file(inv_file, false);
+		rc = cifs_reopen_file(inv_file, false, 0);
 		if (!rc) {
 			*ret_file = inv_file;
 			return 0;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index fb2fccbe86677..764cfd894ad09 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -175,6 +175,7 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 	struct cifs_fid *fid = oparms->fid;
 	struct network_resiliency_req nr_ioctl_req;
 	bool retry_without_read_attributes = false;
+	bool reconnect = oparms->reconnect;
 
 	smb2_path = cifs_convert_path_to_utf16(oparms->path, oparms->cifs_sb);
 	if (smb2_path == NULL)
@@ -186,23 +187,30 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 	 * FILE_READ_ATTRIBUTES when not needed and prevent calling code path
 	 * for retry_without_read_attributes.
 	 */
-	if (!(oparms->desired_access & FILE_READ_ATTRIBUTES) &&
-	    !(oparms->desired_access & GENERIC_READ) &&
+	if (!(oparms->desired_access & GENERIC_READ) &&
 	    !(oparms->desired_access & GENERIC_EXECUTE) &&
 	    !(oparms->desired_access & GENERIC_ALL) &&
 	    !(oparms->desired_access & MAXIMUM_ALLOWED)) {
-		oparms->desired_access |= FILE_READ_ATTRIBUTES;
-		retry_without_read_attributes = true;
+		if (oparms->replay) {
+			retry_without_read_attributes =
+				oparms->desired_access & FILE_READ_ATTRIBUTES;
+		} else if (!(oparms->desired_access & FILE_READ_ATTRIBUTES)) {
+			oparms->desired_access |= FILE_READ_ATTRIBUTES;
+			retry_without_read_attributes = true;
+		}
 	}
 	smb2_oplock = SMB2_OPLOCK_LEVEL_BATCH;
 
 	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data, NULL, &err_iov,
 		       &err_buftype);
-	if (rc == -EACCES && retry_without_read_attributes) {
+	if (rc == -EACCES && retry_without_read_attributes &&
+	    !oparms->pending) {
 		free_rsp_buf(err_buftype, err_iov.iov_base);
 		memset(&err_iov, 0, sizeof(err_iov));
 		err_buftype = CIFS_NO_BUFFER;
 		oparms->desired_access &= ~FILE_READ_ATTRIBUTES;
+		oparms->reconnect = reconnect;
+		oparms->replay = false;
 		rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data, NULL, &err_iov,
 			       &err_buftype);
 	}
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 679ab668051cb..4fd6fe8f6d742 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3363,14 +3363,25 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int flags = 0;
 	int retries = 0, cur_sleep = 0;
 	struct smb2_file_all_info *file_info = buf ? &buf->fi : NULL;
+	bool reconnect = oparms->reconnect;
+	bool replay = oparms->replay;
+	bool unanswered = replay;
+	bool answered;
+	bool sent;
 
 replay_again:
 	/* reinitialize for possible replay */
+	answered = false;
+	sent = false;
 	resp_buftype = CIFS_NO_BUFFER;
 	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
-	oparms->replay = !!(retries);
+	/* reissue the same create: a durable reconnect clears ->reconnect */
+	oparms->reconnect = reconnect;
+	/* with no_replay the caller owns oparms->replay */
+	if (!oparms->no_replay)
+		oparms->replay = unanswered;
 
 	cifs_dbg(FYI, "create/open\n");
 	if (!ses || !server)
@@ -3388,21 +3399,22 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 			    &rqst, oplock, oparms, path);
 	if (rc)
 		goto creat_exit;
+	sent = true;
 
 	trace_smb3_open_enter(xid, tcon->tid, tcon->ses->Suid, oparms->path,
 		oparms->create_options, oparms->desired_access);
 
-	if (retries) {
-		/* Back-off before retry */
-		if (cur_sleep)
-			msleep(cur_sleep);
+	/* Back-off before retry */
+	if (cur_sleep)
+		msleep(cur_sleep);
+	if (oparms->replay)
 		smb2_set_replay(server, &rqst);
-	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags,
 			    &rsp_iov);
 	rsp = (struct smb2_create_rsp *)rsp_iov.iov_base;
+	answered = rsp;
 
 	if (rc != 0) {
 		cifs_stats_fail_inc(tcon, SMB2_CREATE_HE);
@@ -3459,10 +3471,27 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
 
-	if (is_replayable_error(rc) &&
-	    smb2_should_replay(tcon, &retries, &cur_sleep))
+	if (sent) {
+		if (!rc || (answered && (!oparms->replay ||
+					 !is_replayable_error(rc))))
+			unanswered = false;
+		else if (!answered && !is_interrupt_error(rc))
+			unanswered = true;
+		oparms->pending = unanswered;
+	}
+
+	if (!oparms->no_replay && is_replayable_error(rc) &&
+	    smb2_should_replay(tcon, &retries, &cur_sleep)) {
+		if (err_iov && answered && !rsp) {
+			free_rsp_buf(*buftype, err_iov->iov_base);
+			*err_iov = (struct kvec){};
+			*buftype = CIFS_NO_BUFFER;
+		}
 		goto replay_again;
+	}
 
+	if (!oparms->no_replay)
+		oparms->replay = replay;
 	return rc;
 }
 
-- 
2.53.0

