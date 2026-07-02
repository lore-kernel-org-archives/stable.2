Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0142A7AD
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000605; cv=none; b=Inu4LUedTSA60gy0U0pOKnV3GhpaEMe3TJRnA0MluC44fs8sL2u67+UrYCeKfwgwW8/vS20D4HVcg4jHYCn3Rs/fzLhHC3+i7rwgqBv4HJ/PY/bAxMkLdtodh1nXFg4U9LqTPjLkuOiKCAk5mAPotV0KXMyOdHgH7TP9nUDKlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000605; c=relaxed/simple;
	bh=DJr7jhgiuCfg4EwkdagbLGZaiW8N3grTrRPTAdnNh5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BnhgIdZccWrpJFVC4PnebtDC3lk5uJRMKo+hru1cQINnKmKe3i/O/kIqSK3GisPwFq7jYzpykn2BPazcroSzjggTVWbveZ8eSejSdi58CgISdMqY8QXOoYATq8m5sgQ0KJnUiImMnSBsgVj9MgW4qviIGl3KA/INF0GP0QZyqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UShWybQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UShWybQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F71F000E9;
	Thu,  2 Jul 2026 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000603;
	bh=esQ1imQDlZpaxdW7IDMT4xMbxM9wajLG9rEvmKV8m6A=;
	h=Subject:To:Cc:From:Date;
	b=UShWybQgfPFEu6ktpx/3kYSvr6ueVC0NK1vlBxj3gWKbFouru8uu09jmJYtD9tNEl
	 Gre0SKQnuIZE9ZHwNAdYPj6/OR6PHPM7UMTyKO8FsI62QXeSYWRGvsG3wRSdr49Rdm
	 vsak1N+xUxcyOoNcjHJByLTAtg6cGHTt4erxhv0Q=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()" failed to apply to 5.15-stable tree
To: hemparekh1596@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:56:54 +0200
Message-ID: <2026070254-saddling-prankish-2dc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1ef06004ed4bd6d3ed8c840d9d1a376b66d4935b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070254-saddling-prankish-2dc9@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ef06004ed4bd6d3ed8c840d9d1a376b66d4935b Mon Sep 17 00:00:00 2001
From: Hem Parekh <hemparekh1596@gmail.com>
Date: Tue, 2 Jun 2026 16:56:46 -0700
Subject: [PATCH] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

The permission-check ACE walk in smb_check_perm_dacl() validates the ACE
header size and caps sid.num_subauth at SID_MAX_SUB_AUTHORITIES, but it
never checks that ace->size is actually large enough to contain
num_subauth sub-authorities before compare_sids() dereferences them.

CIFS_SID_BASE_SIZE covers the SID header up to but excluding the
sub_auth[] array, and offsetof(struct smb_ace, sid) is the ACE header,
so the existing guards only guarantee the 8-byte SID base, i.e. zero
sub-authorities. compare_sids() then reads ace->sid.sub_auth[i] for
i < min(local_sid->num_subauth, ace->sid.num_subauth). The local
comparison SIDs (sid_everyone, sid_unix_NFS_mode, and the id_to_sid()
result) always have at least one sub-authority, and an attacker controls
the ACE revision and authority bytes (which lie within the in-bounds SID
base), so they can match one of those SIDs and force the sub_auth read.

A crafted ACE with size == 16 and num_subauth >= 1 placed at the tail of
the security descriptor therefore causes a heap out-of-bounds read of up
to SID_MAX_SUB_AUTHORITIES * sizeof(__le32) bytes past the pntsd
allocation. The security descriptor is loaded by ksmbd_vfs_get_sd_xattr()
into a buffer sized exactly to the on-disk data (kzalloc(sd_size) in
ndr_decode_v4_ntacl()), so the read lands past the allocation. The
malformed descriptor can be stored verbatim via SMB2_SET_INFO (the DACL
is not normalised before being written to the security.NTACL xattr) and
the read fires on a subsequent SMB2_CREATE access check, making this
reachable by an authenticated client on a share that uses ACL xattrs.

Add the missing num_subauth-versus-ace_size check, mirroring the
identical guards already present in the sibling parsers parse_dacl() and
smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 664b1b4a3233..340ea98fa494 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1477,7 +1477,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			break;
 		aces_size -= ace_size;
 
-		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    ace_size < offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE +
+			      sizeof(__le32) * ace->sid.num_subauth)
 			break;
 
 		if (!compare_sids(&sid, &ace->sid) ||

