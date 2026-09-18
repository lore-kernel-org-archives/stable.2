Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4722C21DF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691326; cv=none; b=PIkl3aBk12g7FZrFkmGXcUYs16a2ylbkK149MyrEd3WSKop/TW1ZZblMsuVq9z+A2vKFBhCWPIu/g2S/WPpCGHnqgWqSRWWwIIsCKh+41nrVaOfA1k/UvNRhnU/qo9RE6Dh3WkTjkCZwAH24bH84ZAbZvXjMQobQMgVLU0KZoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691326; c=relaxed/simple;
	bh=MGX3ws5kpbyACDFYYG3CBIamCZPj825Ty/u1H8SDJj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHUAF47FuuXQM4wFYu6syMuhlqudxLvXL+xAw1eHi8P3PHK8nmpFsE0cM1u5mgpJsp90aOrr/uOAM48Km7daw8H4BAAACztCltjrsRgqJKIs9JyfezvCK7JSDLLHtXI9OOCii7GaLhHtAQ5EC67eK1czUEAZ8E8kJKF4vsA/VSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2uDsVyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2uDsVyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD481F00899;
	Fri, 18 Sep 2026 00:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691317;
	bh=M0Byq+jT802MLWRz8kmD3EuLXsU+XnyHV2/iSvrFTOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2uDsVyuPpXkjn1h3AIlD5htrH9i8ePwwT97MeDdr7pvMEOhbtoVi7fXC3ynD1i63
	 JPmDUKC6deHHiPgoevGzdI7BVMd4C8WmfkgG4MsE4YNJYwpm/9WE+AMZ3zb8aAV8os
	 qrJ/JEMzgeZWO7LVuDhEjwAN8zV0TFWeu3csMoQMPzvCk/v+yHPScCR1ZWej+WzP5n
	 k7vkfa6585fqhDeFM7ufDIpGFqz9oPxa8WRCYaCqJzrBSRR4dKSbHgxNJC3gc1QKuZ
	 BOyvZYJ7rsR8pEu0aWuc7q7M++rAbio+ZI+TG9yU7A70zs43248aXXRPS33VJfsR1V
	 ItIOXdb7taY+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] smb: client: honor forceuid/forcegid when mapping SIDs to uid/gid
Date: Thu, 17 Sep 2026 20:28:34 -0400
Message-ID: <20260918002835.1323758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091630-sherry-congenial-9b1f@gregkh>
References: <2026091630-sherry-congenial-9b1f@gregkh>
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

Backport notes for 5.10:
- Keep the client in fs/cifs and use the existing mnt_cifs_flags value.
- Drop the inode.c hunk: smb311_posix_info_to_fattr() already takes both
  IDs from mnt_uid/mnt_gid and does not map ownership SIDs in this tree.
- Apply the ACL checks to fs/cifs/cifsacl.c, retaining its existing
  parse_sid() validation and initializing ownership from the mount IDs.
- Alias ctx[0].linux_uid/linux_gid and mnt_uid/mnt_gid through an anonymous
  union. The aliases share the existing storage, require no allocation or
  initialization, and preserve updates through either spelling. This is
  only an ownership compatibility view, not a new filesystem context.
  Keeping the upstream ownership assignments in cifs_posix_to_fattr()
  lets the target SID-parsing fix cherry-pick without the
  adjacent-line conflict caused by replacing those assignments with the
  older field names. Preserve the existing file-type/revalidation logic.

[ sashal: Reduced backport -- upstream 18a72975e9f35 touches 3 file(s), this
  backport carries 3. Not backported here:
  fs/smb/client/cifsacl.c
  fs/smb/client/inode.c
  fs/smb/client/readdir.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: da6e25842431 ("smb: client: avoid using uninitialized SIDs in cifs_posix_to_fattr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_fs_sb.h | 13 +++++++++++--
 fs/cifs/cifsacl.c    | 29 ++++++++++++++++++-----------
 fs/cifs/readdir.c    |  9 +++++++--
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/cifs_fs_sb.h b/fs/cifs/cifs_fs_sb.h
index 6e7c4427369d8..8a029006cb380 100644
--- a/fs/cifs/cifs_fs_sb.h
+++ b/fs/cifs/cifs_fs_sb.h
@@ -66,8 +66,17 @@ struct cifs_sb_info {
 	unsigned int wsize;
 	unsigned long actimeo; /* attribute cache timeout (jiffies) */
 	atomic_t active;
-	kuid_t	mnt_uid;
-	kgid_t	mnt_gid;
+	/* Share mount ownership with the names used by newer SID mapping code. */
+	union {
+		struct {
+			kuid_t mnt_uid;
+			kgid_t mnt_gid;
+		};
+		struct {
+			kuid_t linux_uid;
+			kgid_t linux_gid;
+		} ctx[1];
+	};
 	kuid_t	mnt_backupuid;
 	kgid_t	mnt_backupgid;
 	umode_t	mnt_file_mode;
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
index 9a7315aa24e0d..f0c3b51b984df 100644
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

