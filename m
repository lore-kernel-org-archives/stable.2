Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703373;
	b=TaBt/qm/RvDfpTv3rzMGVKLfOpHr9F0KmylSo9jnK2iEakFvYYTObMiVUNtRVPn5KEk0
	 ULj8dA0hxRDWXeW3tVRj8xq8oEcinqOnahRds5WG2flZjOq/yheH0xBv6cz8LlamKYocc
	 tPmj49k+JBHTOu8igu00ARq9X957YqX2Zyyar9Rh3B/47iYJh261bwQpXPG8QtjHmsEfd
	 yR6KIXNFA8sGThldIu/QJ2N7GD1F9CvJV6NswDp52Wk4qmpU7kMjABQSNSGfNARee52b4
	 nPfNqIQZJXGgew1V3nnydobhfjxOYjshP3QsFiTyacv06C2n9r5LFTmf61E3ZAwpfRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xSD7cxthB9W0KI/LsHWzLh21tuW/dkbAwJgVNf3RpSU=;
	b=cH06tuYypjNBF6EbW00bbnuJ3cMi4oQqtb4OmkfEVlDaQsDx+BZjjxdYDKYFRu2hCq+K
	 jwsrBgqqLPvrmjpEpZ50OnHbrRUMJi1Gpfi4nesdGLuM78uUIs+aTFaXxPdjJc3hPCpW+
	 jOxqs/1rh/TGMkUUAls/YYzNMY+OokJBfYdXozCuKf51Lh4Sux1iRpgI67tpr+CkCxtso
	 QIcmff3i9DMix01uDJ+hu+Q0fyDrj51DJCMKMTegU94jSFCNL9atWggC4OSHVhxJiNsjj
	 EJFBcpJO/vBbwxHdHiu9SKVcHzPNq2UoAhyO84Zqobsqf5zFB6VHc4DDERClZLGcqtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CMshHRoQ;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B46606EEAE
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B46606EEAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CMshHRoQ
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be47aa555cso3698041e87.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793703371; x=1794308171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSD7cxthB9W0KI/LsHWzLh21tuW/dkbAwJgVNf3RpSU=;
        b=CMshHRoQ9LA4EEdoYu9Y+zoBFGOFRgQcTHYuyrnsAZKZYPEWCpOESF/AL1aDG/CfTs
         vkSiQc360/qvZc6nKAo7LoaKhZmtPp9S1JBC+FslRc9n6m5ZIjNR9ihE3gwrQ4x3wMjm
         1V19ifHiEk4sWrAPU6zhVEZ//ylGrLSgAUvjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703371; x=1794308171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSD7cxthB9W0KI/LsHWzLh21tuW/dkbAwJgVNf3RpSU=;
        b=VJ6SFDxr6nxhyi8zexrYDvJHGSWOonH2RP83n6yK5oK03vPjww3PCKOWyZiTat/yDr
         q9H+eHykyCWfhRN0EaGdlbCHTHlO5CF5OXP80UiT3U9m17wwRz+8uJplL/X/1WdgMZbo
         uDzDAoUIsX9gtl+JSt4D0w24nTwKDLd7D+/5N6o+miCPrnY6HWhlSuqCbU+rrBnxP3oc
         Ns1+wB4kSED6Vmhm08gTNAZ3uOwoAtt21UhQm6JMTBaBgm7YUwug9ouTeZpvSda7fYsK
         CnCbt+9yW4HTUM7zDKB348PoLQEsTvxfb4uhYda4T9i4tEccjb2aX8awAOlsv5t1yq1J
         vCBw==
X-Forwarded-Encrypted: i=1; AKwUvBwQRhJyxrUEN5LfCgdqe+v2ZV0hF1+Krevkh0rpMaxfD/1J4sJl6j2hO/qW4AlGa7Nm88ak3Mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/90xLR33dTJ8LL/3sqn9i6xwvOr6+cUkoUtpoQCojXNJw2UewI
	XxDXEy+9TR3eeS50kwJvZ1Ih+HXz8HgKfz3Y2w99A929pSm/raBp8CMwmOTSfBXYbQ==
X-Gm-Gg: AYBFou0DShN5l9beQHYscp7bDSBbfdWPUCOKZ7ZEe51tMj8ihaE51YaiOhtct8Po+gq
	ppZO2uqgAOIbm49rC+M+OGqk+BGbGoVP+3Mz6VW6TcZ1JqdFvzYBbjToDoJTl3NKvQtu/dV6cFS
	VRfRiG9D82hkQHXV7e0jtFbbEr8JvPvb0PS2f4effXMWL8WUbp+ppm7VoQ+eiT2NQrZ/5yTPFvl
	C8+wolk51dDDJHX68equ03oQAYmp915LPJQdH9Wzrrr5dzyntRJkunbZyVq8QFcGiaRq+5ytOSf
	dYPPeWTiPH4MBgbKy/KHa8KbkmTM+ALgT8If4O8Q+BDXwM+uK3KOZhzCOWibNCQmnwziOVraqk1
	7hH9vBjjTHVpGUKp20AvAajp//W3sYcROxQ6Uk3zopT1MU4hQSFFU3y4Z0MFteDSlyENrK2Ytii
	gHEJ9DmFdx51en3CiS29fbBbIt9411h/mM3poxMS/RDOYIl98wlGLSSH8j6X9UTPELr2PRN0Oz2
	WUsgEdjI9WaJYkvjVYNVC/V0QvE8gLN+u/7IXMY7bZ3v0BMZIKsqKMg0E+somDRRL6iZzJIQFCi
	tWsOfBBRIz9hyX4X6c3OLmnx7RJhATLMiRhtjqBOINOgfoxNhZjH1LFQTDP75NbbTXOpg7seWRS
	59tQIMlSRglk=
X-Received: by 2002:a05:6512:398c:b0:5ba:3300:d521 with SMTP id 2adb3069b0e04-5bfd957f357mr3782618e87.41.1793703370702;
        Tue, 03 Nov 2026 02:56:10 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe0754779sm2103257e87.82.2026.11.03.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:56:10 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Nov 2026 10:56:08 +0000
Subject: [PATCH v2 1/2] media: videobuf2: publish buffers in bufs_bitmap
 under mmap_lock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-vb2-mmap_lock-v2-1-054e11dcd013@chromium.org>
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
In-Reply-To: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
To: Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

vb2_mmap() only takes q->mmap_lock, not the main queue lock (q->lock).
To keep vb2_mmap() safe, newly allocated buffers must not become visible
in vb2_get_buffer() until they are fully initialized and q->mmap_lock is
held.

Commit a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
started setting q->bufs_bitmap inside __vb2_queue_alloc() before buffer
memory is allocated and without holding q->mmap_lock. As a result:

- A concurrent mmap() can find a half-initialized buffer, and if buffer
  allocation or .buf_init() fails, __vb2_queue_alloc() frees that buffer
  without holding q->mmap_lock, causing a use-after-free in vb2_mmap().
- If fewer buffers are allocated than requested, they are already
  counted as active in q->bufs_bitmap before .queue_setup() checks
  whether the smaller count is acceptable.

Fix this by keeping new buffers only in q->bufs[] during allocation and
setting their bits in q->bufs_bitmap under q->mmap_lock once allocation
and .queue_setup() succeed, and let __vb2_queue_free() read q->bufs[]
directly when cleaning up unexposed buffers.

Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 66 +++++++++++++++++++++----
 include/media/videobuf2-core.h                  |  8 +--
 2 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b0a6084f1757..70ef38c3d16a 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -431,6 +431,9 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
  * @q:	pointer to &struct vb2_queue with videobuf2 queue.
  * @vb:	pointer to &struct vb2_buffer to be added to the queue.
  * @index: index where add vb2_buffer in the queue
+ *
+ * The buffer is stored in @q->bufs[] but remains invisible to vb2_get_buffer()
+ * until published with vb2_queue_publish_buffers().
  */
 static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
 {
@@ -439,7 +442,31 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
 	q->bufs[index] = vb;
 	vb->index = index;
 	vb->vb2_queue = q;
-	set_bit(index, q->bufs_bitmap);
+}
+
+/**
+ * vb2_queue_publish_buffers() - publish buffers staged by __vb2_queue_alloc()
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ * @start:	index of the first buffer to publish.
+ * @count:	number of buffers to publish.
+ *
+ * Set the @q->bufs_bitmap bits of the @count fully initialized buffers that
+ * __vb2_queue_alloc() stored in @q->bufs[] starting at @start, which makes
+ * them visible to vb2_get_buffer().
+ */
+static void vb2_queue_publish_buffers(struct vb2_queue *q, unsigned int start,
+				      unsigned int count)
+{
+	unsigned int i;
+
+	lockdep_assert_held(&q->mmap_lock);
+
+	for (i = start; i < start + count; i++) {
+		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
+			    test_bit(i, q->bufs_bitmap)))
+			continue;
+		set_bit(i, q->bufs_bitmap);
+	}
 }
 
 /**
@@ -460,6 +487,11 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  * @first_index: index of the first created buffer, all newly allocated buffers
  *		 have indices in the range [first_index..first_index+count-1]
  *
+ * The allocated buffers are stored in q->bufs[] but not published in
+ * q->bufs_bitmap: the caller must either publish them with
+ * vb2_queue_publish_buffers() or free them with __vb2_queue_free(), both under
+ * q->mmap_lock.
+ *
  * Returns the number of buffers successfully allocated.
  */
 static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
@@ -562,7 +594,8 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
 	struct vb2_buffer *vb;
 
 	for (i = start; i < start + count; i++) {
-		vb = vb2_get_buffer(q, i);
+		/* See __vb2_queue_free() for why vb2_get_buffer() isn't used */
+		vb = q->bufs[i];
 		if (!vb)
 			continue;
 
@@ -580,6 +613,11 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
  * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
  * related information, if no buffers are left return the queue to an
  * uninitialized state. Might be called even if the queue has already been freed.
+ *
+ * Buffers are looked up directly in q->bufs[] instead of through
+ * vb2_get_buffer() so that buffers staged by __vb2_queue_alloc() that were
+ * never published in q->bufs_bitmap (because a later .queue_setup() call
+ * rejected the allocated number of buffers) are freed as well.
  */
 static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
 {
@@ -587,9 +625,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 
 	lockdep_assert_held(&q->mmap_lock);
 
+	/* q->bufs is NULL until vb2_core_allocated_buffers_storage() runs */
+	if (!q->bufs)
+		return;
+
 	/* Call driver-provided cleanup function for each buffer, if provided */
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 
 		if (vb && vb->planes[0].mem_priv)
 			call_void_vb_qop(vb, buf_cleanup, vb);
@@ -624,7 +666,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 		q->cnt_unprepare_streaming = 0;
 	}
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 		bool unbalanced;
 
 		if (!vb)
@@ -676,7 +718,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 
 	/* Free vb2 buffers */
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 
 		if (!vb)
 			continue;
@@ -1000,14 +1042,16 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	if (ret < 0) {
 		/*
-		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
-		 * from already queued buffers and it will reset q->memory to
+		 * Note: the buffers allocated by __vb2_queue_alloc() were never
+		 * published in q->bufs_bitmap, __vb2_queue_free() frees them
+		 * straight from q->bufs[] and resets q->memory to
 		 * VB2_MEMORY_UNKNOWN.
 		 */
 		__vb2_queue_free(q, first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return ret;
 	}
+	vb2_queue_publish_buffers(q, first_index, allocated_buffers);
 	mutex_unlock(&q->mmap_lock);
 
 	/*
@@ -1125,14 +1169,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	if (ret < 0) {
 		/*
-		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
-		 * from already queued buffers and it will reset q->memory to
-		 * VB2_MEMORY_UNKNOWN.
+		 * Note: the buffers allocated by __vb2_queue_alloc() were never
+		 * published in q->bufs_bitmap, __vb2_queue_free() frees them
+		 * straight from q->bufs[] and resets q->memory to
+		 * VB2_MEMORY_UNKNOWN if no buffers are left.
 		 */
 		__vb2_queue_free(q, *first_index, allocated_buffers);
 		mutex_unlock(&q->mmap_lock);
 		return -ENOMEM;
 	}
+	vb2_queue_publish_buffers(q, *first_index, allocated_buffers);
 	mutex_unlock(&q->mmap_lock);
 
 	/*
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b4f4c15c53a..2e93e6985d5f 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -564,9 +564,11 @@ struct vb2_buf_ops {
  * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
- * @bufs:	videobuf2 buffer structures. If it is non-NULL then
- *		bufs_bitmap is also non-NULL.
- * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
+ * @bufs:	videobuf2 buffer structures. Must be accessed with
+ *		vb2_get_buffer(), as an allocated buffer cannot be used
+ *		until it is published.
+ * @bufs_bitmap: bitmap tracking published buffers. Bits are set and cleared
+ *		under @mmap_lock.
  * @max_num_buffers: upper limit of number of allocated/used buffers.
  *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
  *		     for backward compatibility.

-- 
2.56.0.385.gac671c819a-goog

