Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B21496919
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000466; cv=none; b=g6b6nggrnvCpC2oePs4xn4aYq3GrSL1e0UPq/W3PUkKtt1p0BPXRkfAzhpOBTkwdMv5uoqEan0suXu7c4deX1V7H0SHfNHthevruL+pNKEmbizGLMJbcL3LO+bwLT23XYUyq6Shs7clXCyGk10gcOjPT8c7RQdip895iCO309jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000466; c=relaxed/simple;
	bh=WwHv25BLgPGAnZVf8WltlnBnyLqauDDRakXUiffHpIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FQFVKNWUJbZyuJYg042Jfnl34nSfpMNxRIuYK3NM8ciXV5W/lIkc3prHKtmOU5EYHtysc6Sf8Djr7hqGnHdaGoZXZGruwFKnWgMFIy7iKY0onxx3F3TpFFse/UrQkSmztu5UB/fXNGMjdFuQwmszlbhHkE6siDYfF2d3Wv8L0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djp0vOgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djp0vOgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C871F000E9;
	Thu,  2 Jul 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000465;
	bh=aZYEMAVoPgVKr0Hq9Z/fCghQFfMjX9a1LN6+/7PfxDk=;
	h=Subject:To:Cc:From:Date;
	b=djp0vOgmR3+h5QXMw9MKLZxsb8TX+KcdBgqHi+60VIVyzscOJp3pQxHaFvgQstIBT
	 zyIHhVWBVyxn6IPmJGCjBp3IPBgSxQX65HUATmiamvqXu6BR85Ja4G6DtIlocL8Vk0
	 mfihwt8vKWj+XNURGaKi+MdJ7C032dIeOlO+IObI=
Subject: FAILED: patch "[PATCH] nfsd: release layout stid on setlease failure" failed to apply to 5.15-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:54:28 +0200
Message-ID: <2026070228-deny-tattered-d0df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 30d55c8aabb261bc3f427d6b9aae7ef6206063f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070228-deny-tattered-d0df@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Mon, 18 May 2026 13:16:36 -0700
Subject: [PATCH] nfsd: release layout stid on setlease failure

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

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index c550b83f4432..f34320e4c2f4 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -253,10 +253,12 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 		ls->ls_file = find_any_file(fp);
 	BUG_ON(!ls->ls_file);
 
+	ls->ls_fenced = false;
+	ls->ls_fence_delay = 0;
+	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
+
 	if (nfsd4_layout_setlease(ls)) {
-		nfsd_file_put(ls->ls_file);
-		put_nfs4_file(fp);
-		kmem_cache_free(nfs4_layout_stateid_cache, ls);
+		nfs4_put_stid(stp);
 		return NULL;
 	}
 
@@ -269,10 +271,6 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
-	ls->ls_fenced = false;
-	ls->ls_fence_delay = 0;
-	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
-
 	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }

