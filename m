Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717961;
	b=BqRPj8GY6gOScEFGq7iX3M+gg1HpL834IgFq7FhYBufsbl8gnsnyXkAtvspukv3rD3UE
	 qQLDwoKbSHTKc4PjZdf/a3i1WZp+FY2hb4Jwmq7XJafUCWqGxbQ+gXqVwrHDvPsKFd843
	 p6S2Eytz0JaPKkXUTN3nlFOccD9Fby2URvuHcKfQTCoh10DfQvjnP/b3sCp431HG3wjJg
	 Yy55FJDUKKnB/W68Mo26OgkrsdSfNbHLSNNvOJ0c0ZHiR1hPLpaD8Yxl47IF2Tyji36Zp
	 RCGzu4ua+asfS/g1VatZGDULYNjA31oglbXQt78nNBd2//sN1f7L5WF2ef2FCWLfikw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+mZ5BtqFEoZPMrGul/KQuJ+OpsfTZszkwUwhMiZDbOY=;
	b=lJxDnIba1zlnMt1W+UVLi+qpErDWfgf0SqMapkADgFzMTkMIbOvI1trmXVoIts5bAxxa
	 zBVgL290dLykR/Nt/IbMqe0B+nSWB5jDVG4PG3xDEXmJhODRK3CWXTqLQBpT6apsRZ7aE
	 uXFUO1/7KjDbl3V4D1A6RgOso1BO9ADJ9Hi+5w2Rv0o354KnZZZ9wi8iwJ7rrGdX+qIZl
	 w8c0QOqcQJ7G8nI3KBvTfIhX93KuOrbFALpHizh/ulrTyvSGuakaCWTBxzeUXi+h+oDvI
	 6MnTkwHJPWeukBGKWgXkbswZdwu33GuLQH6SQ4MEykg3z/NUCRhqqtgHFZ+s1giiKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvqMaR0J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23550606BA15
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvqMaR0J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539791F000C1;
	Tue,  3 Nov 2026 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717960;
	bh=+mZ5BtqFEoZPMrGul/KQuJ+OpsfTZszkwUwhMiZDbOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvqMaR0J/w8ICfVUOqC4rNOi/OV4GJyYBW9AHOfD38uftkb/bKRlM6vC9TX1W9yke
	 WnfVFAjz4pz8cHBBBYE9mJhONezgW7hEZxkG+5ihNA9+IY7S9OX3nnQZLKSWt/s0Ij
	 L9O30qsB6N/6KYf8Lmc3GoMgP1qyTi1s6h6jKwagW7R8fVT8skPUbLC8a5r1OLTy1F
	 f1zhVKkOj/nbKyjgph4nr7kR7p8AQd/qMvEUjk1HLzEVlei8nM4Y33GeXO3vqkZ59c
	 UA72jhQno/ReWRZEHJi9HnqBu0ggUJ8klBJO+W/tkKDyM5vwF12mg3RmYUeO9HIOw3
	 Ao3PRzE5vozFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: deny access for an empty DACL instead of granting the request
Date: Tue,  3 Nov 2026 09:59:19 -0500
Message-ID: <20261103145822.4187214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110336-whole-agile-fb2c@gregkh>
References: <2026110336-whole-agile-fb2c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: added missing ownership declarations and initialization of is_owner using the mount’s ID mapping ]
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

