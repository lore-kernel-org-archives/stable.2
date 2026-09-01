Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9437F32A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252425; cv=none; b=bVg2Un/U5BR39hIfZX+6kBhicToWRSchbJvT21gbR+pNP5/S+k0CniAVyPJpl5ov1JtD/q16DvhORh8HWE3oJz4H96vvKeAe5S238Ui5GFMz3B+bt6LGoRLRF0cICe0Posx2IvFzMPKA+EzJwqnP45so9UGEJvEl3pRvRGQrBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252425; c=relaxed/simple;
	bh=wiy8pO7v9iI1/7qOJcZeis9iXMhYLOorLIS5PCg4eBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfXMddsAkDMbIRoSPzvtwONpAX0oIHsb1e7ulV3McwJC9rkREKTQiRWi2OlKVcw0KbPvTPjVh6otYqsk/KmU3BwoDKnAki5BomEDWvxkQ4W6W/Zoel87vgjQruVooc4zIkER60IqZNsFunkf8tUx5nOqfh6jcBZM/h3ajWqYx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF/nWHXF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF/nWHXF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so31846275e9.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252422; x=1788857222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VTk2I9UAlwFcSdMLy483yatScQNtKnIT1avRSc59jAI=;
        b=GF/nWHXFzOuCxuQv4YvkEWRQFPk5cLhoTOMVYKxJbqsicqjh0W8vtnttXwkoRZkqBe
         +qTqyUOCcI9ZJgbUI9BkT6CFFGB+/HDV+/lN2LAioAN0VWJqAckEY5WDF/gUyXQC01pP
         gGB0OTI5T1YdW5OLSmqKb4Z39FqX9rwBv7Qiar8H6munCzOX5/NuclHbTkP0ua77lJ62
         UrrOnUsiRQ6btTK8BC8T+ChNNlQZDHSivqMjE6h3CL9tokz+fUtfyGXFpta6RspCWTcB
         tfGFUCexYDNUNwcIusV21/O7HaMvd61AdaA3kTUVphQYD4rmIrZHWBMOfdexTYzeMdgb
         qzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252422; x=1788857222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTk2I9UAlwFcSdMLy483yatScQNtKnIT1avRSc59jAI=;
        b=rDyp6ZFhFLN2K1dhupn3B7ox75QbdWhrYjaLUMjWXrSLjFX0GHjiK38zRLNYI5PJ23
         UiTF1dSs56EDCFoW7mbZ7QExsxrFq/oRI6y2LfF9AQyFX8SJCud5XuR6vQ2CJzuyZLSc
         tfgMJ+wLz310MeRpOKzFzSOYlM47G8Ewm4yNLGarHvKDaQHqWYgFyqezyaeimZh/kzeP
         nF2Du6P+r5T1uL0hpWZyrA3mbe581yoUEZBFGlgw4fXb1t69nTO6y3pPKkr0aaXQRxjV
         kqmoZW8xjpdNEZ6o1FpHs1KOA2TTiJ0nin2iVhRdEPAiUj7oid1Xgw9ry6fju3CA9gnC
         2wFw==
X-Gm-Message-State: AFuF++knazwwRn6DJzNTIXXbmww9Tu8Le0xBYM9j3fqJrQsf8mYjdUW0
	i58SUDuoYrkzmZGT2QcoaqBIoLe7m8NbdlEyqu7oNDgNSos9FpmFnoWjcyqoXw9T
X-Gm-Gg: AR+sD101Fc9ICt0WDKmx15Hh6aiCmDlhRb6rhLYXbYXTDM7tS/X6FR8mFL1V0oHx1mc
	7UwJ2Gtd1w1Kz9mDi+FtQceAlurvXSiA4XnSZfEfBdLEspX4SLgJ6IkoQ77wp+v9SsPGSQnT+iG
	5Q/mP1ZvpjjRwwwz9nN4Tg6+SJu6BF0yFU2/R/nYI3J0VetNhwH/K8+XYD4JdmYERdb+VBLYNRy
	kQh/HmnJcnwTEBwOD7rIp7XsMw84rww2P6shisqMX0TjaZHwgGwR1Tz0z/1AxNqEGHqekUSUM9A
	7gqwrL+g4DuBMQRd9Tj4Mjh6jtFhEPb9NVRr5Ws1oKQSwSsvd8XD6vYqSMNPmu60VrCCzDdXCLD
	cD3Gwzvd2lXLWady1OSF/pPZ4GQoMy75EzuhiN7DSg/NxVCqCSm7UEzf3wg1W3ktqE/Z2mlKoCY
	35TmrXdL8YSvzHCB9qQjCKzi4un+wfD9aJYuv2R9NCZXgqnhq+FaGP5gLIX2rCy8iE21nq5SBs4
	xIyPbR8OadB4309XDOrGT4rSs0FalNpuhtRITAiwDOUD506tyzChVBG4BeCThk+wMb7Qz8ym23Y
	WbGchisFGVkQeky2ilDJFolr72VUhElNGLjCp2v20hyb94q5c2LZDpmQsxBi+MJpP1o=
X-Received: by 2002:a05:600c:a00d:b0:49a:252d:52f5 with SMTP id 5b1f17b1804b1-49cdc45253dmr125349725e9.11.1788252422042;
        Tue, 01 Sep 2026 01:47:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm727447725e9.2.2026.09.01.01.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 01:47:01 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: aloop: Fix peer runtime UAF during format-change stop
Date: Tue,  1 Sep 2026 10:46:37 +0200
Message-Id: <20260901084637.66106-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260901084637.66106-1-kmehltretter@gmail.com>
References: <2026050445-detention-cussed-a8c0@gregkh>
 <20260901084637.66106-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit e5c33cdc6f402eab8abd36ecf436b22c9d3a8aff ]

loopback_check_format() may stop the capture side when playback starts
with parameters that no longer match a running capture stream. Commit
826af7fa62e3 ("ALSA: aloop: Fix racy access at PCM trigger") moved
the peer lookup under cable->lock, but the actual snd_pcm_stop() still
runs after dropping that lock.

A concurrent close can clear the capture entry from cable->streams[] and
detach or free its runtime while the playback trigger path still holds a
stale peer substream pointer.

Keep a per-cable count of in-flight peer stops before dropping
cable->lock, and make free_cable() wait for those stops before
detaching the runtime. This preserves the existing behavior while
making the peer runtime lifetime explicit.

Reported-by: syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8fa95c41eafbc9d2ff6f
Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Cc: stable@vger.kernel.org
Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260424-alsa-aloop-peer-stop-uaf-v2-1-94e68101db8a@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ used scoped_guard(spinlock_irq) instead of guard(spinlock_irq) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Karl Mehltretter: 6.12.y commit 03f52a9c1704 applies to 6.1.y/6.6.y
  unchanged; identical patch-id. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 sound/drivers/aloop.c | 44 +++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 67bbadcec02b0..64870381d66ec 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -98,6 +98,9 @@ struct loopback_ops {
 struct loopback_cable {
 	spinlock_t lock;
 	struct loopback_pcm *streams[2];
+	/* in-flight peer stops running outside cable->lock */
+	atomic_t stop_count;
+	wait_queue_head_t stop_wait;
 	struct snd_pcm_hardware hw;
 	/* flags */
 	unsigned int valid;
@@ -347,8 +350,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 				return 0;
 			if (stream == SNDRV_PCM_STREAM_CAPTURE)
 				return -EIO;
-			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING)
+			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING) {
+				/* close must not free the peer runtime below */
+				atomic_inc(&cable->stop_count);
 				stop_capture = true;
+			}
 		}
 
 		setup = get_setup(dpcm_play);
@@ -371,8 +377,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 		}
 	}
 
-	if (stop_capture)
+	if (stop_capture) {
 		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
+	}
 
 	return 0;
 }
@@ -1004,24 +1013,29 @@ static void free_cable(struct snd_pcm_substream *substream)
 	struct loopback *loopback = substream->private_data;
 	int dev = get_cable_index(substream);
 	struct loopback_cable *cable;
+	struct loopback_pcm *dpcm;
+	bool other_alive;
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable)
 		return;
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		spin_lock_irq(&cable->lock);
-		cable->streams[substream->stream] = NULL;
-		spin_unlock_irq(&cable->lock);
-	} else {
-		struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-		if (cable->ops && cable->ops->close_cable && dpcm)
-			cable->ops->close_cable(dpcm);
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
+	scoped_guard(spinlock_irq, &cable->lock) {
+		cable->streams[substream->stream] = NULL;
+		other_alive = cable->streams[!substream->stream];
 	}
+
+	/* Pair with the stop_count increment in loopback_check_format(). */
+	wait_event(cable->stop_wait, !atomic_read(&cable->stop_count));
+	if (other_alive)
+		return;
+
+	dpcm = substream->runtime->private_data;
+	if (cable->ops && cable->ops->close_cable && dpcm)
+		cable->ops->close_cable(dpcm);
+	/* free the cable */
+	loopback->cables[substream->number][dev] = NULL;
+	kfree(cable);
 }
 
 static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
@@ -1216,6 +1230,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 			goto unlock;
 		}
 		spin_lock_init(&cable->lock);
+		atomic_set(&cable->stop_count, 0);
+		init_waitqueue_head(&cable->stop_wait);
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source)
 			cable->ops = &loopback_snd_timer_ops;
-- 
2.53.0
