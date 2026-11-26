Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667417;
	b=FBFvGy7GhdQtOUOYflBp9vikDKBcbN+Fxb7ckglA4fM+LfeXCsQOG0B8pXCvK4x0mCYH
	 P8A69RrNpA42NxQt3Pu7eI4uzVV0b3Dp4g7lvTDVk/034uZIo6hAXtWTPIs0Kh+mwY9/7
	 +xjwdBy/T07gQvZ3LIILYn3eor2w5EbSkVcrBfYEcYvhnxefs9f9cv8Pg+AfcKdf06Xc0
	 vYXq/YRxQu6YU+RJRg0m9+wxHUCC1idLALm8tyzi1Z6BQ8iTaiwx+rX9Q4Z73NkIMnj02
	 a3t6y7Y2ElyVfpzwpEJgfIQWh/XE15h1ZQxbZPGBgG+v36Y/ZD2cePwaJLX5cWDAyiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j/eO0Glr9iWnNBrMdmBMG3iGzGzK5c3Tu08LIhWWoLU=;
	b=PWPN/XHITUM5cpYLnjGYjX7mS9vzDFFGcHwkbP0hrvgDYjJ1mkZds3kk1uknSi6ZWtOL
	 GJEw7IH1FStvV3DK9sf2j09XIpRbgKv9GKT3rL3vrBM1XX1USQRTcBAcuV+jVxKces4tz
	 aXdW1aQ6E0VBJsg00itXJJ/SvZNFv1r7eGaLulXIyRXEOe1nF79OOPazzMRXT764+m19q
	 28YVtDFTTUi2jdeFwIWvRq464sIluxLi8VcND1m7JEq2txFibj7fEFoDxoSv4442vf9to
	 qXl/rtHKjNUzL9Hif7OCMjpuKog031ihdsccfoSppTtr8FFkdtbzBokNnVT71ETbwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5iwBUBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5iwBUBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1171F000C0;
	Thu, 26 Nov 2026 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667416;
	bh=j/eO0Glr9iWnNBrMdmBMG3iGzGzK5c3Tu08LIhWWoLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5iwBUBRVKUdnBilR5AsHjUrTRUwiZlYehzeYoMbxoCQFuEW++Ha4PjkJThNSNPhb
	 ewnLNd87swpVlfGjlIBJ6DCScOm0FxSPmyXWMotP4xZatKzkVwqq2w68bS76eGIurh
	 P1peBpX/t2eMOUJQNDRQDjSb+nkLpdnQiWgVSjD6XUQmEDHDm2xfoBeZV7O3R52bm6
	 zKQZobu35pHGH6oIUeDOTfjXG2nM+gixgjzMJQhntynUYaLsTtYejLK9KvFoSLgXah
	 fmwCiu3i71fVbwPkH365yPO2ybLtnLgMJQ5tYXLYrV6gbmVIJr67LNVl4Jk7/rdGba
	 SkfKMpC6MrccQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] cifs: Fix getting DACL-only xattr system.cifs_acl and system.smb3_acl
Date: Wed, 25 Nov 2026 23:30:13 -0500
Message-ID: <20261126042943.1964790-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126042943.1964790-1-sashal@kernel.org>
References: <2026112507-depraved-reappear-7196@gregkh>
 <20261126042943.1964790-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

[ Upstream commit ad9364a6835c45c52f47587ffbe0577bb7cd4c5b ]

Currently ->get_acl() callback always create request for OWNER, GROUP and
DACL, even when only DACLs was requested by user. Change API callback to
request only information for which the caller asked. Therefore when only
DACLs requested, then SMB client will prepare and send DACL-only request.

This change fixes retrieving of "system.cifs_acl" and "system.smb3_acl"
xattrs to contain only DACL structure as documented.

Note that setting/changing of "system.cifs_acl" and "system.smb3_acl"
xattrs already takes only DACL structure and ignores all other fields.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: ffb59029c0d5 ("smb: client: validate descriptor headers before query result allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c |  4 ++--
 fs/smb/client/cifssmb.c |  3 +--
 fs/smb/client/smb2pdu.c |  4 +---
 fs/smb/client/xattr.c   | 15 +++++++++++----
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 540655c232cf6..1c1ce34e4a427 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1679,7 +1679,7 @@ cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
 	int rc = 0;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct smb_version_operations *ops;
-	const u32 info = 0;
+	const u32 info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO;
 
 	cifs_dbg(NOISY, "converting ACL to mode for %s\n", path);
 
@@ -1733,7 +1733,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	struct tcon_link *tlink;
 	struct smb_version_operations *ops;
 	bool mode_from_sid, id_from_sid;
-	const u32 info = 0;
+	const u32 info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO;
 	bool posix;
 
 	tlink = cifs_sb_tlink(cifs_sb);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 8126acf8349a1..f4c5b4cc220a4 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3452,8 +3452,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	/* BB TEST with big acls that might need to be e.g. larger than 16K */
 	pSMB->MaxSetupCount = 0;
 	pSMB->Fid = fid; /* file handle always le */
-	pSMB->AclFlags = cpu_to_le32(CIFS_ACL_OWNER | CIFS_ACL_GROUP |
-				     CIFS_ACL_DACL | info);
+	pSMB->AclFlags = cpu_to_le32(info);
 	pSMB->ByteCount = cpu_to_le16(11); /* 3 bytes pad + 8 bytes parm */
 	inc_rfc1001_len(pSMB, 11);
 	iov[0].iov_base = (char *)pSMB;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 24863ba8a0926..6844bdfcc9b1b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3994,12 +3994,10 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	       u64 persistent_fid, u64 volatile_fid,
 	       void **data, u32 *plen, u32 extra_info)
 {
-	__u32 additional_info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO |
-				extra_info;
 	*plen = 0;
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
-			  0, SMB2_O_INFO_SECURITY, additional_info,
+			  0, SMB2_O_INFO_SECURITY, extra_info,
 			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
 }
 
diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
index e8696ad4da994..b2f367cadf9ff 100644
--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -320,10 +320,17 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 		if (pTcon->ses->server->ops->get_acl == NULL)
 			goto out; /* rc already EOPNOTSUPP */
 
-		if (handler->flags == XATTR_CIFS_NTSD_FULL) {
-			extra_info = SACL_SECINFO;
-		} else {
-			extra_info = 0;
+		switch (handler->flags) {
+		case XATTR_CIFS_NTSD_FULL:
+			extra_info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO | SACL_SECINFO;
+			break;
+		case XATTR_CIFS_NTSD:
+			extra_info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO;
+			break;
+		case XATTR_CIFS_ACL:
+		default:
+			extra_info = DACL_SECINFO;
+			break;
 		}
 		pacl = pTcon->ses->server->ops->get_acl(cifs_sb,
 				inode, full_path, &acllen, extra_info);
-- 
2.53.0

