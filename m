Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932158;
	b=notZdtL28ECLZXRCe1jIQHd53b+5csB3J09q0uSoTQBoCN3fXsnWhfR5cwqJoFHkapYW
	 pe3We2Esfghn/mpDxjV0rss+RKlWmTKQLB57kZoKSqTNFLKuuVxw+AbWCDmhJ1UMW/u58
	 Yl+t7jR3slv70ywzrGKm8DAcRx4rr5Wx2q762WCeeMa+eviENpqmDn+jdpV2fgDOc7Uys
	 RhAyvR9lFSWWghBWjqMRRAGcqrsULs5P0tLvavd0kXsDcMmSdmKUJKZ6xNlBf2jHPle8g
	 293vBzTi/xQoLOp7+VU2S3GBdJ5nOP2K5tjBpBrKSIH20HkSEp6vqc+CgpV160n19/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8HFyvdbZasmtkyhh9+y28XzweWqF8QOA2ZZwCVTIt94=;
	b=aCR688VxA1NVjAapWMWXOfCodDB2VrByeYRo1VaPdA26uvo16DNKaWfv7vFwSddhHtRs
	 hQT13UvYBgTtLE5dYXP6myFwgQhzQ6/Ri7NQcLT1ginl88WIbAbD35SLtwWNMnFp/zwpw
	 0/7/rV8y8IMzVEPh0HylfUAoFUZAgJdKHBJaKHw6L2tB08TN5h4PTP8QtKd0/oom610YA
	 CcMyfl5IU++/TdEkNjnaRn8rqm4Y24MNgJGoSoXX63bqZHYi9nHpd6g97KbxRfV7Tqflc
	 3IF8s7bml6VaViRQO1VRdJSxZhwNEFl/7DS6J8hA2DBY3lbQOTm2OE2uRi9AeoC+KqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbmg4IWR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD6606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbmg4IWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E21F008A7;
	Fri,  6 Nov 2026 02:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932158;
	bh=8HFyvdbZasmtkyhh9+y28XzweWqF8QOA2ZZwCVTIt94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mbmg4IWRQSmitYrsp41emL/nrHOeRvc6yhLPBHdeLlMlCXjCfsPoVxzWdMxGJKb6z
	 pCNIb7WGUrTaiy/oOkADQVAwTdIlP/1wfylXOt2ZlcwsRVj17i4iUD7hFEmfc+ZMwt
	 ML+jEgAzuHsgUTnN3W4GYhETF3WleP32G2yoiRhflOaWaKgsuHgbJsTihngoqQQlCP
	 Cy/FGN68mxFm7fJG0EcWNKuxyNPQZsgu/+V74hy9a00GoP2XWNChmchfokhMSw1Lt3
	 BDc6552iv1h8UIkrwxalRuewUxRmRspefEtyXrmA+Dnd6FTx05q4LOobp6DmT91v2Y
	 AkNlDv5al/j6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] NFSD: map fh_verify() status codes for NFS_ACLv2 replies
Date: Thu,  5 Nov 2026 21:29:14 -0500
Message-ID: <20261106022850.3722633-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022850.3722633-1-sashal@kernel.org>
References: <2026110437-anatomist-emptier-0eda@gregkh>
 <20261106022850.3722633-1-sashal@kernel.org>
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
index 537097ce8c767..87269be93d0f6 100644
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

