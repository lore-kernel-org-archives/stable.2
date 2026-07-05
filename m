Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B433E7A
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259279; cv=none; b=qptBk/XBU3tyG4dNgayK2jYNioOFE2sinAZPboxH08cT2idjGRk+uGROtQaTkev6oli9xip/qp0LOfMFKuq7fnPWfkdpk0o0i1l415Dd7OAO9WvB9bRuA2DnwDk5S0Pgkcbo3STyBMCyYpFu69rezGHs6fOi9HrXP+Uogib74eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259279; c=relaxed/simple;
	bh=4IMkEekQoZCqKhhohcnwnuB7xHe9RNHcuenDgh7l6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE4f94CorPzvyKVSfW1FpRL4R5p3ChLr6hsx0EykI5do6OtVbmSLEkd8JOftehX9JRzpfIHuJfNZ+e5poSX97gkHuZcqxa3ZuFn/zv7+JmkLjsKzQbti3F8Z6dH5dcQm21e+v32NaNx4cJij0TQSB56cGiIIt4HcVxqe9jf02MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv1b+wDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv1b+wDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991FA1F000E9;
	Sun,  5 Jul 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259278;
	bh=ZWOeNq9rB/UKPWo/FaJF0I/X6m5XJYPCRrh/6VZCF1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fv1b+wDisE558nUGOhUiUcuNEkyl70HUzvOjRZMUYrkDzmInQjWOfhmigNQIDx9/Z
	 skGnZcpEMMRDg0Ad+sizqcr9mxANHkUOqNYnFzx1BK4469nxpVpzq16mybjwGMqZw6
	 lV5D9vRwJm+waM5R4E5MMS/utDGVpEQ+ke/slTEvCstpF6AuiueN8oigMaYA2hPc24
	 UKE9tTsoY9RIdp5AhBhqgJdXU5dorvQn4PpjK+wURCoIQr54ei4qeQ9h+Yqfm8ISI8
	 cMQqv+8BPOpk9w25yiw9g6dLgDHBdcz+YKe6fcMnMGmmplZQ7ugzZORHpHa2Q8uH2A
	 zgYlKyEsstlqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: release layout stid on setlease failure
Date: Sun,  5 Jul 2026 09:47:56 -0400
Message-ID: <20260705134756.1722756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070226-viral-uncouth-aba2@gregkh>
References: <2026070226-viral-uncouth-aba2@gregkh>
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
index fc5e82eddaa1af..c08bc2d0d37796 100644
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

