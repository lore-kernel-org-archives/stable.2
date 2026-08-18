Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035F459AFC
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050610; cv=none; b=LGMQocnZCgoCSHCRh2ip16nwqkuapcG3BniwkC/mE0PNSNzE9Y2ytGo6qADM8ApchuWFG9vHmoEeX2xUAo1gmrJYAEmN6S0EJfjHW9dV1NlEisfrq5Q1GYsFJayX2z7ZtE7xd0KGGBPCV/Q4/9y7QDjb9o5mciDGNhAJbcLCiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050610; c=relaxed/simple;
	bh=LtJEwEmUeUmRecVw8rIzf4qNZ0bPe8mKIWeBWWWXbl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWPVvdQ2ikEOUfDBIVu+/hQXINfkxdhTV1jtLvwxAVpEWboFH+uQCyg8aPImnfugDVsQIT1iT4cHI2ZBcaz8fSEjgLg8eFwb8lx2GyzLLOcdHHQKAqcAQv3I4gnWTlk1lIJ1Ep2CVbnKjTAjMv25Wlz/vjApJv/7ntwXs6EqcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD8ATTlC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD8ATTlC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so4257882f8f.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787050606; x=1787655406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9shV1QZCHqW8FXaqflZ+eE8Gymv9k8sKCSVo4d0l9E=;
        b=DD8ATTlCWDBKGbXeqqeHdJwfA5+hY20YA0vcT48IUWCi7WwQHzTw7UFPtKeLh7zKDQ
         hVIp6Mh3Zy9r+hlkcV7tq4lfSRj8KarOMH1hsU0wtU5TsMwPpQojH+nbj6GlOLbIeLv4
         +jhZO00vcRxiZHNXGgeF3S+hR3L32dB4COdBPhYuHCNQFm0yKxrmuDtj6bqNZ+dc+YXg
         +YtFIbR4weY1BBQz0B7rP74nQ/MdPXSdv8GEvvNZrTZ3qEM7+90jFhcskr9MeYecdSFy
         qEbjkpuDZQpGRMLUGgTgtiysv0GbpIBS/C1CEamLhE0U4nsXfqErXQbL14F8RQRKrdoG
         uHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787050606; x=1787655406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9shV1QZCHqW8FXaqflZ+eE8Gymv9k8sKCSVo4d0l9E=;
        b=WFUSTefJUi/6/7akn2qLbCklKH7EjCuQQKe+vaIUfqzG1RdzUa4tVlGY55QX5+496r
         +zg8rQB8dYVH7OoasaG/L9v0MfIUN0BSBaBGWGo2gKEVIHHXXuoBWstBZL82M6Ch6CKa
         ir396I81ETYO51lpOeeBZ+erE6a/vUI+MF3I23vO+rxdjhjm/xxy7duh8mnwCgXaSW2E
         NSjbfp/DweXrPIeU68y7GJc3/4K+SwBQyGam8cpLFzuDWc9e7EtaUb3Tb1GdQWk4yQs2
         UtbPs/ASxNk+ZD2JCDMjUsXGAvf2ejrBeyBM+Knidy1/+dVslldakr3hseERXuImlBFK
         hxIg==
X-Forwarded-Encrypted: i=1; AHgh+Rro67ZMFRSow3x17u8Xt1+DIH7Zkns+WyCI8zu6jdHOxO1cMIPvCUwgoPrKqyFxia2Y1XPRRJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WIh+VMzkuasIJoW6tfGFf70dEeD015KaSpg7mm0mvpsSZcao
	oUUjKRleAxJ40+NJD31BSZXheSmPGg5w8x9DmDkzP0yMgT6cggMzjBq7
X-Gm-Gg: AR+sD12JxVFD3dvDCj9LOmyXPxc0LYdp1sTC65PwodUdIxk05ZQGJsHor5VmOYtY7UG
	7CV1rXuE4PtpvUJsdHxHyN9Py353qt67ZDn8VOao39SoiVNNqDcM87NNIO+/ol4J/y+uCuB1dr9
	y+0nuXrRdpJ0OjGHx7ovnqsSRwJmPbsC+giuwsSGmrGmQdtrlWHAEf/WtTR4WaFqmROd5xEFsuI
	R3zYb1VR8sWuU/I9XJ0/U6z7itZdh2kvgvcUGSCMw3WRrS1TuScB2SEIUa1IT8QUxdMHcrrceUF
	Buw9pdq8NwmqdUgKdJrOp0i69I7ebt74zcNSjsQbslG+ixVq+tIK6LYEMQz7obli+Q/YX54OTiV
	GQcb3/Ly+9vo85F5emT7WW3659AclUqswsNjNleOc/mvpIZPPn02E3thbZOGdqej6Yfgw45girM
	ncPefCW53dmNmlsOkBsrK29lpAUKHahdFmuvOaE06vTRStZ9OKlJfolAva6sF1vBHsZgabXiuaL
	8EKpTR1zexvPheyvJnWbIsGGY8rzVV6MSC1Oi5cX2+7foJb
X-Received: by 2002:a05:6000:2994:10b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-482a90e928fmr10235086f8f.22.1787050606226;
        Tue, 18 Aug 2026 03:56:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816f7sm10433069f8f.34.2026.08.18.03.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:56:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Riesch <michael.riesch@collabora.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: v4l2-isp: reject zero-sized parameter blocks
Date: Tue, 18 Aug 2026 11:56:42 +0100
Message-ID: <20260818105642.65381-1-devnexen@gmail.com>
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

An empty type info entry can then no longer stall the walk, so skip
such a block instead of failing the whole buffer: drivers may reserve
uAPI block types they do not implement yet, and are free to ignore the
block when processing the buffer.

Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
Cc: stable@vger.kernel.org
Suggested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
- skip a block whose type info entry is empty instead of
  matching it against a zeroed entry, so a type the driver
  does not implement is ignored rather than failing the
  whole buffer (Jacopo)
- reworded the commit message, which no longer leans on
  rppx1: its missing AWBG_POST entry is being fixed at
  https://patchwork.linuxtv.org/project/linux-media/list/?series=29170

 drivers/media/v4l2-core/v4l2-isp.c | 41 ++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
index 1eb46e080afa..439477b2b941 100644
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
@@ -100,23 +107,31 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 		}
 
 		/*
-		 * Match the block reported size against the type info provided
-		 * one, but allow the block to only contain the header in
-		 * case it is going to be disabled.
+		 * An empty type info entry denotes a block type the driver
+		 * does not support. Skip the block, it is up to the driver to
+		 * ignore it when processing the buffer.
 		 */
 		info = &type_info[block->type];
-		if (block->size != info->size &&
-		    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
-		    block->size != sizeof(*block))) {
-			dev_dbg(dev,
-				"Invalid block size %u (expected %zu) at offset %zu\n",
-				block->size, info->size, block_offset);
-			return -EINVAL;
+		if (info->size) {
+			/*
+			 * Match the block reported size against the type info
+			 * provided one, but allow the block to only contain the
+			 * header in case it is going to be disabled.
+			 */
+			if (block->size != info->size &&
+			    (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
+			    block->size != sizeof(*block))) {
+				dev_dbg(dev,
+					"Invalid block size %u (expected %zu) at offset %zu\n",
+					block->size, info->size, block_offset);
+				return -EINVAL;
+			}
+
+			if (info->block_validate &&
+			    info->block_validate(dev, block))
+				return -EINVAL;
 		}
 
-		if (info->block_validate && info->block_validate(dev, block))
-			return -EINVAL;
-
 		block_offset += block->size;
 		buffer_size -= block->size;
 	}
-- 
2.55.0

