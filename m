Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B523DAAC6
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224653; cv=none; b=R7DwYvo5HPXczkS368tK57pnxIwq4uplIXUuAVeAMtCCLMRUxTZo5DEANmoApIl9EtsHHHmZx8SHKBf3NoTbwzKVAUEONn9GdtnBMZB7cx7On52799cu/edsDLdzybhTi/V8SS1SqyJL5sNkH8KsOI7urZgligSZ/n4QBI3fCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224653; c=relaxed/simple;
	bh=hJkDm3W+fV7ZpBCUJIAmMowzdA2NGP/qVikG0lIhhuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0vKp88S7ZPm1vobEGXz7BYLGd/kG+PO7Wv1jy4jOoEQawPhj7jbUFPWK2bBj5iPrkbd5ud0iohCDw23kdAa7dfyYehHKlGcTcn2N/WbnQB5tDM/fquzpMOcNLu/RmW5UG9VpumTNcsSDBlOfD5P24YaGocW6oCoDhyhaXAC/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYhBugEs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYhBugEs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1203997f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224646; x=1787829446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/+XjvBzWoD2MQbLHFqUD6b0gTe8eLRAGn6npcOPS8I=;
        b=IYhBugEsjgG2ts7uUHamFNSjeJwcgbAkMzSBmmSOzY/siiFzBVlLQmMthstqNu2lSw
         tDOOQOEnC4wsj/D/qfwwiHEWczJjZ/VhpHv/sYq4/uQePt1YYjLjJLFJ7wuSD5xvbWHZ
         1WTAlB0rlQSiYClUIpZv23Xha38nXdxr9HT6x8qFaWnCY/F1SXCcbHIFpWnELxBYHFpI
         GxBCtIrgVq5i3OaiAI3h+c8cN8OTf0iA06K8ixhB9bdAVZgVtg3FDtgid7XuOdjx1beV
         pH2TxLAXneY6gjxQ3GNVzHIq2shx2LyYaUaZsTEqWrx3VlvvvriyK36rdD/Z5DxvDEvV
         j1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224646; x=1787829446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/+XjvBzWoD2MQbLHFqUD6b0gTe8eLRAGn6npcOPS8I=;
        b=CQUpFAAULG77+5KRfsl5M0OMchXK3QXxjMMOeSllTyAGi/Rq0RGrDrfrlPybydabZ9
         Hys/ey5aY9JNYq/9tu5OpDTpH8Kdt6G7KepkamMW9NozFklPdcW9sEEx6BNkAVxU3jbx
         /WD3M7zavcPGND5cwd68sBneYLMs3vRvwprGFZQOgtBsKr0UPncVzxP5OLCp+pi558TL
         vq7nw7+t1FaxVzWy6b30JzSB1Y+YkekDEFalX8xhZ0jpb71Xi7bL+ypLNyaW7tGG3ACw
         MAVnbA3jm+obi/mzlcmQvAeywQevBS/7+dO6kn7+Yz3qrZQCnH+jd7GObV4yjU5n7Q37
         H26A==
X-Forwarded-Encrypted: i=1; AHgh+RqMNpNtR/6y2O+noUOG9j/jo015jCp3wBXgyXiiBVesLVyQS6l59V2T4KcR0U3v0Vh8G9ujZcM=@vger.kernel.org
X-Gm-Message-State: AFuF++llpFQIyZVc9LQoBssKFL4nUx8truQFZJUlZHl1zsr0CI8HqIUu
	cGJxUEifjzp4odzWdyeOeruZPR4WK44yiiozhDYRd4hmxCdfjJzfaboytVtmoQ==
X-Gm-Gg: AR+sD11uCdRDYGjZudz2eReqSSitfIYnryRtsUh85/2Sn2WsFXIlnjSjIBy3KzGX5yO
	n3eFKfmVBB14EN2uhQn8yeVOjo8OVum17KxFmX9n9uuiiRnhW0cJ0O2rg/34h8mI+oRfDb6k+kG
	h+OZsuUachQFw3LIbOu5HYMrFmCglkrSJhiSHc0N5eT6ZcFaErw2F2eIFbwZmhb6Hw7rkI+u5ZS
	3C3uBOyGTzQYRTn7Xal0XbfBCIVMFFP8ku5p7k+XAAPy6CsgAsbWFx0/g0UekhxuAS//85pDP6q
	qVDi7iaiDoduZ/M2YBvLHlRFJbnGDJzU8U9P2lAYM2UL3JRuCW0GBk1SGhuIEjdoaLQa6864drJ
	PKdHaRm8WtEp/o2amXspnqBIHwXCrImscY5m0v8FGazxjbulo9Wu8hIw5jYEt48ddFAw7xMnsr+
	xiEJCTUSewStI0UZOiagbY6dhbV5AnvoUCAevzdFiYmatcayefZ9Twu4jh/Ql7adikgBdf75CWs
	Cqiz+N+SzE1h9Cb6S65f5qjgTbv3AO+brKw+nMZw1Jw6mBx
X-Received: by 2002:a05:6000:41c7:b0:481:5167:abda with SMTP id ffacd0b85a97d-482b1e9e2a8mr21500418f8f.9.1787224645446;
        Thu, 20 Aug 2026 04:17:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm12957987f8f.19.2026.08.20.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:17:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] media: v4l2-isp: reject zero-sized parameter blocks
Date: Thu, 20 Aug 2026 12:17:22 +0100
Message-ID: <20260820111722.1233915-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_isp_params_validate_buffer() walks the blocks of a parameters
buffer by adding block->size to the current offset, but never bounds
that size from below. A block with size 0 is not caught by the
block->size > buffer_size test, and the comparison against info->size
passes as well when the driver's type_info[] entry is an uninitialised
hole, both sizes being 0. The walk then makes no forward progress and
loops forever.

Drivers build their type_info[] arrays with designated initialisers
indexed by their block type enumeration, so an enumerator left without
an entry leaves a zeroed hole rather than failing the build. Drivers
call the validator from vb2 .buf_prepare, so such a hole turns a
VIDIOC_QBUF on the parameters video device into an unkillable task
spinning with the queue mutex held.

Reject a block smaller than its own header. A block's size includes its
header, so anything below that is malformed whatever the driver table
contains, and rejecting it is what keeps the walk moving. Blocks
carrying only a header to disable a block are exactly that size and
still pass.

An empty type info entry can then no longer stall the walk, but a block
matched against it is only constrained by that header size check. Reject
such a block explicitly: the driver does not implement the type and
cannot tell whether the block content is meaningful, and accepting it
silently would leave that content unconstrained until a later kernel
implements the type and starts validating it.

Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
Cc: stable@vger.kernel.org
Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v3:
- reject a block whose type info entry is empty instead of skipping
  it, so a type the driver does not implement cannot become
  unconstrained uAPI (Jacopo)

v2:
- skip an empty type info entry instead of matching the block against
  a zeroed one
- reworded the commit message, which no longer leans on rppx1

 drivers/media/v4l2-core/v4l2-isp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
index 1eb46e080afa..efe994b4c4d7 100644
--- a/drivers/media/v4l2-core/v4l2-isp.c
+++ b/drivers/media/v4l2-core/v4l2-isp.c
@@ -84,6 +84,13 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 			return -EINVAL;
 		}
 
+		if (block->size < sizeof(*block)) {
+			dev_dbg(dev,
+				"Invalid block size %u at offset %zu\n",
+				block->size, block_offset);
+			return -EINVAL;
+		}
+
 		if (block->size > buffer_size) {
 			dev_dbg(dev, "Premature end of parameters data\n");
 			return -EINVAL;
@@ -99,12 +106,25 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 			return -EINVAL;
 		}
 
+		/*
+		 * An empty type info entry denotes a block type the driver
+		 * does not support. Reject the buffer instead of ignoring the
+		 * block: accepting it silently would let userspace fill it
+		 * with data that a later kernel, once it implements the type,
+		 * would validate and possibly reject.
+		 */
+		info = &type_info[block->type];
+		if (!info->size) {
+			dev_dbg(dev, "Unsupported block type %u at offset %zu\n",
+				block->type, block_offset);
+			return -EINVAL;
+		}
+
 		/*
 		 * Match the block reported size against the type info provided
 		 * one, but allow the block to only contain the header in
 		 * case it is going to be disabled.
 		 */
-		info = &type_info[block->type];
 		if (block->size != info->size &&
 		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
 		    block->size != sizeof(*block))) {
-- 
2.55.0

