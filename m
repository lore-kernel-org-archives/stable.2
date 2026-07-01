Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE3409102
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947837; cv=none; b=E22GlOOXOT0L92wIA1LX916mRTJOQ59IY3tApomTkvffo7hFEQnbfpMu3uaGBIpZwIlv01oG5TiLatYfXfsmrDkh8fkIRGAINSxL6pdku/NHgERWg//uT2RLZ2kf+btlZxmCpzBz1xeny9E0RMJ3lcyH0GDCdiXYGHG264jvhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947837; c=relaxed/simple;
	bh=NwvngB55nrQuY2zsw+u/UlQ+ziOq9i4AgvNGIC5B8qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+IJCmBSEvhKZifULDHrE7btBxkMnvLVmk6LGziPXtNPlTP70XS+76Z2pfmEAY5GZ6oFxpnil5Rn/Fx8bI7AQa7y4aw4iGxTV7T45yzCly6zYbFNfAnTrDNankwdhrx/E9x8qPBbeagNEqnv3n+0l6keMaSY+JfBGj0/+hKkLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSIpZY85; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSIpZY85"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb78090edso1030561e87.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947832; x=1783552632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=CSIpZY85TZwwhMrmUWTKmXQvvXKXXOigC5Y+Y1i+1fTGxltzauMeK4jdgB6AK7ULox
         bB2EnJSIU0+H88MQ2m3GgqimnNrTBiQUolZKiYTuQUJLUvhsGEG4WMWVKFanimUfpDC1
         X1wuGCSE4N/ffZJhWwn0roSjXEJ+Yb8GMlsmZMKCvjUolGEY3/UzFa9WetnEdt47Bt08
         ZeJietjzyb/MH9auiw5RHlZ/7hV1vd/4Q8AqevCiJpmGjf71JccOpivyhu6cq0xDpcc1
         qjV5D/lyvVQ232y+qXcVRatyslA1FXz/UDTHUJ5fR5IUNeDdA+3FPxaHqAw97oHKM9ez
         XJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947832; x=1783552632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=C95pZVrWOlQnYBPpO74cHRpy8m/961rZLGJxyqEkBqrrT2kQ/gSVVh4gkoVA/9zUjV
         IzW+rETsUu3vHpRF84EAwKJzBxGX4dSIRmlotWjNqpWbni0ikkhJ//7U12tjHkgGNvRU
         nAMyzHvBCj6lkNGfyG/G9VdLI3JLFAYjG3gY8Sgf/WOzxbTUR6XZy509xRf4hAjo6fSI
         XvCBa0T0h8DoPuwzANmHAOJ2kS1Kb9LbQYjvLbO/FzoE+8wM+EwGsZTYrrstdrAJqYzj
         baXUowqb7JXWl02kBPfCn7W9ccBy0B000Q2X9WyPSYc1RA7rZfLgB7ypvF+5ZKM7an9u
         gsDg==
X-Forwarded-Encrypted: i=1; AHgh+RpKYJgxrCkFpG39ZBU2WV8KBP45BCaceNcmXBvjmcpkigvRSjyae6vFd+V3bo8WXfMdJXFK0K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlqEweddypjV5wgJvMU0y7lbQOku8ffP/lfXV8fGwSHZxkIBl
	AxdD0SFuclPW735sVLXR5TaGN571nnas7Dudj4vLn3tTjM8wcu9hgalM
X-Gm-Gg: AfdE7clMK+Mp2p3BJJE8Zmo2feSjyzz/g+vJehFoAciADjmPqz2ue80SjGuP20wm5rr
	y8MUvk6dNC6sMncrpCXEHoW0LoCvpkfBUBrDh7EnkNv/jnI90GLD33K8qIt3UNUHv6errJKXUZ7
	yO6Pz7zX9SCwmyLt8dtQl+AjVS8mtG4uhpTK3qUNS7HC8A8hbBNILdjdYRY55u9bS9sQ44ee/Ny
	9+o7cPjg65KnLGP58Ttmid82a6vpsTD1M8/emLJShwAzndSrlc4ZGeKEVOBbpeXKjbcZEERA+Ce
	y8z+irJVXlfSNWloQyJoLr23UR7H+VcRwWa5zj+txV9aIKPFwyr49FveZk1TeT1y8NmAPScpY/d
	3kEadYphbvketQrSJ7J9TpPCKIWAjb067PVdibwSZxaLUVoycisZY1Pj7x1Sp2UVCLJV+QAGGnV
	wiPynVh/sar3oEi8tdXaaVr+mmWe6wIdpFZfVbkyHe8g==
X-Received: by 2002:a05:6512:8387:b0:5ae:9c19:165c with SMTP id 2adb3069b0e04-5aec7fe9d35mr502903e87.7.1782947832122;
        Wed, 01 Jul 2026 16:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:17:10 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fbdev: bound mode sysfs output to the sysfs buffer
Date: Thu,  2 Jul 2026 01:17:05 +0200
Message-Id: <20260701231706.234715-2-mlbnkm1@gmail.com>
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

mode_string() uses snprintf() which can return a value larger than the
remaining buffer space. show_modes() accumulates the return value into i
without checking whether i has reached PAGE_SIZE, causing the offset to
advance past the sysfs buffer if the modelist is long enough.

Add a size parameter to mode_string() and use scnprintf() to return
only the bytes actually written. Add an early return when offset
already exceeds the buffer. In show_modes(), stop accumulating once
the buffer is full.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..af21dc5052 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -27,12 +27,15 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	return 0;
 }
 
-static int mode_string(char *buf, unsigned int offset,
+static int mode_string(char *buf, size_t size, unsigned int offset,
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
 	char v = 'p';
 
+	if (offset >= size)
+		return 0;
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
@@ -45,7 +48,7 @@ static int mode_string(char *buf, unsigned int offset,
 	if (mode->vmode & FB_VMODE_DOUBLE)
 		v = 'd';
 
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	return scnprintf(&buf[offset], size - offset, "%c:%dx%d%c-%d\n",
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
@@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i = mode_string(mstr, 0, mode);
+		i = mode_string(mstr, sizeof(mstr), 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
 
 			var = fb_info->var;
@@ -86,7 +89,7 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 	if (!fb_info->mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -136,7 +139,9 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	i = 0;
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i += mode_string(buf, i, mode);
+		i += mode_string(buf, PAGE_SIZE, i, mode);
+		if (i >= PAGE_SIZE - 1)
+			break;
 	}
 	return i;
 }
-- 
2.39.5

