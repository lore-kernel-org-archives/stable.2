Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554E288BA
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278389; cv=none; b=o85oWBnJfUgoZ3Bs2b00lxBf9nA2wTUb/jfp3rN/7h6gie5s2mNbt3f0x7dgX7EOa8HL4HmZ72UVk8I97z5UKangx/+f82Km+rl/uEXYR0MHSSduJtj1x5RmPDaLulKJm6k+emb60RmAys0Fhitt7PqzCHQi9tTXSRlkTBtmfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278389; c=relaxed/simple;
	bh=Is3gHQ8wB5Fdwd+whRG/wNH/Y15itD6QfGWxpfAK678=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ovtflbsfcw2/JrTLTY+WFQfUPSkezPtyJISiMDR4WozTJWOIr2lLtu/+vyzImKffwiohzJIjNcUkoUB6TjxXDZiUnZ1tlPdh+PgKEEA/+9FxwC1zItc0fXv4W0D04oWaQiJQ3I8Zr5ZHDwt/JAuo82xfNClQfS0lnVHv4UBrolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBbn8xqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBbn8xqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288811F000E9;
	Sun,  5 Jul 2026 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278387;
	bh=iuzbndYfj9+WAXq8Bvp5oDtG8J9dzN8LQYzvs4i+xOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBbn8xqtjgmTScO8DNjDJNTJdRTaU3a2yK19CzhfmpowNzO0RYZZ6TIcTGhwtRwR1
	 q5XAN1D0/FkWoEjDL4CVBYv1VcdfNDcw95T9Prpt1MpI0WtEFowlLPfJHYFK5gfSpW
	 t9zv65EdKsSW7vHzqdG9lGRtR/vNmjzxLh5eOeCYBOVUir+fuDy2pn09Zwigs82JJQ
	 Zq0S5YCkCprvAZ6vnd6eF10fa3M0Jv+6Dl85mjN8/vpB4c+bd2mYPbbgQc0e/hXglw
	 0JA8sVPd/xIR5zkqk+z0kveH0+Baf6AuKHJhU9/AXp2vUrr2eG0pPUq6Ws7YhuuEsq
	 3bBttSOGvjxZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: Don't reset the write verifier on a commit EAGAIN
Date: Sun,  5 Jul 2026 15:06:24 -0400
Message-ID: <20260705190625.1988013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070204-congress-elope-c3c1@gregkh>
References: <2026070204-congress-elope-c3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 1b2021bdeeca12364ad0fa7aac9ddba5cae964f3 ]

If fsync() is returning EAGAIN, then we can assume that the filesystem
being exported is something like NFS with the 'softerr' mount option
enabled, and that it is just asking us to replay the fsync() operation
at a later date.

If we see an ESTALE, then ditto: the file is gone, so there is no danger
of losing the error.

For those cases, do not reset the write verifier. A write verifier
change has a global effect, causing retransmission by all clients of
all uncommitted unstable writes for all files, so it is worth
mitigating where possible.

Link: https://lore.kernel.org/linux-nfs/20230911184357.11739-1-trond.myklebust@hammerspace.com/
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 2090b05803fa ("nfsd: reset write verifier on deferred writeback errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 87a596fc6654dd..11eebaf49c24a4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -334,6 +334,24 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	return err;
 }
 
+static void
+commit_reset_write_verifier(struct nfsd_net *nn, struct svc_rqst *rqstp,
+			    int err)
+{
+	switch (err) {
+	case -EAGAIN:
+	case -ESTALE:
+		/*
+		 * Neither of these are the result of a problem with
+		 * durable storage, so avoid a write verifier reset.
+		 */
+		break;
+	default:
+		nfsd_reset_write_verifier(nn);
+		trace_nfsd_writeverf_reset(nn, rqstp, err);
+	}
+}
+
 /*
  * Commit metadata changes to stable storage.
  */
@@ -646,8 +664,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, status);
+			commit_reset_write_verifier(nn, rqstp, status);
 			ret = nfserrno(status);
 		}
 	}
@@ -1126,8 +1143,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	file_end_write(file);
 	if (host_err < 0) {
-		nfsd_reset_write_verifier(nn);
-		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1139,10 +1155,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0) {
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
-		}
+		if (host_err < 0)
+			commit_reset_write_verifier(nn, rqstp, host_err);
 	}
 
 out_nfserr:
@@ -1277,8 +1291,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			err = nfserr_notsupp;
 			break;
 		default:
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, err2);
+			commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 		}
 	} else
-- 
2.53.0

