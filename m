Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A2401494
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784846551; cv=none; b=QpXS84rpeLwLTNwN8n+pYczzpSXSMZpOfWGjusmAHYnasFBpoyvAYwf3qIzORyijSIXczsfaJRC2qKuaHoYvZjblOi/tE7v9FpsrIE2twuJQcImpfoDCqDH6J4B3+ROe5YeBtcSZ7l+pFwo02szJOSfobUG2Orb0zzC0OMHtOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784846551; c=relaxed/simple;
	bh=8NVtpDOwjU7udwxECy9jxjiPQv82i59N1FgCx5vcIrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+dyP7sXSX95W2tFdNbjy49cM6OGJ3s+Fnq63sq6IuvsXvdYSmXKSIXONTJKVnEcYnZ5oE4ICA2YyYCHP+AJaXdsnfD1kqMMAF/Gp1B2kGMs1fDo32Z7rvGTXNIIOrRgT1PsZekgFvwG5OfLM9RdKeCMVDwexUQe/EID3B0883g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPT/k2FK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPT/k2FK"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69e8ea2783aso1762272a12.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784846547; x=1785451347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlojMWIujU/Cv7htl//acVMDx5/x7mtDVl69pcel8kw=;
        b=OPT/k2FKVn0nbyUG2fsPVUqnlBLYu7DoEOglF7JSaxn66lcDPmmHMO/apsq0s2EKIA
         tnw++RvuMOlK7mTEA7f9UCtsoNwwK/8Tdy4GyNBIYZa+mcW+hMTY1VkfcsAp5sT7S436
         Jkn+tbXX1AncgxmcHo3T1VW2fFMqlTZDNzdjsHYX4B/4r/Om5H/zEePbpkhxyVH25KE0
         MLQY+ELRbuoikCULx/8PUymliWxNHrl4ZJWfTscvMlKlPMiZIyNLNuZCgKmnxs2sU7+B
         r6T8u9YqV/mpiOkMWgCBMIWg30x6kgt3QEbp52qC1WvdUwJfkFje0kcPINtrbQJVhf7u
         KZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784846547; x=1785451347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlojMWIujU/Cv7htl//acVMDx5/x7mtDVl69pcel8kw=;
        b=U1FQ3/jlC8+Nlf8PYB7d0vvOWK7E545YEAwwd/pHMjdMrtaPzL5qKmUfiLRI4gkqCC
         WxXh6jT7Wm4vmH+XYHUyfd2+Nwu0a9QEYC61XRBbmafHNGtRLwtC4TPUgsn42VbI4hln
         CG0UpU9NbSKmlsrjbRB0Ug5r4Hh1hJqTsj6kJA0CEpUujsBr0w6W0x3eaxADi+S0RI0E
         ZrXO1c/ehN7nMiKyL4lSzvXGZiwS4i5qjfRYHxZdoBev5KHQ6JSNAIT4pYc2qkg7yjJr
         Eg33MxbotNL94Tdr8zKSZHJ6VVjs+Qcn7q94BJEFxKKr9E48EMoPpqYHMO2VhJAZkL63
         Zd6Q==
X-Forwarded-Encrypted: i=1; AHgh+RorT2yfyCLDwvZPoBmkzl1Q+bE2D/aG8wgK4CLJCbW6lhIKvcHjcVevQ4xoeMEDbdRekoq4zRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynr871afs0Q7x0gvk0uuRb+fhNBCVzmrPn6ORamaq8dGmzV/IA
	DIkzWDs3cnTIDvv/UrxC+tG/GLTw3qSkJc3kNf8mkp/YtOndL9sJeBsh9XR1/wnwXs4=
X-Gm-Gg: AR+sD12h3bA3MGgJiA21L6IXuBE9MOesGrMVNE1YJezdyT52fXMsu6Wn+CZy2AHwtJv
	jO7ZLrRi+nnBQkTG8hUsWNB0q5/ZyctQEwltRNzbA/896yqb7r0w0nNIjj7xwm09KoyUl5EnNJ9
	Cg7PUb6uHC7wJZMSCvBBuvVOse9eI3z5btbUHmt0fiFqmjafJnbfiW6ysof470BDgcFzyoJVM+B
	AdOoeLbNxiiYFhygM1GFrMf8hCiiQUwAil/eRd74UwoMqAgP8tNwnYw/dZqEkE176JABOf7myUj
	Hg9OC+JlumBZOjjwOUJhd8nb4L8GYf9X+glVW/Ea8BCiVCA9PsX1FT3xah1op22Ql3Gir4pm62s
	KSQEPH8FSyrkVo505fu0UcfMSYb6RxwjAvgt0Vd0DUH0IGEOQe4+NzlwPG4t6d6Praoyp1w==
X-Received: by 2002:a17:907:3f09:b0:c15:d068:9160 with SMTP id a640c23a62f3a-c1c50d1c8bfmr208935166b.31.1784846546715;
        Thu, 23 Jul 2026 15:42:26 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f13123sm276428466b.59.2026.07.23.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:42:25 -0700 (PDT)
From: Your Name <qwe.aldo@gmail.com>
X-Google-Original-From: Your Name <you@example.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: multitouch: bound the slot index before touching mt_io_flags
Date: Thu, 23 Jul 2026 19:42:11 -0300
Message-ID: <20260723224211.613112-1-you@example.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

td->mt_io_flags is a single unsigned long.  Its first MT_IO_SLOTS_BITS
bits track per-slot state, read back through MT_IO_SLOTS_MASK, while bit
32 holds MT_IO_FLAGS_RUNNING, which the report path and the sticky-finger
timer take and release with test_and_set_bit_lock() and
clear_bit_unlock().

set_bit()/clear_bit() are called on that word with the slot number as the
bit index:

	set_bit(slotnum, &td->mt_io_flags);

slotnum is bounded only by td->maxcontacts, which is taken from the HID
CONTACTMAX feature value and can reach MT_MAX_MAXCONTACT (250).  Two
things go wrong once a device reports a slot number of 8 or more:

 - a slot number of 32 sets MT_IO_FLAGS_RUNNING from the data path.
   mt_expired_timeout() then finds the flag already set and returns
   early, so sticky fingers are never released, and the
   clear_bit_unlock() in the other path drops a lock it does not hold.
   Several in-tree classes declare .maxcontacts of 40 and 60, so this is
   reachable with ordinary hardware.

 - a slot number of BITS_PER_LONG or more writes past the end of the word
   altogether, corrupting the struct mt_device fields that follow it.

The same unchecked index is used in mt_release_pending_palms(), where
slotnum comes from a for_each_set_bit() bounded by td->maxcontacts, and
in mt_release_contacts(), where it is bounded by mt->num_slots.

Bound the index to the reserved slot range in one place and use that for
every set_bit()/clear_bit() on mt_io_flags.  Dropping the out-of-range
slots is not a functional change: both readers of the slot state mask
with MT_IO_SLOTS_MASK, so bits at or above MT_IO_SLOTS_BITS were never
observable to begin with.

Also correct the comment on the field, which claimed that eight bits were
sufficient because at most 250 slots are supported.

Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-multitouch.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0495152091e3..463eab9f73cd 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -98,6 +98,7 @@ enum report_mode {
 };
 
 #define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_SLOTS_BITS		8 /* bits covered by MT_IO_SLOTS_MASK */
 #define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
@@ -175,9 +176,10 @@ struct mt_device {
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
 	struct hid_device *hdev;	/* hid_device we're attached to */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
-					 * first 8 bits are reserved for keeping the slot
-					 * states, this is fine because we only support up
-					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 * the first MT_IO_SLOTS_BITS bits are reserved
+					 * for keeping the slot states; higher slot
+					 * numbers are not tracked here, see
+					 * mt_io_slot_set()
 					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
@@ -1027,6 +1029,25 @@ static int mt_compute_slot(struct mt_dev
 	return input_mt_get_slot_by_key(input, *slot->contactid);
 }
 
+/*
+ * Only the first MT_IO_SLOTS_BITS bits of mt_io_flags track slot state; the
+ * rest of the word holds unrelated flags such as MT_IO_FLAGS_RUNNING.  Slot
+ * numbers are bounded by td->maxcontacts, which is taken from the HID
+ * CONTACTMAX feature and can be much larger, so the index has to be checked
+ * before touching the word.
+ */
+static void mt_io_slot_set(struct mt_device *td, int slotnum)
+{
+	if (slotnum < MT_IO_SLOTS_BITS)
+		set_bit(slotnum, &td->mt_io_flags);
+}
+
+static void mt_io_slot_clear(struct mt_device *td, int slotnum)
+{
+	if (slotnum < MT_IO_SLOTS_BITS)
+		clear_bit(slotnum, &td->mt_io_flags);
+}
+
 static void mt_release_pending_palms(struct mt_device *td,
 				     struct mt_application *app,
 				     struct input_dev *input)
@@ -1036,7 +1057,7 @@ static void mt_release_pending_palms(str
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
-		clear_bit(slotnum, &td->mt_io_flags);
+		mt_io_slot_clear(td, slotnum);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1247,9 +1268,9 @@ static int mt_process_slot(struct mt_dev
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(slotnum, &td->mt_io_flags);
+		mt_io_slot_set(td, slotnum);
 	} else {
-		clear_bit(slotnum, &td->mt_io_flags);
+		mt_io_slot_clear(td, slotnum);
 	}
 
 	return 0;
@@ -2062,7 +2083,7 @@ static void mt_release_contacts(struct h
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
-				clear_bit(i, &td->mt_io_flags);
+				mt_io_slot_clear(td, i);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
-- 
2.43.0

