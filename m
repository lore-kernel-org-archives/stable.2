Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F024356766
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616537; cv=none; b=laVnB6k17hxkyFUACHg1ejqXG2B5uTuVRiQxSbqQwUkvDa/9ryBOzDxSmioqoSEj/lUV2Hrxww1tr6lRxTjZIOU4KnKKMmN55FQXP4HVV25iCefiMlWQ2NIcCy/qmna7nr6IU46cvh+ZhQ+1im4OLhulGcH8oaxjUBXoNHVIakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616537; c=relaxed/simple;
	bh=/kHtvMedBL3znvFKP/kqbJMsXf0ZS8H/i8sW0mWafSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/ZPmhHqJgjeLG6Z0MBVJ7vt+AEJIprLfiB/MtxAi3TUsOfVcMOxD9lClFJVRNIl8rpedcQCD6lcypX7/T5MLRnUKsUWZ4TnNGBLt9kvqdq7x1nPWJ/q1ixQZwNCY7hHxMk1qeUVfVxBnzMtUoDZ5JypMkVbBkfeoXCXBpGMi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzAwuio8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzAwuio8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ABA1F00A3D;
	Sat,  5 Sep 2026 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616536;
	bh=j+fxmbsvYN/LDQ8f0RBTY4TgTOPOfnZ9Hdw5RIwhP+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzAwuio8xtnVecbtZrZJL4B29Zz3b/h935mBNSSpEosTf9IgGpkFc/A1n4wzEIopE
	 Nq6c7+QqRQ/0XHeDwEgFLnbd7de4k/jWoxMwlEG9wlV8xMAg8WIhk63IB5kcrtGJH8
	 COX+Fef5bcqa9WhOE6xbzw4l2epaSW/rpFUFBs2Pqb5Cxf+zm++d2qwzQJiOgpyY4F
	 7RYd1QEgoPiTVf9x493DQzqjTTG5tYi+p9ihW4p8/2zAbYA2jJ05VD3Lll2dbgIgFW
	 tFe41skTfRooP2N4IlkYs1UKeJrlOhVLBEKA66nFEbtXYOBQ+JZaELvQExp2oSjAdZ
	 1hfc+tAm5Pu9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Sat,  5 Sep 2026 09:55:33 -0400
Message-ID: <20260905135533.113055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-gathering-scavenger-1461@gregkh>
References: <2026090357-gathering-scavenger-1461@gregkh>
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
index a4c7cab1679bd..65e180d15ef67 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -762,7 +762,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -829,6 +845,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.53.0

