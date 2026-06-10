Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EC3A3E60
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080404; cv=none; b=mkrq6RwALXG1EzrDWW/VMR5O3sDF0FiG4UZr+maQlZUxK2DksL8/e3M9y9yqHFRbIyPHewuqUe20B+Yyg0XNRW5t5F4B5tdObBUUCwyJOR2LNgZqrRnV/roWHLJEpsAV5oPTKKpGpiLHvGcbQ+JqrEcy+BpQz2yCWZQ+8cVyNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080404; c=relaxed/simple;
	bh=2llO2dVILzpfY+LXwwJho1Es9pF2lxdReQMG1p6oU6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qoh8UaaAkmCDb3fwk9q3/9ovJ6/boLoROb3UHUz6hiuamfPgjAMpIZxfJ5mLBZTY6z+nOsSxLPZ6XNgRQMTpKIZNZo2Zm3I7zPjSXA370oT7quZbUUCWFC8J+Vbu62uHc9nMdrm59JakKP4VS4S071dNO7dvgq/dQzOveMhH9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPoOMg0B; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPoOMg0B"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so5015408f8f.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781080401; x=1781685201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
        b=OPoOMg0BB7XTlij3+aCbjlZ7UxsgejisZRAxLfRzIgIOq0n/wgdHPWcgw4PBQELm8q
         njEpB6RigEyU1Ia44oG8NUcVr+Hro0yiOUGw5byQsGQezm8UhfGdOMoR1K6lJG2GGNLH
         jo6dJacQTQ+zQKJFSklKYOl25tX5lhbn4ZCc14TIQDXg8oE2dKalcOS5R3N5VGwUKzP7
         V+RUKvAGk/ziJE4mzF3I5ctV1rjcun9TZgkvBNofUsVq72hnlZyeVfm4RcAPlDhVTUQl
         cvkif9s1Pwm94wAI1Zrd3tCoZCF109R1e1Oq/rWjKJLhLk3HMoJiVKQzWMmHjqkWvJOy
         Npzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080401; x=1781685201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
        b=Sajzvnc9c2sam154YS1Gsv6pDH/3fTIgaFKthycPBNshXt9cobUpZ4KVy0GelHNKQj
         RORD8BYBSHTOBaPRI7/LFpMaBhLH1+X+ljJk3yMGJxcVEcRNyjGHnB+jIG7xce5dq5GE
         iLEkxvAzNBVAyIeDXDrXKU8RgIFWXTZnziM08qIuAffhnOkboDorMse8EWfWNFN8lcjp
         po2VD+hOnbJ0X28o+m7Lyu0tMMK9Tz+GawGa42vmVQ9H4OzBkm5v/5I8mSplpLHya4N5
         saFBz2gnAo3yBQh93HvYN3dVzWfUZtq25RtNjx8g4NlfDF5vWwVfnevqZUS2mKlfW6ap
         totg==
X-Forwarded-Encrypted: i=1; AFNElJ/pCfDF5m7blieQYhYEN2cxahycNETInlFoF/GdcM/Ul9NkCMCBlP487UvTbnv/ozt+5GbgqaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXj+OB2iFNUw87hBb2fIlSVo41a3ekMZ1lKrMO3ZzPXPshq2J
	SGDNy6idGc7J7a3eJxaJFCtbRnkpLfiNtNOLwyM9NXOjbf1a0p2YmQCQ
X-Gm-Gg: Acq92OFusxuGg+dMMLRq5xLxVaU9/mrBYmmmXipOFM/VyeVDmLEhrGkSyLRzM5f1xlW
	t3ZuNe9DceYohI4KzH5Q5EYGKF2MgDppSXT3B/6KgYPdOB0FG17edmiKzL+3z4QVpeVcDd+4xqP
	4B2K3Mpfsf89m7SB8A6kBI16LkyFxh/xGlBy7sNmBBIyPzo+FCqBcqGKFmz8olqgRS/QnDyKtXn
	rHEoyURPXa0ta+uePkpWGhbxnewQGTN+lCl0g+yGlC4DaR+yDHAfzzNKtUWUIaGk55UzVmVQU4g
	0B0fPFnq8fViTzaMxy7abr7yws0kfhR5bO3oszc9EA995WzzqAuj/ijp6h6DWczXGeotV8A99wU
	JV4s7u34NIKny0axXSbR/PxxE1dqnGYKvJg2b3CJO8AJJFLutmAlCfK7671zchJkUyLoiTGLTWs
	T5vzup95mb4oDFns46slugIFv01bOzlBS7MxaXoGvkgROUqn2ldRwj2sCgYuQwUJM/5Hpg06I=
X-Received: by 2002:a05:6000:2b0b:b0:45e:ea2a:dd79 with SMTP id ffacd0b85a97d-460302e0a31mr24547521f8f.4.1781080401290;
        Wed, 10 Jun 2026 01:33:21 -0700 (PDT)
Received: from aldebaran ([193.165.157.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm76213092f8f.35.2026.06.10.01.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:33:20 -0700 (PDT)
From: =?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	stable@vger.kernel.org,
	=?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
Subject: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
Date: Wed, 10 Jun 2026 10:32:45 +0200
Message-ID: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
GPU page becomes one blit row. Large copies are split into chunks of at
most 8191 rows.

The kernel register header names the packet coordinate dwords SRC_Y_X
and DST_Y_X. In the BITBLT_MULTI description in
R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
-8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO base
and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
exceed that coordinate range.

Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
destination coordinates. r100_copy_blit() already packs
SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresses
belong there rather than in the coordinate fields.

This fixes Prison Architect corruption with 4096x4096 mipped textures
after they are evicted to GTT under memory pressure on RV530.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Ondračka <pavel.ondracka@gmail.com>
---
 drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 3ac1a79b6f13..533215d6e9cb 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 {
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	struct radeon_fence *fence;
+	uint64_t cur_src_offset, cur_dst_offset;
 	uint32_t cur_pages;
 	uint32_t stride_bytes = RADEON_GPU_PAGE_SIZE;
 	uint32_t pitch;
@@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 			cur_pages = 8191;
 		}
 		num_gpu_pages -= cur_pages;
+		cur_src_offset = src_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
+		cur_dst_offset = dst_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
 
 		/* pages are in Y direction - height
 		   page width in X direction - width */
@@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 				  RADEON_DP_SRC_SOURCE_MEMORY |
 				  RADEON_GMC_CLR_CMP_CNTL_DIS |
 				  RADEON_GMC_WR_MSK_DIS);
-		radeon_ring_write(ring, (pitch << 22) | (src_offset >> 10));
-		radeon_ring_write(ring, (pitch << 22) | (dst_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_src_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset >> 10));
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
 		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
-		radeon_ring_write(ring, num_gpu_pages);
-		radeon_ring_write(ring, num_gpu_pages);
+		radeon_ring_write(ring, 0);
+		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, cur_pages | (stride_pixels << 16));
 	}
 	radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
-- 
2.52.0

