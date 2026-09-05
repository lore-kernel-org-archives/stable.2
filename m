Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67030C16B
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638746; cv=none; b=tJnhenWzgISi6OcXbHWMkEjpIW/7x0EHxJvvhUKbrpPWcCEqvM+0W/qXZsAZpnG3HFMMIVzfS6E+IPdxvUTWa1f/LlKu12svjCL/BystNPqCUdpfMQ/HnaFNnHy5aCrR+otGbpr84XfBA/nbyYlhsGWNIG3S6mWbSbIBMtp7HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638746; c=relaxed/simple;
	bh=gQ/Y6h3xT/dyzJO0kAU5hJ3E5PLPQ+pC3qrEbF6Y7q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5GjiuAQqAk+OrszF5IGbM32SMG/ZzAR1t8pnpcSBVjqJlt9WAeFQ3VoJPYKJUQKZ3T+0DlFWDSYlr0d4r0NC9acS2uYnFJjkTf2sYEHjWb2dj6D6U67A2HYcNESu1Cr6Ds5zYZIPeU4KsDVvm3xsok/fVoXcMU1RU+h8aMxBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYNX+K3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYNX+K3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993851F00A3A;
	Sat,  5 Sep 2026 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638745;
	bh=IBXdFOvML0PuOPQfDIofrIFa5BJNthYpmpjxXldOVOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYNX+K3+kzvp4dgAL3E02mqNa9+3nqFe/4SLxjUwq2X2lU2s23uw85DltgX1yWhI3
	 gAWlSqgEhsOKF9Zzl+mWxDZii5J/fnuHNFYdmA4RGiVhVOq63unxKzgFbH8bNrgYs6
	 a23fJyJ5AMDcjjJYXpiJ5e1mbQ3ms/YcscL0Vs9c4OJmb7bKiiq6uBIxBXlml5LFbs
	 Uj6C9/0pfPZfU3mK37MO5smC5h8gJNvLXqoABcUOFfILHqWdIZHBOqJkluv1+fKlm/
	 LTgv7G6CtCLFtlAPtyiIbkzcl5LFuNjqBwkHkHnJzmZc7jNwPucBDSWmRy3m1mi/dV
	 fDgehr41pszbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: gate nfs2 setacl by argp->mask
Date: Sat,  5 Sep 2026 16:05:42 -0400
Message-ID: <20260905200542.608898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-thorn-wispy-da17@gregkh>
References: <2026090349-thorn-wispy-da17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit a3a7e20ed66d3f04d37883c398da8a113b430769 ]

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
[ retained the older user-namespace and inode set_posix_acl() API in place of the newer mount-idmap and dentry API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 44b74d83560b5..6e2ed6947033c 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -115,14 +115,19 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
-			      argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
-			      argp->acl_default);
-	if (error)
-		goto out_drop_lock;
+	error = 0;
+	if (argp->mask & NFS_ACL) {
+		error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+				      argp->acl_access);
+		if (error)
+			goto out_drop_lock;
+	}
+	if (argp->mask & NFS_DFACL) {
+		error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+				      argp->acl_default);
+		if (error)
+			goto out_drop_lock;
+	}
 
 	inode_unlock(inode);
 
-- 
2.53.0

