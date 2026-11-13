Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606153;
	b=umEKn5X+dXnXbItDGiX/lqvqDKowEguiz+0akk3gyIlC6UyirGS0lb1yRMn5TwJKCz59
	 V6fySplqGVeZxU45cU+TaOX1Y9o9F+u4NC05wThcvkj2Lk09ftg2FJvZxSY/qfbyh4AEI
	 yO0yOPgafp6RQZtI1ZrKeU+FFy0cajJR2N1L48Ky9PDdAqRpoO2lasg5VBZ7fGf4OYsgG
	 PZZFS3vrdaPHZThw+jsXcN1sdEQXaPA7jl4ws2B2PwubHQKC87AfWCPEAnRe6hchYtyc1
	 Yr/BoqWyiZYDMAQNRycPADXrwiuujvGJhx3F35ZI9b4+mFc+LKiM9oxWKRSa2k+HG/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gner5bYpYIFeR0zyHnHICqOBijztzQG+icYK31fBVS4=;
	b=dD3iBgEKc6tnIU27zycP8K8r748+oAx8CsVrCOGtZG6Adx+tSI2ub+FfYixoBTpwNdSx
	 Uxw/iOxBgmm722mSR95OSV8OseWwa7ByHdgVSqkLNymQ5bsjtQdmLpFPHcUTGaD2b3+7L
	 8SqHoMqB1yyjtMU0Vs6z9VKA2Ujb4gqJJHCA3u9mQ9i/4uH21hETYIPHiiHK1dMOYcYV6
	 t5JNnjXb5mCAMqHXOtzg0rjlMYt56Gtgn3L9qUko+Fhvr5vr8aulofzxcMY1Waoiucqoq
	 ypUWiqABDJj7s31xNIOKeGDK2xeDGfqsc8WOMz1FIOMwugQ/HxF49aa9s3XkSeVhV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEsLHYT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800A606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEsLHYT8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488B21F000C4;
	Fri, 13 Nov 2026 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606152;
	bh=Gner5bYpYIFeR0zyHnHICqOBijztzQG+icYK31fBVS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEsLHYT8GVPqw8KoR5s47Qhp+YqR1sW+EmSZnmLYjaMIrqdaXSI3OsLbER8CyeY9S
	 xjQCw/yah932PTEcSclljdXrfxjFf1ulIcBC7ioYCZMgAuwLyzP7horojuN6lyF7jy
	 l/Wk46Luy6sKFdZJ0Ngp9FUKXF1i2nSoALIMm1RbTsZyVq9p8NvZ0TkMehHM5gYxAw
	 ytncqA+lVCyX2lXgCljXemupmct+JFRyHocVwqhpzSRQf3CCpihybf9xw7e4g133Aq
	 bAUZPL1UdkKfjng51kCRLTnd9iJlsHtFbB9EJY65MzyNmwtC5BBaD2k51B7irfoEEz
	 mWkZZqZ1uzQ/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: let the owner read and change the DACL when no ACE names it
Date: Fri, 13 Nov 2026 16:42:30 -0500
Message-ID: <20261113214202.2623495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201545-failed-6.1-ffc855fe16af@kernel.org>
References: <20261109201545-failed-6.1-ffc855fe16af@kernel.org>
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
[ sashal: added missing owner-check prerequisites using the existing i_uid_into_vfsuid(user_ns, inode) API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 52 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index f0ec137e4efce..74aaaa1aa8f4d 100644
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
@@ -1452,9 +1455,12 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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
 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
@@ -1475,12 +1481,28 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
 		goto err_out;
 
+	vfsuid = i_uid_into_vfsuid(user_ns, d_inode(path->dentry));
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
 
@@ -1561,6 +1583,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
+		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
 		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
@@ -1605,8 +1630,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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

