Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283278;
	b=0WRmwF63lym8fpu/Q1eQqtC/IN4snjx8y4PeDts9P+tYpb5fKYq2DANWI0nEOntOE9df
	 79CEEKt85Wyb0Obfh7FntV7ppjI3Pw+jcvn7wVMb5mbPj68NB6yMWhHrkaW9wUhpAu6wx
	 xDbY9J/iBHtbwKVoVVEkW0DMItK/r8AUtIO6ao7W3/BjMb6hNb7MqHownvFblaC+1VjfK
	 EdHWgCvsl/ftldpEJA/6/hGsGGskR3/wFfV8QLSt0CORc4UGUpbk07GcBZTYvSOk3IHtp
	 2bYbK5vprrb74Kkc1oyuqPB2SerRQ1U4BH7qGT53SvjPt3CLTB3cLSXow/o4W8HTopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2y3MrDkpFnCHzqE3k+FQu6iub0A3Y9c9El8u8EMyopU=;
	b=TjJZyKULEJolvm3rHnJmrSBSYSp9uCm3DYRjriJtkUk0o1S5t3+QoDxZSkc0hQiTu7jD
	 TUtgUCsfDoWi27tXzB0QwedmVpEaqVrowwr1w/v/RjCHBspigFGncla02qeMYJWP60XO1
	 sxrWy/hIb45hsOPBJlnLxL4FhbQcTcoGtxOUlYKLwD9MDP0BjVJmWZo54Bfpitx3SsMGq
	 pUU6V9lVePjgKHQksL5SQhsaanUPCWKxvRTd+f/ywjc0pMvdNtaLvEt5i7LY/ZEb9n82q
	 Qijn4XjbbsYNP5LTpD4QwCAiXzll+80d9Z9YpaYR+HCcdmTW2h54LG/3Soc8ighzxpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3YgHib6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D46606CEC3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3YgHib6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F91F008A6;
	Tue, 10 Nov 2026 04:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283277;
	bh=2y3MrDkpFnCHzqE3k+FQu6iub0A3Y9c9El8u8EMyopU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3YgHib6hiRS302UAlMnpvMO65LwjjWMrQHD6kqhuse9EEd7F9HNhXQGXgTQngH9X
	 UTBjMxWzLLORWCUQrYFLCDDJ73PrAgDtStyN4YNmalKEJIyKOWkV4Nd7OwlIxL5QdC
	 KL7Cn2WRdyFHVrvaq38KMb/6TQ+O6APR+DB5C1zDjBKrhkb5rpGKBGxpmUrcBN8Gaq
	 HHjYk8EyBhcT4NjI6OdEB3tgM9ix74Jg11v2pdOhmnq2+e5QydQIyytOsa7kUdCk5H
	 QScVRnwKnTvcfscX9X9N2MTedsG3Mattn4WIIFd1QBEPZMhYEJTj/SdVa5DSudbeRG
	 PrgsBTrH3mo+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anusha Srivatsa <asrivats@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/panel: Add new helpers for refcounted panel allocatons
Date: Mon,  9 Nov 2026 23:01:13 -0500
Message-ID: <20261110040023.284489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051740-failed-6.12-4eeeac9d7c36@kernel.org>
References: <20261107051740-failed-6.12-4eeeac9d7c36@kernel.org>
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
index fd8fa2e0ef6fa..4d45b61e9a93a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -354,6 +354,31 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
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

