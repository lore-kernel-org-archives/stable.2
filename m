Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606058;
	b=eRlRz0ce56TZOr73FmS/j3ItHOxq+0n9DaQUvZh3n7Bpl6vkOz1dnvxX6XswUKuwwRI5
	 qSL+qK9im2csbTiNnp7lTuOdgeh5yW4FDZvVa28VWXBM0tHHz+E6bmeiKj0Jzg7B/nYrS
	 CXL4Dk3yEQ6hs6ZudmNiCmOfPRc0s4D9Hltj+X9fSBRIRFrPYozaEkIf3/TGI1lT+finh
	 kVdpN0c+zXf9nwfdm3u3dxO50cd7mqyGkUtx3TEDEfrm3k2lzrjV9RhPoo7sygS5hEM20
	 udPhIvelVeJWtklgiHrm3X+5aqxzsyvdDgmcKOZpRfO94oZImy+Rb4R/JbVu3phPWUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606058;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9WDR9bEUjVwTru7rxoX8f44fOQs9haD/QvU4QZnawiA=;
	b=ug02NsrvBDi+5utp3yySeqkwGcASq2gAT/YjcgG2oNAabU8AhSV77SoUy6Gnp2zxgxH8
	 rJ0bv3zylfhzQODvT/3LLcbP3uR79zeeigXFkaPAlEXyc9HcRefyhoYyeJlSI/xw0weVB
	 tjnzB4Qn8H/CmZ6SCE2zL/THqrh+EBocVmcBfwNWS0Te9GO0k6ksPb7vnHiLcZ8EL38mb
	 qjNKMnwN06E2DSct2jL4TLhQVNxp3eCfLudtWUORU+GSUsvzGBvftw1+GEJYAOZZ7Q3D5
	 XouIngHaCZBgqu+KTBx060w4GgQfDno0TYvYeTHoRl6AysskuQsEVX8G15QK6m40hGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iQgaqVPK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1E606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iQgaqVPK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6041F000C0;
	Wed, 25 Nov 2026 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606057;
	bh=9WDR9bEUjVwTru7rxoX8f44fOQs9haD/QvU4QZnawiA=;
	h=Subject:To:Cc:From:Date;
	b=iQgaqVPKmhvlPKUYbYs8ahUIpTPshR2tFpnm8wMpRYK3b/2XkIo6RlWrW+5OUWhmm
	 W1l2nejd06Q2j772L/1FVy/q3UrsmFAWEJxmxoWbluGFUXZYEUfefUdzvI5EKM97sV
	 idM4xddJutBJ++EtHa5vtBQZ8KR5SsShbqXgAwZU=
Subject: FAILED: patch "[PATCH] smb: client: don't replay handle reopens inside SMB2_open()" failed to apply to 7.3-stable tree
To: pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:15:29 +0100
Message-ID: <2026112529-flatly-mammal-3d12@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9bd8ee0c16146a3d0a401b39dc4cb1a84144c956
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-flatly-mammal-3d12@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bd8ee0c16146a3d0a401b39dc4cb1a84144c956 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Mon, 2 Nov 2026 14:29:09 -0300
Subject: [PATCH] smb: client: don't replay handle reopens inside SMB2_open()

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

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 78ab6abe5297..00a75bba42b0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1410,6 +1410,8 @@ struct cifs_open_parms {
 	umode_t mode;
 	bool reconnect:1;
 	bool replay:1; /* indicates that this open is for a replay */
+	bool no_replay:1; /* don't replay this open internally */
+	bool pending:1; /* in/out: last built create had no answer */
 	struct kvec *ea_cctx;
 	__le32 lease_flags;
 };
@@ -1462,6 +1464,9 @@ struct cifsFileInfo {
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
index b851e9b78f51..f5320d8f4dce 100644
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
@@ -1567,7 +1571,7 @@ static bool reopen_aborted(struct cifs_tcon *tcon, int aborts)
 }
 
 static int
-cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
+cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush, unsigned int flags)
 {
 	int rc = -EACCES;
 	unsigned int xid;
@@ -1585,6 +1589,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	struct cifs_open_parms oparms;
 	int rdwr_for_fscache = 0;
 	int aborts;
+	bool fresh;
 
 	tcon = tlink_tcon(cfile->tlink);
 	aborts = atomic_read(&tcon->umount_aborts);
@@ -1658,6 +1663,10 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) == O_WRONLY)
 		rdwr_for_fscache = 1;
 
+	if (cfile->reopen_replay && rdwr_for_fscache == 1 &&
+	    !(cfile->reopen_access & GENERIC_READ))
+		rdwr_for_fscache = 2;
+
 	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
 	create_options |= cifs_open_create_options(cfile->f_flags,
 						   create_options);
@@ -1666,15 +1675,20 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -1688,16 +1702,24 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -1877,7 +1899,8 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
 	spin_unlock(&tcon->open_file_lock);
 
 	list_for_each_entry_safe(open_file, tmp, &tmp_list, rlist) {
-		if (cifs_reopen_file(open_file, false /* do not flush */))
+		/* do not flush */
+		if (cifs_reopen_file(open_file, false, 0))
 			tcon->need_reopen_files = true;
 		list_del_init(&open_file->rlist);
 		cifsFileInfo_put(open_file);
@@ -3107,7 +3130,7 @@ int __cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
 			*ret_file = inv_file;
 			return 0;
 		}
-		rc = cifs_reopen_file(inv_file, false);
+		rc = cifs_reopen_file(inv_file, false, 0);
 		if (!rc) {
 			*ret_file = inv_file;
 			return 0;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index fb2fccbe8667..764cfd894ad0 100644
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
index 0f248eb52520..8a7b25c77e3c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3349,14 +3349,25 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
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
@@ -3374,21 +3385,22 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
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
@@ -3445,10 +3457,27 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
 
-	if (is_replayable_error(rc) &&
-	    smb2_should_replay(tcon, &retries, &cur_sleep))
-		goto replay_again;
+	if (sent) {
+		if (!rc || (answered && (!oparms->replay ||
+					 !is_replayable_error(rc))))
+			unanswered = false;
+		else if (!answered && !is_interrupt_error(rc))
+			unanswered = true;
+		oparms->pending = unanswered;
+	}
 
+	if (!oparms->no_replay && is_replayable_error(rc) &&
+	    smb2_should_replay(tcon, &retries, &cur_sleep)) {
+		if (err_iov && answered && !rsp) {
+			free_rsp_buf(*buftype, err_iov->iov_base);
+			*err_iov = (struct kvec){};
+			*buftype = CIFS_NO_BUFFER;
+		}
+		goto replay_again;
+	}
+
+	if (!oparms->no_replay)
+		oparms->replay = replay;
 	return rc;
 }
 

