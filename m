Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33051DE15
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910497; cv=none; b=c8Ci6P49MmdkBwAdxV9QuBsYbY0xrctrU843Rqv2Z8h9galOgaILpgCRvjoQuUd+WbYKUVkxDEDsprWeSwSrMYSxiNObXsB5QZYXajH6CRscwsUkCBLHK1ALQTRXGZ98kzNTHGe7KYO9SZrqz0xfyhMjs0B3D75EuF/z91gtObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910497; c=relaxed/simple;
	bh=2Mv+FCMvvib0Eeoraw+RBminAz6lGKAn94jJ4R9v474=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD/SVCAmMLYc/vR5qj8KotvUKsyic+zAXQ+H0fCcBbyX5nbIYvlukcDcMDi1gXoTdB1lzug0L4c4Et/nI8/FnWb0/p2VsY/9OM7YfRKJmoUbYzCyS7zNaoE7LFYQum7QKuHjwdxCS4/IOfDEpivHCA0XWhsxppQ8u4ot9YsqUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoRTa6dj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoRTa6dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C9B1F000FF;
	Tue, 13 Oct 2026 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910496;
	bh=OzMZpOVQenacCR5FrtEhAxIlcf3dKMQqx2UeYK6FJEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NoRTa6djJkyyKDTbZyJngth6ce/VQ+hq/7Y8D75F9fQUHJy4vMxpfRt94+pGtzbgF
	 581N7qabg3fKD9ETLoH88bhHCFgkmvhGbryXo7ZFs6HgUg7YP0cPMJyshnHzMuqnaI
	 54XDYgtO84m0JP4pRwD9SwRPmHG1dtbqHRtovE/usZON70Y28HtJJVtor166TiiwNG
	 fTQjtYP4dQ9t0d/3wUFPAHAItydQ0vlOwLwiN27UgHyKmlQdR91IidLo/bXPEJ34hG
	 +3Q/Ej0rsbdIR+0YPgSaPYXGgd3VioP6IDKvw91/vVM7v0N3b7FGUaGUqnr60qqU3a
	 BGBmtvoR1Aseg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/vmwgfx: Stop using dev_private to store driver data.
Date: Tue, 13 Oct 2026 12:54:53 -0400
Message-ID: <20261013165424.426719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101207-unpaid-wok-72a4@gregkh>
References: <2026101207-unpaid-wok-72a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

[ Upstream commit 1b1d5fe66ca591d34c5501aab8f5f09f347e8a3e ]

Currently vmwgfx uses the dev_private opaque pointer in drm_device to store
driver data in vmw_private struct. Using dev_private is deprecated, and the
recommendation is to embed struct drm_device in the larger per-device
structure.

The vmwgfx driver already embeds struct drm_device in its struct
vmw_private, so switch to using that exclusively and stop using
dev_private.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240502004033.107533-1-maaz.mombasawala@broadcom.com
Stable-dep-of: 21bc51cb89ce ("drm/vmwgfx: validate pitch coming from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 --
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 2e84e1029732d..1b0b9d2d4e720 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -856,8 +856,6 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
 	bool refuse_dma = false;
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
 
-	dev_priv->drm.dev_private = dev_priv;
-
 	vmw_sw_context_init(dev_priv);
 
 	mutex_init(&dev_priv->cmdbuf_mutex);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 4e2807f5f94cf..b21831ef214a6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -639,7 +639,7 @@ static inline struct vmw_surface *vmw_res_to_srf(struct vmw_resource *res)
 
 static inline struct vmw_private *vmw_priv(struct drm_device *dev)
 {
-	return (struct vmw_private *)dev->dev_private;
+	return container_of(dev, struct vmw_private, drm);
 }
 
 static inline struct vmw_private *vmw_priv_from_ttm(struct ttm_device *bdev)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 5f99f7437ae61..800a79e035ed6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -280,7 +280,7 @@ static void vmw_du_put_cursor_mob(struct vmw_cursor_plane *vcp,
 static int vmw_du_get_cursor_mob(struct vmw_cursor_plane *vcp,
 				 struct vmw_plane_state *vps)
 {
-	struct vmw_private *dev_priv = vcp->base.dev->dev_private;
+	struct vmw_private *dev_priv = vmw_priv(vcp->base.dev);
 	u32 size = vmw_du_cursor_mob_size(vps->base.crtc_w, vps->base.crtc_h);
 	u32 i;
 	u32 cursor_max_dim, mob_max_size;
@@ -519,7 +519,7 @@ void vmw_du_cursor_plane_destroy(struct drm_plane *plane)
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	u32 i;
 
-	vmw_cursor_update_position(plane->dev->dev_private, false, 0, 0);
+	vmw_cursor_update_position(vmw_priv(plane->dev), false, 0, 0);
 
 	for (i = 0; i < ARRAY_SIZE(vcp->cursor_mobs); i++)
 		vmw_du_destroy_cursor_mob(&vcp->cursor_mobs[i]);
-- 
2.53.0

