Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603046;
	b=ws4XGS/qJjTEs+J48ZgrZN1GrEcGMBdh7G1e8ZVZsUPc/e9ZYQrQNp7xEvn/ADo/NDuJ
	 uBzGnRwhHx72qsnS17Jved4b5TAKaRoEaRABTs1zAFBOdnwQIygQs/nB47GU4R2BBDj4M
	 bIxB6XiqGDOHAm9vTotuwUjP59mPR+AEh5nBaSZk/dCRo3Vy+pK7yYJqRHqyMgTpGYdI7
	 UkBiIp7Re3SEONuyAiowl6t0NgmXMcJZRIc3kpdJe7DBIQCkxXerT5yDMlM3kpgG6EHjZ
	 OzfBEA7W2oNegegrS3GIkmk86OcRmfWuUvp/cy12UuNsRreke4pu0N8QhZjAE4K8+XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603046;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tmfT1cqJlZwl8GjDW3nsIXtgHlCVo3e3oInalR6wiXE=;
	b=KNm9YHkOgeaqTyg0StKWnRp178Vmv0f41s1m57Y2cy7u3ZMBxNY2m1Tm7of5DEzR2pHM
	 BUyTsFjETRKRRk1v7MAt3DDcPEaGsB114Wb4wtqIGvdGi2/xHim80vO7wWpoKuDa6L6Ep
	 nJoCvOBWunW4k49CVq5gk/2BW33p749hBWXXqo/zNRBEjrAUaoDtc5kAXpEXi8gRgcmCb
	 ErbZxS/JHdCOBA/umt777nTz+tjDkeGDrcqJgE4NWJEmdVIoPtdBMPvX0QCEvwo3X6AhC
	 Fcg8Xcdum7+NXNTe48jWKZoQLm0unW8+pZJramXj3fZRDb+eaZeOVddupNXwHmGT+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DvJZptBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC5606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DvJZptBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310441F000D1;
	Wed, 25 Nov 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603045;
	bh=tmfT1cqJlZwl8GjDW3nsIXtgHlCVo3e3oInalR6wiXE=;
	h=Subject:To:Cc:From:Date;
	b=DvJZptBHH6MVzjcE1uFoxYVF9HrZWww3YY8vC0kIbUaP5ih41/PeNn5S4mdfhEyU3
	 GQRkBq/WDsMkTXAY+YOtjFoiMetjfh2tYIC9f6l9y4TwauT1vSV0tqjcEnF31smomW
	 qR9uHQqsrVOJ9gq7AwpoFEGgUt7wYtwtmDuJz5CA=
Subject: FAILED: patch "[PATCH] ksmbd: grant a caller what its groups and OWNER RIGHTS ACEs" failed to apply to 6.6-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:24:15 +0100
Message-ID: <2026112515-dock-lapel-1710@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 42ac1f1917ae678ee2c47f415ab844af03bbd46b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112515-dock-lapel-1710@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

