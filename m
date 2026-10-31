Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473790;
	b=HabjO9x5+8ulz65pLli0g8aqHYW687E2llJq5fcgP1LXpSngXGP7ozw3htXgg28MGUuO
	 4hYlb+pspkBNhzLkPFamxYW1uj+UJYmbIyEJj9IXNtMSCuexBwSCMI7lSveDNZZcrv1m4
	 1GiACdKj58h6HXirkWJibGnxoi6NcyVKxqPu3sOYf7mC7bTzssHzClaBqQ0uBPhPSWytT
	 mdRWn4YQEDDBIWG+qrylXBEndLuRqnj6CFiPzhQixWIXW1796HQM1gRA6hMTZG7drCFyZ
	 98blSLNCugMXVf5YqxSkNZVGWy7QSBdxNyeEWuVFOM88+jrRIWJgxF0l3FTBQjdG9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473790;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=b+Qh5Uwalfg4+sQsbYwohX2NOBHbbc/nf2ild3+ohzI=;
	b=wIPu/tDt0icu52GfUFwuhzI3ClU5hIAr4jXcPa6eAvtQecVLxB5XEoYz1vC2YYSvZ0Ya
	 irFgFQl/mTCG4uSzVUJV6/dfot56ZWIWUW5lzFpXxtLH98Cv3Xpccs/T0k6pz2mhMUWFE
	 JN7CxU8j+oPgrn+1pcc5A0HfIb9b8TAaOI06nDmO/6JelpFOGOE9Vl2/Dmm4Ci01e4rLn
	 GaDbLBhZlENZZGJ+qXqCk3i6EmFcSLLhpg38gr6kXC5V9G72pFAXRSCo4/4XnCZzUC89A
	 Qlh5FZiTrSvo0r0sH/DcKHotqhv/G2FsbAjT3xLFyNxX59RSjJ6dG6ZEv2ebjgwlAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605F606A31A;
	Sat, 31 Oct 2026 19:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8605F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=b+Qh5Uwalfg4+sQsbYwohX2NOBHbbc/nf2
	ild3+ohzI=; b=OZLx7He7D9sWFx/jS8d1BqhnntFDHg2vzEGnO6cw6aH1sTzqFR
	S9/jwtY31X0kzr9yWPE6Li7aVpcL6dJ8+IP3MA38LtYakBiocNxz+ZilyQS/5Cq8
	/42lp5DfmgmF7GvVxUUqSlKYoP38by4Lq5Fi+JF82KQkOjO4Wp9I7MKgM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCm6v_xPOZquI0SAQ--.42611S2;
	Sun, 01 Nov 2026 03:09:38 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
Date: Sun,  1 Nov 2026 03:09:36 +0800
Message-Id: <20261031190936.5696-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <874ie1rbge.wl-tiwai@suse.de>
References: <874ie1rbge.wl-tiwai@suse.de>
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
X-CM-TRANSID:BLQMCkCm6v_xPOZquI0SAQ--.42611S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kCr13tFyxWF43Ww45KFg_yoW5Ar1kpF
	W8Kr4Yyr1DGrn09FySyF1kCF1Fy3Wxta4DKryrW34YyFyrXw13tay0kF15ursxCryfG390
	vF1ktFWfGFs8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6rWl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUyfb8UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2rmBsIaGwAAsC

bcd2000_disconnect() calls snd_card_disconnect(), which only prevents
new opens, and then frees the MIDI URBs.  A rawmidi file that was
already open can still be closed afterwards, and its close callback,
bcd2000_midi_output_close(), calls usb_kill_urb() on midi_out_urb.

The URB pointers are cleared on disconnect and their accesses are
serialized with midi_lock, but bcd2000_midi_output_close() reads
midi_out_urb without that lock.  The check can therefore pass just
before the pointer is cleared, and usb_kill_urb() then runs on the URB
that has already been freed:

  BUG: KASAN: slab-use-after-free in usb_kill_urb+0x74/0x80
  Read of size 8 at addr ffff8880078e7d40
   usb_kill_urb
   bcd2000_midi_output_close
   close_substream
   rawmidi_release_priv
   snd_rawmidi_release

  Allocated by: usb_alloc_urb <- bcd2000_init_midi <- bcd2000_probe
  Freed by:     usb_free_urb <- bcd2000_midi_free
                <- bcd2000_disconnect

Take the lock in bcd2000_midi_output_close() and reference the URB with
usb_get_urb() before releasing it.  The URB then stays valid until
usb_put_urb() after usb_kill_urb() has returned, even if a disconnect
frees it in the meantime.  usb_kill_urb() itself cannot run under
midi_lock, as the completion handler takes the same lock.

Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
Cc: stable@vger.kernel.org
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v3: reference the URB under midi_lock in bcd2000_midi_output_close()
    instead of waiting for open files in bcd2000_disconnect(), which
    would block the USB disconnect path on userspace.

 sound/usb/bcd2000/bcd2000.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 2bd49bf82748..0fd086cac955 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -183,10 +183,24 @@ static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
 static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	struct urb *urb = NULL;
 
-	if (bcd2k->midi_out_active && bcd2k->midi_out_urb) {
-		usb_kill_urb(bcd2k->midi_out_urb);
-		bcd2k->midi_out_active = 0;
+	/*
+	 * Reference the URB under the lock so that it stays valid until
+	 * usb_kill_urb() returns, even if a disconnect frees it in the
+	 * meantime.  usb_kill_urb() cannot run under the lock, as the
+	 * completion handler takes the same lock.
+	 */
+	scoped_guard(spinlock_irqsave, &bcd2k->midi_lock) {
+		if (bcd2k->midi_out_active && bcd2k->midi_out_urb) {
+			urb = usb_get_urb(bcd2k->midi_out_urb);
+			bcd2k->midi_out_active = 0;
+		}
+	}
+
+	if (urb) {
+		usb_kill_urb(urb);
+		usb_put_urb(urb);
 	}
 
 	return 0;
-- 
2.34.1

