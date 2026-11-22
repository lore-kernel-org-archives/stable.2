Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340106;
	b=F/GfGPdg2P2hyYRmhTh8yzXpqaoaxdLnPZi5vtBqfG48TgbpibiW0GsjdVWWpdSvwf2m
	 PRPWiQvnLcM6QbeMGx1h3rvP0id3GFstg1TALGcrTP//x8K5Uq7sP4y/re6OPnydW9Co0
	 b0Jv8PLlOa8y//2gDZGLggjLT2fdWOzizSdbaSr5O/CWkY14qtancB9QoJg5aE0TBOtxs
	 uEHB46u8Z8pYjayk4pwDwd31tdtk7+oWt2TAV8iCWfHmdc8Rnb+tn7naU+/OPz78x+yvn
	 f5lfY+6LDwQrUI3QaTIE/maFeriIKq7+vFykA6DyWZU4UYxCOUn6s1mWYkZImxFlhnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340106;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bhDv5aW2ilrYJ9ClUDw7dzZQTeWdfvqaImsg754KqbI=;
	b=ETl0W/C3Hat/FFtJP+OYWA3ex6NhMtjLfubYbItR+jjmY6WZVBQu55q33+jAIPtL9R77
	 KfthQGHQl/tIYl+r84Wt4mbP6FVez9Y/rMUuyAzfKG3z3rZ6JeHKpauDQbuyH/TaRrVi5
	 38VXcU8KqO/opN2o64d8Pa9NThI068Pf+FhgZubcrq2rahHzz25n7pW9IkaXmdujy9cEz
	 A6T5eWCqQ/+3D3D/1+yZjv74wMU+rPHHIjPho13PdG04TGZAThPvxUPY8Bb5cfex5FbJy
	 JwX1UhPwuLUosNl0VlD778tlXcuSNUGSM4FXEgXRhEmb46LUuchMcljauWknfKdPONA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDC606A32A;
	Sun, 22 Nov 2026 09:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FDC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bhDv5aW2ilrYJ9ClUDw7dzZQTeWdfvqaIm
	sg754KqbI=; b=XTrygeHHS+Qz+9XzIrMvBB6Z3koo6Qbx2Eb5XepF7jlqTXXDj6
	UW4EMqgjbrN8ve1LHx7uIaMqqZ0fW/KfDHQ2ZDIExNVl9TRpjpg01nrBy00qDO3b
	N8EC/LF9z4J0ue9pmxVsD+JFyenvm1EOfYIEer8jsGILvV0OZIj8wsDBM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAWNfs_twJr49QOAg--.56686S2;
	Sun, 22 Nov 2026 17:34:55 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v5] ALSA: line6: Stop URBs synchronously via sync_stop callback
Date: Sun, 22 Nov 2026 17:34:54 +0800
Message-Id: <20261122093454.14422-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkAWNfs_twJr49QOAg--.56686S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CrWktF4UGw4kCr4xZr4fXwb_yoWDArWkpF
	yru345Kry7JFy0vrW7Xws0qw1Sqw18KFnxKw1UC39Yya1fG3W5Xa47AF1rurs8CF4v9ay3
	Zr4jq3y5Grn8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5QSdJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2sBs9hWqgAAsz

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

Stop the URBs synchronously instead of polling for them: mark all
currently active URBs for unlinking under the stream lock, so that the
completion callbacks cannot resubmit them, and kill them with
usb_kill_urb(), which waits for the giveback.  Expose this through the
sync_stop PCM op, which ALSA core invokes before hw_free(), hw_params()
and prepare() once the stream was stopped, so the buffer is guaranteed to
be unused when it is released.

The URBs are stopped in sync_stop() only while no other stream type is
running on the same stream, since software monitoring or a capture helper
may keep them running.  When the capture stream is stopped, the helper
playback stream is stopped together in snd_line6_trigger(), so its
leftover URBs are stopped as well unless another playback stream runs.

Replace line6_wait_clear_audio_urbs() with this helper accordingly, and
drop the now redundant wait from snd_line6_prepare();
line6_pcm_disconnect() and line6_pcm_acquire() keep stopping the URBs
synchronously, as the device may be gone already and the monitor and
capture-helper streams are started without going through the PCM ops.
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
v5:
- Skip line6_kill_audio_urbs() when the URBs are not created yet, as
  line6_pcm_disconnect() can be called after a failed probe.
- Stop the URBs in sync_stop() only when no other stream type is running
  on the same stream, and stop the leftover playback URBs of the capture
  helper as well.
- Keep the synchronization in line6_pcm_acquire(), now killing the URBs
  instead of polling: the monitor and capture-helper streams are started
  there without going through the PCM ops.

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
 sound/usb/line6/capture.c  |  1 +
 sound/usb/line6/pcm.c      | 83 +++++++++++++++++++++++++-------------
 sound/usb/line6/pcm.h      |  1 +
 sound/usb/line6/playback.c |  1 +
 4 files changed, 58 insertions(+), 28 deletions(-)

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
index d17baf7761c6..16e6f9900514 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -109,29 +109,37 @@ static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
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
+ * longer referenced by the host controller.  The unlink marks are
+ * cleared afterwards, so that a later stream start can submit the URBs
+ * again.  This function must be called from a sleepable context.
+ */
+static void line6_kill_audio_urbs(struct snd_line6_pcm *line6pcm,
+				  struct line6_pcm_stream *pcms)
 {
-	int timeout = HZ;
 	int i;
-	int alive;
 
-	do {
-		alive = 0;
-		for (i = 0; i < line6pcm->line6->iso_buffers; i++) {
+	/* May be called when the URB creation failed during the probe */
+	if (!pcms->urbs)
+		return;
+
+	scoped_guard(spinlock_irqsave, &pcms->lock) {
+		for (i = 0; i < line6pcm->line6->iso_buffers; i++)
 			if (test_bit(i, &pcms->active_urbs))
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
+				set_bit(i, &pcms->unlink_urbs);
+	}
+
+	for (i = 0; i < line6pcm->line6->iso_buffers; i++)
+		if (pcms->urbs[i])
+			usb_kill_urb(pcms->urbs[i]);
+
+	scoped_guard(spinlock_irqsave, &pcms->lock) {
+		pcms->unlink_urbs = 0;
+	}
 }
 
 static inline struct line6_pcm_stream *
@@ -172,7 +180,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 {
 	clear_bit(type, &pstr->opened);
 	if (!pstr->opened) {
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr);
 		if (pstr == &line6pcm->in) {
 			/* prev_fbuf points into the capture buffer we are about
 			 * to free; drop it while no capture URB is in flight.
@@ -338,7 +346,7 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type, bool start)
 		if (ret < 0)
 			goto error;
 		if (!pstr->running)
-			line6_wait_clear_audio_urbs(line6pcm, pstr);
+			line6_kill_audio_urbs(line6pcm, pstr);
 	}
 	if (start) {
 		for (dir = 0; dir < 2; dir++) {
@@ -510,10 +518,8 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 */
 void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 {
-	line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
-	line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
-	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
-	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
+	line6_kill_audio_urbs(line6pcm, &line6pcm->out);
+	line6_kill_audio_urbs(line6pcm, &line6pcm->in);
 }
 
 /*
@@ -592,15 +598,36 @@ int line6_init_pcm(struct usb_line6 *line6,
 }
 EXPORT_SYMBOL_GPL(line6_init_pcm);
 
-/* prepare pcm callback */
-int snd_line6_prepare(struct snd_pcm_substream *substream)
+/* common PCM sync_stop callback */
+int snd_line6_sync_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
 	guard(mutex)(&line6pcm->state_mutex);
 	if (!pstr->running)
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr);
+	/*
+	 * A capture stream may use the playback stream as a helper, and
+	 * snd_line6_trigger() stops it together with the capture stream.
+	 * Stop the leftover playback URBs here as well, so that the helper
+	 * stream can be restarted at the next trigger; skip it while
+	 * another playback stream is still running.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	    (line6pcm->line6->properties->capabilities &
+	     LINE6_CAP_IN_NEEDS_OUT) &&
+	    !line6pcm->out.running)
+		line6_kill_audio_urbs(line6pcm, &line6pcm->out);
+	return 0;
+}
+
+/* prepare pcm callback */
+int snd_line6_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+
+	guard(mutex)(&line6pcm->state_mutex);
 
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

