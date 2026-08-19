Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27B4499B1
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155227; cv=none; b=uOd+RHGeFU1J/+CVS79VKnTsiv1Jci8qXFyl8iTo6+5fE+vJyRI4zi36x3PwaZUuwZDj7Ygnw3OxsQNzM+TAhIFSJmiLzsZhFFE+HHMyb44sNxVAtimkmgULWBRExgOTyXMCNWSqnAGlpT7P2zN6Ec62losfuxS6c6V/Wg4orYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155227; c=relaxed/simple;
	bh=Go9qyjClI5XuqFOTeUdtCcOltUcHrxHIVnsoj1l3gZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJbEng0lpRKPRd14lsGNekOPS5EcDIqoVTNkzkd1ANP8jMXwgrG8p26SOiy3yuFUoSl9dIPnXhWGIqQWGa0Qz+NYwqVT7Fk3eASPUYUkRyqSvUwH8pQv4hkCdbuTX1fQSNyRxO9fjH8hdHfoGHyjk4le71fi+lX0FskWCWPuFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ3Yk2RS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ3Yk2RS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787155224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdwphjmf7twiQKozt/YmavKP3Voyo4Fdnf0ShOQkMVE=;
	b=IZ3Yk2RSpT5JLWtHErylRZ3H7TONcEcggDvSJqTtlGwD0OVZsfwqWZgz/aN8UFwrPQSldP
	uMVcSHnuV6Gqiq734Y01YDyserYNKsQUMtnFBM2xwB3EhJfpvTxZGon8EM9gLlEpM57LRr
	RjaTBFEnOk6yV3Ih4tJNqTG7kjLbK2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-eCl0fOJ4MQCvU2ebNBM7_Q-1; Wed,
 19 Aug 2026 12:00:09 -0400
X-MC-Unique: eCl0fOJ4MQCvU2ebNBM7_Q-1
X-Mimecast-MFC-AGG-ID: eCl0fOJ4MQCvU2ebNBM7_Q_1787155199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C5271954AFB;
	Wed, 19 Aug 2026 15:59:57 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63C4A18005BB;
	Wed, 19 Aug 2026 15:59:53 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Marek Czernohous <mczernohous@gmail.com>
Cc: stable@vger.kernel.org,
	"Dave Airlie" <airlied@redhat.com>,
	"Marek Czernohous" <marek@czernohous.de>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Luca Ceresoli" <luca.ceresoli@bootlin.com>,
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
Subject: [PATCH v2 2/6] drm/nouveau/kms/nv50-: Add nv50_outp_get_old_crtc()
Date: Wed, 19 Aug 2026 11:43:49 -0400
Message-ID: <20260819155934.154125-3-lyude@redhat.com>
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

Does what it says on the label, unused for now.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index a885394f7cb92..152361f7feb42 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -459,6 +459,22 @@ nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_enco
 	return NULL;
 }
 
+static struct nouveau_crtc * __maybe_unused
+nv50_outp_get_old_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	const u32 mask = drm_encoder_mask(&outp->base.base);
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		if (crtc_state->encoder_mask & mask)
+			return nouveau_crtc(crtc);
+	}
+
+	return NULL;
+}
+
 static struct nouveau_crtc *
 nv50_outp_get_new_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
 {
-- 
2.55.0

