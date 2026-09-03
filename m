Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DED4AF9E4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442867; cv=none; b=MGltaLgD4ZrWb+UN1aCy5IfM8yu/g7ddq2He8eSPN5ax15/swzUpLc+4zjx3SLSnGr/iIG5GJtS4b0wHQHbnNEs2t5u/UINdKcQXuZ/y9sWZR4UQlA+pkO1d8dCQ/hZI9JGEZlTvKol15rA3e5BBoLqaCTZRvPXoSml8VPm8hKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442867; c=relaxed/simple;
	bh=WEaiHPJOCLvQZQsfgF4RCltDg5kmwYZz1dvUeNQXRXI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qFC22C0BLR4cWHd29oJaDvCyoWNfk76pOUyBiYdvNP9YnxnUKjllkRKjQTHxgDd5dhN1vbQYZOFlQUxaqTuY21mQRlQzAKW43+TlU2ULLr2TsBgWDsVnceriwFdLT2AQHW0aNZA+hON6u7FNVKRnbIltv6i627++YMjSa1RdGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIplh57D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIplh57D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B27B1F00ACA;
	Thu,  3 Sep 2026 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442853;
	bh=/IkeERoIJI462NazaNVm/njGWjKMLgDha3NlS5e75Vg=;
	h=Subject:To:Cc:From:Date;
	b=sIplh57Dih/FlCbNb0fKEbzAUEhTRoGuJl3ksPAz2QisIlNSqQm7uvrDIhoNG1AQ2
	 mmRRjzk5TDNkSI3faJawKuL/he6e8uFgmwjDpfdwq4hyL2b+Xv1MheAiEs5ZP4bF81
	 ZXj796lTcqmCYVSa9wmSWPA42IGE3U4BiTvSSqgs=
Subject: FAILED: patch "[PATCH] nfsd: gate nfs2 setacl by argp->mask" failed to apply to 5.15-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:16:50 +0200
Message-ID: <2026090350-onyx-repaying-474c@gregkh>
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
git cherry-pick -x a3a7e20ed66d3f04d37883c398da8a113b430769
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-onyx-repaying-474c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

