Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472990;
	b=eBPwcsariwNO0BCicCVN45iMrYGPz8OFS9b7FVsiHCs5PxHJZQQW3lUDohLmhbDaLVer
	 DnTd4lBQh5anu+Zc5BAbapjVJxnhL+3zzwa8MWB8HmEZnYNpDSZPPiSyYmXk9yDndASAk
	 kED6ixVqanwwysxzlYh83PgE9tbPYlnne7r5k81N+jyiqioSUTW/A6E8rHOSX5fuc2dCk
	 JLsGPLJ5YLYNma4MsjFlmsS5E0ylBpglsiQPEt7PzywE6OR2UT5Jm7+Reeb0kQIfqZfTh
	 6yqzsSyJ1JUKGK1f+4GGcDPYhZKRiUtP+hAfKNhPr8vVGAq0FA/LSdcxCxw8iDNp1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472990;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Xq2fDK7M5xkF2oQ83GyUxxkY9YeTLIfIvFOZOQkkAd4=;
	b=oVNpdj1IJRhMMWfo1nAiZa/GDL5i1SJUPa9C84OgPlDLkuIBvJMp7mjvpVHGfuhpL46i
	 hsaDOBL2Yj2+ExXDF41Z1J0i8OGp3iqHIn0LgAolacZMNVi1euO8NXBHhlZNqd6pUwkTN
	 vlJ8keQcxEQPJDV1Z+1nQQTMlus8ICVsE3GvnMfVLay/9s++y83TERhdFERTWrijej3Wf
	 uzfZaCTZOvpeHaKMcyonqOLLktKT5FEVLfoI7A+0El+l63UF3giFm7k9NaNdamz1RqYIG
	 dGxrkWCxwmY+HRmGaGRkVTrE5rfljk4SpzOW0tQ8sqfk3mFls7PWMPNIobIHYUwaMdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0216606A31A;
	Sat, 31 Oct 2026 18:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0216606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Xq2fDK7M5xkF2oQ83GyUxxkY9YeTLIfIvF
	OZOQkkAd4=; b=APTiQzemIGay2r1izSnYYAK7Qo0sojlYASzjCr0yAxVNeZav9I
	27S0SBeQ3EbfMsNHywejJSCZCETszLTXmYc8ZMFKuCyKYVdi5G/vb1yq0WbT493X
	dsVmSvRyDKsCaAXT/L1iKSbFEf2O7g0qP5m+4guJPGB9367i6y3GtFCVo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDG6wHTOeZqnLkSAQ--.14664S2;
	Sun, 01 Nov 2026 02:56:19 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] ALSA: usx2y: Release the URBs when the DSP load fails
Date: Sun,  1 Nov 2026 02:56:19 +0800
Message-Id: <20261031185619.18601-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkDG6wHTOeZqnLkSAQ--.14664S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UAr13Kw15tr43tFWUArb_yoWrCr47pr
	Z7WrZ8trWqqr4q9w4qqa1qk3WFyw4vyFW5G39ayw4kJr1UAryfC34FgF1j9FsrJrWrCw10
	qrWq9rW5WrW5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUyH7NUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2rmBsIY4QAAs6

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

Release the URBs on these error paths instead, so that a retried
request starts from a clean state and the assertions keep their
meaning.

Releasing the URBs also lets a retried request reach
usx2y_create_alsa_devices() again, on a card that keeps the MIDI and
PCM devices created by the failed attempt.  For the US-428 the audio
streams would then index usx2y->subs[] past its end, so do not
initialise a partially created card a second time: mark the chip as
hung when the ALSA devices could not be created, and refuse further DSP
load requests.  A failure of usx2y_in04_init() leaves the card
untouched and remains retryable.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v3: do not initialise a partially created card a second time.  A failed
    usx2y_create_alsa_devices() now marks the chip as hung, so a retried
    DSP load request returns -ENODEV instead of running the ALSA device
    creation again.

 sound/usb/usx2y/usX2Yhwdep.c |  6 ++++++
 sound/usb/usx2y/usbusx2y.c   | 16 ++++++++++++++++
 sound/usb/usx2y/usbusx2y.h   |  1 +
 3 files changed, 23 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 7f153a2fcdd8..366167c62575 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -179,6 +179,9 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 	int lret, err;
 	char *buf;
 
+	if (priv->chip_status & USX2Y_STAT_CHIP_HUP)
+		return -ENODEV;
+
 	buf = memdup_user(dsp->image, dsp->length);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
@@ -201,11 +204,14 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
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
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
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

