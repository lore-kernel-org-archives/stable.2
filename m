Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039B345EC6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638720; cv=none; b=K7s7VSwMKmutsnqvUACeTNw4GE8erlO6l356Ink246FwaxbxaIk6vScghlHvg/Gt1SrE7oGwDltgwJJZMnihd+naPqpCggSRY3pXoPhg9BRDxg+F2ETmj5UoqgdkasCV1ED6QZZ94Vra4JhNGOYq6MGw8Avgaohe4AgNdcwJ87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638720; c=relaxed/simple;
	bh=+8sy0ZbbEAYEXNtUOX77uK7rLxBFOagqt3+NknBOJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPFLSIh+AbTvr5NyM8nGQ+csJKe/7wjzVLXs0fjMI0oA15q0HQr7TC7Vjf2f7CoIkOCTXQzmxOdkPZJOQm4yMg87/wTzMzWLYkf4fGZyEwjAiSY5aVl9bFN1iNPX1xb6dtlmlerXbISnJjDqQHLyI8iyl2+jvuQPywUlufF08Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRutFMrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRutFMrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4DA1F00A3A;
	Sat,  5 Sep 2026 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638719;
	bh=nWDjCD5jfcjwXVG+DAwjNIxYy1Z6ZD3UaG/vkyga34M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRutFMrUoxZKyFxfVyy1bR0mr0glDyWh8N7ABjsbPk4m/MbNaGf5fZFFpoy1AtpO7
	 s9vq5XogAJR6MWShAen3QLtzT678ogLYIJppnXgNIDjZST3PxJcxNLAFLs/RmFhUeJ
	 O7kP3klUMyrPZmNtAOeDXn5Rjmrd7Ss/JoT+qyrw4pm+gVwTpAJ5y4K9KpeMGnqpcs
	 R9iOEiHCyO2Wt/e6+77boll4NwemDSh/oaEWDq46U1JWwykJFyu4ZvDipQibIqXcsx
	 G82aJHgg/mQ1XS1Fq8/CqfYWhYn5BOGVUCVQMiabHspp7XxGPPzDxeATBk1fW4RCj0
	 Icfp6I8SfjL+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Sat,  5 Sep 2026 16:05:16 -0400
Message-ID: <20260905200517.607056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-purple-stiffness-b344@gregkh>
References: <2026090320-purple-stiffness-b344@gregkh>
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
index 2c7a8943cad9c..ee67978996293 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1853,12 +1853,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -1877,6 +1880,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_copy_done(copy, status);
 	release_copy_files(copy);
 	return status;
+out_dec_async_copy_err:
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c75b295df206a..1f62c3755988c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -736,6 +736,7 @@ struct nfsd4_copy {
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
+	bool			attr_update;
 
 	copy_stateid_t		cp_stateid;
 
-- 
2.53.0

