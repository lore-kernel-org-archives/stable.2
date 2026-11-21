Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255033;
	b=bv3eDoulXnGbd1M//bhx9qiuTAxR97oXC78/0NiLFp0i2hWoM83tgoXa6WY0FjnO357l
	 JsnTP5+JXO0SpTh0Jo21fAR+HxqDUVAfRioRcCOLMxTSaD8mVrttobd+w+vEi+bUD1YIr
	 kNCnxHGGmKbZB2qYCI8UKrMe2ObkTuAyy4lpJS0iV7NkaO+JazffKRotEXZ+orqnQWzJ2
	 4/9apAXoWEUmv34elbmHZnKCaqIgPACBW3wNw8ICWy911aDNWWB5XKssAFk9vt2glgzI9
	 riub0MV0+OIjxHFqI0F50TzlvRveQI7ZkJUV+fiAAjdURyg4wjULzFlvf3b7+5Tm1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255033;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Fg0BrQ2AmWJzVUSo6unSAaTvw32B62rJbYlFXw4O8BQ=;
	b=BvSUdV6xQV7O7o7WNT9w6S+S3/zcFDwoGckHAvsSZ9jo+Xzz/gKLbYaT0AhwkzXM16FW
	 hhSHTa9dGEZ4Wo0fzFMBz+FFtVOs+gw7+U7HDcGgM+VxVhUhNGsFqg1NP6l0P6o0VLYm6
	 kc4ohPmPUWtSFm5/dTmV9tcKobmcq5HEFXJh/zRI/+zh67HRRpW85yrt0Hcnv0tWSZ/27
	 qIzwDjT4yLRPMO/1ZUePMB6ArYIiHWREqaYZUKScQEPbbnlDMHwQCwGUsMckEIcirSWOZ
	 KIwDRQFBnTwmi5hqm47yNLZstBAQlBE6CZFA8+ez6olqHPxdKeXIRet7hwW2kjQdl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484A606A320;
	Sat, 21 Nov 2026 09:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B484A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Fg0BrQ2AmW
	JzVUSo6unSAaTvw32B62rJbYlFXw4O8BQ=; b=r5MVXTc9aLtHbl3zX69ZROw8Sd
	2o4QdKqNhp7SR38QZDu0R5H/CX8xLeiuIVLZAjfX2yvy/fZoMLHTH/wN6rxCC+lI
	sGn2NZpkClUZdamHz2vY1/0xiWOQ9NH31asL68ylSXr1816qMJHDwumDaJNZo65z
	tUrqHtwrBzt4tbKmA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCmxfvcagFrVH0AAg--.46391S2;
	Sat, 21 Nov 2026 17:56:44 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] ALSA: line6: Kill URBs before releasing the PCM buffer
Date: Sat, 21 Nov 2026 17:56:43 +0800
Message-Id: <20261121095643.8196-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCmxfvcagFrVH0AAg--.46391S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1xXrW7uF17GrW7Gr4DArb_yoWrJFykpF
	95Wa4YyFZ8JF4IkrW7Jws3Ww1Sva1kXFnrGF1UAryrAa13G3Z8Xa4aqF45Wr4UCan2vaya
	vF45tw4rGry5Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUED2sAZMnEuAABs3

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
so that the completion callbacks cannot resubmit them, and then kill them
synchronously.  usb_kill_urb() waits for the giveback, hence the buffer is
no longer referenced by any URB when it is freed.

Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
- Rebased on sound/for-next.  v1 was generated against v7.3.1 and no longer
  applied, because line6_buffer_release() gained the prev_fbuf clearing
  block in the meantime.  No code change.
---
 sound/usb/line6/pcm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index d17baf7761c6..6a8983507a39 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -134,6 +134,31 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 			"timeout: still %d active urbs..\n", alive);
 }
 
+/*
+ * Mark all currently active URBs for unlinking and kill them.
+ *
+ * The unlink bit is set under the stream lock, so the completion
+ * callbacks cannot resubmit these URBs any longer; usb_kill_urb() then
+ * waits until each of them is given back and hence the stream buffer is
+ * no longer referenced by the host controller.  This function must be
+ * called from a sleepable context.
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
+		if (test_bit(i, &pcms->active_urbs))
+			usb_kill_urb(pcms->urbs[i]);
+}
+
 static inline struct line6_pcm_stream *
 get_stream(struct snd_line6_pcm *line6pcm, int direction)
 {
@@ -172,7 +197,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
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

