Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601648;
	b=nW4ZNuwUPfhZ55oeT9s7W1SvY12wqlzNNnCDrHzBe9r0rafDosM+DJKSvYNzrWAXQTBB
	 8Tg25Ln4gb14eXQgBsHDVQg/QZ4eH24YfXrHXnFfAfhVvXd+A2jhKHmHjUTTe5DJZ7IPK
	 Tp80exL8zihZPfTw7ROXo9/iH+n7pBMEfYvBQjelq0P/Uk1vrXew3LCvqDOAY+lpjsc0d
	 XjK4k4oCq8Am9xXaHNxVotPcGm3FJCwSXq36pxY9p0u8r6XutZzZmctf9Yn4dwfuO5XhF
	 e/h3/U6SOF2t4f1wO62FPd/13aqrM+/1BlVx0Mme5jJlCt2K0ypluaiIS4QRUNmrFKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601648;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sZBhQ3SppDixQiwyPMqGdmT24bfk2fDmr5Ymd3hDDcg=;
	b=CXinfhlPLOZI22QP3WkFzo8x39hfBAFHI5OlhQXoOAxL/wpMtNOfHvZd25oKQciwEIJO
	 Rq5AnTgq9fqQTprg0Ifb8OgX1q/a1gzh8g6pi3NyBpOJju62iD3FzEZjDMZQ8rTEmQn4F
	 R98ThexfzPuyfodRIc6X6XXfOUULvQwnslSZO9O8LS/8jRwXpoCsqFNCYY7aO7rF7gqXO
	 uTqabqeiHBCukvoE4JhkkVIm24NhBZ4dQA3B73M0DUjSdiVkZUTLzL/0nheX1UaI9KQSA
	 WWcg16WG3kqO5hLuQeaniOrxFKAJNHC9vClj7N1xatqig6+sjktYvWH45mx4NqSw3OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RoCMVXVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B558606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RoCMVXVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDF21F000C4;
	Wed, 25 Nov 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601647;
	bh=sZBhQ3SppDixQiwyPMqGdmT24bfk2fDmr5Ymd3hDDcg=;
	h=Subject:To:Cc:From:Date;
	b=RoCMVXVrhM4MYZdl/40px2edmwk7Mhndvshp0dyCPrfQRg2KooyyMomX+ZpVbujMG
	 RROYqNR+5EdJNMDE5mwMotnYq2KqO0iM7fOAFamDsNo5wtTd09fXkmdjlnQ4B5OuZv
	 0FkyL69yJEkBummi91lFJB7FEAFOZwhCrGHd3Zoc=
Subject: FAILED: patch "[PATCH] pNFS: avoid repeatedly cancelling I/O for the same lseg" failed to apply to 6.12-stable tree
To: tmenninger@everpuredata.com,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:11:58 +0100
Message-ID: <2026112558-afoot-retread-cd75@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 9e28836b480c66cca4c3d391177f5b3a50927f7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112558-afoot-retread-cd75@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e28836b480c66cca4c3d391177f5b3a50927f7d Mon Sep 17 00:00:00 2001
From: Tim Menninger <tmenninger@everpuredata.com>
Date: Thu, 5 Nov 2026 00:01:31 +0000
Subject: [PATCH] pNFS: avoid repeatedly cancelling I/O for the same lseg

Commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is
recalled or revoked") added I/O cancellation when a layout segment is
invalidated while outstanding references remain.

The invalid segment stays on the layout's segment list until those
references drain. Subsequent scans can find it again and repeatedly
invoke the layout driver's cancel_io() callback. For flexfiles, this
cancels matching RPC tasks and disconnects data server RPC clients.
During RPC/RDMA data server recovery, repeated cancellation can cause a
reconnect loop that consumes essentially all client CPU and prevents
forward progress.

Record cancellation requests per mirror stripe in the flexfiles layout
segment. Each stripe is cancelled at most once, regardless of how many
times the invalid segment is encountered. A per-stripe bitmap rather
than a single per-segment bit preserves the ability to cancel I/O to a
different device after an earlier device-specific cancellation.

Cancellation is best-effort. An RPC that has already passed the
layout-validity check may not yet be visible to the cancellation
scan. Such I/O retains its lseg reference and remains subject to
the normal RPC completion and recovery paths. Suppress repeated
cancellation and disconnect requests without changing the existing
lseg lifetime and deferred layout-return accounting.

This reproduced on 6.8.0, 7.0.0, and 7.4.0-rc1. It was tested on
7.4.0-rc1 with sustained pNFS/flexfiles I/O over RPC/RDMA while
restarting the NFS service on a data server. Without it, repeated
cancellation led to a reconnect loop and no workload recovery. With it,
the client recovered after the data server returned.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9492d6bc1d1a..4419ded8fe58 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/bitmap.h>
 #include <linux/file.h>
 #include <linux/sched/mm.h>
 
@@ -340,6 +341,7 @@ static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
 		ff_layout_free_mirror_array(fls);
+		bitmap_free(fls->cancelled_stripes);
 		kfree(fls);
 	}
 }
@@ -653,6 +655,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		fls->mirror_array[i]->report_interval = be32_to_cpup(p);
 
 out_sort_mirrors:
+	fls->cancelled_stripes = bitmap_zalloc(
+		fls->mirror_array_cnt * dss_count, gfp_flags);
+	if (!fls->cancelled_stripes) {
+		rc = -ENOMEM;
+		goto out_err_free;
+	}
 	ff_layout_sort_mirrors(fls);
 	ret = &fls->generic_hdr;
 	dprintk("<-- %s (success)\n", __func__);
@@ -2582,6 +2590,10 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg,
 			if (devid && memcmp(&mirror->dss[dss_id].devid, devid,
 					    sizeof(*devid)) != 0)
 				continue;
+			/* Do not cancel a stripe again while this lseg drains. */
+			if (test_and_set_bit(idx * mirror->dss_count + dss_id,
+					     flseg->cancelled_stripes))
+				continue;
 			rcu_read_lock();
 			mirror_ds = rcu_dereference(mirror->dss[dss_id].mirror_ds);
 			if (IS_ERR_OR_NULL(mirror_ds) ||
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 09c3cd6964fd..5d5587fded76 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -109,6 +109,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
+	unsigned long			*cancelled_stripes;
 	struct nfs4_ff_layout_mirror	*mirror_array[] __counted_by(mirror_array_cnt);
 };
 

