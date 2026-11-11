Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418953;
	b=GLhE1B1/6r+R9su9S5bXJeUJxHtpnnrwf+t5aQmNitBLlTsc3VAGP5isWKg4DIMWADNf
	 tdyMkhCeqobF/TrkDi91WKyINai/vMBH9lOmYHSURpV7d9TlCLbOC9SSL1ESO5bA729Zo
	 uvsWoUTBJZi6K9nFSQjCfZuQzup9i5K0D7cbWC/Szy90Q9CTn/tm7d0uSKOF3M2Dyeqtf
	 tlxZ7ztaXj+iQu9xzCAfRe3iRZosQqaEN2udNG2LLr1up2uSrwq6GNbEq3rCdwdUmr3OP
	 tsABhQ2IC+jNbVZrHzg0TgLi6WQ5OsBRdJhH+HLftNXH04jxlD79p690qLEndnBXofg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ShhGdGHUwVC/R5IxZdkMrnQzOWfigW6B4acEFzPPEdg=;
	b=f8JpZPkG1bEXoL3NaWpCEO25sS6EWLyqO15hLN8ypq3TMry5GdK59g9M+4UgdQ7LxS0j
	 smPHPf7YkqXhVovc7PR2Q6aOM9wFCC88dsHB82Jxt7oVAperbXsb8FwZXod50YvqudFzF
	 EfKoos65+KbgCjxymtuSTylqqsUii7WAC7pg97kuvfJllZc2hqBpMA5j+fxf1bjufMvBq
	 hxsMBd1EFvpCnet5x1lvchKT6OLTn6l/olfHqnQ10MgJLMkaGed+rN2EqLbHio5+AuTCg
	 7QCwJ+aNHkBPykOMtfSfWYiiKagXQVs8bzj8C8g6Pdo1DtNlMCF5ppUVu+PXrbTDh+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhXM44bk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050260A2615
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhXM44bk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C6A1F00A0A;
	Wed, 11 Nov 2026 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418953;
	bh=ShhGdGHUwVC/R5IxZdkMrnQzOWfigW6B4acEFzPPEdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KhXM44bkGepHwAzUOhW8N4cI/WzND3c0c9YZi8lyYXIYVzgi7NLVZqXpbWaN9/Qf+
	 PLyTBaI4wLIf3MG/4s/4yHn1O6/kSt14c6O6qBbJ8sRsbH7/iQWVri3GFG1Kv8BBEI
	 x8eog/KjsWGAM4rPAd44AWw6fv/kRK4F1P0+OGWZMcjrARYdt9mMS8WBOrj7zvkggd
	 77nF8R8kJhP3RL3+eMsCh0whXQUDRnWL571EkIYqo2symRc69TBFYffzhUMVm5VzdQ
	 Nr+tCOnbwcnZr2dfPm6rBQGcqeSK/R90xWqmHITYx8pU4nzDlC88YaJLu1sPXLk8io
	 swA1z3i7sTtXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: aloop: Use guard() for mutex locks
Date: Wed, 11 Nov 2026 12:42:30 -0500
Message-ID: <20261111174210.3657227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051902-failed-6.12-ded106036984@kernel.org>
References: <20261107051902-failed-6.12-ded106036984@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ebd9b6c91d4e345b7ded4b56567c46267a45d961 ]

Replace the manual mutex lock/unlock pairs with guard() for code
simplification.

Only code refactoring, and no behavior change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250829150026.6379-2-tiwai@suse.de
Stable-dep-of: ded106036984 ("ALSA: aloop: Don't constrain playback params in notify mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 83 +++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 50 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 50b8e7b3d8179..24ab1a7fd773d 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -532,13 +532,12 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
 	dpcm->pcm_salign = salign;
 	dpcm->pcm_period_size = frames_to_bytes(runtime, runtime->period_size);
 
-	mutex_lock(&dpcm->loopback->cable_lock);
+	guard(mutex)(&dpcm->loopback->cable_lock);
 	if (!(cable->valid & ~(1 << substream->stream)) ||
             (get_setup(dpcm)->notify &&
 	     substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
 		params_change(substream);
 	cable->valid |= 1 << substream->stream;
-	mutex_unlock(&dpcm->loopback->cable_lock);
 
 	return 0;
 }
@@ -979,9 +978,8 @@ static int loopback_hw_free(struct snd_pcm_substream *substream)
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
+	guard(mutex)(&dpcm->loopback->cable_lock);
 	cable->valid &= ~(1 << substream->stream);
-	mutex_unlock(&dpcm->loopback->cable_lock);
 	return 0;
 }
 
@@ -1001,10 +999,10 @@ static int rule_format(struct snd_pcm_hw_params *params,
 	struct snd_mask m;
 
 	snd_mask_none(&m);
-	mutex_lock(&dpcm->loopback->cable_lock);
-	m.bits[0] = (u_int32_t)cable->hw.formats;
-	m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		m.bits[0] = (u_int32_t)cable->hw.formats;
+		m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
+	}
 	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
 
@@ -1015,10 +1013,10 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.rate_min;
-	t.max = cable->hw.rate_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.rate_min;
+		t.max = cable->hw.rate_max;
+	}
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -1031,10 +1029,10 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.channels_min;
-	t.max = cable->hw.channels_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.channels_min;
+		t.max = cable->hw.channels_max;
+	}
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -1047,10 +1045,10 @@ static int rule_period_bytes(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.period_bytes_min;
-	t.max = cable->hw.period_bytes_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.period_bytes_min;
+		t.max = cable->hw.period_bytes_max;
+	}
 	t.openmin = 0;
 	t.openmax = 0;
 	t.integer = 0;
@@ -1264,12 +1262,10 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	int err = 0;
 	int dev = get_cable_index(substream);
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
-	if (!dpcm) {
-		err = -ENOMEM;
-		goto unlock;
-	}
+	if (!dpcm)
+		return -ENOMEM;
 	dpcm->loopback = loopback;
 	dpcm->substream = substream;
 
@@ -1354,7 +1350,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		free_cable(substream);
 		kfree(dpcm);
 	}
-	mutex_unlock(&loopback->cable_lock);
 	return err;
 }
 
@@ -1366,9 +1361,8 @@ static int loopback_close(struct snd_pcm_substream *substream)
 
 	if (dpcm->cable->ops->close_substream)
 		err = dpcm->cable->ops->close_substream(dpcm);
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	free_cable(substream);
-	mutex_unlock(&loopback->cable_lock);
 	return err;
 }
 
@@ -1419,11 +1413,10 @@ static int loopback_rate_shift_get(struct snd_kcontrol *kcontrol,
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift;
-	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -1439,14 +1432,13 @@ static int loopback_rate_shift_put(struct snd_kcontrol *kcontrol,
 		val = 80000;
 	if (val > 120000)
 		val = 120000;	
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	if (val != loopback->setup[kcontrol->id.subdevice]
 				  [kcontrol->id.device].rate_shift) {
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift = val;
 		change = 1;
 	}
-	mutex_unlock(&loopback->cable_lock);
 	return change;
 }
 
@@ -1455,11 +1447,10 @@ static int loopback_notify_get(struct snd_kcontrol *kcontrol,
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].notify;
-	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -1471,14 +1462,13 @@ static int loopback_notify_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 
 	val = ucontrol->value.integer.value[0] ? 1 : 0;
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	if (val != loopback->setup[kcontrol->id.subdevice]
 				[kcontrol->id.device].notify) {
 		loopback->setup[kcontrol->id.subdevice]
 			[kcontrol->id.device].notify = val;
 		change = 1;
 	}
-	mutex_unlock(&loopback->cable_lock);
 	return change;
 }
 
@@ -1490,14 +1480,13 @@ static int loopback_active_get(struct snd_kcontrol *kcontrol,
 
 	unsigned int val = 0;
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	cable = loopback->cables[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	if (cable != NULL) {
 		unsigned int running = cable->running ^ cable->pause;
 
 		val = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ? 1 : 0;
 	}
-	mutex_unlock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
@@ -1540,11 +1529,10 @@ static int loopback_rate_get(struct snd_kcontrol *kcontrol,
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate;
-	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -1564,11 +1552,10 @@ static int loopback_channels_get(struct snd_kcontrol *kcontrol,
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].channels;
-	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -1586,12 +1573,11 @@ static int loopback_access_get(struct snd_kcontrol *kcontrol,
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	snd_pcm_access_t access;
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	access = loopback->setup[kcontrol->id.subdevice][kcontrol->id.device].access;
 
 	ucontrol->value.enumerated.item[0] = !is_access_interleaved(access);
 
-	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -1759,12 +1745,11 @@ static void print_cable_info(struct snd_info_entry *entry,
 	struct loopback *loopback = entry->private_data;
 	int sub, num;
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	num = entry->name[strlen(entry->name)-1];
 	num = num == '0' ? 0 : 1;
 	for (sub = 0; sub < MAX_PCM_SUBSTREAMS; sub++)
 		print_substream_info(buffer, loopback, sub, num);
-	mutex_unlock(&loopback->cable_lock);
 }
 
 static int loopback_cable_proc_new(struct loopback *loopback, int cidx)
@@ -1793,10 +1778,9 @@ static void print_timer_source_info(struct snd_info_entry *entry,
 {
 	struct loopback *loopback = entry->private_data;
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	snd_iprintf(buffer, "%s\n",
 		    loopback->timer_source ? loopback->timer_source : "");
-	mutex_unlock(&loopback->cable_lock);
 }
 
 static void change_timer_source_info(struct snd_info_entry *entry,
@@ -1805,10 +1789,9 @@ static void change_timer_source_info(struct snd_info_entry *entry,
 	struct loopback *loopback = entry->private_data;
 	char line[64];
 
-	mutex_lock(&loopback->cable_lock);
+	guard(mutex)(&loopback->cable_lock);
 	if (!snd_info_get_line(buffer, line, sizeof(line)))
 		loopback_set_timer_source(loopback, strim(line));
-	mutex_unlock(&loopback->cable_lock);
 }
 
 static int loopback_timer_source_proc_new(struct loopback *loopback)
-- 
2.53.0

