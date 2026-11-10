Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284098;
	b=y/s8RQ2w11Pk9tqguy8M17SXydRN1vN5XyFxmIXmVGxgcYI3+pPA/p72LMro1AmzjMca
	 NL/+13QOtqAyrlDiGoHLaG4p9XUf43IVq039Fsnxo1sZfZWK6Vh2N0KoexkeHs4MpA4JN
	 Py3GLpiCwC1+/Jc14+KBMagAq3nLeMbXu56hrzptgSGL+8yfNxR5B7VqdHVX+7LERmtu5
	 VKQQ9QWbJZx1vdBSkYdRBkAvCD+p+hjErgZrGEjLxBAqw9aajAYBJ/k08Iv1fRvfIHs3Q
	 RmiMPRBBzSd4040XDKCrxZ/V8nj4TAMKdNSb7WLHJiBbrrPYSsjttCjcRb5fH+F1Iow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fdvvb6Pd1z5H9gOGeEkdJb8Fkrq2JVOQTXJJlkjOIJY=;
	b=lmvw8L+sFmrzT8xl1c5VJZ+pa9+fqG0Y1+kaYWjaNnQ6u0uTsD6xea7vE4GHV4WGuDLe
	 3xIKfk+T8kG0jlysIp7xpl/xtQd3fp73CfyCwDsQRRlYP4W7HBKbt3atEgM4L0wfLR2kH
	 haqGoHg69qOcZWRarHKBe6UolcRc7OU2nbzRHMFVRVGvpVZ+OM9tDq2FXC/pURwh1V9Yy
	 NF/Zn8uFmHpd7zMbNB+oLFZCM6C9e1nxg+q5SelofUFrGhOgB2khPYGVQU6FgwNJmjpfr
	 X6JqN/+rGK+YCZdMtNYIiu3zKcAO5UhIC0dxpzY7YKxJhHLbFAANwvcJHsjjSiikzgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebqYBeuK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC95606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebqYBeuK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD4A1F0089F;
	Tue, 10 Nov 2026 04:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284097;
	bh=fdvvb6Pd1z5H9gOGeEkdJb8Fkrq2JVOQTXJJlkjOIJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ebqYBeuKNetl8nNhFdUYRTgsReiNg/OxYAvUp9rbYpq9lIqCyPEPyfiY+LOIfs87x
	 eq9xPVSHeo+E1LzFavbcyvAaw9n36dC0Ziuv5xYwyUxMmNkZXshz5+DoK2TU6Y2TZW
	 1/GM4sxL72GclT3Cyd6ka4YHE5HbILGoyPHDzVsNdCvktrLCm7DOFYSOvzUY2TcPH/
	 cNJ6711Rk12BlmZxjNZLlalz8cKhAKqNi+mDLWsDPlCunLGSPdn8r5Zi96uDyfXTGa
	 A3q6yPpztPFSu3bjIuEvt+ZUp8uEjYK3lpnP3fWGoCHmAu4RqlrnV7TNCA8jLe2hvb
	 kt9qlQIw4dnzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anusha Srivatsa <asrivats@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] drm/panel: Add new helpers for refcounted panel allocatons
Date: Mon,  9 Nov 2026 23:14:54 -0500
Message-ID: <20261110041431.316108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053009-failed-6.6-4eeeac9d7c36@kernel.org>
References: <20261107053009-failed-6.6-4eeeac9d7c36@kernel.org>
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

From: Anusha Srivatsa <asrivats@redhat.com>

[ Upstream commit ed9c594d495deb676825489032cee0a03ce29bf9 ]

Introduce reference counted allocations for panels to avoid
use-after-free. The patch adds the macro devm_drm_bridge_alloc()
to allocate a new refcounted panel. Followed the documentation for
drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
implementations for this purpose.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
Link: https://lore.kernel.org/r/20250331-b4-panel-refcounting-v4-1-dad50c60c6c9@redhat.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Stable-dep-of: 4eeeac9d7c36 ("drm/panel: ebbg-ft8719: Set prepare_prev_first")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 25 +++++++++++++++++++++++++
 include/drm/drm_panel.h     | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 98df4788d096f..ea1f42cee44dc 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -336,6 +336,31 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 }
 EXPORT_SYMBOL(of_drm_find_panel);
 
+void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
+			     const struct drm_panel_funcs *funcs,
+			     int connector_type)
+{
+	void *container;
+	struct drm_panel *panel;
+
+	if (!funcs) {
+		dev_warn(dev, "Missing funcs pointer\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	container = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-ENOMEM);
+
+	panel = container + offset;
+	panel->funcs = funcs;
+
+	drm_panel_init(panel, dev, funcs, connector_type);
+
+	return container;
+}
+EXPORT_SYMBOL(__devm_drm_panel_alloc);
+
 /**
  * of_drm_get_panel_orientation - look up the orientation of the panel through
  * the "rotation" binding from a device tree node
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 10015891b056f..daaa259ef898f 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -269,6 +269,28 @@ struct drm_panel {
 	bool enabled;
 };
 
+void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
+			     const struct drm_panel_funcs *funcs,
+			     int connector_type);
+
+/**
+ * devm_drm_panel_alloc - Allocate and initialize a refcounted panel.
+ *
+ * @dev: struct device of the panel device
+ * @type: the type of the struct which contains struct &drm_panel
+ * @member: the name of the &drm_panel within @type
+ * @funcs: callbacks for this panel
+ * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
+ * the panel interface
+ *
+ * Returns:
+ * Pointer to container structure embedding the panel, ERR_PTR on failure.
+ */
+#define devm_drm_panel_alloc(dev, type, member, funcs, connector_type) \
+	((type *)__devm_drm_panel_alloc(dev, sizeof(type), \
+					offsetof(type, member), funcs, \
+					connector_type))
+
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs,
 		    int connector_type);
-- 
2.53.0

