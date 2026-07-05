Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7A1F4631
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262427; cv=none; b=ZbEihD2S4fL8M3HEiic3SZ8NtWt9fbpbTRBm5eWAxzzRJn1w1vM1+OeJw8nCnx965g/92L4vNoWNcRe/7Q4WzVrUg3iqmAEy5R/tOhYUUudK4xxyHlbG+eRCgaCLyWBU2JU6LAwwhgyymnX39JX7tOIHvVU/MfjVAgCG11/zpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262427; c=relaxed/simple;
	bh=eV5JBnI9+sgBVZ2F8+MQmE4efgm6eYMD5f6v7PnHK30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpdEUJWJXu8lHLAlCTZIo7uYcVZa7bWcc08ERTIlDQTAlHStVJKfGq2YL//m9rtshgUIboCs0qNOiDbGgD+b2G3My+zokkDEIUuJzzg8YiL+2kUFSfq9n6rCLSUb2hjpX4E5hDJo97WLavPXkEr7wVwo9+peAfdqGeWQpbPRJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8jN/RRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8jN/RRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F08F1F000E9;
	Sun,  5 Jul 2026 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783262426;
	bh=DKalG1t2H0QhEPIKT1QtLd8CPVJI4+I1TsrPgciY6ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d8jN/RRjb8UyoHzKIqpxR7ejCxvJJ1Bw4yc/YL3WIX+bURPNFP6xCea5ABBKFFpMG
	 8ZIfHNYBBP0TXYYhoHlBIiInMgoF5D1OG6n++BZDWcv32uFolh1K1H/8vJQaLcZmX4
	 4dPWsmxT63QjCwpKKynugZLBdZVj3VXY6IaQehO1HMJJrJQeTLpcU0hNbgO1FybnpM
	 XlH0cgSFrHGkJMbgX2z0zUF87MYYYVi5stDCgro3WRa90XwjN5nficAA7DXpCL3RwT
	 jIjStmMunZrF+wgJWrJUiDTCOygB5n15qOITM+TVxvQXiiRT5peJbdiOJd7RBnKqKO
	 wFeS1LUPvFkrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: Don't reset the write verifier on a commit EAGAIN
Date: Sun,  5 Jul 2026 10:40:22 -0400
Message-ID: <20260705144023.1865360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070203-tipping-straw-267a@gregkh>
References: <2026070203-tipping-straw-267a@gregkh>
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
index ae1f43eb515a81..f83b312fe3b4d4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -338,6 +338,24 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
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
@@ -659,8 +677,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, status);
+			commit_reset_write_verifier(nn, rqstp, status);
 			ret = nfserrno(status);
 		}
 	}
@@ -1177,8 +1194,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	file_end_write(file);
 	if (host_err < 0) {
-		nfsd_reset_write_verifier(nn);
-		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1190,10 +1206,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
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
@@ -1336,8 +1350,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
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

