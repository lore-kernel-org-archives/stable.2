Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4E345736
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815601; cv=none; b=X3zoyzFkLHl1iJTslWKSWUo1xP7mYv3Q+cmcrRWowh8nxECGVZY8JT3bSK/gEyYnCwuMcXUKXxVx22njUHiYJIpXNp04Ccm5LiTboFdqEdAiQPcKM0+LBdqT75xffpZVTYijpIql1NAaymR8/tsw5UnzRZMMlvwy2lqIgyqWJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815601; c=relaxed/simple;
	bh=9k3QzAn1zOrO37xiDA1A+tita3daJfYpHz3a0etYzPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAxVd1r+xw/xS39ZtvRsMgpHADrLjezBlqMcil6TuMNHJL9o/QaCA3FpsUsuPZcygRzd02duFkyp1MGr1STMqrb6O4fIV2G1B+HfppuhMACxoM5BRW9NqW6YVy2imxotl2iCrNOQ+mbYPASLU2QJW9+wRBOtCtrEk87qFwJjVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0oVWFmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0oVWFmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F061F00898;
	Thu,  1 Oct 2026 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815599;
	bh=7fBYN4j+hUOIk/kwlcxzYGnyoKJs1o3NJy7FeHLYJwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0oVWFmAoaUjCgPBU/MtY0DdilMlZZIDhccML1gC3TAyG2cvWWzcYGmj9HCiCLSNj
	 FKsx9QLV620iu9xrD+7E6Tz5FGdYylc+WaWJH2CLnh5nz04yTWSH4cZEWfZVfs4VoU
	 pzwwCY5XpMc5tCmB0p5VfqY/mB5aTOWePfpDU1kLFwc1XTyDuRrg9FNgvZKOkOU/oy
	 BWjN/kK2i1fwn/pn8aRSAk01KbntSwuBHwEoBPAXs44TPVIaBRWFz/DFTheXnVtvjM
	 lSGZw3Ef6GCiwUPjp0s0sJ/SaaVbVxxjtOs51ME7GUGhaN17KFqOVspeLT6md3u3pf
	 9aGkeinHTF7sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] smb/client: pass cifs_open_info_data to SMB2_open()
Date: Wed, 30 Sep 2026 20:46:35 -0400
Message-ID: <20261001004636.2232529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001004636.2232529-1-sashal@kernel.org>
References: <2026092945-vendor-cesarean-fd29@gregkh>
 <20261001004636.2232529-1-sashal@kernel.org>
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

[5.15 dependency adaptation]
The cifs_open_info_data wrapper is absent from this stable tree. Keep the
existing SMB2_open() argument type and callers, and use the file_info
alias directly for the supplied smb2_file_all_info buffer. Drop the
upstream caller and prototype changes instead of importing newer open
and symlink handling APIs into fs/cifs.

Move the existing success trace after smb2_parse_contexts(), retaining
the six-argument trace interface in 5.15. Together with the file_info
alias, this provides the merge context needed by 566820af017e ("smb:
client: close handle after create-context parsing failure"). No functions
are added, and the handle-close fix remains in the target commit.

[ sashal: Reduced backport -- upstream 1f551e407bb49 touches 4 file(s), this
  backport carries 1. Not backported here:
  fs/smb/client/link.c
  fs/smb/client/smb2file.c
  fs/smb/client/smb2pdu.c
  fs/smb/client/smb2proto.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 566820af017e ("smb: client: close handle after create-context parsing failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index e93dd51a88557..8c46757d4c838 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2939,6 +2939,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
+	struct smb2_file_all_info *file_info = buf;
 
 	cifs_dbg(FYI, "create/open\n");
 	if (!ses || !server)
@@ -2981,10 +2982,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 			tcon->need_reconnect = true;
 		}
 		goto creat_exit;
-	} else
-		trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid,
-				     ses->Suid, oparms->create_options,
-				     oparms->desired_access);
+	}
 
 	atomic_inc(&tcon->num_remote_opens);
 	oparms->fid->persistent_fid = rsp->PersistentFileId;
@@ -2994,21 +2992,24 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
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
-- 
2.53.0

