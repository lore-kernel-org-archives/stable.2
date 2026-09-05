Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D323E33D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578900; cv=none; b=lGZyeLDDdZuoP443tZJ/p9EM1y6v0RafN8rSg5HEWUxsQfniwdDqP5mGefjM37qmUy/ImwxHrNHMLvr17lilET5zsIPriHRAFR4y2tiOJ/HT6lPcz43+W1kYhIphzSd/atpOW72TxY7+PGtGAKsQ4WeeMGesuU9/taKVEyjrgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578900; c=relaxed/simple;
	bh=YSRnZNHLtcAknFoTmC56POlR/3I8V5V+LqrtVtcgeYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie2N+3z6OAX7D0mpEpkRDfLu2nuFxlqxDyHE9a8Bveo1zvjv82uY7c+48FllZdandPDlwIw4tAHxBZR03dvjPUyldRUONHXozACJvhKMsZnc2aGTYWIGSUWEGMfmDDQpJf5vtmbRaFSllzH+3/n+MqIAYLuHKq4FVuXV34ezlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RncXtoAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RncXtoAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886EB1F00A3D;
	Sat,  5 Sep 2026 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578899;
	bh=02N1x9QhlWmIChoYJYL+M/PJsn1Shs8b52p7xbVQVEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RncXtoAa6J4oy0wlP1/tWJ5rAqYaMtmbOkqpAktrwygXspFgiVIFuAikLyr1ASqIA
	 XB40EgwPd6Dkkb7SSDmBgoP2iu0JoXEkCsVBDxpOEEbCC/DzPzzpL4so6FsQ7G9dpY
	 YAoXXyyvFLr5JDAC8lHRA+3ix/IPdfKcfb1xaLe5gu0UdmYLWKlcW/+3IsYeZPqfOQ
	 vT6xKefFVv/VcwEJcCly1rJVLjNsPezBnUsia9AvqUtR2aIvmqZKH3ESfKLjuovped
	 gusshrtraAR+69a9L67QWeRdbk6o7Q2bMqdFX1z8nxdAZYhsoNyI9ZEdOwWPXoUjGv
	 16jVEztgIoPJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
Date: Fri,  4 Sep 2026 23:28:16 -0400
Message-ID: <20260905032816.1914179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-halves-ungodly-d2fe@gregkh>
References: <2026090351-halves-ungodly-d2fe@gregkh>
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
index 2c7a8943cad9c..6c4c121793088 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -796,7 +796,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -863,6 +879,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.53.0

