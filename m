Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FC3168E6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606166; cv=none; b=htIGnosbgs9faWOfq51ZsK1+SZfjrCmObEjosigzUgB14Mzl+yo2Dzv0Ew0BCldQ57x7QgPvq8kTlwnJXOnaTEb3guL0Ou1Ejo0JbwcZgPlaeLGa3JnCkXCMNgnV5TV3yv/+FitBVD/2ayQGJ03g9o77XbVv4Cj6vGGUAqjRol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606166; c=relaxed/simple;
	bh=Aor9Mky0zdi8wcuPFsCF/4zzhfmcN/1xETE+AMC631U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwQtabFwbQoMCpEWit6m4e6ur8IOgc1SOvTj2FtygjwOs8E501+09glgKSGkoRRYMsu3XrblvDdUgeiWpHfm6Ljwf3O+imgAGrUfrSuyJ7V87jmKhuuI04NEXxQvK69oA9ZYXy2HkvvnwuoATOl9ZabkYFUzF6stWAmB1d+7pm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty0g6Ven; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty0g6Ven"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7021F00A3D;
	Sat,  5 Sep 2026 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788606163;
	bh=mdDkVa5/NgPZdzIidoGW9xhCafkp1r/i0wqBBB91LLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ty0g6Vene6Q9V2nfNce/Mcbp1uroDm8SMwd0rr0h+hJtB7SbijeOlKA+XN0loYB0+
	 /Utt4hJ4QsTbA/iIFtlJc3OFzxo2WfmDLn71Fdu9/Q3SvTUx3aRc4d2qBvfKZvLKnH
	 sB9GYDVbk2GlCc3X3umcS6MCkgrBdadysrbbEnRf+Es5RS5gruE09fA6Wukub1cIGn
	 GVKoFh4d51o7cD+PsfLirkO8e/32hgq1/lo9sbl81DSDkhaKrunoV8nZxippEp3HN0
	 mhuLiFPn2fPTS9DcdyTpucsNX9ZbWqQ3jRtkhyUx7SEdeOH3d+1RjgLrHDzAN3c0ZR
	 +dXVBEOXTjo4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Sat,  5 Sep 2026 07:02:40 -0400
Message-ID: <20260905110240.3661850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-aerospace-talisman-6ee6@gregkh>
References: <2026090356-aerospace-talisman-6ee6@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5767080362e85..2766ce14c5f1f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -795,7 +795,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -862,6 +878,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.53.0

