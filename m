Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667020;
	b=sCatOMtQDK1kPpIreoUMlgZvtDp1CEHIawl3Bc5nKRoVznnwZuI6AgkHosjDBeWt9mpB
	 H43BdwMqrkBt1CigMVkEMJJJ72CndkMAy0V1x83kIUU0rKDVi9Vgw3PrVRoDeQYsGr8sL
	 fL14WH/3LCDcX068rW4VJhUVFoHGEgDWIPpBsxhIa+QKxhkt00NMtxcIpjcuKah/JnbA2
	 PPp0zH7ZjzpzggtWcYELEerGNPsnAQpRDN4r0fg1A/+XWxxfxqwxmol1GFrMxKkzcaPVh
	 BUHB6TF3qFhg80uStKs4JTsMCXVLufCPyrapDkMxs8kznZ5adQiJu0I154owaO1Iesg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OU2HuBGw0WF1gCIEuE+eqR0xuetSb0X1bJ0Sy4WrItA=;
	b=kJvXVOwE2vqPY2ZjKwUjCYqbRkv6tqktn8bcRxtcXxn712qQqvmYbFjg0bqcWcPbQ4Xb
	 mE5oNFlsqI4eC/cGlFVSgMvdA6Am5ghbnLR59kxHSz/g5YR77fa1DqrbuRpdqpbBH0//+
	 Oxb4j6lOumwfrIoNMEEu8UDKtEeVUeLBwgb9CyIiP7BYLkE0emmhoWrpxPc/XvGuveFxl
	 lo3FdPavPr2DBlCliitStmDk1kakwq83AvXrfbniFYz5dI2P3pIp2DrARDcf7zcBZNjE4
	 0TaunPOYqn8LBty+kyCWgTHQcI9Wu0H+EpHWp6MzKyGy+IW7ogMMG1ECfV06lqB3kPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jI8aeTOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EE606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jI8aeTOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4F01F000C4;
	Thu, 26 Nov 2026 04:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667019;
	bh=OU2HuBGw0WF1gCIEuE+eqR0xuetSb0X1bJ0Sy4WrItA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jI8aeTOfOmeH/WltOet1KJeKLf2rZ25vPNN6w46aDwt09L/OVP2o+XmnNAhH0C+eG
	 Fllca6GvTCV2dx7VcrkgxgSlJSEYn2p3YcwFj+ZjcSTJ4dMps/+JvXiS7FWxK4/xfp
	 wv8FPZF87lqfSKxE9QPH9/aCLZAXuYdhbZxJksagIothabefOgpbAC53K8eqVmFCVv
	 KnNnJ2R9M+zJoAhhsEG5A0ba4y1h50iDO7C3nR2rEMKiXkIQnQKhCRafgf5LmDzb55
	 c0jmucO8znC9sMY001uyhnnXBzCtGrMpuv/hWkBaSbRvPyWQaGR9RDNnjdwz5BcmE6
	 NgpkOcMvG5ilg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] cifs: Fix getting DACL-only xattr system.cifs_acl and system.smb3_acl
Date: Wed, 25 Nov 2026 23:23:35 -0500
Message-ID: <20261126042229.1926905-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126042229.1926905-1-sashal@kernel.org>
References: <2026112506-zipfile-subpanel-c0d3@gregkh>
 <20261126042229.1926905-1-sashal@kernel.org>
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
index dd88f0ad23915..d4ddc741b9b74 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1683,7 +1683,7 @@ cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
 	int rc = 0;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct smb_version_operations *ops;
-	const u32 info = 0;
+	const u32 info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO;
 
 	cifs_dbg(NOISY, "converting ACL to mode for %s\n", path);
 
@@ -1737,7 +1737,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	struct tcon_link *tlink;
 	struct smb_version_operations *ops;
 	bool mode_from_sid, id_from_sid;
-	const u32 info = 0;
+	const u32 info = OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO;
 	bool posix;
 
 	tlink = cifs_sb_tlink(cifs_sb);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6f3f707e20810..51cca91a2ea73 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3488,8 +3488,7 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
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
index a92226e3e6e9b..e6ce1d8528cb5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3998,12 +3998,10 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
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
index 58a584f0b27e9..7d49f38f01f3e 100644
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

