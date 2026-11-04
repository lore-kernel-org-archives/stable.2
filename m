Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802066;
	b=vdRWl3nogha0f/So4nP8xvIsyDlOa7KgpTc5crVwJgPtKmIjHf/R5teCxesnryQeInvv
	 1K5iiGHdNBsl+NDDFLI44dcfs2cUUc3boR9+L4zLhs+hZS8isAirJUGrznaixsaaXdWmA
	 xozF0CWZBJFC2rLgeW7S2uSnZZ3GShKyiEXSGHXSwGzVRa4p8GUq+qggPEhyI7HYr6Shx
	 qlU+eIhDX55p0w5Jgozr1M52DOlbG2Ywqmrgzifu9GZZ1KE8Q9dGZtd68vV1rrlQhNJWN
	 54v0cJoPht4rVy4Qs6B9SWErIWsPOoJZnyb9mjgxayWEddXgtIeVShxwVdQjzcgTP6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802066;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lJ6kgg9JNMYMQ23CLwPjn3Q4F/tBNrJKWc+LXtsQXlI=;
	b=amCUeRQzQ6PjtbNvqWVzFCmtPXOcdGCu0cZ9rLUjOD4sHvc+bA8ZdISS/CDUvM1B/b3J
	 uC3VA/wAUeWvDChBqHBoYwwySmlNcd041ORwYAR6/eFjCddDpQoS5z/W0uN392GMJHOfM
	 cwhAuH288KJ5m1ewuZ6cLrkSVh8SJr+j7xd4hixhf7Tzp1h+TsqlvGunhGgm4dDBN6yVS
	 n4E0HGugDy1rZpV7FtTIBbuSrd7it24XwXOw7O3q5XemiPhwReUM95ZAt7vrkbwXe/Vdn
	 CdgMbm/vroxGj1Nv/YPCWtMZry4aag31/Am5IRrwngI4kBHwas5NXolwl+9DbTkPfvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ckCEmnzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF845606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ckCEmnzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECB1F000C1;
	Wed,  4 Nov 2026 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802065;
	bh=lJ6kgg9JNMYMQ23CLwPjn3Q4F/tBNrJKWc+LXtsQXlI=;
	h=Subject:To:Cc:From:Date;
	b=ckCEmnzs7tSs6h6uV4kUtUyo5s6hCPQNrXYFuZlM/h+7hxHwM59nFZYQvpMM0r92l
	 qED9niediL+L9BugHwYU6qO22kREGelDIiu3xEn3CHKZJnhF/UPN3yX63KjwPyaa8r
	 LdAEihE/VTqZDA3I8jEflYSIAx5vHbB5PuGu9MmY=
Subject: FAILED: patch "[PATCH] xen-blkfront: unbind irq before tearing down ring and shadow" failed to apply to 5.10-stable tree
To: ndaugoing@gmail.com,jgross@suse.com,roger@xenproject.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:21:03 +0100
Message-ID: <2026110403-viper-verify-b61d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f3e27b7955727a4d7c0e9264a2a209fbba788bdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110403-viper-verify-b61d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3e27b7955727a4d7c0e9264a2a209fbba788bdc Mon Sep 17 00:00:00 2001
From: Yuchao Zhang <ndaugoing@gmail.com>
Date: Tue, 22 Sep 2026 15:21:55 +0800
Subject: [PATCH] xen-blkfront: unbind irq before tearing down ring and shadow
 requests
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 11659569f720 ("xen/blkfront: split per device io_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260922072155.34625-1-ndaugoing@gmail.com>

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..86f5dd3aced1 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1210,6 +1210,14 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	/*
+	 * Interrupt teardown must be done ahead of freeing queue-related
+	 * data, otherwise the interrupt handler can race with the cleanup.
+	 */
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1292,10 +1300,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	/* Free resources associated with old device channel. */
 	xenbus_teardown_ring((void **)&rinfo->ring.sring, info->nr_ring_pages,
 			     rinfo->ring_ref);
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)

