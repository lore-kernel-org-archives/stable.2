Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07D2253EE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221140; cv=none; b=Pyyv7Ld9V+9O7vW3HD2dyZknPyYlnp7TAlTqsrPfc71lUTLrACUmmlBL9agemNrNwmPz9douu8B1ix1iw2JSeXfX+kHkjGesnXIZ+e153L6iAzrWQBhZH7Lr23gxj87q853Xfiww1M9AqC2yjmWN49zEnNbaI1VQBJ1FGOsMwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221140; c=relaxed/simple;
	bh=5Ny+TgUx2FKK+awaK3ARZzCU4kU0+3mi7OPclkk2VBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaQ8ZXvgu5pz/YCaCFORjB92VsUyUI9hfj0opbnuaPMHa9I+EiJd512w6yz3WvSmYwA9ClHpSfzF17zh7swJr5GOC3SSPCJvPfAWH/YoZzqYC1FIaIhPFE//AVfidT5OVYijNTV7Qt12zJZv6wJv586G0lvxOdhzsJDbh9EETgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKT0zAGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKT0zAGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA7A1F000E9;
	Sun,  5 Jul 2026 03:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221139;
	bh=QTSX5H6BbeWQYDL84sGSBTq4+wc8SmW0GAEQYcaQKnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKT0zAGcLHWMYBryP0fJrjDsWlP01x2Zsoe7IH9uqY/YYe9SpBd/2WMigmGyEQonF
	 L+FgeZTGNDHcBEIP6XyxPxJ4XwaFHd2Q+/1lcL3/PyDZk2EeaYDLjp7TTEFjkeyP8a
	 4NYJ6k4fdtBQ+asYWp4OFTabrCZU90GZM0c6CQLRAlGL6p91/+w7hfpjkt7tuaaRJ2
	 W+i0uViSyOnSQkN5g9t6+nTSXpD6Kq6R/lpQzhHjTjT1vZZ3qb9EE5SQx20z5O9Bl6
	 oBkFacjupXVIICWIZ8Zwuco22OkUIV+aRT3/CdiVD7CvMr2amVcXWP91gzitnaL7t4
	 MOiOwSXRpWNyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] nfsd: release layout stid on setlease failure
Date: Sat,  4 Jul 2026 23:12:17 -0400
Message-ID: <20260705031217.1602142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070225-wipe-antler-1b0c@gregkh>
References: <2026070225-wipe-antler-1b0c@gregkh>
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
index 683bd1130afe29..62762e43f810b3 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -256,9 +256,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
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

