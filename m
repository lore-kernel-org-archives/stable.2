Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472258;
	b=eMYdE5acmBwLu//G5LPp4qYnfNRQvlc1FVr83ywbtWdhedK0QqmkaSAaCsXkUWoeOC/a
	 DJyBRFkYDWg7njVK6Bwu+6ccgloPwnj+P6JeBB9w+uJL1mm5A7nDpZEtheSQWpCHAAH1+
	 sQV+gaC6F03m/vL7uRFoFjCAJWkz28ddFLSt3KR3YcUj0DpGd2oYcM8UUPWgF9TZWNNK4
	 3f+HawapKd0U6h37XQsh2RFEcFf64n99AAhfCopVar1PmK4IU4ZyAaQkJfEh/Hh0hGIdW
	 ej5jj6EUhQa2/BBGzuIRe09vqEM4SRXrEpFsJa71W5OVO7DmdK2tPUKV5lEfuxdH5sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472258;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=rW3sBoDWZ7+6/zNMEDP54qtzm+oUsOkgUooSKVHjvnE=;
	b=ByxpB9w6RJVbsuUkUk+GHNsnILIi0tWOkuC6B324jvKNavq/369MIfy11Yc/mvuO66n0
	 HmEi6fZF2gDJjaZiuHPkonhOf/n7fDubipEfX4B1Yo0DQ7nIpHfJL6zKCbhYs8w34SIE4
	 w3hQHPOLpae3eHtpjenJT61egsrO+e38C9EP4W2acU95l5eHeNYQcTlLPojcKt44M8i9+
	 5HDCb8nJ2gLJK20GF1KN3eS4XMdKFup3rXdPyCKJKneFsoj3XalWJon6IZ48Gcb1wXDiz
	 bH0VsqFspIKT5DEU2GI61hNzc/7nju1ckJvqyloIUx+rhhy49JcAGczCQ7dv22bgg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273AF606A31A;
	Sat, 31 Oct 2026 18:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=rW3sBoDWZ7+6/zNMEDP54qtzm+oUsOkgUo
	oSKVHjvnE=; b=M0vuX5uI1PaxrtiOReeq78r1ZKJL1gf7IIJ7twZ9yXDXJCvEbJ
	y3uCGCM2JXSWh+mwD/MI79jbVpJ9nKpOlHYYyVGC9riTv+TIfZqSmeU/ZT32u6mq
	hWToSsfH+2tvsMnIIe832cPGSBadI3UVUNQ/dfHa+x35K0XEb2uSJYnjg=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmhPr1NuZqna8SAQ--.14611S2;
	Sun, 01 Nov 2026 02:44:06 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: bcd2000: Wait for open files before freeing the MIDI URBs
Date: Sun,  1 Nov 2026 02:44:05 +0800
Message-Id: <20261031184405.15307-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBmhPr1NuZqna8SAQ--.14611S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kCr13tFyxWF43Ww45KFg_yoW5Xry5pF
	Wvgr48tr4Dur1YkF1fZFnrGF4rA3WkAF98C34rWwn0yry5Zr9xtF48K3WUuanrCFyxG34Y
	vr1DW3yfXan5C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUkuMNDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2rmBFQW-QABs+

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

Use snd_card_disconnect_sync() instead, so that disconnect waits until
all open files are released.  The rawmidi close callbacks then run while
the URBs are still valid, and no userspace-triggered callback can run
afterwards.  The devices_mutex held by bcd2000_disconnect() is not taken
by the rawmidi close path, so the wait cannot deadlock.

Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
Cc: stable@vger.kernel.org
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2: rebased onto v7.3-rc7.  The URB pointer clearing and the locking are
    already handled by 459d3a64766f ("ALSA: bcd2000: clear the URB pointers
    on disconnect") and 221253723dc5 ("ALSA: bcd2000: Fix race between
    rawmidi and disconnect"), so this version only keeps the change of the
    disconnect ordering, as suggested by Takashi Iwai.

 sound/usb/bcd2000/bcd2000.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 2bd49bf82748..a5e8ea92532c 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -451,8 +451,13 @@ static void bcd2000_disconnect(struct usb_interface *interface)
 
 	guard(mutex)(&devices_mutex);
 
-	/* make sure that userspace cannot create new requests */
-	snd_card_disconnect(bcd2k->card);
+	/*
+	 * Make sure that userspace cannot create new requests, and wait
+	 * until all already-open files are closed so that the rawmidi
+	 * close callbacks (which may kill the out URB) run while the
+	 * URBs are still valid.
+	 */
+	snd_card_disconnect_sync(bcd2k->card);
 
 	bcd2000_free_usb_related_resources(bcd2k, interface);
 
-- 
2.34.1

