Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D088594803
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657324; cv=none; b=gbrvJUSajj+6SiMueAWTH3UeubTWT8lPLfEzjVBZYXDhSyKDjBSXevdHJcf7VamgxjgzaE3bcinwjIWOKI02HBCDI2s8kVgOnPirmDWNoAUCONz+wX1LcuSsnb3eV8Hpad/AhxNyyuHeiZzQUhyF8EYnu7CBmDQQ+MVFTM6chbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657324; c=relaxed/simple;
	bh=A/3Sg7wsmZXkGyMPUAn4b4Z/6nmdHyZNJYEtL94Qj9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq2dX51HQpUln6R5aa2H3giaSFBlL9enVDp5umLDYagHMKVMuBYUvbXk9VZpEOL9Ef2biP2tg5tgL4UWy8BkhjQDfNytv+Hc/PZjuLfaRxocj7v4Xn9BZXXYUdmdGuIShLqWXGzpbsAi21Xsf2jhPSjB0y1fbeyIyOZKjdtS/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBCYDtKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBCYDtKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D111F00898;
	Thu, 17 Sep 2026 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657305;
	bh=WR4i8Nx3CGzDtfEqdAZpesRrNRyBdQizSA2p25ZzIhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBCYDtKKd6KfpQaBB1KI21weiIpSybUurn6xSe/yDMIkotwcJBj8WDAcS45LE9N+a
	 HsZqrT1xtEYeNIgH26qf/7WWKzBFFjpBOkR/RMyRO19Fde38TCejp8Rih2xeQcnbRs
	 MWLzrpM3uqQ4LsTgqvgphxFtAgsRrRHsbkwJPMMEREUTdKkL2PRQOaN9zwlMFSL6tX
	 OsH6AbBVHnFd+mYtidL8PMYWqLMU9Xplafiw3tf5Ecoi+fQvYUKEQAlNagT2a2NBmo
	 jFUk8R373pycA5jNr/AyII2MfGB+MRa80SFBKZ4ui8J9jHbn5TnUdGR1hFfRo8N7Q+
	 9RQq9KzadEhOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
Date: Thu, 17 Sep 2026 11:01:43 -0400
Message-ID: <20260917150143.670967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091606-capture-dutiful-4654@gregkh>
References: <2026091606-capture-dutiful-4654@gregkh>
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
[ replaced cifs_sb_flags(cifs_sb) with cifs_sb->mnt_cifs_flags because the older tree lacks the accessor. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 29 ++++++++++++++++++-----------
 fs/smb/client/readdir.c |  9 +++++++--
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 3dbc71556cb00..d21085712e9cf 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1273,6 +1273,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 {
 	int rc = 0;
 	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
+	unsigned int sbflags = cifs_sb->mnt_cifs_flags;
 	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
@@ -1289,17 +1290,21 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
 		 le32_to_cpu(pntsd->sacloffset), dacloffset);
-/*	cifs_dump_mem("owner_sid: ", owner_sid_ptr, 64); */
+	fattr->cf_uid = cifs_sb->ctx->linux_uid;
+	fattr->cf_gid = cifs_sb->ctx->linux_gid;
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
@@ -1308,11 +1313,13 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
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
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 20955d595e6a5..05344d6a0606b 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -233,6 +233,7 @@ static void
 cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		    struct cifs_sb_info *cifs_sb)
 {
+	unsigned int sbflags = cifs_sb->mnt_cifs_flags;
 	struct smb2_posix_info_parsed parsed;
 
 	posix_info_parse(info, NULL, &parsed);
@@ -277,8 +278,12 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 	if (reparse_file_needs_reval(fattr))
 		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
 
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

