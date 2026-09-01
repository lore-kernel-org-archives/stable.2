Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540547279C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252423; cv=none; b=H41fBG0b5/Q8p0IGOicvQxryHiUM64LQzB+dnWFvQkdtsaHdo+uPxUHlBUWK4gFVss8fZUfy37KpIaxzOU8X7DHkKHT+kRUqGEhnNNMDyqWjtat17sqpbVOTRTzMrgnWYEarLCkU/pEafUIuOolIrSxyB1arY9JN6vTqzL/Ig9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252423; c=relaxed/simple;
	bh=5TXH4LC7ZsK53s8hTAxjUirx2sEYY+ExHWiOtAZax1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6e0XfNMEfbsU7NONCQ7N9srrMuU38b/EVhB6itKvry6wpP0y6bmMljvS1KtR/wctRjkwojyvz1tu06MVzm80/SZAwMx2JuspcBNAIluE7I+bpbL37FkC7ASAByVg5sxOKRGJQUeMBloZO4gn990/shet4/cMe6f68HqT2SIQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnjBW/RA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnjBW/RA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e2fdf6ebso3715926f8f.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252420; x=1788857220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6/zRLtsUSMddk2IzAgWLfFXWAC9OmiNCU9k76PvNK4=;
        b=TnjBW/RA2zSFodgiNB8aSNyHlqNXg1We4Ly2GPGon/3yJ892g9mNcpHoawILxMLqf5
         ZcplLdvBBfrdLKnIHPdNJZu2X9BK5p64DnHHxd7Hh81TXZaPKbtCA+SwvVnuo9xMj3w4
         bnO/8hjUZU/WjQpKf+5bcnbjmvBdWHvD6kmUk3PFMNNuSqW8/Pli29HpzQqHG5a2tiod
         +M2IsiBaS6wV9W7NMEVV8xWJXrWsBkPJUqMHpWPuUyYelLu6KlGwKQq5drPdZ8yej5lx
         DlkDJ2htZ8zI0OTnEndEafrSAlPMl2jfUIAmwtmmfZjD148+5ndVNECSlkQsyVcIQ86B
         QGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252420; x=1788857220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6/zRLtsUSMddk2IzAgWLfFXWAC9OmiNCU9k76PvNK4=;
        b=UZO6mSXMEuXB/N59ScDO3+XF1/nAqzhbMNdz+u9wzD7d5dDiXZQceS0Vt/UnaJVuPT
         SDNiRAlnpSD7rBPO1icanWDdY0beYl1hg26bH468swdxyCeZN7T/3kuL5BhTnGiUVo/I
         1zsJBV3hJ55QT21mO9zRqwgw4rN1ZjA9BYIypDHr/uOkZCh1FT6t0cFVNb6lpsTU1/Rc
         8iOHEseKihC4M317pqI9JcUbPFg8tspcaZD+4EaTibWGI4m2PkSgz1Ffpf2gjnnSnfoV
         thpLHxp1jIAMhNjnqx0i401lVJoY6FnxejUwqtUy2FzVAHjc2Dxjn940qg1yzumX/xJ/
         gLLw==
X-Gm-Message-State: AFuF++nRv7B4wSCHaudCtziUwM10NIn4FkwbjrhFpC6QpDAe/zAQeF+s
	wirQvIyxrd88IjzpsW2l3rV4SCo/ztvkgpewLbJmqDORu6GLwJKXCl91y6KnGOpV
X-Gm-Gg: AR+sD12VroAVAr3Uhej0iuU5jDIIb9Hh4ljwS8p6f7ca1eCreYQEn+/Vshca8HFoKyG
	RGbUGFwZZ2PJggScTj5G5y6ivSe4DnskdcK4ybzMQlhWn00YMUBkIZoS1NJR3Qr2VguR+DMWSqJ
	7ydvndkQhtLxaYPnY4aHnhE/OXiLDyGc59bbfIOn/VD82idS9Hggqj941aicKyfMIImEm7PejkD
	gniViNtEDXbVn2o6K10+DMHvbx1+3ZmRdu42MgNf2a34bK4Nh9+TV64tXMS8phzSjtEnSb9Ogaa
	3FPu4Mfi1OAGvswKOUS0sB+4ZlqaNZ/EpOJIsJvbcNw6Bst2QSaqXVMYAr4jrr73T3g8qwxJ4Bc
	hhCZEcVHES44BQNuVJdiWy3HgOl8WS6OXdNYaJADw4sM3+93n/fYE2a8eb2ajV1kcoY1qLk4/4D
	5uGQSdUryKTbD1hlAYKCB2RKasHG6Fxkg43sMTSomrk5qmDZh4LO3HyV8fzc1wcC7psiKeVAp2S
	vf+JJizyQXq7Q+44uhtlLOv8U9+Rpt9gV1r+RY3goktzuuYE7kdC0flY9xivrRRebY5H+jxzYaT
	JAk6gCd2Z/JOa/s+ts87KOKz9pvu9g1mJZJnNTdYq3yD/+piSAT7UBHlYQKMK/cQK+omeRr+nB8
	nQQ==
X-Received: by 2002:a05:600c:64c6:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-49cdc558470mr120027825e9.11.1788252419521;
        Tue, 01 Sep 2026 01:46:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm727447725e9.2.2026.09.01.01.46.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 01:46:59 -0700 (PDT)
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
Subject: [PATCH 6.6.y 1/2] ALSA: aloop: Fix racy access at PCM trigger
Date: Tue,  1 Sep 2026 10:46:36 +0200
Message-Id: <20260901084637.66106-2-kmehltretter@gmail.com>
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
[ Karl Mehltretter: dropped the access-mode comparison and notification
  (462494565c27, e299a9fd433f, cdac6e1f7164). ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 sound/drivers/aloop.c | 58 +++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index a38e602b4fc60..67bbadcec02b0 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -319,35 +319,41 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
+	struct loopback_pcm *dpcm_play, *dpcm_capt;
 	struct snd_pcm_runtime *runtime, *cruntime;
 	struct loopback_setup *setup;
 	struct snd_card *card;
+	bool stop_capture = false;
 	int check;
 
-	if (cable->valid != CABLE_VALID_BOTH) {
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
-	} else {
-		snd_pcm_stop(cable->streams[SNDRV_PCM_STREAM_CAPTURE]->
-					substream, SNDRV_PCM_STATE_DRAINING);
-	      __notify:
-		runtime = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->
-							substream->runtime;
-		setup = get_setup(cable->streams[SNDRV_PCM_STREAM_PLAYBACK]);
-		card = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->loopback->card;
+	scoped_guard(spinlock_irqsave, &cable->lock) {
+		dpcm_play = cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
+		dpcm_capt = cable->streams[SNDRV_PCM_STREAM_CAPTURE];
+
+		if (cable->valid != CABLE_VALID_BOTH) {
+			if (stream == SNDRV_PCM_STREAM_CAPTURE || !dpcm_play)
+				return 0;
+		} else {
+			if (!dpcm_play || !dpcm_capt)
+				return -EIO;
+			runtime = dpcm_play->substream->runtime;
+			cruntime = dpcm_capt->substream->runtime;
+			if (!runtime || !cruntime)
+				return -EIO;
+			check = runtime->format != cruntime->format ||
+				runtime->rate != cruntime->rate ||
+				runtime->channels != cruntime->channels;
+			if (!check)
+				return 0;
+			if (stream == SNDRV_PCM_STREAM_CAPTURE)
+				return -EIO;
+			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING)
+				stop_capture = true;
+		}
+
+		setup = get_setup(dpcm_play);
+		card = dpcm_play->loopback->card;
+		runtime = dpcm_play->substream->runtime;
 		if (setup->format != runtime->format) {
 			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
 							&setup->format_id);
@@ -364,6 +370,10 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 			setup->channels = runtime->channels;
 		}
 	}
+
+	if (stop_capture)
+		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
+
 	return 0;
 }
 
-- 
2.53.0
