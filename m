Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989540;
	b=x1zOaGvN1twj3ByxXKP/wcZ1gUQiaK5QemlTzSNbaQYtGkYvJZj3dwqNSRloWItCZM9M
	 Sywx6NAhkYVUn3jQqGDgVlsG7gwXQfL7XwWsn4obv5mHjV65nhavZ/kBq17TjkQLVhSO2
	 DBWdjnMcaAq+/kU0icE5Hmmts2VbOLa8olJpJO0W+4yeh17GQFJGCGcM3AT9NQjG14A3F
	 qwQcyO68DWEuVx9zH/Jn+P09R7N0U69vH6HNAOZ5RjZCRlQ64k4PEjTcIEk7A0Yr45cny
	 IuQ1juDKXFGk3FC2Jm0OoTrqwnP1iahwMKNsMLhzN4OBVBSCO3FmPzlwsvMnLQ4zeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/vWl1nX3D6wi/vA2Ly07M9D4DffI2iKIWcCM1qIT0HY=;
	b=W4iTEM7AGNjJWFvpmF4/co3jtqh125QHTjFZ+LpY4Tvh1Z3FSzQjRFzCfe2Qmzpyqx3r
	 Q5SfeLajVNgINvHNHbRgHBLd8gcyW5dIFSM9v6yrdxbKavQaUbGpDy3knDGrjpM3p8vzN
	 U9o5R2L7+xMIeBYeT2bG+yGsBaft7zZfftxUv2JANYTz4G6eepr/s41rVm1Wlvla+8J0q
	 t06UERd3jJubZ7/38eJfPeL2LPi4YtRZZyvNgJkxAv4vWWLpPiZbJdyKOJEAwdSwjvoTh
	 hD7dmNOZtLtmDcRuuNYL2xV6YsmfXw088FfLoC6GQA0Evhqc6WV3SNXGW7Zf0Dr/R9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rJCzqkQy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3444606A332;
	Fri,  6 Nov 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rJCzqkQy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA691F008A5;
	Fri,  6 Nov 2026 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989539;
	bh=/vWl1nX3D6wi/vA2Ly07M9D4DffI2iKIWcCM1qIT0HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rJCzqkQyf1iKXMkhFaV3PavwX1dYMQBgn5dOcoQKj6kx5yApmgs5DBTkW5cKg887q
	 sNymQlBv0UiF51Tt17JRwHslOg6WH4FElGdJj7knB1xzuNUQ/XLmvg3G7AS9N40nZf
	 WfyV7b+E9IP2XXDL0qRjV8V2GKk1c3GnfiRGgR8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.3.3
Date: Fri,  6 Nov 2026 13:25:29 -0500
Message-ID: <2026110629-authentic-landline-8ae4@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110628-entertain-crier-14aa@gregkh>
References: <2026110628-entertain-crier-14aa@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 692cda0dfe09..a8f35bdca5d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 3
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index b427d54bc120..f5890b3f1df9 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -318,8 +318,10 @@ struct xen_blkif {
 	unsigned int		nr_ring_pages;
 	bool			multi_ref;
 	/* All rings for this device. */
+	rwlock_t		rings_lock;
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
+
 	unsigned long		buffer_squeeze_end;
 };
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 4b865ef800b1..8d0ff8fcac22 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -127,14 +127,23 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 	return;
 }
 
-static int xen_blkif_alloc_rings(struct xen_blkif *blkif)
+static int xen_blkif_alloc_rings(struct xen_blkif *blkif,
+				 unsigned int nr_rings)
 {
 	unsigned int r;
+	struct xen_blkif_ring *rings;
 
-	blkif->rings = kzalloc_objs(struct xen_blkif_ring, blkif->nr_rings);
-	if (!blkif->rings)
+	rings = kzalloc_objs(struct xen_blkif_ring, nr_rings);
+	if (!rings)
 		return -ENOMEM;
 
+	write_lock(&blkif->rings_lock);
+
+	blkif->rings = rings;
+	blkif->nr_rings = nr_rings;
+
+	write_unlock(&blkif->rings_lock);
+
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
 
@@ -174,6 +183,7 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	blkif->domid = domid;
 	atomic_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
+	rwlock_init(&blkif->rings_lock);
 
 	/*
 	 * Because freeing back to the cache may be deferred, it is not
@@ -268,6 +278,7 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	struct pending_req *req, *n;
 	unsigned int j, r;
 	bool busy = false;
+	struct xen_blkif_ring *rings;
 
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
@@ -334,10 +345,16 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	 * blkif->rings was allocated in connect_ring, so we should free it in
 	 * here.
 	 */
-	kfree(blkif->rings);
+	write_lock(&blkif->rings_lock);
+
+	rings = blkif->rings;
 	blkif->rings = NULL;
 	blkif->nr_rings = 0;
 
+	write_unlock(&blkif->rings_lock);
+
+	kfree(rings);
+
 	return 0;
 }
 
@@ -385,6 +402,7 @@ void xen_blkif_interface_fini(void)
 		unsigned int i;						\
 		unsigned long long result = 0;				\
 									\
+		read_lock(&blkif->rings_lock);				\
 		if (!blkif->rings)				\
 			goto out;					\
 									\
@@ -395,6 +413,7 @@ void xen_blkif_interface_fini(void)
 		}							\
 									\
 out:									\
+		read_unlock(&blkif->rings_lock);			\
 		return sprintf(buf, format, result);			\
 	}								\
 	static DEVICE_ATTR(name, 0444, show_##name, NULL)
@@ -1102,8 +1121,7 @@ static int connect_ring(struct backend_info *be)
 				requested_num_queues, xenblk_max_queues);
 		return -ENOSYS;
 	}
-	blkif->nr_rings = requested_num_queues;
-	if (xen_blkif_alloc_rings(blkif))
+	if (xen_blkif_alloc_rings(blkif, requested_num_queues))
 		return -ENOMEM;
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index a0a438881388..b233834ec6cc 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -812,8 +812,6 @@ void xenvif_disconnect_data(struct xenvif *vif)
 
 		xenvif_disconnect_queue(queue);
 	}
-
-	xenvif_mcast_addr_list_free(vif);
 }
 
 void xenvif_disconnect_ctrl(struct xenvif *vif)
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index e020f44ac2c7..a826fa24258b 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -267,6 +267,8 @@ static void backend_disconnect(struct backend_info *be)
 		vif->num_queues = 0;
 		synchronize_net();
 
+		xenvif_mcast_addr_list_free(vif);
+
 		for (queue_index = 0; queue_index < num_queues; ++queue_index)
 			xenvif_deinit_queue(&vif->queues[queue_index]);
 
@@ -837,6 +839,7 @@ static void connect(struct backend_info *be)
 err:
 	if (be->vif->num_queues > 0)
 		xenvif_disconnect_data(be->vif); /* Clean up existing queues */
+	synchronize_net();
 	for (queue_index = 0; queue_index < be->vif->num_queues; ++queue_index)
 		xenvif_deinit_queue(&be->vif->queues[queue_index]);
 	vfree(be->vif->queues);
