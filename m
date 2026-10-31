Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466986;
	b=P6Pt4LwzO3c7rqpaCtploE9Rnk0yigJS6SoEC7z9PIDmw8Sj01aSJEovyUjlpSq/Itny
	 GrK/EPrH/loo04voZkC30sXGZVwT/lxg47W6YnAK5TlUa2waSIYuXVlsIpclVhaA/+rGY
	 zX9qq3/z70Nf1az3Z/Z40p1ptJZde8cOiw8DcQWs8kFkor7gx1Fa5exph4toGVHvEHG9c
	 i9Iu4rRXouxExxgy7f9mqnPlCCU9Sf56cb/KFGttXKnGUSbCvEYYYHx/MRS389IEuwAaO
	 OUxSO0A/YH2yISk5K+FKSxSQKOVuY7BsaPjUi1ZWaJ3rb4a23XxIbxGNu6XiD/lF1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466986;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=U1Xw4iNZ1++V+yaBJq/cHdN3Ds+0tg3sl1/dR1osbmQ=;
	b=M3FuMtKi9QTaGiCQC22tp+ebCZafl5v9kzKv9ZIAyAOTTVhzZLkE2cWmY7fI/r6Hl80w
	 cMEOAuT3DAstC+f5m6f0Fhpkbs222NOYhD9za2EnSKhD/2Qr6ZwnNT/GB0GPPiwZw2LyM
	 kOKI/NUajiWw9/rNUjJlUAYus2kSi+1/uNc2H5/aJHCLiTJHoOPckr2jn6yzVTIXpuAXQ
	 LXq8SQq17xYnTXmKP+KbbUO8fWaiJlMumGO4BZk4Sf+OThtK9FaFTV7dkzejbSimms4DD
	 a2g7+57USuuZD6tdcbOgwTMJLJc2ft+F0KzJ8Bb4zFdA7bHFSYnYBI0pyQLQ0DMXX+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9D606A31C;
	Sat, 31 Oct 2026 17:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=U1Xw4iNZ1++V+yaBJq/cHdN3Ds+0tg3sl1
	/dR1osbmQ=; b=3W/dGc5WhirRDclRBZxs+3cmyogfEsxsOW9j4mwO73L17gX2JQ
	LR13uLu3M/bXwJtwwCG+5cFozUjrHc//96O7BY1x76Z+Rgtj5q58MyTmGOtryckq
	XEmEzrTEI00sijfzqIecYccJCHpIGCvmztw+w1anSpc8TCy01B650QFL8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2fxcIuZqs94RAQ--.16755S2;
	Sun, 01 Nov 2026 01:16:13 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: usx2y: Release the URBs when the DSP load fails
Date: Sun,  1 Nov 2026 01:16:12 +0800
Message-Id: <20261031171612.8148-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <871p95svvd.wl-tiwai@suse.de>
References: <871p95svvd.wl-tiwai@suse.de>
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
X-CM-TRANSID:BbQMCkDW2fxcIuZqs94RAQ--.16755S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UAr13Kw15tr4fGrW8Crg_yoW5uFyDpr
	WxWrZ8tryqqr4qqwsrXa1qk3W0ywsYyrW5G3y0yw48Jr17Ar1fC34rXr1q9rsrJrWrCw1F
	qFyqgrWUWrW5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIxwIDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2rmBFQQiAAAsM

snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
the interrupt URB when the FPGA firmware image with index 1 is loaded,
and then creates the ALSA devices.  If usx2y_in04_init() or
usx2y_create_alsa_devices() fails, the URBs that were already set up
are left in place.

The core keeps the index unloaded when the callback fails, so user
space may issue the same request again.  The second attempt then enters
usx2y_async_seq04_init() or usx2y_in04_init() with the URBs still
allocated and trips WARN_ON(usx2y->as04.buffer) or
WARN_ON(usx2y->in04_urb).

Release the URBs on these error paths instead.  A retried request then
starts from a clean state and the assertions keep their meaning.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2: release the URBs on the failing paths of snd_usx2y_hwdep_dsp_load()
    instead of removing the WARN_ON()s, as suggested by Takashi Iwai.

 sound/usb/usx2y/usX2Yhwdep.c |  2 ++
 sound/usb/usx2y/usbusx2y.c   | 16 ++++++++++++++++
 sound/usb/usx2y/usbusx2y.h   |  1 +
 3 files changed, 19 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 7f153a2fcdd8..13995e81d2ae 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -201,11 +201,13 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_in04_init(priv);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_in04_init error\n");
+			usx2y_free_urbs(priv);
 			return err;
 		}
 		err = usx2y_create_alsa_devices(hw->card);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_create_alsa_devices error %i\n", err);
+			usx2y_free_urbs(priv);
 			return err;
 		}
 		priv->chip_status |= USX2Y_STAT_CHIP_INIT;
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 108f9bddf9aa..8a551abe47dc 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -349,6 +349,22 @@ static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s)
 	s->buffer = NULL;
 }
 
+/*
+ * Release the URBs set up by usx2y_async_seq04_init() and usx2y_in04_init().
+ * Used when a later step of the DSP loading fails.
+ */
+void usx2y_free_urbs(struct usx2ydev *usx2y)
+{
+	if (usx2y->in04_urb) {
+		usb_kill_urb(usx2y->in04_urb);
+		usb_free_urb(usx2y->in04_urb);
+		usx2y->in04_urb = NULL;
+		kfree(usx2y->in04_buf);
+		usx2y->in04_buf = NULL;
+	}
+	usx2y_unlinkseq(&usx2y->as04);
+}
+
 static const struct usb_device_id snd_usx2y_usb_id_table[] = {
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 7b6deed17d4b..e5e26ac8dc04 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -110,6 +110,7 @@ int usx2y_audio_create(struct snd_card *card);
 
 int usx2y_async_seq04_init(struct usx2ydev *usx2y);
 int usx2y_in04_init(struct usx2ydev *usx2y);
+void usx2y_free_urbs(struct usx2ydev *usx2y);
 
 #define NAME_ALLCAPS "US-X2Y"
 
-- 
2.34.1

