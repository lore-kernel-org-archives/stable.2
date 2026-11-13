Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609537;
	b=kfMkXS8ia5UsglFxsWyG0xoVDezSb/p4Sc5i8pW7oUcvY6fRivaZ4XTvYVO4MTMUcE7R
	 60lq5f+suYfiXbhx3Zhg9n/uUFK8lhe90o8BlGAX4Zu7IKiyzKBD0BrCt/wBFUand/75q
	 puId9bs7UacoeQh+UrSETifnOvn3HKU/xrHps4c2Gw5vE3B1HxDB1bmtH6ooK3MTUpjJ9
	 7Gw242MgxN5hlSgJIxPpFakMu96ddsAVnMPmrqvPejSAaR++YlP1PrnOssHTPVB8hu+gO
	 ZSv/ONdFJtzMFRi+eOpkEDeZDHjYgnofKn2Klg5OAsQjEmx003tbHuV4/UsUWLONI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vEDSwN0wDdfxGXMIrbS6+OaRU5ifics9Z0yCjeme3tM=;
	b=eaQHTyO0HoAO1Lg/L6lc4RL+ZnyiCQeY5pYyOFuaktAeIu/pLlD191ktHoAbOxhKnWHu
	 qJKTYan3J36TbKXoy0oh9bxXgwFZXSCA9h16iYu8qu40NWabEslkU4H5VGz5j+dHOtHzB
	 yioUlGQRJQp/Q8T/J5Ep53GixwbU49LhOxUCPx6jgB6AxFphP7xaeA3yGx1MuR6BUN6cb
	 01RcxVoBPSrw3/XwLVMI8z0he1sWoF2/gqz+kXu7UdSKU+5jf5YxTPKIb2efsvZgyqHQS
	 8NzdxobfOXS+eeLhHGi9u6yVoUZPZIcVXqdCrysxaad4yH5/9lpIqHn4ICGxairCIQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFotH2i5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C099606A548
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFotH2i5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92C1F000C4;
	Fri, 13 Nov 2026 22:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609537;
	bh=vEDSwN0wDdfxGXMIrbS6+OaRU5ifics9Z0yCjeme3tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFotH2i5S8WYFctcRcu5rFq8SGBWlMqtxcBs/pWjR9kiBYqU22kOc/R4INBZAyiPr
	 c4axnaJIvK1bSrLerRhlhP2suQskrPUfPuS0PiSaANXbLcStmlBLNe9Y3lcDJ7gc+A
	 vQlD2PBoOqYazWjUllLN/jg/tuGXwlD5apDVWDjbE/0TLTD0B+7zqF0UH82j6Omc5Z
	 tDJ0K7B4vWPMk0n0+QP06OMIPUO4fdcZCKeYz44xywVxysKx6yS8VQVmS+cT+4rA6p
	 qvlcaVRJTNsrZPR94pd9JrPmEY4GmLKgH+JsqqQ7T3w6UefZRm5QqXg6gLb0ELt2ab
	 AaO3Q3a8XlEJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: let the owner read and change the DACL when no ACE names it
Date: Fri, 13 Nov 2026 17:38:55 -0500
Message-ID: <20261113223828.2723949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202057-failed-5.15-ffc855fe16af@kernel.org>
References: <20261109202057-failed-5.15-ffc855fe16af@kernel.org>
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
[ sashal: Adapted the owner check to use the existing mount-aware i_uid_into_mnt() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smbacl.c | 54 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ed690767837fd..7c8a1c0506752 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -28,6 +28,9 @@ static const struct smb_sid creator_owner = {
 /* security id for everyone/world system group */
 static const struct smb_sid creator_group = {
 	1, 1, {0, 0, 0, 0, 0, 3}, {cpu_to_le32(1)} };
+/* security id for owner rights */
+static const struct smb_sid sid_owner_rights = {
+	1, 1, {0, 0, 0, 0, 0, 3}, {cpu_to_le32(4)} };
 
 /* security id for everyone/world system group */
 static const struct smb_sid sid_everyone = {
@@ -1257,14 +1260,17 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	unsigned int dacl_offset;
 	size_t dacl_struct_end;
 	struct smb_sid sid;
-	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
+	int requested = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
+	int granted = requested;
 	struct smb_ace *ace;
 	int i, found = 0;
 	unsigned int access_bits = 0;
 	struct smb_ace *others_ace = NULL;
+	bool or_ace = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
+	bool is_owner;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
@@ -1285,12 +1291,28 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
 		goto err_out;
 
+	is_owner = uid == from_kuid(&init_user_ns,
+				   i_uid_into_mnt(user_ns, d_inode(path->dentry)));
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
 
@@ -1345,6 +1367,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
+		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid))
 			others_ace = ace;
 
@@ -1398,8 +1423,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
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

