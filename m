Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D30525A78;
	Wed, 16 Sep 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573433; cv=none; b=dN0p5xQUZoPjhqTBzU7oxhBhp9FT8q85u7Y1/PWDqOc4LdZPWCLLALIY3l6PjPK1a2JhNQ9PJVEvFJMDm7KdJgCMsttD9G4O4u0ODWywKVHtK7ffLJqnG82QZcPMP5iR60nRgqVIAdf+UoOlAeHTRCo+jcrV+4bR2N3GHySdXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573433; c=relaxed/simple;
	bh=x6J2ve3jsQpfxSG78Ce8o42jmMaY2ygDvCvO4uWc9E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRoqWTVVArgoTSND/8JhT/SCEdDVqItAbabl6t4vFhvEFb1swDMOkM6/YLNrw3kxs5Nf938PnSBVhmqjJhNeYOsjFpYyKflSQfwyMOLh8vBpBAnQzOjCQDKMtVg4U+sTzXJATiW98GQteso8IvaVJE0UVlGx5r3Ote8ZYb+hKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFD8suapqIAdtCA--.21260S2;
	Wed, 16 Sep 2026 23:43:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	maaz.mombasawala@broadcom.com,
	martin.krastev@broadcom.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	zack.rusin@broadcom.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix surface reference leak in crc_generate_worker()
Date: Wed, 16 Sep 2026 15:43:12 +0000
Message-Id: <20260916154312.2060360-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFD8suapqIAdtCA--.21260S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1UXryUKFW7uw4xGFykXwb_yoWfZwb_C3
	4DXrn7XrWUGF1ku3WIv3s8CF9ak3WkurZ7Za18tw13GasrXr1UKryY9F95J3s7Wa1UWryf
	Cw4qg3WfAwnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcS
	sGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqpO80jwABsz

When vmw_surface_sync() fails, crc_generate_worker() returns without
dropping the reference taken by vmw_surface_reference(), leaking the
surface on every sync failure.

Unreference the surface before returning.

Fixes: 09f34a00272d ("drm/vmwgfx: Make sure the screen surface is ref counted")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..8c5fb552a40c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -135,6 +135,7 @@ crc_generate_worker(struct work_struct *work)
 			drm_warn(
 				crtc->dev,
 				"CRC worker wasn't able to sync the crc surface!\n");
+			vmw_surface_unreference(&surf);
 			return;
 		}
 
-- 
2.34.1

