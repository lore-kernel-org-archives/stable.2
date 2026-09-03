Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6114AF69F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442866; cv=none; b=B5SJvbdHN78HaaX2XQzPZNlM53rOtzw1Xozstj/pER1Zv5pZyV0pv40a2NMMmpkcLtwLd9jghTWaYr4DEvgOWapRZd3iimkAfpGwi1hIQWMK01KQ0jK1dlmbQ21CsKM6+oToASb5I2gmS1ymr4ZexE7E/8CJHNEo+nCE5iEP3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442866; c=relaxed/simple;
	bh=xU5ptK5mrVGwCUuLvWsBYiFBftNMUe1OvjhjTScNRiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ShDnzp6Arrc5fmbBcpR3POW65W+TajvpLjF0ahpzfnLUVJvaF+153TFNZyP57u6BPPBc3nNJ0jNU+iPSnO9ftC8qIOzp3Stce7+vZWdOg116ozyTlSYUBSjpBzisvqlnHwcYWSsHVXbNXdJBSk0q82eBWScdVG+zCd9Ym/EiWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4/f6asI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4/f6asI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D081F00AC4;
	Thu,  3 Sep 2026 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442851;
	bh=jUV0CtAfOTIqCw/ash7wSd4KToagmoKTrsEWHoic2M0=;
	h=Subject:To:Cc:From:Date;
	b=p4/f6asIcyc2yKN81wVlsKFDliAPF6+ZoUA6YLB5CQPSfbMVPO6o8feztb4rJfvvX
	 OAopsJu1TjY8KoeNKPqCosedagbUQzRUKlqoQ2OHKY0PNNqNxFU/I9v7s2Ak0nE7h0
	 zaeQzMaOG4/0NcSO5ovFMlFH8VeXV4fqn0UXAPbk=
Subject: FAILED: patch "[PATCH] nfsd: gate nfs2 setacl by argp->mask" failed to apply to 5.10-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:16:50 +0200
Message-ID: <2026090350-subheader-pretender-b710@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a3a7e20ed66d3f04d37883c398da8a113b430769
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-subheader-pretender-b710@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3a7e20ed66d3f04d37883c398da8a113b430769 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Sat, 30 May 2026 16:58:16 -0400
Subject: [PATCH] nfsd: gate nfs2 setacl by argp->mask

The NFSACL v2 SETACL path shares the decoder convention used by its
v3 sibling: nfsaclsvc_decode_setaclargs() fills in argp->acl_access
only when NFS_ACL is set in the request mask and argp->acl_default
only when NFS_DFACL is set, leaving the other pointer NULL because
the argument buffer is zeroed up to pc_argzero before decode.

nfsacld_proc_setacl() then hands both pointers to set_posix_acl()
unconditionally. set_posix_acl(idmap, dentry, type, NULL) is the VFS
"remove this ACL type" operation, so an omitted arm is
indistinguishable from an explicit request to delete that ACL. A
SETACL carrying only NFS_ACL silently strips the directory's default
ACL; mask=0 strips both.

This is the same defect just fixed in nfsd3_proc_setacl(); apply the
same remedy. Gate each set_posix_acl() call on its mask bit and
initialize error to 0 so that a request with neither bit set leaves
the on-disk ACLs untouched and returns success. The out_drop_lock
path and the unconditional posix_acl_release() in
nfsaclsvc_release_setacl() already tolerate the skipped arms.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 76305b86c1a9..827f90194c43 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -115,14 +115,19 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
-			      argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
-			      argp->acl_default);
-	if (error)
-		goto out_drop_lock;
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
+		if (error)
+			goto out_drop_lock;
+	}
 
 	inode_unlock(inode);
 

