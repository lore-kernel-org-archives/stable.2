Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639571;
	b=JqOxB8570/fG3CXvgTRaILAZ+fnuWmkTJOdGlfrNDq5M8Ev9n7Ts3hI6VubkQ82Qgqqz
	 /24VJfsqc2gTaXEoSuRnkDPH9EVbdGRpA2dGAgHQ+DfmrKk8jVVCen3vatoq+utK6UqGH
	 YElny3XZw5qlloZwGDuUhpbF3hzOVO2kuB8Oy8vhXalt6qdOMvqdGdgdHVb1BFh83I1SO
	 KOyBKzHcdJyrYNnuw6wbdWloGunwXzdQLVBtKHyrngtnrhWV5PppuF9NpWiQcuA0iwXqy
	 /RYsRBcfl/P/ItPu9OTekLnQDPGQesy9K2a4UWBnNym3VaQdtBaRgB1rl3aLPKPnBXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=8VG88+Iq3vaISnahrDlu9XP6pNoIrIIWL4VTZc72VoQ=;
	b=ffqprSrLCkKBiiouKrpKzafBJg0sJdl8jX4ceyztodmG5Ue71OPLBu5eo0t/oXZ67If2
	 WymjHZZjmOkc260hAq/VujU3yN3m4s0tAq+l+wz0olY9SXTIJKK+e+9hnEvZxpijdtCMa
	 Cu3MZkU0UHoreE14QdVTrkYNsu1jc5WX4Tm1sJUIUS9TJ3zo8bnCGUGr+A/eOCLcqKVjM
	 mxRnGM6abnqO/sVHE1vrkXdAlq1u5yInRgeVHhSizpl08shOXs0M0sW0hM06idW4XdY51
	 boshRBgRtnNpynaMuCYBLKeRaLGcqqAEyvkndVO9Z212nGbMtpdrWtbMsOZkJx8brJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="QUj/2aX/";
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA2606A916
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BA2606A916
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QUj/2aX/
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso3527599e87.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793639568; x=1794244368; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8VG88+Iq3vaISnahrDlu9XP6pNoIrIIWL4VTZc72VoQ=;
        b=QUj/2aX/Pwq4cGAOB7apUhZIZsWaAwdu+sFoW0jJU0WB0eQWSyG13Z2acJZ29W6zDE
         vZorbn+qU1kod/QAAk7ciVbRGz7AXMc+HMeuf1czrqMjb/dW7BjH54VdNhqzULY+O0Ox
         Xe9/1Rh6NA1xgRt+9ZRVfCjAuWrGaiZxffgr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639568; x=1794244368;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8VG88+Iq3vaISnahrDlu9XP6pNoIrIIWL4VTZc72VoQ=;
        b=pzM+XBZc4rJds+7ENE7M0+blbyo6EpnHV3oWt1871B2Ex72ivz2tH1ktR6qghKnaR2
         KBlk3x7/dNO0jXWUf1CxFl8t+BODrHhTaTOD+Fm0ATnupOfoiITavj4rUjfI1/+v4yc9
         AvqNZNkT/H5WF0h4PVu7M4e+9RU/YjR9Yd3IMq6pkiYXHcwp+fY5QBMlvSUquFLcAAcd
         ncML0T0GGgUaeVqOXcM+6aan+TddGOE7yT0olB1OW/OWSRXNT8+G8Q1T7gn6SqQ0L3hh
         8JKcFKF6AgRna1zXeqFpBDIXlw3TQZJ3RwNs1joTnOlU/9h2bSWzZm/y28Od1ycufGBy
         +gwA==
X-Forwarded-Encrypted: i=1; AKwUvByF8hh63Z8Ogyx4WGDRdqOJFH/Y4/gI+WLWfr0urPTIaTQyWQL6nREh9rzmlgbtRAbreZpBo5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TrJV6u1Reh5Bm5jHa0IxEbG95zKMDyAsSj1hacLfFzN8uJy5E
	WPFbVCAwe2/18QNrmV1UpDYAH7MstK2d0PXLhoCdJ4vyJUQ8XxeKJ+ZxhT9ZFrCJb+VJGo0eOQo
	hapInKQ==
X-Gm-Gg: AYBFou0oIVaufd0vO+5CH01Wv9KScLX6ZGS810aprtcUxAcFmgKrpMySxU8G+EyguMM
	F+CIAOQuu6DkV/+sliMmKRnAnigny83A9AnE+OBh6xZpJSPsqSPFqJz3It8Iq9SGxexgvYS0nyV
	sIjzbQgukLnEU2FrvO325odTCZyS5x4nHmmP8jRIJCVWbhMWKKQ4MvvHU7XN8v/B1hQo/IKXv5v
	xWjyeWd4H2/2lQ2w9ZWRDm1iyH5sKYCR07JpYcq4VbFKu6ii+k3XdDCuCaZ6ePqFy45TbZO17BX
	Dax+g1rjrlin2tzgC4o6gXWX9Qw10o1z8uE6pVGr8Zv59i4XF5Ew8FOJJp/1YeOlJ6podk9hceT
	7pwgB/1IFty7DWtFTImec7JwvSVYaTZYHysUDLqzc5EXdwwnG+C9rdA455J1GLZduBBqwSzB5/m
	XG7X6tSLTej43LQhGJ8s4S59E1afAMCp+W1d7KmCqJRSj089NRMSZdHkPh/9WCY3szoXtG/wE7X
	5kqfq6L0lTFmpBXUl0KAFdDqDh06qI/FcHnc1uw/rYJPWiBTm7FfOhdw+zKuXzhaX+44lTtVB1n
	wmQdKXcjxwWBMXGzZCWRe2m6Gb7VziQSgF1DknQyrlQikK5hrpYrzWWam3lZQ/WM1O4ZmgijNGm
	FbIozwoQ/Pg==
X-Received: by 2002:a05:651c:4198:b0:3ab:53ca:c746 with SMTP id 38308e7fff4ca-3acb7a9a3f9mr29982501fa.12.1793639568252;
        Mon, 02 Nov 2026 09:12:48 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acd5c479bbsm566121fa.32.2026.11.02.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:12:47 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Nov 2026 17:12:44 +0000
Subject: [PATCH] media: videobuf2: publish buffers in bufs_bitmap under
 mmap_lock
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
Message-Id: <20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIvE6GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3bIkI93c3MSC+Jz85GxdS1PLVIPkZJPUlCRjJaCegqLUtMwKsHn
 RsbW1ANTThOxfAAAA
X-Change-ID: 20261102-vb2-mmap_lock-959e0cc4edb3
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
and .queue_setup() succeed. Add a memory barrier pair on q->bufs_bitmap
so lockless vb2_get_buffer() readers also see fully initialized buffers,
and let __vb2_queue_free() read q->bufs[] directly when cleaning up
unexposed buffers.

Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This patch was generated by an LLM, but supervised and reviewed by a
human (not the most handsome human, but a human).
---
 drivers/media/common/videobuf2/videobuf2-core.c | 97 +++++++++++++++++++------
 include/media/videobuf2-core.h                  | 13 +++-
 2 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b0a6084f1757..185393078ce3 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -427,19 +427,36 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
 }
 
 /**
- * vb2_queue_add_buffer() - add a buffer to a queue
- * @q:	pointer to &struct vb2_queue with videobuf2 queue.
- * @vb:	pointer to &struct vb2_buffer to be added to the queue.
- * @index: index where add vb2_buffer in the queue
+ * vb2_queue_add_buffers() - publish buffers staged by __vb2_queue_alloc()
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ * @start:	index of the first buffer to publish.
+ * @count:	number of buffers to publish.
+ *
+ * Set the @q->bufs_bitmap bits of the @count fully initialized buffers that
+ * __vb2_queue_alloc() stored in @q->bufs[] starting at @start, which makes
+ * them visible to vb2_get_buffer().
  */
-static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
+static void vb2_queue_add_buffers(struct vb2_queue *q, unsigned int start,
+				  unsigned int count)
 {
-	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
+	unsigned int i;
+
+	lockdep_assert_held(&q->mmap_lock);
 
-	q->bufs[index] = vb;
-	vb->index = index;
-	vb->vb2_queue = q;
-	set_bit(index, q->bufs_bitmap);
+	/*
+	 * Order the buffer initialization and the q->bufs[] stores done by
+	 * __vb2_queue_alloc() before the bits that publish them. Pairs with
+	 * test_bit_acquire() in vb2_get_buffer(), which is also called
+	 * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
+	 * from a mem2mem .device_run().
+	 */
+	smp_mb__before_atomic();
+	for (i = start; i < start + count; i++) {
+		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
+			    test_bit(i, q->bufs_bitmap)))
+			continue;
+		set_bit(i, q->bufs_bitmap);
+	}
 }
 
 /**
@@ -448,6 +465,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
  */
 static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
 {
+	lockdep_assert_held(&vb->vb2_queue->mmap_lock);
+
 	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
 	vb->vb2_queue->bufs[vb->index] = NULL;
 	vb->vb2_queue = NULL;
@@ -460,6 +479,11 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  * @first_index: index of the first created buffer, all newly allocated buffers
  *		 have indices in the range [first_index..first_index+count-1]
  *
+ * The allocated buffers are stored in q->bufs[] but not published in
+ * q->bufs_bitmap: the caller must either publish them with
+ * vb2_queue_add_buffers() or free them with __vb2_queue_free(), both under
+ * q->mmap_lock.
+ *
  * Returns the number of buffers successfully allocated.
  */
 static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
@@ -506,7 +530,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		}
 
 		vb->state = VB2_BUF_STATE_DEQUEUED;
+		vb->vb2_queue = q;
 		vb->num_planes = num_planes;
+		vb->index = index + buffer;
 		vb->type = q->type;
 		vb->memory = memory;
 		init_buffer_cache_hints(q, vb);
@@ -515,7 +541,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			vb->planes[plane].min_length = plane_sizes[plane];
 		}
 
-		vb2_queue_add_buffer(q, vb, index++);
 		call_void_bufop(q, init_buffer, vb);
 
 		/* Allocate video buffer memory for the MMAP type */
@@ -524,7 +549,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			if (ret) {
 				dprintk(q, 1, "failed allocating memory for buffer %d\n",
 					buffer);
-				vb2_queue_remove_buffer(vb);
 				kfree(vb);
 				break;
 			}
@@ -539,11 +563,20 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 				dprintk(q, 1, "buffer %d %p initialization failed\n",
 					buffer, vb);
 				__vb2_buf_mem_free(vb);
-				vb2_queue_remove_buffer(vb);
 				kfree(vb);
 				break;
 			}
 		}
+
+		/*
+		 * Stage the initialized buffer in q->bufs[]; it becomes visible
+		 * to vb2_get_buffer() only after vb2_queue_add_buffers() sets
+		 * its bit in q->bufs_bitmap under q->mmap_lock.
+		 */
+		WARN_ON(vb->index >= q->max_num_buffers ||
+			q->bufs[vb->index] ||
+			test_bit(vb->index, q->bufs_bitmap));
+		q->bufs[vb->index] = vb;
 	}
 
 	dprintk(q, 3, "allocated %d buffers, %d plane(s) each\n",
@@ -562,7 +595,8 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
 	struct vb2_buffer *vb;
 
 	for (i = start; i < start + count; i++) {
-		vb = vb2_get_buffer(q, i);
+		/* See __vb2_queue_free() for why vb2_get_buffer() isn't used */
+		vb = q->bufs[i];
 		if (!vb)
 			continue;
 
@@ -580,6 +614,11 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
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
@@ -587,9 +626,19 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 
 	lockdep_assert_held(&q->mmap_lock);
 
+	/*
+	 * No buffers were ever allocated (e.g. REQBUFS(0) on a fresh queue),
+	 * only the queue state needs to be reset.
+	 */
+	if (!q->bufs) {
+		q->memory = VB2_MEMORY_UNKNOWN;
+		INIT_LIST_HEAD(&q->queued_list);
+		return;
+	}
+
 	/* Call driver-provided cleanup function for each buffer, if provided */
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 
 		if (vb && vb->planes[0].mem_priv)
 			call_void_vb_qop(vb, buf_cleanup, vb);
@@ -624,7 +673,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 		q->cnt_unprepare_streaming = 0;
 	}
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 		bool unbalanced;
 
 		if (!vb)
@@ -676,7 +725,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
 
 	/* Free vb2 buffers */
 	for (i = start; i < start + count; i++) {
-		struct vb2_buffer *vb = vb2_get_buffer(q, i);
+		struct vb2_buffer *vb = q->bufs[i];
 
 		if (!vb)
 			continue;
@@ -1000,14 +1049,16 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
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
+	vb2_queue_add_buffers(q, first_index, allocated_buffers);
 	mutex_unlock(&q->mmap_lock);
 
 	/*
@@ -1125,14 +1176,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
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
+	vb2_queue_add_buffers(q, *first_index, allocated_buffers);
 	mutex_unlock(&q->mmap_lock);
 
 	/*
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4b4f4c15c53a..0b32ac7bc8fc 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -565,8 +565,11 @@ struct vb2_buf_ops {
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
  * @bufs:	videobuf2 buffer structures. If it is non-NULL then
- *		bufs_bitmap is also non-NULL.
- * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
+ *		bufs_bitmap is also non-NULL. __vb2_queue_alloc() fills in
+ *		an entry before its bit is set in bufs_bitmap, so buffers
+ *		must be looked up with vb2_get_buffer().
+ * @bufs_bitmap: bitmap tracking which bufs[] entries hold a fully
+ *		initialized buffer. Bits are set and cleared under @mmap_lock.
  * @max_num_buffers: upper limit of number of allocated/used buffers.
  *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
  *		     for backward compatibility.
@@ -1286,7 +1289,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 	if (index >= q->max_num_buffers)
 		return NULL;
 
-	if (test_bit(index, q->bufs_bitmap))
+	/*
+	 * A set bit guarantees that the buffer is fully initialized, pairs
+	 * with smp_mb__before_atomic() in vb2_queue_add_buffers().
+	 */
+	if (test_bit_acquire(index, q->bufs_bitmap))
 		return q->bufs[index];
 	return NULL;
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-vb2-mmap_lock-959e0cc4edb3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

