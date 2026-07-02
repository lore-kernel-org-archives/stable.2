Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91824A2E01
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000473; cv=none; b=f4rIE7X1G5S0djgoK5yzS+J189uaxqwU8VSgO4JgLCgdfgw1oOT7TZBiH4hw7dpc5Vlv7j3I2+TfrKJtX/pRt7xE7llvl+9UVNVRWm9qmjBbbTYG2e3VvvKY/tV7d//hWrZverTzTvbh71vz9HdAs8QXXxj2VLGBb//RsGbXxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000473; c=relaxed/simple;
	bh=dqCGtL68kHeqJR8hBuuHiv5dtaO+q0imOeXf7L1VrSk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JW0KKbmfjooGGXBTHkH6hjS/hv/sGykuqTuNsFcXCBCHrWNaZyINNbn2eipKEHeXzbDacFgSvDQY2loRS3OcRJOyfzFz77cweMpV8Z70Gqh0UFJ7V/v6Mj2bmbFZki9jKAWg72KgKShm/IIv26Lc376iZJ+JuqIjltDRnZyf4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqL6I1Q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqL6I1Q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF21F000E9;
	Thu,  2 Jul 2026 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000471;
	bh=SYy2YaTCKLX/BLGFGj6H0IZAFUCoawN0+W0FgnYwERA=;
	h=Subject:To:Cc:From:Date;
	b=rqL6I1Q0S8HpYuXnXFbDiwhXxHGC9Dnjt/0tQ4SIgBIiaanCZHr0dBAuL5IPsqpfh
	 OgHMO82y9B1nidSyOYykdIc8PazIwRHdgLwgJ+cOmEIgmLuzzmIhhZUkMw+774a04o
	 zSMsloZw+rhyc0n1qHgkZUNV0ned0meHVD4Ft5Es=
Subject: FAILED: patch "[PATCH] nfsd: release layout stid on setlease failure" failed to apply to 5.10-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:54:28 +0200
Message-ID: <2026070228-repeater-synthesis-1c1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 30d55c8aabb261bc3f427d6b9aae7ef6206063f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070228-repeater-synthesis-1c1b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

