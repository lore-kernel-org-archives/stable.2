Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9A3B1ED1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617503; cv=none; b=JEIfkewVqjS9ilzfnVmwHPk9eXiFGUqCWgR73TdUVC2OceHZPKzTrqryw3g+04GVu9qwoh8PiV7wWuQSGDNASyXOGhoqn6XuWQtLqw+AVCpAgejZ/ytBYC4/5MsN/tA2cfpjedLb8gFqoaeGOmAlLHl4oFrlt1x1slbBRT3k36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617503; c=relaxed/simple;
	bh=rqy2OnCOXipnm1DAz0Jy6JvOFj+7UfaufG12qUqhuco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezP1bQKVQ2yTFkyjwkzhCgkqiizebpWcYYrewk0zCD9A9QMqRh2AlwyP52IT9dWijucMCpJirOqQGy9HUe4waU8AutXrauG/Wf4QyPs/xIsrQv9CkGPAxopo8FvyYr7zwwTBh734Es88BXG17FbiJ99z7FxDhUCRV9XS8skSi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkgjFZz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkgjFZz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E411F00893;
	Thu, 17 Sep 2026 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617501;
	bh=zMQM/iJh3FjmQBe5kuTqJNaX58aEgF70i3lLsWjI5aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkgjFZz8iRb+Bq4AgzAloROButGw6IRXuGCr96XKrZFWn/KO6jMxYCvRVe6yNUbCP
	 pZmW+DdEgYiy5kovQtRFpkBw7wl9XiNauQi4ykb5h6QMFXSR5t2r96UjFz0U52t9xc
	 DwmRx/UUQFGVHcsAEcPWaS6NxfzRerkBjEg6CxgvA7rfGanNwwBsVgc+JZ6tvAlbbA
	 Fs41U9y9EC+/hweCUUb08lmPe7HkgrA9+atityc1t6kbtI+XJ0RfGxhTnRqe7uE9DN
	 JcTJ98xSbQLgzIKOkI0vFMnxKDSR4FKRHIa54JVMESxdoXYGxOKQOmlQX/dqGiDpJX
	 gRS/4dcQlW2vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: fail DACL rewrite when the new DACL exceeds 64K
Date: Wed, 16 Sep 2026 23:58:18 -0400
Message-ID: <20260917035818.4126527-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917035818.4126527-1-sashal@kernel.org>
References: <2026091602-staging-palatable-a0c1@gregkh>
 <20260917035818.4126527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjoern Doebel <doebel@amazon.de>

[ Upstream commit d05045177a855386bca5e1909e08d06290e6e3b3 ]

replace_sids_and_copy_aces() and set_chmod_dacl() accumulate the size of
the DACL they build in a u16. That accumulator can wrap.

validate_dacl() caps num_aces at (dacl_size - sizeof(struct smb_acl)) /
20, i.e. 3276 for a maximally sized DACL, while each rewritten ACE can
grow to sizeof(struct smb_ace) (76 bytes) once its SID is replaced with
one carrying SID_MAX_SUB_AUTHORITIES sub-authorities. The worst case is
therefore sizeof(struct smb_acl) + 3276 * 76 = 248984 bytes, far beyond
what a u16 can hold. A wraparound is reached with 863 ACEs.

After the wraparound, ndacl_ptr->size becomes meaningless and the offset
will point anywhere in the ACE array. As a result, we will see
corruption of the DACL, which then gets sent to the server. This is not
an out-of-bounds write as the allocation now covers the worst-case
expansion, so writes will always go into the buffer.

Adjust the code to use a u32 internally and return -EOVERFLOW in the
overflow case. The operation must be refused, because a DACL can only
hold 2^16-1 bytes on the wire and larger DACLs cannot be represented.

set_chmod_dacl() carries the same pattern and is fixed the same way. It
only wraps once the source DACL comes within roughly 380 bytes of the
64K ceiling, but the failure mode is identical.

Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Fixes: f5065508897a ("cifs: Retain old ACEs when converting between mode bits and ACL.")
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ae0e858935547..9adfc26155d04 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1006,13 +1006,13 @@ unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
 static void populate_new_aces(char *nacl_base,
 		struct smb_sid *pownersid,
 		struct smb_sid *pgrpsid,
-		__u64 *pnmode, u16 *pnum_aces, u16 *pnsize,
+		__u64 *pnmode, u16 *pnum_aces, u32 *pnsize,
 		bool modefromsid,
 		bool posix)
 {
 	__u64 nmode;
 	u16 num_aces = 0;
-	u16 nsize = 0;
+	u32 nsize = 0;
 	__u64 user_mode;
 	__u64 group_mode;
 	__u64 other_mode;
@@ -1111,17 +1111,17 @@ static void populate_new_aces(char *nacl_base,
 	*pnsize = nsize;
 }
 
-static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
-		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
-		struct smb_sid *pnownersid, struct smb_sid *pngrpsid,
-		int *aclflag)
+static int replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
+				      struct smb_sid *pownersid, struct smb_sid *pgrpsid,
+				      struct smb_sid *pnownersid, struct smb_sid *pngrpsid,
+				      int *aclflag, u16 *pnsize)
 {
 	int i;
 	u16 size = 0;
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
 	u16 src_num_aces = 0;
-	u16 nsize = 0;
+	u32 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u16 ace_size = 0;
@@ -1150,9 +1150,12 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 
 		size += le16_to_cpu(pntace->size);
 		nsize += ace_size;
+		if (nsize > U16_MAX)
+			return -EOVERFLOW;
 	}
 
-	return nsize;
+	*pnsize = nsize;
+	return 0;
 }
 
 static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
@@ -1164,7 +1167,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
 	u16 src_num_aces = 0;
-	u16 nsize = 0;
+	u32 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u16 num_aces = 0;
@@ -1215,6 +1218,8 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 
 		nsize += cifs_copy_ace(pnntace, pntace, NULL);
 		num_aces++;
+		if (nsize > U16_MAX)
+			return -EOVERFLOW;
 
 next_ace:
 		size += le16_to_cpu(pntace->size);
@@ -1231,6 +1236,10 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	}
 
 finalize_dacl:
+	/* The DACL size field is 16-bit on the wire, see MS-DTYP 2.4.5 */
+	if (nsize > U16_MAX)
+		return -EOVERFLOW;
+
 	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(nsize);
 
@@ -1391,6 +1400,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
 				    pnmode, mode_from_sid, posix);
+		if (rc)
+			return rc;
 
 		sidsoffset = ndacloffset + le16_to_cpu(ndacl_ptr->size);
 		/* copy the non-dacl portion of secdesc */
@@ -1466,10 +1477,12 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 		if (dacloffset) {
 			/* Replace ACEs for old owner with new one */
-			size = replace_sids_and_copy_aces(dacl_ptr, ndacl_ptr,
-					owner_sid_ptr, group_sid_ptr,
-					nowner_sid_ptr, ngroup_sid_ptr,
-					aclflag);
+			rc = replace_sids_and_copy_aces(dacl_ptr, ndacl_ptr,
+							owner_sid_ptr, group_sid_ptr,
+							nowner_sid_ptr, ngroup_sid_ptr,
+							aclflag, &size);
+			if (rc)
+				goto chown_chgrp_exit;
 			ndacl_ptr->size = cpu_to_le16(size);
 		}
 
-- 
2.53.0

