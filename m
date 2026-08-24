Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426583803D9
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595019; cv=none; b=oiumQ1rwTyE0CYweJa9q1hO3Z/qMfZ9Ib6UTaDdCyX1FDVikpVnAauTFBQlemkktWRwwUWReIATsajjIdY5Lxj1qs6KJTjiSAU0D5h/NIuoZnr1STtyR08WbaTbudjHRZiVOdIQ7qAzG9ea2OiQtmknABK8XoHAGJdYvXraw8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595019; c=relaxed/simple;
	bh=L1yQdOy3oQZC1rPoP8YUDoQsCx/Bkd2r3mbJ4IAjav8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7EkmBz6iHPtsQH7JyVZLgj1erfcMBmNbBzLMg5fBZCV9FNjfxwVlz7umcvAj9GfeJF4w2InHefiY8N8DK39OR5JL8W9J1WxTsxgrhzpf8bT95xFhshJZafunQufq18j9siZzFTsF9iqMNxeGbjjT3r4qoHRqrvxDNMZqCz4lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJYnnY5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJYnnY5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2D31F00A3A;
	Mon, 24 Aug 2026 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595017;
	bh=kejzsgd0/11TfK5GGep7ocA0Q7d9S/u461rHgoE+bDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJYnnY5VMxMJGc5pZBY0NwKii7QCokiRrQzakEYJTZY6yZgse7zQd0FhM1EI15BBC
	 VIF2/RvaKYprvd6EJxA/O7Q2/d3CwrNXYlqFw15Jt+WxLc+hzzIapQLpHveQ9ZPaUG
	 3rq1h3pgInDiYE6OlvzVZ1uJSwJ1RKo3EEdV0FFJcVx/hhN9ERDdKK1hGnUk2weyOq
	 mFRsG5OqZhkU+TDrDaK7sYr7MDCHIg6fBpKeQcvlDNVpYnpPPqi9fZn+fUCR7Bhcak
	 bJcwby1UVbQnK/LQdp5jY5kzBmCQcRfTTKxHvcms2KsRZmj7atP+YkyAjVaEZHtIYS
	 qquLCnO99o72Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] fbdev: Wrap user-invoked calls to fb_set_var() in helper
Date: Mon, 24 Aug 2026 14:10:14 -0400
Message-ID: <20260824181015.254406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082036-chili-glider-8a45@gregkh>
References: <2026082036-chili-glider-8a45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 6f611e5e5f3327cf2e2daabe6ee5acac58cc784e ]

Handle fbcon during display updates in fb_set_var_from_user(). Check
with fbcon if the mode change is possible, update hardware state and
finally update fbcon. Update all callers.

Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
mode-changes callers in sysfs and driver code are missing fbcon-related
steps.

With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
fbcon state themselves.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: 061db6b7a910 ("fbdev: serialize mode sysfs access with lock_fb_info()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
 drivers/video/fbdev/core/fbcon.c       |  2 --
 drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
 drivers/video/fbdev/core/fbsysfs.c     |  4 +---
 drivers/video/fbdev/ps3fb.c            |  5 +----
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
 include/linux/fb.h                     |  2 ++
 7 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 4ebd16b7e3b8d..54f926fb411bd 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -85,11 +85,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		var.activate &= ~FB_ACTIVATE_KD_TEXT;
 		console_lock();
 		lock_fb_info(info);
-		ret = fbcon_modechange_possible(info, &var);
-		if (!ret)
-			ret = fb_set_var(info, &var);
-		if (!ret)
-			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+		ret = fb_set_var_from_user(info, &var);
 		unlock_fb_info(info);
 		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 666293f0864f3..6691e0f8ff41a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2706,7 +2706,6 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
 	else
 		fbcon_modechanged(info);
 }
-EXPORT_SYMBOL(fbcon_update_vcs);
 
 /* let fbcon check if it supports a new screen resolution */
 int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
@@ -2734,7 +2733,6 @@ int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *va
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fbcon_modechange_possible);
 
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0ea182314b89b..a3af47e103b0d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -349,6 +349,19 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 }
 EXPORT_SYMBOL(fb_set_var);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var)
+{
+	int ret = fbcon_modechange_possible(info, var);
+
+	if (!ret)
+		ret = fb_set_var(info, var);
+	if (!ret)
+		fbcon_update_vcs(info, var->activate & FB_ACTIVATE_ALL);
+
+	return ret;
+}
+EXPORT_SYMBOL(fb_set_var_from_user);
+
 static void fb_lcd_notify_blank(struct fb_info *info)
 {
 	int power;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index fa12e5da9bbdc..49d886c2dd7c8 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -20,9 +20,7 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
 	lock_fb_info(fb_info);
-	err = fb_set_var(fb_info, var);
-	if (!err)
-		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	err = fb_set_var_from_user(fb_info, var);
 	unlock_fb_info(fb_info);
 	console_unlock();
 	if (err)
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index dbcda307f6a67..1376d19b19aeb 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -29,7 +29,6 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 
 #include <asm/cell-regs.h>
@@ -830,9 +829,7 @@ static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
 				/* Force, in case only special bits changed */
 				var.activate |= FB_ACTIVATE_FORCE;
 				par->new_mode_id = val;
-				retval = fb_set_var(info, &var);
-				if (!retval)
-					fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+				retval = fb_set_var_from_user(info, &var);
 				console_unlock();
 			}
 			break;
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 72969fe8e5134..e8324b01700f6 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -15,7 +15,6 @@
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
@@ -1768,11 +1767,9 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	var.height = ch->display.height;
 	var.activate = FB_ACTIVATE_NOW;
 
-	if (fb_set_var(info, &var) < 0)
+	if (fb_set_var_from_user(info, &var) < 0)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
-
-	fbcon_update_vcs(info, true);
 }
 
 /*
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5178a33c752c6..88680a7cabd55 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_blank(struct fb_info *info, int blank);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var);
+
 /*
  * Helpers for framebuffers in I/O memory
  */
-- 
2.53.0

