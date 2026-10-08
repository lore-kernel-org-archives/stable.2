Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0F39D6FF
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498575; cv=none; b=naf3e4Ac8Y1YEfujk/fWt40UR0FQ/VqiXMNj7ZheWqB1FQRqbQ+F6z+dPfvzbcISQyYrqrj3ST3Rk12TDg6bnZL1zlskb6zkI/QN3ohOazv/iHNzOATts9T5PhoWYR4jPI3SkiL74V5Pkzm9Mhfj3+3XG/XtyRl/h/qZjnbneR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498575; c=relaxed/simple;
	bh=XDoDohKUT4MMZIf4IQQNH9bM3u5dtDfVD4p1Q9suYvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8mRfAjkb1Xoz8vGZ6Dhbc/DZfiw+QcNhb8cs6vHDcpMUTQjT9bO76ESW7PNtEVg+9BAXDjHV3o6iLEboqIQn3BDwhAHx8xRIXd6i7f3WzH4il5+MstrsScV/ZKMeLKBuKklAa1ANnbTFOayPkEYf/90YyIU0BLXNs3rX2vsJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=qNNTNICx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="qNNTNICx"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-824e6e6ed71so4535367a34.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1791498573; x=1792103373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOtIgYM1WQR25wgZCSC/vXuzzOnva4ZKPnDOK4M6K0M=;
        b=qNNTNICxCbiAuiKfSfWFYX0vpLEo7MOXs7Io4597cFOAG+PDDxy9lJ1hAnnaZimJMd
         oY4eXNE3pWIepBgWQleR+Bzx7jcmBXxr4MstHPTWAZdTUWeahANwzK0Xzfy0u5cghujc
         X65NTME/PNYBb45/Mp0kqmHMUJKJyBQucNkzA8LaGdN0ZpgVkv0DhRnCDG+9nBPEb56m
         4SEFmkTpjX9KbsDMQMWMAnpAMNFQcX1QXeD/51I5aO+9VtHoJtjDSnGxmiLB3GLmIJK+
         +4yj5PFLievo5Qw5u4k1RbiuwK1TrT/dPs0VcooBm/T8rEW0zuP3+NYuV7ODI8xkEHf3
         XL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498573; x=1792103373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOtIgYM1WQR25wgZCSC/vXuzzOnva4ZKPnDOK4M6K0M=;
        b=gwem9ncXnn6a/EVMzyRheU878ryrLPdHiVi2hSWXHeFhHbRxoflVGAWm9igAhVfCG3
         7Xk2YD/MZZRt34FU47RIYrTo7a6S09XkD5metrcpxFB9Eg5xxNU3H9vbfhBJYyHWaQwW
         ZyPA+2+hEkpE2Oo4MCzCMiR4SLBOLgD4oCfm5N9NnvqRCsE1Nkb1rLPtznXAf1TORSv5
         uzJKcaKmUN3pNM1YKsuYB5MrMwVzqGp+jjGd1ANA/+lDegbUGcIIULGApvmmML9Sbjdv
         JnAPx3mM+gQC1GcY7vAYKZ3z0LjyC2+1syTkRf2yv/hDiZfd6A0h2CgVxr/2qXgYgCb6
         BOZw==
X-Forwarded-Encrypted: i=1; AKwUvByt+mM+UCorGW+zAQtvZh3avUI9R6RAwRHzyyjqo6fEAdOYTvNHobELc+ZnZTb58JcTZf3O7lE=@vger.kernel.org
X-Gm-Message-State: AFuF++kK9UTZmbyCVZymLd9n57Gt+yQLV3f4bIfyJBeZn7Fb4Kzq4qox
	uw1g8WoxunkYr5UxQyxgekkaiXw0fPIn/B5pRktC5++OnlbJ+URxlvzlo5uAT9XFGkc=
X-Gm-Gg: AYBFou3RFodaOpx8zcw6fHrW+/eSaSHzJmJV1nRnndKqMG2GHXaSKNgDPLgblqHA9gk
	cujmnLtrWY3maTn3ygWdODoBIKDtxZljHhCdK+J2GHtHB9/EJ/T+nIdCRYtDCqDh67plO3176Ik
	enXwAYSFKf4+FJngA4UsQAgBXw2XcfD7cxvCniF677JOujkwCdD8NxGVV0QUlC+0QxUxduw1iBz
	8hUYNPrEQFs0jAuyu7hfZXLj7P87jwHxAG17gLKF2quTtTBs5uqmnAqNt82lYlG4llaKYjyhygd
	Nsu7YgjdjQXRmQLHV4vRDU5dEqiN02bBM/azUeH2qeoHKdO4elGX/3QxH2Zm0VN1nO3sj+w3DCv
	ZjRCqJwbVnu/oMYBgfUme4TInJamWvqc8aKE0aqojucCOsiyPn6ZqngMUHnH1Y9dKYeKz5HrCmR
	465zKLeHqh/5KVMfdKyAmzhKfSCds+MJwH73PY2HHOBvx/pUeSB9WjPx+9AbWWOmIKo958h/XMm
	AL9TeRkO1osAy1bBkea5IebUajlA2lRQqs5
X-Received: by 2002:a05:6830:919:b0:81e:1262:6536 with SMTP id 46e09a7af769-82acf29f4famr8740093a34.15.1791498573265;
        Thu, 08 Oct 2026 15:29:33 -0700 (PDT)
Received: from irdv-lubao.dev.purestorage.com ([208.88.158.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-83038f82468sm278874a34.11.2026.10.08.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:29:32 -0700 (PDT)
From: Lucheng Bao <lubao@everpuredata.com>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	tmenninger@everpuredata.com,
	jcurley@everpuredata.com,
	Lucheng Bao <lubao@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/pNFS: prevent i_size regression while layoutcommit is outstanding
Date: Thu,  8 Oct 2026 22:28:42 +0000
Message-Id: <20261008222843.63319-2-lubao@everpuredata.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008222843.63319-1-lubao@everpuredata.com>
References: <20261008222843.63319-1-lubao@everpuredata.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ac46bd374c9a ("pNFS: Ensure we layoutcommit before revalidating
attributes") replaced outstanding-layoutcommit attribute filtering with
synchronization before explicit revalidation. For layouts requiring
LAYOUTCOMMIT, OPEN attributes can still shrink i_size before metadata
synchronization completes.

Commit d8c951c313ed ("NFSv4.1: Don't trust attributes if a pNFS
LAYOUTCOMMIT is outstanding") moved LAYOUTCOMMIT post-op attribute
processing after cleanup, leaving another unprotected window after
NFS_INO_LAYOUTCOMMITTING is cleared.

Extend the existing writeback checks to reject smaller sizes while a
LAYOUTCOMMIT is pending or in flight, preserving size increases and WCC
checks. Process the reply's attributes and establish their generation
barrier before cleanup removes that protection.

Fixes: d8c951c313ed ("NFSv4.1: Don't trust attributes if a pNFS LAYOUTCOMMIT is outstanding")
Fixes: ac46bd374c9a ("pNFS: Ensure we layoutcommit before revalidating attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Lucheng Bao <lubao@everpuredata.com>
---
 fs/nfs/inode.c    | 8 ++++++--
 fs/nfs/nfs4proc.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 3022454f7698..11432f521b04 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1636,7 +1636,9 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	if ((fattr->valid & NFS_ATTR_FATTR_PRESIZE)
 			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
 			&& i_size_read(inode) == nfs_size_to_loff_t(fattr->pre_size)
-			&& !nfs_have_writebacks(inode)) {
+			&& !nfs_have_writebacks(inode)
+			&& (nfs_size_to_loff_t(fattr->size) >= i_size_read(inode)
+				|| !pnfs_layoutcommit_outstanding(inode))) {
 		trace_nfs_size_wcc(inode, fattr->size);
 		i_size_write(inode, nfs_size_to_loff_t(fattr->size));
 	}
@@ -2392,7 +2394,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		if (new_isize != cur_isize && !have_delegation) {
 			/* Do we perhaps have any outstanding writes, or has
 			 * the file grown beyond our last write? */
-			if (!nfs_have_writebacks(inode) || new_isize > cur_isize) {
+			if ((!nfs_have_writebacks(inode) &&
+			     !pnfs_layoutcommit_outstanding(inode)) ||
+			    new_isize > cur_isize) {
 				trace_nfs_size_update(inode, new_isize);
 				i_size_write(inode, new_isize);
 				if (!have_writers)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 04b1987115d5..1ae047a062b8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10093,9 +10093,9 @@ static void nfs4_layoutcommit_release(void *calldata)
 {
 	struct nfs4_layoutcommit_data *data = calldata;
 
-	pnfs_cleanup_layoutcommit(data);
 	nfs_post_op_update_inode_force_wcc(data->args.inode,
 					   data->res.fattr);
+	pnfs_cleanup_layoutcommit(data);
 	put_cred(data->cred);
 	nfs_iput_and_deactive(data->inode);
 	kfree(data);
-- 
2.34.1

