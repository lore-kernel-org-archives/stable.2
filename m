Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882557;
	b=B76C2o8kuWBjyrXR/9S3LWQwnoY6qgg1aizj9kVaUnQ1LANEbd6RiBu1iUypapGG/P9i
	 qMEhZ76MJ8XCW023xdFXCG5wMvIf/a57fs9w+n7T9qdjz6tgsoBC6vdV7VvjWjGe/XkWY
	 NT4QcRP+/B0zbg1hgVfOXup1yjae+96pS7ZPu6HzZaTYHC0DSovuZ7PDkkS4X8aJLZx7V
	 KEoRtyylqtyhPYDvveT/2DFwX9n7a30g32uCVTNwCxzISrJRwa0rWFA8/wHYw7Wq8Rnue
	 k5Cz0GjXo7VIieYzNCf1sXasSWWOO7BbmGrsJnPnXLxw1lqNr7S3BN6SDf9scmUD54w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/mcHRTaiKvfeue2RUQHpmszoVu2/OuJy7NEzGrwwFIA=;
	b=2jcUujKZOBO4JICPr1CQUhwKQ4wJcLs4hXHRldbmZ4YKZct8b5Tp5ef1YvdYpt1zP+l+
	 o2V8yavkd/4+tSVRIm6pKeMUuTpxc5JM/RXDer3LEoQRe+fFKHmccIF7N1YOuWCKwygWg
	 xl7SyZUCBgGlqIxPgSHWOiqCW0f2llpNWVPcBVreFbuvqOiauxR3uv+ZMOC8lZOWUq85a
	 A/MdR6NTQ5gunb2ixy3W+G5Jjim7LuwDCPBKAEe0cutWD6u18AsZilEyy9yD4CKV2W/8W
	 qeSv47r+ke7hg6IPfBJ+USt9SsHUDN8LdlnHvSxiysQ5D8qh4CSjT8qgXdjNunWbrYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YGkwKiDs;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D3606D80C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24D3606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YGkwKiDs
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so14225751fa.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793882555; x=1794487355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/mcHRTaiKvfeue2RUQHpmszoVu2/OuJy7NEzGrwwFIA=;
        b=YGkwKiDsyGuAbnMRBTy9lhCF4YogV7DXh/R1p6vd0Mkf/iQfKZtBQFI0hEtyil7rCf
         wuwwyX66AQPD4rTI9EYgdyuFA4p3ZCRWf71G7rxlnVag3ltBKL8/cTEFAmMJPk1IXyLp
         PiwrSAC3iyjyx0ulQ//a6zf72AjSX1f9JzJdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882555; x=1794487355;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/mcHRTaiKvfeue2RUQHpmszoVu2/OuJy7NEzGrwwFIA=;
        b=Dt6Geb1c5TvPdfdliYoh39XAxYTIVnojh1bK7hGRCKD2f95+RCYn7Ljherm8x4TaN8
         oSxIho1CoL23xq3kgsoilG+HmZJvHTnHxrOlQRM91kNMH4S7xcP5izVI6LL7GG7LLy0s
         k+XUlIlWt8OLGxxKJIMlKLFfO8xpqrJuAI2uQT/v6NTB3N/SnCRybOHwS0rsXz/mFfVM
         5ZNuwkBB9kyctPSCXoIwfEYm/BtEX7Z9ls6lUdzoc+ST+s6RI7mNO5UzFyz+4lWsGDGv
         WRfp3/Mh2pMkNJCo2vvxerDk6a9RrEU2jQXp8tyQaaGo8WFs5FjwYiJw+718Ani1eupn
         oGAw==
X-Forwarded-Encrypted: i=1; AKwUvBx6Qp6RSgkpo6V0vbgfE1IpRONkDFPzC2AAR+vquHBpy4RIp1sz4HavUAWyzV21XpbxyBrJ8H4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jrkfGSpEw9jpTRpVI6Es7bpSyIvhxLtIhxI69FTk5jm8vBvkE
	BVIYwxq/dZMyCrcrNsSpoHm5RNAWqnS7fJETi7Yl4DkgBRz9GHd9shXjll/bCiLlGw==
X-Gm-Gg: AYBFou1ffUUOOv11Avneyx/yt3yT7lWH65GJaYRWixw4JZLzCzIu0sQUTw2Bds2J6GF
	urCVcS/n6BOWudLUG1j4tHenvdqfoNteBTttPV8/ghiwhvPUzTzJJxM4oJ2BX03TPDgGUR/suVb
	hnz2jpWPj3EmMpGRcJlosZAHba0MXf26pXWWSkBKf/S3HoD9clY5NnQcPLg7BiejrgUo3ptREDr
	RGS36+0015ONXeZODMNp2M0VSDL/QTrwrY/SrQm96aOlGQadO5csSLTY4eZfAutsx2hDEsnJAJk
	ZZOwEeKGW/e7q3y08QiwRtlbOE38ogs2McuLc8CmPLNcPMgWNQTTNHZQwtFKNhweDPqy1DzAxlg
	7S/qvBnKrqi/OdZF2po7VIGhLt1aMvzCNTsjpLPUTivMTXEPlK5kPHmgJjo7coYKuxsdEbBvBpu
	Zs0YNPZ1Z6YWB1wJWD3nInET/OwRaL1diEHusMBLk5b1bHqZLULxB4L4Rrno6/H9a14UnmoaTHu
	wrvG3eWdW4ULIT1vzCE4E/oKZQWmkkmNI9czRvWpgunMhONxBkThx1HFiH+BgV1SyRzceuq+sog
	DWsLsPY/JhTE/qCd8bVXaKnEbcd99MSF+srUIrHTXhkeZzFwkfVhc2PyL74nIj7c9z2YKX4bzrK
	HedK9QfkE9A==
X-Received: by 2002:a05:6512:3c8e:b0:5bf:b93e:8854 with SMTP id 2adb3069b0e04-5bfd959d946mr6969937e87.57.1793882554975;
        Thu, 05 Nov 2026 04:42:34 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff6047e87sm729598e87.60.2026.11.05.04.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:42:33 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 05 Nov 2026 12:42:28 +0000
Subject: [PATCH v3] media: videobuf2: publish buffers in bufs_bitmap under
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
Message-Id: <20261105-vb2-mmap_lock-v3-1-27ca302f9497@chromium.org>
X-B4-Tracking: v=1; b=H4sIALN57GoC/3XM0QqCMBTG8VeRXXdiZ3ORXfUeEaHbUUfNyVajE
 N+96VUIXf4/+H4TixQsRXYqJhYo2Wj9kEPuCqb7eugIrMnNBBcHRC4gNQKcq8fbw+s7VKoirnV
 JppEsf8ZArX2v3uWau7fx6cNn5RMu6z8pISC0pBRviUsyx7Pug3f25fY+dGzBkvgF5BYQwIGrk
 hCNNhzlBpjn+Qt92VM87gAAAA==
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
and .queue_setup() succeed, and let __vb2_queue_free() read q->bufs[]
directly when cleaning up unexposed buffers.

Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
Cc: stable@vger.kernel.org
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Patch 2/2 from v2 has been dropped for now; we will send it separately
once patch 1/2 has landed in next and fixes.

This patch was generated by an LLM, but supervised and reviewed by a
human (not the most handsome human, but a human).
---
Changes in v3:
- Clarify @bufs comment in struct vb2_queue to state that drivers must
  access it through vb2_get_buffer() (Marek).
- Drop patch 2/2; it will be sent once patch 1/2 has landed in next and
  fixes.
- Collect Reviewed-by from Marek.
- Link to v2: https://lore.kernel.org/r/20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org

Changes in v2:
- Keep vb2_queue_add_buffer() without set_bit() so __vb2_queue_alloc()
  stays unchanged, and add vb2_queue_publish_buffers() using atomic
  set_bit() (rather than non-atomic bitmap_set(), since vb2_get_buffer()
  has lockless readers).
- Split the smp_mb__before_atomic() / test_bit_acquire() memory barrier
  pair into a separate patch with an explanation of the arm64
  VIDIOC_CREATE_BUFS vs vb2_find_buffer() race.
- Drop lockdep_assert_held() from vb2_queue_remove_buffer().
- Simplify the !q->bufs guard in __vb2_queue_free() to 'if (!q->bufs)
  return;' (still needed as a NULL check now that __vb2_queue_free()
  indexes q->bufs[] directly instead of going through vb2_get_buffer(),
  since vb2_core_queue_release() and REQBUFS(0) call it when
  q->bufs == NULL).
- Clarify @bufs and @bufs_bitmap documentation in struct vb2_queue.
- Link to v1: https://lore.kernel.org/r/20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org
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
index 4b4f4c15c53a..3ed9a0df21b8 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -564,9 +564,11 @@ struct vb2_buf_ops {
  * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
  * @memory:	current memory type used
  * @dma_dir:	DMA mapping direction.
- * @bufs:	videobuf2 buffer structures. If it is non-NULL then
- *		bufs_bitmap is also non-NULL.
- * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
+ * @bufs:	videobuf2 buffer structures. Drivers must access it through
+ *		vb2_get_buffer(), as an allocated buffer cannot be used
+ *		until it is published.
+ * @bufs_bitmap: bitmap tracking published buffers. Bits are set and cleared
+ *		under @mmap_lock.
  * @max_num_buffers: upper limit of number of allocated/used buffers.
  *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
  *		     for backward compatibility.

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-vb2-mmap_lock-959e0cc4edb3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

