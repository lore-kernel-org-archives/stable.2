Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713F126BE1
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386857; cv=none; b=Na01vEtBNfiVcqQmLQH/3UfoHRIW4MsKnxjvPCJGPZMQyXByteJhrZfZfBC/3d2UJqwSNnJOhgsAzg1046xVf5TtOdmdjqatRCqgX08zGnyp1kgjz6LXdtIuRaW4E3vI8vQ+lZX11Q+caGrCiUpiSOfJ1+T9/Y49Q1dl7t7DuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386857; c=relaxed/simple;
	bh=HHcwdsUXEm2ayaVu7SSBBQ8NDirWwcRsDg4gbWZ/4ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ii4qJZZuRnJWKQXBdOgJ22fQjpoqi3HsSvM2HQXy4XyhlRYFH5J23AcPcuc6tBKz9if4xI8T4wo6cH8CSBIaTcpz2/xZ/UJUM1lM+WulY5pmpgOk29G+NsjOJKuj/xdqJ5uZV1CEEXXrlXL3yVWw5Rcl5d7lTTN5r5tG3TVEs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPg28wpb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPg28wpb"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-86d43cdee51so26974867b3.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386855; x=1789991655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvOpnlEvc0lDTY/fJ/50aU18KEAzaXSSdE1MwD9cp2Y=;
        b=KPg28wpbhqcywZNrpCMyZUph12lU+ataZdQcM+1ZZZvqPcmAXy3DW89af7FGZ1ySBY
         7jPQjBkEAW6AZqJQmAXT+veQrH9sgj/Crs8qyna0R0fS9KFEfjdmV8F6yratCHUFjWZv
         gCAuUAhkSnsX/iIOmKF7WF8Y5WBbB/HSq5HrYQTHyn7mYhcqfD9258OBsEgA0h4oRb6D
         gpowLoZnyz83JYjcabD4UOoQSzE1Tt+Ka88RSaM5NhTzs+Vj5HCHj4R3JL0WQPePm1Pk
         i0LkaN/lPUXq327nql1CnCF4RqJNwEZjhCpDpIvTJlPRNp2IwgWkGpMkK+XN56FP7Ol/
         O0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386855; x=1789991655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvOpnlEvc0lDTY/fJ/50aU18KEAzaXSSdE1MwD9cp2Y=;
        b=ZUAeEmt0w2gFdRBGjFyOEUl0Z7LnOe1dq0sZfG/qh10sjsKife6sqD6wDDtXtNjabB
         lyhUSjiCgocx8loTLve1OUsxuqfcBMFR0SXwHITpsmg5Ii/sS5wPhHSqVYI3+njyHOT9
         prZRNoy4KZcMk6YDtPrgsssXec64b/+OjbXa4gtxKV3z7DtsKl0C0RPt7zRMAn/en1Xu
         n8LGg56jB4Hp9ihNEsa2bqYpyT/Xip3vjStQaf5YX1GK8gXDMDaz9M51omP8rTsjHBNe
         L7FfmNPVkSiZSHWHmcayuZPboeSlRjgQaTsT6Cb0Tx5ROTjTIze6Oconv1S2f9OO6Irj
         wEqA==
X-Gm-Message-State: AFuF++kyJgnzHzpJ5RFlG7jRH0X73XbpJcdYMV4CwKet1zuDYH7b8tVY
	+lsQcJ9GyErpKy2Eiv6XtkYypqz/8+oyvgT8kAELkzjIbK9CNiDduQxa
X-Gm-Gg: AYBFou2y3ibBlDTsd8GG7PVbCeeBuhwO8us59Tlg7+eNbsdzm0dSUwXYgN5iQHWL04K
	XOGKLTCeX252zuQ2ZrxHvcOmrg9+AaPKjebfswB/D+H/SZvN3B59J4oQtFNoCctWdEJGhnTqD9Y
	MZ+HCRYG43BSHa6xvUEoniOZKta6g862bgdUWxRbciPHaTKerQRh/EVrbbXB8s1d8SYW5b2lTHB
	4pUE9JxmzYBNqiaSUsD+3126OKdRjalbWCL4d0m5g0P7Ti8bAkwwaHIUHNFASNqJJi5obtKPChY
	hKP5eywFCLTZkLRpSP0xe4Yn0J0kEvt9+GN7ryMYIWVz3OSt6dO9iJ87lOz4pv8SWt9iQfXLNAp
	dnytHNlxaKGw6AaIacGLFaTo6MCCaxrwz6cpSbCn6/mOjfr6nqnpIMTVJ3Hd4ZNk2uQ40QJCeqy
	AytOErBV850wxZv7PLFTyJ1ZXkdKv3l9ANloRg4uQSL26cPTP4hH68Dg==
X-Received: by 2002:a05:690c:e15b:b0:873:5bb2:6c37 with SMTP id 00721157ae682-88d2426b390mr3468467b3.62.1789386855441;
        Mon, 14 Sep 2026 04:54:15 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea9478sm34802197b3.34.2026.09.14.04.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:54:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: dummy: free software device on configfs release
Date: Mon, 14 Sep 2026 19:54:04 +0800
Message-ID: <20260914115404.1691763-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_dummy_probe() allocates struct iio_sw_device with kzalloc_obj().
The error paths free it, but after successful registration the normal
removal path only frees the contained IIO device, leaving the software
device allocation behind.

The software device embeds a config_group. device_drop_group() calls
iio_sw_device_destroy() and then drops the config_item reference with
config_item_put(). Therefore, freeing the software device directly from
iio_dummy_remove() would free the embedded config_item before that
final put.

Configfs requires dynamically allocated config_items to provide a
release callback which frees the containing object when the reference
count reaches zero.

Add a release callback to iio_dummy_type and free the software device
there.

This issue was found by manual code inspection.

Fixes: 3d85fb6f8104 ("iio: dummy: Convert IIO dummy to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 19fcdbbc11c6..7d2ff1d4a06e 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -23,7 +23,19 @@
 #include <linux/iio/sw_device.h>
 #include "iio_simple_dummy.h"
 
+static void iio_dummy_release(struct config_item *item)
+{
+	struct iio_sw_device *swd = to_iio_sw_device(item);
+
+	kfree(swd);
+}
+
+static const struct configfs_item_operations iio_dummy_item_ops = {
+	.release = iio_dummy_release,
+};
+
 static const struct config_item_type iio_dummy_type = {
+	.ct_item_ops = &iio_dummy_item_ops,
 	.ct_owner = THIS_MODULE,
 };
 
-- 
2.43.0

