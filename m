Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0EBA34
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620566; cv=none; b=ip+MOQl3PpeXnVqqM129ClQ2DSi2t75E3qvSDbxiMkjuwJ/jg3Zsq3Fg6Etanb8JYSA1gBXbV4o0+dreUusnOZIEw5ErMCUEHe7pDsLkSs9JTUEunlKvhttIXNDfOUcQTVhE+z+2YTMValABvpwUGVTGIaYtqzL7F3+HLHt+vNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620566; c=relaxed/simple;
	bh=A3TJrtgd7oybgHgivklokLfPybtXlCDzOteEvkEab1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKA7ENyT2HsLUE1sSsIGedJ7tJEqnrfoc8wBf5MDgeGGCSlWsQ50G7qrRarR9/zsbc4c3hTXsUna9YgJ/PoDXK023tFEzmcB6Y40F6HLJf3eu0kzS4giAfDATtVYvQ5QVCSBDCB4ukocwapxah6UVNyFf3qrzW64REtuDMZJH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdDtn2Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdDtn2Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A9F1F00A3A;
	Sat,  5 Sep 2026 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620564;
	bh=iwF5vpFlUhTnNRLBhqLXb8q+tBnAJgEF7tmOsqDfqBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DdDtn2Nj1et2/jUPOY6IE9m453BYBZgOG89X/HbHFYCgLScqBM3TUVAhckZCnQR0d
	 Kzk9TjUCsKt6fvwsk0QDT3aIHJcyeyJkrekPyd7NVEkuCtnvyjHmdvbEAkzuvCk46B
	 AArI3S8rqGGjMqFQ2IhNB5lINuh1roha+QIJy3sIbavLE9MhXST7PauhLm4Xc5U/kB
	 WbzEu8GBIAOLcXquq+9y1ZkGwKpZiCouwngSj9SdPdygi1ycZUi/z/XIyraEKIhSEG
	 59BtlGS/2mME5xL/vKqccYWicgdPhJDgtY+Qoou7COqGrDPWxheM2wXIqkfdfm4ZlI
	 WOme7Wew9WrRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nfsd: fix nfsd_file leak on inter-server COPY setup failure
Date: Sat,  5 Sep 2026 11:02:42 -0400
Message-ID: <20260905150242.303418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-pasty-taste-d5c3@gregkh>
References: <2026090341-pasty-taste-d5c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 88a76145451d703eedd867b5989bf73d17340399 ]

When nfsd4_setup_inter_ssc() fails, nfsd4_copy() returns
nfserr_offload_denied directly, bypassing the out: label where
release_copy_files() would drop the nf_dst reference taken by
nfs4_preprocess_stateid_op(). Each failed inter-server COPY
leaks one nfsd_file, pinning file/inode/dentry/vfsmount.

Fix by setting status and jumping to out: instead of returning
directly.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260531-nfsd-testing-v1-3-7bfa481b0540@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ adjusted cleanup paths to omit unavailable trace_nfsd_copy_*() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5767080362e85..cac8586429317 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1808,12 +1808,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out;
 		}
 		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
-		if (status)
-			return nfserr_offload_denied;
+		if (status) {
+			status = nfserr_offload_denied;
+			goto out;
+		}
 	} else {
 		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
-- 
2.53.0

