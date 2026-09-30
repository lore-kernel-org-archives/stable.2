Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D903BED38
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797759; cv=none; b=f3bUyJEGERuIkeHPCeE7RC8BZ+ggwrnvIQ/r5kQy6FpGidMDHTAGrNBcu2TNimbMmy0kcwApMgdb31rkn7sJWh1RAHDd3awy4D+PVYA3dqcbcZJebVPteIL18mbwfc+jTZKt+bi71gIUpgD3pI4tiBt7eWT3uzN49+8qgg0jY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797759; c=relaxed/simple;
	bh=lNHkqRahvJwG75tv08IzPmZvLDWsM5m6o8UCjd6LHoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFcaO44rUXAjwxKruA4fvIWMCxCJSBZP+pvOhBw1gFdALre4OJYVh2q9sEsP5pQPsP53vvIwc6BuJJ9R59lPFNcjv2Ncu3pMxIykBE0qfY0kBescQwrhXGwOVfJ7re9Ma/R1FvMgpNsZ0qFRPlz9qy7BkAc6+I91O9gzRqD7prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH7cWhpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH7cWhpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728751F00899;
	Wed, 30 Sep 2026 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797755;
	bh=ZT8Q3F3f7U9EBIWVWU6KGB1+arHIzdSkQy244Vwh91Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lH7cWhpKq7+Lq7wQf3aLnxm/nKTrVyl0s32ylD1C7D/ObXPeaxFhi0kAfB9eQN7Uy
	 9JXIChkE0tVYRXucQLWXBGWQHpEcLi9MgUNOH/N9+P+n+E3vc3uBbIB6Si0Sl7yx/9
	 7dQCzjs5QxK/VjckxhRTqWkxHBAbAU/3HBkxtfj8mSdtiOsZ8iHDq4LrHgCmbpSqPD
	 TQI/CE9EWp7DBe//TueBZ9quEiXzvjVtegJoj9TcIZJ6iTyCo5oxSzXFWd+Cz37/QN
	 HSby7BSPVSDe/WMR6YpmHEwrffpLfrknluR/YZ7HiBx4QLZs2CBstILtF567bDOd5h
	 DfHWPM0yI0QVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] smb/client: pass cifs_open_info_data to SMB2_open()
Date: Wed, 30 Sep 2026 15:49:10 -0400
Message-ID: <20260930194911.886968-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930194911.886968-1-sashal@kernel.org>
References: <2026092945-chowder-rearview-c340@gregkh>
 <20260930194911.886968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 1f551e407bb49dce0bbd34ed6a499dad69e18020 ]

Let SMB2_open() fill the smb2_file_all_info embedded in cifs_open_info_data
directly. This removes the temporary smb2_file_all_info copy in
smb2_open_file().

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>

For the 6.6 backport, keep the existing retry delay initialization and
header declaration style. Move the existing open-done trace after create
context parsing, retaining the stable six-argument tracepoint signature.
This supplies the context needed to apply the follow-up handle cleanup in
566820af017e ("smb: client: close handle after create-context parsing
failure") without importing the newer tracepoint API.

Stable-dep-of: 566820af017e ("smb: client: close handle after create-context parsing failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/link.c      |  6 +++---
 fs/smb/client/smb2file.c  | 19 ++++++++-----------
 fs/smb/client/smb2pdu.c   | 31 ++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  2 +-
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index e1b23e7bd1b61..221585e846c1f 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -343,7 +343,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info file_info = {};
+	struct cifs_open_info_data data = {};
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -359,12 +359,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	if (utf16_path == NULL)
 		return -ENOMEM;
 
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, &file_info, NULL,
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, &data, NULL,
 		       NULL, NULL);
 	if (rc)
 		goto qmf_out_open_fail;
 
-	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (data.fi.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		/* it's not a symlink */
 		rc = -ENOENT; /* Is there a better rc to return? */
 		goto qmf_out;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 134155669a59c..4444eea01e01d 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -111,8 +111,6 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 	__le16 *smb2_path;
 	__u8 smb2_oplock;
 	struct cifs_open_info_data *data = buf;
-	struct smb2_file_all_info file_info = {};
-	struct smb2_file_all_info *smb2_data = data ? &file_info : NULL;
 	struct kvec err_iov = {};
 	int err_buftype = CIFS_NO_BUFFER;
 	struct cifs_fid *fid = oparms->fid;
@@ -129,14 +127,14 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 	}
 	smb2_oplock = SMB2_OPLOCK_LEVEL_BATCH;
 
-	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
+	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data, NULL, &err_iov,
 		       &err_buftype);
 	if (rc == -EACCES && retry_without_read_attributes) {
 		free_rsp_buf(err_buftype, err_iov.iov_base);
 		memset(&err_iov, 0, sizeof(err_iov));
 		err_buftype = CIFS_NO_BUFFER;
 		oparms->desired_access &= ~FILE_READ_ATTRIBUTES;
-		rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
+		rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data, NULL, &err_iov,
 			       &err_buftype);
 	}
 	if (rc && data) {
@@ -149,9 +147,9 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 							 oparms->path,
 							 &data->symlink_target);
 			if (!rc) {
-				memset(smb2_data, 0, sizeof(*smb2_data));
+				memset(&data->fi, 0, sizeof(data->fi));
 				oparms->create_options |= OPEN_REPARSE_POINT;
-				rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data,
+				rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, data,
 					       NULL, NULL, NULL);
 				oparms->create_options &= ~OPEN_REPARSE_POINT;
 			}
@@ -180,23 +178,22 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 		rc = 0;
 	}
 
-	if (smb2_data) {
+	if (data) {
 		/* if open response does not have IndexNumber field - get it */
-		if (smb2_data->IndexNumber == 0) {
+		if (data->fi.IndexNumber == 0) {
 			rc = SMB2_get_srv_num(xid, oparms->tcon,
 				      fid->persistent_fid,
 				      fid->volatile_fid,
-				      &smb2_data->IndexNumber);
+				      &data->fi.IndexNumber);
 			if (rc) {
 				/*
 				 * let get_inode_info disable server inode
 				 * numbers
 				 */
-				smb2_data->IndexNumber = 0;
+				data->fi.IndexNumber = 0;
 				rc = 0;
 			}
 		}
-		memcpy(&data->fi, smb2_data, sizeof(data->fi));
 	}
 
 	*oplock = smb2_oplock;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 8bb739d150c05..a2dc353b6e691 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3190,7 +3190,7 @@ SMB2_open_free(struct smb_rqst *rqst)
 
 int
 SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
-	  __u8 *oplock, struct smb2_file_all_info *buf,
+	  __u8 *oplock, struct cifs_open_info_data *buf,
 	  struct create_posix_rsp *posix,
 	  struct kvec *err_iov, int *buftype)
 {
@@ -3205,6 +3205,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int rc = 0;
 	int flags = 0;
 	int retries = 0, cur_sleep = 1;
+	struct smb2_file_all_info *file_info = buf ? &buf->fi : NULL;
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -3260,9 +3261,6 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 		goto creat_exit;
 	} else if (rsp == NULL) /* unlikely to happen, but safer to check */
 		goto creat_exit;
-	else
-		trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
-				     oparms->create_options, oparms->desired_access);
 
 	atomic_inc(&tcon->num_remote_opens);
 	oparms->fid->persistent_fid = rsp->PersistentFileId;
@@ -3272,21 +3270,24 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	oparms->fid->mid = le64_to_cpu(rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	if (buf) {
-		buf->CreationTime = rsp->CreationTime;
-		buf->LastAccessTime = rsp->LastAccessTime;
-		buf->LastWriteTime = rsp->LastWriteTime;
-		buf->ChangeTime = rsp->ChangeTime;
-		buf->AllocationSize = rsp->AllocationSize;
-		buf->EndOfFile = rsp->EndofFile;
-		buf->Attributes = rsp->FileAttributes;
-		buf->NumberOfLinks = cpu_to_le32(1);
-		buf->DeletePending = 0;
+	if (file_info) {
+		file_info->CreationTime = rsp->CreationTime;
+		file_info->LastAccessTime = rsp->LastAccessTime;
+		file_info->LastWriteTime = rsp->LastWriteTime;
+		file_info->ChangeTime = rsp->ChangeTime;
+		file_info->AllocationSize = rsp->AllocationSize;
+		file_info->EndOfFile = rsp->EndofFile;
+		file_info->Attributes = rsp->FileAttributes;
+		file_info->NumberOfLinks = cpu_to_le32(1);
+		file_info->DeletePending = 0;
 	}
 
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
-				 oparms->fid->lease_key, oplock, buf, posix);
+				 oparms->fid->lease_key, oplock, file_info, posix);
+
+	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
+			     oparms->create_options, oparms->desired_access);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index f553e3edd54ec..da0adcb6a06d0 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -154,7 +154,7 @@ extern int SMB2_tcon(const unsigned int xid, struct cifs_ses *ses,
 extern int SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon);
 extern int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms,
 		     __le16 *path, __u8 *oplock,
-		     struct smb2_file_all_info *buf,
+		     struct cifs_open_info_data *buf,
 		     struct create_posix_rsp *posix,
 		     struct kvec *err_iov, int *resp_buftype);
 extern int SMB2_open_init(struct cifs_tcon *tcon,
-- 
2.53.0

