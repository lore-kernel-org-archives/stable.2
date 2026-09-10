Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D038DC6A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054078; cv=none; b=LERUC1u7HXQ1dJgQDQ2EdLtEsGG8BZu5FNf62oKBwP2X1Mg6z80ggN6ZiSQzrK1jvW28OSDBpizK22oHaF8nCBSG1QBOkXxrrls+sBwIpCMjIl1uUsn6BQZ6QNI1dVYHkcU9JW7S9ThUxymQc4RCYbI7ouXFgBtCCUQoPMY7Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054078; c=relaxed/simple;
	bh=6y/rOjw1gHUzrBFOqpU9h2mi+k1NFhcMDPs1TMzAPk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocjBTS0MBrvcBPEkK4yx8TbDuE3LJHxYdnLm5j4dL9byXNSrk02JeDmmcr0Ob945l7dj1TpaphA1FYvjN+Bp4sqLtt6K+k8qtx5wct/pxD3nT2Xjpt3E/8hUoUhWGdOxmwsnZ/uKIb1PhU3/cupFVSYNHzC/mRg3/JfWI28VgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQUwvdwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQUwvdwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D31F000FF;
	Thu, 10 Sep 2026 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054076;
	bh=Uq+rBNy8gTjXdUL+qwlFT/g0xoUdHkGsidLsPNAP1Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQUwvdwF6KBnld7mxSfsnvUStlYRDW7b5uL90jEB7BCwxuIm/uzu4+qr4sC34AH70
	 cgX92IDa0/odEQwtXytw60FsTr68MNCS08+/eF1+Rf/Nwz4k6fe2DwYw+6Fgt08zfu
	 OSIY86k0s1YAcAIVB2ugBCgSiejzUvVk1OQjmepAl5i43ICiWX4Bvx5L/A4hurVptL
	 dykNPIVzpoxwAxG/LQwvpPQS2HTu3ekajSRsVzngaqwMhTA0rJXisUUW0H+g7tIzbe
	 ESJBBKcxeOgjukmdjWCrBQz/2MMv9XwpkLKnLOS2KEr566G3U3ErbRCqLV0l1deKkM
	 oilyLo/Tk+BpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] ksmbd: fix maximum allowed access checks
Date: Thu, 10 Sep 2026 11:27:52 -0400
Message-ID: <20260910152754.950820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090802-tactical-overplay-91bf@gregkh>
References: <2026090802-tactical-overplay-91bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit cc2f133e80eb2c4a04bfa77a2f207749fe2f516a ]

The DACL permission check looks for an ACE matching the current user and
falls back to the Everyone ACE. It does not consider an Authenticated
Users ACE, even though an authenticated session is a member of that
well-known group.

As a result, opening a file whose access is granted through S-1-5-11 can
incorrectly fail with STATUS_ACCESS_DENIED. Treat an Authenticated Users
ACE as a fallback entry alongside Everyone.

The maximal access calculation also combines access masks from every ACE,
regardless of whether its SID applies to the current user. This can grant
rights belonging to an unrelated principal. Process only ACEs applying to
the user, Everyone, or Authenticated Users, and accumulate allowed and
denied masks in ACL order. Preserve explicitly requested access bits so
they are validated against the resulting maximal mask.

When ACCESS_SYSTEM_SECURITY is denied, report STATUS_PRIVILEGE_NOT_HELD
instead of the generic STATUS_ACCESS_DENIED. Access to the system ACL
requires a security privilege that ksmbd does not grant.

For regular files, include FILE_EXECUTE in maximal access when the client
requested GENERIC_EXECUTE and the DACL grants the complete file-read set.
Keep a direct FILE_EXECUTE request subject to the explicit DACL bit. This
matches the POSIX file ACL mapping without broadening specific execute
requests.

Do not replace rights from an applicable NT ACE with a POSIX ACL entry.
The POSIX ACL is only a fallback when no user, Everyone, or Authenticated
Users ACE applies; otherwise it can incorrectly broaden the stored DACL.

This fixes smb2.maximum_allowed.maximum_allowed.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: b5ec6c462aab ("ksmbd: fix tree connection use-after-free in smb2_tree_connect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c |  9 ++++-
 fs/smb/server/smbacl.c  | 83 ++++++++++++++++++++++++++---------------
 fs/smb/server/smbacl.h  |  2 +-
 3 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 76f63f9adc725..9b3ffa0929805 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3601,6 +3601,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (file_present && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
 		rc = smb_check_perm_dacl(conn, &path, &daccess,
+					 req->DesiredAccess,
 					 sess->user->uid);
 		if (rc)
 			goto err_out;
@@ -4173,8 +4174,12 @@ int smb2_open(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		else if (rc == -EOPNOTSUPP)
 			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
-		else if (rc == -EACCES || rc == -ESTALE || rc == -EXDEV)
-			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (rc == -EACCES || rc == -ESTALE || rc == -EXDEV) {
+			if (req->DesiredAccess & FILE_ACCESS_SYSTEM_SECURITY_LE)
+				rsp->hdr.Status = STATUS_PRIVILEGE_NOT_HELD;
+			else
+				rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		}
 		else if (rc == -ENOENT)
 			rsp->hdr.Status = STATUS_OBJECT_NAME_INVALID;
 		else if (rc == -EPERM)
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c13f07a09ab8b..0537638153325 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1432,7 +1432,7 @@ bool smb_inherit_flags(int flags, bool is_dir)
 }
 
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
-			__le32 *pdaccess, int uid)
+			__le32 *pdaccess, __le32 raw_daccess, int uid)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	struct smb_ntsd *pntsd = NULL;
@@ -1442,10 +1442,11 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	unsigned int dacl_offset;
 	size_t dacl_struct_end;
 	struct smb_sid sid;
-	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
+	int requested = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
+	int granted = requested;
 	struct smb_ace *ace;
 	int i, found = 0;
-	unsigned int access_bits = 0;
+	unsigned int access_bits = 0, denied = 0;
 	struct smb_ace *others_ace = NULL;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
@@ -1479,10 +1480,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		goto err_out;
 	}
 
+	if (!uid)
+		sid_type = SIDUNIX_USER;
+	id_to_sid(uid, sid_type, &sid);
+
 	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
-		granted = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
+		access_bits = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
 			DELETE;
-
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
@@ -1495,15 +1499,41 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 				       CIFS_SID_BASE_SIZE)
 				break;
 			aces_size -= ace_size;
-			granted |= le32_to_cpu(ace->access_req);
+
+			if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+			    ace_size < offsetof(struct smb_ace, sid) +
+				      CIFS_SID_BASE_SIZE +
+				      sizeof(__le32) * ace->sid.num_subauth)
+				break;
+
+			if (ace->flags & INHERIT_ONLY_ACE ||
+			    (compare_sids(&sid, &ace->sid) &&
+			     compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
+			     compare_sids(&sid_everyone, &ace->sid) &&
+			     compare_sids(&sid_authusers, &ace->sid)))
+				goto next_ace;
+
+			switch (ace->type) {
+			case ACCESS_ALLOWED_ACE_TYPE:
+				access_bits |= le32_to_cpu(ace->access_req);
+				break;
+			case ACCESS_DENIED_ACE_TYPE:
+			case ACCESS_DENIED_CALLBACK_ACE_TYPE:
+				denied |= ~access_bits &
+					le32_to_cpu(ace->access_req);
+				break;
+			}
+next_ace:
 			ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
 		}
+		access_bits &= ~denied;
+		if ((raw_daccess & FILE_GENERIC_EXECUTE_LE) &&
+		    S_ISREG(d_inode(path->dentry)->i_mode) &&
+		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
+			access_bits |= FILE_EXECUTE;
+		granted = requested | access_bits;
 	}
 
-	if (!uid)
-		sid_type = SIDUNIX_USER;
-	id_to_sid(uid, sid_type, &sid);
-
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
@@ -1527,25 +1557,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
-		if (!compare_sids(&sid_everyone, &ace->sid))
+		if (!compare_sids(&sid_everyone, &ace->sid) ||
+		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
 
 		ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
 	}
 
-	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE && found) {
-		granted = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
-			DELETE;
-
-		granted |= le32_to_cpu(ace->access_req);
-
-		if (!pdacl->num_aces)
-			granted = GENERIC_ALL_FLAGS;
-	}
-
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_inode_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found && !others_ace) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1583,14 +1604,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		}
 	}
 
-	switch (ace->type) {
-	case ACCESS_ALLOWED_ACE_TYPE:
-		access_bits = le32_to_cpu(ace->access_req);
-		break;
-	case ACCESS_DENIED_ACE_TYPE:
-	case ACCESS_DENIED_CALLBACK_ACE_TYPE:
-		access_bits = le32_to_cpu(~ace->access_req);
-		break;
+	if (!(*pdaccess & FILE_MAXIMAL_ACCESS_LE)) {
+		switch (ace->type) {
+		case ACCESS_ALLOWED_ACE_TYPE:
+			access_bits = le32_to_cpu(ace->access_req);
+			break;
+		case ACCESS_DENIED_ACE_TYPE:
+		case ACCESS_DENIED_CALLBACK_ACE_TYPE:
+			access_bits = le32_to_cpu(~ace->access_req);
+			break;
+		}
 	}
 
 check_access_bits:
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index ab21ba2cd4df3..bf0312bfa0405 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -95,7 +95,7 @@ bool smb_inherit_flags(int flags, bool is_dir);
 int smb_inherit_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     unsigned int uid, unsigned int gid);
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
-			__le32 *pdaccess, int uid);
+			__le32 *pdaccess, __le32 raw_daccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check, bool get_write);
-- 
2.53.0

