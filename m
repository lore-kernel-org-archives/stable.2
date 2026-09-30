Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F4519E12
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789641; cv=none; b=p+xNU2RzhJgs9LMIVauCVIhIoZMnuBc6jRUvPNhTL6SxrFffzR17SOZO4XYlIeFt3SDvRqQUGAI19jVdAt7Uy0groG3RZrj7ksPjJO4w/AzVVd2O7rADYndCk0nyIrJy6OZTycdRdFRnjn2jaqzRB2hTVv4URwUq6KRnJ5he4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789641; c=relaxed/simple;
	bh=UoqrkNW+nLv17GXlUFsEr/eiBmTXFxLlIjlnTbSakxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knPdyCvA/x3rjDz7H1xlpuqmCjTOsG6fLG6iKVcyyb0gnlcSWnvdESDyNR/ULgApylgR1YKvyWha0T+KhItkAD/CA1aX0v98BHlgLee4bnjzFuMjFD9psTZSzFqZK7818YAAr44nDTD4QbstzblcqyvjLbRjLDUKTpnhczs4GkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoU/8Px0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoU/8Px0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A7F1F00898;
	Wed, 30 Sep 2026 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789640;
	bh=tkcj9Yn+Jn1EHjljPMUkSlqVuZwgbXbaZO1QRgcBDyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UoU/8Px0ov5EWVl+PFCZ/AOhbrhxVoyt0/ukmTnujgvPjJkc0Mpao+AYDzVGY2BBc
	 Xhrx4zD87FT03XcUULJRa6VwIjxfmD7yTl2rLLhTt5cjoc5JW68duQ3Qf+uM9Jrz4j
	 rr7S0Ung81PeWQcI68J43mTXcaj6ANoXZEyaoR/jwvKCkYEWJTHC937uWimpIH12MG
	 rnXoIIq8c4dWm83PIh67hiww83OuQ1QUNEnAMjT18ZbCcH1EGd/x9KXNvrccllBORO
	 UOLI1OnSS0B7aCc/VR/2nlT37MWv4JGtVqDRs6io7bWdIv4I9nIVZ6psnqiibbgWdu
	 qeQpf4afTAQWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] smb3: make query_on_disk_id open context consistent and move to common code
Date: Wed, 30 Sep 2026 13:33:57 -0400
Message-ID: <20260930173358.3641932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-badly-dust-d0e0@gregkh>
References: <2026092930-badly-dust-d0e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 1149c8467ddebfb6bb9aab37830f70a49cab7085 ]

cifs and ksmbd were using a slightly different version of the query_on_disk_id
struct which could be confusing. Use the ksmbd version of this struct, and
move it to common code.

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

[5.15 dependency adaptation for 67f4c1c6a1b:
Keep the create-context declarations in the existing per-subsystem headers.
This tree has not consolidated create_context into smbfs_common, and ksmbd
still defines its own SMB2 headers. Moving the response into the common
header would require unrelated header conversions.

Retain the client response rename and match ksmbd's 16-byte Reserved array,
without changing the packed wire layout. Leave the ksmbd and common headers
unchanged and omit the upstream common-header lease comments.

Rename the client's lease-break flag and both existing parser uses to the
upstream _LE spelling. This is a value-preserving prerequisite for the
target's lease-parser changes; no functions are added.]

[ sashal: Reduced backport -- upstream 1149c8467ddeb touches 4 file(s), this
  backport carries 3. Not backported here:
  fs/ksmbd/smb2pdu.h
  fs/smbfs_common/smb2pdu.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 67f4c1c6a1b5 ("smb: client: fix create context out-of-bounds reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 4 ++--
 fs/cifs/smb2pdu.c | 2 +-
 fs/cifs/smb2pdu.h | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8ba..cd47852103da2 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4405,7 +4405,7 @@ smb2_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 	struct create_lease *lc = (struct create_lease *)buf;
 
 	*epoch = 0; /* not used */
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS)
+	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
 	return le32_to_cpu(lc->lcontext.LeaseState);
 }
@@ -4416,7 +4416,7 @@ smb3_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 	struct create_lease_v2 *lc = (struct create_lease_v2 *)buf;
 
 	*epoch = le16_to_cpu(lc->lcontext.Epoch);
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS)
+	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
 	if (lease_key)
 		memcpy(lease_key, &lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index e93dd51a88557..52e63bd6b717b 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2019,7 +2019,7 @@ create_reconnect_durable_buf(struct cifs_fid *fid)
 static void
 parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 {
-	struct create_on_disk_id *pdisk_id = (struct create_on_disk_id *)cc;
+	struct create_disk_id_rsp *pdisk_id = (struct create_disk_id_rsp *)cc;
 
 	cifs_dbg(FYI, "parse query id context 0x%llx 0x%llx\n",
 		pdisk_id->DiskFileId, pdisk_id->VolumeId);
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 712d256c0d4f5..1a8dc46024877 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -571,7 +571,7 @@ struct create_context {
 #define SMB2_LEASE_HANDLE_CACHING	cpu_to_le32(0x02)
 #define SMB2_LEASE_WRITE_CACHING	cpu_to_le32(0x04)
 
-#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS cpu_to_le32(0x00000002)
+#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE cpu_to_le32(0x00000002)
 #define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET cpu_to_le32(0x00000004)
 
 #define SMB2_LEASE_KEY_SIZE 16
@@ -653,12 +653,12 @@ struct durable_reconnect_context_v2 {
 } __packed;
 
 /* See MS-SMB2 2.2.14.2.9 */
-struct create_on_disk_id {
+struct create_disk_id_rsp {
 	struct create_context ccontext;
 	__u8   Name[8];
 	__le64 DiskFileId;
 	__le64 VolumeId;
-	__u32  Reserved[4];
+	__u8  Reserved[16];
 } __packed;
 
 /* See MS-SMB2 2.2.14.2.12 */
-- 
2.53.0

