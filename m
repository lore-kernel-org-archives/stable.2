Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18944E0211
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781350; cv=none; b=ZnTQVt7Ge5uJxSPtrDNMIozMQvC06cgL/ae4sSLesMTe6n7SkdXria+LN6Lk51SJlr09naUBk96HW3OKfoJCfLS1ZDq6hFMSuEOopoyQ3T1WYGpk2v3m/Ib8qTBtVBs/F/g0AsjCVZSFeU8JpVkKPJ/Ffa89gAMw/V1ZRPOZgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781350; c=relaxed/simple;
	bh=DNagl9HqaXzROJqHxk5+dTS69Zy0MgU9BrdEvqiVbg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tmc9VQlS/t806jOuH6CdKru+moHxFhXJpqgEl3PE42wZimirpeFmJkQCfcrqlGVJdp6XR8TifJK4badTkkUiW80UPskie0YppQ0/vEgkGA3NznqnHjDfd/tiD2NCIuA5ddv343RGosrOoPKdzQH+nyokF/2e5R9xr+zhMT/f6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzzZOZjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzzZOZjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6751F00893;
	Wed, 30 Sep 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781341;
	bh=8yWAOfJAwWEI54t+G5KOFyIQBc2Uu3UQY4JlG8YZ/WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzzZOZjbOlRRMlsJ1XXApoQmIdYyaN4oQ5+vhtejZs3PSNx90sB/Vu/bJPpn+OtxX
	 hSNtsEF6xdsU/injoph6hX5rfVzhQhTVZGUb/9LqlPcvuUdl9IjkaH+P5BF/1+P9/w
	 IqN1v2nuQ7laXXM9AAUePkalzHOitL/q/2Vcd6dOk60n7UC4IiZw9b8z0I2E5EB4Z5
	 ruys0ppPkd8ZNSilcrNkMnixdlBarMltSq3oA5xa4KB9bxeQ9ucWDKwsdiIYzZIZV5
	 i3cTvDgT09q4FNgIScQ8dQbF5nqr96Exub84UVbVPwrjuH2dIFE88flsFPwqaQ20AM
	 hqeDAit1VTM0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] smb3: make query_on_disk_id open context consistent and move to common code
Date: Wed, 30 Sep 2026 11:15:38 -0400
Message-ID: <20260930151539.2562092-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092929-survey-cost-ee4b@gregkh>
References: <2026092929-survey-cost-ee4b@gregkh>
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
Stable-dep-of: 67f4c1c6a1b5 ("smb: client: fix create context out-of-bounds reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c |  2 +-
 fs/smb/client/smb2pdu.h |  9 ---------
 fs/smb/common/smb2pdu.h | 11 +++++++++++
 fs/smb/server/smb2pdu.h |  8 --------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 98d6fcdf22365..984babcecc21d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2179,7 +2179,7 @@ create_reconnect_durable_buf(struct cifs_fid *fid)
 static void
 parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 {
-	struct create_on_disk_id *pdisk_id = (struct create_on_disk_id *)cc;
+	struct create_disk_id_rsp *pdisk_id = (struct create_disk_id_rsp *)cc;
 
 	cifs_dbg(FYI, "parse query id context 0x%llx 0x%llx\n",
 		pdisk_id->DiskFileId, pdisk_id->VolumeId);
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index d12ca9c7e62bc..2c2a2177b553c 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -170,15 +170,6 @@ struct durable_reconnect_context_v2 {
 	__le32 Flags; /* see above DHANDLE_FLAG_PERSISTENT */
 } __packed;
 
-/* See MS-SMB2 2.2.14.2.9 */
-struct create_on_disk_id {
-	struct create_context ccontext;
-	__u8   Name[8];
-	__le64 DiskFileId;
-	__le64 VolumeId;
-	__u32  Reserved[4];
-} __packed;
-
 /* See MS-SMB2 2.2.14.2.12 */
 struct durable_reconnect_context_v2_rsp {
 	__le32 Timeout;
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 7d69a2a1d3ba4..430b65512228f 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1240,6 +1240,7 @@ struct create_posix {
 
 #define SMB2_LEASE_KEY_SIZE			16
 
+/* See MS-SMB2 2.2.13.2.8 */
 struct lease_context {
 	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
@@ -1247,6 +1248,7 @@ struct lease_context {
 	__le64 LeaseDuration;
 } __packed;
 
+/* See MS-SMB2 2.2.13.2.10 */
 struct lease_context_v2 {
 	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
@@ -1270,6 +1272,15 @@ struct create_lease_v2 {
 	__u8   Pad[4];
 } __packed;
 
+/* See MS-SMB2 2.2.14.2.9 */
+struct create_disk_id_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 DiskFileId;
+	__le64 VolumeId;
+	__u8  Reserved[16];
+} __packed;
+
 /* See MS-SMB2 2.2.31 and 2.2.32 */
 struct smb2_ioctl_req {
 	struct smb2_hdr hdr;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 6011fca980456..7518aa42f11ed 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -146,14 +146,6 @@ struct create_mxac_rsp {
 	__le32 MaximalAccess;
 } __packed;
 
-struct create_disk_id_rsp {
-	struct create_context ccontext;
-	__u8   Name[8];
-	__le64 DiskFileId;
-	__le64 VolumeId;
-	__u8  Reserved[16];
-} __packed;
-
 /* equivalent of the contents of SMB3.1.1 POSIX open context response */
 struct create_posix_rsp {
 	struct create_context ccontext;
-- 
2.53.0

