Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E437366055
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615572; cv=none; b=aGOYNFh1Z+hhH/J28RC8C6SiygS3xpSMrY3b4wNyOzNgNnAo8JM8ALqCAUubru5uZ2ULGzdrQ2fP7nP1ZqgDyvrxx9b3iPEyABoO71rPCrogq4gPneD0sAgAU8twBIR/Oq5dob96OVgdrogcPUbIFdOX0+I0Cr5MLcuR+VY2z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615572; c=relaxed/simple;
	bh=eTHJEnAQHi6UfXw2i+5E34MyNh40E4aCWLg5MahPvOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuRwBtzE/95/fB00nnh8qtHbxQ8cQkCg0HEBUm1m4l6+B7OpU0n4f+xSXkvFXqttt/dxSjgoKR5nGuD7jrWuqLQ/SUU3bCvWNpQaSXxGpiKT7zosgUonXZ4wStLbqcLpML+q4tAUJTwWeaCTTu0Lj/BaxCre6Lk0528yHxCNTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOMiCU6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOMiCU6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12FF1F00A3D;
	Sat,  5 Sep 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788615571;
	bh=9rV6vTou8JScZHIdRegCPnD5kYIIXy6iaAQ0deg4CRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOMiCU6luO4dOY7U98V8GgNvEW7PYh9immK93kMFXfSz4kabSKUckJWtCimsbFfyR
	 sO2IuMVuRXjrNhYfGu0n6NsY+mdcoN6Rb5W9Xal1AGD0V+EcARm/FcFgzRr1RlpuQA
	 zLf8kg/dU36RXT/VNTpdCN9i/k12HrZunpZRIPGvzKj92nOQLnYTtHkUiswfszgZhE
	 vU4t46uS8IkyJ8OLf717IEYD5BmwM4yrkRESMrSZr8PIOzH1bbk1wuv/0pU4qpNiYP
	 Yc3fUo6ejilfkk8il1nJA4OcNxlgEGq1gkTN8nhgC9dSP96m7vJ2idz2++yhnJhDVs
	 PG2DO2q0Y54pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Sat,  5 Sep 2026 09:39:28 -0400
Message-ID: <20260905133928.68421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-subsonic-bronco-a251@gregkh>
References: <2026090357-subsonic-bronco-a251@gregkh>
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
index 7a85817fa5bfe..9d6af56e38eda 100644
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

