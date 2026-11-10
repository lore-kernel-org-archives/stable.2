Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322158;
	b=G852FMtFYu6HnCf15ialAa9O6Wz6b6Y+nanerqZhamjCdZxi2WNNQbhvJm9K83stbpyQ
	 b91+SMprpSJZGLGwqhXitUrFmCBXOplqHiizHo23ypM8yCcjeeV+6+gga/cFzij4P7RBN
	 hATXVXN8ycSsVYW6KdJ4Pv2jM5DIaR66lEaVH+Slr/DcEkFpwJV9NGj/aPLt+5tkwq0dR
	 6/YVc3bDDcrjs44lk0+PrmjujBAhnH1vUT9H/8poJuq0JSlaBlq2ng61T1Wh0QnniKbkv
	 TGoInBcdwogvIeOf+xasSAfX/QFJ0Y31vdFJeZ1w4C/bZ6L57KxQHqZRwrKt48CQFGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UgJY+DAmRY+sFcFbkgyS43sbmIQ9L7ctiP6MLbgRmpA=;
	b=svoo+9TPeq40Mzaw/ikhlhUUrNu57hhmaLyPPV5xRmGKHKFDW3ek6Pi2+6qWbAUTrSMu
	 VHwGL9DMMCpumpdNyRvAMrsCxp4l/WhDQyqHtenORlPmsuwxKtmt55iKGbPuHGgATkfPp
	 7x+w+cGFOXgapjQhGSPDpmNGdTL5hFYWm0kmNfARZw3xtCg5q0w0DGvtuFh0TP3SqVvsV
	 derEQcfXWV7wTrIiMbvt4j1ccj1ZgCAUAbybVoZATHQF8tzgiJRjHIe/bIJbDZRKXclqZ
	 MNzTCdo9Z9sbS4fzcx8dpkxl5vUizLpEXGoTuiNCgdxDjUOTeC5ZZlROGOeF/IZA37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZpjsT9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZpjsT9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ADF1F0089F;
	Tue, 10 Nov 2026 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322157;
	bh=UgJY+DAmRY+sFcFbkgyS43sbmIQ9L7ctiP6MLbgRmpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oZpjsT9LVTnTl0UXilnxppgNkB/8vCcbSnk5/G/n2vfwDp3hM8LpUM/CY/Gc8Uuwp
	 YKycPmA4Y0JTvjmBPyu8XAZYgxKsbs1yEWyrOnhXQn9kn1gLttI9i+dcwmS+VL79kl
	 txSo+gBxEkcmpFzxlIIxDytZRE71exHAP5NpWD4mJHcJTCcZiwmsB2+S3upytKzvKs
	 Pc7/nzcW4aNDBOaxrEHEoyWF4PjtAwibAarccLvvZ3DqAxhCVKPmz2f6B8hG1BwlMX
	 QptnWoimUeUTrSrH/QoajRYa1Mc4PUp9oHLW4ZNJcY/VSk6GvqjkBqwdthcgUkXI9n
	 CJC/DSnT7L7tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: line6: Use guard() for spin locks
Date: Tue, 10 Nov 2026 09:49:15 -0500
Message-ID: <20261110144908.1985531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053722-failed-6.6-443ed4edc267@kernel.org>
References: <20261107053722-failed-6.6-443ed4edc267@kernel.org>
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

[ Upstream commit bdcdb4e7aa410122baa3496b93e7850dc20a90fa ]

Clean up the code using guard() for spin locks.

Merely code refactoring, and no behavior change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 443ed4edc267 ("ALSA: line6: Handle period elapsed calls outside the locks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/line6/capture.c |  6 +-----
 sound/usb/line6/driver.c  | 31 +++++++++++++++----------------
 sound/usb/line6/midi.c    | 10 ++--------
 sound/usb/line6/pcm.c     | 27 ++++++++++++---------------
 4 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index e77ef16c792f0..f26cb35446cf9 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -157,8 +157,6 @@ void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
 static void audio_in_callback(struct urb *urb)
 {
 	int i, index, length = 0, shutdown = 0;
-	unsigned long flags;
-
 	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
 
 	line6pcm->in.last_frame = urb->start_frame;
@@ -168,7 +166,7 @@ static void audio_in_callback(struct urb *urb)
 		if (urb == line6pcm->in.urbs[index])
 			break;
 
-	spin_lock_irqsave(&line6pcm->in.lock, flags);
+	guard(spinlock_irqsave)(&line6pcm->in.lock);
 
 	for (i = 0; i < LINE6_ISO_PACKETS; ++i) {
 		char *fbuf;
@@ -223,8 +221,6 @@ static void audio_in_callback(struct urb *urb)
 		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running))
 			line6_capture_check_period(line6pcm, length);
 	}
-
-	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 }
 
 /* open capture callback */
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 9df49a880b750..36b97e8403135 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -286,31 +286,30 @@ static void line6_data_received(struct urb *urb)
 {
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
 	struct midi_buffer *mb = &line6->line6midi->midibuf_in;
-	unsigned long flags;
 	int done;
 
 	if (urb->status == -ESHUTDOWN)
 		return;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		spin_lock_irqsave(&line6->line6midi->lock, flags);
-		done =
-			line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
-
-		if (done < urb->actual_length) {
-			line6_midibuf_ignore(mb, done);
-			dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
-				done, urb->actual_length);
+		scoped_guard(spinlock_irqsave, &line6->line6midi->lock) {
+			done =
+				line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
+
+			if (done < urb->actual_length) {
+				line6_midibuf_ignore(mb, done);
+				dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
+					done, urb->actual_length);
+			}
 		}
-		spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 		for (;;) {
-			spin_lock_irqsave(&line6->line6midi->lock, flags);
-			done =
-				line6_midibuf_read(mb, line6->buffer_message,
-						   LINE6_MIDI_MESSAGE_MAXLEN,
-						   LINE6_MIDIBUF_READ_RX);
-			spin_unlock_irqrestore(&line6->line6midi->lock, flags);
+			scoped_guard(spinlock_irqsave, &line6->line6midi->lock) {
+				done =
+					line6_midibuf_read(mb, line6->buffer_message,
+							   LINE6_MIDI_MESSAGE_MAXLEN,
+							   LINE6_MIDIBUF_READ_RX);
+			}
 
 			if (done <= 0)
 				break;
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index 0838632c788e4..c04c3cac8ede7 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -72,7 +72,6 @@ static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 */
 static void midi_sent(struct urb *urb)
 {
-	unsigned long flags;
 	int status;
 	int num;
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
@@ -84,7 +83,7 @@ static void midi_sent(struct urb *urb)
 	if (status == -ESHUTDOWN)
 		return;
 
-	spin_lock_irqsave(&line6->line6midi->lock, flags);
+	guard(spinlock_irqsave)(&line6->line6midi->lock);
 	num = --line6->line6midi->num_active_send_urbs;
 
 	if (num == 0) {
@@ -94,8 +93,6 @@ static void midi_sent(struct urb *urb)
 
 	if (num == 0)
 		wake_up(&line6->line6midi->send_wait);
-
-	spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 }
 
 /*
@@ -158,17 +155,14 @@ static int line6_midi_output_close(struct snd_rawmidi_substream *substream)
 static void line6_midi_output_trigger(struct snd_rawmidi_substream *substream,
 				      int up)
 {
-	unsigned long flags;
 	struct usb_line6 *line6 =
 	    line6_rawmidi_substream_midi(substream)->line6;
 
 	line6->line6midi->substream_transmit = substream;
-	spin_lock_irqsave(&line6->line6midi->lock, flags);
+	guard(spinlock_irqsave)(&line6->line6midi->lock);
 
 	if (line6->line6midi->num_active_send_urbs == 0)
 		line6_midi_transmit(substream);
-
-	spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 }
 
 static void line6_midi_output_drain(struct snd_rawmidi_substream *substream)
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 7325482dcaebb..0d7ea10c98ebf 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -190,11 +190,10 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 			      int type)
 {
-	unsigned long flags;
 	struct line6_pcm_stream *pstr = get_stream(line6pcm, direction);
 	int ret = 0;
 
-	spin_lock_irqsave(&pstr->lock, flags);
+	guard(spinlock_irqsave)(&pstr->lock);
 	if (!test_and_set_bit(type, &pstr->running) &&
 	    !(pstr->active_urbs || pstr->unlink_urbs)) {
 		pstr->count = 0;
@@ -207,7 +206,6 @@ static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 
 	if (ret < 0)
 		clear_bit(type, &pstr->running);
-	spin_unlock_irqrestore(&pstr->lock, flags);
 	return ret;
 }
 
@@ -215,21 +213,20 @@ static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 static void line6_stream_stop(struct snd_line6_pcm *line6pcm, int direction,
 			  int type)
 {
-	unsigned long flags;
 	struct line6_pcm_stream *pstr = get_stream(line6pcm, direction);
 
-	spin_lock_irqsave(&pstr->lock, flags);
-	clear_bit(type, &pstr->running);
-	if (!pstr->running) {
-		spin_unlock_irqrestore(&pstr->lock, flags);
-		line6_unlink_audio_urbs(line6pcm, pstr);
-		spin_lock_irqsave(&pstr->lock, flags);
-		if (direction == SNDRV_PCM_STREAM_CAPTURE) {
-			line6pcm->prev_fbuf = NULL;
-			line6pcm->prev_fsize = 0;
-		}
+	scoped_guard(spinlock_irqsave, &pstr->lock) {
+		clear_bit(type, &pstr->running);
+		if (pstr->running)
+			return;
+	}
+
+	line6_unlink_audio_urbs(line6pcm, pstr);
+	if (direction == SNDRV_PCM_STREAM_CAPTURE) {
+		guard(spinlock_irqsave)(&pstr->lock);
+		line6pcm->prev_fbuf = NULL;
+		line6pcm->prev_fsize = 0;
 	}
-	spin_unlock_irqrestore(&pstr->lock, flags);
 }
 
 /* common PCM trigger callback */
-- 
2.53.0

