Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929984;
	b=ChJRSgEJl4AggB0SDIL93+0Uljn7JHt6KAjR+sS6KZDajcQgOqShg2SsShrX/cjBGdjd
	 4tizg6K8yCiVlnraJd1px48pKD05l7uJFufGwQkB9cAQR+jfYNSmHX9KBQChmZUGYPoPA
	 ECSCz1RgE+D00Kp8gFX7ft6pidT/kugJrNvYBPhdiBYhq0rND/TBcxlPYl4v6TyWxxdgZ
	 9/HgF4+1Sqi/l4gwSRUv7wK832TAeD6nnbX7ZJQwM5NMpucD8mFqqE5xxjZNa+DsCCpXY
	 m65Ee9GHOP06Hj7yVnbQ7ATBFVkn7sCCLtIee4/En/xm5uQeT7m96f+ecgl9Nj805JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=thO5JkeILKgSWeqPDruNeVfnwP15qavXrJk2j5I1YWo=;
	b=R/y/1cBxaGriEdxjvdeu/VjjngcH9pxEcQ5DpZC7m6CAmuaUgp8cXfDpRqdbKTK3w+L+
	 b9iHN2YYktn3YW5xohfa9l2MUKmmaMCpovPVsUnoFfAH/1mHYrNTfrYBrhrhpnZkyV/iK
	 PCEWayZ7XCxppJdAozygI4EKHf+ot0op7AA5U1sZBr3j24IEpzdsl10UBb8cNiAizXkGH
	 jLsCKeZKcCpjLBBLnir9Yu58yMXOxnBPztr1zZ/AQr5CZ9Y7TahqdAfatLIX5pk17YMKP
	 jZSZV5TRxIJQ/VU1CIB8IvUoq8mDOiXskdw6E87kf8B2mefTX4BAK7P2zMXpw8ikEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY9pnPts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E842606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY9pnPts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13DF1F008A3;
	Fri,  6 Nov 2026 01:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929984;
	bh=thO5JkeILKgSWeqPDruNeVfnwP15qavXrJk2j5I1YWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KY9pnPts9x8navZbCLTc3jASuDg44NkuSrTq8G/zKTUabAMzZRRTnpJ7kBZwcFYZf
	 fYWJY08CFqOKhrPWLTAruuFYA8DU1abWERAGP1khLekpmP2z58cUpCwQZsGLdDoL2c
	 g7wRb9TrKnFH0OtLcIrEcMmWNJ3sCuHX8J89GmG9v4qZ72ss9L0NvDUAfIKLdK/QhK
	 GLh4h14Ye4I9WR1Ca2vh/cfYxZfDdhkrorEX1Si4cSl5JzQCjlQ6IJAYnKzlGIBJMe
	 i1jW95E5/spI2NxoySvu7mxUxcF7iEnsdBM9d1+vAshrGfFgBvaTV0OmsQjWcCfmXR
	 MQBrC3Mopc4IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/3] NFSD: map fh_verify() status codes for NFS_ACLv2 replies
Date: Thu,  5 Nov 2026 20:53:00 -0500
Message-ID: <20261106015247.3620698-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106015247.3620698-1-sashal@kernel.org>
References: <2026110436-sputter-backdrop-7c80@gregkh>
 <20261106015247.3620698-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit ccfc4db5ab740175b9958ea0cf5986957bf4e659 ]

The NFS_ACL v2 protocol shares its status code space with NFSv2,
which has no NFSERR_BADHANDLE and no NFSERR_NOFILEHANDLE. An
NFS_ACLv2 GETACL, SETACL, GETATTR, or ACCESS request that carries a
malformed or empty file handle gets a reply with status 10001 or
10020, values the client cannot interpret.

Commit 1459ad57673b ("nfsd: Move error code mapping to per-version
proc code.") removed the version check from fh_verify() that turned
those codes into NFSERR_STALE for any version 2 program. The NFSv2
procedures gained nfsd_map_status() in exchange, but the NFS_ACL v2
procedures did not, so the unmapped status reaches the encoder.

Add the same mapping to the NFS_ACL v2 procedures.

Fixes: 1459ad57673b ("nfsd: Move error code mapping to per-version proc code.")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260916004240.141975-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index f978aa2be36aa..113ec827ae061 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -57,6 +57,20 @@ static const struct nfsd_access_maps nfsd2_access_maps = {
 	.other		= nfsd2_otheraccess,
 };
 
+static __be32 nfsacld_map_status(__be32 status)
+{
+	switch (status) {
+	case nfserr_nofilehandle:
+	case nfserr_badhandle:
+		status = nfserr_stale;
+		break;
+	case nfserr_wrongsec:
+		status = nfserr_acces;
+		break;
+	}
+	return status;
+}
+
 /*
  * NULL call.
  */
@@ -121,6 +135,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 
 	/* resp->acl_{access,default} are released in nfssvc_release_getacl. */
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 fail:
@@ -179,6 +194,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 out:
 	/* argp->acl_{access,default} are released in nfsaclsvc_release_setacl. */
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 out_drop_lock:
@@ -205,6 +221,7 @@ static __be32 nfsacld_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -229,6 +246,7 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 
-- 
2.53.0

