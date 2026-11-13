Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601865;
	b=NF0LPw+q+2fpuWaxLmihnlwAobzOTH4pm91SgiS2PPxkP2YJv7oB0k+KpZMYQEpx47l4
	 CGeU29FdSE6v/vEP54+dfcEDQhIJ/cwh3JjWVQL/UgfFjH6KKxwjOmkIe/f85tyTh03wt
	 8hAfswTIVAZasBHCgn1nGA0/NTK5mq8ll+kZx7JjGqlJYq9aTcqI99hVsIPq00qTxtT7N
	 JF/nYsX7URdOMNjAMGfcwFbHJFszLT6KDAHIXp7WrLseq5/sJAF3qZfZRiiutYOWWMSFb
	 qqDAZyohIRstg9vNyAa4NmrWBFuzhxCBGWXM+EoXTCH2AC/7/hqr8xvOLSnc0U3GWRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v63bf9buaEPBLt3037MuGXX04iZnN54rFSt2d+bEdBo=;
	b=QhztYfj9+8SbimVqNOXQDBG63U29vaNr8we1xlJ1YNmLkBaHD75oNnwJu1urayPsvl0B
	 nzT3KKu9LpKvk3kRbQRboG4PIzoHob5aqGYlomXvz8wXLLDF0RecLElLZp6UioYncF+YW
	 Rg1Ykxz4cac7r9ISCElvyUlXFB7vTJx04vMioBLvS/mJdK5OS/SxUUMt2bfq/n6yEZGu+
	 BwzznOYhQNw1lK/GznKX1rkq7QSm9y23tnTETBw1RFN98QyGVg93HvDrZCjRakJmwxmra
	 0evEllGuOpUE9L9ZXreMR+Ig46Y7LxkD7GhsNCzOTFQjcegehBSlmvHMWYsTlrn0SqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAyQBMD6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33578606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAyQBMD6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E61F000C4;
	Fri, 13 Nov 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601864;
	bh=v63bf9buaEPBLt3037MuGXX04iZnN54rFSt2d+bEdBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAyQBMD6ER5ZcK9bBuPRBmOSx2FqKxsZNiB+NpFkTk0E04G4hfaedDvtAUB6ruz3T
	 mzlmz+yei71KgcdSMAoG+vqlncLiNktcznbRFzCSXrKXhArnSQaYuHRKZvojGsyVzi
	 Bfzh/RE/DNFC8sTBnjfBv8mVm91yNyY7+FKYBJ5v8AuV0Z4sPYT/AXF9+4TJxQV8xp
	 6BX4Y6J6KrlN27j3KcHaOtCmhiptKeMbgs46lzM+sXhYNWGROBWNEeTdtz46vx0Oqm
	 U1+CV4aCfy90h0L1/Etiy5pcQ9MaRBNPfC/WywBblXQQ+KPIjBFDJMdgCKaGiw3AF5
	 TC/Y/LoqKqIFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: let the owner read and change the DACL when no ACE names it
Date: Fri, 13 Nov 2026 15:31:03 -0500
Message-ID: <20261113203037.2598057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200653-failed-6.12-ffc855fe16af@kernel.org>
References: <20261109200653-failed-6.12-ffc855fe16af@kernel.org>
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
[ sashal: added the missing sid_owner_rights constant definition for OWNER_RIGHTS SID S-1-3-4 ]
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

