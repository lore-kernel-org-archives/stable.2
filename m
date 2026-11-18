Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038473;
	b=Oe4eaFq5BIkT5BZ+JSynaXIQpvZB9IPE6fbHxU+IOgJrYOBaSFezauxcaALT1AMOVH6e
	 LrBPnsx/pQG7hXYTencR5NuiGvcrhiG5N2t8sspbpdzmGv2F1SAQaz2LwPO9WNSxyJITz
	 ncstfW1Ln03T0JaV0ny0cG/RfyKmO/ECSDW5CUO432S6Mte7rpQeRd7yEQb/y6RzYuz2h
	 EZ1ywMXq/ViBkd5zcWhNX3iiSTFpLQ6RLztJPc8M+PPJxihj0f7Tu0bH8tKUSGa1OuiS5
	 6CJQ9ENSdUFx4YsxS8jDdPI2GHlcizsZ+8uS2MJgiZIyqIloTik8P4CQDXGYLnUQ02w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038473;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DSiAzRz5MIjqj12rygoWjMUou4UoCjMUOgWeZ1VDPU4=;
	b=T4Dw6TbmQIi/V2EPmbWzSlh01Mj4Lj5+Tlsm9CFIg2z4B+1j59vgjPYld85Ru+lZdxnt
	 /Gd3ce50yijS/xnyioQJMGFTWGYe9ERRfHJbJNe1fqIJ44QtkaaNcPEYFzzY6Qnhq/lit
	 BwJorSsTc+5JAqVGVVBBFU8InaWMZJIVTL5wiNIZBEuHP01dmjA8/GmVmVKuYX68Cm181
	 jOwS0c7PPZ5mpU5zY3KLgPvx208kWIgJt/CmrVrHvdPraqV9PrrIAL37uIIsP3Q8pSbgM
	 p8gFD4Xg+bBnCO9z75jETpNAwCY7pYmhbN569R3j4pGKY8gc++KsXzzcfPpjZebo6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GAGczhTu;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104D606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3104D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GAGczhTu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=DSiAzRz5MIjqj12rygoWjMUou4UoCjMUOgWeZ1VDPU4=; t=1795038473; x=2110398473; 
	b=GAGczhTungdokbz46d8k6tp0/a5/bGwBy+EZh4EBzAZ99XWAGNBtiBU29MXMVHktsDqLYE+RqzE
	FlOi9Y6tiV6/5vtV8GeFLYXXrQO4Npx8+XzYpBYO4k108+AmmJUdf+fed5i+0R/5T8WXn872ls8Rk
	BDK8ntJYfGG2KQoRBa50CFDPH0KwFzIksJvru9yjQojDPb4Gs/z7dQS6zbrq4pRStLaBiZy8MQVof
	DlzR1tCww2XZ9QdFPllFJ0zmy4/GcXvHrvXO6Uw3R6MsRFgCZF4t2Ul1SJHhuHPmAFS/q+WNoqEmb
	7XY/whjsx/HbYd4EEhlLheTEx4oOjyoU3ZRw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTnVO-00000001DOD-2Cqv;
	Wed, 18 Nov 2026 22:47:50 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 18 Nov 2026 18:47:30 -0300
Subject: [PATCH 3/4] drm/vc4: Start shader code at varying offsets in its
 BO
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-vc4-icache-workaround-v1-3-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7331; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=M4tq1OKGXxeOKX3GWqc5ZHUiHKIsKMNHJrbPYz3qbTM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz2d6kfLe1xpYg2nB1H5F12KmTa4JUFGSfPH
 KXgY5s356mJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qoD1B/4xFGeZi3VnCwo5Jiol5XNtePzOOLvEMlVN0/ZjO0wF6O0ZaNLR2AXc4tLoMXdjNF0Wn8O
 vqL1c6Q0CasIX2pHoY6xonDWuotga7aJwtcUFH5K0VGrD4oKbpC1BqCb1lJjdWYTKRTRLAwyzXn
 qNEHYAIG1ctpBYLool9DEj1lzr7dgSxIImqDkx8m5CsjdfB2+ZrSTcgjlQnjPkBdSY1H/YjXAQW
 CEtkhqM3n0MuzEYkg+2ZJZBMM0/Gv11iDCNLN6iStD4foMhzrBwjfxMe7EvpLPRloVFeTQ1Zp9J
 6uPL3VvFMxO4Yd8Hg8AIW5xWlR1upd5nCXr0pPJmXf/dXvxv
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

VC4 is affected by the HW erratum GFXH-16: the QPUs can get stuck in a
loop where instruction cache loads are evicted before they are used.

The QPUs of a slice share one instruction cache. Shader BOs are page
aligned and the code always starts at offset 0, so instructions at the
same position in different shaders end up mapping to the same cache sets.
When the four QPUs of a slice run four different shaders, their fills
evict each other, no instruction executes and the hangcheck resets the
GPU.

Place each shader's code at one of four offsets, 256 bytes apart, inside
its BO, and add the offset when relocating the shader record. Shader code
is position independent, as the validator only accepts relative branches.
The offsets are tracked per client, so shaders a given client creates in
sequence (which tend to run together) start in different sets.

Notice that this approach makes the livelock unlikely, but not impossible.
The next commit will address the remaining cases.

On a Raspberry Pi 3 running the issue's reproducer, GPU resets went from
dozens in an hour to none.

Cc: stable@vger.kernel.org
Fixes: 463873d57014 ("drm/vc4: Add an API for creating GPU shaders in GEM BOs.")
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c               | 43 +++++++++++++++++++++++-------
 drivers/gpu/drm/vc4/vc4_drv.h              | 10 ++++++-
 drivers/gpu/drm/vc4/vc4_validate.c         |  3 ++-
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |  7 ++---
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index da4b11b7ce9f..2ab7c158b7ff 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/overflow.h>
 
 #include <drm/drm_fourcc.h>
 #include <drm/drm_print.h>
@@ -836,6 +837,19 @@ int vc4_mmap_bo_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+/*
+ * QPUs sharing a slice's instruction cache can livelock evicting each
+ * other's fills. Considering that shader BOs are page aligned, any code
+ * at offset 0 maps every shader to the same cache sets. This makes a
+ * livelock more likely to happen due to GFXH-16.
+ *
+ * Start each shader at one of four offsets, cycled per client, to spread
+ * them across sets. The use of four different offsets is motivated by the
+ * number of QPUs per slice (4 QPUs).
+ */
+#define VC4_SHADER_OFFSET_STEP	256
+#define VC4_SHADER_OFFSET_NUM	4
+
 int
 vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv)
@@ -844,6 +858,7 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 	struct vc4_file *vc4file = file_priv->driver_priv;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_bo *bo = NULL;
+	u32 offset, size;
 	int ret;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
@@ -865,29 +880,37 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	offset = ((u32)atomic_inc_return(&vc4file->shader_offset_idx) %
+		  VC4_SHADER_OFFSET_NUM) * VC4_SHADER_OFFSET_STEP;
+
+	if (check_add_overflow(offset, args->size, &size))
+		return -EINVAL;
+
 	ret = vc4_grab_bin_bo(vc4, vc4file);
 	if (ret)
 		return ret;
 
-	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
+	bo = vc4_bo_create(dev, size, true, VC4_BO_TYPE_V3D_SHADER);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
 	bo->madv = VC4_MADV_WILLNEED;
+	bo->shader_offset = offset;
 
-	if (copy_from_user(bo->base.vaddr,
-			     (void __user *)(uintptr_t)args->data,
-			     args->size)) {
+	/* Clear the memory around the code, which may come from the BO
+	 * cache.
+	 */
+	memset(bo->base.vaddr, 0, offset);
+	if (copy_from_user(bo->base.vaddr + offset,
+			   (void __user *)(uintptr_t)args->data,
+			   args->size)) {
 		ret = -EFAULT;
 		goto fail;
 	}
-	/* Clear the rest of the memory from allocating from the BO
-	 * cache.
-	 */
-	memset(bo->base.vaddr + args->size, 0,
-	       bo->base.base.size - args->size);
+	memset(bo->base.vaddr + offset + args->size, 0,
+	       bo->base.base.size - offset - args->size);
 
-	bo->validated_shader = vc4_validate_shader(&bo->base);
+	bo->validated_shader = vc4_validate_shader(&bo->base, offset);
 	if (!bo->validated_shader) {
 		ret = -EINVAL;
 		goto fail;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index f68486be08a6..62ce83322d1b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -255,6 +255,9 @@ struct vc4_bo {
 	 */
 	struct vc4_validated_shader_info *validated_shader;
 
+	/* Byte offset of the shader code in the BO. */
+	u32 shader_offset;
+
 	/* One of enum vc4_kernel_bo_type, or VC4_BO_TYPE_COUNT + i
 	 * for user-allocated labels.
 	 */
@@ -802,6 +805,11 @@ struct vc4_file {
 	struct xarray perfmons;
 
 	bool bin_bo_used;
+
+	/* Counter picking the start offset of the next shader BO's code,
+	 * see vc4_create_shader_bo_ioctl().
+	 */
+	atomic_t shader_offset_idx;
 };
 
 static inline struct vc4_exec_info *
@@ -1089,7 +1097,7 @@ bool vc4_check_tex_size(struct vc4_exec_info *exec,
 
 /* vc4_validate_shader.c */
 struct vc4_validated_shader_info *
-vc4_validate_shader(struct drm_gem_dma_object *shader_obj);
+vc4_validate_shader(struct drm_gem_dma_object *shader_obj, u32 offset);
 
 /* vc4_perfmon.c */
 void vc4_perfmon_get(struct vc4_perfmon *perfmon);
diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 240786e7dcd5..2d3b151263e4 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -856,7 +856,8 @@ validate_gl_shader_rec(struct drm_device *dev,
 		void *uniform_data_u;
 		uint32_t tex, uni;
 
-		*(uint32_t *)(pkt_v + o) = bo[i]->dma_addr + src_offset;
+		*(uint32_t *)(pkt_v + o) = bo[i]->dma_addr + src_offset +
+					   to_vc4_bo(&bo[i]->base)->shader_offset;
 
 		if (src_offset != 0) {
 			DRM_DEBUG("Shaders must be at offset 0 of "
diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index 66502a6a4a8e..a5a1c78eb73d 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -779,7 +779,7 @@ vc4_handle_branch_target(struct vc4_shader_validation_state *validation_state)
 }
 
 struct vc4_validated_shader_info *
-vc4_validate_shader(struct drm_gem_dma_object *shader_obj)
+vc4_validate_shader(struct drm_gem_dma_object *shader_obj, u32 offset)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(shader_obj->base.dev);
 	bool found_shader_end = false;
@@ -793,8 +793,9 @@ vc4_validate_shader(struct drm_gem_dma_object *shader_obj)
 		return NULL;
 
 	memset(&validation_state, 0, sizeof(validation_state));
-	validation_state.shader = shader_obj->vaddr;
-	validation_state.max_ip = shader_obj->base.size / sizeof(uint64_t);
+	validation_state.shader = shader_obj->vaddr + offset;
+	validation_state.max_ip = (shader_obj->base.size - offset) /
+				  sizeof(uint64_t);
 
 	reset_validation_state(&validation_state);
 

-- 
2.56.0

