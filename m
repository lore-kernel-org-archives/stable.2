Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603409;
	b=03FLFMeAAewtT3hP0fsQhiW9OJJCUBx/9UAHaU6yNwwHufYedhhvrYRE/+giaCj1ulun
	 VXpqlfBTyJVR/ZuX3JzccX5RnoZO9e18HCAFuAeUnAnD+c2D3XItf+0hj3btd1skgNDHC
	 IaCtrVTZ8OTamQXCST1GG0mWHm0ABkEU9iZ4Om5PYWW91SN0tcnzOGoZ6xUKrpmYAK7gw
	 r3KJ1avrEl1xlmJP2n+jx40x3VY91z1v5jZbWsf9AucpsfmhvRNDw1muze38dxeiCEKZV
	 mlpenecyydQaKAQNCUBpGjotV9QFGgvpfRd1Umj8i3i+orLMLWkK7RT3k++Gc6BADbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ePE3yvePlxHav1TsPKz/9gOmDCm84hdxRakGfr0yZhs=;
	b=eZJyt01XfWY6Th7s9GqQRQR8ki/DwExss4lH9Rye4OEnEitmmfJ5nlIYCWtHM45+krnw
	 XZ5LHbaChHzN3UEM9fvflQlFZisFzdN/QP7M1GKTfLuOjPpkiM5EqPOpJ4XRqY7xpCJwB
	 kqG9c0lEJ+KTE42VYX/UvZg+KQgp8bUthfwj3ImHAxwgt0qHQEL5SLqWaIMcCYNcTPE9E
	 teKznp1wnYueFlhDXm1dGO69duf20aDC9faabQbwqfZ71dES7TAYTDoesgj8L2GaZcSs0
	 +4SGQwNc1bwrMX3IC683LI0wt1jgGy3+iIwIjCINhl8uqaiZqqgGFgCkUVc3MjN5s0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euuwYSzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1B606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euuwYSzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784041F000C4;
	Fri, 13 Nov 2026 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603409;
	bh=ePE3yvePlxHav1TsPKz/9gOmDCm84hdxRakGfr0yZhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euuwYSzphHqjTXzj4MWfL8zjUbdHHOldnAcUEp5NqTmvr1PgGQrqlv3DyAn0m7Qvp
	 TqEiHyt3HiO2ThUAN9tSdRYlDimqey+DzMmSWStaiZuk5PbMmw86TC+0UErc0j4qjv
	 xMIe5szWoa6e9n1KmXMAl9DbQlgen1dYX8y9XwLiwchh97KJqmDrQMLIFsLLJE9Lde
	 FhK/2R4lv75l7PcUzmrbj2AFjunnhZRCo0BrUR4ml99qltvteWW8HlYaiqSoFUZGR+
	 Sb3GVWuooF3RMAR8S+vuQzmZnWQmW8CA5fCcFMWbV3ejfI23GhsG1eDYG3OYT5JuXw
	 I7PIbJoDssD1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: let the owner read and change the DACL when no ACE names it
Date: Fri, 13 Nov 2026 15:56:47 -0500
Message-ID: <20261113205617.2612345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201107-failed-6.6-ffc855fe16af@kernel.org>
References: <20261109201107-failed-6.6-ffc855fe16af@kernel.org>
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

[ Upstream commit ffc855fe16afe02b22305111aa68cd8d07360941 ]

smb_check_perm_dacl() refuses the owner when neither its DACL lookup nor
the POSIX ACL fallback matches. The owner then cannot read or replace
the DACL over SMB. MS-DTYP 2.5.3.2 grants the owner READ_CONTROL and
WRITE_DAC unless an OWNER RIGHTS ACE applies.

An empty DACL allows the owner's explicit requests for these rights but
refuses MAXIMUM_ALLOWED. smb2_open() uses that check for the maximal
access reply (MS-SMB2 3.3.5.9.5), so even a READ_CONTROL open fails when
it asks for that reply.

Grant the owner's implicit rights on both paths, for explicit requests
and MAXIMUM_ALLOWED, unless an OWNER RIGHTS ACE applies.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: added missing sid_owner_rights definition and is_owner setup required by the upstream patch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 52 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 40b2e6b499457..058367e33f044 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -27,6 +27,9 @@ static const struct smb_sid creator_owner = {
 /* security id for everyone/world system group */
 static const struct smb_sid creator_group = {
 	1, 1, {0, 0, 0, 0, 0, 3}, {cpu_to_le32(1)} };
+/* security id for owner rights */
+static const struct smb_sid sid_owner_rights = {
+	1, 1, {0, 0, 0, 0, 0, 3}, {cpu_to_le32(4)} };
 
 /* security id for everyone/world system group */
 static const struct smb_sid sid_everyone = {
@@ -1466,9 +1469,12 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	int i, found = 0;
 	unsigned int access_bits = 0, denied = 0;
 	struct smb_ace *others_ace = NULL;
+	bool or_ace = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
+	bool is_owner;
+	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
@@ -1489,12 +1495,28 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
 		goto err_out;
 
+	vfsuid = i_uid_into_vfsuid(idmap, d_inode(path->dentry));
+	is_owner = uid == from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
+
 	if (!pdacl->num_aces) {
-		if (!(pdacl_size - sizeof(struct smb_acl)) &&
-		    *pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)) {
+		unsigned int allowed = 0;
+
+		/*
+		 * An empty (present, zero-ACE) DACL grants no access to
+		 * anyone except the object owner's implicit READ_CONTROL
+		 * and WRITE_DAC (MS-DTYP 2.4.5). Deny every other caller,
+		 * deny the owner any access beyond those two bits, and do
+		 * not let trailing bytes after a zero-ACE DACL become an
+		 * implicit grant.
+		 */
+		if (is_owner)
+			allowed = READ_CONTROL | WRITE_DAC;
+		if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+			requested |= allowed;
+		if (!allowed || requested & ~allowed)
 			rc = -EACCES;
-			goto err_out;
-		}
+		else
+			*pdaccess = cpu_to_le32(requested);
 		goto err_out;
 	}
 
@@ -1575,6 +1597,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
+		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
 		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
@@ -1619,8 +1644,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		if (others_ace) {
 			ace = others_ace;
 		} else {
-			ksmbd_debug(SMB, "Can't find corresponding sid\n");
-			rc = -EACCES;
+			unsigned int allowed = 0;
+
+			/*
+			 * No ACE names the owner, who may still read and
+			 * change the DACL unless OWNER RIGHTS applies
+			 * (MS-DTYP 2.5.3.2).
+			 */
+			if (is_owner && !or_ace)
+				allowed = READ_CONTROL | WRITE_DAC;
+			if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+				requested |= allowed;
+			if (!allowed || requested & ~allowed) {
+				ksmbd_debug(SMB, "Can't find corresponding sid\n");
+				rc = -EACCES;
+				goto err_out;
+			}
+			*pdaccess = cpu_to_le32(requested);
 			goto err_out;
 		}
 	}
-- 
2.53.0

