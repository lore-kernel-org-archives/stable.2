Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989500;
	b=Xk9Goub5P15goHum88C9TCg7qEwzhhfY/3z59lGnenv1C6k0QAG/TvJZ5+uxw1s+J/JN
	 ERfYuLm0B8l+SeFLjCXy5KZ+QIdTr71+mENTvRaaDPLTWNMGHDWR0QiREHAp8Rv9lQcgS
	 vLpEhkwLUOqNjJTGBv/BnWlayvV+Sjo3QWqY3ZB1kzcO2cj3cyAX13i5B11huja4QmQod
	 HWXnEsZFsH2JFCuc0k9SdShx61p5T71tdZfhvX+8hTon2oMgpA+dfEUNft69mV89+c7n5
	 7z1n9TCcBJElQOqfvy4RKpLZrz02UCJqUCuy89UMVeoD+ZT9lHfei51FE/dMeRCcmMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989500;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zDwXRUgmgjLzyK+vNatlIuTEGq/PIv3VbBlkOOgIGzM=;
	b=D0K/uv3qIZA0HsHL80P4d2hc/nV1aYJrDmkHKLmr/LYoq7bUPzloELXz0msg7Dj9c2w8
	 d8tzlRTZBA2mto8aWv0I75Zu0tDgxwV6WvBjhv7IKZvEBSdiQH5TuLtTgMjEQfU/hJm+E
	 MyKfSgY6W3ACCgSpcyuvNGqtoOtkxA7pn6N9jEoPE9zMkvOpBXfpNtEzkd1I33buR9MaZ
	 zxQziCmzpf3QB85FNrwvWAabBrGfJBUIlAsAkJBIjkTPfdEidJMpwIo5+A1ZnHNtkGuW5
	 NFMuSAB+7LXk4XQMHw1KwVlls2cj2eX19K4Y6ElAy+bhlt5Kect/vYq6UGoCxDng/ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rErTEwF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FE606A33F;
	Fri,  6 Nov 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rErTEwF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A9F1F008A4;
	Fri,  6 Nov 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989500;
	bh=zDwXRUgmgjLzyK+vNatlIuTEGq/PIv3VbBlkOOgIGzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rErTEwF9zpKkoVqCr3dWV7p3qu2Z0UCBu5YJ2m7mvFZZ6KkLZXLo2kbPR9hr8dVQI
	 IvmGzwmMXT7U0qpLcIv3MddCFMrlkCZO+5iLQYwTwus7jNsmj3W3z5KFhludk0jLZz
	 /sQc2B8EYDD9F0D2pg8BpcfrTQQuGk/TIrV+GYNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.225
Date: Fri,  6 Nov 2026 13:24:55 -0500
Message-ID: <2026110655-glorious-vocalist-72a7@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026110655-upright-drained-3d9c@gregkh>
References: <2026110655-upright-drained-3d9c@gregkh>
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
index 39856e1c9c4a..215bf5d254d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 224
+SUBLEVEL = 225
 EXTRAVERSION =
 NAME = Trick or Treat
 
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
index 1525e28c5d70..6808b9cef6e4 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -126,15 +126,23 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
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
 
@@ -174,6 +182,7 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	blkif->domid = domid;
 	atomic_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
+	rwlock_init(&blkif->rings_lock);
 
 	/*
 	 * Because freeing back to the cache may be deferred, it is not
@@ -268,6 +277,7 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	struct pending_req *req, *n;
 	unsigned int j, r;
 	bool busy = false;
+	struct xen_blkif_ring *rings;
 
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
@@ -334,10 +344,16 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
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
 
@@ -385,6 +401,7 @@ void xen_blkif_interface_fini(void)
 		unsigned int i;						\
 		unsigned long long result = 0;				\
 									\
+		read_lock(&blkif->rings_lock);				\
 		if (!blkif->rings)				\
 			goto out;					\
 									\
@@ -395,6 +412,7 @@ void xen_blkif_interface_fini(void)
 		}							\
 									\
 out:									\
+		read_unlock(&blkif->rings_lock);			\
 		return sprintf(buf, format, result);			\
 	}								\
 	static DEVICE_ATTR(name, 0444, show_##name, NULL)
@@ -1109,8 +1127,7 @@ static int connect_ring(struct backend_info *be)
 				requested_num_queues, xenblk_max_queues);
 		return -ENOSYS;
 	}
-	blkif->nr_rings = requested_num_queues;
-	if (xen_blkif_alloc_rings(blkif))
+	if (xen_blkif_alloc_rings(blkif, requested_num_queues))
 		return -ENOMEM;
 
 	pr_info("%s: using %d queues, protocol %d (%s) %s\n", dev->nodename,
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f20ddaaa2451..90658aa58e8c 100644
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
index 5b78d9172aac..b9219b394de5 100644
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
