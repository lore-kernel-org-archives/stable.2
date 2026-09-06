Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3967361967
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660827; cv=none; b=dkeAl7Wb0iZpSjD9x671AAgctBmfw7kFfotOdMCybtrWc2I35OeUWFngOLh0vHbvsA36ipMDcHYOMU/PYOwJ4U9Nqlj0xjrhKm4Sb6owDzbMQYmPjWtQ7uGxk6OYiKDkkWGZ6JOWzRg1P5+jEO3ROEJzVsj1wMwOnmCIPIGALxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660827; c=relaxed/simple;
	bh=Ol94YgtARD9ZILk1Pe8XcXSiD7ribSK+7YMJylNNyfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8GZjHEMhPoJHmm5g9v1MuU1wrPGP5hY6EAyIGxCX5gPIapg68KvnFWf+wfcEnn5n62mVEBmqYcBRugRNG+Fb/S+J6VZ11rlGAW+2ywnM41nkQwvx4KhYW8oEn5SbWyekTL/rGLKtzsK5/5UC2OqgMxO68u1pYHITH09fT8UzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d13N2QTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d13N2QTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68101F00A3E;
	Sun,  6 Sep 2026 02:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660801;
	bh=aAAOH8Dwp3705EwFG2oGlUbq7oZ9CjBRktwVriG7Cfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d13N2QTXLMuNYQCHTEWaAhl11JPdKmteX55cl9sBkQqoejTvIqs9DYmxLSfauKwUv
	 ZLz8YiZwy/GPBxAQy+/MfjcZ++P2WsFkuz8vdW3XPNrsRqNPmJBEFoK4XJzYRYhFa3
	 gkCBMaD8Js910HJX5jmJsuR1+EwRjFBLaNaBJQv1QDwqOv87VirYv+5QmeSSbE5hlY
	 c7GAUFunLxcp4UIT7V2aDCAp/+ul56l+XofQOKZV500TyHqjLrasdtJtAYwij8gMca
	 AX4Q538RJ5tAPExZsOCy5I3G+e4//S1h2rhzaAl0drtOamSDgFqArQVAMBbZo8D6sX
	 c6VF5TiKdYmpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Date: Sat,  5 Sep 2026 22:13:17 -0400
Message-ID: <20260906021317.760487-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906021317.760487-1-sashal@kernel.org>
References: <2026090321-immorally-carried-7c28@gregkh>
 <20260906021317.760487-1-sashal@kernel.org>
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
index 26e3540f5e1d8..8e0e8a5370d70 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1799,11 +1799,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

