Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C63AD529
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155226; cv=none; b=QA3nT518Qlm2GicWSq/TNsVWnSV6tifcmTha/dsT98bLaaZVp519o38ua1NwJtYKz2zm/w8mcEYxIm5mMAsNAh+j+/FoWuwYa8XQQp7rVa1a9B+jd1kj6OGHb6AePc0JpuCuDtA3IPxlMeCXXrqTJqNCg4uT3XoCXyGa/in50XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155226; c=relaxed/simple;
	bh=cVYN0k7yL7k+ocQStlIjdIgldryc/hkG+TyXn4QYmok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwlC2aEyple/xfNXceYQFyuy8gcPlpoFPsBFXeebxIpEqFNR5jlGcKg058PeYQa1rgx/i2RFik6t4QRElqRbMObHyplaf75qh9G2LOAU1dfSoU1zyF9pqovOoSkakqb+bd2axlHr3lgKgMihL+dPojQLex4eh+n9LHtIdiEgx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5pWp1zX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5pWp1zX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787155224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMF+0ARQ9Eixkloaq8eI+L+kTqWe7Y7ZEuYINPQUR1c=;
	b=D5pWp1zXlsUVZzEFzPLxY+QYnLyAf+UC7Ee9Al8eJGN/oz/zvMFHidOk/UUPauHGFk7bVi
	sNzhhfnkl7fII5KhJ26nqHj6u8xQMq97IXfHeUCk7rn1iTrYBBMaQfflVwtaD8AM3B4tjp
	14j1jIjTrHxjWPYA+/YsTBa2++TOntM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-5Dfng3uhMEqdLYBca1IOjQ-1; Wed,
 19 Aug 2026 12:00:19 -0400
X-MC-Unique: 5Dfng3uhMEqdLYBca1IOjQ-1
X-Mimecast-MFC-AGG-ID: 5Dfng3uhMEqdLYBca1IOjQ_1787155206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950711956047;
	Wed, 19 Aug 2026 16:00:06 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDE4A18005BB;
	Wed, 19 Aug 2026 16:00:00 +0000 (UTC)
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
Subject: [PATCH v2 3/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in nv50_sor_atomic_disable()
Date: Wed, 19 Aug 2026 11:43:50 -0400
Message-ID: <20260819155934.154125-4-lyude@redhat.com>
In-Reply-To: <20260819155934.154125-1-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is a leftover CRTC bookkeeping variable from the pre-atomic days.
While it works in most situations, it's prone to breaking - as pointed out
by Marek Czernohous.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reported-by: Marek Czernohous <mczernohous@gmail.com>
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

