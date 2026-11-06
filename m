Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989498;
	b=ajeGOQQm05g298+HyrfP2QGI5aCnxkfLKh3SEqnFzjtNpS92P2zKNjyDK43bqzanCrdJ
	 w8zAyvtMHZVkrnw2otrWFhVSriveWzdCObZla3xia3ClWJONhmcoh+lEs02AWVJVJRf69
	 fELseP279qENwh3xFVn6KlYqTQ2RSWs1SHhCLl/l1ibWlewoJGCfT9lOJ+O9a/v7qHtNI
	 I0hlCDmIEcOit/+Hnq3QHMtheeeb6g+7fUlIZKOqUcyWNNzQEHw4sa9LQGOpYHpwUTjyE
	 lWqjZ/qkFYq95qChMh/CLoH8/hRM7VGSmwNV3f61nTrlf/AQDNhTRrU4sBGYDxIvdcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VSQl2dQwPs11p7ItZohLUQDXTTSNLnJbRIO+PA7NW4U=;
	b=NHY99aWfluXsA65Wu1oJn9SnhznbnC0FYqFgeFk5brgR3aACjVTUKYF+HLXVlHGWPD4Z
	 djIdVvpVSQ0y1bk6v9xUcXM7H6WoZTaDGMOlWo4v+yNTB4Dlut/BNuCewZi5czR5K3q7v
	 XOV0n1MLdzdjXjKa4dW2hn90yWwOBOTJOvDLl1WReA1z87MLp+La3NVveDwK9qldSR/ie
	 kY1wg9M5tiRBu5/1VMogYts2kLgaAlOz18TMwp3fvc+cfwXRe91pXM0yOrWv86Jz2NU3q
	 c94sHkgNoaMFC/gXR+owKF3JiJwPVqHgKykZDJmcKqMV0KZl1MkdeaQ1aXcDh9mUtlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D4rU93fv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9735606A32F;
	Fri,  6 Nov 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D4rU93fv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2841F008A3;
	Fri,  6 Nov 2026 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989497;
	bh=VSQl2dQwPs11p7ItZohLUQDXTTSNLnJbRIO+PA7NW4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4rU93fv1FVrgbltRVACCsUPiQsoGA0F768UbEmqZUSHewVGn0JuxyyM7YhjPZN5a
	 OzvOle7cBOQCn7wbnJ60OzoGHSMSNoKvVm64gGfRYxdYa/zBrkMJEB/jnvumMnP/J+
	 4HJ4hIn+k8N6T8cLEEgV/OQVxtJ3KdQJfgKVh38g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.274
Date: Fri,  6 Nov 2026 13:24:50 -0500
Message-ID: <2026110650-daybreak-punisher-c964@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110650-various-fantastic-2eef@gregkh>
References: <2026110650-various-fantastic-2eef@gregkh>
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
index 0e5cf0c2083f..73daa0bf2028 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 273
+SUBLEVEL = 274
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 5eff34767b77..e923e8cd1f04 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -318,8 +318,10 @@ struct xen_blkif {
 	unsigned int 		nr_ring_pages;
 	bool			multi_ref;
 	/* All rings for this device. */
+	rwlock_t		rings_lock;
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
+
 	unsigned long		buffer_squeeze_end;
 };
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index ddea36295931..bdfd8d4042b5 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -127,15 +127,23 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 	return;
 }
 
-static int xen_blkif_alloc_rings(struct xen_blkif *blkif)
+static int xen_blkif_alloc_rings(struct xen_blkif *blkif,
+				 unsigned int nr_rings)
 {
 	unsigned int r;
+	struct xen_blkif_ring *rings;
 
-	blkif->rings = kcalloc(blkif->nr_rings, sizeof(struct xen_blkif_ring),
-			       GFP_KERNEL);
-	if (!blkif->rings)
+	rings = kcalloc(nr_rings, sizeof(struct xen_blkif_ring), GFP_KERNEL);
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
 
@@ -175,6 +183,7 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	blkif->domid = domid;
 	atomic_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
+	rwlock_init(&blkif->rings_lock);
 
 	/*
 	 * Because freeing back to the cache may be deferred, it is not
@@ -269,6 +278,7 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	struct pending_req *req, *n;
 	unsigned int j, r;
 	bool busy = false;
+	struct xen_blkif_ring *rings;
 
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
@@ -335,10 +345,16 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
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
 
@@ -386,6 +402,7 @@ void xen_blkif_interface_fini(void)
 		unsigned int i;						\
 		unsigned long long result = 0;				\
 									\
+		read_lock(&blkif->rings_lock);				\
 		if (!blkif->rings)				\
 			goto out;					\
 									\
@@ -396,6 +413,7 @@ void xen_blkif_interface_fini(void)
 		}							\
 									\
 out:									\
+		read_unlock(&blkif->rings_lock);			\
 		return sprintf(buf, format, result);			\
 	}								\
 	static DEVICE_ATTR(name, 0444, show_##name, NULL)
@@ -1110,8 +1128,7 @@ static int connect_ring(struct backend_info *be)
 				requested_num_queues, xenblk_max_queues);
 		return -ENOSYS;
 	}
-	blkif->nr_rings = requested_num_queues;
-	if (xen_blkif_alloc_rings(blkif))
+	if (xen_blkif_alloc_rings(blkif, requested_num_queues))
 		return -ENOMEM;
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 09fc4bc0622e..18c236047408 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -811,8 +811,6 @@ void xenvif_disconnect_data(struct xenvif *vif)
 
 		xenvif_disconnect_queue(queue);
 	}
-
-	xenvif_mcast_addr_list_free(vif);
 }
 
 void xenvif_disconnect_ctrl(struct xenvif *vif)
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index c47e327039a0..1d03fe6cad9c 100644
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
