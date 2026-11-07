Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048730;
	b=m+PCJZuiBik5xJUScc1mDyobE1MCZNOoiTMTbWAAVm5g3Ioj6QkCB8BJh+aCHgC3rTMg
	 H7IKbUXjt6ctNTbUgV3qIUp0NG7zU21jJmoYZGJgdg8aQ/HSBF/JBa9tM7RnzJggyR8mv
	 asdrO5jdo7n8qtfzCtVS2OEq7ZKn8C6DZJIxmu/VSKiC5x0rzjvVoN55ZGTc/JfmG4e0B
	 RXnXS8o14JnTyw81U0GPtzk9xS88r08FERsoOr7qaNe0WHOp1+mdYskh4gcGgliuayB9W
	 xGR1xMSdllR3+O8MZh3cQzfuYd05ZXRATOLOYc9p29BtulswnoBW3ymLgeGhRrQ9EOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2wx3FG+pwk65VYTgsDJy9avj1aJ/VU9sRfPmwBdSenU=;
	b=MqdUS10exDJc/J1nKh3HMDa5Z1DrUDH+UeDYmbLKqDyZMRQqKtBmZ+dKbf3tdKIrDWTN
	 ERHkUiZ5SHikWFzueS8znARHDSo6iXEbXWk36zkp2K/ZBqJRysC/7WG3NZfg31jIT/N+Z
	 z36j7mLPmWn5trQ1hqNifckUnb1mO6wazBvFpKC5Rp2xlgNkmah3b1/5himL+tei3hHBt
	 ssgNp0qeQpPudsQDdbI0Zu1P2PHXo5vc2Y6/3DU6SO3Sml71yjV7cFxLQjizMQi+xrCVI
	 RCvJJ9XIne9jzvwcCZgJ2r/IZTmdHObfDQ17YsF/kU9nBpvQH3zGsRrKtng3Ify/ogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l31go2VW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1729606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l31go2VW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5441F0089F;
	Sat,  7 Nov 2026 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048729;
	bh=2wx3FG+pwk65VYTgsDJy9avj1aJ/VU9sRfPmwBdSenU=;
	h=From:To:Cc:Subject:Date;
	b=l31go2VW92jzVwJFwUlZjgDAB08bGHw1F8o+aw2fV3fad5InNZGyv21XFcZN0v8q6
	 AP48rmgC6ytMtAaecuWaIW4hTudlL5WNzKFRljZVg1ptvhObEnow5h6xTkPlYsk5Bh
	 3i+fUP56kaREF6drpHnIsYUgkrpFZWTqxWLBejeUhaQArqKWeh+yZAbp7R5jdKCNSe
	 bxNwJ3p5IeqDYlrS9rwHuez31Aqh0y0axmvrqIHuN6/1NZ+PGHWZifVc4sjbgLJUJ+
	 lz0KTs73RzWe+geHYS0fk9PmWr0D8AZcXB6oUoF4gpPJJ1ymGKXPVefDa/5BAm5aYF
	 mhpRbskdo6foQ==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: line6: Handle period elapsed calls outside the locks" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:07 -0500
Message-ID: <20261107055207-failed-6.1-443ed4edc267@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 443ed4edc2678cc51c5a01e7dffc4c890be40051
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055207-failed-6.1-443ed4edc267@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 443ed4edc2678cc51c5a01e7dffc4c890be40051 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 20 Oct 2026 13:31:17 +0200
Subject: [PATCH] ALSA: line6: Handle period elapsed calls outside the locks

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
---
 sound/usb/line6/capture.c  | 25 ++++++++++++++++---------
 sound/usb/line6/capture.h  |  2 +-
 sound/usb/line6/playback.c | 31 +++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 3e1f40d6b481a..17f49f567efbf 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -126,24 +126,21 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
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
  * Callback for completed capture URB.
  */
-static void audio_in_callback(struct urb *urb)
+static bool handle_audio_in(struct urb *urb)
 {
 	int i, index, length = 0, shutdown = 0;
 	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
@@ -208,8 +205,18 @@ static void audio_in_callback(struct urb *urb)
 
 		if (!test_bit(LINE6_STREAM_IMPULSE, &line6pcm->in.running) &&
 		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running))
-			line6_capture_check_period(line6pcm, length);
+			return line6_capture_check_period(line6pcm, length);
 	}
+
+	return false;
+}
+
+static void audio_in_callback(struct urb *urb)
+{
+	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
+
+	if (handle_audio_in(urb))
+		snd_pcm_period_elapsed(get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE));
 }
 
 /* open capture callback */
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 90572dae134ee..628315389efcf 100644
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
index aa6ddf8746a0a..e93a16f6958e3 100644
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




