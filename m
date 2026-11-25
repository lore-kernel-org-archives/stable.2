Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635450;
	b=aN7m4UjibcptfNjHQIS5032T2y6hnPfoX7UiIsOYz2aOT1q//hk89sPzgA60P/rAZhgH
	 r/asqddeiHyR0yrFH5FxW4te8AqRWNZHigs/UJM0xmhLbAjgu5LRL+MQeZvD0P+msq5LS
	 ws7lyAlFmCFzCvnelCKcFtYO6ahY90Wct45A/uDJY0zhtHXHGDsb9uklCfibF/xvxXcGk
	 ZCSDtU3NnnG/eFKg60eE9iFCuLPAYLNRYt1F6RwXhbfGEpP2w+D47nSW/4fU0HKT4Q15L
	 L0k4Y8Lyl55J8kTxygfZtLkuuPMXVnats9C2IPq7q9cE6y4FWyKC+jwMFjTHMUwdkIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z6jlZPPB+BcFemLIrqZoyihzS+S4RZWy1BG4jrkI0t0=;
	b=UhqymlofQxth/ek/i1CmZV0JATzeNZN1kkCQhq3dhclEtP7zu4SVxZGqucXotqI6/o0E
	 K/1kWnw/aYk8b0vZsM+mNH3rjHWqeq5Zw7pg8ek1QDhliaj7dLDLImM4ALljSMXfks0b1
	 EAS+XdUuk/oURHvXc8Bi+VlQyKG/qYj7cT6FCZvu8C08aBhnQR1vkKBjhFrgDH4lcM0ZT
	 mRNbqoje/Nai8nrDtG/iCqJJ0CSVFH6+/Ht2FttHJXgldoQ20nWNpkw4biBabiAWatBH9
	 oiV37zJtyXGIKjRhAFlk1lGBA+PvV9eNcqZqG1CFIAGNZkUtCT9j7eayU27cGMo7YNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oa600321;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEF606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oa600321
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071F21F000D8;
	Wed, 25 Nov 2026 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635449;
	bh=Z6jlZPPB+BcFemLIrqZoyihzS+S4RZWy1BG4jrkI0t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oa600321EXTMXJUavJ90DCcquELvpf02Nhuc0TgSzAPR2er0rru3LJFptdy/4yhYn
	 veXh1Jqi/kv1rp2CJ6k00Q3w+DA789Gd/82hmYCcwGnMOZsb+SNzStZOw/6kT0SpFn
	 A8ciEYb/OpnjMDCEBhDoAY2pVYzyOW6PjGcHrNa30KQp5HpWk7G+2o3Wfle5xk9NWB
	 VIG6XzA/t3n0fFX1lRDIibkA0u0CS6vqsWPTUoS21zh/1/I9YjHXqC7U48an42vCBr
	 S9sUaj64pct/trKTRQ62xAXZyRRTinmFUGtPCZHvWV7vHcowuIv1NkJgHmpj3KtJkb
	 dju2NRKO+Vjww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: let the parent's DACL grant DELETE and FILE_READ_ATTRIBUTES
Date: Wed, 25 Nov 2026 14:37:27 -0500
Message-ID: <20261125192718.1186906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-rice-courier-add3@gregkh>
References: <2026112510-rice-courier-add3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 4ab80fd4d1f1c4363b336ddb3d8818ea37c4997d ]

FILE_DELETE_CHILD on a directory can grant DELETE on its children.
FILE_LIST_DIRECTORY can similarly grant FILE_READ_ATTRIBUTES. Because
ksmbd checks only the child's DACL, it can refuse rename, deletion and
attribute opens that the parent permits.

When the child does not grant an explicitly requested DELETE or
FILE_READ_ATTRIBUTES, check the parent for FILE_DELETE_CHILD or
FILE_LIST_DIRECTORY. Use exact SID matching, evaluate group allows and
denies, and exclude guest and anonymous sessions from Authenticated
Users. Fail closed on non-inherit-only object deny ACEs, missing or
unreadable parent DACLs and the mount root.

For the strict parent check, let applicable group and OWNER RIGHTS ACEs
decide before the POSIX ACL fallback. Otherwise a POSIX ACL entry can
hide a FILE_DELETE_CHILD grant.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 99 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 18 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c3be25f2db87b..ef376c8a789cd 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1487,6 +1487,11 @@ static bool smb_sid_is_owner_rights(const struct smb_sid *sid)
 	       !compare_sids(sid, &sid_owner_rights);
 }
 
+static unsigned int smb_parent_derived_rights(struct ksmbd_conn *conn,
+					      const struct path *path, int uid,
+					      bool authenticated,
+					      unsigned int want);
+
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, __le32 raw_daccess, int uid,
 			bool authenticated, bool strict)
@@ -1507,16 +1512,19 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	unsigned int grp_allowed = 0, grp_denied = 0, bits;
 	struct smb_ace *others_ace = NULL;
 	bool or_ace = false, obj_deny = false, au_ace = false, member, counted;
+	bool grp_ace = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
 	bool is_owner, owner_rights = false;
 	bool maximal = *pdaccess & FILE_MAXIMAL_ACCESS_LE;
 	/*
-	 * MAXIMUM_ALLOWED requests match every session against
-	 * Authenticated Users.
+	 * MAXIMUM_ALLOWED requests that are not strict match every session
+	 * against Authenticated Users and do not count ACEs for the
+	 * caller's groups. Strict ones match SIDs as explicit requests do.
 	 */
-	bool authusers = authenticated || maximal;
+	bool open_max = maximal && !strict;
+	bool authusers = authenticated || open_max;
 	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
@@ -1550,13 +1558,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		/*
 		 * An empty (present, zero-ACE) DACL grants no access to
 		 * anyone except the object owner's implicit READ_CONTROL
-		 * and WRITE_DAC (MS-DTYP 2.4.5). Deny every other caller,
-		 * deny the owner any access beyond those two bits, and do
-		 * not let trailing bytes after a zero-ACE DACL become an
-		 * implicit grant.
+		 * and WRITE_DAC (MS-DTYP 2.5.3.2), besides what the parent
+		 * grants. Deny every other right, and do not let trailing
+		 * bytes after a zero-ACE DACL become an implicit grant.
 		 */
 		if (is_owner)
 			allowed = READ_CONTROL | WRITE_DAC;
+		if (!strict)
+			allowed |= smb_parent_derived_rights(conn, path, uid,
+							     authenticated,
+							     requested & ~allowed);
 		if (maximal)
 			requested |= allowed;
 		if (!allowed || requested & ~allowed)
@@ -1569,9 +1580,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	/*
 	 * Evaluate the DACL in order (MS-DTYP 2.5.3.2). access_bits collects
 	 * the result for the ACEs that apply to the caller, without its groups
-	 * for MAXIMUM_ALLOWED. grp_granted collects what ACEs for the caller's
-	 * groups, or OWNER RIGHTS for the owner, grant. It is used when the
-	 * SID lookup and POSIX ACL fallback below do not decide.
+	 * for a MAXIMUM_ALLOWED request that is not strict. grp_granted
+	 * collects what ACEs for the caller's groups, or OWNER RIGHTS for the
+	 * owner, grant. It is used when the SID lookup and POSIX ACL fallback
+	 * below do not decide.
 	 */
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = pdacl_size - sizeof(struct smb_acl);
@@ -1616,8 +1628,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     compare_sids(&sid_owner_rights, &ace->sid) &&
 		     !member))
 			goto next_ace;
-		/* An explicit request counts only SIDs that match exactly */
-		if (!maximal && !member &&
+		/* Other requests count only SIDs that match exactly */
+		if (!open_max && !member &&
 		    !smb_sid_equal(&sid, &ace->sid) &&
 		    !smb_sid_equal(&sid_everyone, &ace->sid) &&
 		    !(authusers && smb_sid_equal(&sid_authusers, &ace->sid)) &&
@@ -1627,10 +1639,11 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		bits = le32_to_cpu(ace->access_req);
 		switch (ace->type) {
 		case ACCESS_ALLOWED_ACE_TYPE:
+			grp_ace |= counted;
 			if (counted)
 				grp_allowed |= bits;
-			/* MAXIMUM_ALLOWED takes no group grants */
-			if (maximal && member)
+			/* An open's MAXIMUM_ALLOWED takes no group grants */
+			if (open_max && member)
 				break;
 			if (counted)
 				grp_granted |= bits;
@@ -1638,10 +1651,11 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			break;
 		case ACCESS_DENIED_ACE_TYPE:
 		case ACCESS_DENIED_CALLBACK_ACE_TYPE:
+			grp_ace |= counted;
 			if (counted)
 				grp_denied |= ~grp_allowed & bits;
-			/* MAXIMUM_ALLOWED takes no group denials either */
-			if (!(maximal && member))
+			/* nor group denials */
+			if (!(open_max && member))
 				denied |= ~access_bits & bits;
 			break;
 		}
@@ -1656,6 +1670,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			access_bits |= READ_CONTROL | WRITE_DAC |
 				FILE_READ_ATTRIBUTES | DELETE;
 		access_bits &= ~denied;
+		/* An object deny ACE could deny the parent's rights */
+		if (!open_max && obj_deny)
+			access_bits = 0;
 		if ((raw_daccess & FILE_GENERIC_EXECUTE_LE) &&
 		    S_ISREG(d_inode(path->dentry)->i_mode) &&
 		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
@@ -1712,10 +1729,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
 		/*
 		 * An Authenticated Users ACE keeps the POSIX ACL from deciding,
-		 * also for sessions that it does not match.
+		 * also for sessions that it does not match. For a strict
+		 * MAXIMUM_ALLOWED request, ACEs for the caller's groups or
+		 * OWNER RIGHTS decide before the POSIX ACL, unless the DACL has
+		 * an object deny ACE, which ksmbd does not parse.
 		 */
 		if (!IS_ERR_OR_NULL(posix_acls) && !found && !others_ace &&
-		    !au_ace) {
+		    !au_ace && !(strict && maximal && grp_ace && !obj_deny)) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1776,6 +1796,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			 */
 			if (!obj_deny)
 				allowed |= grp_granted;
+			if (!strict)
+				allowed |= smb_parent_derived_rights(conn, path, uid,
+								     authenticated,
+								     requested & ~allowed);
 			if (maximal)
 				requested |= allowed;
 			if (!allowed || requested & ~allowed) {
@@ -1821,6 +1845,45 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	return rc;
 }
 
+/*
+ * Return the rights in @want that @path gets from its parent directory:
+ * DELETE if the parent's DACL grants FILE_DELETE_CHILD, and
+ * FILE_READ_ATTRIBUTES if it grants FILE_LIST_DIRECTORY
+ * (MS-FSA 2.1.5.1.2.1). A parent with no DACL, or with one that ksmbd
+ * cannot read, gives nothing. Callers pass only rights that the request
+ * names.
+ */
+static unsigned int smb_parent_derived_rights(struct ksmbd_conn *conn,
+					      const struct path *path, int uid,
+					      bool authenticated,
+					      unsigned int want)
+{
+	struct path parent = { .mnt = path->mnt };
+	__le32 granted = FILE_MAXIMAL_ACCESS_LE;
+	unsigned int rights = 0;
+	int rc;
+
+	if (!(want & (DELETE | FILE_READ_ATTRIBUTES)))
+		return 0;
+
+	/* The root of the mount, or a disconnected dentry, has no parent */
+	if (path->dentry == path->mnt->mnt_root || IS_ROOT(path->dentry))
+		return 0;
+
+	parent.dentry = dget_parent(path->dentry);
+	/* Strict, so the parent's own parent is not consulted */
+	rc = smb_check_perm_dacl(conn, &parent, &granted, 0, uid,
+				 authenticated, true);
+	dput(parent.dentry);
+	if (rc || granted == FILE_MAXIMAL_ACCESS_LE)
+		return 0;
+	if (granted & FILE_DELETE_CHILD_LE)
+		rights |= DELETE;
+	if (granted & FILE_LIST_DIRECTORY_LE)
+		rights |= FILE_READ_ATTRIBUTES;
+	return rights & want;
+}
+
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check, bool get_write)
-- 
2.53.0

