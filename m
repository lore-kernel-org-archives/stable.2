Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700939;
	b=gea/f1WNGXUAuCof1QTr7Gt2G6IJI2C+5f8VohD7+1eHqoIDJV7U2L7EfZ4Omq6IiNS6
	 Y9q4XRheELirBNjBQ2osgetXG+bW5RTldPN+SuozmdusuICoOiE/lSzDw3mrRYWxzHvi9
	 mOKEYcxQtQdkevqD82qCQ80xA8TUzg7Lql7SHVRut8c14bNBoT3ZeKPDNfEu9EGUXlgFR
	 2jePdJJcLWjxb0TpG4evjsAfbHTOxn3wo9zpMJQ0KmVG+bYPN3dLoJXsNe9e6t53ajRKm
	 DEp1gkQgykpClljy+9Dci3HlhftB+iPFSdoMzPWlfd+iMczZvFHt+r6490lWPuTnWhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700939;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QehXtfYYpPjcWl8YK10telu/czKZvptu0ZQGZAqSA6E=;
	b=q6T1+PqFGjTzi8R5TBOslus5p7W6RaxUBeKgB/IPfZ2J+XHOyINrh2iJxsYWfNHoQlHO
	 5nGAqi+dkKrXUGEcprIPG7IoDjJ4V43YBZjYSUGa/p/a9NeIUHQDRIdPl4xd0awN+B5eQ
	 KrfeHTfl2WN3bmgKSvfRZXUHNMCqM7zagdr7dXClphLh2be8MlpuBwhP4iIieXCPqqZoB
	 JxecI7tAxX1tP273hy05M3+mF6hQMpAnLlAvxZSu6SZMGDw9Kmmbs77gitrZjfaIXHrA6
	 7KIDDUTCPqB4faGbS9F4gPcEy69XtcMSsakVGLFtjRCzs3pGF201ahhvSflkapY/i7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XT0uodhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6241606D80C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XT0uodhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0496D1F000C1;
	Tue,  3 Nov 2026 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700938;
	bh=QehXtfYYpPjcWl8YK10telu/czKZvptu0ZQGZAqSA6E=;
	h=Subject:To:Cc:From:Date;
	b=XT0uodhNtFpbamjnbgpwHNjRQAyAaLG9/WbMBEBDBtXB77V0CanTSiDJoUF+p28MZ
	 M0M8zpETQrB/3H/NYwdTjzd0EFE2okYyzwp+8jLNrYTtDu4OyJohOtwDd1eAGbeT5y
	 kM7FwVkvAJac0vlnwMt8e81mz6jDy4fU3aLjMeIE=
Subject: FAILED: patch "[PATCH] ksmbd: deny access for an empty DACL instead of granting the" failed to apply to 6.18-stable tree
To: elb12345@hotmail.co.uk,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:15:36 +0100
Message-ID: <2026110336-whole-agile-fb2c@gregkh>
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
git cherry-pick -x de0cffef897c1c232ed973f89928cd6c93d0b1e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110336-whole-agile-fb2c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de0cffef897c1c232ed973f89928cd6c93d0b1e3 Mon Sep 17 00:00:00 2001
From: Aamir Ahmed <elb12345@hotmail.co.uk>
Date: Wed, 16 Sep 2026 11:49:27 +0100
Subject: [PATCH] ksmbd: deny access for an empty DACL instead of granting the
 request

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

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c959699ace56..664f01263611 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1502,21 +1502,27 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
 		goto err_out;
 
-	if (!pdacl->num_aces) {
-		if (!(pdacl_size - sizeof(struct smb_acl)) &&
-		    *pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)) {
-			rc = -EACCES;
-			goto err_out;
-		}
-		goto err_out;
-	}
-
 	if (!uid)
 		sid_type = SIDUNIX_USER;
 	id_to_sid(uid, sid_type, &sid);
 	vfsuid = i_uid_into_vfsuid(idmap, d_inode(path->dentry));
 	is_owner = uid == from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
 
+	if (!pdacl->num_aces) {
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
+			rc = -EACCES;
+		goto err_out;
+	}
+
 	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = pdacl_size - sizeof(struct smb_acl);

