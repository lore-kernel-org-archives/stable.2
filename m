Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779F4908D5
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069957; cv=none; b=Q3nC2IDSR+PxpxF65B2ZEHU+tPKzJf35IkF0znTzkVomRQ9GtcroXnfwdBeexrpXthED21TFlAARBcpYm7w5nqOLZEa9TLcw2PX19dMtO9qUiDHVO1XWju9zh27OicS3Ijilbl2P5+v8Wj79PNTAR3p0p0gcGwA0SLHzpD4F7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069957; c=relaxed/simple;
	bh=+DicZqvoxzRMbNNpDHwbco6MjGZW1B7WV/xUthTtgOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gzj+kBV5OBjovu7/RzV/QepNT11jraOmZmvL1T6uNGGcPkPSlDxe/IppjKX1Ck3yRIuDgV3ZHC4gJkkvQKzyAEC0zmHHlriYEV8Zxr5fIIvczWkmX0vEo5cvTWWJWCTBX0bGiU7R1XXh4ucAjZ5lYqT6ybFipSUTOutpebRsgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=yXPfpjfq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="yXPfpjfq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1577088f8f.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785069954; x=1785674754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDZR69zxyQUnmAa+1SVSCo3XwuE2Lf+IdHyjHOEBtFQ=;
        b=yXPfpjfqABX+Uj2KL0kzjUfSGYTv3cWwA4iYRZeNJ14A8EIOjYYVbITjhwTAU6m3do
         Cbr9hZ+5TzJsV0TyE5SvOVt3qHI4ITiQQ7h41plsJVm+a/N40fA1f/zDGEJ+UJCN59oA
         v2NGQYptNBJgT01wMb1N8hU8Fj/egApKxZr61peTFv65x7D/Fz8YE4FflRafbyBm93NI
         Pu//f/Z5sMZ+0prPxHzJxxSk92Q/aUzwurDn3cpwAzOgXmocNAHOSxYCqFdUt2Ddz1EG
         YCRWIx1Rb8SafzKFpjQSg3Yc/Er+9HdM2LpiJfBr0i0BaP4LHuetAGdCEh47huUfgPlg
         FwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785069954; x=1785674754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDZR69zxyQUnmAa+1SVSCo3XwuE2Lf+IdHyjHOEBtFQ=;
        b=gSy5k6MLxfkZ070P05I4DaS5toT92lAnwWfWF5+MguxsjZ8KhMToPNQJaPSCaaqYad
         CCWmnj9rbFXv279StLz4R+1Q+q3DeQEiuxXuHbzWb/kcHypjY9SInZiXL1wjDdAJ7ou9
         6l4b5nAOZlCnon3iRRQNjHTJHJHvGPPiDtgLYT7wmSGTKUDzxP7AiukP+u5o1E2NocnN
         Vz/lwBDB7k0yKW/YJ2mmxYRApUffKzO5FZq+URoR+963ycdFrCXBA/kiv9O99r4EZ7n/
         PATSZlyfyI9qDW8BT1hc/XnYLipRJHQ3kHJ3q5aINRYk1GZdt02y8XWaEqaBV9jtgIvw
         WkRg==
X-Forwarded-Encrypted: i=1; AHgh+RqSURH9jiuNGr6/x16i6cjqFkj1Vp/TEfc0+nCpS9O3q09eEisBlH8O6V9D67SvrOy1afkNTBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhictqfbioGaXDpxAMYQ5fWkKUJhD23cz7ezX1Eg0TAZSU70HN
	znXtKVeyPviOVnnhAvErrLXD8Tzulzt6p+IfIQH6QyuInVrrPAlrBEipMxZPi1Bf3Mlj
X-Gm-Gg: AR+sD12T9P5e+JeJPV8/A3mf28QeSWhpW7yG5crGaGnDWMHZVm2LL4uA/tDZ1sn/z7x
	BgYUD6lBJr+q9Gy876Yip6dhRWIx07YcuAboAJa2fHFSK3VnzkuTvR2ZFIZuwtDRLB5WGU6MTp8
	vGL8abtd9eTEd2AcWfklyvm8NbS5RYVzTrzdHMz8RJmjOYtGLS8qmY2j1wv8ZahqkDrKk/XThIt
	TB543eQlsGuN54+Pm0+V6j5yLbDADbw2Z1OIWv3XKud77CkoEqGBN47djbiYE3LUekB5RDJTKX1
	Qb2RkXbgEz1hiVO6qsALQiOBNrP3OjmEsg9Pm2IDXX4bMCdm7qhNJXXLed40ATnpU2P/hMiNgmF
	NHGIQdTruW2tlWRjQHUqv1kX5u1faxIYeBkAr6O0qaPKuNs0+GdI52qDN87jMm5jhdUhy0odIWh
	++nVH12L4xQJePz0u4sROtD2olXIyzm36/2MMF6mUUO3g3pSOn4c8iMWyk8L+W3bnk43rCanWNm
	j8zsA0ApqXYSrSBEUICa3yN
X-Received: by 2002:a5d:5f04:0:b0:47f:7005:285e with SMTP id ffacd0b85a97d-47f9feb6806mr6227705f8f.53.1785069953284;
        Sun, 26 Jul 2026 05:45:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm40939225f8f.6.2026.07.26.05.45.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 05:45:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: sony: clean up device list on probe failure
Date: Sun, 26 Jul 2026 14:45:51 +0200
Message-ID: <20260726124551.15323-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sony_input_configured() adds some controllers to sony_device_list before
HID core registers their input devices. input_register_device() can fail
after the callback returns successfully. sony_probe() then observes that
HID_CLAIMED_INPUT is clear and unwinds, but only stops the HID hardware.
The devres-managed sony_sc is freed while its list node remains linked, so
the next matching controller traverses freed memory.

Initialize the list node and device ID to inactive states. Make list
removal idempotent and run the driver-private cleanup on every probe
failure path. This also makes a second cleanup safe when
sony_input_configured() already unwound a partial initialization before
sony_probe() handles the missing input claim.

Found by 0sec (https://0sec.ai) using automated source analysis;
verified against the HID input registration and probe unwind paths.

Fixes: 4f967f6d7374 ("HID: sony: Fix memory issue when connecting device using both Bluetooth and USB")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Link: https://lore.kernel.org/linux-input/20260724143925.007D61F00A3A@smtp.kernel.org/
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-sony.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066ebd..56471b7b052d1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1982,11 +1982,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
 static void sony_remove_dev_list(struct sony_sc *sc)
 {
-	if (sc->list_node.next) {
-		scoped_guard(spinlock_irqsave, &sony_dev_list_lock) {
-			list_del(&(sc->list_node));
-		}
-	}
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
+
+	if (!list_empty(&sc->list_node))
+		list_del_init(&sc->list_node);
 }
 
 static int sony_get_bt_devaddr(struct sony_sc *sc)
@@ -2127,6 +2126,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 	}
 }
 
+static void sony_cleanup(struct sony_sc *sc)
+{
+	sony_cancel_work_sync(sc);
+	sony_remove_dev_list(sc);
+	sony_release_device_id(sc);
+}
+
 static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
@@ -2313,9 +2319,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -2339,6 +2343,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2367,6 +2373,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2421,7 +2428,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2436,13 +2443,7 @@ static void sony_remove(struct hid_device *hdev)
 	}
 
 	hid_hw_close(hdev);
-
-	sony_cancel_work_sync(sc);
-
-	sony_remove_dev_list(sc);
-
-	sony_release_device_id(sc);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

