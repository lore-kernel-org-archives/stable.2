Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795338314;
	b=eBRvFi9Wy47538I4Y3rpz4p0zk+ARRRY6zKAcpRARozkHJiKLjozoUgE2bw8fREIgbcF
	 SS2eAUsJDAjwRdLVkw/D4XRUkUoTX9riqBnUGFUf/rKCzyXI7J4Gg6d+LbDTEXPEYWjtD
	 ySaclv7f9vx7tWZ9VC3pMY7/HZahepteAkNtTesvqfWFpFnnitVLEVH91muGRhQfQ7LnX
	 0TmB16yr/gOxngRHpjyR1a96poQ1Z1JRL/ewzWzNxFzMqqh5g3nPqh7W1nQxIdg5v7ZmU
	 ujXp1ri20deCsNtD/qmtpjdheMWOWGh1c5xyirrNPQBM6AN586wfJ0Aq4f+tzktRtqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338314;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=X+asBrBWRlmSSQtSLMv4yg9JDSC55SePNj+cTrr2ITw=;
	b=UwU5/gckxfKbY35aBCbROZ2ORP39lmgSkhpsnzbnnCnJUotEDQEs0vRBfOI4g7591cLl
	 jXz1VuUKFeQa+rRliKZ/svBT+2tlYndKrsR2U78AXYFKMfbpUCjEQsYeXPCnH5kYIeDPk
	 NUNojyblMxQmeCzobniENt4xKNRXG37Hvp+a1Gzf7mu3d6BYmQZh5lJnY5Orp90/Qc9vy
	 rH+y5TOj9wmqpv8e4ezmDFoF814MWL7pEqQVvwmQDr+fcSUwPVlS2NHlTadN2n5I2seVg
	 TsgYE8pCFw61oir7ACo+8IlMGrksCJHiQuPVGdKkSdABgunCU+a1gi3UKxh4b9XFp2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4A606A320;
	Sun, 22 Nov 2026 09:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=X+asBrBWRlmSSQtSLMv4yg9JDSC55SePNj
	+cTrr2ITw=; b=nb9YscixJVdcc0EM/chbva91P0sde9kpL+vj5qfCu9gCrxpONN
	wERa9eQwNQrsmMqSD2N7A7WOk04A27dHDt2dNi5WUd10ymIHZdDP+sQ+IDwUJkUl
	XkfVSJonBzeBAkodLWelF/ngrmCq4zGLWq2WD3PZVWfM+gxZmPVJy84Ho=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBWWv03sAJrDvcNAg--.1744S2;
	Sun, 22 Nov 2026 17:04:56 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v4] ALSA: line6: Stop URBs synchronously via sync_stop callback
Date: Sun, 22 Nov 2026 17:04:54 +0800
Message-Id: <20261122090454.6217-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkBWWv03sAJrDvcNAg--.1744S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW3Zry8KFW3WFy3KFyrXrb_yoWfXrWfpF
	95u345try7JF10vrW7Xws8Zw1aqw1UtFnxKw1UC39Yya1fG3W5X3W7AF1fur4DCa1v9ay3
	Zr4UXa15Gr15Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgaL9DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2sBtklR5wAAsu

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

Replace line6_wait_clear_audio_urbs() with this helper accordingly, and
drop its now redundant calls from snd_line6_prepare() and
line6_pcm_acquire().  line6_pcm_disconnect() keeps stopping the URBs
synchronously, since the device may be gone already.

The monitor and impulse streams are started via line6_pcm_acquire() and
released via line6_pcm_release() without going through the PCM ops, so
line6_buffer_release() still stops the URBs before it frees the buffer.

Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
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
 sound/usb/line6/pcm.c      | 66 +++++++++++++++++++++-----------------
 sound/usb/line6/pcm.h      |  1 +
 sound/usb/line6/playback.c |  1 +
 4 files changed, 40 insertions(+), 29 deletions(-)

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
index d17baf7761c6..dc850aa2ebd0 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -109,29 +109,33 @@ static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
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
@@ -172,7 +176,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 {
 	clear_bit(type, &pstr->opened);
 	if (!pstr->opened) {
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr);
 		if (pstr == &line6pcm->in) {
 			/* prev_fbuf points into the capture buffer we are about
 			 * to free; drop it while no capture URB is in flight.
@@ -337,8 +341,6 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type, bool start)
 		ret = line6_buffer_acquire(line6pcm, pstr, dir, type);
 		if (ret < 0)
 			goto error;
-		if (!pstr->running)
-			line6_wait_clear_audio_urbs(line6pcm, pstr);
 	}
 	if (start) {
 		for (dir = 0; dir < 2; dir++) {
@@ -510,10 +512,8 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
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
@@ -592,15 +592,23 @@ int line6_init_pcm(struct usb_line6 *line6,
 }
 EXPORT_SYMBOL_GPL(line6_init_pcm);
 
+/* common PCM sync_stop callback */
+int snd_line6_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
+
+	guard(mutex)(&line6pcm->state_mutex);
+	line6_kill_audio_urbs(line6pcm, pstr);
+	return 0;
+}
+
 /* prepare pcm callback */
 int snd_line6_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
 	guard(mutex)(&line6pcm->state_mutex);
-	if (!pstr->running)
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
 
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

