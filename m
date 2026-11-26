Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681478;
	b=dc3PXg8K1MmFNzJG0hl/fM0z2gk/hkNollgvuXejXnpVVcxDjIBUSUUJSssI36BZDeFw
	 1Nl41VSLx9MoB9A9Cf+7uav77t86L/XTmgKhuVVP9LrI9SMw5ur4skh7NYFffeGyxHYVr
	 dove5D0y9gVqt6vZSTS5n8wzI+yP+wzG0tKA++hNkbD9H5okmRobCiKUt+ykjG9GTTy01
	 yofCrXDY5uqiucCcjRvYUB+Jq+Wu2oBhsWCFHvav9bHajjt3M61VdplQ1UUxA7H/qDvK6
	 f22ZZO3YdzjIHT5lzm4jA+HArNbO3oj9XUX/z/Lrz6ODpd93bZyPJCwpLgrwnzbB1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681478;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kvkohFIVoj8f2Me/6uzQ3sWm8aGGRnxnWLHr2+eero=;
	b=yS4BB73Vh9MA6PSsFQg8eU5WNAQsIF5ZDGEVg8w6THupWcixF8m8fL40L7nt+d8yAEMp
	 G9wN34kDGoDM80bcpQ1npAcJcKgSpAdl4QRAvMXGXRrPQFmnCgL2xDSbp/iDcCkpoBf1a
	 xXcrj3+U9c1aeLrgtbngN54CAIHzP6fYkseYGEawM/q+Kcp+qQ2Yc9oLcUwupeEESf9Ba
	 vWQU1cWGIn0OqOq9V8FNZn1+kRVfzhn5jTO9nIUzQhkvMNE2wiy4sorFG7WdEndXdfsc7
	 LTuEN/tpu6ndyr75Mrshn0vBM9qo83bD/T1D4TWVPRqlCyV069aUVwRrWJ/JVfMkiNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=C87gxbT1;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B67606A338
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1B67606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=C87gxbT1
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 2D3312032496;
	Thu, 26 Nov 2026 13:24:28 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id 5D043203679C;
	Thu, 26 Nov 2026 13:16:27 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 5D043203679C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1795680989; bh=0kvkohFIVoj8f2Me/6uzQ3sWm8aGGRnxnWLHr2+eero=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C87gxbT1P8Tf0TAGi7G71ijMpY+k1lmzdFcGQBS4vFdVsN8AQQC+Tv4nnmbUCazUY
	 WhTRJiUfWyv/O1CFZ5DSEOoSXomaanM7Nl0jgjRM8WFp/ZP2knbPDomDw/oMuPfOui
	 DJc3GqXqklpe1C6RsnbEXOLAO2Wa6kodS/hQ68t9q86kQ/+QW8YknfU2BAyL6Llvf5
	 gb6IoF/1gei3gxFlmy/cljPnWMf1ZSKN+3RN082Go0ioqneATWhtz3WgoSvdWw+t8c
	 bmgErIgMsmt50LgHii0lOkkhmDTHl/TG38RBseGDCsfyaQCYM/ZeMbCCbP6A7sOtq6
	 PsMhfxg7YiknQ==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Emil Velikov <emil.velikov@collabora.com>,
	Oleg Vasilev <oleg.vasilev@intel.com>,
	Jeevan B <jeevan.b@intel.com>,
	dri-devel@lists.freedesktop.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] drm/connector: Check DP subconnector property before attaching it
Date: Thu, 26 Nov 2026 12:15:56 +0400
Message-ID: <20261126081602.2901498-2-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
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

drm_property_create_enum() can return NULL on allocation failure.
Passing this pointer to drm_object_attach_property() causes a NULL
pointer dereference during DP connector initialization.

Attach the DP subconnector property only if it was created successfully.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: e5b92773287c ("drm: report dp downstream port type as a subconnector property")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/gpu/drm/drm_connector.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..41cbd76e0b1c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2106,9 +2106,10 @@ void drm_connector_attach_dp_subconnector_property(struct drm_connector *connect
 				drm_dp_subconnector_enum_list,
 				ARRAY_SIZE(drm_dp_subconnector_enum_list));
 
-	drm_object_attach_property(&connector->base,
-				   mode_config->dp_subconnector_property,
-				   DRM_MODE_SUBCONNECTOR_Unknown);
+	if (mode_config->dp_subconnector_property)
+		drm_object_attach_property(&connector->base,
+					   mode_config->dp_subconnector_property,
+					   DRM_MODE_SUBCONNECTOR_Unknown);
 }
 EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
 
-- 
2.56.0


