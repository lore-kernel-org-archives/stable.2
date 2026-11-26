Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677211;
	b=3qxW8w4IyvmyaIhIXel7nrq3MwdvUEhgQhrq27BE/UbjoF+EmSuJ+87X1MG2SwBQEBOj
	 /3xjEjrO3PTPYIsk/F0Z8zALD8mp0HaufRB1O1hKrQZ5DM6/BMltnsWqi6OOIhiuc5SL+
	 AlwugYugWjCDxImyGT+u+02TtYsTEztBQnZ5eFaVupEklt28NY178o7EE/rFPzqcKMoet
	 +bueyBWAacgwL9z2kqjFWOqeKaqD5stmJneFPAr8xImzBOwLwXZjXH8V/ySPsWNiiW64M
	 j05kQx67dWtBQw1sswVD1ecrM08ll/hql8cuu96D0WGVwjqqhGv3Pz6PM1aDvO4/jFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aVE6uQY9znCYqrgi6+/JSfmRMS1q7/GU0dj9T9uQX+4=;
	b=XeuhI6LuyiHrGrT+gY2E4RJNknweP4cVSZYRtQYAEKDpMkdEM0fk35rBX4cP7tR5ycSB
	 H6ZBsU6qox1GKX18PIwL+uNQK85UHakUVNWxx20N9RSn0c4QzRWySpaMsk8SrTlxJzA9t
	 1DPas3lknPPiHthqjZZKXWs7t5WY+jgParbTPHxrYAaqTB1fgjrLOljNMITljnkb2H3GF
	 fIt4zu8WphWy6w08nxXehD5F+Lo22CW1FF4UYYgDWfUIVr8uNFPw/SEq89NScSA6U+U4t
	 DFCNibuy/awwFedLVG+7n2BPP15gZ8S0Kekm/zN6+xJLDLTxuGOqcx6OzlgNBuL7xjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cnQnoygJ;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBA606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CBA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cnQnoygJ
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so2708872b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795677210; x=1796282010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVE6uQY9znCYqrgi6+/JSfmRMS1q7/GU0dj9T9uQX+4=;
        b=cnQnoygJZFyd6qqbDXu1P1IdIIs9W16GuDQhHY9PmSw5+USuvyeTqv7Uf5gktlo0kd
         UxhvRdD9jTXueiHQpd4ttqJjgrF1MACsSvc80aTTR7k+kuxw4nZ9yHHaDKYj47TgFNws
         g6XlrJmN/XIwzoMPDZz9j0WGszkrSlX6anbyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795677210; x=1796282010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVE6uQY9znCYqrgi6+/JSfmRMS1q7/GU0dj9T9uQX+4=;
        b=Ll7amcZ1zDPB8fgr42UiOxor5f2s5ICXPr905OlTgiL/36Azxfe2PeOtEAC2n/SY2+
         gPqdakCuZ9iOfmIfs5Qi9ykfaVIobPdn/ahD8ffxxrlD6oxlK1EWv01+dewZVKY+LO3P
         Uzw/2oHs+/LIvpKN9i4XCgOYFjzPz2Ns8J4KTf1EfBEsavoB6RIKH67sV0iVSfJWghah
         6UX441oYWYWJu2And5+jPACZxEDLnfk0gmU6YMqLPLFCmJ1j/ryBYQesDTKwSwJCDzjC
         ht35QSAZgDBaFBo8tyr8qEfsRZtgp9P2w9+Q7VleuWdZP71U6pDirUlU1dV1AoAa2uzY
         tU7A==
X-Forwarded-Encrypted: i=1; AL+hErGtnB9SrFv7GBORjus3MzUoXauv3K7zkHsj9doZBMGaXsoTbdYQta9/rW5p73osWNQONV+zdOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P58FLGAHgKVFThDA1I8aoTGg3nfj4IEoYO9zpIib76iK7nCmp
	hcGlenirzXJJStSJpjA76tFRPnTfqJLJJwS6YKW1jztLkrJURJOBvZ5k50SLQXMrmA==
X-Gm-Gg: AZFdTZd7JJsnUal8Mzwuqa7J5YOaJe3DgHl3v8bNGNJ1PLex1Bul+fPtctNbnSeATsQ
	HyCWsJdzDODbZT4idBsmHzelBPbZbtOBD7ilX2zxYnBC7gTPsClu63DdOIm0lIjg1749vzq7la+
	xOJhgIActFcntIG5Kp3Ys0WK1So9yHIClOSKG71yIa2gA8dNAztSFZ636sV+n1D7BwlKVlUm/PN
	YiyYFZ8q1cdyDkkbQ2qlo6R4Ec98k7V5c8i9EHyJj8FqLh4zn+lOnumwqXzmruuT5oRRCrwD343
	5EAooeL81VfJFV9LgLtlaulTMXgm/MFvxJjqSRGpX/72V4W7PNYUv+OUQiZM+rty8qOs7+xEgX+
	SKAxeJX06gNMfXWbHRf0Qo09Sylk/Q7rKHdpz3qK12VbwIisjKZyzi2ZXV7vcD8fO4cnWd3lbtv
	ED6VS0qnh0Sm3QXM+truAKWv5FdNFbkNT7XGa7zqQdT/3S3wkQrvDDb8KYg6FL4Hc/DU+AbC3Ds
	GyelQQa+H3a8ZqzACUAQV/onnHAq8FU8RHfRhhRcah/pNtk5aZGv6v9KszpLb7qahib1V0/LMgt
	4zrrecDXZOFVzJUwGZGLd/UUdXxJzj/kOPcDiPL7jk7FkyB+u9nk8meTzXVq
X-Received: by 2002:a05:6a00:238b:b0:89f:521:8089 with SMTP id d2e1a72fcca58-8c87bcbcfebmr18588681b3a.19.1795677210131;
        Wed, 25 Nov 2026 23:13:30 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8c87285b60csm10397352b3a.9.2026.11.25.23.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 23:13:29 -0800 (PST)
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
Subject: [PATCH RFT v4 1/5] drm: Split framebuffer pixel offset calculation from drm_fb_dma_get_gem_addr()
Date: Thu, 26 Nov 2026 15:12:49 +0800
Message-ID: <20261126071314.253890-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126071314.253890-1-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
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
Cc: stable@vger.kernel.org # dependency for next patch
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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
2.56.1.839.g22a8290db9-goog

