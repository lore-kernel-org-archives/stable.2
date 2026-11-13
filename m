Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600142;
	b=dAx4H6OxMStBc2dNepjD+qs5xLulc2WDsvRToiURg8DFQMl2YBZPIs4pRMKFns/nyO19
	 7btg+FeXeKWD20p+nGnvk+2btYswIbU1L3Vq7z/jk5pp+nyPxw/s6N0VpErOzMaNuItGC
	 H6hw8bThZsS7uUs845rV4hTqOY/ZM7dtxGnGHFmvlQi4JBLJBfKGLyM1ROd5gggSw27N6
	 ToqzK0ZCb0MP4OglssAJCT0WzkqsgUnKuQtjLoY5DyupfZUpbg8ftkcOuQnoE7nCwyz4e
	 PunFGxLvkyVzgGMn/hpWMIMfZLrCXJzKuqtqRkUsqkVQUHOL9piHBUVOIYUXL/Zq67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EfTMf5rCngV87O4gBtlbh3ZrxE+BKQpmcSO0vkCYsYo=;
	b=gBn19jD9qLiQqPvno+WlR+a8es02kIKdwROc+fAKMTz9Ppd/Y0fLXrQacU/VPBzK4Qme
	 yQ/P/ID5hlPTJrAW6SNTOJmRtSXi3CispFi4+js7Qie/E5CkdSpiSLbBpM9ReGr7ynNoF
	 iM/NSaCz+s60cWDz1jbd8z2kIFNk4T6s53J87P3N3ZdLAjZsfFiNKye6XASGHGZMh/rnd
	 KGn7HDquZ9nH7yYGI+0P7/VQQ46f0EbQ+RPEzIphtpI7nZ/MKcmvDgDqsL8ouOb3H67B6
	 nbc504aIu/1WW9YUILWy/QoyNT3hCmCP88LhLonnmgBdzXrdx1//zD6S7DhD8vAO6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVefDKLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B8606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVefDKLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA5B1F000C5;
	Fri, 13 Nov 2026 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600141;
	bh=EfTMf5rCngV87O4gBtlbh3ZrxE+BKQpmcSO0vkCYsYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVefDKLDfu4eZReMBmwdOv9vF90BnYsWc7xoe2u7vx0yiZPhM1zOtQaNYJhoX0xij
	 QT53275giIqPFkYu2T2VWuit/kuWHildgOCplLM1yvTtuBpt+nfZOYUf7kolPJtsgH
	 JFGl0rdOViuu3oLXmlgDVkQrRk2T0Guy7c6y8aEuYXNuFGBMTgCCOjrC1ne6eyS73R
	 uP59NddsTlfFR2v4i5yjJ13DpxPBQjARyekBWVz7hkQqqpluT8TjsITYx8lA9pUZmn
	 Tv1gTjva8QaGsevN+v3syTnbO1rN+3qbNtE2v4KDi738W1x5k3HVPwqzXCoR/TkxOv
	 JkR2rY4S1iuow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: let the owner read and change the DACL when no ACE names it
Date: Fri, 13 Nov 2026 15:02:19 -0500
Message-ID: <20261113200148.2481477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200250-failed-6.18-ffc855fe16af@kernel.org>
References: <20261109200250-failed-6.18-ffc855fe16af@kernel.org>
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
[ sashal: added the missing sid_owner_rights definition required by the upstream patch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 63f7bccb4d9af..3ae4f83202f4e 100644
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
@@ -1466,6 +1469,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	int i, found = 0;
 	unsigned int access_bits = 0, denied = 0;
 	struct smb_ace *others_ace = NULL;
+	bool or_ace = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
@@ -1498,6 +1502,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	is_owner = uid == from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
 
 	if (!pdacl->num_aces) {
+		unsigned int allowed = 0;
+
 		/*
 		 * An empty (present, zero-ACE) DACL grants no access to
 		 * anyone except the object owner's implicit READ_CONTROL
@@ -1506,9 +1512,14 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		 * not let trailing bytes after a zero-ACE DACL become an
 		 * implicit grant.
 		 */
-		if (!is_owner ||
-		    (*pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)))
+		if (is_owner)
+			allowed = READ_CONTROL | WRITE_DAC;
+		if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+			requested |= allowed;
+		if (!allowed || requested & ~allowed)
 			rc = -EACCES;
+		else
+			*pdaccess = cpu_to_le32(requested);
 		goto err_out;
 	}
 
@@ -1585,6 +1596,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
+		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
 		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
@@ -1629,8 +1643,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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

