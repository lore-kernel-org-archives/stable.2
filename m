Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF858F094
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986561; cv=none; b=JVFWSkJTHHG+eKeozmWm8bH9QfYSYNeKByUuAcNXWI/7USp1EOMJPcY5x/sA+K0Uh03gu3ZCObkRH40rCJEE9NMMOOzONdK7FFKREv+lip0yyiYXyW9vG97LVq44/htQcTPZXJ+ATzWLTL21xBQVgoojA+zzC23gJc1Pfqc1/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986561; c=relaxed/simple;
	bh=/w/I9cjUpeD3P8mBc+iGqyix5rslnZ9Yqd4xn2z8okE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpW0fy3ENvA1RrlMf79TYMspKu7HqFwD/c8mwi+E/qj282YTu+iH9atLEKr0ndxEVVXPiYw6FDivu0f858EIxGu+xhEPzP3p0gR9Inu4H/oI9aengsGH9bxPIwDNI7aTU/6vW5tM0X4LHq39aqD5tOc9aJF9vwo7ED+EsfHNlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuqwPv1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuqwPv1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B552E1F00893;
	Wed,  9 Sep 2026 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986544;
	bh=9pQjsvq+GMkkWIlGw5XeZ7RL1vfPVFe+9cf8JVy2Jqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XuqwPv1hnFTDaqnHVA+faUr5v2cSrtdti7D0RccKLcCgbRQEbbRbwCqv39Ql90W3M
	 WshGKAzQH422V1ILfTZZOXcZ4Aq5gIqNHg+HwY6d6XUvIRgFa2Tw7ZEtWq8/pYo2ZS
	 DEAZZRRk0zTx4ci5EVkgoAd/N6pBD+MBUlX3MUR2/XzvAz0hE4tpL8zNwZ6RsaJOEm
	 a6t3eUqu1CbYG/ljmtdG8Xt5jJc0oFNc/P1fZr6n6LzrMJlib/Frn6FtVJSWdUAdxm
	 UYR4GmKPTfFRHvk9g+FBZYl2k/Gc2VWjwTlAO2P0cnrqyUkRaDjOi1IUlFwqbGRk8p
	 NX3CKUgTptFxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <wangborong@cdjrlc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ALSA: pcxhr: use __func__ to get funcion's name in an output message
Date: Wed,  9 Sep 2026 16:42:21 -0400
Message-ID: <20260909204222.3660007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-dimly-regulator-21d3@gregkh>
References: <2026090309-dimly-regulator-21d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Wang <wangborong@cdjrlc.com>

[ Upstream commit fac24b0f34c179c6ca863f5205fad42a676caf9a ]

Prefer using '"%s...", __func__' to get current function's name in
an output message.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Link: https://lore.kernel.org/r/20210731052647.141046-1-wangborong@cdjrlc.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6c97817e2059 ("ALSA: pcxhr: initialize mutexes before requesting threaded IRQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/pcxhr/pcxhr.c | 47 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index c2e4831c3a13f..1fe7e876c7fb4 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -367,7 +367,7 @@ static int pcxhr_sub_set_clock(struct pcxhr_mgr *mgr,
 		mgr->codec_speed = speed;	/* save new codec speed */
 	}
 
-	dev_dbg(&mgr->pci->dev, "pcxhr_sub_set_clock to %dHz (realfreq=%d)\n",
+	dev_dbg(&mgr->pci->dev, "%s to %dHz (realfreq=%d)\n", __func__,
 		    rate, realfreq);
 	return 0;
 }
@@ -500,7 +500,7 @@ static int pcxhr_set_stream_state(struct snd_pcxhr *chip,
 	else {
 		if (stream->status != PCXHR_STREAM_STATUS_SCHEDULE_STOP) {
 			dev_err(chip->card->dev,
-				"pcxhr_set_stream_state CANNOT be stopped\n");
+				"%s CANNOT be stopped\n", __func__);
 			return -EINVAL;
 		}
 		start = 0;
@@ -525,7 +525,7 @@ static int pcxhr_set_stream_state(struct snd_pcxhr *chip,
 	err = pcxhr_send_msg(chip->mgr, &rmh);
 	if (err)
 		dev_err(chip->card->dev,
-			"ERROR pcxhr_set_stream_state err=%x;\n", err);
+			"ERROR %s err=%x;\n", __func__, err);
 	stream->status =
 	  start ? PCXHR_STREAM_STATUS_STARTED : PCXHR_STREAM_STATUS_STOPPED;
 	return err;
@@ -571,7 +571,7 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 		break;
 	default:
 		dev_err(chip->card->dev,
-			"error pcxhr_set_format() : unknown format\n");
+			"error %s() : unknown format\n", __func__);
 		return -EINVAL;
 	}
 
@@ -616,7 +616,7 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 	err = pcxhr_send_msg(chip->mgr, &rmh);
 	if (err)
 		dev_err(chip->card->dev,
-			"ERROR pcxhr_set_format err=%x;\n", err);
+			"ERROR %s err=%x;\n", __func__, err);
 	return err;
 }
 
@@ -631,7 +631,7 @@ static int pcxhr_update_r_buffer(struct pcxhr_stream *stream)
 	stream_num = is_capture ? 0 : subs->number;
 
 	dev_dbg(chip->card->dev,
-		"pcxhr_update_r_buffer(pcm%c%d) : addr(%p) bytes(%zx) subs(%d)\n",
+		"%s(pcm%c%d) : addr(%p) bytes(%zx) subs(%d)\n", __func__,
 		is_capture ? 'c' : 'p',
 		chip->chip_idx, (void *)(long)subs->runtime->dma_addr,
 		subs->runtime->dma_bytes, subs->number);
@@ -722,21 +722,20 @@ static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 	}
 	if (capture_mask == 0 && playback_mask == 0) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : no pipes\n");
+		dev_err(&mgr->pci->dev, "%s : no pipes\n", __func__);
 		return;
 	}
 
-	dev_dbg(&mgr->pci->dev, "pcxhr_start_linked_stream : "
-		    "playback_mask=%x capture_mask=%x\n",
-		    playback_mask, capture_mask);
+	dev_dbg(&mgr->pci->dev, "%s : playback_mask=%x capture_mask=%x\n",
+		    __func__, playback_mask, capture_mask);
 
 	/* synchronous stop of all the pipes concerned */
 	err = pcxhr_set_pipe_state(mgr,  playback_mask, capture_mask, 0);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
+		dev_err(&mgr->pci->dev, "%s : "
 			   "error stop pipes (P%x C%x)\n",
-			   playback_mask, capture_mask);
+			   __func__, playback_mask, capture_mask);
 		return;
 	}
 
@@ -779,9 +778,9 @@ static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 	err = pcxhr_set_pipe_state(mgr, playback_mask, capture_mask, 1);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
+		dev_err(&mgr->pci->dev, "%s : "
 			   "error start pipes (P%x C%x)\n",
-			   playback_mask, capture_mask);
+			   __func__, playback_mask, capture_mask);
 		return;
 	}
 
@@ -890,7 +889,7 @@ static int pcxhr_hardware_timer(struct pcxhr_mgr *mgr, int start)
 	}
 	err = pcxhr_send_msg(mgr, &rmh);
 	if (err < 0)
-		dev_err(&mgr->pci->dev, "error pcxhr_hardware_timer err(%x)\n",
+		dev_err(&mgr->pci->dev, "error %s err(%x)\n", __func__,
 			   err);
 	return err;
 }
@@ -905,7 +904,7 @@ static int pcxhr_prepare(struct snd_pcm_substream *subs)
 	int err = 0;
 
 	dev_dbg(chip->card->dev,
-		"pcxhr_prepare : period_size(%lx) periods(%x) buffer_size(%lx)\n",
+		"%s : period_size(%lx) periods(%x) buffer_size(%lx)\n", __func__,
 		    subs->runtime->period_size, subs->runtime->periods,
 		    subs->runtime->buffer_size);
 
@@ -998,12 +997,12 @@ static int pcxhr_open(struct snd_pcm_substream *subs)
 	runtime->hw = pcxhr_caps;
 
 	if( subs->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
-		dev_dbg(chip->card->dev, "pcxhr_open playback chip%d subs%d\n",
-			    chip->chip_idx, subs->number);
+		dev_dbg(chip->card->dev, "%s playback chip%d subs%d\n",
+			    __func__, chip->chip_idx, subs->number);
 		stream = &chip->playback_stream[subs->number];
 	} else {
-		dev_dbg(chip->card->dev, "pcxhr_open capture chip%d subs%d\n",
-			    chip->chip_idx, subs->number);
+		dev_dbg(chip->card->dev, "%s capture chip%d subs%d\n",
+			    __func__, chip->chip_idx, subs->number);
 		if (mgr->mono_capture)
 			runtime->hw.channels_max = 1;
 		else
@@ -1012,8 +1011,8 @@ static int pcxhr_open(struct snd_pcm_substream *subs)
 	}
 	if (stream->status != PCXHR_STREAM_STATUS_FREE){
 		/* streams in use */
-		dev_err(chip->card->dev, "pcxhr_open chip%d subs%d in use\n",
-			   chip->chip_idx, subs->number);
+		dev_err(chip->card->dev, "%s chip%d subs%d in use\n",
+			   __func__, chip->chip_idx, subs->number);
 		mutex_unlock(&mgr->setup_mutex);
 		return -EBUSY;
 	}
@@ -1078,7 +1077,7 @@ static int pcxhr_close(struct snd_pcm_substream *subs)
 
 	mutex_lock(&mgr->setup_mutex);
 
-	dev_dbg(chip->card->dev, "pcxhr_close chip%d subs%d\n",
+	dev_dbg(chip->card->dev, "%s chip%d subs%d\n", __func__,
 		    chip->chip_idx, subs->number);
 
 	/* sample rate released */
@@ -1569,7 +1568,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 	/* init setup mutex*/
 	mutex_init(&mgr->setup_mutex);
 
-	mgr->prmh = kmalloc(sizeof(*mgr->prmh) + 
+	mgr->prmh = kmalloc(sizeof(*mgr->prmh) +
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),
 			    GFP_KERNEL);
-- 
2.53.0

