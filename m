Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D14AF9D0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442878; cv=none; b=myzFzu1QBomLxkE6F/GIa1VosHfpyBbP+UnWQU7nE7FBqQEiwdWX8Ys1qWt3Z2b/fwnXYSeUlRpTwgVAyX9iYQNpe5NutSumtPcnlhkWD8oot2k3Ou96jQ/nArXfEITJsYDG3gfC7nOGTAoNzvrn8YaHxIHls0BLrIBlp79Ohf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442878; c=relaxed/simple;
	bh=nC6P6bCXCJ0+9eqNldSy91a/1ASXotY5QxtmIbygLzY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O/VeWKCkhjxEhQbkogHMZl/zt8nWhiFVxZp6sT2tJAI22BcC3iQJ3Yn7ZJtIoT04Oai8LEU8CgUybYVcG2tgosNx8zb5AtG3wgjCe4cHy0hUpIx8vFiLXIC76PXNl6VUz6FTvD37EGC3A9k+Om6aRYYpaRGocltK5xpFxISOKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VVUtK+mN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VVUtK+mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372CB1F00A3D;
	Thu,  3 Sep 2026 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442856;
	bh=vHcChZHhoogAQ76Sybl9lrUp5ahX786HtF5wNcFnbu0=;
	h=Subject:To:Cc:From:Date;
	b=VVUtK+mNZ6toSTlGUiNu66eVnJYtya6u7yiK583T1RL28zCtMywcsDluk6pAXPe8P
	 RpHEUXd7mhZw300YCrn/5lrr7oGmHaZjSVxrrh3I7x+cOhK5ECAFG+pA553LeJ0kId
	 MPJsIG2KhFdcF8uo1q9RngsOicjAx/y0aAf/lJHg=
Subject: FAILED: patch "[PATCH] nfsd: gate nfs3 setacl by argp->mask" failed to apply to 5.15-stable tree
To: clm@meta.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:17:00 +0200
Message-ID: <2026090300-rewire-gratified-1349@gregkh>
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
git cherry-pick -x 453d7198a0ab07a12d46e0575861ac7b932da17e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090300-rewire-gratified-1349@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 453d7198a0ab07a12d46e0575861ac7b932da17e Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Sat, 30 May 2026 09:19:21 -0400
Subject: [PATCH] nfsd: gate nfs3 setacl by argp->mask

nfsd3_proc_setacl() calls set_posix_acl() unconditionally for both
ACL_TYPE_ACCESS and ACL_TYPE_DEFAULT, passing argp->acl_access and
argp->acl_default verbatim. The NFSv3 ACL decoder only populates
those pointers when the corresponding mask bit is set:

    nfs3svc_decode_setaclargs()
      if (args->mask & NFS_ACL)    decode into acl_access
      if (args->mask & NFS_DFACL)  decode into acl_default
      /* otherwise the pointer stays NULL (pc_argzero) */

    nfsd3_proc_setacl()
      set_posix_acl(.., ACL_TYPE_ACCESS,  argp->acl_access)
      set_posix_acl(.., ACL_TYPE_DEFAULT, argp->acl_default)

set_posix_acl(idmap, dentry, type, NULL) is the VFS "remove this
ACL type" operation. A NULL pointer that means "the client did not
send this arm" is therefore indistinguishable from "the client
asked to remove this ACL". A SETACL with mask=NFS_ACL silently
drops the directory's default ACL; mask=0 drops both.

The sibling nfsd3_proc_getacl() already consults argp->mask before
touching each arm; mirror that in setacl.

Fix by wrapping each set_posix_acl() call in the matching mask bit
check and initializing error to 0 before inode_lock so that a
request with neither bit set leaves the on-disk ACLs untouched and
returns nfs_ok. The out_drop_lock path and the unconditional
posix_acl_release() at out: are preserved; both NULL-tolerate the
skipped arms.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-5-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index e87731380be8..a87f9d7f32be 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -105,12 +105,17 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
-			      argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
-			      argp->acl_default);
+	error = 0;
+	if (argp->mask & NFS_ACL) {
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_ACCESS, argp->acl_access);
+		if (error)
+			goto out_drop_lock;
+	}
+	if (argp->mask & NFS_DFACL) {
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_DEFAULT, argp->acl_default);
+	}
 
 out_drop_lock:
 	inode_unlock(inode);

