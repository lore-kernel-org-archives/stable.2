Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B4339362
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435580; cv=none; b=VZyQGl3nu8l0d1cpvHwPW2x7akyLovqOrt2wZ30x7iJAt+nKlqafXFa3aaPLlQNyr2aakjo4Qq7Z+R6H59g22Oq8QiVKPMxbm/tOVijy0m5BhjqYRXPkmH9n8yFZIxwRUw23Sb9PuO5e4/xVfQCAS/fFnvtPM7iIKi7U4ecjMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435580; c=relaxed/simple;
	bh=edfnTtJHPWaCyOOTHhoRn8TruzUY/kOXrk0TmixhlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZL/usGV+NKigAH1Ge0AH3xRvTiGgo/qt5PyDwxBPAJCezWBZbK3KshUSZSOrOCGnV7FF399uJhSJI8trDZzOhOQgKXSofxOqEktrCvR8Udn9WxHCoaxuQ1OwWgrW3pjnRXJKPJHvfAwASWoWHLDJDSqD9YK+7rdNDtqlVjcyeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cckDWyJy; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cckDWyJy"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e28a62abso43051541cf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435578; x=1790040378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g87KMiRFdAPY30cDz1iKQzMln28+sYX6puXQlGcxBvE=;
        b=cckDWyJyR02knloIT0x3QsVEWaerOMYcDxRVxd1HwaGKfLaCoqHZYcuTsehMLEAl6w
         c0g1Rkcri9pGAw+/b/j0/J+QG5hWBRqPT5Exb4RvyhV8P5xwzzQfaNQA85+DzyvEZ1oe
         9MzN4gDNKISC5q1LlBdCjoCKPVEnZMr0xlm19Uv/iF+bZyl4L3sNzSzPpoDIKitJ1eot
         eDjv+CjNijsBcEs/tD74m3QTjyp4OVN4nDRxDsR1sWbaL9qD/GlMs6QKguzI717LLJC6
         h/z9Uip3WyoS0DZswq6dfm0LgjG/B+MqbUr6608r1lB0Kj6x1JhhN8bJBjlXTaRYrjol
         ReKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435578; x=1790040378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g87KMiRFdAPY30cDz1iKQzMln28+sYX6puXQlGcxBvE=;
        b=uFcHU46ZCb1ol+Z6YTppkx7FhEE5LezwgBby6kTpQN1r1RjLCP9D+H+JEHFUY1KVjH
         2zqORNLh7TDyy4JaN9SZyK162goEFdjBndnRuSWhMn3/tk8BHNd6wshZu4Q/HdC0J8op
         EHsan1iiT8mSGB0YEWdcd9kJFLO+Zf1xU5QRPov7RL4+H+sPBjuAiBAjHU4/jN1bpKnY
         PqXR7NQgth5ZHyyPi9mO84OjJcULw7CsoBnZrlQz3rrgftKBJ+TOuDC2QjGl8k1TW49n
         aaTUM62Fh1NxiYFVrD1vS1YeyDxTPWaH0B9jjiAjJ0vkPSilFUSZZcuAeHFeHxlAEF5p
         w/9g==
X-Forwarded-Encrypted: i=1; AKwUvBz1xlibGiPIBvknp928Tophwq9XCwNMVWQqmbFtrYcAww0PR16TJDA4oTqS8Z3EyIq5gS8CgzE=@vger.kernel.org
X-Gm-Message-State: AFuF++lYhqYiCojzRv2ftz25Cp/0vP4U/+En+05+YQc4WZvmXQzcTZmw
	vLUHQXHhzhfbvNwL23a+ogjLMQ8ZNhzPEa0VPneHIpjc8E22zkUQE0o=
X-Gm-Gg: AYBFou3ajwKktWnDwkqfR2dEuRNTakUJMEsSGaKt9Ccnd7DDX02zcXZ+UKFssfuC7dW
	VavUe6rz/wHRVnAXkenhM0bRneqPdn/GtKZEPL5rtJSiN3zaFiZVyZi2ajuZvDqUINhP7vXGotE
	4rPFK5ffU+fniG/L3ywVl5YzmPwQXnQTkVT9WT5mzEiHDcDb1twWSuL6r8hvj6rLY4fiUyBhGdw
	qNMnZcZUJymMVJfd7H6af9WwadDgBKGrtdFrfK7NIDk86zeFfAnMbIIt7UZGCbThtm5kKzcdDYs
	twrhv41IZ+SuYIaf+VGtpsvoOslfuNPwNjeTOPwvh5Ra9ZED13rLorHU0z4TeYG4svtYa6NeePK
	GeZENF4qF3SZ5sbGrG2pC/xnUYH78hhW+GhhNA8vdAdM45eFQB1K54mqEWcRVNf8KXwpwiOOM0J
	Ndw40pQt2VZSAwMqvjClREIJcQEfCdS5YD/tt6dLb2wP7q9PHVAzJETNOY9tNTxjwGyOT/K7/u4
	qgy9/Brc+WfaG/q1XKIruJeMjVdROKLMg6yHD50pVGRDERue6P0A747zf1yxiPO7nmLStHwQura
	f4MYYcUNTtjPSQ9Mokt8GHqKY7YcetQXQ1h92PWCt4t9iQn0vc7vGlTr8AXIxt6BIX3t2Q==
X-Received: by 2002:a05:622a:941:20b0:531:dca:2e91 with SMTP id d75a77b69052e-5310dca3544mr52831701cf.30.1789435577831;
        Mon, 14 Sep 2026 18:26:17 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5310cbf288dsm33662361cf.1.2026.09.14.18.26.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:26:16 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/gma500: unwind resources on backlight init failure
Date: Mon, 14 Sep 2026 21:26:08 -0400
Message-ID: <20260915012608.65663-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psb_driver_load() initializes KMS polling before it attempts to initialize
backlight support. If gma_backlight_init() fails, the function returns
directly and skips psb_driver_unload(), leaving the resources allocated
earlier in probe, including KMS polling, active.

Simply using out_err is not safe: a failed backlight_device_register()
leaves an error pointer in backlight_device, which gma_backlight_exit()
would pass to backlight_device_unregister().

Move backlight cleanup to psb_device_release(), which is registered only
after successful backlight initialization, and use out_err on backlight
initialization failure. This unwinds the earlier resources without trying
to unregister a failed backlight device. Normal device release and failure
to register the managed release action retain the existing cleanup order.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move backlight cleanup to the managed release callback so the probe
  error path cannot unregister an ERR_PTR, addressing Patrik's feedback.

 drivers/gpu/drm/gma500/psb_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f535..c4cc4bf5f4 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -170,7 +170,6 @@ static void psb_driver_unload(struct drm_device *dev)
 
 	/* TODO: Kill vblank etc here */
 
-	gma_backlight_exit(dev);
 	psb_modeset_cleanup(dev);
 
 	gma_irq_uninstall(dev);
@@ -227,6 +226,7 @@ static void psb_device_release(void *data)
 {
 	struct drm_device *dev = data;
 
+	gma_backlight_exit(dev);
 	psb_driver_unload(dev);
 }
 
@@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (ret)
-		return ret;
+		goto out_err;
 	psb_intel_opregion_enable_asle(dev);
 
 	return devm_add_action_or_reset(dev->dev, psb_device_release, dev);
-- 
2.47.1
