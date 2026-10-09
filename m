Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9949C4B2
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543931; cv=none; b=E6DlK2BFLLy3OkKR7WW1RmvC3Xh41NYoMDR03jJy4vH+JeVB0O7paNcdLnQA5cZ2hf5ityOAE3h1d+P+SkhfvHnNB3DUOOeaMjas2f7b1XlXfw8/+z+JCsULd19VmRgPFXZAzXo/RP/DP2d1nerZzHZAcaSGMX2iO8a8GfXdhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543931; c=relaxed/simple;
	bh=kQcLPkFSXk7wF/ecPlHEf46OGe2ulZn/aej9SI9xOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps9rhQeNMG0gRUoLuDNzXvv5pG5TALDg4zMiUzkbVQU0jHgthqSomtCMcUrbeRfp9VBM0VMPVLb3mK7CnNTj81Hu1JmYl9KZMVwIjtS1SVtf507Ao/zSQdFmQFn31HuuGQF7k/tLWE+xI40LOmVSkg8WYZw6r7lLuXHzA1fS+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9SguXuD; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9SguXuD"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5d4d307fab6so1780971e0c.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791543918; x=1792148718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L8Kzk9pmS1mnrb4ZOlblCrWGz9hRSAXGKg/NA0WqpoI=;
        b=L9SguXuDZ/8FJ15WxJx8c6XhFuQPonXo/TNkSAsTFgp2kehrznyW9eGte9FzBrYe5G
         JTo7SKKZVHbloDvKsIcRWEiKGTsDrDkbjNu9Dyfy44WqUQTYhR5lxOMIVNWVx4fqsWpz
         veigmNQbOUdazIlHWFTeOS5B6zOVUsK4XYfaFhAT2lGgRxNIW6jvlLzOgKk9AqcbVb4z
         V9XJHtdsxgAuA4DSSSIt0bIQwI16XNB1IEHlgV3azUaEPy93RPjpcCl5nyHdiSq9d+V2
         dbkd5YHdFWXxIxeEtynnlZm8BkzrlU7d+SnXlbIsjbeZdaJ+h5/MbPeef/p/g3VaazT2
         GNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791543918; x=1792148718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L8Kzk9pmS1mnrb4ZOlblCrWGz9hRSAXGKg/NA0WqpoI=;
        b=jQj1ljeSWPbSkPG+a4uQRtuegoxU+HXcw4kXPD1xp6+2aySLgoqkfnisXPn07GWmNB
         ptw+XRBiQ+X2HFl5Pwuf9uVaddc5vuitI18HRu2iHftsgEPS+bTc49HV6B3aEwhEh6Ax
         YxwicQE1e/YziYty0VWD3zgYYz2MY1/k8Ps225AvA/bl4X+lZGLzaXm+11Wbok6Ncjgm
         sMUu482wteLaYwckGZfftuZM7r2s/dpHrnRgFqmr86NCMFl4JR7tRCZl/IQ3DCrOh9g0
         mt3qo+gwrHgtWAu7mTOi79SG6MGNzr7jBzgvtE1Cmaq3MN+EkyaTfqUK5sRLm26vN01x
         Z8IQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhhPDeX3gOtZ86CVlGmOqlutRzYJguqWrsnEm/cSV9Y+89UBg1u5k/vEUo6dSPMZruH/1DHEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL2e7ikXjRaULuuk1c4M75JQ2FY3MYjG7DzqW6G4gMriiBZp8I
	KCGJtMjzDHQ6R5EhsceJVNw9gqzuk0p6r36KGh2XZq5oQLitJlhnyy/V
X-Gm-Gg: AYBFou2ywS3PFt+MyqHegOiAeUCE37yr6OjqgAJySTIP/WVJGQxGx/zaD+YHgvCt+P0
	5gzPR+AlOxiBVkxPs7Y9yJGM0FJKxOGaBbHkyGMhKlUhsm0IwvFdMnyu8CdgaHbMm1cbtsnHp10
	6R3MjHDpgLxhX8+baTEKVQcjPl5+DbyFwQiyPbkTxqe2/pfMzRbmpRtC5t0yrRSxb2ECF8EMdt9
	EyYApvlZ+pB5knUeDSeVLlgK21+ynSr2vNfHCqC6oKL0Za6fLE49QiVabzq6LUzWs4PJSgjsNxp
	HEjXjZBBBNQ8QdV3v6CmT/JKRhbAy7jEEVD8mzAuSOV1ImHhvImPZeEf+66mfOR5WFpss3Tv7sx
	yWDN3SNtLDcxbCfGaSwZCvy/htC0WM1YYRyc31Tpti8SU24QxE/y7rSdG/IPZZzwr9U1qqKcMBV
	7wbxNDJE4kszQPOpM/41ZDxyhkZaiE4PsMyHcpl/4nG2+0QJaBeJ1HQ/Idlio0qMc=
X-Received: by 2002:a05:6122:54f:b0:5c9:a60b:e5d8 with SMTP id 71dfb90a1353d-5e91f5057a2mr424306e0c.18.1791543918471;
        Fri, 09 Oct 2026 04:05:18 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cbf7fccsm1334965e0c.15.2026.10.09.04.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:05:18 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] HID: multitouch: use kzalloc for haptic data to fix use-after-free
Date: Fri,  9 Oct 2026 08:05:09 -0300
Message-ID: <20261009110509.2432308-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009032607.3233482-1-qwe.aldo@gmail.com>
References: <20261009032607.3233482-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc(), tying its
lifetime to the HID device's driver unbind.  hid_haptic_init() then
stores the pointer in ff->private and installs hid_haptic_destroy()
as the force-feedback destroy callback.

When the HID device is removed while a process still holds an evdev
fd, devres frees td->haptic at unbind time.  hid_haptic_destroy()
runs later from input_dev_release() and dereferences freed memory.
The input core then calls kfree(ff->private) on the same pointer,
double-freeing it.

The existing get_device()/put_device() pair in init/destroy pins the
struct hid_device but does not keep its devres allocations alive,
since devres runs at driver unbind, not at the final device kref put.

Replace devm_kzalloc() with plain kzalloc() so the haptic struct
survives driver unbind.  The input core's input_ff_destroy() already
calls kfree(ff->private) after the destroy callback, so
hid_haptic_destroy() must not free the struct itself -- it only needs
to tear down the sub-allocations it owns.

On the non-haptic path in mt_probe(), replace devm_kfree() with
kfree().  On the error paths before hid_hw_start(), free the struct
explicitly since ownership has not yet transferred to the input core.
On hid_hw_start() failure, only free the struct when the haptic
subsystem was not initialized (td->is_haptic_touchpad is false);
otherwise the input core's teardown already freed it.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v3: drop the kfree(haptic) added to hid_haptic_destroy() in v1/v2 --
    input_ff_destroy() already calls kfree(ff->private) after the
    destroy callback, so the explicit kfree was a guaranteed double
    free (found by Sashiko AI review).  Also handle the hid_hw_start()
    failure path: free td->haptic only when the haptic subsystem was
    not initialized (!td->is_haptic_touchpad), since otherwise the
    input core's teardown already freed it.
v2: do not free td->haptic on hid_hw_start() failure (found by
    Sashiko AI review).
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

 drivers/hid/hid-multitouch.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d..9cbe61832 100644
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
@@ -2195,8 +2197,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret)
+	if (ret) {
+		if (!td->is_haptic_touchpad)
+			kfree(td->haptic);
 		return ret;
+	}
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2206,9 +2211,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

