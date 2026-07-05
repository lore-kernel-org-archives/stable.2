Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EB380FEC
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260553; cv=none; b=Qmy38Z4vUXN6sHKxqbLsXXr+D1I65kgE2BcIxESvkY9MyJeolGTEAVOxiRqdX5iOL5H7xmRoqs6LBC3TILOW9W/aMr6bSQRLyubFjGgrp/SVs64cp4nidM32A0/UihTKqZ5iMClUEKUKxC/enx5a6Pk7PNvndptXg4ylqgEFPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260553; c=relaxed/simple;
	bh=S+rrsUzf6P0YHXXWy04c5yHty/dZKXCPKQHc/j247zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYxMOIb05qjj1SI45IuOxOhTs7q836pMU/NedkVgrBVVFKTuxP6ccR5D4IUkHk42tbVbDIg+pNviRanV+mR81CnpFYhuLFlIzxvU3OarPihEdQV37MVB0miJRKIaE02DlZtclpnqkOEKHuYh90ahClNZdx8NGQBdxBX7mqc8gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3nyqdsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3nyqdsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B6C1F00A3A;
	Sun,  5 Jul 2026 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260552;
	bh=D/y6/A8zI7c8WvI2qHn8E97UgjcJoBwmvIBVLslIFiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3nyqdsW9xmboUfFxgsh+YidkizedQRT38zkyyGD62UfilljGYYsC+tjxM177abEB
	 mtLjbVngWBe+hfWlAFZdsBwSFtsG5ZBbnGs4MExV1dEnMmK4MOAhSZcAUbCloWPsZr
	 NeTCtnOZIyrGu1OhfIx5YdbauUSt6j8WByYw8HKsLDvN64XS0Lu9vjd8Mkyfy5Rmbb
	 UId1WrW4V0O37FgryEi7fhlup9VXqfEXiBdcrNDuprZMJ2uQWKXZQNydobzE0GUN9o
	 cLhSHcv9a5MpMyublx8QG/UkSy4UFI6mFnIrDHZwoLKeeIos9IzrpRMqfsPWw0jOf/
	 FjRzlP6PhlaUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: release layout stid on setlease failure
Date: Sun,  5 Jul 2026 10:09:09 -0400
Message-ID: <20260705140909.1776897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070227-aftermath-okay-f7fa@gregkh>
References: <2026070227-aftermath-okay-f7fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 ]

nfs4_alloc_stid() publishes the new stid into cl->cl_stateids via
idr_alloc_cyclic() under cl_lock before returning to
nfsd4_alloc_layout_stateid(). When nfsd4_layout_setlease() then
fails, the error path frees the layout stateid directly with
kmem_cache_free() without ever calling idr_remove(), leaving the
IDR slot pointing at freed slab memory. Any subsequent IDR walker
(states_show, client teardown) dereferences the dangling pointer.

The correct teardown for an IDR-published stid is nfs4_put_stid(),
which removes the IDR slot under cl_lock, dispatches sc_free
(nfsd4_free_layout_stateid) to release ls->ls_file via
nfsd4_close_layout(), and drops the nfs4_file reference in its
tail.

A second issue blocks that switch: nfsd4_free_layout_stateid()
unconditionally inspects ls->ls_fence_work via
delayed_work_pending() under ls_lock, but
INIT_DELAYED_WORK(&ls->ls_fence_work, ...) currently runs only
after the setlease call. On the setlease-failure path the
destructor would touch an uninitialized delayed_work.

    nfsd4_alloc_layout_stateid()
      nfs4_alloc_stid()           /* idr_alloc_cyclic under cl_lock */
      nfsd4_layout_setlease()     /* fails */
        nfs4_put_stid()
          nfsd4_free_layout_stateid()
            delayed_work_pending(&ls->ls_fence_work)  /* needs INIT */
            nfsd4_close_layout()  /* nfsd_file_put(ls->ls_file) */
          put_nfs4_file()

Fix by hoisting the ls_fenced / ls_fence_delay / INIT_DELAYED_WORK
initialization above the nfsd4_layout_setlease() call, and replace
the manual nfsd_file_put + put_nfs4_file + kmem_cache_free cleanup
with a single nfs4_put_stid(stp).

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Cc: stable@vger.kernel.org
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 308214378fd352..84bb200e24adea 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -242,9 +242,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	BUG_ON(!ls->ls_file);
 
 	if (nfsd4_layout_setlease(ls)) {
-		nfsd_file_put(ls->ls_file);
-		put_nfs4_file(fp);
-		kmem_cache_free(nfs4_layout_stateid_cache, ls);
+		nfs4_put_stid(stp);
 		return NULL;
 	}
 
-- 
2.53.0

