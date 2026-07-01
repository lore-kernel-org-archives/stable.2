Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC53909B9
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926031; cv=none; b=SVF6P5cC7RX5G6OlOxqqX8KTKrnO2crwgSCftVM+isoe4B988LMaBcAYs0THCj+pELbKiaaoCgnC1VA0dvXJQ37O+s/mLFNg1IEfxY33QNpOkR2GhROfPQSIOYbIaRG2YEeBvwk28II8f5yhEhB8x3f30mdrUC4o4lpzQDj1lJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926031; c=relaxed/simple;
	bh=kKTeujLS9a68lTaT3jxbumlF5HSR11tXhUWpjVgLfuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgWSjVJybNxISCr7tby8ntgpUwtLHPdWgl3yDhqebbcbw2a+eAUSnwTHm1VUpNTiFXrcWiArkUTej1Sc8ILUVmo3QGeJEhlXhasc0B1fzLx/DuDfCAszEx4lQ7tPPtNjDk5ibV2MynyGskL+ShdT7qoiaxhJXvaSGqXfu390yiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cystack.net; spf=pass smtp.mailfrom=cystack.net; dkim=pass (2048-bit key) header.d=cystack-net.20251104.gappssmtp.com header.i=@cystack-net.20251104.gappssmtp.com header.b=nwhAI+7M; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cystack.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cystack.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cystack-net.20251104.gappssmtp.com header.i=@cystack-net.20251104.gappssmtp.com header.b="nwhAI+7M"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2c80ff1bbb1so3325895ad.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cystack-net.20251104.gappssmtp.com; s=20251104; t=1782926029; x=1783530829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enoWlMtun1s/5aE0gWfbvE36ga7ngFUQHQ5/PNaJTIU=;
        b=nwhAI+7Mf99VMmVGnBWrX4WfCaL5oNxokFNlsu+pq9TaF0Mm2vMA1s4GXAQ+xgMjnC
         QjaxuvSQK52+u+jd7Bg0FIHsFg+2xPJv9CGNxbPmd+3OJ90uWvpXeiGbvlhlHlnqi1gV
         xYzhUwd1C6F/Q+jjGV4nKKwJq7nideAKF5jE4ALBItNUuVZ+k32aynyTAHiIhwRe55gP
         Ofh+Spn/QjwhYg4DO/hYfmGCzmuImmI8wywrBYigFg7SzRw+S/UaSNykc2XwHkqzDRjf
         qQeL1bUjGQSDDaL1/teGf2S4MovxPh8WYnjz436Kq2gUhD/HUtqqyVu7gn6tnpbjQBbg
         38Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926029; x=1783530829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=enoWlMtun1s/5aE0gWfbvE36ga7ngFUQHQ5/PNaJTIU=;
        b=amvTTDhKheN8G5F1WUho8b09WC5ZPF6lTM8eBdNjjAy1JFuSSt0YWhPD1ZDMuew/EY
         b/MzXR37fjlH6IiicyokQYvBWU2yaZVNHFQAwY93w9rKn1fGqksByZeE40sBKSatHANX
         pP76/Cb9To2d73+4OT/y+X7VHP8L+SNlEdvfZMFLUKuuLccN8qDxQ4nDJxYW/AkBxpdG
         ERYHlMHlFTscEAp9kuNHF8eOGH6de5rRdrCYMbOwJAnwzZlQP+BIrVt7+ecFCgbT/NMp
         IU0CxE+KaWrkHC2G0lS/DBIKyT4MRZyDAnop8cdqR6Tmk6zDvhiPLvCqe6cgWsxioH0h
         Mrqg==
X-Forwarded-Encrypted: i=1; AHgh+RqfaTIB1T7DmUoFuaVLxAV9bYh34dRi4GlaU81Rw1v3zN5FTfPuW+g6OM6HUA1WqzhYpvmAhOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+5l2x8VHCi68nIr02Z8VvHrwaslwsoXomApLHnBKlKMxZrwZ
	KRkcNm5ySxe8VWATMi0bcfSqMqRM6ciCI4ePAU5qeGvF+ywzVaCo5Op+gypywjmyInU=
X-Gm-Gg: AfdE7cmmgKG/dxjt5hlIulQw3sWHbYUMrTGpXE5QJE2A45mOQ76Ev3OXWcJmGz+rSxM
	gZ1fXBvZ67DkFX4mhqKjtM47X9cXNkJJmOIf32pf7jeehriQFHh5h/g87bI6URezm9L7ENaZZE7
	YeQfMQZu6EsB2wJutgFmFeBz9XaLidoKwtfLM41+o4BRmcmfEt92uWg9YnWJ6mhhljPJfBFUwdj
	HfJndZ6exNL/OhENAzBb1hVu4OinWoZHtdiMqhaANtKx7dxat5xttzIzlutoqj2TkWsnjnIgty7
	sIEsfHuHyIkNEPfRgq72IPtHLEU1UK4+mBIvXx09rAlcUPejX1y8ZRQALYpLKEgXSs/iasGIHkN
	oHhrUv9eJws2JTpKiiIJ6DrOzbFTuB8hOLA0QldueMjh/mf2R8phKznTbcOzwHsHOSzqzQZEL76
	88ipQWHp1GNwoUelbRWA62jDTJBiYEKGAnJTtKo0U=
X-Received: by 2002:a17:902:db12:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2ca7e67eda5mr27897885ad.2.1782926029330;
        Wed, 01 Jul 2026 10:13:49 -0700 (PDT)
Received: from localhost.localdomain ([171.225.202.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8de800sm1329215ad.12.2026.07.01.10.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:13:48 -0700 (PDT)
From: Trung Nguyen <trungnh@cystack.net>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trung Nguyen <trungnh@cystack.net>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: multitouch: fix out-of-bounds bit access on mt_io_flags
Date: Thu,  2 Jul 2026 00:13:19 +0700
Message-ID: <20260701171320.16367-1-trungnh@cystack.net>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <CAO-hwJLS6uAX__aGkmpcDQ8v6GJaHGrL+TOYXVRX6jvjzNW+wg@mail.gmail.com>
References: <CAO-hwJLS6uAX__aGkmpcDQ8v6GJaHGrL+TOYXVRX6jvjzNW+wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_io_flags is a single unsigned long, but mt_process_slot(),
mt_release_pending_palms() and mt_release_contacts() use it as a
per-slot bitmap indexed by the slot number. That slot number is only
bounded by td->maxcontacts, which is taken from the device's
ContactCountMaximum feature report and can be up to 255, not by
BITS_PER_LONG.

As a result, a multitouch device that advertises a large contact count
makes set_bit()/clear_bit() operate past the mt_io_flags word and
corrupt the adjacent members of struct mt_device. The sticky-fingers
release timer is the easiest way to reach this. mt_release_contacts()
runs

	for (i = 0; i < mt->num_slots; i++)
		clear_bit(i, &td->mt_io_flags);

with num_slots == maxcontacts. For maxcontacts around 250 the loop
clears the bits that overlap td->applications.next, zeroing that list
head, and the list_for_each_entry() that immediately follows then
dereferences NULL. The kernel panics from timer (softirq) context. On a
KASAN build this shows up as a general protection fault in
mt_release_contacts() with a null-ptr-deref at offset 0x58, which is
offsetof(struct mt_application, num_received).

The state is reachable from an untrusted USB or Bluetooth HID
multitouch device; no local privileges are required.

Store the per-slot active state in a separately allocated bitmap sized
for maxcontacts, the same pattern already used for pending_palm_slots,
and keep only MT_IO_FLAGS_RUNNING in mt_io_flags. The two
"mt_io_flags & MT_IO_SLOTS_MASK" arming checks become
bitmap_empty(td->active_slots, td->maxcontacts).

Move MT_IO_FLAGS_RUNNING back to bit 0. It was bumped to bit 32 by the
same commit to leave the low byte for the slot bits; with the slot bits
gone it fits in bit 0 again, which also keeps it within the unsigned
long on 32-bit.

Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
Cc: stable@vger.kernel.org
Signed-off-by: Trung Nguyen <trungnh@cystack.net>
---
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0495152091e3..edb37b4c867e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -31,6 +31,7 @@
  * [1] https://gitlab.freedesktop.org/libevdev/hid-tools
  */
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/hid.h>
@@ -97,8 +98,7 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
-#define MT_IO_FLAGS_RUNNING		32
+#define MT_IO_FLAGS_RUNNING		0
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -174,10 +174,9 @@ struct mt_device {
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
-					 * first 8 bits are reserved for keeping the slot
-					 * states, this is fine because we only support up
-					 * to 250 slots (MT_MAX_MAXCONTACT)
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING) */
+	unsigned long *active_slots;	/* bitmap of slots with an active
+					 * contact, sized for maxcontacts
 					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
@@ -1036,7 +1035,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1247,9 +1246,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(slotnum, &td->mt_io_flags);
+		set_bit(slotnum, td->active_slots);
 	} else {
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 	}
 
 	return 0;
@@ -1384,7 +1383,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+		if (!bitmap_empty(td->active_slots, td->maxcontacts))
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1443,6 +1442,15 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_pressurepad)
 		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 
+	if (!td->active_slots) {
+		td->active_slots = devm_kcalloc(&td->hdev->dev,
+						BITS_TO_LONGS(td->maxcontacts),
+						sizeof(long),
+						GFP_KERNEL);
+		if (!td->active_slots)
+			return -ENOMEM;
+	}
+
 	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
 					       BITS_TO_LONGS(td->maxcontacts),
 					       sizeof(long),
@@ -2062,7 +2070,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
-				clear_bit(i, &td->mt_io_flags);
+				clear_bit(i, td->active_slots);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -2085,7 +2093,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+	if (!bitmap_empty(td->active_slots, td->maxcontacts))
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
-- 
2.45.1.windows.1

