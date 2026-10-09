Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F238AC78
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516388; cv=none; b=Wzw011LffeystRlMZG0dpsMjH6neWn0qrUuh4GPpHhWRFdyITkCZIKH3609cxI74DaiUZ1e5oQ2zODF2rVFsoqRa7HGLTDx6jpGaL0oeuGxFDchkdi92fdBHAShqc0/sPrgza3B3XtQFruQl/3qIql3pNGu7BayHyFA/X4GS7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516388; c=relaxed/simple;
	bh=FC0tBf/Bbd0fFv+n0zfKmklZj2q8QedkLNsQoVQYUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=piYfj0+5OX4N8xekd/+lClsZ0KWWgfDZ+EXg9TXC9BvBJDav0OV5WaVleee2hGZzHvv9mYwvLaJtlq938H54Tf+Gm0wQl64bKjjQ0fZWhMEi/4Rf/YxVxtnMUDsWKOU6OUFM8cngMLzMwFtKMAC7Jo5KVq5m07gqrI2GVkFJl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx4x+YMr; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx4x+YMr"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98febe968deso994200241.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516375; x=1792121175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0oI5ab0SOpcU2oguj2Mvg/3amVLKLWqr9M0+kJZIag=;
        b=Zx4x+YMrxsZTRjx8vuVtP19LE8VSxgNi6ghVN7P2yxStBZtUJ1W8ZOUJ67kI6Qb0ZA
         /9eamYyyeVusn2BNXogqJZorrT6WkkENW7MR+HzfW+zi0PpYLcLxNixYzoZnGSqAV77Z
         fEaGXxLr+MfefLfyg3Ee3Zqj+qzQ249qe7ZvCB2Pal4hbB/pzin+kKrb3xRFiS0wzg4Y
         Ajp4JF7sXh7WxTfLry7Mgwwy05kQgbYV7eey+jgLmP4vczOBSW6gG8xVHTmwbt+5+swp
         iuKrjraINgRqYW8DConvFIEO3z95ufE0nMJXd+GWTXMek6mOJ/AqWmvFiU3sRxT93p5Z
         8Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516375; x=1792121175;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0oI5ab0SOpcU2oguj2Mvg/3amVLKLWqr9M0+kJZIag=;
        b=Y238qISs5VH2oQXN4tKaqwRCJiCzcVlCXkjxxkFe2ZVnOFeYVcDX//W3/rQO8EY+wj
         rX9AF2xEo3q0KlXYOM/ebKC5/6/chWeDm+HF6dPqIiLo/66lAuNEEN2cGg3SXnYc9IUm
         QccryKnHD0lha/Ge/mNb1HOa6VaQJdh9j7KvMcrnxbv7NLDTTH+OxhgTU5SWBEDMwWUF
         VGaxX4NZHcZZ0B+Jd9uALn1gbZCiYRTO4M2vEHMrsYx+NTzd/OqFi/Y5tjKjhSG35mUr
         nJsoiOxb1tC0UmgXPVdg0h/IUeivC/1r2JwuxvdZj9d7hwtmaDA43gtu+jO+T2HDB9rY
         Hxig==
X-Forwarded-Encrypted: i=1; AKwUvBz+vN5o39yQimy9Zctwrgafo+eINUnlbJmaQLHG0KIRigBA58v223PWODkGD8314nHckNxWr0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6kfts8qTB+0ZIXnkA3kpipYBcgcVCXN+JLKUqtGQKFg2TzHdx
	LWBVIct8a4jiakWC2jwYSkV6bYKg27PDa4molYtp75wGLGHFUcZlXSso
X-Gm-Gg: AYBFou0fFqLiSBTwSJSWehraiL/+eyxhee5X1MhdXgjFl7FOcz7ubn1UYPMHRs+K1gJ
	3inFCrUCpZU+pjGjaf9PnnyQ2GiBWtLx6dkpVchhLdbSJconTMmnim2I/d2//7xD9DmbEzqmR2z
	Jh/OmMepIYgT466VWkpf/aR/67yMREVIaP5U6mGVNENcYbw79haBBL9Cq1nJVe8ymEPBYHwxUuJ
	EOJBW0b66XFuVbJjRsLS1ZIjj+Gy7lqno0X720GdUJ9RjWg/81EMJRYhWYHnCfvt4WxzmChyZl7
	U9qo6LVgCvb/bF6xUdF2r9/kXiut8dgq/lTcsBhxeMTQG1fkGsXgO1UjZhjEhKuufm9Yn4L6RsM
	xWvRp1ncFKGePnvChzOBewODcTD7cefzDXqiv2ps2vvblerDkHGbm8tv7By1RKodSoFoKPe8Dy4
	wR7fawuxKKboEnYfriPvMfIY7GCZsByqiX23AVUiPZtriVJCiedIJU6IcbAdKTvOE=
X-Received: by 2002:a05:6102:b02:b0:7a5:2792:32d0 with SMTP id ada2fe7eead31-7cb3a067145mr220615137.15.1791516375576;
        Thu, 08 Oct 2026 20:26:15 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354681e4sm728780137.10.2026.10.08.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:26:15 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] HID: haptic: fix use-after-free of devm haptic data in hid_haptic_destroy()
Date: Fri,  9 Oct 2026 00:26:03 -0300
Message-ID: <20261009032607.3233482-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc(), tying its
lifetime to the HID device's driver unbind.  hid_haptic_init() then
installs hid_haptic_destroy() as the force-feedback destroy callback,
which dereferences haptic->hdev on its very first line.

When the HID device is removed while a process still holds an evdev
fd, devres frees td->haptic at unbind time, but hid_haptic_destroy()
runs later from input_dev_release() when the last fd closes.  The
callback operates on freed memory.

The existing get_device()/put_device() pair in init/destroy pins the
struct hid_device but does not keep its devres allocations alive,
since devres runs at driver unbind, not at the final device kref put.

Replace devm_kzalloc() with plain kzalloc() for the haptic struct so
it outlives the driver.  Free it at the end of hid_haptic_destroy(),
which already tears down every sub-allocation manually and holds a
device reference that keeps hdev alive until the kfree.  On the
non-haptic path and the pre-hid_hw_start error paths in mt_probe(),
use kfree() instead of devm_kfree().

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: do not free td->haptic on hid_hw_start() failure — if
    hid_haptic_init() ran inside hid_hw_start() and installed the
    FF destroy callback, the internal cleanup already frees the
    struct via hid_haptic_destroy().  Only free it on the error
    paths before hid_hw_start() (found by Sashiko AI review).

 drivers/hid/hid-haptic.c     |  2 ++
 drivers/hid/hid-multitouch.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08..6c365dbf0 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -406,6 +406,8 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	haptic->hid_usage_map = NULL;
 
 	module_put(THIS_MODULE);
+
+	kfree(haptic);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d..f4d8d640d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2132,7 +2132,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);
+	td->haptic = kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
 	if (!td->haptic)
 		return -ENOMEM;
 
@@ -2181,12 +2181,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto err_free_haptic;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto err_free_haptic;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2206,9 +2208,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
 	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+		kfree(td->haptic);
 
 	return 0;
+
+err_free_haptic:
+	kfree(td->haptic);
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)
-- 
2.43.0

