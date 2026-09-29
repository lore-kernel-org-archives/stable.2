Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7873DA7F8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696561; cv=none; b=aEA7zHOMEsjwP0c3us5mWgW/wcqug8FB5A/5iw9OVRJ3HMTO4tsCikKptg6gzJZ8rF0BrQ5sKFKpV2Iy818DaArcv9qP8RFg8H0WAkMSW0Kyj9W+cBjM5P9rAFG0DCzzc8F1bn69SEUnoADWgH3j9YFEBK5F8FENqISVHTwZuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696561; c=relaxed/simple;
	bh=jQ0BO9bcb/fDTmlKLMQrhnXwHxyGqgpnSP3aW+9lv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bItAJ65w3Stapc+EtD6+DRf31QfJMrSyCE3GhuiAje5Rp4wWFN1gvSDXe/Tgvi8tY8MSEQk9MikKhdnCFKlyz8o2pR5eMpXnTEhJYQsRe0ac8T1Er9pYVz3y7XG4/sFueuq1AzpH8+ezQLubkjmIwxPAW/dAlKslJ8kjdjk/P50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgwNJSwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgwNJSwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325931F00893;
	Tue, 29 Sep 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696559;
	bh=jrLcWxczPqomYkqr3S1SAv7+VCdHYgOMb7rNg77eS3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FgwNJSwtFJ8+bG8d+L7fmHsL9FGb66uMCHypf//VVzKh72zHi5JYB7YJOTQvP+VKi
	 LbVeZ2JGDpBPJ6cU0OwnYyzxyVEFhVSZ7VFyJsg1uYja0W/HY0O3MoU/v0fzJ7bESa
	 7kC3QJtkyw9ABB7JPZwzfEpVt3wfkiKZGAkumW69u/4b07AHnOyw/RjTKh6xpeYrqP
	 iy4QY0Xebs0y+xJF+Yug8wpJUd8b/jg3a2MU9jqieMukI+wAB9EUrdWKcl9cK8V2mT
	 tCs9xDrjnNjNUyM6aFUnqUkPwe4VeUHNE0++r/eRbeLvwkBnZUxYdmw1uyJnHzYnov
	 SZNVkl9BltNLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] drm/client: Pass force parameter to client restore
Date: Tue, 29 Sep 2026 11:42:35 -0400
Message-ID: <20260929154236.4087907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929154236.4087907-1-sashal@kernel.org>
References: <2026092902-autistic-bonnet-dcb5@gregkh>
 <20260929154236.4087907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 943240d342f148896733eb6c7b223a08aa1f520a ]

Add force parameter to client restore and pass value through the
layers. The only currently used value is false.

If force is true, the client should restore its display even if it
does not hold the DRM master lock. This is be required for emergency
output, such as sysrq.

While at it, inline drm_fb_helper_lastclose(), which is a trivial
wrapper around drm_fb_helper_restore_fbdev_mode_unlocked().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patch.msgid.link/20251110154616.539328-2-tzimmermann@suse.de
Stable-dep-of: 1fca688e9443 ("drm/client: fix restore of partially initialized client")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/clients/drm_fbdev_client.c |  6 ++++--
 drivers/gpu/drm/drm_client_event.c         |  4 ++--
 drivers/gpu/drm/drm_fb_helper.c            | 24 ++++++----------------
 drivers/gpu/drm/drm_file.c                 |  2 +-
 include/drm/drm_client.h                   |  8 +++++---
 include/drm/drm_client_event.h             |  4 ++--
 include/drm/drm_fb_helper.h                |  8 ++------
 7 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index ec5ab9f305471..c8327c66a4abc 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -26,9 +26,11 @@ static void drm_fbdev_client_unregister(struct drm_client_dev *client)
 	}
 }
 
-static int drm_fbdev_client_restore(struct drm_client_dev *client)
+static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
 {
-	drm_fb_helper_lastclose(client->dev);
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+
+	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_client_event.c b/drivers/gpu/drm/drm_client_event.c
index c3baeb4d4e6bc..cf8799d3734dc 100644
--- a/drivers/gpu/drm/drm_client_event.c
+++ b/drivers/gpu/drm/drm_client_event.c
@@ -101,7 +101,7 @@ void drm_client_dev_hotplug(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_client_dev_hotplug);
 
-void drm_client_dev_restore(struct drm_device *dev)
+void drm_client_dev_restore(struct drm_device *dev, bool force)
 {
 	struct drm_client_dev *client;
 	int ret;
@@ -114,7 +114,7 @@ void drm_client_dev_restore(struct drm_device *dev)
 		if (!client->funcs || !client->funcs->restore)
 			continue;
 
-		ret = client->funcs->restore(client);
+		ret = client->funcs->restore(client, force);
 		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
 		if (!ret) /* The first one to return zero gets the privilege to restore */
 			break;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index df73433b46527..71889daef3fc3 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -253,6 +253,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
 /**
  * drm_fb_helper_restore_fbdev_mode_unlocked - restore fbdev configuration
  * @fb_helper: driver-allocated fbdev helper, can be NULL
+ * @force: ignore present DRM master
  *
  * This helper should be called from fbdev emulation's &drm_client_funcs.restore
  * callback. It ensures that the user isn't greeted with a black screen when the
@@ -261,9 +262,9 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
  * Returns:
  * 0 on success, or a negative errno code otherwise.
  */
-int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper)
+int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper, bool force)
 {
-	return __drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, false);
+	return __drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
 }
 EXPORT_SYMBOL(drm_fb_helper_restore_fbdev_mode_unlocked);
 
@@ -1316,9 +1317,9 @@ int drm_fb_helper_set_par(struct fb_info *info)
 	 * the KDSET IOCTL with KD_TEXT, and only after that drops the master
 	 * status when exiting.
 	 *
-	 * In the past this was caught by drm_fb_helper_lastclose(), but on
-	 * modern systems where logind always keeps a drm fd open to orchestrate
-	 * the vt switching, this doesn't work.
+	 * In the past this was caught by drm_fb_helper_restore_fbdev_mode_unlocked(),
+	 * but on modern systems where logind always keeps a drm fd open to
+	 * orchestrate the vt switching, this doesn't work.
 	 *
 	 * To not break the userspace ABI we have this special case here, which
 	 * is only used for the above case. Everything else uses the normal
@@ -1946,16 +1947,3 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
-
-/**
- * drm_fb_helper_lastclose - DRM driver lastclose helper for fbdev emulation
- * @dev: DRM device
- *
- * This function is obsolete. Call drm_fb_helper_restore_fbdev_mode_unlocked()
- * instead.
- */
-void drm_fb_helper_lastclose(struct drm_device *dev)
-{
-	drm_fb_helper_restore_fbdev_mode_unlocked(dev->fb_helper);
-}
-EXPORT_SYMBOL(drm_fb_helper_lastclose);
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index eebd1a05ee974..be5e617ceb9f1 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -405,7 +405,7 @@ EXPORT_SYMBOL(drm_open);
 
 static void drm_lastclose(struct drm_device *dev)
 {
-	drm_client_dev_restore(dev);
+	drm_client_dev_restore(dev, false);
 
 	if (dev_is_pci(dev->dev))
 		vga_switcheroo_process_delayed_switch();
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 540d2bd70c006..bf9783c978344 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -47,12 +47,14 @@ struct drm_client_funcs {
 	 *
 	 * Note that the core does not guarantee exclusion against concurrent
 	 * drm_open(). Clients need to ensure this themselves, for example by
-	 * using drm_master_internal_acquire() and
-	 * drm_master_internal_release().
+	 * using drm_master_internal_acquire() and drm_master_internal_release().
+	 *
+	 * If the caller passes force, the client should ignore any present DRM
+	 * master and restore the display anyway.
 	 *
 	 * This callback is optional.
 	 */
-	int (*restore)(struct drm_client_dev *client);
+	int (*restore)(struct drm_client_dev *client, bool force);
 
 	/**
 	 * @hotplug:
diff --git a/include/drm/drm_client_event.h b/include/drm/drm_client_event.h
index 985d6f02a4c43..79369c755bc90 100644
--- a/include/drm/drm_client_event.h
+++ b/include/drm/drm_client_event.h
@@ -10,7 +10,7 @@ struct drm_device;
 #if defined(CONFIG_DRM_CLIENT)
 void drm_client_dev_unregister(struct drm_device *dev);
 void drm_client_dev_hotplug(struct drm_device *dev);
-void drm_client_dev_restore(struct drm_device *dev);
+void drm_client_dev_restore(struct drm_device *dev, bool force);
 void drm_client_dev_suspend(struct drm_device *dev);
 void drm_client_dev_resume(struct drm_device *dev);
 #else
@@ -18,7 +18,7 @@ static inline void drm_client_dev_unregister(struct drm_device *dev)
 { }
 static inline void drm_client_dev_hotplug(struct drm_device *dev)
 { }
-static inline void drm_client_dev_restore(struct drm_device *dev)
+static inline void drm_client_dev_restore(struct drm_device *dev, bool force)
 { }
 static inline void drm_client_dev_suspend(struct drm_device *dev)
 { }
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 2faf8aaf98dc7..dd9a18f8de5a7 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -254,7 +254,8 @@ int drm_fb_helper_set_par(struct fb_info *info);
 int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 
-int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper);
+int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper,
+					      bool force);
 
 void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_fill_info(struct fb_info *info,
@@ -281,7 +282,6 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_debug_enter(struct fb_info *info);
 int drm_fb_helper_debug_leave(struct fb_info *info);
-void drm_fb_helper_lastclose(struct drm_device *dev);
 #else
 static inline void drm_fb_helper_prepare(struct drm_device *dev,
 					 struct drm_fb_helper *helper,
@@ -397,10 +397,6 @@ static inline int drm_fb_helper_debug_leave(struct fb_info *info)
 {
 	return 0;
 }
-
-static inline void drm_fb_helper_lastclose(struct drm_device *dev)
-{
-}
 #endif
 
 #endif
-- 
2.53.0

