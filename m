Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652E3932F7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617279; cv=none; b=idrRGdNvuPngnMS7Rcym9S/mPOXcfjq6hn24zo2cnxe16Ah4ykizYUT3O3abRmEwueqbkZ9n+1c+5fiq6i0lqKFsXfxI8QGvG6GrEhfrAcJcrsodQx8V0kMmXJHn2MPeAsLBFx44VlcHyXEgecA7uOP/IDmGOcL50P51u/8FeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617279; c=relaxed/simple;
	bh=4gDeoocE0JooQIBs2Nv4wYMtD8jUjJik2UlaPFO/VQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAGwYdX7FXxcmwRTyCfFqX4OAnZcXY9wPLQBdesr7W4PQ99S6zvKpPXSzdoGWZNLHS9l2y4o4rwPRn3MClUf/35OX3PYgSbBKWBW6O778ywtXenzU3vIAFbxu9Xk8h5zxhdeMafKfo70yqFz7xK9aHqbZ0wEzkHVQgZIrLmq6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVHaiRxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVHaiRxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B731F00899;
	Thu, 17 Sep 2026 03:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617275;
	bh=0uQL4KK/GIbSPISW3iEYc4+WwYxCHUuOOWNUhTNMTJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVHaiRxHy2I5kgphD/VOwk0mfDu+CR39gUfuXzR0wwdXRj0cG6dFQHjDZkiznO+u1
	 or3pWBAa34f8MR0Rp1xJYLYfVVIyXKr+27YTzVGi4u7HSzA3yOgMMjF77sbQcQ0zkS
	 7+fy+GPOokZg997TxAhe8Tt/3hBIHgabLROBHPd2onc3EiDnmWcEpSOUOGYA1zKJgS
	 VJ8+POrgeoUTtIjEfeoBfYp5c3fYFCG8LzQAoE51IGtrzWSkKpucKF3sjtT7Y5ZOQV
	 C9FYp6P7htiZGZgvtDUef5D9i225zogN8x1D7NPZCRdVtPDUC29T2l3XXn/pkvyvjT
	 Vcv55kJff2fqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] smb/client: fix security flag calculation when setting security descriptors
Date: Wed, 16 Sep 2026 23:54:32 -0400
Message-ID: <20260917035433.4114718-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035433.4114718-1-sashal@kernel.org>
References: <2026091601-untagged-squatter-778d@gregkh>
 <20260917035433.4114718-1-sashal@kernel.org>
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
index 7864d9f3b7053..92905e29fcc6a 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1112,7 +1112,8 @@ static void populate_new_aces(char *nacl_base,
 
 static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
-		struct smb_sid *pnownersid, struct smb_sid *pngrpsid)
+		struct smb_sid *pnownersid, struct smb_sid *pngrpsid,
+		int *aclflag)
 {
 	int i;
 	u16 size = 0;
@@ -1136,12 +1137,15 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
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
@@ -1463,7 +1467,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 			/* Replace ACEs for old owner with new one */
 			size = replace_sids_and_copy_aces(dacl_ptr, ndacl_ptr,
 					owner_sid_ptr, group_sid_ptr,
-					nowner_sid_ptr, ngroup_sid_ptr);
+					nowner_sid_ptr, ngroup_sid_ptr,
+					aclflag);
 			ndacl_ptr->size = cpu_to_le16(size);
 		}
 
@@ -1678,7 +1683,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			kuid_t uid, kgid_t gid)
 {
 	int rc = 0;
-	int aclflag = CIFS_ACL_DACL; /* default flag to set */
+	int aclflag = 0;
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
@@ -1782,6 +1787,11 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
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

