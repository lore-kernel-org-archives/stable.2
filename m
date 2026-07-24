Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EE3E717A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903230; cv=none; b=IsGWNuVDjSTjDoQZiN1nuMFqzRglDGlmLc1PUYZV+7evhlMIXKGKG56LmLl2rNbSCnCA405P+4b1xFCSbjQ+OBC5VSIEJzWuncm+A9fw7oDAMnCLh04gHXm8RGaSILQQ/W6I5+YTPvlZ3iFfQA1e5HkqnoWU3llkaqrLYG/O2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903230; c=relaxed/simple;
	bh=Zj74hJMn5EEa+Tdvo+oBwE3+v+XfzQe/LuZObDwPF1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RA36zCIvI22VElLCtf33beNAllEERBQQB/OFQetKAyT3lqS0RSfzre++uEbgX+Z62yW6vWdet7e+yLBa5cyW/S98Vt/dl2bhP2tu7+jWohfiTI32WQb2Qw+wqjMF2MlbDiBTEgZTIof+CmlxiB4y5pNaCgbqrAaUpLJJ8YppA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=kuEyiKhS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="kuEyiKhS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f7872abb6so358915f8f.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784903226; x=1785508026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOrMfHhwgNyC11nXJyc1Bax0nC8w1A9xAnO4x+p5G4g=;
        b=kuEyiKhSeQeFZ5YSDQNA8JchxlAjUsg14ePTQJAxNc4InmyViaCxfzYCKeaFI/gFyK
         AkeARS54GHCVR9+gHipXJruaFn9MXTEXYQe1z9H7S8UPU8ovioZIBSamwaC2st+38YOp
         MxWdjQBRlgvYlI+V9hXtEI1wBHFsZFDtYMrN0o0CArHFiM4I77/9hM5UCMPLlFjNeVef
         P5kUV5cHmUMkM1ewazxJBOyj++pyGnhZlXu/4kuNZMrdaMK7MQJ8Ek5ThzW8MO84I35T
         yGrt5m+eBMn/CXjcnoTNRgX/nGiGykUnQfgAoAsVR95D1txrmaBy6tOpVo90NLt/1xJv
         6nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903226; x=1785508026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOrMfHhwgNyC11nXJyc1Bax0nC8w1A9xAnO4x+p5G4g=;
        b=KfZ0V1L9WisKqhujzc2tAjDYkTlaJRTn6lY74MuJm4tCZm7UuASc77rcbofFI0kCdY
         jJ9Go/oZYysUZ4VPyypAOmDJt/FJWsZT8ezxh6VPyVDdbLvek/S4VGPSEB0F7ZD7mVB+
         kjDWjCQqBNgU+KBDo1DmTV5n76YYWpwofEdYHTyALy3IyXM1sX3mAPFehe+mLczjxaWI
         sagzGjwk8M4m1IekjlYnOfMnKx7cE96SrAP+prssYx8Mp83fkhisHsP5hI23XzaZtB0P
         dEsNrSr1FJ2/KNjFcoVq0p7xPVkmwyTKq2xssmT6NNHGLXX0KVqR4IhQtvX1WWHtdGRS
         tFag==
X-Forwarded-Encrypted: i=1; AHgh+RoSao8Pq5AoC5MEMCrCau/zrwRAkOsWgzAie7zy7RR2O+APPEXqjStmFobSfdncriieJqimlLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVIMtUCLrSSrvoFiHll9+AqcAgXtNjucOhth6HdGTKTRQbf9k
	mUyJpmJcHs7hxX/K2FRr6tNmQNefTVbviPdMEoPJ1upI6AHdTirXHbfV4oCEMchy+sElTZC44If
	62djjJw==
X-Gm-Gg: AR+sD13Dw6splcZjboThJiKLCTie/fLpHMvhzH5WlJBVn8LCAFCHQ3KmlKcQZ6AEF4f
	d8TmVKQ+6qqoVPELKpBjuuKeFvIQrw+oKo9YgGJk6wrLdpxUC37vNbPap087AEu+1oqUHD4AC8B
	5wzBilHoeVW013NdYRxwDoVNG3O1u2vJ4goPMI5vSBf7KZxnep/7y9isivPvq5IGfk5Tv534B05
	RI5Q7sGaRj3FKquUF77cPRGq1IFjhE6ZHXPAE22nszAqY1ODbcno1Szfj+nS8x3vmHguuOO+Xfs
	L9Xl69AlLvfjp+9lXUqtdIUK2CynrkEb24mJnhG6Moy2AcuNWHj6u3h/AvMwUBx/C96DcWGXHXz
	EAkCYE0sI6pLSnv8HVcCVAletxIKMGkC2IcuUXaoPO4/jzARvPf9tupsBYI7EP3H3NUyNLfRGio
	ynSWvuNkW9dieTi+vXbaEVC0K2IpseBSv63J/MNQjVM7d56hI7UGSHo4qBgGwen2UvdkYQPWYfi
	Y9MBNg3BsODjHV+gBhDtNmJv3YkhckyqSU5
X-Received: by 2002:a05:6000:2906:b0:479:e2ea:3d51 with SMTP id ffacd0b85a97d-47f8da6c47amr8782491f8f.17.1784903226005;
        Fri, 24 Jul 2026 07:27:06 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm26761420f8f.1.2026.07.24.07.27.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 07:27:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Pascal Giard <pascal.giard@etsmtl.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind
Date: Fri, 24 Jul 2026 16:27:03 +0200
Message-ID: <20260724142703.55813-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For GHL (Guitar Hero Live) dongles, sony_probe() arms a periodic timer:
ghl_magic_poke() (the timer callback) submits sc->ghl_urb, and the URB
completion ghl_magic_poke_cb() re-arms the timer with mod_timer().

sony_remove() drained the timer with timer_delete_sync() and then freed
the URB with usb_free_urb():

	timer_delete_sync(&sc->ghl_poke_timer);
	usb_free_urb(sc->ghl_urb);

timer_delete_sync() does not block re-arming, and while the URB is in
flight the timer is not pending, so the sync delete is a no-op. A URB
completion that runs after the delete re-arms the timer, and usb_free_urb()
only drops a reference -- it does not kill an in-flight URB. sc is
allocated with devm_kzalloc() and freed once sony_remove() returns, so the
re-armed ghl_poke_timer (embedded in sc) then fires on freed memory, a
use-after-free from timer softirq. This is a disconnect/rmmod race.

Poison the URB first, then shut the timer down, before freeing the URB.
usb_poison_urb() kills any in-flight URB and permanently rejects further
submissions, so a poke timer that is still pending cannot re-submit the
URB from ghl_magic_poke() in the window before timer_shutdown_sync() runs.
usb_kill_urb() would not suffice: it only cancels the in-flight URB and
leaves it submittable once it returns, so the pending timer could
re-submit it and put a fresh URB in flight over the freed sc.
timer_shutdown_sync() then drains any last callback and blocks re-arming.
The probe error path is unaffected: it is only reached before the timer
is armed.

Reproduced under KASAN on next-20260710 via dummy_hcd + raw-gadget
emulation of the GHL PS4 dongle (VID 0x1430 / PID 0x07bb): hid-sony binds
and arms the poke timer, the poke URB is held in flight, the driver is
unbound (freeing sc), then the URB is released. The completion re-arms the
timer on the freed sc, and the re-armed timer fires ~8 s later:

  BUG: KASAN: slab-use-after-free in ghl_magic_poke+0x98/0xb0
  Read of size 8 at addr ffff88810b02fd50 by task swapper/0/0
   ghl_magic_poke+0x98/0xb0
   call_timer_fn+0x35/0x2b0
   __run_timers+0x69c/0x9a0
   run_timer_softirq+0x173/0x2a0
  Allocated by task 169:  sony_probe
  Freed by task 338:      devres_release_group <- hid_device_remove (sony_remove)

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: cc894ac55360 ("HID: sony: support for ghlive ps3/wii u dongles")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: use usb_poison_urb() instead of usb_kill_urb(). usb_kill_urb() only
    cancels the in-flight URB and leaves it submittable once it returns,
    so a still-pending poke timer could re-submit between the kill and
    timer_shutdown_sync() and race the free (Sashiko review). Inline
    comment kept terse; rationale in the log.
 drivers/hid/hid-sony.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066eb..112d1deaf3f3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2431,7 +2431,9 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		timer_delete_sync(&sc->ghl_poke_timer);
+		/* poison, not kill: a pending timer must not re-submit during teardown */
+		usb_poison_urb(sc->ghl_urb);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 
-- 
2.43.0

