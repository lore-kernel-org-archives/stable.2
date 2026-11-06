Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989512;
	b=BawOgJ7OK2vtrvEQchGhKIQ9eDUQpA2CFPXsEAkAi9yj1uRg3iv93iwRR6yI/5wSFHdD
	 nDl6uvu/++AsXJwz0XadJkPojcyWWAQVQUc5txqO79MsS1IX1pDEUHWeovikaauUKO6o9
	 jWPOmyn/TdvFsmldGHy5vhGYgZyKDjbUiEwDd/dphGEBGK8mekp8tbmHbSSfXNOkaE3j8
	 EmRM/2bpp7YiNx1czVZvGyhSh1vIllIJUGOjPfHnDz7i1UgJV3zeIxGESDgrLQ9NOi4jX
	 ndF8Pu37b2Sr9nOpFin5LuBGdUiiOH674NJQVrI4h+OtfGDRGI5p0lnrxPE3QcBuB6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989512;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=25/Oezbo/H2OY0Dngihw1GEqN9kUDg/nYNkd8VYSfF8=;
	b=Ki7aqyx3ad+OTvR4juXh5YdZJ1f5ns6qGEuE1MwkThk8XNXyvvfnIuCbyk1AlZN19a+B
	 gCQ1JA3ECg18odfiQA5/OtQ2Sir4VBIDKt6o9j0oR6bNVMWv6JDHH2zY6Doh2syGZucL0
	 tbgBdxy751mpkydbnkjVde7SleRfoEfyqbZOd+ZmzBTAZNxmt5F3X1uFDqyHS2qNpTzCB
	 D/2wKcKWd1RX5vBVxZ4MGnMP6bSRWAH8HpJQ0M3XSHK9axwWaTsqnvX4XpyczJRsepTTX
	 c6Qks7M5uuiEEjHVp6hW5tTnRxFqFyVqjmpScX4q/08JKcc1kJw+4fOH/ZPySbRp0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YBoiYlRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC6606D813;
	Fri,  6 Nov 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YBoiYlRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D3E1F008BE;
	Fri,  6 Nov 2026 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989511;
	bh=25/Oezbo/H2OY0Dngihw1GEqN9kUDg/nYNkd8VYSfF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBoiYlRbay6DT1Ey4+GqaLjC9lrTxxTb/JRgAZfGO0plS8Yw9mCo/LlKxEHkwF5fU
	 nxAl2eJcwvtRpoYJyqD8SXXzT6aFKJAD9R2pZFZpNhk0Ievj3eRJLl4xDiFSW1SVPr
	 IAPN3WZLIx6gx+AjLdreyyHI6JI+QMeJWfIilq1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.162
Date: Fri,  6 Nov 2026 13:25:07 -0500
Message-ID: <2026110607-mustard-cradling-ac9d@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110607-squid-outlet-b53a@gregkh>
References: <2026110607-squid-outlet-b53a@gregkh>
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

diff --git a/Makefile b/Makefile
index 05e06ca0dac1..1b3616c8d2c1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 161
+SUBLEVEL = 162
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 40f67bfc052d..4ade16ae45f3 100644
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
index bb66178c432b..b4ea123e9be1 100644
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
@@ -1104,8 +1122,7 @@ static int connect_ring(struct backend_info *be)
 				requested_num_queues, xenblk_max_queues);
 		return -ENOSYS;
 	}
-	blkif->nr_rings = requested_num_queues;
-	if (xen_blkif_alloc_rings(blkif))
+	if (xen_blkif_alloc_rings(blkif, requested_num_queues))
 		return -ENOMEM;
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index acf310e58f7e..0c4b77acc56b 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -809,8 +809,6 @@ void xenvif_disconnect_data(struct xenvif *vif)
 
 		xenvif_disconnect_queue(queue);
 	}
-
-	xenvif_mcast_addr_list_free(vif);
 }
 
 void xenvif_disconnect_ctrl(struct xenvif *vif)
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 61b547aab286..aca25db2503b 100644
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
