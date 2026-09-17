Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72B509EFF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649378; cv=none; b=uyWFTltCOjBbG7lyo7kzv6jzAhqOY+68LGPhM4JaVGpsvc8fxoOTQsxc1J8dS8YMyL8FON07wux/e9qrNdVjaE8V4kcl4OznD/hHypww2jbZDj7/RLBzuwfmCa/LEdFxTwOt4oPYD6OlNfk834CZzVfAYz/uZZfWpGwEl0uebI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649378; c=relaxed/simple;
	bh=LRe/QhM+10Yzq0ua0poeVfo5/VZsaO2ZMOTgbaHZJvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMXTlka/4DhWZwoYBiaESoef58ASFSldMRfMZdZNevzLWK/DiMKIotaX1JOgZGaeDBByxlVh4BFPJRf/RZ+dDpdP2iUosw3zRnCNEQMj7PMfzOh2UOVeSkttjkCSAaeCfksFPZkop8cHQwMOpyJEmbmMhrsxdMxeA5F8yd5pRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBXaLkZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBXaLkZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD621F0089A;
	Thu, 17 Sep 2026 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649364;
	bh=hkIl3mHhhmXIUZlxcpKUxPUS6qYexW0a6xLUCdBf2lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBXaLkZ99hl+Fqu/Zos6CW/5m+qkCnLiFQR3nPTVgJ3mENwV+L3hA/2KlGlR+YX9O
	 T9wr3nW18pX2XePJ0nVGgcM4rbBosy2I63IFNiWDm5t9G8ogUhP/tCw6L0CsJaPBCD
	 WkS1dLij3J9zLVKhgCX07vodYC/+ETdwYP+XBm82d3xrBGjL1oWyU3dM2VbV0e+stA
	 nEfqRcy6I3F23VaDo3F7ct/J2JaAFklkEQENjxBudl/q3mroYwcfYrqGUnC+TLEq5A
	 wvwVTz89hKT7zYR/lStdvjexrJ50XsfRjWql5r5puw1Xi8e/IBItJjD5h1bamJFvmk
	 v2ZyRl/SevFkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
Date: Thu, 17 Sep 2026 08:49:21 -0400
Message-ID: <20260917124921.227155-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917124921.227155-1-sashal@kernel.org>
References: <2026091605-runner-debit-e9f7@gregkh>
 <20260917124921.227155-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 29 ++++++++++++++++++-----------
 fs/smb/client/inode.c   |  9 +++++++--
 fs/smb/client/readdir.c |  9 +++++++--
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index af6f746f68256..97c02467596be 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1300,6 +1300,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 {
 	int rc = 0;
 	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl;
 	__u32 dacloffset, osidoffset, gsidoffset;
@@ -1318,17 +1319,21 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, osidoffset, gsidoffset,
 		 le32_to_cpu(pntsd->sacloffset), dacloffset);
-/*	cifs_dump_mem("owner_sid: ", owner_sid_ptr, 64); */
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+
 	rc = sid_from_sd(pntsd, acl_len, osidoffset, &owner_sid_ptr);
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
 
 	rc = sid_from_sd(pntsd, acl_len, gsidoffset, &group_sid_ptr);
@@ -1337,11 +1342,13 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
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
 
 	if (dacloffset) {
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index b67b316538b83..d4282729d1392 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -831,6 +831,7 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 	struct smb311_posix_qinfo *info = &data->posix_fi;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 
 	memset(fattr, 0, sizeof(*fattr));
 
@@ -875,8 +876,12 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
-	sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+		sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
+	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+		sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
 
 	cifs_dbg(FYI, "POSIX query info: mode 0x%x uniqueid 0x%llx nlink %d\n",
 		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 7bf3214117a91..9888756fff888 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -241,6 +241,7 @@ static void
 cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		    struct cifs_sb_info *cifs_sb)
 {
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	struct smb2_posix_info_parsed parsed;
 
 	posix_info_parse(info, NULL, &parsed);
@@ -280,8 +281,12 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		 le32_to_cpu(info->ReparseTag),
 		 le32_to_cpu(info->Mode));
 
-	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
+	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
+		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
+	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
+		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
 }
 
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
-- 
2.53.0

