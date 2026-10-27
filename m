Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135863;
	b=jnPsQpNVnJSSHERSWrcH3fsxbNuMejUEmdxu1UhS8Cg4+pA+voMDp0oy3GQ85S0CIxcY
	 18H9qTV066i4lnz9S0izgX22Ge+zkMYCu+zW//cc1cLx2UtOJBzabYe1Ax4c5AKyrPLbt
	 62CKXN67xotsVnV3tFwjaD6b8bVlFa/YnjD3Rp7+AWLM2Zd5OuotWgaZ2pklkAZ4XTTek
	 1zVlBVIp5JH/FDF/f2gkEZW9GE/RhtdTIU4aOsQlLSGKGqG70+9v3vZTMd/axJSiUjMqa
	 LbWk/M0NibBn9RZpUUsb+CP5SrTCKZZS6Dji8um4Yq3zBEfzX/ZQ9EEDFSQyj/9C41g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135863;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=kjKHoXJ1QztHn7LxaBTuy/zVwxBXOh8NpL66zD+sMpw=;
	b=e3bdq0HJ+14GL+djyW5BTGW1HLA3L4js4lxgM/jok/BSfZq2IGB0aa4bT/GasD5Ra8Tj
	 rEta1UQpo5ZlW2eou+2Qp0GvWyaH18fsSwUBogy+2gIy0OKp4iJRsUayhsUQdJSDNre3c
	 HJr6sHUj0NcfulttaVGEN3u26UFowKocPsn21WfoITpZLVy08k8TeQNzIvY/OpitKwUMr
	 vA1jQbI+d7m2jQ0MS4En8MRtUfJzqka+nWhklDlleKpcsO+iIm/Ro2qiSEX0YCP+jEGSE
	 /OKDdRuYHVLeLBEyfHKja7ar6yRvNpfJZxdaGXct9hN8xuVr1RDGUpCcdY7as5RYwng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BX2i5Mtt;
	arc=none smtp.remote-ip=209.85.210.228
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340E606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E340E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BX2i5Mtt
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-886e61fa30fso158279b3a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135862; x=1793740662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjKHoXJ1QztHn7LxaBTuy/zVwxBXOh8NpL66zD+sMpw=;
        b=frFO/apqUiPJJMTnUzOTPteHWSKUZe4f9FdLKgIWkDGJ/nAaUOpqigDdi6zGBIblSh
         NX2En3rw7r4982Awnt+WtAHm1gsy/EG3ANwBKyvj9Sz/d2y2kwtNhZZKZkbaUY30XFBq
         3Q9zAFJo3yAFs4bLYAtQ8zEQOr+ZF9Xmm5vGncqFi+8e2QC5Vyg+ToBmwkGy1uupHVJg
         8a7Y7mqd65RebqfdnXvPnfId1pvFH/PGVW/ZyVfxWlPFieERA0NjIh2JO3Qq8ynMsJGJ
         rxSAPAModjCpeZIyXLclhMlIIMWvOhll6bFo0mJLMoQzft4rm3UOOViaUDdALIru/l53
         bFXQ==
X-Forwarded-Encrypted: i=1; AKwUvBztcbW0pVNia9Ef4mU4myhc41ab81HUyJYGaJMHxFFUFfQPbpOFdmSVM5qZzceu0hup811AR5s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOabKmRglPM02IxPiSlE/XcNzjSR7erzMQ4R6ajbyfrtFPo9xl
	g9bMnY5bweirZFADe4gyM/asmaROhQevujns7W/rrBQEMfqCMs8S8rbk8mGfM1sTwRcOsrzEIZ0
	gNebtxt/LgW0DdDuciPk6Tozq0IlRZ/0xUZeQsrmVWt9SCntbjp70+9jD8ftgiAu3H3W65/1dCV
	bT6VGh1KqlknzjaF7Pgv8Zy4K1osBqPw1Tdu8wujxsFDtq06Oz5weFU7zhOAh3gguxr9foqBX3E
	5dV27JP
X-Gm-Gg: AYBFou0Dai7nhl542FtVpweLt3SzNQ94XkB+tQ0YV2WkUKnqVtojsj1Ay/V3mDY5PQs
	JzujFWXJ7oxvvW7bKWUvL863DNBFkFzQCsG+RamkJJ3Nx18rur1TXVGEhx0K8mcv1aFyozoKaGO
	VZhgYngVw+QC90OdqxwMUleGEUGZdQhrFQDvJs7dAtj4hnAPkViQcs5bb08+a3HMajIRL8xEy1t
	H1R16UXvdEmtd7Vpu9Vec1z3yoNf+Eykj8jB7rqtGf80JkFDVAml02RlGlhWs72k9Nj85gJB5gq
	0VSgIMeRXGARIYBl2bH6hRmX7OIHXkokipKX8dLvb9X1MqBOgNLJzKiqS7IqjM3lqKkGIkFQv4Y
	nnEM1S7/XvE1jvN66MnrqwBp913Bt9xiOJWJgaj20QFei9nv7Tbg/4cPzebvl+bRtrSfU2tmqv3
	xARSj440eFzgEqWsPc8N6XaqAmc2xKVMMp
X-Received: by 2002:a17:90b:4f49:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae580ae572mr191647a91.11.1793135862140;
        Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae579cd137sm99023a91.2.2026.10.27.14.17.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so498473eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135860; x=1793740660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjKHoXJ1QztHn7LxaBTuy/zVwxBXOh8NpL66zD+sMpw=;
        b=BX2i5MttuJJdamn4P8WL/EO3Mg3yG+te6xEL/aKHtOky1pCIthdcB0YEmq2ILNryN4
         fA6nD3m/2kxYFJMukKEPeqG2oK3/a8J5+stIlFpzEKsSkSXhAOyh3XMcD4EdsuxE1QQA
         Oyt5UMPds/wz2aTh+yrQhk37JtFRVyD9sIdP0=
X-Forwarded-Encrypted: i=1; AKwUvByFZUrQW4xzhO6k/jUnAgxxcvIEbQ+6wo8GfFcrZoUoM+yYnvSHcuf9l+uMCqu91MR4YF+FfeE=@vger.kernel.org
X-Received: by 2002:a05:7301:2e85:b0:36a:1788:3d1c with SMTP id 5a478bee46e88-36a203dfa05mr1211704eec.34.1793135860324;
        Tue, 27 Oct 2026 14:17:40 -0700 (PDT)
X-Received: by 2002:a05:7301:2e85:b0:36a:1788:3d1c with SMTP id 5a478bee46e88-36a203dfa05mr1211660eec.34.1793135859600;
        Tue, 27 Oct 2026 14:17:39 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:38 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each plane state
Date: Tue, 27 Oct 2026 17:17:24 -0400
Message-ID: <20261027211729.646988-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Cursor plane states duplicate the user object reference without acquiring
its mapping or pin. Preparing the duplicated state nevertheless unmaps
that object, and only pins the new buffer if it is not already pinned.
Cleanup of an older state can therefore remove a mapping or pin still
needed by another cursor commit. Repeated cursor updates from KMS clients
can then access an unmapped or movable buffer.

Give each prepared state its own mapping, buffer reference and pin, and
reset the mapping when duplicating a state. Release only the resources
owned by that state in cleanup_fb(). Map the required image extent for
every state so resizing a cursor on the same buffer cannot reuse a
smaller cached mapping. Unwind the pin and reservation if preparation
fails.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 69 ++++++++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h |  4 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  1 +
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 5a69606a0593..942d07079ef7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -112,8 +112,7 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 {
 	SVGAGBCursorHeader *header;
 	SVGAGBAlphaCursorHeader *alpha_header;
-	struct vmw_bo *bo = vmw_user_object_buffer(&vps->uo);
-	u32 *image = vmw_bo_map_and_cache(bo);
+	u32 *image = vps->cursor.map.virtual;
 	const u32 image_size = vps->base.crtc_w * vps->base.crtc_h * sizeof(*image);
 
 	header = vmw_bo_map_and_cache(vps->cursor.mob);
@@ -132,7 +131,6 @@ static void vmw_cursor_update_mob(struct vmw_private *vmw,
 	memcpy(header + 1, image, image_size);
 	vmw_write(vmw, SVGA_REG_CURSOR_MOBID, vmw_bo_mobid(vps->cursor.mob));
 
-	vmw_bo_unmap(bo);
 	vmw_bo_unmap(vps->cursor.mob);
 }
 
@@ -490,9 +488,21 @@ vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
 {
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
+	struct vmw_bo *bo;
+	int ret;
 
-	if (!vmw_user_object_is_null(&vps->uo))
-		vmw_user_object_unmap(&vps->uo);
+	if (vps->cursor.map.bo) {
+		bo = to_vmw_bo(&vps->cursor.map.bo->base);
+		ret = ttm_bo_reserve(&bo->tbo, false, false, NULL);
+		if (WARN_ON_ONCE(ret))
+			return;
+
+		ttm_bo_kunmap(&vps->cursor.map);
+		vps->cursor.map.bo = NULL;
+		ttm_bo_unpin(&bo->tbo);
+		ttm_bo_unreserve(&bo->tbo);
+		vmw_bo_unreference(&bo);
+	}
 
 	vmw_cursor_mob_unmap(vps);
 	vmw_cursor_mob_put(vcp, vps);
@@ -625,10 +635,12 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	struct vmw_surface *surface;
 	int ret = 0;
 
-	if (!vmw_user_object_is_null(&vps->uo)) {
-		vmw_user_object_unmap(&vps->uo);
+	/*
+	 * A duplicated state only owns the user object reference. Its mappings
+	 * and pins belong to the old state until cleanup_fb().
+	 */
+	if (!vmw_user_object_is_null(&vps->uo))
 		vmw_user_object_unref(&vps->uo);
-	}
 
 	if (fb) {
 		if (vmw_framebuffer_to_vfb(fb)->bo) {
@@ -652,31 +664,34 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo) {
 			struct ttm_operation_ctx ctx = { false, false };
+			size_t size = (size_t)new_state->crtc_w *
+				      new_state->crtc_h * sizeof(u32);
 
 			ret = ttm_bo_reserve(&bo->tbo, true, false, NULL);
 			if (ret != 0)
-				return -ENOMEM;
+				return ret;
 
 			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 			if (ret != 0)
-				return -ENOMEM;
+				goto out_unreserve;
 
 			/*
-			 * vmw_bo_pin_reserved also validates, so to skip
-			 * the extra validation use ttm_bo_pin directly
+			 * vmw_bo_pin_reserved() also validates, so to skip
+			 * the extra validation use ttm_bo_pin directly.
+			 * Every state takes its own pin, the buffer can
+			 * still be in use by an older state whose commit
+			 * hasn't been cleaned up yet.
 			 */
-			if (!bo->tbo.pin_count)
-				ttm_bo_pin(&bo->tbo);
+			ttm_bo_pin(&bo->tbo);
 
-			if (vmw_framebuffer_to_vfb(fb)->bo) {
-				const u32 size = new_state->crtc_w *
-						 new_state->crtc_h *
-						 sizeof(u32);
-
-				(void)vmw_bo_map_and_cache_size(bo, size);
-			} else {
-				vmw_bo_map_and_cache(bo);
+			ret = ttm_bo_kmap(&bo->tbo, 0, PFN_UP(size),
+					  &vps->cursor.map);
+			if (ret) {
+				vps->cursor.map.bo = NULL;
+				ttm_bo_unpin(&bo->tbo);
+				goto out_unreserve;
 			}
+			vmw_bo_reference(bo);
 			ttm_bo_unreserve(&bo->tbo);
 		}
 		if (!vmw_user_object_is_null(&vps->uo)) {
@@ -703,6 +718,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	}
 
 	return 0;
+
+out_unreserve:
+	ttm_bo_unreserve(&bo->tbo);
+	return ret;
 }
 
 /**
@@ -796,7 +815,6 @@ void
 vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
 {
-	struct vmw_bo *bo;
 	struct drm_plane_state *new_state =
 		drm_atomic_get_new_plane_state(state, plane);
 	struct drm_plane_state *old_state =
@@ -823,9 +841,8 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 		vmw_cursor_update_mob(dev_priv, vps);
 		break;
 	case VMW_CURSOR_UPDATE_GB_ONLY:
-		bo = vmw_user_object_buffer(&vps->uo);
-		if (bo)
-			vmw_send_define_cursor_cmd(dev_priv, bo->map.virtual,
+		if (vps->cursor.map.virtual)
+			vmw_send_define_cursor_cmd(dev_priv, vps->cursor.map.virtual,
 						   vps->base.crtc_w,
 						   vps->base.crtc_h,
 						   vps->base.hotspot_x,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
index d32cf17d013b..9b50f80f9635 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
@@ -14,6 +14,8 @@
 #include "drm/drm_fourcc.h"
 #include "drm/drm_plane.h"
 
+#include <drm/ttm/ttm_bo.h>
+
 #include <linux/types.h>
 
 struct SVGA3dCmdHeader;
@@ -41,6 +43,8 @@ struct vmw_cursor_plane_state {
 	enum vmw_cursor_update_type update_type;
 	bool changed;
 	bool surface_changed;
+	/* The mapped buffer is referenced and pinned by this state. */
+	struct ttm_bo_kmap_obj map;
 	struct vmw_bo *mob;
 	struct {
 		s32 hotspot_x;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 31d3ee0825ca..85228eb9c3e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -283,6 +283,7 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
 	vps->cpp = 0;
 
 	vps->cursor.mob = NULL;
+	memset(&vps->cursor.map, 0, sizeof(vps->cursor.map));
 
 	/* Each ref counted resource needs to be acquired again */
 	vmw_user_object_ref(&vps->uo);
-- 
2.53.0

