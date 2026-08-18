Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA138D40A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097420; cv=none; b=gLIGNkAfhUBKB0s3SrEAmNkdRxmzeRsTSUM2Dq/eU6lFTnITRiKBKOeo3Gf3MzYY5svbjB2lN+wbcipqKVf6qqsyltbGvbo/TkSoQAUwq3SzvGL4dK3YA+hGB06UeGh8kidP9mugIOR/TJxo3F5CH8WslMX/X8zmz+e70zcJVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097420; c=relaxed/simple;
	bh=BJ/kVaE/61dNOwCMKw6yVJWUCXGmmJw0OAbiOOPSdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2V/yDXFqFmDxvPLfm500s4aZpQu+AffZG66lTy/TVVszZhAAJ9EF7r7fkiUe1xeML9dPz9JfM6VKsA2eZUCFgSCH/QcJWU7Nxsm9PsCzMOQl7Kni+sPh1Ev6/QiRR9UGCCMxFyUK4R6uSoUq/EMG0+tLPr1Ud59P7dL7gssclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fH+4m0SY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH+4m0SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787097418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ3/ySkk4MATWRJyNja7KbHykfH+1xBTq7SfrpfOH5s=;
	b=fH+4m0SYMhh2RXqUqWU7ONazTlVyszL+o7QVQZDwnoBGHL06iPTtYKDU+uDdYqOFYiQ1qZ
	c33iHTfpISRFH56xf49eFMVSFhq4qk2B2RSejv0YzTq9J5VZ5JS3TGgU8uQx0JXOjeZgGb
	+Uruqwu9Q/A78u1NDLN7s3qg5MsyNAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-kpkGkP4lMGm6evd75ZFzzw-1; Tue,
 18 Aug 2026 19:56:52 -0400
X-MC-Unique: kpkGkP4lMGm6evd75ZFzzw-1
X-Mimecast-MFC-AGG-ID: kpkGkP4lMGm6evd75ZFzzw_1787097410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8D8A19560B4;
	Tue, 18 Aug 2026 23:56:49 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCF76180049F;
	Tue, 18 Aug 2026 23:56:46 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Marek Czernohous <mczernohous@gmail.com>
Cc: stable@vger.kernel.org,
	"Faith Ekstrand" <faith.ekstrand@collabora.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Marek Czernohous" <marek@czernohous.de>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Luca Ceresoli" <luca.ceresoli@bootlin.com>,
	"Kees Cook" <kees@kernel.org>,
	"Marco Crivellari" <marco.crivellari@suse.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Ben Skeggs" <bskeggs@redhat.com>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Jani Nikula" <jani.nikula@intel.com>,
	"James Jones" <jajones@nvidia.com>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight disable into its own function
Date: Tue, 18 Aug 2026 19:48:43 -0400
Message-ID: <20260818235637.1738055-2-lyude@redhat.com>
In-Reply-To: <20260818235637.1738055-1-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Besides using state->dev to access the nouveau_drm device again, there
should be no functional changes here.

Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 39 +++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 2c66e480b5116..a885394f7cb92 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1561,24 +1561,39 @@ nv50_sor_update(struct nouveau_encoder *nv_encoder, u8 head,
  * the panel backlight has been shut off? Intel doesn't seem to do this, and uses a
  * fixed time delay from the vbios…
  */
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+static inline void
+nv50_sor_atomic_disable_backlight(struct nouveau_drm *drm,
+				  struct nouveau_encoder *nv_encoder,
+				  struct drm_atomic_commit *state)
+{
+	struct nouveau_connector *nv_connector;
+	struct nouveau_backlight *backlight;
+	int ret;
+
+	nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+	if (drm_WARN_ON(drm->dev, !nv_connector))
+		return;
+	backlight = nv_connector->backlight;
+
+	if (!backlight || !backlight->uses_dpcd)
+		return;
+
+	ret = drm_edp_backlight_disable(&nv_connector->aux, &backlight->edp_info);
+	if (ret < 0)
+		NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
+			 nv_connector->base.base.id, nv_connector->base.name, ret);
+}
+#endif
+
 static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nv50_head *head = nv50_head(nv_encoder->crtc);
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
-	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
-	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
-	struct nouveau_backlight *backlight = nv_connector->backlight;
-	struct drm_dp_aux *aux = &nv_connector->aux;
-	int ret;
 
-	if (backlight && backlight->uses_dpcd) {
-		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
-		if (ret < 0)
-			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
-				 nv_connector->base.base.id, nv_connector->base.name, ret);
-	}
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	nv50_sor_atomic_disable_backlight(nouveau_drm(state->dev), nv_encoder, state);
 #endif
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
-- 
2.55.0

