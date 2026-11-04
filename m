Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818490;
	b=v9LcGWREI57lBQjg96288zuWRPh+L8OvMEMgIEc/sJ9WMgAApahpoBOjYXX8R9PUrbTx
	 fVkkIp68+dOVbrFOItRaPQ2BwWKyme8diRRlDNYWA5ExF3lw4hIEXOxyGiYt5Jon99cKm
	 t284F2TWZqVXbae4AurtGVCZTrDrFOx6H6Sd6X/OiRrDs3qetjWPw6HLWlwRvPeba72rf
	 PenWQUBq1tkMF6aEY9zmNM4TqCy6TSGq38trbbpO0ogBs52ilZkZj/eCjpMfphZN1QLkX
	 r94X9QMRHeeJCnP19juDaA3yJTZUP/+A7VBFimcmh+TujEDO4mC3mgaYAm6yzp4ytzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818490;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SeCfoWW2BNuVeO9m7QjSBA39I4eq+wxqSunkccrpJec=;
	b=0AUqe+04eyGbUOxKGqQ+ZkOuR5B5Px6pX5k4PfgL1uBK05pWrWO+tzohdAgaxaEjSsNl
	 CsR7sA66ieNR5brit81X3dwqKJ6AyCBwJuRwfVpFQabxiRZcJKv+8jgn+gFuD9rv4DlFm
	 mEWmBmom7TjDE7ay0Cjihp5vgYMJxZVG8zdsSyCnOnSQfqTV7owLJrmLAyHamnocW2T/s
	 CwDiJH5q2pURbmqTuvdpA44B7Mmse0+evrlXblbH1FtsEHSvDbMjUumBIuVY4StxqQxK8
	 SACix5RfdnhZUPmtLWW6aAWO73O+vDgGhECLxyAajEUFqYjIFCWtosFe1Psh3vqdYZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Icm1dN44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B4606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Icm1dN44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6537F1F000C1;
	Wed,  4 Nov 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818489;
	bh=SeCfoWW2BNuVeO9m7QjSBA39I4eq+wxqSunkccrpJec=;
	h=Subject:To:Cc:From:Date;
	b=Icm1dN44i2hCvLHZz1wFnKZMZl4Ll0TagjVoDLg5Ssiy3+y1mghugnNTTIE8tHDbX
	 yqkWrGEcxppLM6GM0w2FxLYFwYxk3YNbY5RQUFdPMzUSDHS8P1CQv5ZpwzXEn6LJvv
	 ib3T50yIAct7Pax0aEx2lAmBo56RBpW2a1pSsigc=
Subject: FAILED: patch "[PATCH] NFSD: map fh_verify() status codes for NFS_ACLv2 replies" failed to apply to 7.3-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:36 -0500
Message-ID: <2026110436-sputter-backdrop-7c80@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ccfc4db5ab740175b9958ea0cf5986957bf4e659
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110436-sputter-backdrop-7c80@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ccfc4db5ab740175b9958ea0cf5986957bf4e659 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 15 Sep 2026 20:42:39 -0400
Subject: [PATCH] NFSD: map fh_verify() status codes for NFS_ACLv2 replies

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

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 0a5c444fef99..0673e83b6666 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -59,6 +59,20 @@ static const struct nfsd_access_maps nfsd2_access_maps = {
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
@@ -123,6 +137,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 
 	/* resp->acl_{access,default} are released in nfssvc_release_getacl. */
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 fail:
@@ -181,6 +196,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 out:
 	/* argp->acl_{access,default} are released in nfsaclsvc_release_setacl. */
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 
 out_drop_lock:
@@ -207,6 +223,7 @@ static __be32 nfsacld_proc_getattr(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 
@@ -231,6 +248,7 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 		goto out;
 	resp->status = fh_getattr(&resp->fh, &resp->stat);
 out:
+	resp->status = nfsacld_map_status(resp->status);
 	return rpc_success;
 }
 

