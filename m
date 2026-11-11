Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370205;
	b=J1noBJ5EX/qcNI1r0M4e7fCt/qvcJb3F7wT1m46BOkfrN/WGJdxJeeGU0fERfWGXDlFo
	 99oF9NnpqNqWbzjjL2UbwnaGnYGmwiik9CplxhbRZAwKVZQsLMWzs0vDKsPU5FyfI1xkb
	 9EBuYzw2zFaR1lCSXT6PrJiNALh1dMrXUeOt/OvWLwZinhnZzUy+q5tJue6+45nRThCCn
	 MZSaDifREj+ZVF0xzi06eFhVFhubGwJ8e35Iqv3VZ8FaOM5vEy9MZdn8kRqGbOd8a3S9R
	 9LCPDIDnV8MCXPkhA+hWxJcxSPvN/uJf0m87vq99MYkZmQXQEbIAvCSs8N2HP3Jt26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370205;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=idNLXweLoPNjx3jK9Nmfy3VMz81+Rf6DURR5LGdMO8o=;
	b=I3DP5qlt+3FhMxVCC0mSoyfTI39DmbfmX3c5SkHcSHhyQZGYR5V8bjTgdB2tz3KJd73I
	 5m0vmedY/a0SVHHDky4S1b/JB8OyEyq2DQ3mL4KVHp0fGlwSXJlLw65V83fvDS/VCe3GO
	 QfQtUPcJAoDOubCBD14NoPlDnPxbiyJfBvE4A+iuqoVuuVnWQ8CNiWTLqMC88aEIPKmMP
	 hoDyVGockXO5xZupQ86hlT+uOHd/Y6sxU7mayFMVDc7RzYvITaC4dNHHZXx8rPJgAfOhR
	 KJNOpLGhTSMijqDjng42RtkZSgclkTIlaPXGWeCGSsO9W3XByq67EjJuaktbiJOJ0iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778D606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1778D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=idNLXweLoPNjx3jK9Nmfy3VMz81+Rf6DUR
	R5LGdMO8o=; b=u+S6LEVKPqRGkkyU4YQXa7ZgA+FWgZMz60hpCggKSwIIlZxt5p
	80Zsx2IpeEZDH2C5/w/tDDdpmbxXTQ9kB89j1dEKmsz0FjNcbcDdrmePaERYBOYd
	4LgQ8sf3cZbBHEWpIMaemH6ydtxAtjAasZPN3zPvtJLrjOB0m+px9/4xo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmiwGS6vNq_+ZyAQ--.14204S4;
	Wed, 11 Nov 2026 12:09:55 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/2] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
Date: Wed, 11 Nov 2026 12:09:53 +0800
Message-Id: <20261111040953.33271-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111040953.33271-1-25031212351@stu.xidian.edu.cn>
References: <20261109202440-failed-5.15-f6c7bb1f0799@kernel.org>
 <20261111040953.33271-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBmiwGS6vNq_+ZyAQ--.14204S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kCr13tFyxWF43Ww45KFg_yoW5Zr4UpF
	48Gr4Yyr4Durn09F1IyFn7CF1Fy3Z7Ja4DGryFg34avFyrX3W3tay0yF45CFsIkryxG3sx
	Z3WDtayfWFs8Cw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4
	vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOBM_U
	UUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUOD2rzNcaM4AAAsA

commit f6c7bb1f0799591a62be75b9bcf84245b4f208b7 upstream.

The 5.15.y tree is still built with -std=gnu89, so the guard() and
scoped_guard() helpers used by the upstream patch cannot be used
here.  Use explicit spin_lock_irqsave()/spin_unlock_irqrestore()
pairs instead; the locking scope is unchanged.

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
Link: https://patch.msgid.link/20261031190936.5696-1-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/bcd2000/bcd2000.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 95806e031..69c0f1b96 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -185,11 +185,26 @@ static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
 static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	struct urb *urb = NULL;
+	unsigned long flags;
 
+	/*
+	 * Reference the URB under the lock so that it stays valid until
+	 * usb_kill_urb() returns, even if a disconnect frees it in the
+	 * meantime.  usb_kill_urb() cannot run under the lock, as the
+	 * completion handler takes the same lock.
+	 */
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
 	if (bcd2k->midi_out_active && bcd2k->midi_out_urb) {
-		usb_kill_urb(bcd2k->midi_out_urb);
+		urb = usb_get_urb(bcd2k->midi_out_urb);
 		bcd2k->midi_out_active = 0;
 	}
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
+
+	if (urb) {
+		usb_kill_urb(urb);
+		usb_put_urb(urb);
+	}
 
 	return 0;
 }
-- 
2.34.1

