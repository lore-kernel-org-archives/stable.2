Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267F25DB1A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899565; cv=none; b=LEUWynWs13pZM2Qbq6FYGDG0d34imG+GYPdiK4XzL8jzmOrpS7/M0JHhTAvRhd06qcAak2l41zB1jJ/YkK9iOp72wmcsE5mGuZlvC67SwJOioVa+wNh3OA/jAUzNyPc9t+2P1klaKW8tUHVCJMz5V6pLYIczpvIeHSHg0cHfFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899565; c=relaxed/simple;
	bh=3a1+2nbXhZcTj4NeTgnKV87B2okzAssG60+kH78Twao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl+KP7opJc9cpLj0bzr6WAT4uojR1DScD3COpjVrTvc6kkCD6eyPUcTsldKGyDmd7gbYMN6oFuwT6EX9XKnFRWm7cDze4eYBq6FwyDhN4O+dt4+z+3k5DLqbRXAu0XP6z4dr2VenTFn2AhdOdXvJ1GISw2oS3uRiRwKmOmpDdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qg0owHf3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg0owHf3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so211108a91.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899563; x=1783504363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mVJevA43xSAbcO4XqhY7+SohvyRUWiP3RuKf16nZNc=;
        b=qg0owHf3MUSdtGbd/ij8LNpShNt375wMuwK4tvW6JxsKT73IkPryVWOiMzIvJaaNi9
         aRiMP3reyuHWGCI+GBm4xsric1MimiiiQLMXPHdfkNtu7bloeejmYYBBo7wG1xyuMlmb
         kMwOmUMfJ/THgi9rB99u+z49LrVVGoqP9muBQYLGrp4VPklQG/ND9ZCaj2opLyurkpDA
         W8NYHC/xgBbsmTGZBDOeZ1xad+fYdPpnu9mg0jkk3mX2IYN0/I+k3Wj19GBeHvRRELnF
         NfjLEUlFIGf8Gl0M87dJQAJZDH1aFfgowekEFxGLFAGBcQtaSCEEA07y0B+laUcVflsU
         sLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899563; x=1783504363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mVJevA43xSAbcO4XqhY7+SohvyRUWiP3RuKf16nZNc=;
        b=S2JoAfGKA+yDXgLzv7yx1QUUOuNG8Y9riAHMyw4UuRsgw1+4KaaDvU4PzJohlpMy0Q
         ymWpzNwMDXDijynEwu4hw0LR+yEszWAQjc3ATrh7mXXkugM4IuEn8XGSsbJ+NWQL3MMi
         zMPmB3jQh1lAZ8KjYS80dV5FL54CYKfIkqzkWkNrUyVrRRbJcK1eiMdyzk78wIrKLAEw
         MrMV/5xSDFJ/Gh1QQhtqjd3lAkajfi9Oe2XumxHZga8N43wZcMcYe4hQI4DHwiPWhzOT
         OFc33gUBtDnOs4Zj+K3O4KlaS0YJpywz2wNsSiDmOh+xwr9hWo5Wgf5c/7hQ54lJtjqz
         XchA==
X-Forwarded-Encrypted: i=1; AHgh+RrlJ/uzECh/xt+QJUrb3998lFUQZsWy7tEMlsNkLtdJHF1LZZ+bRIPH7mP0FYY/YGqWd/75nDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rO7yHi5HbwEaoHRjXto7FCjN1ZKojBLPSlMt3pIn+glUqgUg
	u85eFgcT8r+8kdas3KCu9FYJp3a30A0w8DARMVEBJeZKrgHBL4NuRaHU
X-Gm-Gg: AfdE7cm4A0Beqc2qMSftOX+2GwUj5jsxBNMZFCU4acBsk/7gD81fN4DB0DdWVaEtJuF
	CAlcbdyzTfUYDVJgEJe1om+ZpJ0ryhopkstW25+0eq1ffLMOdcmyhATkb8yuygXsDzRgPWIeWgJ
	qAO5sQx1j8ZnODz6j/6nfw7Fy7NTY095iqf8NGsHz8GTHuqdfctrDe5b+UCEU7a22RZ87cgEs3T
	CicWENZ/C1V01rOHk3x4V5AUbTwVoYwbkwgjYKp5ZR9a2qLFvPR/2yHjcd5Rz5ilo8NZBzfrSBK
	0rTILoXtn0KoW7tnWmg70BJHMiwR7G8M4Qxgql41noAqR35WmQ+TCc2HLfy95hw84vDW5lX1xs5
	iq6UkPeMBfnSRGBuVzYH94WQafL/BSa9hC52bmY1K4iCPg2KlPft1NRQb9UR+1Wp7rOS4rmn/Fw
	FRUZgOU55F/CEVZTOXzyQVuYVnGYJg9CBhTz8T9fUYdXUpz193zivI+PG/XD4g5p/UTxJuZEebA
	pCF/A==
X-Received: by 2002:a17:90a:d647:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-380aa221bf1mr776096a91.23.1782899563156;
        Wed, 01 Jul 2026 02:52:43 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d6d45asm1596801a91.9.2026.07.01.02.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:52:42 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usx2y: us144mkii: fix work UAF on disconnect
Date: Wed,  1 Jul 2026 18:52:31 +0900
Message-ID: <20260701095231.1020811-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tascam_disconnect() cancels capture_work and midi_in_work before
usb_kill_anchored_urbs() kills the capture/MIDI-in URBs.  Those URBs
self-resubmit, and their completion handlers reschedule the work.

A URB that completes in the small window between cancel_work_sync() and
usb_kill_anchored_urbs() therefore re-arms the work after its only
cancel.  Nothing cancels it again before snd_card_free() frees the
card-private tascam structure, so the work handler then runs on freed
memory.

Kill the anchored URBs before cancelling the work; once the work is
cancelled no remaining URB can complete to re-arm it.

Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 94553b61013c..58ef23146f20 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -585,19 +585,24 @@ static void tascam_disconnect(struct usb_interface *intf)
 		return;
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
-		/* Ensure all deferred work is complete before freeing resources */
 		snd_card_disconnect(tascam->card);
-		cancel_work_sync(&tascam->stop_work);
-		cancel_work_sync(&tascam->capture_work);
-		cancel_work_sync(&tascam->midi_in_work);
-		cancel_work_sync(&tascam->midi_out_work);
-		cancel_work_sync(&tascam->stop_pcm_work);
 
+		/*
+		 * Kill the URBs before cancelling the work, so a late URB
+		 * completion cannot re-arm a work that then runs after
+		 * snd_card_free().
+		 */
 		usb_kill_anchored_urbs(&tascam->playback_anchor);
 		usb_kill_anchored_urbs(&tascam->capture_anchor);
 		usb_kill_anchored_urbs(&tascam->feedback_anchor);
 		usb_kill_anchored_urbs(&tascam->midi_in_anchor);
 		usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+
+		cancel_work_sync(&tascam->stop_work);
+		cancel_work_sync(&tascam->capture_work);
+		cancel_work_sync(&tascam->midi_in_work);
+		cancel_work_sync(&tascam->midi_out_work);
+		cancel_work_sync(&tascam->stop_pcm_work);
 		timer_delete_sync(&tascam->error_timer);
 		tascam_free_urbs(tascam);
 		snd_card_free(tascam->card);
-- 
2.43.0

