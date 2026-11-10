Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323877;
	b=m4J9VeTJojdwy5fBTONy0xffLxHd9mj9xj/tKQ9zI9NmdDG41ZsT6kSAlfcJeyydh0fU
	 MGI7dSrjyE+glfoTGb2Rwjj17Qn7qq97hYRlqb4RWMRjjDzcuzx4VzHvE01JrIcVTz24I
	 kRaAaJnl6fPn/9Z5lVuGOjsEPQrLGE62WM/620md0hd8/LK4GVZLED+U1rEuDxGSclXl9
	 8Q6Y4BAUv/rgZqSi755+S6i1l9jbSuSJkUXfyEYK/ehjtUtV4uAufxpKF6+0Rgnwy+z8g
	 4mfGVIKNyHWh9lrJMcF2U4PQzu8ajjoWO6wJHHEblYnr/wg+eM4mZQO7mktoFhfJXOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F7R2r3jsbSOUtZB6/Vbkn7CA7J1lCeszJnZ0u6wkkpU=;
	b=FiZ1cnxlIf9cK+kHYzOjuQr0CNr+z+lLy2eYkUFVUcdHim1q3MO3hUoBqfW5q2Nm5Ywr
	 RmlV5Jf1FohX4zifRnrM1AFeJkRrOI67qU1Qoy/zds4U0gaCEkKk9IseRX+Jw81Cx8OAs
	 CQGRlDdzvgcfV9qyJyWD3x0SKPQW3VneEmrGmnvJUx35GHksxkI7o5mXv5XTg9iONMdZq
	 XIIHdjHwzk+TonbWnpac5AMWtUSzQsCX6/Fb1pfNvZ1+0UoBSdbR/LqWratBJLNwII7C8
	 RD3a9CIqV+uaCZwlD+GmKHo9Ds4mfc3azT4b8MWZyYKP7Fg0y+XUl5qeLga6fnDOANw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OI59Gcty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OI59Gcty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5321F0089F;
	Tue, 10 Nov 2026 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323876;
	bh=F7R2r3jsbSOUtZB6/Vbkn7CA7J1lCeszJnZ0u6wkkpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI59GctyfGbWvUsoup8nePOSiQady1XE9rp+848MtIkNMGOdA5Zx5vuogdjHQO5kN
	 l5Ur7cofeJSRopn3+C/3yxKxseOdZiNeq7NPO0yDlRtNS7TZ2isMVq0WNSVR5BZvqD
	 zCx6SFZ2WRQFlxe1NliMlyuTCUADE9jW1nvtufkhXk7u1cp1cKzwF3wtWSQaDTZKI6
	 p2Yl0axs7VKZEsY6lmXY2x+YDM8q5Q7qGi3+GUjaQrErscQ8FPezum3keLr6lbl98a
	 hzesaZ6cbtKGQE+nF2sI0M5eJW21aqq5mvb8VuV6equumvLsjoq4RCn1Yj+pfbTY4u
	 abOk/EF9c5Imw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: line6: Handle period elapsed calls outside the locks
Date: Tue, 10 Nov 2026 10:17:54 -0500
Message-ID: <20261110151742.2090222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062610-failed-5.10-443ed4edc267@kernel.org>
References: <20261107062610-failed-5.10-443ed4edc267@kernel.org>
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

[ Upstream commit 443ed4edc2678cc51c5a01e7dffc4c890be40051 ]

LINE6 driver may call snd_pcm_period_elapsed() for both playback and
capture substreams at processing the playback substream, and this may
lead to a ABBA deadlock.

Move the actual calls of snd_pcm_period_elapsed() outside the locks
for avoiding it.  The capture period notification at submitting the
initial playback URBs (only with the impulse mode) is simply skipped,
as it's done in the lock context; it'll be caught up at the next
period.

Fixes: f56742cc4189 ("ALSA: line6: Add LINE6_CAP_IN_NEEDS_OUT, a void playback stream during capture")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-5a9de389-e6ea-410d-8322-e74e14152603
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20261020113118.234689-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: used a local flag in audio_in_callback() instead of extracting handle_audio_in() to accommodate explicit spinlock handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/line6/capture.c  | 17 +++++++++--------
 sound/usb/line6/capture.h  |  2 +-
 sound/usb/line6/playback.c | 31 +++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index e77ef16c792f0..2f7490c8693fa 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -137,18 +137,15 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 		line6pcm->in.pos_done -= runtime->buffer_size;
 }
 
-void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
+/* update the capture position and check whether we need period_elapsed call */
+bool line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
 {
-	struct snd_pcm_substream *substream =
-	    get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE);
-
 	line6pcm->in.bytes += length;
 	if (line6pcm->in.bytes >= line6pcm->in.period) {
 		line6pcm->in.bytes %= line6pcm->in.period;
-		spin_unlock(&line6pcm->in.lock);
-		snd_pcm_period_elapsed(substream);
-		spin_lock(&line6pcm->in.lock);
+		return true;
 	}
+	return false;
 }
 
 /*
@@ -158,6 +155,7 @@ static void audio_in_callback(struct urb *urb)
 {
 	int i, index, length = 0, shutdown = 0;
 	unsigned long flags;
+	bool capture_period_elapsed = false;
 
 	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
 
@@ -221,10 +219,13 @@ static void audio_in_callback(struct urb *urb)
 
 		if (!test_bit(LINE6_STREAM_IMPULSE, &line6pcm->in.running) &&
 		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running))
-			line6_capture_check_period(line6pcm, length);
+			capture_period_elapsed = line6_capture_check_period(line6pcm, length);
 	}
 
 	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
+
+	if (capture_period_elapsed)
+		snd_pcm_period_elapsed(get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE));
 }
 
 /* open capture callback */
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 20e05a5eceb4f..5ae1745261e50 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -17,7 +17,7 @@ extern const struct snd_pcm_ops snd_line6_capture_ops;
 
 extern void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf,
 			       int fsize);
-extern void line6_capture_check_period(struct snd_line6_pcm *line6pcm,
+extern bool line6_capture_check_period(struct snd_line6_pcm *line6pcm,
 				       int length);
 extern int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 0da1998dd5add..deb313486ee78 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -136,6 +136,8 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 /*
 	Find a free URB, prepare audio data, and submit URB.
 	must be called in line6pcm->out.lock context
+	Returns 1 if snd_pcm_period_elapsed() needs to be called for the
+	capture stream after releasing the lock, 0 if not, or a negative error
 */
 static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 {
@@ -151,6 +153,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		line6pcm->properties->rates.rats[0].den *
 		(line6pcm->line6->intervals_per_second / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
+	bool capture_period_elapsed = false;
 
 	index = find_first_zero_bit(&line6pcm->out.active_urbs,
 				    line6pcm->line6->iso_buffers);
@@ -260,8 +263,9 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 						   urb_out->transfer_buffer,
 						   urb_out->
 						   transfer_buffer_length);
-				line6_capture_check_period(line6pcm,
-					urb_out->transfer_buffer_length);
+				capture_period_elapsed =
+					line6_capture_check_period(line6pcm,
+								   urb_out->transfer_buffer_length);
 			}
 		} else {
 			if (!(line6pcm->line6->properties->capabilities & LINE6_CAP_HWMON)
@@ -283,24 +287,26 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		dev_err(line6pcm->line6->ifcdev,
 			"URB out #%d submission failed (%d)\n", index, ret);
 
-	return 0;
+	return capture_period_elapsed;
 }
 
 /*
 	Submit all currently available playback URBs.
 	must be called in line6pcm->out.lock context
+	The capture period notification is skipped here since we can't call
+	snd_pcm_period_elapsed() in the lock; it'll be caught up at the next one.
  */
 int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 {
-	int ret = 0, i;
+	int ret, i;
 
 	for (i = 0; i < line6pcm->line6->iso_buffers; ++i) {
 		ret = submit_audio_out_urb(line6pcm);
 		if (ret < 0)
-			break;
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 /*
@@ -316,6 +322,8 @@ static void audio_out_callback(struct urb *urb)
 	const int bytes_per_frame =
 		line6pcm->properties->bytes_per_channel *
 		line6pcm->properties->playback_hw.channels_max;
+	bool capture_period_elapsed = false;
+	bool playback_period_elapsed = false;
 
 #if USE_CLEAR_BUFFER_WORKAROUND
 	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
@@ -358,19 +366,22 @@ static void audio_out_callback(struct urb *urb)
 		shutdown = 1;
 
 	if (!shutdown) {
-		submit_audio_out_urb(line6pcm);
+		capture_period_elapsed = submit_audio_out_urb(line6pcm) > 0;
 
 		if (test_bit(LINE6_STREAM_PCM, &line6pcm->out.running)) {
 			line6pcm->out.bytes += length;
 			if (line6pcm->out.bytes >= line6pcm->out.period) {
 				line6pcm->out.bytes %= line6pcm->out.period;
-				spin_unlock(&line6pcm->out.lock);
-				snd_pcm_period_elapsed(substream);
-				spin_lock(&line6pcm->out.lock);
+				playback_period_elapsed = true;
 			}
 		}
 	}
 	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
+
+	if (capture_period_elapsed)
+		snd_pcm_period_elapsed(get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE));
+	if (playback_period_elapsed)
+		snd_pcm_period_elapsed(substream);
 }
 
 /* open playback callback */
-- 
2.53.0

