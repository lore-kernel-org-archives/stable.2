Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603058;
	b=wancFoWTZ6c6voIJqwEA5r0J9RrDv4Ox/W7uPeJ87PsNoyc9+zmIpzbgiTyh0BDDIgAx
	 +TUOUHK7RWWfe+lK/qLwtePb6QLiKMwNM320ORRy7ZY+Au9+GQcB6SKojJKqrVob/lc5T
	 /1+J3n7Du+GTj3ozLVckuVPt3D7yVxG/pIiJjk5sH45GNIAZhfiVTtY7LPcjpiFp7ac4C
	 wUtaapRdYe4yh6RYPcH8uPK34RUuWcZ7NR4TpSCSg6N5pB6WVTIdym+sRaUlBOgDsb85I
	 nl60Eb3X/zoRWX/CW7GzHKc2FqpXBSNCWxXEvwB4raNSj/2zeCrFjdoNSwG7w/ASQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603058;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9Zqpq2VEDZTuD8L896ch48oDmrdZrKH5uPD9GmX4nKA=;
	b=xwib8BNRrdS4byD3Ju6VtXy8d92W78kIkJU7U8rWrKoPdnf/N0SLM0TEY7jBeaYjzATn
	 lpRYdyaTmDkyYAQWkuS0Lq3+XxyHi04B+omILZg1r6sPU6qiBeJ68sl5uUxethAU/gNfS
	 /Ewctt/5X/DQeWG09Ql+lnvwT2RQe7kHRnbzxV/Smq/5Ejf2uVTRbtaFXjCH1SxniVKMK
	 p84Nc0PkYcxffR87M/1mJBtvhSgai2YuY8NM42Z4zCcf0PaPMT2rnLLGP88iJi3pNSUu9
	 xmJ152GkRdqC2yho1ymMT6Fhfqeq7SeReDQWtWz+J0LWOTZMaKbs1PeMsQmKEn26BxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZjXYW3Gj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EB606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZjXYW3Gj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4031F000D8;
	Wed, 25 Nov 2026 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603058;
	bh=9Zqpq2VEDZTuD8L896ch48oDmrdZrKH5uPD9GmX4nKA=;
	h=Subject:To:Cc:From:Date;
	b=ZjXYW3GjMethWEuRjPf34lDoksqE6xErXG7mbpdHg+bsUThKFXjpvrlYg0pPFSs79
	 IuqbRBGJjvghMzXIcXJORETFkvothN/prdCU32+mRl02zd7GP7SMHxVV+7JWjZ92ZZ
	 RgTNSd8bwHY7N8s0mbKud8i0boLZSr9rMvmJ3gw8=
Subject: FAILED: patch "[PATCH] ksmbd: evaluate the DACL in order for explicit access" failed to apply to 6.18-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:25:41 +0100
Message-ID: <2026112541-karma-product-dcfa@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 20bed0d6ff62d985fe8222958825504b8aad4e88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-karma-product-dcfa@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 20bed0d6ff62d985fe8222958825504b8aad4e88 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Sun, 8 Nov 2026 12:20:10 -0600
Subject: [PATCH] ksmbd: evaluate the DACL in order for explicit access
 requests

For requests without MAXIMUM_ALLOWED, smb_check_perm_dacl() selects one
ACE instead of evaluating the DACL in order. When the selected ACE is a
deny ACE, the function grants the complement of its mask, and deny ACEs
before it are ignored. The selected ACE can also be inherit-only,
unsupported, or an NFS mode ACE.

Guest and anonymous sessions also match Authenticated Users. These bugs
can grant read or write access that the stored DACL does not grant. For
example, a deny of FILE_READ_DATA grants FILE_WRITE_DATA, and guests can
read files granted only to Authenticated Users.

Evaluate explicit requests in DACL order. Use exact SID matching for the
caller, Everyone, Authenticated Users, OWNER RIGHTS and the caller's
groups. Match Authenticated Users only for authenticated sessions, and
ignore the NFS mode SID.

An Authenticated Users ACE must still prevent the POSIX ACL fallback
from replacing the DACL result for guest and anonymous sessions. The ACE
does not grant them access.

Keep the existing single-ACE behavior when a non-inherit-only object
deny ACE is present because ksmbd does not parse those ACEs. Guest and
anonymous sessions do not match Authenticated Users there either.
MAXIMUM_ALLOWED behavior is unchanged.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: cc2f133e80eb ("ksmbd: fix maximum allowed access checks")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/mgmt/user_config.h b/fs/smb/server/mgmt/user_config.h
index cc460b4ff7d3..e116b2ee9917 100644
--- a/fs/smb/server/mgmt/user_config.h
+++ b/fs/smb/server/mgmt/user_config.h
@@ -67,4 +67,9 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 void ksmbd_free_user(struct ksmbd_user *user);
 bool ksmbd_anonymous_user(struct ksmbd_user *user);
 bool ksmbd_compare_user(struct ksmbd_user *u1, struct ksmbd_user *u2);
+
+static inline bool ksmbd_user_authenticated(struct ksmbd_user *user)
+{
+	return user && !user_guest(user) && !ksmbd_anonymous_user(user);
+}
 #endif /* __USER_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5bbc33d5a3a8..72981756ee23 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4338,7 +4338,8 @@ static int smb2_handle_app_instance_id(struct ksmbd_work *work,
 	/* Authorize the referenced open even if its name changes meanwhile. */
 	old_path = &old_fp->filp->f_path;
 	rc = smb_check_perm_dacl(conn, old_path, &maximal_access, 0,
-				 work->sess->user->uid, false);
+				 work->sess->user->uid,
+				 ksmbd_user_authenticated(work->sess->user), false);
 	if (rc) {
 		/* Access denial prevents takeover, not the CREATE itself. */
 		ksmbd_put_durable_fd(old_fp);
@@ -4860,14 +4861,17 @@ int smb2_open(struct ksmbd_work *work)
 	if (file_present && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
 		rc = smb_check_perm_dacl(conn, &path, &daccess,
 					 req->DesiredAccess,
-					 sess->user->uid, false);
+					 sess->user->uid,
+					 ksmbd_user_authenticated(sess->user), false);
 		if (rc)
 			goto err_out;
 
 		if (maximal_access_ctxt) {
 			maximal_access = FILE_MAXIMAL_ACCESS_LE;
 			rc = smb_check_perm_dacl(conn, &path, &maximal_access,
-						 0, sess->user->uid, false);
+						 0, sess->user->uid,
+						 ksmbd_user_authenticated(sess->user),
+						 false);
 			if (rc)
 				goto err_out;
 
@@ -6347,6 +6351,7 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 			rc = smb_check_perm_dacl(priv->work->conn, &path,
 						 &daccess, daccess,
 						 priv->work->sess->user->uid,
+						 ksmbd_user_authenticated(priv->work->sess->user),
 						 true);
 			if (rc) {
 				dput(dent);
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 32feafe9f73b..50a03101cd8a 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1478,6 +1478,12 @@ static bool smb_sid_in_group(const struct smb_sid *sid)
 	return in_group_p(make_kgid(&init_user_ns, gid));
 }
 
+/* Whether two SIDs are the same SID */
+static bool smb_sid_equal(const struct smb_sid *a, const struct smb_sid *b)
+{
+	return a->num_subauth == b->num_subauth && !compare_sids(a, b);
+}
+
 /*
  * compare_sids() compares only the sub-authorities both SIDs have, so it
  * also matches a shorter or longer SID, such as S-1-3 or S-1-3-4-777
@@ -1490,7 +1496,7 @@ static bool smb_sid_is_owner_rights(const struct smb_sid *sid)
 
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, __le32 raw_daccess, int uid,
-			bool strict)
+			bool authenticated, bool strict)
 {
 	const struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	struct smb_ntsd *pntsd = NULL;
@@ -1507,12 +1513,17 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	unsigned int access_bits = 0, denied = 0, grp_granted = 0;
 	unsigned int grp_allowed = 0, grp_denied = 0, bits;
 	struct smb_ace *others_ace = NULL;
-	bool or_ace = false, obj_deny = false, member, counted;
+	bool or_ace = false, obj_deny = false, au_ace = false, member, counted;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
 	bool is_owner, owner_rights = false;
 	bool maximal = *pdaccess & FILE_MAXIMAL_ACCESS_LE;
+	/*
+	 * MAXIMUM_ALLOWED requests match every session against
+	 * Authenticated Users.
+	 */
+	bool authusers = authenticated || maximal;
 	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
@@ -1564,9 +1575,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	/*
 	 * Evaluate the DACL in order (MS-DTYP 2.5.3.2). access_bits collects
-	 * the MAXIMUM_ALLOWED result. grp_granted collects what ACEs for the
-	 * caller's groups, or OWNER RIGHTS for the owner, grant. It is used
-	 * when the SID lookup and POSIX ACL fallback below do not decide.
+	 * the result for the ACEs that apply to the caller, without its groups
+	 * for MAXIMUM_ALLOWED. grp_granted collects what ACEs for the caller's
+	 * groups, or OWNER RIGHTS for the owner, grant. It is used when the
+	 * SID lookup and POSIX ACL fallback below do not decide.
 	 */
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = pdacl_size - sizeof(struct smb_acl);
@@ -1606,10 +1618,18 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		    (compare_sids(&sid, &ace->sid) &&
 		     compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
 		     compare_sids(&sid_everyone, &ace->sid) &&
-		     compare_sids(&sid_authusers, &ace->sid) &&
+		     (!authusers ||
+		      compare_sids(&sid_authusers, &ace->sid)) &&
 		     compare_sids(&sid_owner_rights, &ace->sid) &&
 		     !member))
 			goto next_ace;
+		/* An explicit request counts only SIDs that match exactly */
+		if (!maximal && !member &&
+		    !smb_sid_equal(&sid, &ace->sid) &&
+		    !smb_sid_equal(&sid_everyone, &ace->sid) &&
+		    !(authusers && smb_sid_equal(&sid_authusers, &ace->sid)) &&
+		    !smb_sid_is_owner_rights(&ace->sid))
+			goto next_ace;
 
 		bits = le32_to_cpu(ace->access_req);
 		switch (ace->type) {
@@ -1627,8 +1647,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		case ACCESS_DENIED_CALLBACK_ACE_TYPE:
 			if (counted)
 				grp_denied |= ~grp_allowed & bits;
-			/* access_bits takes no group denials either */
-			if (!member)
+			/* MAXIMUM_ALLOWED takes no group denials either */
+			if (!(maximal && member))
 				denied |= ~access_bits & bits;
 			break;
 		}
@@ -1648,8 +1668,14 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
 			access_bits |= FILE_EXECUTE;
 		granted = requested | access_bits;
+	} else if (!obj_deny) {
+		/* An explicit request takes the ordered result */
+		access_bits &= ~denied;
 	} else {
-		/* An explicit request uses only grp_granted and obj_deny */
+		/*
+		 * ksmbd does not parse object deny ACEs, so with one present an
+		 * explicit request keeps the answer of the ACE found below
+		 */
 		access_bits = 0;
 	}
 
@@ -1680,15 +1706,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		    !(ace->flags & INHERIT_ONLY_ACE))
 			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
-		    !compare_sids(&sid_authusers, &ace->sid))
+		    (authusers &&
+		     !compare_sids(&sid_authusers, &ace->sid)))
 			others_ace = ace;
+		if (!compare_sids(&sid_authusers, &ace->sid))
+			au_ace = true;
 
 		ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
 	}
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (!IS_ERR_OR_NULL(posix_acls) && !found && !others_ace) {
+		/*
+		 * An Authenticated Users ACE keeps the POSIX ACL from deciding,
+		 * also for sessions that it does not match.
+		 */
+		if (!IS_ERR_OR_NULL(posix_acls) && !found && !others_ace &&
+		    !au_ace) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1752,7 +1786,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		}
 	}
 
-	if (!maximal) {
+	if (!maximal && obj_deny) {
 		switch (ace->type) {
 		case ACCESS_ALLOWED_ACE_TYPE:
 			access_bits = le32_to_cpu(ace->access_req);
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 3342cebab333..bbd35948a379 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -97,7 +97,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     unsigned int uid, unsigned int gid);
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, __le32 raw_daccess, int uid,
-			bool strict);
+			bool authenticated, bool strict);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check, bool get_write, bool posix_open,
diff --git a/fs/smb/server/tests/smbacl_kunit.c b/fs/smb/server/tests/smbacl_kunit.c
index 33496b4d31a3..bf28439a7696 100644
--- a/fs/smb/server/tests/smbacl_kunit.c
+++ b/fs/smb/server/tests/smbacl_kunit.c
@@ -229,7 +229,7 @@ static void ksmbd_smb_check_perm_dacl_boundary_test(struct kunit *test)
 		goto out;
 
 	rc = smb_check_perm_dacl(NULL, &file->f_path, &daccess,
-				 cpu_to_le32(FILE_READ_DATA), 0, false);
+				 cpu_to_le32(FILE_READ_DATA), 0, true, false);
 
 	/*
 	 * The post-boundary ACE (ACE #2, beyond pdacl->size) grants
@@ -271,7 +271,7 @@ ksmbd_smb_check_perm_dacl_maximal_boundary_test(struct kunit *test)
 		goto out;
 
 	rc = smb_check_perm_dacl(NULL, &file->f_path, &daccess,
-				 FILE_MAXIMAL_ACCESS_LE, 0, false);
+				 FILE_MAXIMAL_ACCESS_LE, 0, true, false);
 	KUNIT_EXPECT_EQ(test, 0, rc);
 	if (rc)
 		goto out;

