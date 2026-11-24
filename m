Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528726;
	b=EKnaTVuRapBtd/jC7jrPOV28jeqZVJu6dVQzg4jDB9iReNRUODuQb/x5G3/k4YyLF/Mp
	 9Qa1QHM621y/wcyx9opM2IG81xtOxxwNZszrFESwyto8kP+7U5qMrQmGHG2nbYVjtEetz
	 88qvHhs68PNrz02upM1D2KywSlKsdDJW0QMF9QlozXAnT/kR/bNqgxjUIZvTFq66Q68Vt
	 AjGvyBx42wdSDqP8H+jFbLdyYZiGBG1+7ABC6/YMQA14M3r9KhEx1W7PmE/MNS/kXcR4q
	 re9HDjuiFl5arFoSL/aLc1loPhgufqFOJC9oc6wKKLd3wxfhp+OuGT4sWc//6jOH7FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528726;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=+HySKkOVbW474osHQ9Y0YmzT/kE7CKLfCjwENY+Iv3I=;
	b=zSo94itHHGOFBgUcoLk1gi48seGU9nkPLAs0ZezICFS45FJc4e035MvYYAmrrARz6zlF
	 mbyN7i02fYIMe1Hkyhno5zfTPyoX4uhyCQFoldG7Z30oKGoXeORf6uFN5/+Hzn4ili2Bp
	 EmJgAbVseX7EfaPqREIWm/0SIswYSsIEdGvSt4MYCEYWwxdKF9RB+xxsi84hFXNNfa9R1
	 CN3jNZ98Mk8/80XOK8JCNZ8FNDD9+645vGdg7V6bDVMUdOJzsBYzXi68Bfnhx+ZYEGCT8
	 UFLuXo0Z2naZx1vfQ8awMK9klkjkwtb3gsmAJZoCckxLVXBHm43c7rfbT26fMjso18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=LWPg5PLb;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF2606A326;
	Tue, 24 Nov 2026 13:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88FF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=LWPg5PLb
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb9f;
	Tue, 24 Nov 2026 21:58:42 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: s3c-fb: Fix potential registration corruption on probe failure
Date: Tue, 24 Nov 2026 21:58:40 +0800
Message-ID: <20261124135840.2276343-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa20dda064003a1kunma2178d373424ae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTExLVk1NT0sdHkgYHUJIHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=LWPg5PLb9d6gzJORAqlgK8DHlzCNVSaYpI4KfipNPdYA+XydQSYkdramj35/25nIPUmVuwHaqa5nL+7ui10BOaIg3lQZS+mT6oPuGvB/+i5QykrN5JbjRW9hA4xSrGmAPGu74EQLjZtQU60V1R4yM5eky1pMAjwzOGKLb47IlR0=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=+HySKkOVbW474osHQ9Y0YmzT/kE7CKLfCjwENY+Iv3I=;
	h=date:mime-version:subject:message-id:from;

s3c_fb_probe_win() publishes its window before registration succeeds.
On failure, the caller unregisters that unregistered framebuffer, whose
zero-initialized node can remove another framebuffer from registered_fb[0].
Colour-map allocation failure is also ignored.

Unwind failed windows inside s3c_fb_probe_win() and publish them only
after successful registration. Stop the window before freeing its display
memory if registration fails, and skip empty slots in the caller's cleanup.

This issue was found by our static analysis tool under development.

Fixes: ec549a0fdc32 ("fb: add s3c-fb driver for newer Samsung SoC framebuffer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Unwind failed windows in s3c_fb_probe_win() and publish the window
    only after registration succeeds, without a registration flag.
  - Stop on colour-map allocation failure and skip empty cleanup slots.
  - Blank the enabled window before freeing memory if registration fails.

 drivers/video/fbdev/s3c-fb.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index fde78707d313..8fae4d909bb7 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1197,7 +1197,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	WARN_ON(windata->yres == 0);
 
 	win = fbinfo->par;
-	*res = win;
 	win->variant = *variant;
 	win->fbinfo = fbinfo;
 	win->parent = sfb;
@@ -1208,7 +1207,7 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_alloc_memory(sfb, win);
 	if (ret) {
 		dev_err(sfb->dev, "failed to allocate display memory\n");
-		return ret;
+		goto err_release_fb;
 	}
 
 	/* setup the r/b/g positions for the window's palette */
@@ -1249,16 +1248,17 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_check_var(&fbinfo->var, fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "check_var failed on initial video params\n");
-		return ret;
+		goto err_free_memory;
 	}
 
 	/* create initial colour map */
 
 	ret = fb_alloc_cmap(&fbinfo->cmap, win->variant.palette_sz, 1);
-	if (ret == 0)
-		fb_set_cmap(&fbinfo->cmap, fbinfo);
-	else
+	if (ret) {
 		dev_err(sfb->dev, "failed to allocate fb cmap\n");
+		goto err_free_memory;
+	}
+	fb_set_cmap(&fbinfo->cmap, fbinfo);
 
 	s3c_fb_set_par(fbinfo);
 
@@ -1269,12 +1269,22 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "failed to register framebuffer\n");
-		return ret;
+		goto err_blank;
 	}
 
+	*res = win;
 	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
 
 	return 0;
+
+err_blank:
+	s3c_fb_blank(FB_BLANK_POWERDOWN, fbinfo);
+	fb_dealloc_cmap(&fbinfo->cmap);
+err_free_memory:
+	s3c_fb_free_memory(sfb, win);
+err_release_fb:
+	framebuffer_release(fbinfo);
+	return ret;
 }
 
 /**
@@ -1470,7 +1480,8 @@ static int s3c_fb_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(dev, "failed to create window %d\n", win);
 			for (; win >= 0; win--)
-				s3c_fb_release_win(sfb, sfb->windows[win]);
+				if (sfb->windows[win])
+					s3c_fb_release_win(sfb, sfb->windows[win]);
 			goto err_pm_runtime;
 		}
 	}

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

