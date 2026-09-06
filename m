Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F41363C63
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660825; cv=none; b=mDvEcQmzq4DtrSwX5eI/m0yiT4hK+chl9JMaMyhJ9i39I6PD68KWYUe8yXYF5Rr43UcRQT0NVpY60zuT5nx2hh8MjdeDa/xx4GP6N/45K9aXV+Lbl4CBNCdAnfl+wWjWWqMIv29iRVfOCUGRdvVx313zqP0YwyXtgeHkZ/aOXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660825; c=relaxed/simple;
	bh=0033GFncsVxXt4VxfVFB43GmPTXO0tqLWCU9k0qwadc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnHnpqdt4o19NcmGxo6HyonV3tEPsCDcd7Ny0neP+B3R0WDIdzckbUl2iq8tvxo2iisNdHIe0IL9DiXw13+eDNORfgoSbMJgIMoFbHomAjGl+ZsBKPNRI56yYXorX0nM4eZnx4+VM2UUlhQMAb6vCLrOIdmr4NUJncdaM5Nu5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9bBdbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9bBdbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0C71F00A3F;
	Sun,  6 Sep 2026 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660820;
	bh=J0kmZI3xf3MyH3EERidynh9S+EVixKtAfH4czxJNWEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kP9bBdbl9M2Cze/2i0zyXfb+zsMVmrsbxLh2KlJEjLHwpwVajeseHXRx3FEV7be+B
	 jLLO/SNY0ywlE1Y6WY0g5liP97x1f9ls0+37ZAeBLgkRF3MSKoF5iSkOrOqjfJ4Q4C
	 wtU7f+diAUFvBV7cNN9VMa03VTK+/YtT1rsah4phQhuDRwuI3P8UpDSVTefWEMMr8c
	 SwnyPu47L914WH0EUq1g2Z106LXz6v+B662aq7AiGLluneZoy1BABuVW/uSzsl/0ix
	 KcW1IP6A8j/Wm6kjhR6mwYXt1bjm2ieIdk3xZ1qJ3dXoe4uUn9ACNN7pNaRzA7Wt2s
	 jxFUfN6BI6aag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: gate nfs2 setacl by argp->mask
Date: Sat,  5 Sep 2026 22:13:38 -0400
Message-ID: <20260906021338.761875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-subheader-pretender-b710@gregkh>
References: <2026090350-subheader-pretender-b710@gregkh>
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
[ adapted four-argument set_posix_acl() calls to the older three-argument inode-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b3fddd772599e..3276f1a6ab799 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -115,12 +115,17 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
-	if (error)
-		goto out_drop_lock;
+	error = 0;
+	if (argp->mask & NFS_ACL) {
+		error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
+		if (error)
+			goto out_drop_lock;
+	}
+	if (argp->mask & NFS_DFACL) {
+		error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
+		if (error)
+			goto out_drop_lock;
+	}
 
 	inode_unlock(inode);
 
-- 
2.53.0

