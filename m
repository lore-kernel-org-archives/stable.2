Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C64BC023
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000918; cv=none; b=gAeSrg47ysCKfAqHO5YfL03CeEkJtY/yLyCw9t3gujtVY38lY6YUTmkCKQuRP9QaxdX8BS9eUOu7RnP3bXmOGPgyIeYrRm2b2HifdG35BXqG+d1M9+mm8pKKFMoT+89hajoMiKiKV3aOOGkerpTbAyDB9zzQ4Ni4iHY7tBb70/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000918; c=relaxed/simple;
	bh=QrodsstZv1xUxg82NQQ9jut6R6EEeMj74cNXxbSarOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=INCnZIlrDR2l9d0rzPGKqfoyItcvAeKP/UaNmVBtICcu/TC/B5CxOaojHtMt7G8GbgqeOaNVLw00R4aWB5sTiq8Fdh83nASNp9jz5GrA9EuMYac2RrIXrkMDXeEjUa/k/qmkrKQ6HChTpC+7AJCD93UyFXC6ArQpRzc8OIywrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGC1Ulmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGC1Ulmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195CA1F000E9;
	Thu,  2 Jul 2026 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000917;
	bh=xDtfDD9aoE4CTINBozfHW3DPjyzP2zuuK/vjphk5BKw=;
	h=Subject:To:Cc:From:Date;
	b=yGC1UlmumBgKpXeeamAPGwQvj2lrVKAPvsugOvjFiWkBN/kc1XW1GQtJhloGHyoWB
	 lTSrdsLCCR0FleoJgAZXBfiJLYy+/J54V1Wm8S4fbJQRZ0Kt4cnMxewB4lm3rKBJJq
	 0GXF7TvGRHaP4IXRJ/7Yu9ypbfjl7iOJYxrjMoSI=
Subject: FAILED: patch "[PATCH] nfsd: reset write verifier on deferred writeback errors" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:59:04 +0200
Message-ID: <2026070204-congress-elope-c3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2090b05803faab8a9fa62fbff871007862cac1b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070204-congress-elope-c3c1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2090b05803faab8a9fa62fbff871007862cac1b7 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 12:44:19 -0400
Subject: [PATCH] nfsd: reset write verifier on deferred writeback errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nfsd_vfs_write() and nfsd_commit() both call filemap_check_wb_err() to
detect deferred writeback errors, but neither rotates the server's write
verifier (nn->writeverf) when this check fails. Every other
durable-storage-failure path in these functions calls
commit_reset_write_verifier() before returning an error.

The missing rotation means clients holding UNSTABLE write data under the
current verifier will COMMIT, receive the unchanged verifier back, and
conclude their data is durable — silently dropping data that failed
writeback. This violates the UNSTABLE+COMMIT durability contract
(RFC 1813 §3.3.7, RFC 8881 §18.32).

Add commit_reset_write_verifier() calls at both filemap_check_wb_err()
error sites, matching the pattern used by adjacent error paths in the
same functions. The helper already filters -EAGAIN and -ESTALE
internally, so the calls are unconditionally safe.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cba473969429..7e6468bdc723 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1513,8 +1513,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-	if (host_err < 0)
+	if (host_err < 0) {
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
+	}
 
 	if (stable && fhp->fh_use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
@@ -1694,6 +1696,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
+			if (err2 < 0)
+				commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 			break;
 		case -EINVAL:

