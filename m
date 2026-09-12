Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A19CA6F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226044; cv=none; b=l4iCqMRtInuaFcdKpvs4EylS2f3rLBSGfCtjBsNS9Hf6aNxFkgIfYu7+DWn9Ii8yl/iVDtcpG7z8ht1uy32i1+loc+1OI5by5QccmJQXMCK32rjBovRL15f+c+RbknUrJqTtdYMAPzAw1vD/3sa18aKnBkbP4NBSqFe5F8xvPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226044; c=relaxed/simple;
	bh=tZ0vcwJxtqRX31vi1bWmPPh4roCcv2W2YDGZO61GGa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PODPxVUKUXlZYbtbCGrs6+Irqb7rO0qn0jfkjYtV3KPPu+yeRg+Np1UX7MXpsUNob+iMpsImg0/RbuHqZGyCVkqkYs+RyKROedJCabK3wve87QKjAymqh/1RDv+/ZRtRnaPhIiQJrweEku3z5gRulHwigda21KCveGtUH49Q5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbqTgsi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbqTgsi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9D1F00893;
	Sat, 12 Sep 2026 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226042;
	bh=Vtru4iSBYJppNS61AlPrctUhxWCvCdDeASUQmgCqlWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VbqTgsi70x9E/9h/ui4tpdqnoudI7knVf3Dq/TDKu0anbtYtcQKtqPgOk4vduqlpN
	 fA7ZMOeAIXLFXniYZhsKcjSrdfSaldXnCGYMXP8UTCLIpJeHXeTXaxfT92eJJjocfX
	 FfyGCr0lPwzCiL4c0j+bgJUtJPipXxvKzU1XLQfgPfHK4tYwexi2Ey92rL/Phlfq2d
	 kcBdjGhPIaI7MGAm8rw64nhlS0/v/3WH+UbXLUPayCdRICtcWHmP5rALsaaODknBXV
	 X8zsdFPRoswXif5wbI+FbcBKS6G+o/PhdllQ7LevVb+GKBWNTvWaGgtANwY1ILrFpl
	 w4OWqjRui8mSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/sysfb: simpledrm: Improve panel-size validation
Date: Sat, 12 Sep 2026 11:14:00 -0400
Message-ID: <20260912151400.3070794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-granddad-turkey-01e8@gregkh>
References: <2026090929-granddad-turkey-01e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3a75a0761914d01c7362adf1f906cc1d1762c189 ]

Validate the panel size from the device-tree node against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail transparently on errors; do not warn.

v3:
- move comments to a more prominent place (Thierry)
v2:
- only use initialized values in debugging output (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height configuration via panel node")
Cc: Rayyan Ansari <rayyan@ansari.sh>
Cc: <stable@vger.kernel.org> # v6.4+
Link: https://patch.msgid.link/20260625094509.157581-3-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 49 ++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 07abaf27315f7..44f7203cd534d 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -212,6 +212,39 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
 	return res;
 }
 
+static int __simplefb_get_panel_size_mm_of(struct drm_device *dev,
+					   struct device_node *of_panel_node,
+					   const char *name)
+{
+	int ret;
+	u32 value;
+
+	ret = of_property_read_u32(of_panel_node, name, &value);
+	if (ret) {
+		drm_dbg(dev, "simplefb: cannot parse panel %s: error %d\n",
+			name, ret);
+		return ret;
+	} else if (value > U16_MAX) {
+		drm_dbg(dev, "simplefb: panel %s of %u exceeds maximum value\n",
+			name, value);
+		return -EINVAL;
+	}
+
+	return value;
+}
+
+static int simplefb_get_panel_width_mm_of(struct drm_device *dev,
+					  struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
+}
+
+static int simplefb_get_panel_height_mm_of(struct drm_device *dev,
+					   struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -781,7 +814,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct simpledrm_device *sdev;
 	struct drm_device *dev;
 	int width, height, stride;
-	int width_mm = 0, height_mm = 0;
+	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
@@ -844,8 +877,18 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			return ERR_CAST(mem);
 		panel_node = of_parse_phandle(of_node, "panel", 0);
 		if (panel_node) {
-			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
-			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
+			/*
+			 * Ignore errors from parsing the physical panel
+			 * size. Using the pre-initialized sizes of 0 will
+			 * make drm_sysfb_mode() calculate a default physical
+			 * size based on a resolution of 96 dpi.
+			 */
+			ret = simplefb_get_panel_width_mm_of(dev, panel_node);
+			if (ret > 0)
+				width_mm = ret;
+			ret = simplefb_get_panel_height_mm_of(dev, panel_node);
+			if (ret > 0)
+				height_mm = ret;
 			of_node_put(panel_node);
 		}
 	} else {
-- 
2.53.0

