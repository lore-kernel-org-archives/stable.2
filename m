Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D03480326
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155209; cv=none; b=OC12j3Gs+Ima6M8vdOpaAIk9qUTl5W4cq9wiH2ou2W4Ph2InJSNecXdwf/sFJ9Hs+VXE7muq72+a8O5o583UVxpV/ikv2CR7lzfRRdpKtFpdq11KH3DnSjBEPQbj81wLjHEODB1MP7sy4EQj6psnOE4qI9WVy+6Q0trZYiOlNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155209; c=relaxed/simple;
	bh=BJ/kVaE/61dNOwCMKw6yVJWUCXGmmJw0OAbiOOPSdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAT7cPeZfPpHG7n/QlDbfkUhOz1gVWeiLcMPJ0aSvtMpo5CavgPnxLa8OCilznAeRWlg7yPolcfSGi1sGPYiL0klroMyc2dEq/jcAMfJerV5Qw13DOD+5ltkquddnuXcslK5HGUjUXOYgjTiA7T5LmiEXYe+vJytRrfb+8cx4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTaOF3pf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTaOF3pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787155207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ3/ySkk4MATWRJyNja7KbHykfH+1xBTq7SfrpfOH5s=;
	b=NTaOF3pfHVZqCw14v5yo18FM+cr0i/QlisuTix7J0CzJVKYzBURAwrEsp5fwExny7ptHm0
	12vCIemLq3suVnfGE5wkM9vatGzvJdomQ/hANAhpPMWogU56abXiha5IW0JAcJ+XdhFYVm
	wDt98jh4vgmID6GxpnHap7efJTOlPsw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-GM-ns7WWP726exDZ-ptw4A-1; Wed,
 19 Aug 2026 12:00:01 -0400
X-MC-Unique: GM-ns7WWP726exDZ-ptw4A-1
X-Mimecast-MFC-AGG-ID: GM-ns7WWP726exDZ-ptw4A_1787155193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78AAD1955DD2;
	Wed, 19 Aug 2026 15:59:49 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C237518005BC;
	Wed, 19 Aug 2026 15:59:44 +0000 (UTC)
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
	"Marco Crivellari" <marco.crivellari@suse.com>,
	"Kees Cook" <kees@kernel.org>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Ben Skeggs" <bskeggs@redhat.com>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Jani Nikula" <jani.nikula@intel.com>,
	"James Jones" <jajones@nvidia.com>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight disable into its own function
Date: Wed, 19 Aug 2026 11:43:48 -0400
Message-ID: <20260819155934.154125-2-lyude@redhat.com>
In-Reply-To: <20260819155934.154125-1-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

