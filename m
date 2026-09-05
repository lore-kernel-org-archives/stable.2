Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB474CCDFD
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788574423; cv=none; b=QZF5J6we3wMCMxE1jjQRF+E+3Ro2IMC+7mUv6lCXnTO6RDAE/p6ksPDHvra2Gg35he5ZfcmO/bhl9b6s0vb3ghD/ual29IqJyndHAXRle9dFipeOwcodX5p0OSzvGLY6WlwfHoYbmiP6rTjJtl1QL7FfFIFCPg1X+hVRdj5k3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788574423; c=relaxed/simple;
	bh=D8OCIrRcRr33nzvFLHa2Bh5sJD0GJxCXfPzBKyR+wAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQTY5YFjum9xUqwGnXmyCXrsMm11WSu6NE4N0QIOvria1sljSPKIo+InvjtQ7yiOgeqRuFDvs2vQoF7Hpwr+0wq9+AhnVJLj2uEQ1Kh8pyDNSYobaTQyLfBtZRIhns+q98mdouU7xg0VCbkW9MHDuq2sASKfGSazsQNOyb1AciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIXn91Tx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIXn91Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A10E1F00A3D;
	Sat,  5 Sep 2026 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788574422;
	bh=1N8eH8xJZdtwQM0roDxeDabt5SCxEpPV+5xX/dqVmNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIXn91Txc8TzCIzJEIzDFeWzUnPCT4T9YmvaYR26mXzWstL/8hMxhqdeythkjcjIA
	 a6r2nqjXgkhtp237JVQcXBYQiZtx9HZ5Mi4XKIvMUu6HKUGGZlJ2F4RJ8HRy0tBMPc
	 yvbOcxdzOk0pmGcgPp0LjOt+Ylu4T/mQLFLvbwr5MZWzYlgPE6pqrrpx6CykCZw/E6
	 QfsHiOy27GkPLNC8WmPrRkxvFKgo497TGmLd53isQWAWkFa82DVwOoH8YXGC89Li6o
	 a/J+bJPITM7j62UDJ3B+oLmZjm/9eGa89s3AoZ58YPfU2DGqtMkPpWk+cIRsdxDBIn
	 /BZBH2K//TL5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Fri,  4 Sep 2026 22:13:39 -0400
Message-ID: <20260905021339.1845829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-lizard-judo-a248@gregkh>
References: <2026090350-lizard-judo-a248@gregkh>
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
index 98086d217aa22..a394634620ea4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -800,7 +800,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -867,6 +883,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.53.0

