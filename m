Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB05231836
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623186; cv=none; b=aBOo5RUMBULcUousXl+Fn1/5UCS8BK0VpG1e5UDG4qqgd//zlfhIy/cFs23WXBSJGVPMDkcgeJ9GH81pCekjls+tLMDaVTUJVQzkHMs76MiE7nRHEz1Q9DgtG4+x4LTrRfsIy8nytfylSFDj21jQ3tsJL2m5/HmaDAVa4HIzzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623186; c=relaxed/simple;
	bh=Rt6bO3i51HZgO7qJBWIwjy6Q9IaESJ4IGxKR5+z/SXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqcbOjjq9cRo3sJNYu4GPDEH486L41X5bo3mZO3Sij29Hh+ld6wlGeLfrAtIbox1FV8e2F4rjN1RdkHWJH7TU1D1/dxQ58AP35TmRrf6AAHXT1FNmup6U1pSpyCfYM2gZs8pH5rYbRAENPygdpRHMhYQpzPfaK/irP82RjIAPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7axcfTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7axcfTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0971F1F00A3A;
	Sat,  5 Sep 2026 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788623184;
	bh=eP2JTMvw4mZFqg8cN/t7iNiAvT78LLV8CKYbbb/PVKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7axcfTo/WmXL3/7AeSICThCwBaC5fDJSmzzQLyKYZHJx1Bx60GVlqO1AUKXLI1yU
	 SKdktrCAIrftO9Eae+0dFhCO/Ty43VzdkaazOe8nALTgH6DQYfA0QafqxN0qj2Sz8z
	 4KhkanxU3SEzjx/bHFnCotAIjrbLp9CzExjuWKjRQCn0fiEMy01rObNxS7cC5SP/kj
	 5tFFSnmSpe4qsc6YuXgIHeM4whOH42EcjVcSQymz357F9E/v+bLRfhtt5+Q6T8sd8n
	 DHoz17xok50YffKEk6AdeF8OllVUL9/v6ZBG3N1V1KtxFXxUb9i1FuC19F7fx0U6R2
	 WaxNKFhEaXTfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: fix nfsd_file leak on inter-server COPY setup failure
Date: Sat,  5 Sep 2026 11:46:22 -0400
Message-ID: <20260905154622.397093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-anytime-glorified-49ee@gregkh>
References: <2026090342-anytime-glorified-49ee@gregkh>
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
index d29a37f696a44..53fb2c503dad8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1775,12 +1775,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

