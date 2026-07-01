Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892E35E1CB
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947840; cv=none; b=ak9Xgq146NLrE5LB66vYI6CZN5yBsKcZs+LLWWKNJm1QiFUtFAUYUElnqOvaRYjIRF138Askv5oNBVK4hZZiaTuFMNwP5Z3jBFvg99QteF2exX9KKnE3dzOTXZbJnK71+7hcFlriFJNSQ73ztBFweqlns26/Avfs7gdOuES+xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947840; c=relaxed/simple;
	bh=LCQ5ybY2W5wSNed4JctAr7mTZXfrxHe+bWEoILZJZwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLdZ34/PwGlKXubZ6nZM11wT223Kye5+DviwOJr7KJQCEY7pW1ACNgg1mYHAdpHKjE/sW3Q/RTHLDD9gAc75XrJsj8JeRXZ9Vlm9lJvmQTwVKuDgi9aHA7W49uOR7BoNm+NNv1DPLHNILP9nA3+vA3lKxM0NQfsPOYrNA/dq2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2pzTGoc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2pzTGoc"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec139da7eso3161e87.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947835; x=1783552635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
        b=i2pzTGoc24M3TKFJSyDd0xoXefIASVx8VfXmwbiB+BCkKe8tM27GuI7GgyYUyUZYLq
         avC0ep8LShlxz+D2G5P6x568Q8hbgTGet72ZYcvzl7lZcz6WlUMyXCyvrm/HHCq/pQjW
         QQepDqK3JpOerTBtbZdJcQraM+7evn8z9FyGXuIFuZ2x5ympf4Avi9/PF/7gKoNZRqrr
         QQKHqPqHKaZIc5nU8Bkc4q1AT8qYwOxK2m4XpTjAB4chHeq/tMw93EmCZZuHOaKvX6dn
         qjagh4UONdhjRKKyHhP4bLmDwA8Ug9REARDzvvEryWzpNuox2HZ69igxyVVwrQxwqkUb
         cinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947835; x=1783552635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
        b=PrNXlNpD+oOlmr8sYwyzw9l9EViGUuBqV6IzFRo3RCtx9ltLIEpAv01RZZ8JG5jr5L
         4AdvWBjajqoMchqdjJ6JvbjBDea8x2ZNuiis9nuZ4cYmVK3HYhNQkUpGgLpLnlxhAsaY
         69beppEnYIuMS+WXKGdOUuSjziN71/US438c4EANx+jMOd2UwjzXycnuGrw+S/JlFeXa
         pWjq1Js0Eo9mWUvCum9jUp+DmyqurpsBkY0XoDOGUkgWhyaRkcMVSz2rIe0ygM9DwSMz
         dLrX1mX7thGARNhjm76yRqgqVTP6/a2Mp9Bo6yjeGt8FxPNN0P+9loVImLXr94sw/jeh
         5Lmw==
X-Forwarded-Encrypted: i=1; AHgh+Rrw0mABnEVyqQdddRxdrOYo1XKa5NpYvDJAwHekVLfF7x7N28q6AWqCwTTlnzujjjqAFMyoPMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzul4iv+LB8B0yc2ZshcRk+b4eVAZchYOozlz0Jf2e9gNfq9Ybe
	984aJ3VzWYHtVvzjaaExjr8FsKBrorQg4WyGzOoYWqbPDhVZEa85PBV3
X-Gm-Gg: AfdE7cnC36Le/k3ZdnDcaB284oyloB3JmwjD8c6nR94p9XZgIP+O2aRswGYz+bqfpeq
	R2RwwZbZPXVUmwd+sbfx8KqIfLIwOLpZSbaeJ140Oa0SfrZ1pV3o+/Mk1UafmOnpAPiX36C9eDO
	EHxWu8qLa/hgmiZXX8Swp51jHPZRp9/oRGA0UbgAwrcq8UyCL14uTnyIpBmwuFIAsqHeFGXPm5Z
	FRILa1WkpB44tubg5pZK0dY3V6mGLppipmryse6zEZhEzF7qlRqpmJ10AQ73RGSEGl93xVIMIC4
	4MrpLMtqQstAa7YmETwdOJZD2QmUlWirkEnhBIqSbn16g/hMshzAPV8GQy5UZgM89cevGxTblGl
	ahpiq2kZoIkbSrPDB3mKiNiuB3biqYfjVENCh3k2oryAs54v95Dw6vv2qIWUoMrncDvExHFj0w9
	ZMFV/T/6u4aAD28QXlHO1VZE1A5w/XcMQ=
X-Received: by 2002:a05:6512:2286:b0:5ae:b6cf:c745 with SMTP id 2adb3069b0e04-5aec630a373mr908377e87.17.1782947835394;
        Wed, 01 Jul 2026 16:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:17:13 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] fbdev: serialize mode sysfs access with lock_fb_info()
Date: Thu,  2 Jul 2026 01:17:06 +0200
Message-Id: <20260701231706.234715-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
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

