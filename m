Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370189;
	b=R+L9ZPOQRPoMI4TVIYqNj9V4B13u45Bwqr30xBe8nrzPtQ1qOa0R+mI8KAyFn0kNN3nE
	 xLwpLtpIPv/2CcINdyYLUes3IDoYoIqgcCV6S0GslGl/YBqBBNxUhoOvnXK6gfS4z8lX9
	 usCURQpMTdm4uhNFbJrrXoKZU5WObPz6nKLaCpFAD5SvK85Q/0Ejj2/o7Gi6x0aVN1i/t
	 H+bt3rGPNXqDcTWKmhXg3i4Hc7qAcKZ/Iw/SuA744ZPOwGVrIF7LkDQQ27awtkSP8hIPR
	 YQe9AP3wbgqw2Ga3/TuD6EU3xCk8j4rrk+g0uOOj09iLyAN8jvBmjNK3NHx4ZeBmv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370189;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=gQY5hXxv/GLlI8dyssHZ5Geq68YVzQILwEJ/2EY8I9I=;
	b=G8t4X382l3XYv4gxjMchlMaCXamYSYf/r575UqOYXTGLfinykpqjeULw4luPwZymW1as
	 i7HmIkfkSkY6Yjk+d6MKYpHQme4WBG6LPICV50llbszCD16XbifBNIU0BXqD8493t3ApO
	 Bjt7vOVHXdI+xQpLUWQODBb/GrCg+tJ9QRwCQ/3Srl2i/tjf7EB6T7myHLACeHmYYAqPu
	 dZobrjnbld7B3uhR0JOLPn9fiX6p1NAefJ0gOkoluyWKR3cpMJCWk6axNxlmlZ7dxVCaB
	 aciBEF/kWXC7i/SPoONGW59ka1ffl4r8R1FW4oHAyxlh0q4wamQ563RcbynGHqw61bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF7B606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF7B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gQY5hXxv/GLlI8dyssHZ5Geq68YVzQILwE
	J/2EY8I9I=; b=DLn71OiFAi2s9halAfNaL1upk+p9qHxNXqZOj57wgvRChJDonD
	mRbyPlYmaBMALhKBvDGfBaMeaUXSHr1ChwCy2zrX084WrOoH8Xll0nxamCE9+Zim
	LRH/PLwxSXbv/OdVfAaZAcZ8KrrPTb/1C8Hdmz4edAhkcV337T+IFoYc8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGifyD6vNqclByAQ--.43367S4;
	Wed, 11 Nov 2026 12:09:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 2/2] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
Date: Wed, 11 Nov 2026 12:09:38 +0800
Message-Id: <20261111040938.33215-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111040938.33215-1-25031212351@stu.xidian.edu.cn>
References: <20261109202905-failed-5.10-f6c7bb1f0799@kernel.org>
 <20261111040938.33215-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCGifyD6vNqclByAQ--.43367S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kCr13tFyxWF43Ww45KFg_yoW5Zr4UpF
	48Kr4Yyr4Durn09F1IyFn7CF1Fy3WkGa4DGryFq34avFyrX3W3tay0yF45CFsIkryxG3sx
	Z3WDJayfWFs8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5yCJJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUOD2rzNcaM2wABs6

commit f6c7bb1f0799591a62be75b9bcf84245b4f208b7 upstream.

The 5.10.y tree is still built with -std=gnu89, so the guard() and
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
index da2c84344..ff11d673a 100644
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

