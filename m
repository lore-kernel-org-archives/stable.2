Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63054B1DD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955672; cv=none; b=Xp6fccd/L0gVkkuvcGA+ADHx9bie0lYSdfg0zBGxQx1GIvYdC+/R3voUPxGxiH+kO2lPu7SlxJrkO0n+l/UULNFsVf+dZ3doP98bXv0ImEr+kNSKE6K2r1+M0dea7jnapyCTb6Os6DMPSqqy9Mmd/2ReOU+HVy5Qonpnkcst77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955672; c=relaxed/simple;
	bh=A4dvMwLV3ssJVuoFHxBZOP2Sode/sAg4nTFaB3dCq6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JXm1jRS5B1QQ/JBr9nhYtIlxKRXV9a1OPEwaczpM2cmM5fkne/i33tx4WRHGkdJJDhKAQX3kOHSMD93yl+MhzZCPlZBXZOurCAo5yWMwaQNxN3bX+8pnM7wlPrDsgyhgTK7vmba8tiBZQREY1JEoZ35+iB+yk5wUtSbvrKcbXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZlNo7ab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZlNo7ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA161F00A3A;
	Wed,  9 Sep 2026 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955670;
	bh=EY3yEq7HMKG+vtJjclM+07kDy0qhFldNr95eCKuk21I=;
	h=Subject:To:Cc:From:Date;
	b=mZlNo7ab3o1rmzeUhF85Flw8Zgeay2MQzUIHYkZWcLyGhD+c7BIJLxqHqrtPMIV7u
	 AWs9SY9MNMM3icq1XbLsM3nklFbO5zC58CEp9yFXSP2S9heP8DXLUUoCWIi279GwFT
	 i16j1x0aG5BJGu/T9T5PjmVEPJAQXCJeeh7+8/YU=
Subject: FAILED: patch "[PATCH] drm/sysfb: simpledrm: Improve framebuffer-size validation" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,javierm@redhat.com,mripard@kernel.org,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:20 +0200
Message-ID: <2026090919-unstylish-evade-283b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 03f1a3545b721fa7fdadd00080e237519a286a97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090919-unstylish-evade-283b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03f1a3545b721fa7fdadd00080e237519a286a97 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 25 Jun 2026 11:39:33 +0200
Subject: [PATCH] drm/sysfb: simpledrm: Improve framebuffer-size validation

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

v2:
- remove unused function simplefb_get_validated_int0() (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Link: https://patch.msgid.link/20260625094509.157581-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index fc168920f2c6..15dcafa9d524 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -48,13 +48,6 @@ simplefb_get_validated_int(struct drm_device *dev, const char *name,
 	return drm_sysfb_get_validated_int(dev, name, value, INT_MAX);
 }
 
-static int
-simplefb_get_validated_int0(struct drm_device *dev, const char *name,
-			    uint32_t value)
-{
-	return drm_sysfb_get_validated_int0(dev, name, value, INT_MAX);
-}
-
 static const struct drm_format_info *
 simplefb_get_validated_format(struct drm_device *dev, const char *format_name)
 {
@@ -88,14 +81,14 @@ static int
 simplefb_get_width_pd(struct drm_device *dev,
 		      const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "width", pd->width);
+	return drm_sysfb_get_validated_int0(dev, "width", pd->width, U16_MAX);
 }
 
 static int
 simplefb_get_height_pd(struct drm_device *dev,
 		       const struct simplefb_platform_data *pd)
 {
-	return simplefb_get_validated_int0(dev, "height", pd->height);
+	return drm_sysfb_get_validated_int0(dev, "height", pd->height, U16_MAX);
 }
 
 static int
@@ -144,7 +137,7 @@ simplefb_get_width_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "width", width);
+	return drm_sysfb_get_validated_int0(dev, "width", width, U16_MAX);
 }
 
 static int
@@ -155,7 +148,7 @@ simplefb_get_height_of(struct drm_device *dev, struct device_node *of_node)
 
 	if (ret)
 		return ret;
-	return simplefb_get_validated_int0(dev, "height", height);
+	return drm_sysfb_get_validated_int0(dev, "height", height, U16_MAX);
 }
 
 static int

