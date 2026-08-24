Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2E381EA8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595019; cv=none; b=HIb3kUa3lmwdBhE2Dofr/zGX1KeISOChXO9T16mZO/AeK+pepjdCw+cLJNiQNGvj9g2VmuhqGI+LW5CDs1BKgZu4oegG6KzSvFHhFarZC4yvMJclt9VYoVBMuBCsRfICWwLSar/9QwFbN1vIGcm87KKCfsyYsilqhUJfNKXkmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595019; c=relaxed/simple;
	bh=ZPqKgEwPAX+vRrNBanKs3rapNLJizSzTPklcNGpEKy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jry/0k3/BzyIF5cT/vPUfYtKgMLOCks9jL36zL3r1qjxm07EJRFGNeE+irk73tz7FAFkTFvX5XFn2NS+spN/cHBGQGDBKF9znfvacM8svFtX8eta+d7q56gVQyALBuOY4jZAO3YmZFgLHCKL2dsycuAI1uOHK6NZj+G2waZtCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG/OUCU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG/OUCU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F81F000E9;
	Mon, 24 Aug 2026 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595018;
	bh=RQUkC9oFopQOHam7DR8oqxdyGx3d3CnMnplPfaPimu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG/OUCU6DZZ6rwp0DsrNjg7ZwGI14w/sItKgcgud2RU63Ioo+V9YmvChIpNeqbJ24
	 iPOzcKObuNheo7vNaxzBzhLeDnVPZsQm1xV355mmgaKOZCxDSnqGJgTD1D2UtX/XkJ
	 UdFtnRDdGeqnhpQyyL65F4Wsg0CgI8S9luIP8qbRDsMGHJbTiDwCOKc2XIELDFnjV/
	 mrFGyVB3ebz0+6kqtSaDuLuyM58ZiPni/bFllhsdYfQCinM/1owJ/bJNV1oqWErpgQ
	 4tZE0pGyg/Xb9RH86LPrXQJ5S7AL5Y9Kg9fYgpYYcTkQIMM8tMn0cTZNkK4KevPHxN
	 U3t4yDJMT37SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melbin K Mathew <mlbnkm1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] fbdev: serialize mode sysfs access with lock_fb_info()
Date: Mon, 24 Aug 2026 14:10:15 -0400
Message-ID: <20260824181015.254406-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824181015.254406-1-sashal@kernel.org>
References: <2026082036-chili-glider-8a45@gregkh>
 <20260824181015.254406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Melbin K Mathew <mlbnkm1@gmail.com>

[ Upstream commit 061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 46 ++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 49d886c2dd7c8..c32dd71a38e1c 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -13,19 +13,24 @@
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
@@ -66,6 +71,9 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	memset(&var, 0, sizeof(var));
 
+	console_lock();
+	lock_fb_info(fb_info);
+
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, sizeof(mstr), 0, mode);
@@ -73,12 +81,22 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
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
 
@@ -86,11 +104,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
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
@@ -138,12 +165,15 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
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
 
-- 
2.53.0

