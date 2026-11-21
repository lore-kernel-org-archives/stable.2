Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257612;
	b=E/e5pZfSujy2JkLOW+UJuw8jdI3m7nH2Vz8aWi+wM/FdngHA90yCYf0SStL0+SBO7fto
	 G85R0giQ44NPm1ESNNhmCM/u2apagQABVusNANPnPaK5s5LPAmdsooIGMWgRLY81Jeyxx
	 gXSqOuvQz6k16n3kCqlwbbXrN6wk5Ap46DQAyR6yHSgikSRONmxCIg2hClfSDpe1V1oAj
	 dvDoq0roLrEyRUg28e/VcCVE2THLdig79szns7d8hU35vhgAzq0J0+UrwzZ0k/ZU3bSEV
	 G5Kc/KIcNL3cVkplQ2r090Cdnse8xPnNXR6awUub+Z+kEKOV/sVDkx1hfwm2WGVoLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257612;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CuKgNakrBL5RzZXrKyZdOYYbQEIx+TxxRG5v4oUIGAE=;
	b=mxRSuoQmcH87/UINXBpuq8Y0XH0Pe9S2KDnlZLJpkVxvOQQN5QFtumBOQSdhHscqAp5V
	 gStyMx6G5d7iNmcT1GMiS7SiOYZ7XVKz5xrdaG4amFdZ6yvyCUUHqAMfOBzBW1eXKsVEY
	 BDfNa2F4+795m3rxcuTi0E+CmALq/eitGUd4sYkqsM7FwbG03L6HEmFS07yB3HIOJqd2L
	 jYd1bkLro2YE1uaF2MV5Pjn2D0ocsui2puoiF4q81ujukHvucuD3wyXr4/+DCb4V0NNxu
	 DuNxWHDymFLX3uRbFhVp6s+iap2nWVRJXVbqTkUXgVH7QQcG6D8c2l5QaKy4EPFB8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114EF606A320;
	Sat, 21 Nov 2026 10:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=CuKgNakrBL
	5RzZXrKyZdOYYbQEIx+TxxRG5v4oUIGAE=; b=eZzc2eBc3hoYFBcwNc3j2GKOob
	G7Ud06UgAQ9fnD8OXBrKWwqEKl6pQbD3XSR4X4Q/46XGj+VbCCG6+iJM7NMF7jna
	LYvRrbWf/U9b8UwDuSrxhOiFDJ7SJz85giLLk/RQcJW7Wo2LUxxZ9DWyRMJ6DRfG
	aN1PL2f4yHfQeuHzA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCm6v8AdQFrmesAAg--.42348S2;
	Sat, 21 Nov 2026 18:40:01 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3] ALSA: line6: Kill URBs before releasing the PCM buffer
Date: Sat, 21 Nov 2026 18:40:00 +0800
Message-Id: <20261121104000.5431-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BLQMCkCm6v8AdQFrmesAAg--.42348S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1xXrW7uF17GrWrCw1rWFg_yoWrAw4xpr
	95ua4YkFZ8JF1I9rZrJws5Xw1Sva1kXFnrGF17JrWUAa13Gwn0qa4SqF45Wr4DCana9Fya
	vFWYyw4rGr45Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU59db7UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sAYljOOwAAsr

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

Set the unlink bit for every currently active URB under the stream lock,
so that the completion callbacks cannot resubmit them, and then kill all
URBs synchronously.  usb_kill_urb() waits for the giveback, hence the
buffer is no longer referenced by any URB when it is freed.  Drop the
unlink marks afterwards: line6_unlink_audio_urbs() can leave a stale mark
on an URB that completed and was not resubmitted, and such a mark makes
line6_stream_start() skip submitting the URBs.

Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v3:
- Kill the URBs unconditionally instead of rechecking active_urbs outside
  the stream lock, and clear the unlink marks after the kills.

v2:
- Rebased on sound/for-next.  v1 was generated against v7.3.1 and no longer
  applied, because line6_buffer_release() gained the prev_fbuf clearing
  block in the meantime.  No code change.
---
 sound/usb/line6/pcm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index d17baf7761c6..4be3b41a98a2 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -134,6 +134,36 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 			"timeout: still %d active urbs..\n", alive);
 }
 
+/*
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
+{
+	int i;
+
+	scoped_guard(spinlock_irqsave, &pcms->lock) {
+		for (i = 0; i < line6pcm->line6->iso_buffers; i++)
+			if (test_bit(i, &pcms->active_urbs))
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
+}
+
 static inline struct line6_pcm_stream *
 get_stream(struct snd_line6_pcm *line6pcm, int direction)
 {
@@ -172,7 +202,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
 {
 	clear_bit(type, &pstr->opened);
 	if (!pstr->opened) {
-		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		line6_kill_audio_urbs(line6pcm, pstr);
 		if (pstr == &line6pcm->in) {
 			/* prev_fbuf points into the capture buffer we are about
 			 * to free; drop it while no capture URB is in flight.
-- 
2.34.1

