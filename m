Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914954DAC8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955675; cv=none; b=rJYp4OjidhXVTr0EYP8KP67F/qYSHgcp9mCC16fXTb4qgyhdQyBlhYUslLz8jQ9aVuTHNjzpsNJEq43yv/phzdADorNMaWge6evYrfac/klV4KvuHGcqFcQkaEqniUo5fw4JfcjqahXNM+Nejc4NVUPSXgoM75omOFNZOY/bY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955675; c=relaxed/simple;
	bh=eHwCOrWcA+8kHDLhtoCbJsLnSy7MHMavGUZZW6mVqCw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ddei7xLMrC5N10jAqY5U6qgq5d6olMgcsZ6RWNi1KNvrwNEVA49OhiN3d/YBhXvjJxHYg4GAiRY22DC40HS1RJDRuaaYavCngtoiehTHMceGzOKFXKYqKN+sN15C5sV4m0fOnUk/wK2B2aXkdOJ7Azr1bqb6Nr9s5Nz36S0EPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPw1Fu1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPw1Fu1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BD1F00AC4;
	Wed,  9 Sep 2026 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955673;
	bh=2fvAp+ZoEWdj1ejlgdZei+Mknw9JhOFAtZYaxy0ypW4=;
	h=Subject:To:Cc:From:Date;
	b=uPw1Fu1gfICKFUu1ioR9F8NnguhBpgjuFkmBFcoqaH7ma2jeVDeyceOfZD5V7xaUB
	 o+vh5g/BvIcESpXAPlRJOb4akuB7E4BsP4NWhtq4J3hnNuLzAWIK/qK1K3Etw2z8Le
	 9nvzz6Kba4ZEwbMmwZLYsa3EYWvB4SHyVFFCfxdk=
Subject: FAILED: patch "[PATCH] drm/sysfb: simpledrm: Improve panel-size validation" failed to apply to 6.12-stable tree
To: tzimmermann@suse.de,javierm@redhat.com,mripard@kernel.org,rayyan@ansari.sh,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:29 +0200
Message-ID: <2026090929-granddad-turkey-01e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3a75a0761914d01c7362adf1f906cc1d1762c189
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090929-granddad-turkey-01e8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a75a0761914d01c7362adf1f906cc1d1762c189 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 25 Jun 2026 11:39:34 +0200
Subject: [PATCH] drm/sysfb: simpledrm: Improve panel-size validation

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

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 15dcafa9d524..6bbe779ec870 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -193,6 +193,39 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
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
@@ -594,7 +627,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct drm_sysfb_device *sysfb;
 	struct drm_device *dev;
 	int width, height, stride;
-	int width_mm = 0, height_mm = 0;
+	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
@@ -658,8 +691,18 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
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

