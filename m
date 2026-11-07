Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018409;
	b=c7Wuz5coIYPtn2YyrfVOS7ghahtkuOsDWm3Z7g4v18HWoC035Avik7jFuALpfg1JP5vS
	 Q+HPpcidFRLqJwdxElrMfnUrz2FddC5exTHozymA8nTWXu5KIaRKP4Rsv8CTEZnBQef0a
	 u9KbFzg8LIX0rR2BwkTrnyWP+t9oSbF3e/mTa4ZQ7ICIBtBVWsEigDxrpy3kBmxN12rIJ
	 B6UPwVzHmZsQ+zRgTW5Axb2En1dW1qisr/aqePgW6rRW8DKgRc7OAXFripMoA0cqGoY4T
	 AhAV7MwXwFFNikZb5HzO4Zf9PhL9QeKaNtQAFTGusq+FoEQQ+XdRJiyUUS4w2JnVWyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4NbOECnSKC2AUNIuqP3Ssdsa8prET02+IbfFdfmCMKg=;
	b=o6MBgySRuMW5KLY4GPwgEfagDuaVsKnYe0t3rfJH7d0XbHgh3Wdf/b+on9GuA9x72ii8
	 q8Y3zTiPx/i/mYmugMQqQDe7koUUHmSqir/wAOwxpVZBGPBMCrzLHIMH+bpTJqpkUgyFM
	 R/5b2ba5ZD4ChfMrAknuqlelK+XuXF+lHaTYkWRpZ03K1CzZzzqLFO9g5Y6AsUP9+qT01
	 VMNQYVExJXnXoIJKZVltuWmraazniV5KgbWzwq33kYQTlzokPIzSWlWDAgEC1YJORXGWD
	 QH3t4ch0P9yVjoHfsyFEmHdDkQ4Xbeu7toktM9Ux1Zx4zzHqHnZgs45Mg+1ITfqWEZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/BtaKQd";
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F85606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F85606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/BtaKQd
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0db268bd8so9277767b3.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794018407; x=1794623207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4NbOECnSKC2AUNIuqP3Ssdsa8prET02+IbfFdfmCMKg=;
        b=c/BtaKQdoUSyw7MhMbhuqe8PF01x8kwtH85nic69RzP4R8bS6AcU1lqV6IQtKG3BjM
         RgBQx0u403/OhjWB3anJi+j9YsxwocOzAhvHtvRSmihQimbL5KWJQ28fH6eV5rMP6y1A
         FB7USgxqmcd7LTEIds/Amz/LOdsuFMkg/Ud5qSWwP2HU+AkSk6y2C3Q468lVjDbV03la
         Gtwp89oU0J94uUZmnyXBn8hJo4Gcw18wQ93TyO10zvaGIj23Hs0/SLQoGahL3c6jvK7K
         R0CoWiVcvIoFeSV1ChPokgSEgN1QMV4+frMfZIBdpmimZkOv/E9cGsKaqz1Y8MaRuzO9
         2FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018407; x=1794623207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4NbOECnSKC2AUNIuqP3Ssdsa8prET02+IbfFdfmCMKg=;
        b=eAmgosZivDgakFqgaIue9dLRd9H1IUChLYpMXGfUPfU88zclDhg5mg7akrPufUN1Us
         1MsLwqxrLIbwDabK8NX+RDaKuvS9Ph6mz9+b7OzX+AX4/kE0wrv+luqkhtBNyKg6THSe
         GKmfSQeUjYwGinOi49U6Vrt5srE6QGDc4mYGiu3BLx7V5P0qaO20sGgkMKvT4KVeDzhx
         3IK4W9hqMg6yuNFSDyZTH6TEtVN0tvG6zlFQ70gcSBWJCP1dPZwXZaZCswYuL/+hxtKk
         uSbDunxp6CGigMqbqO3JZU28wNV/KCHOpyQmQW71hpBME3f4rl/2GKs8WNELU+xCvrLP
         72gA==
X-Forwarded-Encrypted: i=1; AL+hErG3VsxIYZL57ijklFJQQBEMDiBdLBAEGOvkY2mEzRfDHAkDP4+MyVcevlmrolnXaYmLycngQfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z99oMPQnIf/J+86E1jExpME+Qvze1jOwpTVcTmNB2MmJtYpA2la
	J7jkST76CRtS2AFvjdiWq5veH+xL4wl9y+X4FrUWbY+Rj9lKwqvmopCpUYrqQAhqlDw=
X-Gm-Gg: AYBFou2ulYyAD2stQKBbkvE0I7DLnPd8vmunLHoOOumoG91oOYFNmp1gCtnSCvY3/mS
	n5X4pevJzMmLHAEdB9jH7UEzfWDAu5EE7FmSEAyx2DovY6B7qR9+RVGaKyUgmV2lAgEBOuhloG6
	iQCY/9205OzVxRvZkFbgYStQBs0toQfsA5ikA7GuQ45MVlzosfrHBK4aEqzoEouxDbSNvxAXztk
	MXPztd5mCUnT+t3hdVeuLljUX6pMvUb102R/IHPHkqEFzL1BUhSCwuMZN23cs3hTWpONbOlrJEV
	sYBVg4GsBs4oeNbS9rvUtFJU5tswv7ODEXOqIpU/FaH7dgt4TlZJ1zty4KFqBzdXeopFeRjPNuc
	uMVG9Kg9fkCgLzkD6Z6+3F9PgH5knfj1BxmV+eHRyvxTpXtvnix7HcRVcLVUmC4/tVgdVNlz0k1
	Ye6xGecUlCwTKaPdIhlBr3ij2NzNLeZW47UYg3lsv7atZesYLYTIV8CAg1+9L3IxbuPARqRduQk
	oShx3bqu+y8ZMXJk6otiG2CCcCRxlJ5y+ikFPhvOxsYljvGeuR/kQlhHq3TtYEuApZVOFvBSPUl
	wE4B+b01rHoUGXDzFuyH9ubcRLNV9ypm8MRWcmazVGVrQaU4opUKkKZijIs=
X-Received: by 2002:a05:690e:b8b:b0:67c:1b55:8b27 with SMTP id 956f58d0204a3-67c1b558dd0mr1454574d50.5.1794018407574;
        Fri, 06 Nov 2026 18:26:47 -0800 (PST)
Received: from pop-os.local ([2804:868:d047:aeb1:207f:64c4:29d4:b099])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f5243sm32755517b3.3.2026.11.06.18.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:26:47 -0800 (PST)
From: Cristiano Souza <cristianocps@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	Cristiano Souza <cristianocps@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ALSA: usb-audio: Skip broken playback feature unit on XiiSound chips
Date: Fri,  6 Nov 2026 23:26:43 -0300
Message-ID: <20261107022643.135168-1-cristianocps@gmail.com>
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
Content-Transfer-Encoding: 8bit

Weltrend XiiSound-based devices (040b:0897, e.g. Redragon H878
wireless headset) expose a UAC1 playback feature unit whose volume
and mute controls are unusable in practice: the reported per-channel
dB range is only 0..+0.39dB, yet setting any volume below the
maximum mutes one or even both channels, and the mapping between
logical and physical channels is unreliable.  Any attempt by
userspace to drive the hardware volume therefore results in muted
or one-sided audio.

Ignore the playback feature unit via a usbmix_name_map so that
userspace falls back to software volume, and pin the unit's master
and per-channel volumes to the reported maximum with mutes cleared
when the mixer is created, so the signal path always stays fully
open.  The capture path (microphone feature unit) is not affected
and keeps working.

Tested with a Redragon H878 wireless headset on PipeWire/PulseAudio:
stereo output works on both channels at any volume, software volume
applies smoothly, and mute/unmute works.

Cc: stable@vger.kernel.org
Signed-off-by: Cristiano Souza <cristianocps@gmail.com>
---
Changes in v3:
- Re-pin the playback feature unit on resume via
  snd_usb_mixer_resume_quirk(), as the device may lose its state
  over suspend (Sashiko AI review).
- Validate the UAC_GET_MAX read length instead of only checking for
  negative errors, to avoid pinning with a short read (Sashiko AI
  review).

Changes in v2:
- Skip the broken playback feature unit via a usbmix_name_map in
  mixer_maps.c instead of open-coding the skip in the FU parser, as
  suggested by Takashi Iwai.
 sound/usb/mixer_maps.c   | 19 +++++++++++++
 sound/usb/mixer_quirks.c | 59 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 98b4146..9218ca6 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -374,6 +374,20 @@ static const struct usbmix_name_map dell_alc4020_map[] = {
 	{ 0 }
 };
 
+/*
+ * Weltrend XiiSound chips (040b:0897, e.g. Redragon H878):
+ * the playback feature unit is broken; its volume controls act like
+ * mute switches below the maximum value and the channel mapping is
+ * unreliable, so any hardware volume change mutes one or both
+ * channels.  Skip the unit entirely and let userspace fall back to
+ * software volume; the unit is pinned to maximum/unmuted by the
+ * mixer quirk in mixer_quirks.c.
+ */
+static const struct usbmix_name_map xiisound_map[] = {
+	{ 5, NULL },	/* playback feature unit */
+	{ 0 }
+};
+
 /*
  * Corsair Virtuoso calls everything "Headset" without this, leading to
  * applications moving the sidetone control instead of the main one.
@@ -790,6 +804,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1395, 0x0025),
 		.map = sennheiser_pc8_map,
 	},
+	{
+		/* Weltrend XiiSound (Redragon H878) */
+		.id = USB_ID(0x040b, 0x0897),
+		.map = xiisound_map,
+	},
 	{
 		/* Microsoft USB Link headset */
 		.id = USB_ID(0x045e, 0x083c),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 5839719..4c7d683 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4603,6 +4603,59 @@ static int snd_audiofuse_controls_create(struct usb_mixer_interface *mixer)
 	return err;
 }
 
+/*
+ * Weltrend XiiSound chips (040b:0897, e.g. Redragon H878):
+ * the playback feature unit (id 5) is broken; its volume controls act like
+ * mute switches below the maximum value and the channel mapping is
+ * unreliable, so the unit is hidden from userspace entirely (see the
+ * quirk in mixer_maps.c) and userspace falls back to software volume.
+ * Pin the unit's master and channel volumes to the reported maximum
+ * and unmute them, so the audio path stays fully open.
+ */
+static int snd_xiisound_init_fu_pins(struct usb_mixer_interface *mixer)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	unsigned char buf[2];
+	int ifnum, ch, err;
+
+	if (mixer->protocol != UAC_VERSION_1)
+		return 0;
+
+	ifnum = snd_usb_ctrl_intf(chip->ctrl_intf);
+
+	/* unit 5 is the playback feature unit on these chips */
+	for (ch = 0; ch <= 2; ch++) {
+		err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+				      UAC_GET_MAX,
+				      USB_DIR_IN | USB_TYPE_CLASS |
+				      USB_RECIP_INTERFACE,
+				      (UAC_FU_VOLUME << 8) | ch,
+				      (5 << 8) | ifnum, buf, 2);
+		if (err < 2)
+			return 0; /* no such unit/channels, nothing to pin */
+
+		err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+				      UAC_SET_CUR,
+				      USB_DIR_OUT | USB_TYPE_CLASS |
+				      USB_RECIP_INTERFACE,
+				      (UAC_FU_VOLUME << 8) | ch,
+				      (5 << 8) | ifnum, buf, 2);
+		if (err < 0)
+			return err;
+
+		buf[0] = 0; /* unmute */
+		err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+				      UAC_SET_CUR,
+				      USB_DIR_OUT | USB_TYPE_CLASS |
+				      USB_RECIP_INTERFACE,
+				      (UAC_FU_MUTE << 8) | ch,
+				      (5 << 8) | ifnum, buf, 1);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -4616,6 +4669,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x0644, 0x8047):
 		err = snd_us16x08_controls_create(mixer);
 		break;
+	case USB_ID(0x040b, 0x0897):
+		err = snd_xiisound_init_fu_pins(mixer);
+		break;
 	case USB_ID(0x041e, 0x3020):
 	case USB_ID(0x041e, 0x3040):
 	case USB_ID(0x041e, 0x3042):
@@ -4807,6 +4863,9 @@ void snd_usb_mixer_resume_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x0bda, 0x4014): /* Dell WD15 dock */
 		dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x040b, 0x0897): /* Weltrend XiiSound (Redragon H878) */
+		snd_xiisound_init_fu_pins(mixer);
+		break;
 	}
 }
 
-- 
2.43.0

