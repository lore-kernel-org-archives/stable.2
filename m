Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C54D0CF1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577313; cv=none; b=e6ZORMe4gmfYDgOZErp+t+Ady2wjJfbrZNyYMRZDoJ4fT3J/JIXS3hD2HQMd/c1SouPwg6a2UBjcSqfAddCnQffxd01uXT1bUE2wxbiTG1LPedAT0DPPx1KU9hSVK7MQhr7lAA0iWXfMUWJjKIB9oIQKkHmTxUE/myZ7AprfU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577313; c=relaxed/simple;
	bh=M5jsccUcAb8FrA1+p192i7s3t59Q8mP3/XyK0RUWflA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FvVXHhzejNtDLUze7MJgWMINlpBroRRUSqhfuS7gZhzRDEeMcW8b/nxpXemt7lUaMF6tyJhEhQNQ51Qq1/5xQNArgKugIiWNrhc640hDtC9ysKskPVfR85S/KLjxGP7diLZmvaHYLhoFN3S0O8kDa1GnR/boigcO6s7UwEQxpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vsmksUQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vsmksUQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72A11F000FF;
	Wed, 16 Sep 2026 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577309;
	bh=X+9H/t20ps0pnKJ2f3pDDklXvrJ0U3vrolzyZmvN1Os=;
	h=Subject:To:Cc:From:Date;
	b=vsmksUQOG5n9g35hv0S2TRC82+6j/LtZI/LY2N1QIcsihHs64r8S9CIufMjWDFb+t
	 Y+I3t+tcXCTg5GoScpbQXljV0gF7LcatMv9+IPsECDnwptHLy29ShDP2XiJX7ek4X+
	 wgvwrOcnXMwpu0K/UKdZBEbbraodyzE9XF/b8l2I=
Subject: FAILED: patch "[PATCH] smb: client: fail DACL rewrite when the new DACL exceeds 64K" failed to apply to 6.12-stable tree
To: doebel@amazon.de,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:43:02 +0100
Message-ID: <2026091602-staging-palatable-a0c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d05045177a855386bca5e1909e08d06290e6e3b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091602-staging-palatable-a0c1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d05045177a855386bca5e1909e08d06290e6e3b3 Mon Sep 17 00:00:00 2001
From: Bjoern Doebel <doebel@amazon.de>
Date: Tue, 8 Sep 2026 16:10:01 +0000
Subject: [PATCH] smb: client: fail DACL rewrite when the new DACL exceeds 64K

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

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 3e96e151df35..c5e47a835f99 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1096,13 +1096,13 @@ unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
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
@@ -1201,17 +1201,17 @@ static void populate_new_aces(char *nacl_base,
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
@@ -1240,9 +1240,12 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 
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
@@ -1254,7 +1257,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
 	u16 src_num_aces = 0;
-	u16 nsize = 0;
+	u32 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u16 num_aces = 0;
@@ -1305,6 +1308,8 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 
 		nsize += cifs_copy_ace(pnntace, pntace, NULL);
 		num_aces++;
+		if (nsize > U16_MAX)
+			return -EOVERFLOW;
 
 next_ace:
 		size += le16_to_cpu(pntace->size);
@@ -1321,6 +1326,10 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	}
 
 finalize_dacl:
+	/* The DACL size field is 16-bit on the wire, see MS-DTYP 2.4.5 */
+	if (nsize > U16_MAX)
+		return -EOVERFLOW;
+
 	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(nsize);
 
@@ -1473,6 +1482,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
 				    pnmode, mode_from_sid, posix);
+		if (rc)
+			return rc;
 
 		sidsoffset = ndacloffset + le16_to_cpu(ndacl_ptr->size);
 		/* copy the non-dacl portion of secdesc */
@@ -1548,10 +1559,12 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
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
 

