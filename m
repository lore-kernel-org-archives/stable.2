Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A4370D70
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048628; cv=none; b=V4Rgbq9jgMA48KWeYf6H/iDFGAUQ4MTZ8mlreK7m2Dvm1gllMOx/RUOyRi4Sg+eFw3VOaXNYWdTgE+MFhuYeq2vCPov0QM9Mco2k7vuQsqG67oVZsROOi8ZqKqmqhet4wZZGp/hjPWH/N6ekRoFAoxmoytDpuZvMDNX3rGpby+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048628; c=relaxed/simple;
	bh=YqC9iDwpxyUc/X5PROvGek7XpCxoo71vmGdQ1f40fXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMZ9hszApIUrIXyCsxyueRI8FvGV6i1KllcJ2nZX36eqmeKz+Oi0tU6EcwIB0rngwzCWho4+tsBZIy5K3tve0XeGxpv8KwUPcHw6zat5cXflfVeXwVyyffOmHycl0U/B/HZ/Z1bBwRIgSd9KAair+IPCrhfgOCSmkHtSWjifgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=DQAzVio2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="DQAzVio2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848d21bbaffso1794636b3a.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785048626; x=1785653426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaArLYkUWmaM9MJAuJdcx0UyuZzpKZG00TXXySfOH00=;
        b=DQAzVio20T5EZcoZH7A07F69ADDcLwJDEn8uvj7FLr9tV3NJXT/bYokCimxg9xq5kF
         ePe9sVZq4Z+RzBP2+SF3XBfnm1Lid4wnJTc1Pxj9LU72Fk6V0fuGzf8OFSo1GBlPKBz2
         +qn/XFMvoFHi1GvbwJV6zQv7m9woByR5peKn2QyZ7qZWuohTuUVkcClSsvIP59lnewG8
         W/WV3P43cNj3nadFX723I+0i5vDua61cdVlVLoJyyQHVGME9L68ad4Z4MTxX6nJmocWc
         kmbbkrnIv2V1Fl4CeO7Uzz2dwA6E8NQNEuTZZngcIgDP6prSj7N3AJ9FUStuKIvNgwaE
         GJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048626; x=1785653426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaArLYkUWmaM9MJAuJdcx0UyuZzpKZG00TXXySfOH00=;
        b=V9+S6v0+3+41KffJ3w29kxITcLOxgqX5D40MmE2WnKoueInTcCS7KmNtj1TlazNEmT
         sdBAOhjNA59xReOqbIvM/1QNjZ/EwjgtH9GGm1iPNBrFJ3vos+JEuzIBwGC9dpeBHDfz
         kOJyirf3iOB4MZ30oSyxlBNnFFHsNWj9limXfQtaUrMxCvAiZbfzQldsNgZF4JBZgLxy
         mTla9u3Hrh7JJcm69W882Bwbr36fDOZzuqb5MaxLVZxSTArJBztHOboJDv7/FaXRrox2
         Y1A+dWMM2TPldymyIZ4fj183Y1ynQ7zwjaevG/B66kNCDzeVwReCxst3ZhJT4e7UeqBq
         /7JQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqgXLlSEEM6HSpKuZwDWWNrPAvZ2Gf8wcM8T3zlP98J7gyW9jAwtcw9fjjJcDqV27gMaaG6eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyH+ZcLG0qbrdVa+KxcNwO47s37Z332jYwnXP3RUAbaQCsksou
	AgvhS75jtMpkbmQYeXA9I/ZJ2ojcavQdp9OYnCJyaqWCwyHmuBETlMUnVt6WyqZaDso=
X-Gm-Gg: AR+sD10pxBcrhebVU1bi03K2p7D0BMLFV/Vnx0qhfJPFN5ICxLXKsmZbS2TyV0Z0Cd/
	uXHONYCEq+8ahD5ruBTOfH3S/8DvtcojeWQtWsKMean72oLgU/6NfGfzOVITDcu2SrrrFJ7BXsP
	nR/wuXNQGZm5vFDJDR737/sRuQ+oQeaO/nfkI0wumiHhWfvdtzJjTpjTvSBMzwEXf3QGO1EHIcG
	zzya94DdKu5OOgIdaCvVe5ecnsSDkO8AQvB+NNWFFYVMia84HAfNADFZ+OR5HxFtGHPvlIjisjs
	+/iki3Y2clh5DQx/kAUw0xLBoq/K940w46l9UpbIzWZd4b/WxeYgLwJcVu+SoTozzBNgM2Sg/zd
	GrUqzxq8EP6QX/h5jC+BCmU1HTZ9CYr9oeF6PPLSSci9100DOT/gsRxFIyJargCkjtYfxzEOHnv
	hDDk9BLdVTtiWWWviuCdqtuyA7ix39hRBTaIIe3HdxLjK2iwfePFrQEaewEr2J+bVUX9efTSE=
X-Received: by 2002:a05:6a00:1ca2:b0:848:7b92:8e74 with SMTP id d2e1a72fcca58-84e59544834mr3284997b3a.39.1785048626213;
        Sat, 25 Jul 2026 23:50:26 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce1f7sm1632320b3a.34.2026.07.25.23.50.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:50:25 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lina+kernel@asahilina.net,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix stack info leak in RME Digiface status
Date: Sun, 26 Jul 2026 15:50:20 +0900
Message-ID: <20260726065020.46070-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_rme_digiface_read_status() reads a four-word status block from the
device into an uninitialised on-stack __le32 buf[4] and, whenever the
vendor control-IN transfer does not return a negative error, copies all
four words into the caller's status[].

snd_usb_ctl_msg() copies the full requested size back into the caller's
buffer regardless of how many bytes the data stage actually delivered:

	buf = kmemdup(data, size, GFP_KERNEL);
	err = usb_control_msg(dev, pipe, request, requesttype,
			      value, index, buf, size, timeout);
	memcpy(data, buf, size);

usb_control_msg() returns the transferred length on a short control-IN,
which is a non-negative value, and writes only that many bytes.  The
remainder of the copy back is the kmemdup()ed image of the caller's
buffer, so a device answering with a short data stage leaves the
trailing words of buf[] holding leftover kernel stack.  The only guard
in the caller is err < 0, so those words are stored into status[].

They then reach user space: snd_rme_digiface_get_status_val() selects a
16-bit halfword of status[] per the control's reg/mask, and the eight
Digiface status controls together expose the whole 16-byte frame to an
unprivileged reader of /dev/snd/controlC*.

Zero-initialise the buffer so a short read yields zeros instead of stack
residue.  This mirrors snd_rme_get_status1(), which already clears its
output word before the same kind of vendor read.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 611a96f6acf2 ("ALSA: usb-audio: Add mixer quirk for RME Digiface USB")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 sound/usb/mixer_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index fb3bd360e5a9..a1f5592cc5d5 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3496,7 +3496,7 @@ static int snd_rme_digiface_read_status(struct snd_kcontrol *kcontrol, u32 statu
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = list->mixer->chip;
 	struct usb_device *dev = chip->dev;
-	__le32 buf[4];
+	__le32 buf[4] = {};
 	int err;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
-- 
2.50.1 (Apple Git-155)

