Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344C33BBC5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617883; cv=none; b=gbtyl7/EHPRL4HDcy6vkX7Awy7ZQtHDbpaE9CodNvXNGKSycAfNT+5xrk/Qn8R5VdcSJyic1UOz5j5pe1lRFGR72uy76LnCNzqF8ZMyxqfjAfy8xlM4nLIJKTqehgT9F2wH5SaL6SuZSHuHFht27+rPKqGIxhu8oAdqTLotaIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617883; c=relaxed/simple;
	bh=UvoyNwU6HFHXvaQbJCfEzXJsKYkajZgXgH2OgKYMQ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0Nu8urXB6eAy7p1WjLYNu1k6o+v19Ga27nSgkj2yuZB5fjFEx/HghZxjPRdItulT8Al63uFnikGbiLejYEiO/cAUeDq0fYOgxQxt7bPh1PnIwfPFAIXENoFrOBgNFpPLKUuUAFvOVZhk0WjjwcWndMFSGgo3Xo5w0WyCc57JGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzpH6E7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzpH6E7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EA31F00893;
	Thu, 17 Sep 2026 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617882;
	bh=7eADLYBKBh6HPsdjOtNZdws2p9SROZ5Xk3l6/yktHP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzpH6E7q+5/FQTWYo5kFFJVCI71zBC5TSHcxrm8LnfNeOLAhbcGAk9u3AVOFRtIvG
	 XAfD01/O3mgNe6lE5etqv7acas48eKXfYRLuih36whnlHkAmEXoaJrqEKT1wM02Cv/
	 10FERwlt9Ib2EJ7E4ypK3RfsGpNriCsKQDLWHsz8uZ0IjQO6vvrmsiVhTmA6lAtgwr
	 VKRq1ookxLhh0ovYUEkjHBc6CSGXwaDQwM8285IfIY5C5/eygJbDCC8klkPbtrmm9R
	 aH7uQPO2lZM2jBp9ghQ0VN1JCk9Dio1yzEhBYNz8VqkVSYHP9GmWpDiKc0nX1MRAsQ
	 0JCSjtEoqdAXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] smb/client: fix security flag calculation when setting security descriptors
Date: Thu, 17 Sep 2026 00:04:38 -0400
Message-ID: <20260917040439.4163850-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917040439.4163850-1-sashal@kernel.org>
References: <2026091603-giddily-overstate-4978@gregkh>
 <20260917040439.4163850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralph Boehme <slow@samba.org>

[ Upstream commit 4939889c985da68936090cc013e58c28b7bff34f ]

In id_mode_to_cifs_acl(), aclflag was initialized to CIFS_ACL_DACL by default.
This forced the client to request setting the DACL even when only an ownership
(chown) or group (chgrp) change was being performed.

Let build_sec_desc() do the proper flag calculation by initializing aclflag
to 0. build_sec_desc() sets the appropriate bits (CIFS_ACL_OWNER, CIFS_ACL_GROUP,
or CIFS_ACL_DACL) depending on what actually changed. During ownership transfer,
CIFS_ACL_DACL is only set if replace_sids_and_copy_aces() actually replaces the
SIDs inside any of the DACL's ACEs.

If build_sec_desc() results in aclflag being 0 (meaning no changes were mapped),
exit early to avoid sending an empty security descriptor update to the server.

Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d05045177a85 ("smb: client: fail DACL rewrite when the new DACL exceeds 64K")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index e03fa822ad33e..ae0e858935547 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1113,7 +1113,8 @@ static void populate_new_aces(char *nacl_base,
 
 static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
-		struct smb_sid *pnownersid, struct smb_sid *pngrpsid)
+		struct smb_sid *pnownersid, struct smb_sid *pngrpsid,
+		int *aclflag)
 {
 	int i;
 	u16 size = 0;
@@ -1137,12 +1138,15 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 		pntace = (struct smb_ace *) (acl_base + size);
 		pnntace = (struct smb_ace *) (nacl_base + nsize);
 
-		if (pnownersid && compare_sids(&pntace->sid, pownersid) == 0)
+		if (pnownersid && compare_sids(&pntace->sid, pownersid) == 0) {
 			ace_size = cifs_copy_ace(pnntace, pntace, pnownersid);
-		else if (pngrpsid && compare_sids(&pntace->sid, pgrpsid) == 0)
+			*aclflag |= CIFS_ACL_DACL;
+		} else if (pngrpsid && compare_sids(&pntace->sid, pgrpsid) == 0) {
 			ace_size = cifs_copy_ace(pnntace, pntace, pngrpsid);
-		else
+			*aclflag |= CIFS_ACL_DACL;
+		} else {
 			ace_size = cifs_copy_ace(pnntace, pntace, NULL);
+		}
 
 		size += le16_to_cpu(pntace->size);
 		nsize += ace_size;
@@ -1464,7 +1468,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 			/* Replace ACEs for old owner with new one */
 			size = replace_sids_and_copy_aces(dacl_ptr, ndacl_ptr,
 					owner_sid_ptr, group_sid_ptr,
-					nowner_sid_ptr, ngroup_sid_ptr);
+					nowner_sid_ptr, ngroup_sid_ptr,
+					aclflag);
 			ndacl_ptr->size = cpu_to_le16(size);
 		}
 
@@ -1679,7 +1684,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			kuid_t uid, kgid_t gid)
 {
 	int rc = 0;
-	int aclflag = CIFS_ACL_DACL; /* default flag to set */
+	int aclflag = 0;
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
@@ -1781,6 +1786,11 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	if (rc != 0)
 		goto id_mode_to_cifs_acl_exit;
 
+	if (aclflag == 0) {
+		cifs_dbg(FYI, "set_cifs_acl aclflag=0, no change mapped\n");
+		goto id_mode_to_cifs_acl_exit;
+	}
+
 	if (ops->set_acl == NULL) {
 		rc = -EOPNOTSUPP;
 		goto id_mode_to_cifs_acl_exit;
-- 
2.53.0

