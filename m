Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D16479884
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254009; cv=none; b=TzWncu3IwVFtnnhGjwO55nqLixfB6CSd2hpdcAypqxYIIkw9OBBW2j9qz1E/8n5sOLTFBP6VRmqc7JrdfpRk06OKCzbRKgvg7WQOxoIym2VNZUYXhEshUhr/JT+wvFrOkrZjUMcosMoiPpwhVpxdUwT1r94btPrFkGDWZcwhk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254009; c=relaxed/simple;
	bh=5TXH4LC7ZsK53s8hTAxjUirx2sEYY+ExHWiOtAZax1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLuWoB+zJpZ8rUCb2mvx1naZ+Ytp9PNKC4YsT7l8185Uq399IRa8vFI58s/RpTxjlQ0RSD7Sp4yju+ZID23CA0RgjPJAcWDH8IL2Znu8hAsNdasik1Ek1ncJxx0Y6BLjZJ4FhfQ0WYDrxDOUgSljwgwbBZzWjoqaaOEFc2361vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTVC+N+l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTVC+N+l"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49557167508so48146325e9.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254005; x=1788858805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6/zRLtsUSMddk2IzAgWLfFXWAC9OmiNCU9k76PvNK4=;
        b=KTVC+N+lmN5KJcwrfqShoqBht30i/ldO42Hk4YXOyFEqc7l1KbwfwvGTc6tJGWzxO/
         HrCw8k/KeaFULbtM/AuRJ260xcvBXFyC52LL+fxiE5+iN9C4mekdHDFze7kWZn+jeu2W
         5bYpQM2sjkVWGAVelCuieVBmilz5n0PkTHYH7EKq2Icrk9347KORMEDHQd6n42MGmxMH
         ZvGnpLp79fDyNrSYFhfB0GgR29y7lKY89kjP0iXQFby6PBJQDK/7o94Luht7AwGXytrE
         Lf84/g3tpsZM3JzfB6K6c5OrLQWKzSilpWBqwjmeVYRqfUFINhaWs96RkegcHDfhL210
         4POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254005; x=1788858805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6/zRLtsUSMddk2IzAgWLfFXWAC9OmiNCU9k76PvNK4=;
        b=e1hpK6K4tsWMaoTgfH1Es64To9Sz7c0UDl8YbRtCJtQqeTzI8tAX565IS50eCZqCFy
         n3s51m0G46g6NMe+phPzbkvyB4nQFCFw1CvPehNCfm6aT/pOrGekwijUxPF186NqKzaF
         tiUsqBia6GrP+7avn7nxFQO41Zy48IO9FpWYq4Tk4isEgEDThd4OJ2R9J2JSNleVVZRi
         tc/U5j9/7u7wM0AXMz6q45dJQR21tc2eBTuj36ATJAUaooX6mfGq+AVAdDe+Utu81CjK
         n7XyttAi4QkRq3/EJZFWPdMKkeiB+gzpq6VX+91ohZuC5J4S3rS8fOzbOmoDiZV4HgPo
         t8cw==
X-Gm-Message-State: AFuF++mKHzXJxoIIhpzU3QAzAelzCG3tCmwwLzgggrSE2ofFvMNBC6yz
	hpL5tm6jiOJP2mHT23SNq2sd4Q9xD3g37DA05GfCBHSConVqtEOW574YS+BlncLi
X-Gm-Gg: AR+sD13Ia4r8341oqlg4PdoAj+hF90mmuALvGfZQrB0wEKnMqPGHsd3BCgZCI6BXwbO
	ApWIir2ZUzoNs4vtvsdCutpEvGdCx9TzEpn4XJ9o5LL3KC5hd6fWntm5Jhg3V7rn/qlIPsPvMF/
	n75nr8YjA3B5AhbNbHfUDMfpniG8zazQL2kCsIrf4NH8ZZ0r0YhI6VjGHAvfgTpLEvF1DNwHd3I
	aJImas3+7dj3wCsMSnk6QVi8WhdWdZaOX8+843X99h3YTgl0dIZ/N11UjMVAXcvYu1NDEQcKJu/
	Q7CaDj+PMsLlNUq8UX5C+ijZx1K9PDhrERGojpEfiCrw0bmB3T5c2YUwUS7Av3frKfwrw4Sk0au
	/ecx6/PONF+ppVd2LHS+f3cQtCdZjbnkzkmukUr1HiK8UhxhIL/jOF1ZIkKle+X4uafvnNmKbPd
	TaubzQouVTI7X2uq0VRHY6YAJdGoRVhdy1kIFXr9VefaLRkB4IplNViZWYXdB54RqcmxbAf96mi
	XoxOX8uwb7NqiiXvu4sK+hZMv6qMI8qXBItWVHIOiDP9ZgO2Q8ioDoZYiarPo3wamNbSxQxahC8
	zP5t+7kXxfjOc+/KvGHW7xmBA9eDxTZavK6lFKz2TBFh6W3N2u0D1IUDsAO90/BpZYQ/KFpYw6+
	gAw==
X-Received: by 2002:a05:600c:3b2a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cdc57d1d1mr105123535e9.16.1788254004957;
        Tue, 01 Sep 2026 02:13:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d781bcsm3378291f8f.26.2026.09.01.02.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 02:13:24 -0700 (PDT)
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
Subject: [PATCH 6.1.y 1/2] ALSA: aloop: Fix racy access at PCM trigger
Date: Tue,  1 Sep 2026 11:13:01 +0200
Message-Id: <20260901091302.66860-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260901091302.66860-1-kmehltretter@gmail.com>
References: <2026050445-connector-rebuff-f713@gregkh>
 <20260901091302.66860-1-kmehltretter@gmail.com>
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
