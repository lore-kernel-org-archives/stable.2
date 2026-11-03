Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700941;
	b=5WtFcjt6PHwsym7xmMT8+bDTAcfuyGRw2kF5xttq4fNH0R05GSRO3A8iLWQe+4MWmiz1
	 Nwp2T+epLhlddfNivTJacT+SfKX8A7964zAvDZm/BtHt3c30HrbjtukAyfavXhytBGI8h
	 nzCppObomB/nobFX6YrCyW/FihNRTLxrgdDhzhPkLkpcocu8kfeGa85DsV9vfRrhz+MAY
	 bEsdX2lD3ZfREjigI3U3rZ5PKMs31SIx7K4Y+7qjJV2BDUu05Y5SAGoo2Rtej2iacVM+s
	 wDC4mlCH0HatoijKfG/c6A+LL4xxeKGBIN/XUsjTjmJwfO9U2+x5vsd80/VcCJJaWDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700941;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mwaffUvIfqrOd70Ufwy0BF9RX2dVZScAAYb+4J7fNyQ=;
	b=ZFYQo02Td/vLIyXFb3ajrWwouFabsxmF4+a+G0eJModYQOEGTOSrNh8z/jbHVNmttd+k
	 2N7sO/MMq6a2fwFp+zTZXNRXALoZEaK3tpw1REbtn4Nt4t/0uH3oNmp3YZ1TbuxS+eJaB
	 3uRyV9g3gW1gM4i2yA2JVaDhUcYoIy+F3pw3KFrs7eGiJBOxKHy/MRk/dEm4+FCdXojpl
	 BN4g+6vu2WaVlWcUZ74QtFSQqOVkIvK7+depEwaU3SR5M+rdZqFCSYp82iCFKK5ord+u+
	 DXnXGw+g576Pz2qc/DrTLPOdeBCa8f2Ra9x4PhNvkyVmxqDkQhb7j27oh+feBuS+NTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KW34zT5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42C606D812
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KW34zT5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6220B1F000C1;
	Tue,  3 Nov 2026 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700940;
	bh=mwaffUvIfqrOd70Ufwy0BF9RX2dVZScAAYb+4J7fNyQ=;
	h=Subject:To:Cc:From:Date;
	b=KW34zT5pqqBkiBALBlZW8FHIpXbUfKc191qOv2WHL0e6j+1lNOCzJqgxxVmX9vHEj
	 71PsajFdixZT+hD3JiH4vtpyBnFMFFwi0PTnowFql7pe9B49LmMeprHpc070W32iGz
	 cVk5I42OzhyxxpKJmuW1HE5VbNkyApHKGQAUbtlY=
Subject: FAILED: patch "[PATCH] ksmbd: deny access for an empty DACL instead of granting the" failed to apply to 6.12-stable tree
To: elb12345@hotmail.co.uk,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:15:37 +0100
Message-ID: <2026110337-headed-quirk-3494@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x de0cffef897c1c232ed973f89928cd6c93d0b1e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110337-headed-quirk-3494@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

