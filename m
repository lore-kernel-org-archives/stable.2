Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54231716A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573003; cv=none; b=UKkIYLVPlKr5LwzoUoya/jsKN6/q+/dMeOisTSNHZunckBvOaj53QbaYB4zBhLGv4ov8RVfGsb8NsT6JstwBs1F7Zk0E4+Vvc3BLGzaS+13X7Kmqz12/X0M1Bm/2NVjLq7iecaZXnrfuHCs0Go7+5X3OjhsP4C8S2AafCNqWdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573003; c=relaxed/simple;
	bh=TxWJnS9fWcYd/CEaJ6J/6OLzkJQD+5uttjsAzBfj3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNOhzE+pLtiMSHx6Lnx6lMe6SaaEufRF0o1aNUqI56f0t1WKPYT8QJwr+GXe0x1VaoCyvWJgPl7sDFu7k3K2Xei7bkx/YGgVqcUw2BTFbP0vZBoKiLsIdhU3xQ1RmX/9P+3wuWb2AXZ+8xjlnI6vUhXPuKxQ1zguFmllo0H/K7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4S2xc97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4S2xc97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449BC1F00A3F;
	Sat,  5 Sep 2026 01:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573001;
	bh=axqPrUR/RwcwQtV+k9wGZL3/cmX3Z3nfy/OnGemvy1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4S2xc97Xikc7LQIg/hcwcvGTFf9poPNSqwhHywFtquDUbpv9naB9Wb/UapSvxxga
	 iYISG3MGx07Ox6LNWZVta/JufUHeE+T8MQZPgv9WDzUcUzxnW7RgiYNkBeg0iub/jJ
	 ECdoTFjdmWErnUBO6LD+O+hlBzLuWJXGkbxU3nFucbBZYXD5qDlXNxITW+bSY2zo6N
	 RJae0VFIEje3bK0+K9laeZbUcJvpRWnwxxnqgEyubMyXkG9+25nB7hk0DbRjjOR4sm
	 ML29MPZC34sOdcQqe0YHbNljdsov6YARTRl9lMqFcQy9DYhHHvZnu+/GoBdk6f8Rt9
	 t021N526l/PVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] NFSD: check truncate permission under inode lock
Date: Fri,  4 Sep 2026 21:49:58 -0400
Message-ID: <20260905014958.1806867-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905014958.1806867-1-sashal@kernel.org>
References: <2026090340-darkness-disposal-745f@gregkh>
 <20260905014958.1806867-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit b778e0e0a16759f22a70579c3cf8d254a40d4a7f ]

nfsd_setattr() checks whether a size update needs NFSD_MAY_TRUNC
before it takes inode_lock(). The comparison uses the file size sampled
by that unlocked read, but the actual ATTR_SIZE update is applied later
under inode_lock() by notify_change().

This leaves a TOCTOU window for append-only files. If a client sends a
SETATTR that does not shrink the file at the time of the unlocked
sample, a concurrent append can extend the file before nfsd_setattr()
takes inode_lock(). notify_change() then applies a real truncation
without the NFSD_MAY_TRUNC check that rejects IS_APPEND(inode). The VFS
truncate syscall paths perform their own append-only checks before
calling notify_change(), so NFSD must make this decision against the
locked size it is about to change.

Split the write-count acquisition from the truncation permission check.
Keep get_write_access() before the locked setattr work, then recheck
whether the requested size is below i_size_read(inode) after inode_lock()
has been acquired and before notify_change(ATTR_SIZE). This also avoids
the plain unlocked inode->i_size load.

Fixes: 783112f7401f ("nfsd: special case truncates some more")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-6-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 064074dbb64b5..429521b0d194c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -390,21 +390,22 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr *iap)
 }
 
 static __be32
-nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct iattr *iap)
+nfsd_may_truncate(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct iattr *iap)
 {
 	struct inode *inode = d_inode(fhp->fh_dentry);
 
-	if (iap->ia_size < inode->i_size) {
-		__be32 err;
+	if (iap->ia_size >= i_size_read(inode))
+		return nfs_ok;
 
-		err = nfsd_permission(&rqstp->rq_cred,
-				      fhp->fh_export, fhp->fh_dentry,
-				      NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
-		if (err)
-			return err;
-	}
-	return nfserrno(get_write_access(inode));
+	return nfsd_permission(&rqstp->rq_cred, fhp->fh_export, fhp->fh_dentry,
+			       NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
+}
+
+static __be32
+nfsd_get_write_access(struct svc_fh *fhp)
+{
+	return nfserrno(get_write_access(d_inode(fhp->fh_dentry)));
 }
 
 static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
@@ -531,12 +532,17 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * setattr call.
 	 */
 	if (size_change) {
-		err = nfsd_get_write_access(rqstp, fhp, iap);
+		err = nfsd_get_write_access(fhp);
 		if (err)
 			return err;
 	}
 
 	inode_lock(inode);
+	if (size_change) {
+		err = nfsd_may_truncate(rqstp, fhp, iap);
+		if (err)
+			goto out_unlock;
+	}
 	err = fh_fill_pre_attrs(fhp);
 	if (err)
 		goto out_unlock;
-- 
2.53.0

