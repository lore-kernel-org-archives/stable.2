Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8548BD46;
	Wed, 23 Sep 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159523; cv=none; b=nhOBIMW9xpN9LA2/TrB9CiB+GmivQ/52XnC4YkLhkrXVusDU/G5qTtd/R06MzLL7lAHFs5DIlvTnj7MM0TfwTD4cPzvMlS9YplRRQiGurID+Ga9qrKzfhvSE64SWhu2drmLX+7CFFjCO2odyQijvd3puSTEnTwJ9DHXS5+MvUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159523; c=relaxed/simple;
	bh=3ITgkxFPz1IColri678g5nG57QVgrj5EYIaEu5PHiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFnb6ybZhkTVuZGz146MzUsFGOZIjGTDfyMl4PlT8DHyqs6AK74/QMKs4TWiIPcoA0LYtViTcvjECoVb+59dR4aBfWdJMsKT56swrQbTibdW7RRlNGlGBjHC0VcX9mdidYokixKO4cHAt+B4vzJc3VkqLBiZnqGU/+OeE3HnCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=g9lz5sOa reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="g9lz5sOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=/RGotnimWk1mwS1lBuqb5bmaY1r+PDJ+z7
	W0m0eAKts=; b=g9lz5sOau+cxBbocri5kDI+j8EboEo1CojTV69Lmyj6rsFGjQi
	p0mcHh0IKVBWfifpkDBdzlORabAnXU0zMc6K3er7uLBMik+9k6lo0dVfduK+PN61
	OYZXQ5e3uu2HFBhJpI2sLB7e8Fb1oorDDOMTOBEizxnA90V4nJRAfl9aU=
Received: from localhost.localdomain (unknown [113.200.174.5])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCmK9qEqrNqdiYZAA--.17422S3;
	Wed, 23 Sep 2026 18:31:39 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuanzhe Liu <25031212351@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] ALSA: bcd2000: fix use-after-free of MIDI URBs on file close after disconnect
Date: Wed, 23 Sep 2026 18:31:16 +0800
Message-ID: <20260923103116.1666-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260923103116.1666-1-25031212351@stu.xidian.edu.cn>
References: <20260923103116.1666-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCmK9qEqrNqdiYZAA--.17422S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyUtr1xtw47JryUJry3twb_yoW7Xr1Dpa
	y8JF4UtF4DXrnI9F4SyF1kWF1Fy3Z7AayYkryrW34Yvry5Xr13Ja18tF9IvrsxCa4kG345
	ZF1qgayfWF4DCaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbv387UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2qyxZua4gAEs3

Closing a rawmidi fd of the BCD2000 after its USB interface has been
unbound crashes with a slab-use-after-free in usb_kill_urb():

  BUG: KASAN: slab-use-after-free in usb_kill_urb+0x74/0x80
  Read of size 8 at addr ffff8880078e7d40 by task amidi/30287
   usb_kill_urb+0x74/0x80 drivers/usb/core/urb.c:706
   bcd2000_midi_output_close+0xd4/0x140 sound/usb/bcd2000/bcd2000.c:182
   close_substream.part.0+0x15f/0x8d0 sound/core/rawmidi.c:560
   rawmidi_release_priv+0x21d/0x290 sound/core/rawmidi.c:580
   snd_rawmidi_release+0x4e/0xa0 sound/core/rawmidi.c:610
   __fput+0x3a6/0xac0 fs/file_table.c:510

  Allocated by: usb_alloc_urb <- bcd2000_init_midi <- bcd2000_probe
  Freed by:     usb_free_urb <- bcd2000_free_usb_related_resources
                <- bcd2000_disconnect <- usb_driver_release_interface
                <- usbdev_ioctl (USBDEVFS_DISCONNECT)

Root cause: bcd2000_disconnect() calls snd_card_disconnect(), which only
blocks *new* opens, and then immediately kills and frees midi_out_urb and
midi_in_urb. Already-open rawmidi fds, however, keep working: their
->close() callback bcd2000_midi_output_close() unconditionally calls
usb_kill_urb(bcd2k->midi_out_urb) when midi_out_active is set (which it
is, since the completion handler re-submits the out URB), and the URB
completion callbacks re-submit the URBs via bcd2k->midi_{in,out}_urb.
Both dereference pointers that were freed in disconnect -- a UAF. No
physical unplug is needed; USBDEVFS_DISCONNECT on the usbfs node triggers
the same path.

Fix the lifetime mismatch in two parts:

- Wait for the users that are already there: use
  snd_card_disconnect_sync() instead of snd_card_disconnect() so that
  disconnect blocks until all open card files are released. The rawmidi
  close callbacks then run (and call usb_kill_urb()) while the URBs are
  still valid, and no userspace-triggered callback can run afterwards.
  devices_mutex held by bcd2000_disconnect() is not taken by the rawmidi
  close path, so the wait cannot deadlock.

- Mark the device shut down before freeing: add an atomic shutdown flag,
  set first in bcd2000_disconnect(), and check it in bcd2000_midi_send()
  and in both URB completion handlers so no new URB submission can be
  queued while disconnect frees the old ones.  Also NULL the URB
  pointers after usb_free_urb() so any stray access becomes an
  immediate, diagnosable NULL dereference instead of a silent UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
---
 sound/usb/bcd2000/bcd2000.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index bebb48c..cbf6d39 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -55,6 +55,7 @@ struct bcd2000 {
 	struct urb *midi_in_urb;
 
 	struct usb_anchor anchor;
+	atomic_t shutdown;
 };
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
@@ -131,7 +132,7 @@ static void bcd2000_midi_send(struct bcd2000 *bcd2k)
 	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= BUFSIZE);
 
 	midi_out_substream = READ_ONCE(bcd2k->midi_out_substream);
-	if (!midi_out_substream)
+	if (!midi_out_substream || atomic_read(&bcd2k->shutdown))
 		return;
 
 	/* copy command prefix bytes */
@@ -212,7 +213,7 @@ static void bcd2000_output_complete(struct urb *urb)
 		dev_warn(&urb->dev->dev,
 			PREFIX "output urb->status: %d\n", urb->status);
 
-	if (urb->status == -ESHUTDOWN)
+	if (urb->status == -ESHUTDOWN || atomic_read(&bcd2k->shutdown))
 		return;
 
 	/* check if there is more data userspace wants to send */
@@ -228,7 +229,8 @@ static void bcd2000_input_complete(struct urb *urb)
 		dev_warn(&urb->dev->dev,
 			PREFIX "input urb->status: %i\n", urb->status);
 
-	if (!bcd2k || urb->status == -ESHUTDOWN)
+	if (!bcd2k || urb->status == -ESHUTDOWN ||
+	    atomic_read(&bcd2k->shutdown))
 		return;
 
 	if (urb->actual_length > 0)
@@ -353,6 +355,8 @@ static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
 
 	usb_free_urb(bcd2k->midi_out_urb);
 	usb_free_urb(bcd2k->midi_in_urb);
+	bcd2k->midi_out_urb = NULL;
+	bcd2k->midi_in_urb = NULL;
 
 	if (bcd2k->intf) {
 		usb_set_intfdata(bcd2k->intf, NULL);
@@ -427,8 +431,19 @@ static void bcd2000_disconnect(struct usb_interface *interface)
 
 	guard(mutex)(&devices_mutex);
 
-	/* make sure that userspace cannot create new requests */
-	snd_card_disconnect(bcd2k->card);
+	/*
+	 * Make sure that the URB completion handlers and the rawmidi ops
+	 * don't touch the USB device or the URBs any longer.
+	 */
+	atomic_set(&bcd2k->shutdown, 1);
+
+	/*
+	 * Make sure that userspace cannot create new requests, and wait
+	 * until all already-open files are closed so that the rawmidi
+	 * close callbacks (which may kill the out URB) run while the
+	 * URBs are still valid.
+	 */
+	snd_card_disconnect_sync(bcd2k->card);
 
 	bcd2000_free_usb_related_resources(bcd2k, interface);
 
-- 
2.45.1.windows.1

