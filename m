Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63C4BC023
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000911; cv=none; b=BK2hWFZ4pBqatbI0qr6bZE8LKnPYvG1xBsVAsTxMUwyfxWCoGr1C4b/djFcTEKzPHBlVSppfNfGEihPj/73eU4o+UdRB95L3bPRg5mk1q56JbgVqH19Kk8J3Em2yiCMxYcOXvNml5Y5Feol5sGUBhRiIbzs1Nf5AKLtv89cC4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000911; c=relaxed/simple;
	bh=r1WEUZnQs1tiePtqDBrxPbiE+pPG//VnOYCypSFio3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gqBCgkA0CcoNgvQZeaTsjAfa2PMn7RXuOD2zxB3IA+xDmyhJgBAqS35LRxtgeX8fmUwcYgPGE0jqtijcrMzbZyT66sH5XZ2aSDADuMqsSkQpXxz1oqGpKBNrqWaMFvU5rK8XtdhaoMZa3apI2krMBJ7HyCH/B2yB23+evqus3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxcRPc3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxcRPc3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974741F000E9;
	Thu,  2 Jul 2026 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000910;
	bh=L9iTcotCwUBr+7tpK3+UPmKi9icFqhILPisorbIyUtc=;
	h=Subject:To:Cc:From:Date;
	b=VxcRPc3YQ75ICKauZC7OeIl+SdEkGeT8A18TYBH/c6kNJWhjH/dS2i1aq6cr4xPk4
	 1Y2oF1DHYyz7Pg8hud66lCpy/CXl+b7K39zhV+zipPmbIFLs1xqdmtM4yFRxo2Lj0O
	 oWQqqxevkq/YsnO6vu7imbHB9HwPiFvaLrNzM8wg=
Subject: FAILED: patch "[PATCH] nfsd: reset write verifier on deferred writeback errors" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:59:03 +0200
Message-ID: <2026070203-tipping-straw-267a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2090b05803faab8a9fa62fbff871007862cac1b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070203-tipping-straw-267a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

