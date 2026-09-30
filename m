Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFD52E064
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790388; cv=none; b=B5S+2QS/sVXe8uf2iEN3ypYr+KmL4BP0d2ajeI3n9UOIies7WIr0a2ittPSgYd8dKavWY1KdAW7/OubVP7c7Bie1VgQAcklWxKSgm1UyCFd9gHcYSR7+RAma+w5g7RarIE5vfTiVDq4hKYEBVnx9WlDZgYRWKkyxSaFdB1i243I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790388; c=relaxed/simple;
	bh=ZMPvizXY0n4wJBRhWagF96puBKwM0aSHYQ9ejsD+41I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+r3me9ITlBSiVMPs/kOBUTOlR2j3vrTzM3yYkPGfWZbfO24kIrh63UOSSTvyKdYGXPGkXBBhOH++V4cWrmS+Ml67pjgzpfy2RNB+dKHY9XmAwgxCu0iCymD3Q5Uyw8E7CiTjAsc8cy8Nybj6bGaVrBwe/z3MNwcI0XEreqvawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roQuzNca; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roQuzNca"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso30227585e9.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790790385; x=1791395185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SPOcicpnjQVn4bx3oXODthmXye0yocSFDhSVyIxBW4=;
        b=roQuzNcaQrCVAolwbUIel8QJpa/fPYbn6igvxUqWGLBgKRLUCLlZb15vMB1o7Nh+bS
         DLxLisUDiJl0MTwBOfnaf0GHveZ5E7ZJSeJUbh7MYSRH7mRy7o//AIN6CbkVVMWpP3Iq
         UJRAqgEf4yZ7VxG74sXnzAOQwsDL1Og7GIMc0PCISnx9xarQMuVl+NLMbjXDtZRLn2Do
         44PiDXCa/koesUNU6pNm+AWTivaS7N9x9htVrLPxjxZkkJPFvyIuSAyudr6c8sVzHKVS
         0Tk8w/3WJNGSZVTxjStTf0yfkIgmPj29wS6dWwsskENkNJoWRQmEbuXoonRdoaDs7xVd
         x9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790790385; x=1791395185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SPOcicpnjQVn4bx3oXODthmXye0yocSFDhSVyIxBW4=;
        b=ZiFZCJT8WgOOLJ6Jonj2pdlf0j61IUDGlFZulVQVjpUf6moSOMoUzaJy9Sj5Xx/9CK
         IoET2RVpTrG4+0Bl6ML40Bww9AoTeODdxTqohBNkLWd0U1aq3/AALeEqUR2YmjjseUAM
         V/vX5QNybDNaxnimGcwv+tRWiRutvbgF6d7GexZIa36Zmg8I/JLPyVIyOmugoLmaT/rO
         X+5NxHR2YvGEg1eM3N/YGVcB+xYzt1M0wO5hLhuWslgFKRerKMeLNW4QVJ9AA/x1tRsX
         MD3uSqsL/n4IL8kBAlow6qWIHQ9wn/sYXaIfh/1yH2ZRECo9Um1M0QpOgaKOtDErTNzQ
         /yrA==
X-Forwarded-Encrypted: i=1; AKwUvBwpLGGueLUhmVrZRI89HmaYSmOx+HtC0aS7rgO/XWfBEoUosikzL1K+9aL9D7UCydqfvI8QVE0=@vger.kernel.org
X-Gm-Message-State: AFuF++m8jaje5iitvbZ5d2C4b3JF0lPg9+iBzNFlh1begXv1ZO4HAK2G
	p/aLELGSSIRkn14AU8jxSRQuyMLN/ntMjiL39DAeA9PrSu15nuAvHsPW
X-Gm-Gg: AYBFou3tXcRbjYuzCXZ03z5H/LUD3Zng0rGOyMnG57wS0Bc8fsYbWZqETwOvSZelZyc
	x3+s+5HaP/Iv8uSNStndNuml5Uwc1+WEHvP24USUVtG3OrT2EiSXwrpXhY8HbI5leNZeWJQ+laV
	tjJ/mverwQixScteESaCz6a4J9OLxyLZefWvHh6NWhE3wC1YABjuuqTqubVXh7MIbD3ho+ySOhy
	GlAsXYJ6y/GiVNGKNP5/Hg/pUwJM21DHhL1a0oFzTvvgLXj87BTYca5L+ENZBhMSH6VjGvtnjwZ
	A1Fo8QDu2EHJ17cowLWPeGhYXZdwXkgNKGB3Ms/n0qz7QgXISEdnsfNjQKx1OYbe4CeuZbaB4Fr
	2LsoZM5fHVKyLm675FlMS9msU7mVd2AVqdTvEWs6aycL7WoThS6YHg3qr5u64BOsSYDVHEw5iDo
	sFWvt7PlCYnCpIPOUM7km9fzHzyH8bleoeA19pq7LXQeS6hNV4EiV6Su0/eHRwdOY35txbBVGVD
	rPwWx+oVHVzacBU9/vK45E2gfRJF7U/IdD60glsTKhpKc64zlGYVxgT9Xo=
X-Received: by 2002:a05:600c:1c16:b0:4a0:a34:f6fe with SMTP id 5b1f17b1804b1-4a01b01bb21mr43230055e9.17.1790790384597;
        Wed, 30 Sep 2026 10:46:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01eba6fd7sm6723965e9.10.2026.09.30.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:46:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nayden Kanchev <nayden.kanchev@arm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: mali-c55: Fix frame sequence numbers on dual-pipe hardware
Date: Wed, 30 Sep 2026 18:46:21 +0100
Message-ID: <20260930174621.791831-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The single frame_sequence counter in struct mali_c55_isp is incremented
in mali_c55_set_plane_done(), which runs once per completed buffer per
capture device rather than once per frame. Hardware fitted with the
downscale pipe always hits this: mali_c55_pipeline_ready() refuses to
start the ISP unless both the full-resolution and the downscale queues
are streaming, so the counter advances twice per frame.

Each video node then reports sequence numbers 0, 2, 4, ..., which
userspace reads as a dropped frame between every pair of frames, and the
two pipes never number the same frame alike, contrary to
Documentation/admin-guide/media/mali-c55.rst. The V4L2_EVENT_FRAME_SYNC
event and the statistics and parameters buffers only read the counter,
so their sequence numbers stop identifying a frame too.

Increment the counter once per frame, when the ISP start interrupt is
handled, and stamp each capture buffer when mali_c55_set_next_buffer()
programs it, as it is written out during the following frame. Stamping
at completion would be off by one whenever DONE(n) and START(n+1) are
handled in the same interrupt, since ISP_START is processed first. Hold
the counter at UINT_MAX while the ISP is stopped, as the first buffers
are programmed before it starts, so the first frame gets sequence zero.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
 - Stamp the buffer sequence in mali_c55_set_next_buffer() instead of
   at completion, which broke when START(n+1) and DONE(n) are handled
   together (Jacopo)
 - Reset the counter when the ISP stops instead of when it starts

v1: https://lore.kernel.org/r/20260801205311.386692-1-devnexen@gmail.com
---
 drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 5 +++--
 drivers/media/platform/arm/mali-c55/mali-c55-common.h  | 4 ++++
 drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
 drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
index ff01553026fb..fa073ce4b2bd 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
@@ -413,6 +413,9 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
 		return;
 	}
 
+	/* The buffer is written out during the frame following this one. */
+	buf->vb.sequence = cap_dev->mali_c55->isp.frame_sequence + 1;
+
 	pix_mp = &cap_dev->format.format;
 
 	mali_c55_cap_dev_update_bits(cap_dev, MALI_C55_REG_Y_WRITER_MODE,
@@ -457,7 +460,6 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
 void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
 			     enum mali_c55_planes plane)
 {
-	struct mali_c55_isp *isp = &cap_dev->mali_c55->isp;
 	struct mali_c55_buffer *buf;
 
 	scoped_guard(spinlock, &cap_dev->buffers.processing_lock) {
@@ -476,7 +478,6 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
 
 	/* If the other plane is also done... */
 	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
-	buf->vb.sequence = isp->frame_sequence++;
 	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 }
 
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-common.h b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
index 13a3e9dc4243..50f2b7a85f62 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
@@ -76,6 +76,10 @@ struct mali_c55_isp {
 	struct media_pad *remote_src;
 	/* Mutex to guard vb2 start/stop streaming */
 	struct mutex capture_lock;
+	/*
+	 * Sequence of the frame being processed, incremented at SOF. Held at
+	 * UINT_MAX while stopped so the first frame gets sequence 0.
+	 */
 	unsigned int frame_sequence;
 };
 
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index fb81141d1653..be562156b295 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -573,6 +573,7 @@ static irqreturn_t mali_c55_isr(int irq, void *context)
 	for_each_set_bit(i, &interrupt_status, MALI_C55_NUM_IRQ_BITS) {
 		switch (i) {
 		case MALI_C55_IRQ_ISP_START:
+			mali_c55->isp.frame_sequence++;
 			mali_c55_isp_queue_event_sof(mali_c55);
 
 			mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
index e128adf6ee37..dd3bce287a3d 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
@@ -342,7 +342,6 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
 
 	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
 
-	isp->frame_sequence = 0;
 	ret = mali_c55_isp_start(mali_c55, state);
 	if (ret) {
 		dev_err(mali_c55->dev, "Failed to start ISP\n");
@@ -380,6 +379,7 @@ static int mali_c55_isp_disable_streams(struct v4l2_subdev *sd,
 	isp->remote_src = NULL;
 
 	mali_c55_isp_stop(mali_c55);
+	isp->frame_sequence = UINT_MAX;
 
 	return 0;
 }
@@ -584,6 +584,7 @@ int mali_c55_register_isp(struct mali_c55 *mali_c55)
 	int ret;
 
 	isp->mali_c55 = mali_c55;
+	isp->frame_sequence = UINT_MAX;
 
 	v4l2_subdev_init(sd, &mali_c55_isp_ops);
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;

base-commit: 95f76f51937fdfb0fc1e14cae606b1ef574a56f3
-- 
2.55.0

