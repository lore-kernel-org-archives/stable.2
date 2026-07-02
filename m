Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711D4ADDA3
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000459; cv=none; b=fgnLP4hTB5enoEX4umt2kTdWhd9+vhTzgSD3KPGTDFZmTxrRc9eprpcZf4KXFMD0uQYRjwCy3LIqY692QsbfnhDKGm3S4W/ns9e1HFYOhZnSCKS0x2ML/wf+cFJBYR3pKJqNXhQCvLqkQGZegxeLufIROOY9c0sCc1okwKErGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000459; c=relaxed/simple;
	bh=VAoF5I1m0xKbIkEN2rItMHrU+BZX5ylcfre9Qy9lVg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IJ0Q3ROdeUj4Mrt8i0OeQGcSS2Y4+jhqtIJP2x3073gvUoSPo7g5Tx6RKI/Hr6gp5sRkBQRPUsgHTXsRt922IWUDlX9yzj5X/Ytf75tLgPmIGbBDVm1g3MHTauT6VmuFEh/Fx27ecJjgiaOrJzVoV/ah5HxelTFhfzPpagN/oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0WOKEMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0WOKEMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D831F00A3A;
	Thu,  2 Jul 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000457;
	bh=pLSN68yr0iLODpXPWCVUD9mMCbIhhPBAb8pWv8TWxv0=;
	h=Subject:To:Cc:From:Date;
	b=V0WOKEMhV74B+FnsHjRUdOBDEytuDcJHa+2HSQdK5YgHz37G/eQyMGtW3SZPRbP7k
	 fdGqVI+iUIJGmQruFPRmE3ZQcaB4hdnomJ8Pt63zeHM8b13pKIS0LW3ijxveXIPOz1
	 ZPsykQhFtcxOEzKrBgPBgo8OcL8rB/+3SNywDNos=
Subject: FAILED: patch "[PATCH] nfsd: release layout stid on setlease failure" failed to apply to 6.12-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:54:26 +0200
Message-ID: <2026070226-viral-uncouth-aba2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 30d55c8aabb261bc3f427d6b9aae7ef6206063f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070226-viral-uncouth-aba2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

