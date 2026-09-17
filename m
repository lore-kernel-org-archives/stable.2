Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D44D4881
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670386; cv=none; b=iJUV228XIrtwg9S0XCoGLLkm9g5kfDVlaPQd43uV/Bgy5N/ix2L2KsVMcOVRXhB4U6FBkKp+kglwAXw+yTUN4ipfJi+ttMdh7ePlS3fZexLlZJfUW0o4MDjAWWj/3HML4vBLD2buvXK9s18UiMAFnI+pVcaSTlZ4vNeTgYbx0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670386; c=relaxed/simple;
	bh=dL8H538mFx2CSdrFCk6twLHVyVI/MT57XPbWIeCgidg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKYkgk6ap76OH8yWnWBzavmMZ6sF9cQKzNsw9YzmargGmzvUCupVF9VE9QKCAlODwom4lbjZi2ZKXLu/0rvTFp3FVRUQ82hyqHar0ogBlrit74bcLpU39ZMW7WDGEfurnXmtRf34kJtPuKXTxOmdGj/B7kxt9wN442fQ3nxMZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvXZ/9Xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvXZ/9Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CAD1F00898;
	Thu, 17 Sep 2026 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670384;
	bh=EtZD8MSc6FzCihdWTITPYmDr64WgeE3MEgP97paQznQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZvXZ/9XlX9hSGEUajrSzXwYoy4BXUvqAY35It3RNt9ICvRTSGbLD6yBLt0REZcMnq
	 UbtN0o3ow1oK1kSl2fK7Q6raFrHRJo1whZzY6U6Wn487IynieqkD7vloowlidWXcK9
	 ki4gdXzS38/qKkIyk6MO7cu4T8KwZSo9fJWhVRnseCvAcpjTQ2l2VoUAwbJa/+870R
	 E60lyPHAk4VKMnhhn42n6xX1tPJ04FE7g0WpC0mHcpXd5gTF5qmGtYoURv7ti4lzM4
	 ZhUt6l7ZkHs63voFryW8oMPWsbdDkJTfpzgFntCyeyccm5IADD8UcWAqUVoJg5nCIQ
	 wJaCgGTEwd/Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
Date: Thu, 17 Sep 2026 14:39:42 -0400
Message-ID: <20260917183942.1201249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091607-spool-dagger-d4a5@gregkh>
References: <2026091607-spool-dagger-d4a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 18a72975e9f35aadecc75b031f693f2d1f49308f ]

When the administrator mounts with forceuid or forcegid (uid=/gid=
mount options), they expect all files to appear owned by the specified
user/group.  However, several code paths unconditionally called
sid_to_id() to overwrite cf_uid/cf_gid with server-provided values,
ignoring the administrator's explicit override:

  - smb311_posix_info_to_fattr() (stat via POSIX extensions)
  - cifs_posix_to_fattr() (readdir via POSIX extensions)
  - parse_sec_desc() (CIFS ACL ownership mapping)

This allowed an untrusted server to dictate local file ownership even
when the mount was configured to force specific uid/gid values.

Fix all three call sites to check CIFS_MOUNT_OVERR_UID and
CIFS_MOUNT_OVERR_GID before calling sid_to_id(), following the
same pattern already used by cifs_unix_basic_to_fattr() for unix
extensions.

Closes: https://sashiko.dev/#/patchset/20260906155816.603278-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ adapted the patch to fs/cifs/ using legacy mount fields and parse_sid(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 29 ++++++++++++++++++-----------
 fs/cifs/readdir.c |  9 +++++++--
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index c8a0a2edc6500..486bccf548c35 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -947,6 +947,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 {
 	int rc = 0;
 	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
+	unsigned int sbflags = cifs_sb->mnt_cifs_flags;
 	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
@@ -964,17 +965,21 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
 		 le32_to_cpu(pntsd->sacloffset), dacloffset);
-/*	cifs_dump_mem("owner_sid: ", owner_sid_ptr, 64); */
+	fattr->cf_uid = cifs_sb->mnt_uid;
+	fattr->cf_gid = cifs_sb->mnt_gid;
+
 	rc = parse_sid(owner_sid_ptr, end_of_acl);
 	if (rc) {
 		cifs_dbg(FYI, "%s: Error %d parsing Owner SID\n", __func__, rc);
 		return rc;
 	}
-	rc = sid_to_id(cifs_sb, owner_sid_ptr, fattr, SIDOWNER);
-	if (rc) {
-		cifs_dbg(FYI, "%s: Error %d mapping Owner SID to uid\n",
-			 __func__, rc);
-		return rc;
+	if (!(sbflags & CIFS_MOUNT_OVERR_UID)) {
+		rc = sid_to_id(cifs_sb, owner_sid_ptr, fattr, SIDOWNER);
+		if (rc) {
+			cifs_dbg(FYI, "%s: Error %d mapping Owner SID to uid\n",
+				 __func__, rc);
+			return rc;
+		}
 	}
 
 	rc = parse_sid(group_sid_ptr, end_of_acl);
@@ -983,11 +988,13 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 			 __func__, rc);
 		return rc;
 	}
-	rc = sid_to_id(cifs_sb, group_sid_ptr, fattr, SIDGROUP);
-	if (rc) {
-		cifs_dbg(FYI, "%s: Error %d mapping Group SID to gid\n",
-			 __func__, rc);
-		return rc;
+	if (!(sbflags & CIFS_MOUNT_OVERR_GID)) {
+		rc = sid_to_id(cifs_sb, group_sid_ptr, fattr, SIDGROUP);
+		if (rc) {
+			cifs_dbg(FYI, "%s: Error %d mapping Group SID to gid\n",
+				 __func__, rc);
+			return rc;
+		}
 	}
 
 	if (dacloffset)
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 9a7315aa24e0d..2e130228f2183 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -246,6 +246,7 @@ static void
 cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		    struct cifs_sb_info *cifs_sb)
 {
+	unsigned int sbflags = cifs_sb->mnt_cifs_flags;
 	struct smb2_posix_info_parsed parsed;
 
 	posix_info_parse(info, NULL, &parsed);
@@ -290,8 +291,12 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 	if (reparse_file_needs_reval(fattr))
 		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
 
-	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	fattr->cf_uid = cifs_sb->mnt_uid;
+	fattr->cf_gid = cifs_sb->mnt_gid;
+	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
+	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
 }
 
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
-- 
2.53.0

