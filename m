Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681487;
	b=NRzcMrvZSwL0mYq3vzz/fbyLVNjb3MUOYWwhj8gmGrCd01SNJ7K6jVpIwzGRK1rXA56N
	 xmd9cZA8bkTM0YI/9txrkyHvsIil0G9jjpagnG0SQO4qkFkIReCB9sV+XN4V7tzzzrvF4
	 LvymNrzSuH+RoqqgtOLLBlHpumgmwYkhJdg5kRmG6ofQMVwis3Q94L2PE0UeYzwdIlaLM
	 uEdsZseJSfFN9Jpk7PmTmbm/uxM4agZuzjTbxesC9puQKgvB/QSIA/I2/JEYcM36UuT/Z
	 5j1a8fpXOwoFneNk+wUzVFT6w519wRK60XDIKLVnm4rFjuyVgXZKyzm7UoMovAW9rzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681487;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QG7x41CbbyirdC2OMK80hsT9es9iEMG3U7KuCt7Ho90=;
	b=AfnsnE5hasMJ8i4TjjNjPxdyKZUoqw7PuPJP70EBbx+tuB1jri5CxhkkeNW13+I/d2UZ
	 JkP/LhZGb5d66Kl8liuM/q1BdlCuWpVcuFB7fiHyoyDRkkqJiOnY9FzRgh4Kr2qD4un4j
	 SimPDKXG2dIGI7Js1YpbJ+5B4KYYvSLYbvKGBZdyJwxvxQI+vX1hgTM4Jp7g5WDuYkXss
	 00kkwaW/tu+9MrSMNZXQQf1tHSnhUsIQ/YbJedkVl5cFk4YDmLFB8ySqePOqtwSbRdjfm
	 QbD2NQUijQEBfsQ5mbqqm63KYJOGHe8TMrqv1G0lpDyyTuIW2p7Avgp+pCwv5pBThDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=V7JnUiaT;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB0606A338
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DB0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=V7JnUiaT
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id B5E7F2032496;
	Thu, 26 Nov 2026 13:24:39 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id A1D962037210;
	Thu, 26 Nov 2026 13:16:30 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru A1D962037210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1795680992; bh=QG7x41CbbyirdC2OMK80hsT9es9iEMG3U7KuCt7Ho90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7JnUiaTcCnW0T0aalfoWlJmCqKJwfmbGX3RAYzGYQdAsTsGfwAZT0IlUJxFBGFrJ
	 +oA2TYrTjstAk3dEKLVLB+GXyQxfDpLUOd9suIiYebxtrYky6PeXOTfdUHde6VtLvh
	 xCbngRqgFlwlcKairHTDlIBiPfg2Myya7EDVD09sqWznPjUMxV2ydOsv0REoEyI2C5
	 BnigBTjCsQYS1CuWC5noLjgLNZy41XrS+9tEK8cG9arkxgeCULfgrNZj/4P6NPLE4I
	 EmmXom0Z4n9/dIkjAD4qCsGfJpGaktom30a7eZz42OpEo9lnw+VOJ1NEQW2vlxEIJ0
	 KY/ex3NmAYbaA==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] drm/connector: Handle DVI-I property allocation failures
Date: Thu, 26 Nov 2026 12:15:57 +0400
Message-ID: <20261126081602.2901498-3-a.kazinsky@ideco.ru>
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

drm_mode_create_dvi_i_properties() returns success even if either
drm_property_create_enum() call fails. Nouveau then continues display
initialization and may pass a NULL property to
drm_object_attach_property(), causing a NULL pointer dereference.

Return -ENOMEM on allocation failure and destroy the selector property
if creating the subconnector property fails. Publish the property pointers
only after both allocations succeed.

Handle the error in Nouveau by cleaning up the mode configuration and
freeing the display structure before returning.

Fixes: f453ba046074 ("DRM: add mode setting support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/gpu/drm/drm_connector.c           | 12 ++++++++++--
 drivers/gpu/drm/nouveau/nouveau_display.c |  8 +++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 41cbd76e0b1c..51e616f5aa5e 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2061,7 +2061,8 @@ int drm_connector_create_standard_properties(struct drm_device *dev)
  *
  * Called by a driver the first time a DVI-I connector is made.
  *
- * Returns: %0
+ * Returns:
+ * Zero on success, negative errno on failure.
  */
 int drm_mode_create_dvi_i_properties(struct drm_device *dev)
 {
@@ -2076,12 +2077,19 @@ int drm_mode_create_dvi_i_properties(struct drm_device *dev)
 				    "select subconnector",
 				    drm_dvi_i_select_enum_list,
 				    ARRAY_SIZE(drm_dvi_i_select_enum_list));
-	dev->mode_config.dvi_i_select_subconnector_property = dvi_i_selector;
+	if (!dvi_i_selector)
+		return -ENOMEM;
 
 	dvi_i_subconnector = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
 				    "subconnector",
 				    drm_dvi_i_subconnector_enum_list,
 				    ARRAY_SIZE(drm_dvi_i_subconnector_enum_list));
+	if (!dvi_i_subconnector) {
+		drm_property_destroy(dev, dvi_i_selector);
+		return -ENOMEM;
+	}
+
+	dev->mode_config.dvi_i_select_subconnector_property = dvi_i_selector;
 	dev->mode_config.dvi_i_subconnector_property = dvi_i_subconnector;
 
 	return 0;
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 07882624a7f6..04e9a512eaec 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -657,7 +657,13 @@ nouveau_display_create(struct drm_device *dev)
 
 	drm_mode_config_init(dev);
 	drm_mode_create_scaling_mode_property(dev);
-	drm_mode_create_dvi_i_properties(dev);
+	ret = drm_mode_create_dvi_i_properties(dev);
+	if (ret) {
+		drm_mode_config_cleanup(dev);
+		drm->display = NULL;
+		kfree(disp);
+		return ret;
+	}
 
 	/* this only gets set if the driver has the ATOMIC flag */
 	if (drm_drv_uses_atomic_modeset(dev))
-- 
2.56.0


