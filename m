Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEE239085
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949384; cv=none; b=hsG1e1W5jvdm9uG1mrJutUPVMXQfuVMKTA5uM5AQGQwm5TymVPe7XXtkOgZBrmJKI8pdUXMxK0mr7N8lgOu3ILeBnRJYHPRQxS8sW3kRiVmztEwPqmVN93qbH6AbEPYipe4cYM3Au3IMuiIXXUISHefez1W0O7XgFpG2CrYmgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949384; c=relaxed/simple;
	bh=LCQ5ybY2W5wSNed4JctAr7mTZXfrxHe+bWEoILZJZwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhGYVyqbI2cR7HOTeoESa3GfbE8yEg0/9UEh6lPZo2JBffNburNKIWv9/Vp6EnGVfuRKGpRA5oCanLyFe7QIsfdlzSkbpZGaILotBqYUsVvvYJRS1XlUTG4+6RpRTy7HnOt/loPVUjweG03P501zIDgd5FiiixgUf+jYWgsXczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkPdlsBd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkPdlsBd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeae771c49so1133233e87.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782949381; x=1783554181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
        b=JkPdlsBdf4cS+C34AVRyVeY3zM/jZPOIUkRashaM+siqNDXniGcnvK9Fhqbd48HBh7
         JUe7dhYfMWHfHJScIFdeNX7Kgjtu4LMEA0KLhQuKXGYGa5sasKtqQmk3lnp4SAb6jIjX
         WaeGf195f9mJ/hvZh4ZRF/iWedOKIOk8sXBpp9F9JIyovRfkS3+XOaqqVcC8TmFLJB8X
         h5zd8Vt0rPMZtCj49sTziglB7NCwfxTN5DLeuji0vGXB5t+1dNbi7Uey22KLiUi+qw2z
         HoeRlHX4WedKs6Q3lEcb5v52X4q+Y/fhdlzq9uWJD6riSf/riIrLe2yYzkV5PCAZzZ3m
         71nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949381; x=1783554181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
        b=HVvFoZBxlwxoY8q7wRAC+KYUg1JMzfV/WBqkkbRhPjlypNJFu55vlf6KvG+HEl7zTr
         oC7mmO1G/5RL13BRlqhJqdWLEP+ryQm0UYdqCWGWjsMMRuxg33kCvfRR7uxUqRWKSnnd
         jutdR5otfuZjGsYZ5g0XR4Hx3B/OX/mi+bZWpmzNHVoPGBrKJ1wiuE+P8+Aa2I7i9X/i
         o6d1AVLS+Iz7tGSDBblVroIQZAltXSg5+EUckMLelapKGyJwtNIH4OjKqHQ7cBrUQmyI
         aAOC3W+obQX391wZcnN81hUbKuq3i4O6UsRpVrc9XP8zztltAFTVil0QAtdkxB2F0XdR
         tjEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQvez7sTegoIdxbUngrZsgbOyphXGjdQKFwSbq91ue2ziLXkfLb6yiWm3AGvzvK25SknGegi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb5UUMepV1YS3US9FiMY1DskrPqIlR+IdJ6SS8v18IARkMrIP
	NChrORYs0URrQHFwfv8ADZhpknAYeGNtohDNy2TH9TmUIfL4JzVIpE3DiVU/uGxid6A=
X-Gm-Gg: AfdE7cl5PFaec5V2PuEiAlLQNfrGr8aRMRn2bVTJD60yTOKe2iHWghzlb9piXgboZis
	g+0zUSPrzaZd0WmQQYBLfJ4Z0+oNtjdhD/yOvRF4qUjtmSEoZ94qhzismeryKZOUXfXYVjm0aMq
	d/e+SM+2vKqKhOVXUmZffj2Gm4OKhWFEeLCmqdWZ/z3J05mNk4GpNubAaRLmgoX90/hMdQOY7Ez
	MwmeINvZonGK+miNn9Su1jx2YqllIhB0cUFB9tcYjJhCkgcbJhiEQkBaRZMO3gAB4HJQhZZmosG
	9G5gCoMyLqLd1wAtI0LMH0WaODd6oHOYuneh8AT3TexV0h9oOTdSCg9qYuodsIA8qZFmZYuw33F
	jWdYJeZM70Hkpsl/LSj5at1Ar63bC4J/O8XPKR6uFp9l7DLZWQMKEAtObSn8/C7wiZEgvxApGCq
	qpUnayCMHKYfUi9ErLdbsSo1yf8bbodac=
X-Received: by 2002:a05:6512:66c1:10b0:5aa:8822:b1ee with SMTP id 2adb3069b0e04-5aec68b7f97mr677361e87.48.1782949380696;
        Wed, 01 Jul 2026 16:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:42:58 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] fbdev: serialize mode sysfs access with lock_fb_info()
Date: Thu,  2 Jul 2026 01:42:48 +0200
Message-Id: <20260701234248.236023-4-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 46 ++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index af21dc5052..d3d60c555b 100644
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
 
-- 
2.39.5

