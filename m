Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93547CA8C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606660; cv=none; b=GJuDcGvoRICbyFZkyzUfYCDzlJeXwBd86yI91gyb2Pcgo+oBnoQN0dhyQlojGqanXeX1jqmC8RSVLy2/YQxVsRDWRhnpNuBeCOY4kUG6+qPkYh+ft3bXOWMTBsWVT0dv0DHRw344pp2v/eBiSCYnO6WK0Je5piebIYBUaG09Tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606660; c=relaxed/simple;
	bh=BZAV/0zWXpT5uyhPPJwrVSOPszfnywimWH94WPzWdTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgfzB/PGhvsVwVCX990HUF4KfhMRUlmCfcUMjPbPMXrPclUURi2wGVzOZ3ZCsrklyrGLkpzoBWONopKArVUQpDE4EnU7wcQFM/6GEbrupN2icTg/TolifatPuQVWPkpK3m897S7MTyCVXPVxn8b589laaY0ACjIgZbKfURoEuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxsL89lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxsL89lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47531F00A3D;
	Sat,  5 Sep 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788606658;
	bh=yu9mrXEAza+/78dTwZX9OXB8yPGqivJ1y7BOMvKvtOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxsL89lrNsrEDTT/wzRBN23/6TdMOEg5P5zepbNpTpg9pq1BdM9a3qLCHJUA/zdRB
	 KbrIQOqBpWAHCVvU9esFsTuiGWnf/7aVUN0ZjGqIoAYrGyMFIz2T7uqm1Jr6dOFTNc
	 8TWW9dAs6UbDTgzmFxs2X3jJ9qcannBgZ/URFHyTfeZ6aqkiMfTN24yS3mYjdCKC2o
	 DRt5FqjE0BRmb33S9iWBxFnnK0p2lU+mT2SY0mdSgOv82HRxuBuGTAB0X1CEhoNgZb
	 4YstOg7dLfciQGBuamTjLaN+NA44nrvRtylMuQon2sAJh9qwAD0tnR/vfmhsI9rItk
	 7afWHbqY73lTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Sat,  5 Sep 2026 07:10:56 -0400
Message-ID: <20260905111056.3729073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-blame-sincere-dcb7@gregkh>
References: <2026090357-blame-sincere-dcb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 2c7912732184773dbd371a411da87af1cc080b86 ]

nfsd4_create() stores the return value of nfsd4_acl_to_attr() in
status, but the switch(create->cr_type) block unconditionally
overwrites it in every branch. ACL translation errors are silently
discarded, and the CREATE proceeds without the requested ACL.

Add an early exit check after nfsd4_acl_to_attr(), matching the
pattern already used in nfsd4_setattr().

Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
[ cel: prefer NFS4ERR_BADTYPE over NFS4ERR_ATTRNOTSUPP ]
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-5-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ retained unconditional ACL conversion because the older helper already handles null ACLs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d29a37f696a44..09b4fcd28d62a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -761,7 +761,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
+	/* Sanitize cr_type to avoid returning ATTRNOTSUPP. */
+	switch (create->cr_type) {
+	case NF4LNK:
+	case NF4BLK:
+	case NF4CHR:
+	case NF4SOCK:
+	case NF4FIFO:
+	case NF4DIR:
+		break;
+	default:
+		status = nfserr_badtype;
+		goto out_aftermask;
+	}
+
 	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
+	if (status != nfs_ok)
+		goto out_aftermask;
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -828,6 +844,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.53.0

