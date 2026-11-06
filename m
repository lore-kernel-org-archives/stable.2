Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989506;
	b=Dnm5H8mAdYXNR2yD16qCmVVIn6VQWqUvJG7eawWshBYSAkJfQyFjhRbyKVRDvKJDGyyM
	 NMnRg7NGSyi11A+1QN2wyY1eZXyNk9UvxKJwiXMPwlDzUfzL4vWuSi6hRw7qSLD8Fqul1
	 isfpSaoyD/q78pUgRZ6GWgrs8sOCDAFWo3eF71tLpbAhJ2xKlMFRDjeqO0vjtqtb/XWEr
	 vSh8PotPdHzixJIye0yOvFGwfCthjK3j7FhANBQpK/8Z3pjciTswqmxq6s3+2YFpEeg6N
	 xE+FbAvkGNTw5uR/QK4BKZjGsNULtfh6WYp0etmwaZZlwdHICi09PsKGFCykseuUHAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wmpbv9J1oWzQbKl+1SgdFosJC5gjKjETGpDCFiI5mlM=;
	b=pIeslZgyMM3AnbhIjor4oyqD8eML3/KxsqOzBRIS0OADy6RtXXT37toLQjMzhPAeZMHe
	 uD33l/SYaJIQclz/r5VcEb3nQvTgepl9CjTwvQnmLwgoM8xYHgGeEO88gnbPTHYF2Agis
	 nrkRwFU4Taol36YpxsZgE0Etv9dEU7Rdl43kdOEtw7n5+j8jhFn2/SN9gKOHlKgRPOh0b
	 Yf2mSIy7qeoxyNr5OTHYzaNAWkKQeAZ50vpuFHB9GEHTd+KRo6bGgFqEHGgjvrnhUHt69
	 0SEBLjk7z7jXdA2OZjObaL4klSWLA0lmB4FsN87nvi61d3pf2SB3sZnqZy4HBwAQxoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="KK6/3FBn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026EF606A33D;
	Fri,  6 Nov 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KK6/3FBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D8D1F008A2;
	Fri,  6 Nov 2026 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989505;
	bh=wmpbv9J1oWzQbKl+1SgdFosJC5gjKjETGpDCFiI5mlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KK6/3FBnGThGXFGoy4kboIj6kSkUFvkTfI/QzZhbS+ZHvWUlRAeE/l0sJpVt+2lc6
	 qR5YLqThBSEm7IUOL3yJZ5Zj7X9QkZWwo1KeJkUUX/kbnXFnjM9SQxBCyg9qcfmQV+
	 wg5wBF5rHa1EAzGyyRcsYm/eCfuRlNs8tdg0eGUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.192
Date: Fri,  6 Nov 2026 13:25:01 -0500
Message-ID: <2026110601-maternal-itunes-35d6@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110601-engine-salami-5fc2@gregkh>
References: <2026110601-engine-salami-5fc2@gregkh>
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
index 7efb7366912b..56d1cbfcb16b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 191
+SUBLEVEL = 192
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index a28473470e66..8d92082f2927 100644
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
index 4807af1d5805..7e788d1c21f1 100644
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
index fc3bb63b9ac3..a1aae9403474 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -810,8 +810,6 @@ void xenvif_disconnect_data(struct xenvif *vif)
 
 		xenvif_disconnect_queue(queue);
 	}
-
-	xenvif_mcast_addr_list_free(vif);
 }
 
 void xenvif_disconnect_ctrl(struct xenvif *vif)
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index a972b05da96f..8c91adfe216f 100644
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
