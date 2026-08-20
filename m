Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C43E765A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223703; cv=none; b=HkgrxH8+UzM3dJS9OAYJcR5YPuDrOig4iIGFQdY8HXugEkag+bgRXBJuaUAb0xu9gIkIkFmgiQrvxWQfS7HspBcdQqG1l3IHRSNrJIs8sVJIWJu2cQH7KpXLTG7l3+Fz7AxrTOv0nFIBNTuaTSF1fIvOEWNTmLBDUFGKFFgt2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223703; c=relaxed/simple;
	bh=IvEovyguazzTst5/qps3tppgDBhGjuhTAxzhRbxifZE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iAlQU+pQx8iTL0pziQt8dGYnO4FBFHiKz/sGYk2Gov0mmBlagPCrbdd5wH3tsA5AFuwBxSzeIXTNl/ScPNBx+8Gl5wnyDJHjEwgNeHbNkz5RQMcHXxMY23sfzMf8Kg0Qx5tX1jIL2Pi0O5f8DjKW/Lg6dF+NcZYE5nPPsdSeLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PosiB4uY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PosiB4uY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799C01F000E9;
	Thu, 20 Aug 2026 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787223701;
	bh=neOqON4NPA9fJYhIcwkJ7NJimnO370h+51iOmvt6XF8=;
	h=Subject:To:Cc:From:Date;
	b=PosiB4uY5n8vSL8F+2nkjCFuNyugxpCwxyNAujtEoSvj58ZY1Ces0m3A9cPofpaSk
	 C1eqf3cPIHHbJwfOVhnHw1jEcn3GKFExJkYgjIRGPHLnZMqtdzxENYYcEoRWZuioyx
	 uktCJ93RbDun9g/xIoEyNKEEVcCVWhyQfRKqY/Vo=
Subject: FAILED: patch "[PATCH] fbdev: serialize mode sysfs access with lock_fb_info()" failed to apply to 7.1-stable tree
To: mlbnkm1@gmail.com,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:01:36 +0200
Message-ID: <2026082036-chili-glider-8a45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082036-chili-glider-8a45@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 Mon Sep 17 00:00:00 2001
From: Melbin K Mathew <mlbnkm1@gmail.com>
Date: Thu, 2 Jul 2026 01:42:48 +0200
Subject: [PATCH] fbdev: serialize mode sysfs access with lock_fb_info()

show_mode(), show_modes(), and store_mode() access fb_info->modelist
and fb_info->mode without holding lock_fb_info(). store_modes() takes
lock_fb_info() while replacing the modelist and freeing the old one.

A concurrent reader or writer can load a pointer to an old modelist
entry before store_modes() frees it, then dereference freed memory or
store a stale freed pointer in fb_info->mode.

Take lock_fb_info() in show_mode(), show_modes(), and store_mode() to
serialize with store_modes(). In show_mode(), copy the mode to the
stack and format after dropping the lock. In store_mode(), split
activate() into a _locked variant to avoid double-locking, and hold
the locks for the modelist walk, mode conversion, activation, and
fb_info->mode assignment together.

Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index af21dc5052df..d3d60c555bb8 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -12,19 +12,24 @@
 #include "fb_internal.h"
 #include "fbcon.h"
 
+static int activate_locked(struct fb_info *fb_info,
+			    struct fb_var_screeninfo *var)
+{
+	var->activate |= FB_ACTIVATE_FORCE;
+	return fb_set_var_from_user(fb_info, var);
+}
+
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
 
-	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
 	lock_fb_info(fb_info);
-	err = fb_set_var_from_user(fb_info, var);
+	err = activate_locked(fb_info, var);
 	unlock_fb_info(fb_info);
 	console_unlock();
-	if (err)
-		return err;
-	return 0;
+
+	return err;
 }
 
 static int mode_string(char *buf, size_t size, unsigned int offset,
@@ -65,6 +70,9 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	memset(&var, 0, sizeof(var));
 
+	console_lock();
+	lock_fb_info(fb_info);
+
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, sizeof(mstr), 0, mode);
@@ -72,12 +80,22 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 			var = fb_info->var;
 			fb_videomode_to_var(&var, mode);
-			if ((err = activate(fb_info, &var)))
+			err = activate_locked(fb_info, &var);
+			if (err) {
+				unlock_fb_info(fb_info);
+				console_unlock();
 				return err;
+			}
 			fb_info->mode = mode;
+			unlock_fb_info(fb_info);
+			console_unlock();
 			return count;
 		}
 	}
+
+	unlock_fb_info(fb_info);
+	console_unlock();
+
 	return -EINVAL;
 }
 
@@ -85,11 +103,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 			 char *buf)
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
+	struct fb_videomode mode;
+	bool have_mode = false;
 
-	if (!fb_info->mode)
+	lock_fb_info(fb_info);
+	if (fb_info->mode) {
+		mode = *fb_info->mode;
+		have_mode = true;
+	}
+	unlock_fb_info(fb_info);
+
+	if (!have_mode)
 		return 0;
 
-	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -137,12 +164,15 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, PAGE_SIZE, i, mode);
 		if (i >= PAGE_SIZE - 1)
 			break;
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 

