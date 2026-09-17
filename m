Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988A2D0602
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617884; cv=none; b=oZtc0w0wk3i/VF0BCCOMlrPs35G7nay3wEie4u8cB52OU6HHxLb0oMbFVRQR1cZVhr5Z2kQZeF1K0k46F8LeM8tVMUtVJi6Sg+f9umQ17QvBJIg5j4OKmWO7d65cNUtCsT1bzET9R1pp7YxtNFAXos6hJJrcGkvv14dTnKtL06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617884; c=relaxed/simple;
	bh=rqy2OnCOXipnm1DAz0Jy6JvOFj+7UfaufG12qUqhuco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD0MdQOJYo4HcZCECSir008z53pFTLfuIncuw2D5uj60IlSX2k18TNjb7SUKjhpiIPChoI69ost0FqfKbkorlVnqXsu8g4Xpv2I43l4IfpfSYU6RayxsrYg9ZTjE3RQSdeoicWuBIdKumb29w6r9/UgStTsaVCvrfQ0+5crooBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq571mF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq571mF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF5F1F00899;
	Thu, 17 Sep 2026 04:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617883;
	bh=zMQM/iJh3FjmQBe5kuTqJNaX58aEgF70i3lLsWjI5aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yq571mF/IhFizFuQ+FXfybm89PMe0G++Hu1jgYYD/ZbbyI0T5kQEuvnP+6Hl3rN7x
	 nEAeaeLZMOWcLPqQ/z13ncIpaCo7NKEwTdMU/i/SBUto2c+7+W57ZwDZkrFmoJJJhK
	 +qipH7dABzfWZLlPKjY/C4cABxmTizxC2X/ebs2D2sIEHvgDe2zNQkTbjbJ+tvZ5rJ
	 gQybvtDVcJ1kyLO7Nd7FPuIeyALzErROpLG5izSZzcRoi7YeHzXr4IUdFcEspuafEL
	 r+MRLTVT61+07tI14TYn5X/GKdGkHTatcmrFiS+kSxRsrHYBe/cGTidft9TXbRxKf/
	 hnih1SWAAWG5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjoern Doebel <doebel@amazon.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] smb: client: fail DACL rewrite when the new DACL exceeds 64K
Date: Thu, 17 Sep 2026 00:04:39 -0400
Message-ID: <20260917040439.4163850-3-sashal@kernel.org>
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

