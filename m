Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C3283CAF
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701305; cv=none; b=b6zSeoSR3IqS/XIi0srnsq6dMFEIWNZWAQYi6xto4X6P3dytZb/9Y27NA436l4OcSghcNNrUc6sBnBRLBmqaj4sadxAcqpfqTgyfO8Fi2YhCgY5mVTX5/d7FWYviXllc1tUZQ7zq87VDVGoAQgz2stL/JHmhHgMLfQcAQ9nLCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701305; c=relaxed/simple;
	bh=VhAD+zfTHbG3MrivcI61xxjXmCvCDe2aaERR9L0lSPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+WF3kx5eiIbD7tdyPyqXlJeVTBnkuXicyMpLfR+hgtpRlUGR4ptJJ3KCeZ0yN9St+2+ktKs/MoEz/QfGJPDG1rRQfZ3qeclWBVPtqd/+j0fYV2SlJQVP+mBt3OiKwI2WjUVD6mrgIOclquXmkXQXjign/N9/4gpkND1/7Gpc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuSY/JQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuSY/JQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE081F00A3D;
	Sun,  6 Sep 2026 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701303;
	bh=IptYkcaAdjthhxEaFZZzxM8kOyVEnKSrWbYkBv6yuPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuSY/JQOU5MZhxmKrE+XvMnrqA4fANCMAICz76XoZx9Ge5OzyXFiaClhUDpZ2FP57
	 y3luDCHP9RRyPT/jDYbCv2AcGOS38KN61eDzR/Xhb7NtaMzEtWsYntc3G3zYHQa1R3
	 NF49zl854eQPhOJ+hZEqxqpQ5JCvMiwOCwyq6kzlicdS2ah521maIQ90/J2RzlbXhP
	 LmrYl9jZv6Q9UTnIkxw6UgtWj4gD4FI0XlQWBsuwGYkSxdsudFbfqdxyCdtN7OXTx0
	 uBilenFw0jo/5Y7vdyYSS4l0roHQQt1DB5qnA5HrPPGnhjbdIAP6dfRQz2FX+tRvK2
	 KRQCu2oO597RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Date: Sun,  6 Sep 2026 09:28:20 -0400
Message-ID: <20260906132820.873037-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132820.873037-1-sashal@kernel.org>
References: <2026090321-unblock-fondling-c1c2@gregkh>
 <20260906132820.873037-1-sashal@kernel.org>
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
index 2a397ad23077d..31a475dc62e87 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1800,11 +1800,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

