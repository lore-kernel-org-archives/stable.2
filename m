Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1E4FECC4
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781247; cv=none; b=JXL5CmGbls6GQ7ufrxa2N6oy92SIFk0W7DYUmWx2nEa1BOUBRamBvcFqlwcYAGSxnBExtx3qzHTnE+XXmhNyCmCQKpYYT20IZ76KvIB0ga+5GdgqpOq3xcSzotxoQa45SvyW4MXopsAWA9lbtv7UsDystwwGG2y/93LbQyUAZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781247; c=relaxed/simple;
	bh=uhRFEbcL5oUKAfjc75vrEPIbv5YgTOEHmaJGXH6kWmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMnUZkm+a9cDkSS+6TEcdWqfkCssF+0pTYnNR9C2xvt/tULyTnbGucHzH5eBQRAa8FBQ/FR6QBw67YkkDRUd92x3fRF1U0JVLMiGrGBcuYDOsBMb9g6KivK5PHZXiaanMyCssVyRkFSzokXY4TD377UIyU+EaALgAM8iwMtlqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+L/UVP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+L/UVP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470A61F00898;
	Wed, 30 Sep 2026 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781229;
	bh=fAMV2nWm34G8GeY2RG9eSmgebCMQ28Hfz0nYhL8pges=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+L/UVP3TveHSzj8uD6qG3tZ2mslRH8gGBNsHzZ+Vzfrw25lOwru7HcWlRU2mxTj7
	 zPsWhu65Qq7XNO1V7nAsmU34Ul4inzgaQfFyztEE6uE7Jt0Frd0eWqCsWnyyU4NLIp
	 9cAjcxaAOe7/IFa4h82v4Q5ESShkhvvfswwsJlSbw9RyP8SMQcrXWOPAq5hggZJP4W
	 Upe9IVTJ5hzVQfw1B8ygbGhwIw4owxxYE7Qb7DQz7YI5lqwuGTOxuTSYIEqfyxg0hE
	 h4giMF6rJYLfNWqwP/XsXK4nCxTAGj5p4/yFkGAc+LjQHieEQT/V6eFr/5MKPuUDqV
	 R4fz9mHbA10Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] cifs: on replayable errors back-off before replay, not after
Date: Wed, 30 Sep 2026 11:13:44 -0400
Message-ID: <20260930151347.2502416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092944-consensus-idealism-4247@gregkh>
References: <2026092944-consensus-idealism-4247@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 16d480ed4990ed5aefb99c111dd14131a338e3c9 ]

On replayable errors, we call smb2_should_replays that does these
things today:
1. decide if we need to replay the command again
2. sleep to back-off the failed request
3. update the next sleep value

We will not be able to use this for async requests, when this is
processed in callbacks (as this will be called in cifsd threads that
should not sleep in response processing).

Modify the behaviour by taking the sleep out of smb2_should_replay
and performing the sleep for back-off just before actually
performing the replay.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 566820af017e ("smb: client: close handle after create-context parsing failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c |   6 +-
 fs/smb/client/smb2inode.c  |  21 +++++--
 fs/smb/client/smb2ops.c    |  32 ++++++++---
 fs/smb/client/smb2pdu.c    | 112 +++++++++++++++++++++++++++----------
 4 files changed, 129 insertions(+), 42 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index cef855456063a..7e6d2607a221f 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -154,7 +154,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	struct cached_fid *cfid;
 	struct cached_fids *cfids;
 	const char *npath;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 	__le32 lease_flags = 0;
 
 	if (cifs_sb->root == NULL)
@@ -312,6 +312,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	smb2_set_related(&rqst[1]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
+
 		smb2_set_replay(server, &rqst[0]);
 		smb2_set_replay(server, &rqst[1]);
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 2e28a965a25d1..22e943bf14611 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -199,7 +199,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	struct reparse_data_buffer *rbuf;
 	struct TCP_Server_Info *server;
 	int resp_buftype[MAX_COMPOUND];
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 	__u8 delete_pending[8] = {1,};
 	struct kvec *rsp_iov, *iov;
 	struct inode *inode = NULL;
@@ -649,18 +649,26 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	num_rqst++;
 
 	if (cfile) {
-		if (retries)
+		if (retries) {
+			/* Back-off before retry */
+			if (cur_sleep)
+				msleep(cur_sleep);
 			for (i = 1; i < num_rqst - 2; i++)
 				smb2_set_replay(server, &rqst[i]);
+		}
 
 		rc = compound_send_recv(xid, ses, server,
 					flags, num_rqst - 2,
 					&rqst[1], &resp_buftype[1],
 					&rsp_iov[1]);
 	} else {
-		if (retries)
+		if (retries) {
+			/* Back-off before retry */
+			if (cur_sleep)
+				msleep(cur_sleep);
 			for (i = 0; i < num_rqst; i++)
 				smb2_set_replay(server, &rqst[i]);
+		}
 
 		rc = compound_send_recv(xid, ses, server,
 					flags, num_rqst,
@@ -1208,7 +1216,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
 	__le16 *utf16_path __free(kfree) = NULL;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 	struct TCP_Server_Info *server;
 	struct cifs_open_parms oparms;
 	struct smb2_create_req *creq;
@@ -1272,6 +1280,9 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	smb2_set_related(&rqst[1]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		for (int i = 0; i < ARRAY_SIZE(rqst);  i++)
 			smb2_set_replay(server, &rqst[i]);
 	}
@@ -1292,7 +1303,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	if (rc == -EINVAL && dentry) {
 		dentry = NULL;
 		retries = 0;
-		cur_sleep = 1;
+		cur_sleep = 0;
 		goto again;
 	}
 	/*
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index dcf0a9b9647c7..0ab41f241181a 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1210,7 +1210,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb2_file_full_ea_info *ea;
 	struct smb2_query_info_rsp *rsp;
 	int rc, used_len = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -1341,6 +1341,9 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 	smb2_set_related(&rqst[2]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst[0]);
 		smb2_set_replay(server, &rqst[1]);
 		smb2_set_replay(server, &rqst[2]);
@@ -1605,7 +1608,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	void *data[2];
 	int create_options = is_dir ? CREATE_NOT_FILE : CREATE_NOT_DIR;
 	void (*free_req1_func)(struct smb_rqst *r);
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -1755,6 +1758,9 @@ smb2_ioctl_query_info(const unsigned int xid,
 	smb2_set_related(&rqst[2]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst[0]);
 		smb2_set_replay(server, &rqst[1]);
 		smb2_set_replay(server, &rqst[2]);
@@ -2545,7 +2551,7 @@ smb2_query_dir_first(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb2_query_directory_rsp *qd_rsp = NULL;
 	struct smb2_create_rsp *op_rsp = NULL;
 	struct TCP_Server_Info *server;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -2603,6 +2609,9 @@ smb2_query_dir_first(const unsigned int xid, struct cifs_tcon *tcon,
 	smb2_set_related(&rqst[1]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst[0]);
 		smb2_set_replay(server, &rqst[1]);
 	}
@@ -2879,10 +2888,14 @@ bool smb2_should_replay(struct cifs_tcon *tcon,
 		return false;
 
 	if (tcon->retry || (*pretries)++ < tcon->ses->server->retrans) {
-		msleep(*pcur_sleep);
-		(*pcur_sleep) = ((*pcur_sleep) << 1);
-		if ((*pcur_sleep) > CIFS_MAX_SLEEP)
-			(*pcur_sleep) = CIFS_MAX_SLEEP;
+		/* Update sleep time for exponential backoff */
+		if (!(*pcur_sleep))
+			(*pcur_sleep) = 1;
+		else {
+			(*pcur_sleep) = ((*pcur_sleep) << 1);
+			if ((*pcur_sleep) > CIFS_MAX_SLEEP)
+				(*pcur_sleep) = CIFS_MAX_SLEEP;
+		}
 		return true;
 	}
 
@@ -2913,7 +2926,7 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	__le16 *utf16_path;
 	struct cached_fid *cfid;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -3003,6 +3016,9 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 	smb2_set_related(&rqst[2]);
 
 	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		if (!cfid) {
 			smb2_set_replay(server, &rqst[0]);
 			smb2_set_replay(server, &rqst[2]);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c07c5bb321407..200f4e854462c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2840,7 +2840,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	unsigned int total_len;
 	__le16 *utf16_path = NULL;
 	struct TCP_Server_Info *server;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -2953,8 +2953,12 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	trace_smb3_posix_mkdir_enter(xid, tcon->tid, ses->Suid, full_path, CREATE_NOT_FILE,
 				    FILE_WRITE_ATTRIBUTES);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	/* resource #4: response buffer */
 	rc = cifs_send_recv(xid, ses, server,
@@ -3202,7 +3206,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -3232,8 +3236,12 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	trace_smb3_open_enter(xid, tcon->tid, tcon->ses->Suid, oparms->path,
 		oparms->create_options, oparms->desired_access);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags,
@@ -3417,7 +3425,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 	if (!tcon)
 		return -EIO;
@@ -3459,8 +3467,12 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 	if (rc)
 		goto ioctl_exit;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags,
@@ -3614,7 +3626,7 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int flags = 0;
 	bool query_attrs = false;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -3648,8 +3660,12 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	if (rc)
 		goto close_exit;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -3819,7 +3835,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	struct TCP_Server_Info *server;
 	int flags = 0;
 	bool allocated = false;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 	cifs_dbg(FYI, "Query Info\n");
 
@@ -3855,8 +3871,12 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	trace_smb3_query_info_enter(xid, persistent_fid, tcon->tid,
 				    ses->Suid, info_class, (__u32)info_type);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -4012,7 +4032,7 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int flags = 0;
 	int rc = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -4045,8 +4065,12 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 	trace_smb3_notify_enter(xid, persistent_fid, tcon->tid, ses->Suid,
 				(u8)watch_tree, completion_filter);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -4353,7 +4377,7 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int flags = 0;
 	int rc = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -4381,8 +4405,12 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 	trace_smb3_flush_enter(xid, persistent_fid, tcon->tid, ses->Suid);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -5148,7 +5176,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	int flags = 0;
 	unsigned int total_len;
 	struct TCP_Server_Info *server;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -5199,8 +5227,12 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
 		      io_parms->length);
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, io_parms->tcon->ses, server,
 			    &rqst,
@@ -5551,7 +5583,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -5576,8 +5608,12 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 	if (rc)
 		goto qdir_exit;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -5686,7 +5722,7 @@ send_set_info(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -5721,8 +5757,12 @@ send_set_info(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags,
@@ -5801,7 +5841,7 @@ SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	int resp_buf_type;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -5831,8 +5871,12 @@ SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 1;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buf_type, flags, &rsp_iov);
@@ -5934,7 +5978,7 @@ SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 	struct TCP_Server_Info *server;
 	FILE_SYSTEM_POSIX_INFO *info = NULL;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -5955,8 +5999,12 @@ SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 	rqst.rq_iov = &iov;
 	rqst.rq_nvec = 1;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -5999,7 +6047,7 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	struct TCP_Server_Info *server;
 	unsigned int rsp_len, offset;
 	int flags = 0;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -6036,8 +6084,12 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	rqst.rq_iov = &iov;
 	rqst.rq_nvec = 1;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, ses, server,
 			    &rqst, &resp_buftype, flags, &rsp_iov);
@@ -6099,7 +6151,7 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 	int flags = CIFS_NO_RSP_BUF;
 	unsigned int total_len;
 	struct TCP_Server_Info *server;
-	int retries = 0, cur_sleep = 1;
+	int retries = 0, cur_sleep = 0;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -6135,8 +6187,12 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
 
-	if (retries)
+	if (retries) {
+		/* Back-off before retry */
+		if (cur_sleep)
+			msleep(cur_sleep);
 		smb2_set_replay(server, &rqst);
+	}
 
 	rc = cifs_send_recv(xid, tcon->ses, server,
 			    &rqst, &resp_buf_type, flags,
-- 
2.53.0

