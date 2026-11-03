Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720056;
	b=Xcqoe5UZPsVqwNZCsUhgrJIswtrMOueZaM5VlOtw3AHZp6IjUg6/j9fzmppE03rnMed5
	 Vvqafg9QESEiVXiK1QJikodyPTJNis0uYUkaTNl7qLSVlGsar4Vxri6OcfG2l97GI4n4x
	 AGCYcAt4S2tAnwricQNSEeNUEvZ2Cnt1yF6sQSqQwLjSgliNCpoD9Sys/4CgM1/g9L6pa
	 eDZ2WA1KPtCFFNHZf38txEd2gLuO1ZgnbN9uYAGwMixZYWAOdhlZqIvaNwI3sh9HIzsxY
	 BHMt7eWeYgWzDOxjB8YPfBjeL7EXVqVcRKCsIhVTfdeUf5pStO1LIL8jWOKnQlXJyXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720056;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7cas561+VSJ9fHR+gCNDM4Q2PPKbIkxfUd4h6ZbzNXI=;
	b=BEH2U/4qFRCHzcc8nTXghFkTYk+EhyYHbrE59PQiRldjkHOUiMrYf88cSUP4+kd0sA+i
	 fYaxvqDW0Zwr9y5vAoO3RH1NhPOiHRbdww/XL7/kT11Yqdv4GtdRm3nn6J7TJq2yRexxM
	 H/AmaSYWQE6o3oQ9Dzx4MPpkvNLvtlXO4S60n16QAAjNbv/ur7JDcA7Yg7Lc/u3n5UjA4
	 W3XgT7Jxb7Fxaolt5qV1z8VHcYJCtvl76NjpHKvjHB0PN18a/nEoKPdZCqT8YbnvGQrkh
	 Xgrf9YX6YIXXCu7PoozPdqGar/dtuF+/XDeBIEistt/35Z46pozpnSv1GhwLsjhKk7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAMh8Pjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069E606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAMh8Pjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D61B1F000C1;
	Tue,  3 Nov 2026 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720056;
	bh=7cas561+VSJ9fHR+gCNDM4Q2PPKbIkxfUd4h6ZbzNXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAMh8PjwMpIeUVkyhACsO/9CtpAE5DUGFCmhs5V7d4pbhYzcEC+yGtuAFQBtxSf1V
	 nYO0d3T1v9PsWe43+gN5J8duIvxweTzHBRWZ9TvqX8P8JwrmACTQK8AneOV7eutUPX
	 wjiHClHFgZxS+cwGiMi1xGqInCCs1iyZMSoDItVJEqFjTZ+p9dY9p3KEj6zZ2CcS0X
	 EmwlLEyng5UhcsTp294N+QmoL8Bb6Ui9EGvxCmPwAnzI2EiLEfLIsSF51qCJuDsfMV
	 1UenF9bHfCjrIFvqHZb9bUp7bXoMWC0JbDp+FB/9T6ITdW66+YXFG1SdjK6l+UAQjr
	 lZg+JsbTYxjjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: deny access for an empty DACL instead of granting the request
Date: Tue,  3 Nov 2026 10:34:14 -0500
Message-ID: <20261103153341.254176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110337-headed-quirk-3494@gregkh>
References: <2026110337-headed-quirk-3494@gregkh>
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

From: Aamir Ahmed <elb12345@hotmail.co.uk>

[ Upstream commit de0cffef897c1c232ed973f89928cd6c93d0b1e3 ]

smb_check_perm_dacl() returns the access mask it computes to the SMB2
CREATE handler, which uses it as the granted access for the open. For a
security descriptor whose DACL is present but contains no ACEs, the
function is supposed to deny access: an empty (non-NULL) DACL grants no
access to anyone except the object owner's implicit READ_CONTROL and
WRITE_DAC (MS-DTYP 2.4.5).

The empty-DACL branch only denies when both

  - the DACL has no trailing bytes (pdacl_size == sizeof(struct smb_acl)),
    and
  - the request contains bits beyond READ_CONTROL / WRITE_DAC.

In every other case it takes the shared "goto err_out" with rc still 0,
which returns success without modifying *pdaccess, so the caller grants
the full requested access. Three problems follow:

  - The READ_CONTROL / WRITE_DAC carve-out models the owner's implicit
    rights, but the check runs before is_owner is computed, so those
    rights are handed to *every* caller, not just the owner. For
    READ_CONTROL the SMB2 CREATE path does not fall back to
    inode_permission(), so any user can read the security descriptor of
    an object whose empty DACL is meant to deny them.

  - A request of exactly READ_CONTROL and/or WRITE_DAC is granted to any
    caller. WRITE_DAC lets the handle rewrite the DACL.

  - A DACL that declares zero ACEs but carries trailing bytes
    (pdacl_size > sizeof(struct smb_acl)) skips the deny entirely and is
    granted whatever was requested.

On shares where the NT ACL is the authoritative access control -- e.g.
"force user" shares, where every client maps to one POSIX identity so
POSIX cannot distinguish users -- this is an access-control bypass.

Compute is_owner before the empty-DACL branch and deny access from an
empty DACL unless the caller is the owner requesting no more than
READ_CONTROL / WRITE_DAC.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: added the missing mount-mapped UID ownership calculation for is_owner ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 49a35974dd296..33a607e709f18 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1469,6 +1469,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
+	bool is_owner;
+	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
@@ -1489,19 +1491,27 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
 		goto err_out;
 
+	if (!uid)
+		sid_type = SIDUNIX_USER;
+	id_to_sid(uid, sid_type, &sid);
+	vfsuid = i_uid_into_vfsuid(idmap, d_inode(path->dentry));
+	is_owner = uid == from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
+
 	if (!pdacl->num_aces) {
-		if (!(pdacl_size - sizeof(struct smb_acl)) &&
-		    *pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)) {
+		/*
+		 * An empty (present, zero-ACE) DACL grants no access to
+		 * anyone except the object owner's implicit READ_CONTROL
+		 * and WRITE_DAC (MS-DTYP 2.4.5). Deny every other caller,
+		 * deny the owner any access beyond those two bits, and do
+		 * not let trailing bytes after a zero-ACE DACL become an
+		 * implicit grant.
+		 */
+		if (!is_owner ||
+		    (*pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)))
 			rc = -EACCES;
-			goto err_out;
-		}
 		goto err_out;
 	}
 
-	if (!uid)
-		sid_type = SIDUNIX_USER;
-	id_to_sid(uid, sid_type, &sid);
-
 	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
 		access_bits = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
 			DELETE;
-- 
2.53.0

