Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603043;
	b=FzNO1hFj4TKs3QR5R7DQ3E8HRD3ljMLMEjhuoXC66jDsV0TTY86mCXHHmaiael5SPSbZ
	 jLwcb139VZTAx97WA5VvFX6brVIpMube2PS1kwfcoMv0jiNpY1/6fPpR/RTxh58gqDzUs
	 +2FogYsH6AWnS2Qge1sg6zldl28DXVjEGQNTy7drRGXYEaOBi+Ol9xVzy68JouwVlb/dg
	 qYON/tDgaZ/vo8sVNEjhcLW+3YbYEjWkRW3voA4MoWppGyAegbd7tqYevygcJNb7TxwmD
	 c5g80U2HIEmOWzTBfFM3WEjf+trXcJ2Bgdzg3bfbDrtepTg0ib03vWm5AjIgMRDxb3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603043;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+sBi94XgcMMjtQAJm8cL8sozMYzhM5oDNqAgjfuW9RY=;
	b=FWcv1wLbKbioNb8OA4xadZ0/BhSliNqp7SOfvq3xPFsjzcWPO1uJipmhxV+AisigLM/m
	 EJFTCIi6VGYiYtqAeApoIOu8K5lEsLZ37pCU90NO/Ks7hOX3zCHU9lQHDvACp3FVUzcNu
	 08mbJP6SyOFBRiUH3zUMZN3O7jQcwIjU/0dAp/XPEgeNOzu9xodpiaWJVScCEQUZ+DOQZ
	 taORhFpzM9YWxnQrWR0J5qlPCaO2ts6gzlbyMkv/y/xfY1jt39xTWj12v+wnrCx7lli/E
	 Exg+tk4nan/J/KTPfSnVeGUeIVMF5XOdI9jqmes682RnUsXQAFgaByMv3wYAs1fMEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ma5hvE4m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38671606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ma5hvE4m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB71F000C0;
	Wed, 25 Nov 2026 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603042;
	bh=+sBi94XgcMMjtQAJm8cL8sozMYzhM5oDNqAgjfuW9RY=;
	h=Subject:To:Cc:From:Date;
	b=Ma5hvE4muobgtSXhhTvYnknAn+T3PXkkIWr0g6rRGU5Uke/Kdiq/2Aiy8EgfIW1Ou
	 Lo2zzcUqde/tgT2SZum5dwXDA7Mj23OQqErWFsrgWE+f1M141biQqASKBSY3YDT17D
	 B71XAjzT6k/SkTdNTkfv2sztAowi7b7yuVi2xQ74=
Subject: FAILED: patch "[PATCH] ksmbd: grant a caller what its groups and OWNER RIGHTS ACEs" failed to apply to 6.18-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:24:14 +0100
Message-ID: <2026112514-veto-clinic-0c88@gregkh>
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
git cherry-pick -x 42ac1f1917ae678ee2c47f415ab844af03bbd46b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112514-veto-clinic-0c88@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42ac1f1917ae678ee2c47f415ab844af03bbd46b Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Wed, 4 Nov 2026 12:58:04 -0600
Subject: [PATCH] ksmbd: grant a caller what its groups and OWNER RIGHTS ACEs
 allow

smb_check_perm_dacl() does not match ACEs for the caller's Unix
groups and refuses an owner named only by OWNER RIGHTS. These callers
cannot use rights the DACL grants them under MS-DTYP 2.5.3.2.

Match Unix group SIDs (S-1-22-2) against the caller's credentials. Use
the ordered DACL result when the existing SID lookup and POSIX ACL
fallback do not decide access. In that result, deny ACEs for the
caller's groups limit what it grants, also for MAXIMUM_ALLOWED. Count
only the exact OWNER RIGHTS SID in that result, since compare_sids()
also matches shorter and longer SIDs, and return only file access
rights. Preserve the refusal for non-inherit-only object deny ACEs,
which ksmbd does not parse.

MAXIMUM_ALLOWED still excludes group allow ACEs. Including them
requires corresponding changes in smb2_open() to avoid breaking
existing opens. An open relying on group grants can therefore still
fail when it requests a maximal access reply. For the owner, that
reply leaves out the rights of its groups.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index ab76c5c9e0ea..32feafe9f73b 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1459,6 +1459,35 @@ bool smb_inherit_flags(int flags, bool is_dir)
 	return false;
 }
 
+/* Whether the caller's credentials hold the group of an S-1-22-2-<gid> SID */
+static bool smb_sid_in_group(const struct smb_sid *sid)
+{
+	gid_t gid;
+
+	if (sid->num_subauth != sid_unix_groups.num_subauth + 1 ||
+	    compare_sids(sid, &sid_unix_groups))
+		return false;
+	gid = le32_to_cpu(sid->sub_auth[sid->num_subauth - 1]);
+	/*
+	 * ksmbd_override_fsids() builds the caller's credentials with
+	 * make_kgid(&init_user_ns, ...), so the group membership test must
+	 * compare in that space. Applying the mount idmap here (as when
+	 * resolving a SID to an on-disk gid) would mismatch on idmapped
+	 * mounts.
+	 */
+	return in_group_p(make_kgid(&init_user_ns, gid));
+}
+
+/*
+ * compare_sids() compares only the sub-authorities both SIDs have, so it
+ * also matches a shorter or longer SID, such as S-1-3 or S-1-3-4-777
+ */
+static bool smb_sid_is_owner_rights(const struct smb_sid *sid)
+{
+	return sid->num_subauth == sid_owner_rights.num_subauth &&
+	       !compare_sids(sid, &sid_owner_rights);
+}
+
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, __le32 raw_daccess, int uid,
 			bool strict)
@@ -1475,13 +1504,15 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	int granted = requested;
 	struct smb_ace *ace;
 	int i, found = 0;
-	unsigned int access_bits = 0, denied = 0;
+	unsigned int access_bits = 0, denied = 0, grp_granted = 0;
+	unsigned int grp_allowed = 0, grp_denied = 0, bits;
 	struct smb_ace *others_ace = NULL;
-	bool or_ace = false;
+	bool or_ace = false, obj_deny = false, member, counted;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
 	bool is_owner, owner_rights = false;
+	bool maximal = *pdaccess & FILE_MAXIMAL_ACCESS_LE;
 	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
@@ -1522,7 +1553,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		 */
 		if (is_owner)
 			allowed = READ_CONTROL | WRITE_DAC;
-		if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+		if (maximal)
 			requested |= allowed;
 		if (!allowed || requested & ~allowed)
 			rc = -EACCES;
@@ -1531,53 +1562,83 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		goto err_out;
 	}
 
-	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
-		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
-		aces_size = pdacl_size - sizeof(struct smb_acl);
-		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (aces_size < offsetof(struct smb_ace, sid) +
-			    CIFS_SID_BASE_SIZE)
-				break;
-			ace_size = le16_to_cpu(ace->size);
-			if (ace_size > aces_size ||
-			    ace_size < offsetof(struct smb_ace, sid) +
-				       CIFS_SID_BASE_SIZE)
-				break;
-			aces_size -= ace_size;
+	/*
+	 * Evaluate the DACL in order (MS-DTYP 2.5.3.2). access_bits collects
+	 * the MAXIMUM_ALLOWED result. grp_granted collects what ACEs for the
+	 * caller's groups, or OWNER RIGHTS for the owner, grant. It is used
+	 * when the SID lookup and POSIX ACL fallback below do not decide.
+	 */
+	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+	aces_size = pdacl_size - sizeof(struct smb_acl);
+	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
+			break;
+		ace_size = le16_to_cpu(ace->size);
+		if (ace_size > aces_size ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			       CIFS_SID_BASE_SIZE)
+			break;
+		aces_size -= ace_size;
 
-			if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
-			    ace_size < offsetof(struct smb_ace, sid) +
-				      CIFS_SID_BASE_SIZE +
-				      sizeof(__le32) * ace->sid.num_subauth)
-				break;
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			      CIFS_SID_BASE_SIZE +
+			      sizeof(__le32) * ace->sid.num_subauth)
+			break;
 
-			if (!compare_sids(&sid_owner_rights, &ace->sid)) {
-				owner_rights = true;
-				if (!is_owner)
-					goto next_ace;
-			}
+		if ((ace->type == ACCESS_DENIED_OBJECT_ACE_TYPE ||
+		     ace->type == ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			obj_deny = true;
 
-			if (ace->flags & INHERIT_ONLY_ACE ||
-			    (compare_sids(&sid, &ace->sid) &&
-			     compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
-			     compare_sids(&sid_everyone, &ace->sid) &&
-			     compare_sids(&sid_authusers, &ace->sid) &&
-			     compare_sids(&sid_owner_rights, &ace->sid)))
+		if (!compare_sids(&sid_owner_rights, &ace->sid)) {
+			owner_rights = true;
+			if (!is_owner)
 				goto next_ace;
-
-			switch (ace->type) {
-			case ACCESS_ALLOWED_ACE_TYPE:
-				access_bits |= le32_to_cpu(ace->access_req);
-				break;
-			case ACCESS_DENIED_ACE_TYPE:
-			case ACCESS_DENIED_CALLBACK_ACE_TYPE:
-				denied |= ~access_bits &
-					le32_to_cpu(ace->access_req);
-				break;
-			}
-next_ace:
-			ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
 		}
+
+		member = smb_sid_in_group(&ace->sid);
+		/* The grp_ masks count groups and OWNER RIGHTS only */
+		counted = member ||
+			  (is_owner && smb_sid_is_owner_rights(&ace->sid));
+		if (ace->flags & INHERIT_ONLY_ACE ||
+		    (compare_sids(&sid, &ace->sid) &&
+		     compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
+		     compare_sids(&sid_everyone, &ace->sid) &&
+		     compare_sids(&sid_authusers, &ace->sid) &&
+		     compare_sids(&sid_owner_rights, &ace->sid) &&
+		     !member))
+			goto next_ace;
+
+		bits = le32_to_cpu(ace->access_req);
+		switch (ace->type) {
+		case ACCESS_ALLOWED_ACE_TYPE:
+			if (counted)
+				grp_allowed |= bits;
+			/* MAXIMUM_ALLOWED takes no group grants */
+			if (maximal && member)
+				break;
+			if (counted)
+				grp_granted |= bits;
+			access_bits |= bits;
+			break;
+		case ACCESS_DENIED_ACE_TYPE:
+		case ACCESS_DENIED_CALLBACK_ACE_TYPE:
+			if (counted)
+				grp_denied |= ~grp_allowed & bits;
+			/* access_bits takes no group denials either */
+			if (!member)
+				denied |= ~access_bits & bits;
+			break;
+		}
+next_ace:
+		ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
+	}
+
+	/* Keep only file rights, not MAXIMUM_ALLOWED or generic bits */
+	grp_granted &= GENERIC_ALL_FLAGS & ~grp_denied;
+	if (maximal) {
 		if (is_owner && !owner_rights)
 			access_bits |= READ_CONTROL | WRITE_DAC |
 				FILE_READ_ATTRIBUTES | DELETE;
@@ -1587,6 +1648,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
 			access_bits |= FILE_EXECUTE;
 		granted = requested | access_bits;
+	} else {
+		/* An explicit request uses only grp_granted and obj_deny */
+		access_bits = 0;
 	}
 
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
@@ -1668,7 +1732,15 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			 */
 			if (is_owner && !or_ace)
 				allowed = READ_CONTROL | WRITE_DAC;
-			if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+			/*
+			 * Add what ACEs for the caller's groups, or OWNER
+			 * RIGHTS for the owner, grant in DACL order, unless an
+			 * object deny ACE, which ksmbd does not parse, could
+			 * apply.
+			 */
+			if (!obj_deny)
+				allowed |= grp_granted;
+			if (maximal)
 				requested |= allowed;
 			if (!allowed || requested & ~allowed) {
 				ksmbd_debug(SMB, "Can't find corresponding sid\n");
@@ -1680,7 +1752,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		}
 	}
 
-	if (!(*pdaccess & FILE_MAXIMAL_ACCESS_LE)) {
+	if (!maximal) {
 		switch (ace->type) {
 		case ACCESS_ALLOWED_ACE_TYPE:
 			access_bits = le32_to_cpu(ace->access_req);

