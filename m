Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711871;
	b=FbEjopTcREum/unnW+14/yqjCQuODTm71Trdz0Giu2Ahchlkd640njcQtUKrSuxaoSws
	 +BtG/VwbF+UFVxS4lMEodjFw12oT//H5jISjw3U5Fi05680Ddnt93jtF0Dwk5Eex0GymL
	 jqadPAV2VMssBibNAqr08O9ameWYMZjF/2wSq/B/2ZaUEQVGD1Y8htkLHi1RGm97jVNo0
	 sXOD4oCzY8cvClVoJ6ZfjZ/ggP8BavABpKEs4zlT90Y7NDmm/RKzd2zIBVwl/c/Lg/b5v
	 ylhBc2CR8nrRp4T2DKH0nQtD8H3kyY3VskEBIEOKJI5cyi8bckcFo6MSbi47iL5a96w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VyFUo5xJfwdh65Va9N9LwA61fHFpb+VKN7H52mhfkQM=;
	b=eWboFRdQRqUF6d/FXkFVJvSqb1qHr3p15/5yS9wsjP39x49edy+i8LOL7YDq65PnQvdH
	 eX3D8GRD8ncLpCYtaLJqLehB1U2JZ22qIYw3eXFCzjbrjk3xLevxXGsJ3gHFq8QEzVi9U
	 AK8DTeBPh8TIks1K3NLb3z53qTjkAsGu8ra/EZ2p6LqedPSk7e4NSB0e9TpkB4M+hRcMT
	 oYG4GyaPMbXc1MdAhJmNwL43fsn//L8vTTABt1bgZRwNa9EW077q1LT68pOFUvPeFAmOM
	 0LYekCiy6a3z0OMOaBIJoKilt6tnWnZ47edRuMxreWgBB52RA5XAbcVZnSKHPovAFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Txb/2icu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43244606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txb/2icu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC371F000D0;
	Thu, 26 Nov 2026 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711870;
	bh=VyFUo5xJfwdh65Va9N9LwA61fHFpb+VKN7H52mhfkQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Txb/2icujWgmOI1NyZ7Uhhw2t3K9CucRa7744/XG+00BppEAwXift+up+xF8wWdm2
	 ZPG4nwg6cwKCcKQsifXaNpWlyxsGVo+IxfPWXtOEzvvof3ExKvzc9GoJZzu3hukWvu
	 PKwem3wCzlGg70DlayYy/dUmitmk7TlVXCwtGBVrav6YGat3pTiI+86lx1o+cyY3FP
	 lWvWXvdiIBt2qK2SLbeF6i/RiczMYDVpDZq59iTMRq+ev9swGk/Bvg24pB/9rs7J4m
	 mMgxnKnK5YUUuPcOmgPRQkeY/vEWFTfVt5oo7uqhCFL7HAxI8+JE6uzhVldo+e0oSM
	 RNGYzdAroHvmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] devres: Move devm_*_action*() APIs to devres.h
Date: Thu, 26 Nov 2026 11:51:06 -0500
Message-ID: <20261126165025.2602010-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126165025.2602010-1-sashal@kernel.org>
References: <2026112512-disfigure-marmalade-b2e1@gregkh>
 <20261126165025.2602010-1-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f5e5631df596ade5875ba1dc5d640611745d0c0d ]

We have a newly created header linux/device/devres.h that gathers
device managed APIs, so users won't need to include entire device.h
for only these ones. Move devm_*_action*() APIs to devres.h as well.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Zijun Hu <quic_zijuhu@quicinc.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250220162238.2738038-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 6c6508e742b4 ("usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device.h        | 38 ----------------------------------
 include/linux/device/devres.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 601e60c68504c..a1d412a9d6324 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -286,44 +286,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/* allows to add/remove a custom action to devres stack */
-int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
-
-/**
- * devm_remove_action() - removes previously added custom action
- * @dev: Device that owns the action
- * @action: Function implementing the action
- * @data: Pointer to data passed to @action implementation
- *
- * Removes instance of @action previously added by devm_add_action().
- * Both action and data should match one of the existing entries.
- */
-static inline
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
-{
-	WARN_ON(devm_remove_action_nowarn(dev, action, data));
-}
-
-void devm_release_action(struct device *dev, void (*action)(void *), void *data);
-
-int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
-#define devm_add_action(dev, action, data) \
-	__devm_add_action(dev, action, data, #action)
-
-static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
-					     void *data, const char *name)
-{
-	int ret;
-
-	ret = __devm_add_action(dev, action, data, name);
-	if (ret)
-		action(data);
-
-	return ret;
-}
-#define devm_add_action_or_reset(dev, action, data) \
-	__devm_add_action_or_reset(dev, action, data, #action)
-
 /**
  * devm_alloc_percpu - Resource-managed alloc_percpu
  * @dev: Device to allocate per-cpu memory for
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 9b49f99158508..9cd1787ef28ed 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -8,6 +8,7 @@
 #include <linux/overflow.h>
 #include <linux/stdarg.h>
 #include <linux/types.h>
+#include <asm/bug.h>
 
 struct device;
 struct device_node;
@@ -126,4 +127,42 @@ void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int in
 
 #endif
 
+/* allows to add/remove a custom action to devres stack */
+int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
+
+/**
+ * devm_remove_action() - removes previously added custom action
+ * @dev: Device that owns the action
+ * @action: Function implementing the action
+ * @data: Pointer to data passed to @action implementation
+ *
+ * Removes instance of @action previously added by devm_add_action().
+ * Both action and data should match one of the existing entries.
+ */
+static inline
+void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+{
+	WARN_ON(devm_remove_action_nowarn(dev, action, data));
+}
+
+void devm_release_action(struct device *dev, void (*action)(void *), void *data);
+
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
+#define devm_add_action(dev, action, data) \
+	__devm_add_action(dev, action, data, #action)
+
+static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
+					     void *data, const char *name)
+{
+	int ret;
+
+	ret = __devm_add_action(dev, action, data, name);
+	if (ret)
+		action(data);
+
+	return ret;
+}
+#define devm_add_action_or_reset(dev, action, data) \
+	__devm_add_action_or_reset(dev, action, data, #action)
+
 #endif /* _DEVICE_DEVRES_H_ */
-- 
2.53.0

