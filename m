Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603078;
	b=u1kAMxMUufz0SOvTFjnIvomRFqdR5OWPWXbDmsGrzqKLVM6RuNN/RRlcVVKLK3fx2tRu
	 eVtjkTrvV/C5v69rpSXamzHboQqBvAzZr6+SF/EtqtzbVRsFrqTG7SkDNxsdJg94JfERo
	 LFpnq4nv2/nv4ql3WF6ALI7lmWRrQ2Pi53yzBub5qwsq/TZayjoYF1biQouPbMazQfkyQ
	 l2NagpKVD5+MtMIGe53j3uN8ogelRT4nupv/CjlEcc5qtWadmOLtGVFuP9EGOPGEuGiFQ
	 G3a6MI4zWowE7SG1Ox7HyAjU+sH488AWu42LxFMuVy5nKsKjAqnDQBIm+8ktTx7sYNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603078;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cNc6x7M7BhB3p877b0rtPwr9RJwKERTm3yCMciLxJuA=;
	b=Tk5eGrVSEbWBB86UFdP/eAntM63qYvc4Nr65EHHkmSkWwoZcP5wsqps1CXUDLyPtXqCN
	 qob4OgQmZnjb9xfe0L/T7WzPBSB08Fo+htSzbkWHR897UC+eoe6hXZaN0C7iNaccv3T/n
	 hNMGI5Ss7crIsD/gWsB2tSPnejczMz3H8o1eUvHlxXbvh5QnsBrT0puW5w8frgEvRlSB8
	 NBUrcGE2aeLPPkzVEhFPI6Tqqz3ZYTSAEan8eI4jpSZyGCJVIuJEciNgXSqtQshF57XXO
	 Zb8V2KopJ+Fzs2VKaBx9NhCDWAhd1qknGgZgNo7j70SdAqXmFM/9cCmk6VW1i4oX6Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yEZ160vh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC74606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yEZ160vh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05751F000D0;
	Wed, 25 Nov 2026 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603077;
	bh=cNc6x7M7BhB3p877b0rtPwr9RJwKERTm3yCMciLxJuA=;
	h=Subject:To:Cc:From:Date;
	b=yEZ160vhRPnDyOmymANlkF/TISLsziAZF+xKlXBtlqVwPAl0DuMJXe6iJ+foF8JOV
	 Y6dFEvmgc68Np5nSXXMj0W5i7QW2eWENBHsxNnQafDin88FBZ1BOrRgfjs6qCnXkG0
	 c8J1sUFxa+WHSn4YanTqPLnfldxzg0bVeKV6s5SY=
Subject: FAILED: patch "[PATCH] ksmbd: let the parent's DACL grant DELETE and" failed to apply to 6.12-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:11 +0100
Message-ID: <2026112511-posting-plating-d034@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 4ab80fd4d1f1c4363b336ddb3d8818ea37c4997d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-posting-plating-d034@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ab80fd4d1f1c4363b336ddb3d8818ea37c4997d Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Sun, 8 Nov 2026 12:20:11 -0600
Subject: [PATCH] ksmbd: let the parent's DACL grant DELETE and
 FILE_READ_ATTRIBUTES

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

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 50a03101cd8a..1b387c262d59 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1494,6 +1494,11 @@ static bool smb_sid_is_owner_rights(const struct smb_sid *sid)
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
@@ -1514,16 +1519,19 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1557,13 +1565,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1576,9 +1587,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1623,8 +1635,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1634,10 +1646,11 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1645,10 +1658,11 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1663,6 +1677,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			access_bits |= READ_CONTROL | WRITE_DAC |
 				FILE_READ_ATTRIBUTES | DELETE;
 		access_bits &= ~denied;
+		/* An object deny ACE could deny the parent's rights */
+		if (!open_max && obj_deny)
+			access_bits = 0;
 		if ((raw_daccess & FILE_GENERIC_EXECUTE_LE) &&
 		    S_ISREG(d_inode(path->dentry)->i_mode) &&
 		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
@@ -1719,10 +1736,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1774,6 +1794,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
@@ -1820,6 +1844,45 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 }
 EXPORT_SYMBOL_IF_KUNIT(smb_check_perm_dacl);
 
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
 		 bool type_check, bool get_write, bool posix_open,

