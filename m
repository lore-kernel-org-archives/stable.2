Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DE47A880
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257455; cv=none; b=V0pa01FV4idd5osufkSuVvDE5AMWr2NVJjhZlcYyvFfUV7Ronc0lA/bdBKFxTWBj+7rz/mNmxiomiNNcK5zd8fDfmdbGPwnV8DGueDNqICSV8DVEmbplGaQG2HJyF5/JwhPwLqKaa9/OVihlnMUBe3IhZMUzXhSnuydZ/ZbCuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257455; c=relaxed/simple;
	bh=m162thZBVhyy0wZcbSN805/eQ6omc+etcke2hS+teWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZS689hsDZsTpdw0FSGDDZRNejAcSULIal3YVioSXTH96rB6Fly/0a813RwOzY4Exifmv8APps+PXlmjJFYQkaxC5QlUjhz95N/14Dj0Eug/ZY0S0ZIgC3mC8L5k5TaoYlDfyg0niJWMBUQP6qom38ehnvtO2azr9adLGd/nHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiR5Ssdu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiR5Ssdu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956869750eso30759525e9.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788257451; x=1788862251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8Xha6Xgz2f3NrS4LysABMsL2JkXYHN9WzLYcNH8QJU=;
        b=DiR5SsdujQZmBWO9jMZIY2pP3j+2rErJobPylV6zLUt3BO9ULK9x3j6WJFHgjc/u0c
         NSfWpKugcMVPvcCaPZILw6jN9nJkv9eTxkmZgmv8rWx/vm/l8cLKsYLE25Tsdp6x0MqP
         NyXdbiU983USE/Wt89Hv5gUowKwjH9P/NLAsqEdlSM4aLPhT/8qp62xoIOiIYRebb7CK
         iuhhdBCvTmN+LHOT1bFU5v3xddgXAu/6Do0dPsZDKtjcO/pzRX9gF7StoQPCUhvO6KHl
         GSiL1zMP1W6/aD9sD2gqcohyUeEQHt6ATOdPxJrKYuYJVHVLojJlTLVl3SaZA7K/lJ2v
         zGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257451; x=1788862251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8Xha6Xgz2f3NrS4LysABMsL2JkXYHN9WzLYcNH8QJU=;
        b=i6DdJsFKbw5u5zBWDMRgUH4QJ+MrZt0n1mVOjhaZlU0KUSGgtCg+qGHo/4HcT38VbC
         ydUYgJ4N8eDtEoUsQLY4+800S8Lbp/utrhIF4M8F5jVQPFVTLOJV9LVcOR3JiKQbtoY6
         5HnRSPjP/mkPDbV2fkMuJNfCy446W6i2dpVZXMxHNTPJtbytVoI09Ig8prZB/QPP8opL
         pmnHkwWpixdZNFTAQezzcwDwTjcGItZXKOuAWiLBQni/ggOmSgrWOlnWprcu6uS0ODmF
         vGk+KSHsKWYTAf8Q4Z2/2xSGsttqP0l1wJ7sClesgK68xSEkvDEeQd3yXBu5yA/biZhB
         RNGg==
X-Gm-Message-State: AFuF++lGf97SnIQQW6B/+LYlBxf6sReCH/zGLJ/zxh5VtEdlMN5SBB11
	PxzBnU4EnNaXQixfA0o3K3jY+KNtevNuN0/alRxpjdCao+mVvRpoarfJr0NWyawm
X-Gm-Gg: AR+sD139EboCB6/MpSOFvN1fuLTHxFPhKcmmM6HcwM+Ny1/8ptVIwIZfrUPqeKxRWgH
	TuRNrSjOVPd3mgueFTy5SU24+LzBJsxyPqX8YfLHr6F1Rl23jr5Clmtrlz7NL31yCBX65kQ/p8W
	RdOqyhR3RrqV88mpi8rgsTH2NyZ3w/tflKIYhHpJvKeYODtreInSHjeZn23WW1rh3z4SMfo3RXD
	6ue15EDTmkGDG0pg/m+aB6yeiFlo9RnLXRq0HYn/IP08u/zCIbg/FAm5YkjAhucziUfhSWRqnBc
	N0Gs5B39EEz+IQJvKSxdoPfoaGa+h87shtSd8pWXuvoxE7yhMJUbJegmi6cWcH0OjIVGXt3QweZ
	Q7UyWkYtMOfTaHxeg0Cz+BE5KzcDfDwEvYBXpdPzq9IcxJO2xHoBY5efsma4k1GfEYgjV92zsYp
	6ntbFzu0rdFc02azaW/suRWtSnUpqan4aOQmhVRGX3VDO53Pb+LXn4ICnZje67A9ZpasxHukZm2
	XNmYMfOpZbLeD+6hhGtIUU6rCfog7BGvuHywXmOKcgUbojBtcqLesTJ5Kt5qqw1nGNeIqRppWyf
	LxnMpnTfziuGRovlFLNuA2Lt74g3H4nHJnwZaxAMsovsNjFOoCBTpnpwYtVe2O93VB0ogd3rpim
	izw==
X-Received: by 2002:a05:600c:c08a:b0:49c:e1b5:b2bf with SMTP id 5b1f17b1804b1-49ce1b5b2c3mr19468445e9.0.1788257451132;
        Tue, 01 Sep 2026 03:10:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce089c2sm56812265e9.2.2026.09.01.03.10.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 03:10:50 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15.y] ALSA: aloop: Fix racy access at PCM trigger
Date: Tue,  1 Sep 2026 12:10:41 +0200
Message-Id: <20260901101041.82052-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 826af7fa62e347464b1b4e0ba2fe19a92438084f ]

The PCM trigger callback of aloop driver tries to check the PCM state
and stop the stream of the tied substream in the corresponding cable.
Since both check and stop operations are performed outside the cable
lock, this may result in UAF when a program attempts to trigger
frequently while opening/closing the tied stream, as spotted by
fuzzers.

For addressing the UAF, this patch changes two things:
- It covers the most of code in loopback_check_format() with
  cable->lock spinlock, and add the proper NULL checks.  This avoids
  already some racy accesses.
- In addition, now we try to check the state of the capture PCM stream
  that may be stopped in this function, which was the major pain point
  leading to UAF.

Reported-by: syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69783ba1.050a0220.c9109.0011.GAE@google.com
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260203141003.116584-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Karl Mehltretter: open-coded spin_lock_irqsave() instead of scoped_guard();
  used snd_pcm_running() instead of cruntime->state; dropped the access-mode
  comparison and notification (462494565c27, e299a9fd433f, cdac6e1f7164);
  kept the stop_count handling from the e5c33cdc6f40 backport. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
e5c33cdc6f40 ("ALSA: aloop: Fix peer runtime UAF during format-change
stop") went into 5.10.y (83bd62fa9620) and 5.15.y (345c24b2bcf0) without
this prerequisite, so stop_count is only taken after the unlocked peer
lookup and format checks.

The 5.10.y and 5.15.y backports are submitted as separate mails with
identical source diffs. The 6.1.y and 6.6.y branches need both upstream
fixes and are handled by separate two-patch submissions.

Tested on v5.10.268 with KASAN under QEMU; a kprobe widened the race.
Vulnerable kernel, probe at loopback_trigger+0x679 after the peer-runtime
load: KASAN UAF, then a NULL dereference and Oops. Fixed kernel, probe at
+0x93, placed just inside the new lock boundary so the close contends on
cable->lock: no KASAN report or Oops.

Functional A/B, same initramfs: all 4096 captured frames matched
byte-for-byte and control/mismatch handling passed. A prepared-but-idle
capture remained PREPARED when mismatched playback started instead of being
forced to DRAINING, matching upstream.
aloop.o builds on v5.10.268 and v5.15.219. The patch also applies unchanged
to v5.10.269-rc1 and v5.15.220-rc1.

 sound/drivers/aloop.c | 99 ++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 314ced32efbbc..3901f52164933 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -323,56 +323,75 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
+	struct loopback_pcm *dpcm_play, *dpcm_capt;
 	struct snd_pcm_runtime *runtime, *cruntime;
 	struct loopback_setup *setup;
 	struct snd_card *card;
-	int check;
+	unsigned long flags;
+	bool stop_capture = false;
+	int check, err = 0;
+
+	spin_lock_irqsave(&cable->lock, flags);
+	dpcm_play = cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
+	dpcm_capt = cable->streams[SNDRV_PCM_STREAM_CAPTURE];
 
 	if (cable->valid != CABLE_VALID_BOTH) {
-		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-			goto __notify;
-		return 0;
-	}
-	runtime = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->
-							substream->runtime;
-	cruntime = cable->streams[SNDRV_PCM_STREAM_CAPTURE]->
-							substream->runtime;
-	check = runtime->format != cruntime->format ||
-		runtime->rate != cruntime->rate ||
-		runtime->channels != cruntime->channels;
-	if (!check)
-		return 0;
-	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
-		return -EIO;
+		if (stream == SNDRV_PCM_STREAM_CAPTURE || !dpcm_play)
+			goto unlock;
 	} else {
-		/* close must not free the peer runtime below */
-		atomic_inc(&cable->stop_count);
-		snd_pcm_stop(cable->streams[SNDRV_PCM_STREAM_CAPTURE]->
-					substream, SNDRV_PCM_STATE_DRAINING);
-		if (atomic_dec_and_test(&cable->stop_count))
-			wake_up(&cable->stop_wait);
-	      __notify:
-		runtime = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->
-							substream->runtime;
-		setup = get_setup(cable->streams[SNDRV_PCM_STREAM_PLAYBACK]);
-		card = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->loopback->card;
-		if (setup->format != runtime->format) {
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-							&setup->format_id);
-			setup->format = runtime->format;
+		if (!dpcm_play || !dpcm_capt) {
+			err = -EIO;
+			goto unlock;
 		}
-		if (setup->rate != runtime->rate) {
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-							&setup->rate_id);
-			setup->rate = runtime->rate;
+		runtime = dpcm_play->substream->runtime;
+		cruntime = dpcm_capt->substream->runtime;
+		if (!runtime || !cruntime) {
+			err = -EIO;
+			goto unlock;
 		}
-		if (setup->channels != runtime->channels) {
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-							&setup->channels_id);
-			setup->channels = runtime->channels;
+		check = runtime->format != cruntime->format ||
+			runtime->rate != cruntime->rate ||
+			runtime->channels != cruntime->channels;
+		if (!check)
+			goto unlock;
+		if (stream == SNDRV_PCM_STREAM_CAPTURE) {
+			err = -EIO;
+			goto unlock;
+		} else if (snd_pcm_running(dpcm_capt->substream)) {
+			/* close must not free the peer runtime below */
+			atomic_inc(&cable->stop_count);
+			stop_capture = true;
 		}
 	}
-	return 0;
+
+	setup = get_setup(dpcm_play);
+	card = dpcm_play->loopback->card;
+	runtime = dpcm_play->substream->runtime;
+	if (setup->format != runtime->format) {
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &setup->format_id);
+		setup->format = runtime->format;
+	}
+	if (setup->rate != runtime->rate) {
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &setup->rate_id);
+		setup->rate = runtime->rate;
+	}
+	if (setup->channels != runtime->channels) {
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &setup->channels_id);
+		setup->channels = runtime->channels;
+	}
+
+unlock:
+	spin_unlock_irqrestore(&cable->lock, flags);
+	if (stop_capture) {
+		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
+	}
+
+	return err;
 }
 
 static void loopback_active_notify(struct loopback_pcm *dpcm)
-- 
2.53.0
