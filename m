Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A74A3F19
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788627049; cv=none; b=FjEGc+9wwg1aeh7Y7WOg+cw9rzAuPc2BC7GAB7I99kcDJAmEDR6vsBeidqYj409xD454qvlgqR9EgW+EBCZBtt4I/UwLKhzcvQi6tMAnRAEiaTQ8qVsVIxK39pGckg5OgbjSTymshuxxQpH74ofnoU25GZG4D9XJMtEM+g1B5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788627049; c=relaxed/simple;
	bh=ixwwkjv4NgoJj92TUzszagr7mWd2VeQY9wXJTea3FZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEQqrlk1NFUAIcP/NKc98yVlcO/6tQS4oxRfZVtzG2j0jPD68+vPbV9a4H3/EPySsi/r9Zq818spCQ/kmdULlmiCUrkFthxJNc83glZ59EnIhpJYNbWixL0NUXywfzzbL1c0FhpZJ5AKsbEan+UEWpADrz6lvOTnnwzT8UpWMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEdRpWOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEdRpWOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A4B1F00A3D;
	Sat,  5 Sep 2026 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788627048;
	bh=jTy4cqgHaCGrIqgAYsmiThVlVgDwXIiOfa+hzOQBECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEdRpWOtvruc5VT8jJ6DUrtX/JaZadEBmNZV2pRGtlWKIguuSMVrSoTPVzyscZZfW
	 OiGbkwCV9zejyEQtrP1f5HRMmm5H/UpsZhQvA4a5vFTdwIMvInYpkk5Pg9gBGa2Fgu
	 oNEuu+KGyk8XMT1UxbIaalrOZlSiPhnZ1En+8OxxOBKDkKMB6ytUPUunAJg8jRF5Jn
	 OEGVMF1IPXJkPDiTHhyJR15M3jlxmf/KHqoF/8X5hkQnRZVOjmFCJp8ShG5TtQw6wJ
	 2Ew/VIqDpzJFr+lqUuUHbLNhpYxWDikDKBu1EGu11borhxFilRabDhMh2rnWAxvHId
	 mi7Qq2TCjreUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: fix nfsd_file leak on inter-server COPY setup failure
Date: Sat,  5 Sep 2026 12:50:46 -0400
Message-ID: <20260905165047.471369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-mute-statistic-4761@gregkh>
References: <2026090342-mute-statistic-4761@gregkh>
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
index a4c7cab1679bd..39954506fd157 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1776,12 +1776,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

