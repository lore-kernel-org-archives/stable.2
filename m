Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506060;
	b=bKzcCCAyz69F4gNe9ihumltSkDo2N8W2V4jv/nPOL+ci9DjCEItlIuxuCQsTupovzxX5
	 Nf2mP+8J8bvnlE7GlPwbSaQHWtcrrEsh41VG1UlHdh/B/sX7GRBQ6W8kL59XoNJZINFSm
	 uqCpEd3G2UIKQJz4YaIOYDL0FlpBxqoui0Kyxnnqiz3S7jvt0J77lbWzwWJeX1luguDqO
	 p4iDSz0DnpAQA+RXUmt8v5QW4ovcto8AmZ8/1j2Esb9R74iVqFm0Q+RpTYILllGRx2AFN
	 RoMsRxlzMwDZqqFTDyd0p+nl7AAPCSbEwOqCtPvuTZHalW09nc9vGZ+md5QeXmTk7EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NOv+lCeuytPMgK0k4vfCvQSlUO2ysKfU7YDIKLNZGwM=;
	b=VgKy6UXWN3nQ1sxsOpjCdwiqWiaEIyQHtFSZROCpR0g3il2VZFDiuhz05qXR9k/U+N1+
	 KEDkONUobXcgT02vrKFfr9XY3peinFHA9dedHnYKM39+paekIP4KYAtCEVypwLe1MNpSz
	 /T9w/gljH3M/akj7MJW5Yvx8D+3FIgIRrzofIbQuoPXtyBcF6xuE9EzgdDzKRc2tvrF+V
	 zNpaGd59FqkLwoTQwgeace7Z4SmmKueWtSgZ9JamO7T6dY1SuaivSy8ndmxwvOZF8WIGF
	 s+tO8slPRbgVkDIl89rkXzZbUh7L08+5t1Ti3OqSWof/4RDvgx8nj+d/G8AVCPPU1WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BGwHNzg6;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D7606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BGwHNzg6
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb9f760337so2615536a12.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795506059; x=1796110859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOv+lCeuytPMgK0k4vfCvQSlUO2ysKfU7YDIKLNZGwM=;
        b=BGwHNzg6yGKiEYzSySG08M5ztoRkcWXMKqjfKM7V95/voTLjUVIwPd97Hs0O6oAXCC
         qoNaoDCEb5wChIVbJXt6tnqYojBDE2JNn7bBzNMdQRr1slpl5Btr6lrS3WGB0U7i2dhP
         /FR0dtuQL3z4PrYqSjJCVkt6eUTBvQ13lGDkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506059; x=1796110859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOv+lCeuytPMgK0k4vfCvQSlUO2ysKfU7YDIKLNZGwM=;
        b=Sr9ag1B3NtrkfMMzytb/mPNE6OOwd0nMQ/f04LdCdFNndskCMM1R+u5V2DjyraeE8J
         k6GeMTpW595FVSO/b3sqhPwH+AorBJUWMV1yfKbGe4ODt1FWS3NhJHCZb1m9vh7Io19k
         MpRGpi7+Jc88byVKZA62snAKPobm1OYL/IWzMnwmx63e0wEsDbskKYsJ2rgQ6GURKwgA
         KyO1mIlMVNI2A1d4RGXv6QShn/P7Wh2Kp8xgLW1+ViyVC9KaB7iu3XDJee84WQUUp5JC
         aPuhtVohrvck/9qp826h5i73kwMeat2rdZOOe+8aSgPpl8lgxIFMAa9E5EzwBSdljecc
         8Blw==
X-Forwarded-Encrypted: i=1; AL+hErEtfP2imHeiNrxx2FKwRQziLneNGv2eFed+yMg9aLeJLSp05P12O74Gaz3eepB7ax6onHMtAkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zbEgssSr2azbZsMELnzyOC4XDCYIK9VBuO3pljTRP/pdcbkve
	eMVzuiiETizxr4tYfqLlMq1c1ogpXz90aVaspoH3cwGh+OdX910OAeZxaJ6SKD1O1g==
X-Gm-Gg: AZFdTZfC3APwHg14cOdFn57jDAwVBfCyhl7OiuUx2+JULicuXIRBGhzfhdP+rTQgXZI
	hvbbWdMjIhYw2ScaBTRnVRUA1qgMCf3t2FnfyEvcR12JJg6JncnOH38NxqScdNtipz9Mwrb4who
	HfY7N3j9XoS/1dtieFswxtaj92pi3SiiZ8bNCVeXFqylJ5lgws4gUYoCKHIaKHiZmdBTmWtlY9t
	lCyQzZ9nD0pZBFtlEsbsyUSKEunK361oikRHrII2MEp/DvOQjuKjQPtUbE6Ayf6scR1qgHBcB6k
	Sq9NJ7croTqRzqtYqywmKvOr1d+lfONyZeHqOChpAVoYziSvaQbYVT3pSgOAyXZMr/rKXAN+Owp
	rE87jtjBrIDlpcutUHGTAmJn2a717zrZqvGXseyx1ZLoNQRZod1g4A6UbeC20EfLQ+EnTPBEPJg
	4LCUjGcuBFm33CRlw0e2/fn7TofGWinPp/1Fx1m9PjRHhe9xpXzKD3F6eq3oVlZelZ7xB4dHm42
	QWt23jEghMGToIrVQ+VsO7Ux6mjOfth+n6EqKXzHk4T7pcxygVQ0gx5mBpGaoOxh6YM5xlbQBah
	A82dQ+ArENep3moyGuYEvJIIU3+KJdb5r83yRKrt4vDYpkgbU5VKFca/rJhTvt2YSRsPxOEd3De
	fyo2R9A==
X-Received: by 2002:a17:90b:2247:b0:3b3:fe38:d8d4 with SMTP id 98e67ed59e1d1-3b40a5f92ddmr11465678a91.34.1795506059023;
        Mon, 23 Nov 2026 23:40:59 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde6cfc8829sm6568259a12.8.2026.11.23.23.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 23:40:58 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RFT v3 1/5] drm: Split framebuffer pixel offset calculation from drm_fb_dma_get_gem_addr()
Date: Tue, 24 Nov 2026 15:39:29 +0800
Message-ID: <20261124074041.115251-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
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

Currently drm_fb_dma_get_gem_addr() calculates the offset into the
framebuffer memory for the framebuffer's unclipped source coordinates,
adds that to the framebuffer's backing storage, and returns the result.

We are about to add a variant that uses the clipped source coordinates,
so there is already some reuse of code. However, calculating the data
offset for a given pixel is not specific to the DMA FB helpers. The
offset is only related to the framebuffer.

Split out the offset calculation into a new framebuffer helper so that
non-DMA users can also reuse the same code.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # dependency for next patch
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
fb->offsets and fb->pitches are (or should have been) checked by the
driver's .fb_create callback, either in drm_gem_fb_init_with_funcs()
or reimplementing the checks directly.

Changes since v2:
- Change offset local variable and return type to u64, and use
  mul_u32_u32() to avoid 32-bit overflow before widening
Changes since v1:
- New patch
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
 drivers/gpu/drm/drm_framebuffer.c   | 46 +++++++++++++++++++++++++++++
 include/drm/drm_framebuffer.h       |  3 ++
 3 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..ab0f37d8a5ff 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   unsigned int plane)
 {
 	struct drm_gem_dma_object *obj;
-	dma_addr_t dma_addr;
-	u8 h_div = 1, v_div = 1;
-	u32 block_w = drm_format_info_block_width(fb->format, plane);
-	u32 block_h = drm_format_info_block_height(fb->format, plane);
-	u32 block_size = fb->format->char_per_block[plane];
-	u32 sample_x;
-	u32 sample_y;
-	u32 block_start_y;
-	u32 num_hblocks;
 
 	obj = drm_fb_dma_get_gem_obj(fb, plane);
 	if (!obj)
 		return 0;
 
-	dma_addr = obj->dma_addr + fb->offsets[plane];
-
-	if (plane > 0) {
-		h_div = fb->format->hsub;
-		v_div = fb->format->vsub;
-	}
-
-	sample_x = (state->src_x >> 16) / h_div;
-	sample_y = (state->src_y >> 16) / v_div;
-	block_start_y = (sample_y / block_h) * block_h;
-	num_hblocks = sample_x / block_w;
-
-	dma_addr += fb->pitches[plane] * block_start_y;
-	dma_addr += block_size * num_hblocks;
-
-	return dma_addr;
+	return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
+								state->src_x >> 16,
+								state->src_y >> 16);
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index d32aceb6ca9b..589619bd8f0b 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_atomic.h>
@@ -1208,6 +1209,51 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
 	}
 }
 
+/**
+ * drm_framebuffer_get_block_offset() - Get offset to start of pixel block for
+ * the given framebuffer and coordinates.
+ * @fb: The framebuffer
+ * @plane: Which plane
+ * @x: x coordinate for pixel
+ * @y: y coordinate for pixel
+ *
+ * This function will usually be called from the PLANE callback functions,
+ * or from one of the helpers that calculates the framebuffer's DMA address.
+ *
+ * Return: offset from start of framebuffer to start of pixel block
+ */
+u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
+				     unsigned int x, unsigned int y)
+{
+	u8 h_div = 1, v_div = 1;
+	u32 block_w = drm_format_info_block_width(fb->format, plane);
+	u32 block_h = drm_format_info_block_height(fb->format, plane);
+	u32 block_size = fb->format->char_per_block[plane];
+	u32 sample_x;
+	u32 sample_y;
+	u32 block_start_y;
+	u32 num_hblocks;
+	u64 offset;
+
+	offset = fb->offsets[plane];
+
+	if (plane > 0) {
+		h_div = fb->format->hsub;
+		v_div = fb->format->vsub;
+	}
+
+	sample_x = x / h_div;
+	sample_y = y / v_div;
+	block_start_y = (sample_y / block_h) * block_h;
+	num_hblocks = sample_x / block_w;
+
+	offset += mul_u32_u32(fb->pitches[plane], block_start_y);
+	offset += mul_u32_u32(block_size, num_hblocks);
+
+	return offset;
+}
+EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
+
 #ifdef CONFIG_DEBUG_FS
 static int drm_framebuffer_info(struct seq_file *m, void *data)
 {
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index 38b24fc8978d..6f838b485730 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer *fb);
 void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
 void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
 
+u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
+				     unsigned int x, unsigned int y);
+
 /**
  * drm_framebuffer_get - acquire a framebuffer reference
  * @fb: DRM framebuffer
-- 
2.56.1.809.ga0b61035b5-goog

