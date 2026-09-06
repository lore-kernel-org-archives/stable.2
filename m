Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F238C433
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660815; cv=none; b=qo9+LD/toblisGLg4/6QqnRFGE2Ly7HR1v+St0YGQKcNbpqxsV0MVz65aZtatYTuv/9TpFgk+O8fpWt9plsjiGQtiUzyW30zwwrAZCd6fdxAK73QnbJaGR3/LQYtY/jfQ4o8ehTVqUVyy7taJp7EuKZHfar2HS5e0+Y9ucb1gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660815; c=relaxed/simple;
	bh=zdgpx4Oz4BwCoD0Y22f40muhN+NXUK+oHMXbavsPVVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O98oO3qEvK9q2gxN1BqTUF1NHc93QB7p983vNnSQKBqsn9rV/k0XYqGztB840Ot1d+uZ/+xQRbuEKzOBxc/V7tzsj5B+jZdPoIefMlsM8ZBxS36ze64Aw/Mwby6y//LTqzjS4cJ4m9F83LYlIM0i3a8sF1LO29IANI9EIZV02TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuFIFVj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuFIFVj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73051F00A3A;
	Sun,  6 Sep 2026 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660800;
	bh=OjytOf3nF9EdMHYSeMqKQ1sO95/70Q5e02h1HYHGUDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuFIFVj2PgVoBvmKR6dJYgb2KaY1qVF9gWX/EjiDQM3IzlPgMj7Y+4A4FRCB5a7yB
	 qKScq27gHW0tZtvu9NwaHgR6tsIiJlAp7kmUP6x1RKeHyIXbcWfKcjiGJm2Z2NX3Xw
	 kraDgkGFefQaiFItJrt90TcRe1DCWaoJHNA+yTey2zajYDBNeo2gimwNGKVSD+qF1r
	 yyM2KrwBV2u08MfWle0j/j41E6u78Se3wwyBNeKWknXyBxEIhRhza2JAz3YuhCfkPa
	 lKxXppHk9k2rxcXrNWUHmfc6Jxmwq+iKu21pehuEOPxNsQbiCvBdKeBKHpCwZ/dBO1
	 k2r1L2p9VWMTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Sat,  5 Sep 2026 22:13:16 -0400
Message-ID: <20260906021317.760487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-immorally-carried-7c28@gregkh>
References: <2026090321-immorally-carried-7c28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 4183cf383b6faec17a0882b84cd2d901dba62b16 ]

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for COPY operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[ Stable adaptation: Linux 6.12 does not contain the Fixes commit or
nfsd_update_cmtime_attr(), so omit the timestamp-update call sites. Keep the
attr_update context needed by d0beaee498e1 ("nfsd: fix stale s2s_cp_stateids
IDR entry for async COPY"), and alias its newer error label to the existing
6.12 cleanup path. ]

Stable-dep-of: d0beaee498e1 ("nfsd: fix stale s2s_cp_stateids IDR entry for async COPY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 8 ++++++--
 fs/nfsd/xdr4.h     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d29a37f696a44..26e3540f5e1d8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1798,12 +1798,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
-			goto out_err;
+			goto out_dec_async_copy_err;
 		if (!nfs4_init_copy_state(nn, copy))
-			goto out_err;
+			goto out_dec_async_copy_err;
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0)
+			async_copy->attr_update = true;
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
@@ -1821,6 +1824,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	release_copy_files(copy);
 	return status;
+out_dec_async_copy_err:
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c2765619edd4e..0e88d2dfa5214 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -598,6 +598,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	bool			attr_update;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.53.0

