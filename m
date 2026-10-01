Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874624E4331
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852466; cv=none; b=pr5nGlfD+GnqMdov3J36+VUAan13QNqgbEOY0OwMzfAv7IZVig9o6mqrBfPJkXHeLmrJ25jnZkR9V44/0FEtwpU6IoxK2Gp//GEE7O6Sarfl0TkROY+r4CO9ifCm5JEtWwO/sDtmrxFt8n/3sdKprZnIhWh2UQROOSZoIkK7FI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852466; c=relaxed/simple;
	bh=h5gh2M/HVyGgOZCV6yLHVK7P8U0I6t0pPNlzBXe0a8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai0AB4fUu1nFHne5W1SWdxM9hlEojVzR7/sAsZ5UtfP4jejyR2O+1kRZr/aypfkgmaWJbRAn2g0YaaXYln9m+VK//LVjmn/LsA/C0jnEfCb5743vXo5jXvba5S5kDIrTlHZoNJCBmJi7Cy8Ckisszgkwu+9ObIpGaQZT8OR4LFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opu0uOaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opu0uOaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0351F000FF;
	Thu,  1 Oct 2026 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852465;
	bh=1/cCH8XuLVUXp+ZZDzr7YMqo3PIkbihDCYeScgrHTDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opu0uOaA7cUBXlFSsR/91H0JSkCnEX0BXQAFRCISnJXw46IVv6Q/okIjN8e6fgekR
	 Py/h5AvqHTd7VSn4sZoLdBbsndSUjLtfhkJwF8dV7Mgecu3e1FhLfUzTjL228UL105
	 yY1qMsSrFJpFaxejhTWa3O+NUrnusYcrZZizTmpKm+nuWx3/5AZmEh1X4MnhfI4Nx3
	 WJN5MLR2DEsvL3OfMALdrQ4WIp7n5RS/Vlr50dhDo6J9PagiuSXKkjAw8Rf/iE5CzA
	 IgSRNrk1E3qIrigTuKtChY1mYnztDfiG2WSUv8R00tpT1dwPqgNRVQ21uOZLOL5Iro
	 h7y6AnCB00Plw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] smb/client: pass cifs_open_info_data to SMB2_open()
Date: Thu,  1 Oct 2026 07:01:01 -0400
Message-ID: <20261001110102.3713269-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001110102.3713269-1-sashal@kernel.org>
References: <2026092946-apron-radio-67f9@gregkh>
 <20261001110102.3713269-1-sashal@kernel.org>
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

[5.10 dependency adaptation]
This tree still uses fs/cifs and does not define cifs_open_info_data.
Keep the existing SMB2_open() argument type and the FILE_ALL_INFO
conversion in smb2_open_file(); drop the wrapper-type and caller changes.
Use the dependency's file_info pointer directly on the existing buffer
inside SMB2_open(), preserving the stable metadata-copy behavior.

Move the existing open_done trace after smb2_parse_contexts(), retaining
its six-argument stable signature. Together with the file_info argument,
this allows 566820af017e ("smb: client: close handle after create-context
parsing failure") to cherry-pick cleanly across the directory rename.
No functions are added, and the target's close-on-error fix remains for
the target commit.

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
 fs/cifs/smb2pdu.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 19b4f426e9afa..d8cacdd54acb0 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2875,6 +2875,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
+	struct smb2_file_all_info *file_info = buf;
 
 	cifs_dbg(FYI, "create/open\n");
 	if (!ses || !server)
@@ -2917,10 +2918,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
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
@@ -2930,18 +2928,21 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	oparms->fid->mid = le64_to_cpu(rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	if (buf) {
-		memcpy(buf, &rsp->CreationTime, 32);
-		buf->AllocationSize = rsp->AllocationSize;
-		buf->EndOfFile = rsp->EndofFile;
-		buf->Attributes = rsp->FileAttributes;
-		buf->NumberOfLinks = cpu_to_le32(1);
-		buf->DeletePending = 0;
+	if (file_info) {
+		memcpy(file_info, &rsp->CreationTime, 32);
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

