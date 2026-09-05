Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE03644A0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638721; cv=none; b=HRAPAOJns7WHBcjdutUGl5BK3AL8FethHkjw7k8qP9KlMSbm5H6bjHRhkClwhZPpA/L0dCoebmQJa1ozobL1z+Duq/WKPAgsIhCFJWnCxt3PsgO8VIBXY4hPchA75amIDml793q8ZkqsVV80CZtV1d4EFds4jce2bGJj3BObOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638721; c=relaxed/simple;
	bh=2uvuErZQ2meuRx1dJ7atnDAEUrZhCHS+O0WWDfpECOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzKkHUq59/7AFiD8A8ZLgJgAVXxkiPjfgLRcl3LKa3dqv2hqVn3lDD7O8mcIgRLYw3Ztjj2XZOjpEHCAcdXo9LWdwnqJ9oXNwy2uSm//2irtCH0RQrkGrh3pQfoGoRYaKHIih6gg+6fCVbe6h1GBD6g8F5pJyzTwG4PsyXLjJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYJszQe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYJszQe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B061F00A3E;
	Sat,  5 Sep 2026 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638720;
	bh=/aF9lDhDb3DFJ73Wlata1W2FzBb6J+GTo0d/benturE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYJszQe7z+g+sSdCg4wzPjPYj/XS4mvFa8e7+LwEi36FcnrTk9umWH6r89OkberTN
	 5etJMeh6Q7JexszQnRl/5q/fznakToqVV1uHIyIuVU14IeYmR2B01bKm9jsS3sm4CP
	 T72fTox/IXNV30d4sLs9j37xUbsyy1x+4CC9ZhALRY/1apwW16wQUL9vaXorRq/FZH
	 VBzfD3SsZwdmDjBWtBJCR9O9WBdyonj4jgJ6v9SBAfhWbsSU16bOLUXCStTokiMAoi
	 Nbh6+eykgJ0yvOJ3TTMFIScZX11yGCUQjQOFtlpdxhegbFxMG7he3QO6Cj4iQL5wYG
	 yuw3MSp7pr4HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Date: Sat,  5 Sep 2026 16:05:17 -0400
Message-ID: <20260905200517.607056-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905200517.607056-1-sashal@kernel.org>
References: <2026090320-purple-stiffness-b344@gregkh>
 <20260905200517.607056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d0beaee498e11880e72826026db0e9c9890fc114 ]

For an async COPY, nfsd4_copy() called nfs4_init_copy_state() before
dup_copy_fields(), so the s2s_cp_stateids IDR was pointed at
&u->copy->cp_stateid -- memory in the per-rqstp COMPOUND buffer that is
reused by the next request. dup_copy_fields() copies only the value into
async_copy, so the IDR slot dangled at the transient buffer for the whole
background copy. Any IDR walker then dereferences reused request memory:
the laundromat reads cs_type from it and, if the bytes look like an
expired NFS4_COPYNOTIFY_STID, follows into
refcount_dec()/idr_remove()/kfree() on garbage; manage_cpntf_state() has
the same exposure via idr_find().

Duplicate the fields first, then register the stateid on the stable
async_copy. result->cb_stateid is unchanged.

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260710-nfsd-testing-v3-3-a0ff7db6aa3e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ee67978996293..d4b47f43b07d8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1854,11 +1854,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_dec_async_copy_err;
-		if (!nfs4_init_copy_state(nn, copy))
+		dup_copy_fields(copy, async_copy);
+
+		if (!nfs4_init_copy_state(nn, async_copy))
 			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
-		dup_copy_fields(copy, async_copy);
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;
-- 
2.53.0

