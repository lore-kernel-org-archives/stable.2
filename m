Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B726B973
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278389; cv=none; b=p0/bvChV2+4YLyqDw+S/vVRhgPGcOvCe/DCtGI5LpeYDMTWea0TE5wM6i73ei5VVeo5NqXjJZ1h76PFtU2VYTqFS/msgylj4OkJOhW0XF9l63dEIC1Q+FBmoXabndqOljgrkRTZLeIb9A9Jcqaf2YZ9nnmmKU8TqYJJKae0O2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278389; c=relaxed/simple;
	bh=q1eWrAKlLgXnt5gcUHFZV5Q3jI9PPPPpL+kNVn7q6BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyCvdZNcjIGtVKcYcPIZj9E031zITpkdpSrIgJtjXM/ZGzbbZ0SF1OWoHzujY40VOuXglGYzyHQK7P+FHlxpeyX+ggC85Vom92r3qAu8YPCN+uLp3XPe6Kkfsx6/goaiKBQT11lu2dvwOPHV8e2wPED3sU9T/1sW8l6y+0LS5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msJfIHx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msJfIHx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102671F00A3D;
	Sun,  5 Jul 2026 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278388;
	bh=K+eFNahH1jA5MchRUt2RShHN9MY5DdxlIMvXe1LhqHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=msJfIHx5cyCW2k/gvI28rGRN9P7M3gD6qoLHrIdpa9zL6VcyKDRrHKqX7Ovh2T5qp
	 SU0dy9t6v0lBhaAzMxQHC4AXP0wbTWFhDYyP8jPZ9tOPEeHG3LCA48dJkiTrmhtAGw
	 AEI4j9Yz7rWuobNnNDgQyMu3tTLb92Qs7QspqYIjt9c93nCro3wC6AusHjoTC1srnF
	 OJZ646bhI2fzHe4x5yj5qeEUefMXHQaHbSiUR8ut9JTsqn/s5hDCMZ/KGwgT5/qKcF
	 5cSSNWLi+9jyGyqTVAY8ziann7lNnH566OKCfW2PAdRivba8+d6U3FyK2WKpDQWmwo
	 2WUUZXceHT1Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] nfsd: reset write verifier on deferred writeback errors
Date: Sun,  5 Jul 2026 15:06:25 -0400
Message-ID: <20260705190625.1988013-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705190625.1988013-1-sashal@kernel.org>
References: <2026070204-congress-elope-c3c1@gregkh>
 <20260705190625.1988013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 2090b05803faab8a9fa62fbff871007862cac1b7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 11eebaf49c24a4..ed5c9d075cca4f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1150,8 +1150,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-	if (host_err < 0)
+	if (host_err < 0) {
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
+	}
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
@@ -1285,6 +1287,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
+			if (err2 < 0)
+				commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 			break;
 		case -EINVAL:
-- 
2.53.0

