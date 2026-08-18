Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDC3806C2
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097431; cv=none; b=aLpClJNifUETQ0/L46fUSPJq9YKIrNRk4gORgYvbleRZ/rS3gzkuyJOdn/LEgqtHWhyd0qisLSszcDgaEMR3LYiM+Z2KOaerJHc5AzyWhEJyj2E/Xjey1C6dWbsMJHrpOFc/2Z9xG4Q3367EGB+w9gfnwUGqRZ2ALwOHsFAaT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097431; c=relaxed/simple;
	bh=CCLYtguIp7aFmld18f3Sh0cOqkHOeVpid7iacpuj2RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgAI4LxhcB9e/n/YmpO4YzPCtH+LuBCL9urGT6oTc5/xRt/6QrR5L6dA2rcrhttb9nzoUL7WIgoGTHN1EGhGxsMJqv8j7YSv6dJd8g0/hRpwhfy2EJOcL70jx95buQLEBjH+0ynJhJD9Q5R8utxbX06HurQpVWkxksQ0FKWKxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZJlJZ20; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZJlJZ20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787097429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz0aXgFMqOpBVjMIOtdMICeTUjk8ldXgSQBenL20dmc=;
	b=iZJlJZ20LIRxCFwNjEYh4KafDSF+oi3QFRtTxIiY1+x30z02QZDa6Llk+GMfy7js3Pe8Un
	S3AIsK5psfxNHAdHS162YB0vUJaq00kqF1F27z3pFdkioqjp87fOrQ6QkPrnGPYSecRvTQ
	Sf+Ds17uShIxov/rKirYiw5oNClBU10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-H0UBxphkPlK_ZrnM_2TM5w-1; Tue,
 18 Aug 2026 19:57:06 -0400
X-MC-Unique: H0UBxphkPlK_ZrnM_2TM5w-1
X-Mimecast-MFC-AGG-ID: H0UBxphkPlK_ZrnM_2TM5w_1787097424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D881180049D;
	Tue, 18 Aug 2026 23:57:03 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B68D1800347;
	Tue, 18 Aug 2026 23:57:00 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Marek Czernohous <mczernohous@gmail.com>
Cc: Marek Czernohous <marek@czernohous.de>,
	stable@vger.kernel.org,
	"Faith Ekstrand" <faith.ekstrand@collabora.com>,
	"Dave Airlie" <airlied@redhat.com>,
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
	"James Jones" <jajones@nvidia.com>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 3/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in nv50_sor_atomic_disable()
Date: Tue, 18 Aug 2026 19:48:45 -0400
Message-ID: <20260818235637.1738055-4-lyude@redhat.com>
In-Reply-To: <20260818235637.1738055-1-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is a leftover CRTC bookkeeping variable from the pre-atomic days.
While it works in most situations, it's prone to breaking - as pointed out
by Marek Czernohous.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reported-by: Marek Czernohous <marek@czernohous.de>
Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 152361f7feb42..f19820dc055ae 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -459,7 +459,7 @@ nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_enco
 	return NULL;
 }
 
-static struct nouveau_crtc * __maybe_unused
+static struct nouveau_crtc *
 nv50_outp_get_old_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
 {
 	struct drm_crtc *crtc;
@@ -1606,12 +1606,18 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nouveau_crtc *nv_crtc;
+	struct nv50_head *head;
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	nv50_sor_atomic_disable_backlight(nouveau_drm(state->dev), nv_encoder, state);
 #endif
 
+	nv_crtc = nv50_outp_get_old_crtc(state, nv_encoder);
+	if (drm_WARN_ON(state->dev, !nv_crtc))
+		return;
+	head = nv50_head(&nv_crtc->base);
+
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
 		nvif_outp_hdmi(&nv_encoder->outp, head->base.index,
 			       false, 0, 0, 0, false, false, false);
-- 
2.55.0

