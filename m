Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934425;
	b=cSmCmJF4kJJFpPEvAbkwYygcrByj1glLN+pJo49hh2hwQmVj/ndZ3BqAzwc+O2Y+sO0t
	 ZdezJSQ+qwTX1nEUkP04NGi36OZpX3xjUYVkDrWJs+aXKvfeoD5ZFYLd/W/8HillTG/oA
	 26eU74VCJSzbIkdgnkdhyERfPINpayQgyjDC78Dl2LgOmCinTy01e4UUdH0VxxH8EjpkU
	 0zkddzsl6YlGYSvkEyUM7yqoM6cOyL3tdQ/wYGpw9stOClbPHpB9mf+a/uAW8UYl9ACLp
	 up/8kMm5s+qMSKiQfqkgzCYq5ZR0XzvPf7V9K3dyK89D483z99XN+Luzos1vEPCfwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cpqe42reQXIuCXuPE7qaIh4eI/veyQEUoeAGLTJ/rkY=;
	b=2lx4yBSpQgVNH5/VCh5+QZB/dFXeCuqhw71PmeOGlfkicB8o+ySGgRrnd1LnFvKRPKjG
	 rsoODroDFEar83kU4mzELEey0rKcP42utUCcS9DeQInAId7/nxg0X/CeO0L1P5eCBZ7fo
	 vm+IZsgxpcz5OjzNj2MUOz+EElgFc1BrtwtKF8r/hYR1jmJfcRACs5QBI1Epw8MUZMmwq
	 KSj1wnt0JCESQwNS772PHJBXcL01xDI+p6mrcK7HVShhj9VBTmn6JLi0s7CyUtrUQ3Abb
	 IzuLXcWhNQzqJgmoQzB8Kel8+Byth1pJhqoQmtSxxReRNN2qcKADb0GXq7jkm0fFn3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geVYPXyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4808606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geVYPXyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E311F0089F;
	Fri,  6 Nov 2026 03:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934424;
	bh=cpqe42reQXIuCXuPE7qaIh4eI/veyQEUoeAGLTJ/rkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=geVYPXyJr5nBAmjHdY6fbOYyJqDz/djK5z5G15hKMl+GHdpKpTbfGyleD5wCqoxBa
	 5vpB25qwM0FyIB7ZaBDXwMH5LX6UBcd+Hm6fH1MVW988POGfe/p/hJMjm8cZvohxMj
	 RrCih07aunHU37SQwxTI341aB8U4KD3PEMwPKh8mAIFL3AHytXmLKUDJX599zx29Qq
	 zXFVH3v9fC4e2FZypn9AcaYf7OL1V6V6oa7gPttdtbCK9SgUjscTstq3OpZhD2DWlT
	 bFRPBQ/spgVdd/kd+T9jRzMOML7Mx2I6mxRVlDZkcZIc8QfunzQ3lHHOx14YYqX+5o
	 WHomz/59nhQrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] NFSD: map fh_verify() status codes for NFS_ACLv2 replies
Date: Thu,  5 Nov 2026 22:07:02 -0500
Message-ID: <20261106030653.3936502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-retaliate-hasty-41b5@gregkh>
References: <2026110438-retaliate-hasty-41b5@gregkh>
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
[ sashal: Placed nfsacld_map_status() before the NULL handler because the upstream access-map declarations are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 2998640f259de..cf92e1f8df7d2 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -15,6 +15,20 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
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
@@ -79,6 +93,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 
 	/* resp->acl_{access,default} are released in nfssvc_release_getacl. */
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 fail:
@@ -137,6 +152,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 out:
 	/* argp->acl_{access,default} are released in nfsaclsvc_release_setacl. */
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 out_drop_lock:
@@ -163,6 +179,7 @@ static __be32 nfsacld_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -185,6 +202,7 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 
-- 
2.53.0

