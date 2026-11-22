Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344054;
	b=xYgOd+jUleF+1InZMVbCOIC4KJkJUFfstRGOdPAnGeB0k4fhJudE2n99SGGh0WpFfSIX
	 Eh7GWj4uXmb7xGGUdTtpsf2PYB3yfxBcB9O1wxpXm0NabJgG8PQ2DG6IolECw0CH1sUMU
	 mHQ0byAu0wnvPLG9UTr5duJktHP3VxvW0rcQIG0YBsUi3Jvr8/rqutT/hig4WZJ+Dum1p
	 6/U+PrdXsYm1q/8lmCNm8xC86/Zz+Fsertt4JvwcMCbE2lXWhIuvnZYiwX4f1CuuHaHw8
	 6zTgj12yVs2kjQ1mIOHRFBT2snJ03gGJGf+2tFio2SB52kTUeM8EK7Oy2uLyXBOL71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344054;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=jhmtZHgAZHHLxL1xrZ0iLQYNj0E6BsWsRpu5xb+aQ5o=;
	b=KWFydQDodFF6Q1vMIGIBsW5pLvfYWkvWicVw83NF1qvd1yBpozlZuAjHzzspFdSeC9TS
	 4Of3mE7wvJ77/qa4GFdxwX/ZeSXfEIRroia1huDp1MdlWnZcC1arVFQcgkl7GLvX4CKQy
	 aguyAQ5cfoLQBBO9hNI5Qrznqod8CERA11gXtof5fbESvsYwJYK3xePywPYt5q1wLVGMZ
	 lKVYOc7kZEwJvBZZMgZ7e5QOOgD4moB6K3+Jbae01f+yi6wfaWtnxL7Z7ByIk1tDbF5bC
	 JDi98fw/MA6A0c7Mw1A1OhmXioExMd9+kKa/x52h0aaowELMgri04mECqaKZQ6QG2cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9280606A32A;
	Sun, 22 Nov 2026 10:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9280606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=jhmtZHgAZHHLxL1xrZ0iLQYNj0E6BsWsRp
	u5xb+aQ5o=; b=BRETWVW2iK3zgHYf5/mKXcFPP+8Q90us5dIhnG6nP4qLapmAt4
	DeyWeGHC6gKRSlQRWlpG/EkMBZok6yOwWkx/3gunQcjCyNWchcrCwilTtJEKh3Ys
	CYumSX+BooB9N1fN1yO9vOdiTcg1vXF1KZZ2F6BZA5YiVyn6aexBys6+k=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCmqfyoxgJrgsIOAg--.2960S2;
	Sun, 22 Nov 2026 18:40:40 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v6] ALSA: line6: Stop URBs synchronously via sync_stop callback
Date: Sun, 22 Nov 2026 18:40:39 +0800
Message-Id: <20261122104039.7160-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87a4n1702t.wl-tiwai@suse.de>
References: <87a4n1702t.wl-tiwai@suse.de>
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
X-CM-TRANSID:BbQMCkCmqfyoxgJrgsIOAg--.2960S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CrWkWFy7tr4xZr4rtFWfuFg_yoWkWw4xpF
	yru3y5Kr47JF1IvrW7XwsYqw1aqw18tFnxKw1UCrZYya1fG3WrX3W7AF1fur4DCF4v9ay3
	Zr4jq3y5Grs8GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6r
	W5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5X_-JUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2sBs9hbQAAAsU

line6_buffer_release() frees the stream buffer after
line6_wait_clear_audio_urbs() gave up waiting for the URBs that are still
active.  The buffer is still referenced by those URBs, and the completion
callback of such an URB resubmits it from submit_audio_out_urb() with
line6pcm->out.buffer already set to NULL, which ends up in a NULL pointer
dereference in the memset() in submit_audio_out_urb().

While the URBs remain queued, the host controller can also write the
received isochronous data into the freed buffer.  Such a write does not go
through the KASAN checks, so it silently corrupts the freed slab object;
the corruption was observed as a bogus KASAN quarantine entry that later
led to a general protection fault in qlist_free_all().

The active_urbs bitmap cannot prove that the URBs are gone:
line6_unlink_audio_urbs() is called outside the stream lock and only marks
the URBs that are active at that moment, so an URB resubmitted by a
completion callback right after the scan is never unlinked and keeps being
resubmitted after the stream was stopped.

Stop the URBs synchronously instead of polling for them: mark the URBs
that are currently active under the stream lock, so that the completion
callbacks cannot resubmit them, and kill them with usb_kill_urb(), which
waits for the giveback.  Expose this through the sync_stop PCM op, which
ALSA core invokes before hw_free(), hw_params() and prepare() once the
stream was stopped, so the buffer is guaranteed to be unused when it is
released.

The URBs are marked and killed only while no stream is running on that
stream, and only those that are active at that moment, so neither a
stream started concurrently nor another stream type still running
(software monitoring, impulse or the capture helper) is stopped.
Unlink marks left on already completed URBs are dropped afterwards, while
those of still active URBs are kept, so that a later stream start can
submit the URBs again.

line6_pcm_acquire() and snd_line6_prepare() keep a synchronous stop for
an idle stream as well: sync_stop() is invoked only when the substream
itself was stopped, while the other stream types sharing the same stream
never set that, and their unlinking URBs would make
line6_stream_start() skip the submission.  line6_pcm_disconnect() and
line6_buffer_release() stop the URBs unconditionally, as the device may
be gone already and the buffer is about to be freed.

The helper skips the loop when the URBs were not created, as
line6_pcm_disconnect() may run after a failed probe.

Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v6:
- Mark and kill only the URBs that are active at that moment, and only
  while no other stream is running, so that a concurrently started stream
  is not stopped; drop only the unlink marks of completed URBs.
- Keep the synchronous stop in snd_line6_prepare() as well, since
  sync_stop() is invoked only when that substream itself was stopped.

v5:
- Skip line6_kill_audio_urbs() when the URBs are not created yet, as
  line6_pcm_disconnect() can be called after a failed probe.
- Stop the URBs while no other stream type is running, and stop the
  leftover playback URBs of the capture helper as well.

v4:
- Add the sync_stop PCM op and drop the waits from snd_line6_prepare()
  and line6_pcm_acquire(), as suggested by Takashi Iwai.

v3:
- Kill the URBs unconditionally instead of rechecking active_urbs outside
  the stream lock, and clear the unlink marks after the kills.

v2:
- Rebased on sound/for-next.  v1 was generated against v7.3.1 and no longer
  applied, because line6_buffer_release() gained the prev_fbuf clearing
  block in the meantime.  No code change.
---
 sound/usb/line6/capture.c  |   1 +
 sound/usb/line6/pcm.c      | 102 ++++++++++++++++++++++++++-----------
 sound/usb/line6/pcm.h      |   1 +
 sound/usb/line6/playback.c |   1 +
 4 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 626274e503c7..fa98c26cf77d 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -284,6 +284,7 @@ const struct snd_pcm_ops snd_line6_capture_ops = {
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
+	.sync_stop = snd_line6_sync_stop,
 	.pointer = snd_line6_pointer,
 };
 
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index d17baf7761c6..34d68a9ce328 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -109,29 +109,51 @@ static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
 }
 
 /*
-	Wait until unlinking of all currently active URBs has been finished.
-*/
-static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
-					struct line6_pcm_stream *pcms)
+ * Mark all currently active URBs for unlinking and kill them.
+ *
+ * The unlink bit is set under the stream lock, so the completion
+ * callbacks cannot resubmit these URBs any longer.  usb_kill_urb() then
+ * waits for the giveback of every URB, hence the stream buffer is no
+ * longer referenced by the host controller.  This function must be
+ * called from a sleepable context.
+ *
+ * When @idle_only is set, nothing is done if some stream is still running
+ * on @pcms, and only the URBs that are active at that moment are killed,
+ * so that a concurrently started stream is never stopped.
+ */
+static void line6_kill_audio_urbs(struct snd_line6_pcm *line6pcm,
+				  struct line6_pcm_stream *pcms, bool idle_only)
 {
-	int timeout = HZ;
+	unsigned long active;
 	int i;
-	int alive;
 
-	do {
-		alive = 0;
-		for (i = 0; i < line6pcm->line6->iso_buffers; i++) {
-			if (test_bit(i, &pcms->active_urbs))
-				alive++;
-		}
-		if (!alive)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-	} while (--timeout > 0);
-	if (alive)
-		dev_err(line6pcm->line6->ifcdev,
-			"timeout: still %d active urbs..\n", alive);
+	/* May be called when the URB creation failed during the probe */
+	if (!pcms->urbs)
+		return;
+
+	scoped_guard(spinlock_irqsave, &pcms->lock) {
+		if (idle_only && pcms->running)
+			return;
+		active = pcms->active_urbs;
+		for_each_set_bit(i, &active, line6pcm->line6->iso_buffers)
+			set_bit(i, &pcms->unlink_urbs);
+	}
+
+	for_each_set_bit(i, &active, line6pcm->line6->iso_buffers)
+		if (pcms->urbs[i])
+			usb_kill_urb(pcms->urbs[i]);
+
+	/*
+	 * Drop the unlink marks left on URBs that were completed and not
+	 * resubmitted, so that a later stream start can submit the URBs
+	 * again.  An URB that is still active keeps its mark.
+	 */
+	scoped_guard(spinlock_irqsave, &pcms->lock) {
+		for_each_set_bit(i, &pcms->unlink_urbs,
+				 line6pcm->line6->iso_buffers)
+			if (!test_bit(i, &pcms->active_urbs))
+				clear_bit(i, &pcms->unlink_urbs);
+	}
 }
 
 static inline struct line6_pcm_stream *
@@ -172,7 +194,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 {
 	clear_bit(type, &pstr->opened);
 	if (!pstr->opened) {
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr, false);
 		if (pstr == &line6pcm->in) {
 			/* prev_fbuf points into the capture buffer we are about
 			 * to free; drop it while no capture URB is in flight.
@@ -337,8 +359,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type, bool start)
 		ret = line6_buffer_acquire(line6pcm, pstr, dir, type);
 		if (ret < 0)
 			goto error;
-		if (!pstr->running)
-			line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr, true);
 	}
 	if (start) {
 		for (dir = 0; dir < 2; dir++) {
@@ -510,10 +531,8 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 */
 void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 {
-	line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
-	line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
-	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
-	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
+	line6_kill_audio_urbs(line6pcm, &line6pcm->out, false);
+	line6_kill_audio_urbs(line6pcm, &line6pcm->in, false);
 }
 
 /*
@@ -592,6 +611,27 @@ int line6_init_pcm(struct usb_line6 *line6,
 }
 EXPORT_SYMBOL_GPL(line6_init_pcm);
 
+/* common PCM sync_stop callback */
+int snd_line6_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
+
+	guard(mutex)(&line6pcm->state_mutex);
+	line6_kill_audio_urbs(line6pcm, pstr, true);
+	/*
+	 * A capture stream may use the playback stream as a helper, and
+	 * snd_line6_trigger() stops it together with the capture stream.
+	 * Stop the leftover playback URBs here as well, so that the helper
+	 * stream can be restarted at the next trigger.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	    (line6pcm->line6->properties->capabilities &
+	     LINE6_CAP_IN_NEEDS_OUT))
+		line6_kill_audio_urbs(line6pcm, &line6pcm->out, true);
+	return 0;
+}
+
 /* prepare pcm callback */
 int snd_line6_prepare(struct snd_pcm_substream *substream)
 {
@@ -599,8 +639,12 @@ int snd_line6_prepare(struct snd_pcm_substream *substream)
 	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
 	guard(mutex)(&line6pcm->state_mutex);
-	if (!pstr->running)
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+	/*
+	 * sync_stop() is called only after this substream itself was
+	 * stopped; other stream types sharing the stream (monitor, impulse
+	 * or the capture helper) may have left URBs unlinking.
+	 */
+	line6_kill_audio_urbs(line6pcm, pstr, true);
 
 	if (!test_and_set_bit(LINE6_FLAG_PREPARED, &line6pcm->flags)) {
 		line6pcm->out.count = 0;
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index a15913bf2a7a..21e550948cd8 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -183,6 +183,7 @@ extern int line6_init_pcm(struct usb_line6 *line6,
 			  struct line6_pcm_properties *properties);
 extern int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd);
 extern int snd_line6_prepare(struct snd_pcm_substream *substream);
+extern int snd_line6_sync_stop(struct snd_pcm_substream *substream);
 extern int snd_line6_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *hw_params);
 extern int snd_line6_hw_free(struct snd_pcm_substream *substream);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index e93a16f6958e..10e273f4b77a 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -414,6 +414,7 @@ const struct snd_pcm_ops snd_line6_playback_ops = {
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
+	.sync_stop = snd_line6_sync_stop,
 	.pointer = snd_line6_pointer,
 };
 
-- 
2.34.1

