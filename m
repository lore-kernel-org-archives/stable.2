Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767354DD3B7
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168452; cv=none; b=MmysTja6W7WwYq7dm4Qia2mqqV5/3PH5VlKN9P42M0jXGEeycgBhihzcDC3bd+jyswZiX3ax6n/vTVpCg9RonxgnxbLIkQfEqZB/6cMtkQCYlIJjhzgzn1w9ay3tAe+Wg8Z0lAD/frua7GqZMy1dwa7lcWJ6lx0YE9rhKnroLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168452; c=relaxed/simple;
	bh=usDo/7XNU6nwa282LnLeCFXrrSZq4xQm0JTd4N6BgvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEqZlADLUYM3ffR98WOilgX1Lfxnqe/1fI+gWXdP6KZuGuWJtJqwlxlh7ZWNkuzPOXPBTzpnm2cJV53S2+nz6niWDuIzizhAtyyBtoOxwAmj48+PoP4e3HjKhwMsVjeJjdaWvBz2/zrF4m+MbZiAM/3ZxxiF/K7y64g2rTaC7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMShfoUW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMShfoUW"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9196d8543cbso1520226d6.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168449; x=1792773249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfpDl7tRd49YIT38CJTAU2+wIjC5qIySjGavAzs37iQ=;
        b=gMShfoUWUmJJS9xaQ0lQXRpiyC4AD+VdWYl8k7H6L8o7MWjkOkhjk1bK6yXiKa5Dyf
         vDckAMiNx1idXk9KezO/Eqho7+2igccbIoXSS0IArIVtKYD4nE0VXHEpbWyt7YZHUxTp
         ZLCLXIkCaRDTPEjhm1jHEWpg9XP9oeRAjfvOlpf3gqamWgW/XkXh2BSL6ukZdZSD9ffh
         fZm714EJTy+60BTT5rettwyjn0H3F/1UAzF7wlSLHXMToZ2ip3fYi/IV8Jgxn+hl4stv
         VEnUm1iiMhyuSaxkvIX1fYOdQZxdxFkutiKD5X3IAG73JvxM8vLLN2EwjN0ORJu4M4rE
         Gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168449; x=1792773249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfpDl7tRd49YIT38CJTAU2+wIjC5qIySjGavAzs37iQ=;
        b=FMHk3rXPdMAllZsPoKYFYoe55lnFYAqldFLrrBxStLQ2x6kl8sQkGIhlu4pyO5u03y
         aOYXVA3vPx1jV0f/COK+nHnk26kXqIcO+HTIDejvHT9qZw1V/LnMe5UfP8aoJWUSO/KM
         qPy2YvKeGQCSShae1Y9mDl6NfiC62u79xb+mPlIe11N8/V9CSlCjiwLs7A5bsC2xKHYY
         U1XfoephgE7uUHmgwF5rbWrcFDUjTtKMIfp61151Wd+s+WflDK46eF1bEMnFUi0s+7u2
         ZwgBwwb3eYLFYjq9tnNTRtKEdRUYh39vDfZB3CsE2DzhaE6OAkEH/q5wCeLWFpAz8NAe
         i9gA==
X-Forwarded-Encrypted: i=1; AKwUvBxRRGoCC84GBvtMhZvvxqy9vWDFdqPPpXENjT+zzqEBGBm9CrE7MXfwkeV9rRjKplLUx81YNC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ5TIjL2sPOvzCoCbT4p1IMzSn7XpZ289QI4tP3i8IdNg8jwe/
	4VYxm6IL79Fwqkq9efGFk+b1bLsAdtlXYq/60VSuIQF8in5tCtXmRmuP
X-Gm-Gg: AYBFou3K82SfxEiI6CyGvZRaxmP1P19mbTxAZmyNT5IxYg6Ap7DV9T0Y8xN3GefsFRl
	+QjLEYNyFRUlU1XQmghcOKnvHv7t9i4YYiAb0EXAWWIDKJNXbADQrz+VMiAUCJ6ZVTJ5qb1VLjI
	kgnZv52eKCLktHtyQwHy6KYmKgjTK/EK6t5xbEL6S6/5kp/AuiTLdNVBFES/YeXZK4jFeD71P9W
	hDTd6dQMrFxmeoL6iQEaohcubuRpH9C3iWs/1J3Jb4AMvkH/yC0r/oSJmQ9UTAIBNUi++fm5zIy
	FtHhD4IQYAvorR1jx+hHxZIFSl3av2MH9yJgaLXaTw7LLZzjiq7TbrHv86SVCNO2fe9pqgyCavN
	uLkH+luMypgFewiNKVNYNuDAmuW4y63m7DWxTjU1GeR+tgsNSeEl+sTB3YbsMWt3Tn4xee8kdqY
	Dgnk1PghcFDNJo7an0NbvaQiZ7juhkLrea/vQK8VyL1yglCebkfwbd70JwCyf2Pwo=
X-Received: by 2002:ad4:5fcd:0:b0:91b:9232:2bea with SMTP id 6a1803df08f44-91bdf14dac7mr9565136d6.33.1792168449159;
        Fri, 16 Oct 2026 09:34:09 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcc47bccasm25272806d6.20.2026.10.16.09.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:34:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v7 1/2] HID: haptic: reorder try_module_get/get_device before input_ff_create
Date: Fri, 16 Oct 2026 13:33:48 -0300
Message-ID: <20261016163349.3293666-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016163349.3293666-1-qwe.aldo@gmail.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move try_module_get() and get_device() before input_ff_create() in
hid_haptic_init().  The original order placed them after
input_ff_create(), and failures went to input_free which called
input_ff_destroy() without ever setting ret.  The caller saw ret == 0
on failure and kept a dangling pointer to the haptic struct.

With the references acquired first, all failure paths reach
stop_buffer_free directly.  The flush/event save/restore is no longer
needed.

Also move input_set_capability(dev, EV_FF, FF_HAPTIC) after
input_ff_create() so the capability is not advertised when FF setup
fails -- the caller masks the error and the input device may still
be registered, where EVIOCGEFFECTS would dereference a NULL dev->ff.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb..9753bbf 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -419,8 +419,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -499,39 +497,36 @@ int hid_haptic_init(struct hid_device *hdev,
 	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
 			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
 
-	input_set_capability(dev, EV_FF, FF_HAPTIC);
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(&hdev->dev, "Failed to increase module count.\n");
+		ret = -ENODEV;
+		goto stop_buffer_free;
+	}
+	if (!get_device(&hdev->dev)) {
+		dev_err(&hdev->dev, "Failed to get hdev device.\n");
+		ret = -ENODEV;
+		module_put(THIS_MODULE);
+		goto stop_buffer_free;
+	}
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
+		put_device(&hdev->dev);
+		module_put(THIS_MODULE);
 		goto stop_buffer_free;
 	}
 
+	input_set_capability(dev, EV_FF, FF_HAPTIC);
+
 	ff = dev->ff;
 	ff->private = haptic;
 	ff->upload = hid_haptic_upload_effect;
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
-- 
2.53.0

