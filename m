Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CB30216D
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311847; cv=none; b=dDk0OKFfkcBUDucqeZsDbLOOj8DS50x44nTmrwvAlSDK4343aqOZ47fUFQW3ZJ35i+xIzqM4u3AuqpGqszGyAnxEUZetkCS5eOB/uFvTylZLV+Q0osdpBe1eSnZu2HuMbYO9m9pjlywVmorVs13LXZi0iFlx/AkrWjRH8sU6neM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311847; c=relaxed/simple;
	bh=6+8dZ25wx9g3BlD/OuoBnUuvzjT9RsOsJ7dDMoA+1Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQgCkI11afcJEWCiw6qaVAZdfN4USGMJFLVkLfqdydi/4hURoPYOpcEUCiJelDWDECfzLIJjEDjcwGS80+zg9FWk0IQuNOD/36v2QbT1z8jt82EgTmc9SiVQcBe4+++ljbeGeewqbp5AR6ROAtkFk5UBUxzKq6hVRk2bIVyGERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darvell.me; spf=none smtp.mailfrom=darvell.me; dkim=pass (2048-bit key) header.d=darvell-me.20251104.gappssmtp.com header.i=@darvell-me.20251104.gappssmtp.com header.b=PkPKVQk0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darvell.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=darvell.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darvell-me.20251104.gappssmtp.com header.i=@darvell-me.20251104.gappssmtp.com header.b="PkPKVQk0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c7e8eea816so2812835ad.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darvell-me.20251104.gappssmtp.com; s=20251104; t=1782311845; x=1782916645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhMe8aGptZNdBSKGreM3SCPluJHCPPxWSFXY5vBNji8=;
        b=PkPKVQk079+4JZtaeQ/ElieV2tna1RYzoAF5uw6W3togxjZ+rhBB2juayNtBRyV7Ju
         OyoYawIX+bTPYGc38djs4cPkbVw6fd25W8+bntxvGWoAbKaBkMNj5itzRUGLfmxPTYXB
         UVpnRTEtfzuvWWYP+WLzAkzexSeTXkzTu6slmxBbor6E5AXnQLZQxZejNR+ShZW+scxl
         B/NfsCXlzyNzvUs4RS72hV4L4Uzac5zY8L3iZQhHUCALw9pQyYxS8ckj8BVFZ2XXrlvJ
         lgHem1s4p5bbB3qw85TN/ZPuJD9pk2BgE035XTyxzPP0TMdyhuefK5nrf9bbiXeRIVg/
         5MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311845; x=1782916645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhMe8aGptZNdBSKGreM3SCPluJHCPPxWSFXY5vBNji8=;
        b=e0wsAZbSuFMBWomzMDmuMlBo47spsZMaqNq2sRfp293utLTYSSKO7ju+RXnWi4LycG
         EFOmBuJx++p7sjU7IhjaoBNouMd8UgHc4DS063T+zSo5SA8UUfuIR2+7ASv7iW2urw5e
         PQy0emh+G7G3fUm+u4m3Qphlw/Z2D/Cp9dJF5Mr3Xin+JV17AsNFTdAzJt6i5iH5xORn
         UdLzrpds/WiAxEwzDU0JXrS0h5XdaQxyB0BqTfcaNec56qk1SVDeEOZHqEG5j0YGr0iJ
         r6rbHM2SmdK3CZqGim4R40XsVmvVvC8VBgT1qsjYHmaxWaB72PvILAYIVjc0hRnS1mQU
         7Vcw==
X-Forwarded-Encrypted: i=1; AHgh+RraQTqvXOryxeXw7Ana1WLGEv5iuyVwnSRnAQ/BKfa3P38tLhTsXhKgEX7iB6ymCLIUPTlmtS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpupqwepWugB/MsoUVw/IYsiDD4D28ZGtjZG1ne8zk+06qsEl
	e4Z/tXz93PYrDM3VnS7krTjiIv4T+NoUCnqOstjq+tjDbloO5Nv5YWUCJSeOWPj1OkhQlt9gDTV
	5YeYdNSj3IFugPN4=
X-Gm-Gg: AfdE7cnWqBS6UbhNQ6FHmtNu1VcNfo1pyOa8vChAmCnvkea5oWzibcvMHh+td62Agjt
	kk7SzXm6p3t/KssMPjweUlIkNiYfYvMrwah5i4JIqx0zUi6nKM9B6/Pi2UuceW0d6/inDJoCWqH
	bWZMtfct/PlMIq8RRfcfZK9Lr9fp7vcT6zQpMH8871s5JPiBccZn0gwR+HPA4CcvmxUNk1xcnXq
	gSRN2s1TNVxCGYgrll5HLJewST2G7kPhO7iK2j4dJqBrC+WwQ/2QTQaehfB34K5OXyQ+QyByTzv
	JjF1k2b9GFfTuSQbGsnV4mSUknL4mtg05FtbZmq4+STJmEFQmLBtvz7ZNhGwOjsIH2j8R1em1bW
	ZtxYbIuz7WuwXo3y5xvTsf2lmDSncxyr5Eyq8h8ttYMaqdfe1H++d4I3xa4UdWAtT988dXlqYHi
	7+Wrj4XGGYqfaM9LcNAA3GSiV+R2Laqpsb66Bfnd56VVnUX9wzuMtSAtuo
X-Received: by 2002:a17:903:1b4c:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c7c41180e4mr65435945ad.28.1782311844504;
        Wed, 24 Jun 2026 07:37:24 -0700 (PDT)
Received: from lb.drongo-great.ts.net ([199.45.144.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c74478ff1csm141305285ad.83.2026.06.24.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:37:24 -0700 (PDT)
From: Darvell Long <contact@darvell.me>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: avoid kobject path lookup in DualSense match
Date: Wed, 24 Jun 2026 07:37:23 -0700
Message-ID: <20260624143723.2986353-1-contact@darvell.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DualSense jack-detection input handler verifies that a matching input
device belongs to the same physical controller by building kobject path
strings for both the input device and the USB audio device, then comparing
the path prefix.

This was observed when a weak physical connection caused the controller
to rapidly disconnect and reconnect. During that repeated hotplug,
snd_dualsense_ih_match() can run while the controller's USB device is
being disconnected. kobject_get_path() walks ancestor kobjects and
dereferences their names; if the USB device kobject name is no longer
valid, this can fault in strlen():

  RIP: 0010:strlen+0x10/0x30
  Call Trace:
   kobject_get_path+0x34/0x150
   snd_dualsense_ih_match+0x49/0xd0 [snd_usb_audio]
   input_register_device+0x566/0x6a0
   ps_probe+0xb89/0x1590 [hid_playstation]

The same ownership check can be done without building kobject path
strings. The input device is parented below the HID device, USB interface
and USB device, so walking the input device parent chain and comparing
against the mixer USB device preserves the check without dereferencing
kobject names during disconnect.

Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
Cc: <stable@vger.kernel.org>
Assisted-by: Cute:gpt-5.5
Signed-off-by: Darvell Long <contact@darvell.me>
---
 sound/usb/mixer_quirks.c | 46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 50c42a4..912b8b8 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -567,46 +567,30 @@ static bool snd_dualsense_ih_match(struct input_handler *handler,
 {
 	struct dualsense_mixer_elem_info *mei;
 	struct usb_device *snd_dev;
-	char *input_dev_path, *usb_dev_path;
-	size_t usb_dev_path_len;
-	bool match = false;
+	struct device *parent;

 	mei = container_of(handler, struct dualsense_mixer_elem_info, ih);
 	snd_dev = mei->info.head.mixer->chip->dev;

-	input_dev_path = kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
-	if (!input_dev_path) {
-		dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
-		return false;
-	}
-
-	usb_dev_path = kobject_get_path(&snd_dev->dev.kobj, GFP_KERNEL);
-	if (!usb_dev_path) {
-		dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
-		goto free_paths;
-	}
-
 	/*
 	 * Ensure the VID:PID matched input device supposedly owned by the
 	 * hid-playstation driver belongs to the actual hardware handled by
-	 * the current USB audio device, which implies input_dev_path being
-	 * a subpath of usb_dev_path.
+	 * the current USB audio device.
 	 *
 	 * This verification is necessary when there is more than one identical
 	 * controller attached to the host system.
+	 *
+	 * The input device is registered below the HID device, USB interface and
+	 * USB device, so compare the parent chain directly instead of building
+	 * kobject path strings. This avoids dereferencing kobject names while the
+	 * USB device hierarchy is being torn down during disconnect.
 	 */
-	usb_dev_path_len = strlen(usb_dev_path);
-	if (usb_dev_path_len >= strlen(input_dev_path))
-		goto free_paths;
-
-	usb_dev_path[usb_dev_path_len] = '/';
-	match = !memcmp(input_dev_path, usb_dev_path, usb_dev_path_len + 1);
-
-free_paths:
-	kfree(input_dev_path);
-	kfree(usb_dev_path);
+	for (parent = dev->dev.parent; parent; parent = parent->parent) {
+		if (parent == &snd_dev->dev)
+			return true;
+	}

-	return match;
+	return false;
 }
 
 static int snd_dualsense_ih_connect(struct input_handler *handler,
