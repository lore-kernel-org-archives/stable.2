Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542804746A5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253460; cv=none; b=CCedjZsqpTrFMjSXWvB3n+nWB/G51lhcLha7ufpK1lBTpVnw8Twb5b43ZGA0Ubx4UcRbYBAKmPdCweKhyPcxkF8znw33lYv6kru1GIQ7vHp+YHQOW6TtsxNs+VdXiPhJDopHy3sisZlB3mjibAq5uXaq7rEqxTaqEolmzH0nl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253460; c=relaxed/simple;
	bh=doIX0DQKKAwL94HMKj7Q8UCwjHeiufCnHKuAhPQ8rv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmG8LvuUhF2AhrCBya0+urGe1VnXx3+kYD68E0y40yoeDmxXnX3a7YLqiKENHtbqHjHMlsZx3FINpcbTGQZICHlXiGz6oxNAqLNzFvypfVbzZ7/E9Y9o8yjXnFw6hft/r7dknfSN0EJfzMtXMID1IueSzsHHd5DavsotPMHFMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Gj9fBX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Gj9fBX"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9aea40d799so458821a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788253458; x=1788858258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmL3qNokOvrwN31ChPqandS/QNdZTsNqkBCTpOqDVtw=;
        b=O8Gj9fBXV6Owy1bUKxQ33chNaMfoz05Jt9NTM1nZw2z8l7Kws8NtP1cnHYEtFzc/xO
         y/vr5OFnleCPMAvgWv5tvqUCpN0J9gpZR8h/nX75zkNL6ADfTuPd1wwOc921xN9pi5VN
         DC3Eiyf6xxFhZTzc8J4Xy4w4xtUlg6FMTPaJvsQZgZSw01VD84dSZWYtaBlKqUIM1GWX
         kLH9vGQdQ9teCN1oTOwgkOhGJ/l80OBVHFnGx04RKMs+0esETyLgbbgBwB2wNbjqOm0A
         TWMwr3vW9SBhdihQm1XlJd9peqi6gLJXWlq7wzf+HbovPPbLkxKVRzXqT1l5ye8IV3uT
         AsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253458; x=1788858258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmL3qNokOvrwN31ChPqandS/QNdZTsNqkBCTpOqDVtw=;
        b=l1lQ9xe23zvdNAe1XqKlUDVTkSXnz4bZVz7LghxGTcf6VdpLKA36pawmnofnbDjjkG
         5OInb1MRQdgZ5Ie//JuwikdCJMGS3s4NOBiMcr1I5RDNxPMUOok10o5ZwruH5f0XwXVG
         UlT/4tD4nSaBQuqbSPklz9/2AYBX7wyo1o/QcMaccq7WJODrkGXYkl5OaGIqTRqRe7q7
         g7b6VFXZU+0NyXIMBXOrpCZTq1BR4NkfmmefRh9667PREojWgEMNVF7vWlqVsaSR5Yju
         RfkBCYELCcKNpNRnGwjp413vYe+qU6fXYKT9obFjVP6PPfSXWaA18BpMnP5h6oRS5Bll
         L0RA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0ijwUOMkHIf9qdWlQScPtCweVYGV3PnOl5ayH8wmcuUVKHHXdUmdaedf3kRkBs7BI5cH/EOE=@vger.kernel.org
X-Gm-Message-State: AFuF++kGyqFcHQ9R1vG+LjUV1cazXK96BMCJZ5WPK5wL4o3DCzIHc/PJ
	VGOSBCbuRRb5lMqNfB+K6acXxMGl7KRRoIMcyqTUj25PpSvCp/Wmr35VkVqdknPD
X-Gm-Gg: AR+sD13aozGsAdbC95VBi/r+hfeqshlxlIs37JVok7dlc5ItlfaDUAajbvXULT/qZmq
	bj1uzbthiUualzVwqiZt9Vi0Cgwi+x6Amv93XsKS7ewqz4rTSJvEalNgb8692TmkEkL4NlfdQ8x
	UQEdncDEOO4+B+lWXDV6otZfvbOBiJ/uiIDguLI5tYLMXdBxzueRsLciUhW4ojtltLl5LgflU1P
	BhxGFLXcpcGpWY7929f+t4UciCbVsLWbZpF6Ofh4U/3cnBbDK8lziqD9oLxV/LqTpKAao0dHWD2
	zyKVfFcHeEjDMKHlldJZyHkwsD6oX1bJPwfmvf+x1QnYFeo4UeHsiFQSIHTy+P9fijZR68VlKEu
	UyVmRy5B6u8XpmBwRiF8UXMlQCh3vsITDiQQlDWYsjvx4seBMpnQxpslNBHRYzu78UvJo9fDYXE
	tjv2t+vbybmmnUunCsOQDbTuc0vVVHnUMBzY6pbRSoOihOlGZfGr93c/V9lRS46U7GxeNk3cxRY
	2znCDzwuH7wk3dpmi7KOPBQyTa8U2TUsxNfjdawspdwG+s1EYmB4g==
X-Received: by 2002:a05:6a21:6e48:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3d269519d51mr54397035637.13.1788253458199;
        Tue, 01 Sep 2026 02:04:18 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36dbf62sm5666670a12.25.2026.09.01.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:04:17 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: clemens@ladisch.de,
	tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
Date: Tue,  1 Sep 2026 18:04:09 +0900
Message-ID: <20260901090409.1478573-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snd_usbmidi_us122l_output() picks a count of 2 on anything slower
than high speed and never relates it to ep->max_transfer.  The URB
buffer holds exactly max_transfer bytes, so a device declaring a one
byte bulk endpoint takes two bytes from snd_rawmidi_transmit(), and the
memset that pads the rest computes 1 - 2 in int and wraps to SIZE_MAX.

Only 0x800e and 0x800f are pinned to nine bytes.  The US-122MKII at
0x0644:0x8021 falls to the default and takes usb_maxpacket(), which the
USB core only clamps downward.

The akai and novation output ops in this file were given the same guard
recently.  Do the same here.

Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/usb/midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f8996416c3be..1a5210556981 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -969,6 +969,8 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
 	default:
 		count = 2;
 	}
+	if (ep->max_transfer < count)
+		return;
 	count = snd_rawmidi_transmit(ep->ports[0].substream,
 				     urb->transfer_buffer,
 				     count);
-- 
2.43.0

