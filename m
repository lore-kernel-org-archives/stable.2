Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9645FFCF
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626445; cv=none; b=ogbeTyVQxuaJ//4XJsb/pZnc92zqVaE4v0PYyJHsfbb+LA2W99pXJHBdkC+6GhjvzmJktS1ElhATIc+BJRlR6F9FQfw2kiN+2UIHnncbCqP0plN5cRT05kcVuux5kCPWWrg7uNwb3LtWj1T3hb7UQHloPggrTCBGiE+rumHCJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626445; c=relaxed/simple;
	bh=ilAMYb3ig94srQLqhTqaBVQ/PHdBn6af7D559LGqbmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyRR+Vgt0lNv2e5GGQlTsfAySoJCy7YaZWsmMQ8cS01z4sr9yygqMfCB4CIoopdLfv3hcKRdbfcDUtpntNphMxS/daXrUdz6Adl2QgsYneV3QZwOYmDjrMJScEH0/uqGaU6F92k/dMB9HmejrRxRHXAYyB/WyuieYPgIObxDtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWA19HNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWA19HNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6BB1F00A3A;
	Sat,  5 Sep 2026 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626444;
	bh=wgwqAnRLEvxF7UW7P8iMAhgkYNLSnkCuowb85wvurhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWA19HNc5h1Le9Epfi+ufBaBnZ7vR1/Z2wvJQe84ffpczuqUOqZX+QPoID9yv/kYO
	 BEbU2tulPbSNq6KZz3b3ro3Vvaiy6DuvPk45q3VVexzf9ZSw4Uccyq464ot9tIijUF
	 KDrBBHH6vXm/YA5Cptgimd38smDtyaH+5GxDyH10yTC+vfOQ8OmVFmoubfN5hHjSdI
	 XSFiEainx3eJaAzNFiOGTic3RAuIzBUTd5X76GnyfJv2KK/55PSRcuZIK5H0iz/feO
	 NT1FyFpQwFuG7BAwdx7Xr8KHJRlG0wW+6bLOg27g4ZAqkkMBWCdPEngN2bCbtXzRDA
	 MYGG4ek//8Zmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: fix nfsd_file leak on inter-server COPY setup failure
Date: Sat,  5 Sep 2026 12:40:42 -0400
Message-ID: <20260905164042.457528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-boneless-cushy-0bf5@gregkh>
References: <2026090342-boneless-cushy-0bf5@gregkh>
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
index 7a85817fa5bfe..4cb86ca357d03 100644
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

