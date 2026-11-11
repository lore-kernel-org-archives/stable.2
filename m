Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370189;
	b=N5KlhaW/1YMLZ/GaGjHhNynCTfiT1MPbbOdr6rUvXVGl4l1GJRmPcbeWqZTDcM2K6eIX
	 x4tsfmGgTgAGgvsI282ir1e/BTA2ORkE5CsaKcXLp6LG0I4ZrjELLM7EBiigGgbqztSLu
	 eQDOxBr0W/d8Tu+0OvYd9dvzk2e7po11pxPuRZ4PySU/v4SnE1Ox4AuRUF64m8MTL3fAu
	 7LZ0jO690/mkW/1W8vJntNr4LciZeJpjQZbRC/WEgYdgbKZKa4ATnrNz9qsbySRlgZEbp
	 YIkYtO3TYoKoAEs1Vj8TkSXtdaf08YZyCiSdYZmudYABh4vQyYARhl4Pdd+a48sxUWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370189;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=imtZJlCaSrfys7RJ7NF8fd55nCUtmAc9MKJHhtN/yOo=;
	b=imCFdVGOy/nYjVE209gqaOCuv1naMekuULzkuODPCppZGV5UdXNpBN+DW4bpfggS2UuE
	 NBd6qwHRRev4K7tC64C4h0Q6FzwrmnvjSXxPzDV9IA7cSDmSwbSNDlVagE+iz59fnVPos
	 gU38ddebVCp7v4zTx7qnIGsSfGjl/PZt24aFWtz2yaeB2YLCCWGqeidQuZo2k1k/aUoIn
	 V3UdOF7XYSnXfvAZAqOQegqM7/GCXHIiDB2Bc+iICuV4kMtKRaBOVCdYMsD17NeB7bLC4
	 kzPONIWQPlaCZ4+2ByH7fmxjcKQjjptISJuM5L7DXykFB0A+NYjUdY0rKrZSDQrqaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88106606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88106606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=imtZJlCaSrfys7RJ7NF8fd55nCUtmAc9MK
	JHhtN/yOo=; b=UWLkvw5QopHsij27wvWehyHs4cd4ELPL3yYlL7kQ6ICmsw4LxG
	XEjBAB2jQZkqmrXjN0gYeRtmYCj+yNkYgYv5TaUdIP4DT+Tyyvu6/RJkVyS1f/Zl
	auuOBcenAu8+3N0e5CjQ99/vj7uBBCCbrBWBG0coDup35Koiq8tf6VU4U=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGifyD6vNqclByAQ--.43367S3;
	Wed, 11 Nov 2026 12:09:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 1/2] ALSA: bcd2000: Fix race between rawmidi and disconnect
Date: Wed, 11 Nov 2026 12:09:37 +0800
Message-Id: <20261111040938.33215-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCGifyD6vNqclByAQ--.43367S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4Dtw1ruw17KrWrtF45GFg_yoW7Ww1rpa
	18Ga15tr4DZrn0qrW2qF4kWr1Sv3WIganFyrZ5Gw1Yyryjq3sIqa40yF13CFyayF97G39x
	uF1DK3yfGF4DCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5dsqtUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUOD2rzNcaM2wAAs7

From: Takashi Iwai <tiwai@suse.de>

commit 221253723dc58bb901c3f27a7659823e63fc598c upstream.

The 5.10.y tree is still built with -std=gnu89, so the guard() and
scoped_guard() helpers used by the upstream patch cannot be used
here.  Use explicit spin_lock_irqsave()/spin_unlock_irqrestore()
pairs instead; the locking scope is unchanged.

Although we tried to fix the potential UAF issues at USB disconnect on
bcd2000 driver, there is still an overlooked case -- namely, when a
rawmidi trigger callback has been already running at USB disconnect
handling, the in-flight function (e.g. bcd2000_midi_send()) could
still access the URB, because the previous URB NULL-check & clearance
was considered only for the URB complete callbacks, but not about the
parallel rawmidi operations.

For addressing the race, this patch introduced a new spinlock that
covers each rawmidi operation as well as the rawmidi handling in the
complete callback.  The URB is cleared with the lock, so it guarantees
that the pending rawmidi task already finished or a NULL check is
effective.

Fixes: 459d3a64766f ("ALSA: bcd2000: clear the URB pointers on disconnect")
Link: https://patch.msgid.link/20260910155227.996210-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 sound/usb/bcd2000/bcd2000.c | 45 +++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index c3312b3c4..da2c84344 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -43,6 +43,7 @@ struct bcd2000 {
 	struct usb_interface *intf;
 	int card_index;
 
+	spinlock_t midi_lock;
 	int midi_out_active;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_substream *midi_receive_substream;
@@ -90,7 +91,11 @@ static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream,
 						int up)
 {
 	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
 	bcd2k->midi_receive_substream = up ? substream : NULL;
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
 }
 
 static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
@@ -194,6 +199,9 @@ static void bcd2000_midi_output_trigger(struct snd_rawmidi_substream *substream,
 						int up)
 {
 	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
 
 	if (up) {
 		bcd2k->midi_out_substream = substream;
@@ -203,11 +211,14 @@ static void bcd2000_midi_output_trigger(struct snd_rawmidi_substream *substream,
 	} else {
 		bcd2k->midi_out_substream = NULL;
 	}
+
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
 }
 
 static void bcd2000_output_complete(struct urb *urb)
 {
 	struct bcd2000 *bcd2k = urb->context;
+	unsigned long flags;
 
 	bcd2k->midi_out_active = 0;
 
@@ -219,12 +230,15 @@ static void bcd2000_output_complete(struct urb *urb)
 		return;
 
 	/* check if there is more data userspace wants to send */
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
 	bcd2000_midi_send(bcd2k);
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
 }
 
 static void bcd2000_input_complete(struct urb *urb)
 {
 	int ret;
+	unsigned long flags;
 	struct bcd2000 *bcd2k = urb->context;
 
 	if (urb->status)
@@ -234,6 +248,8 @@ static void bcd2000_input_complete(struct urb *urb)
 	if (!bcd2k || urb->status == -ESHUTDOWN)
 		return;
 
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
+
 	if (urb->actual_length > 0)
 		bcd2000_midi_handle_input(bcd2k, urb->transfer_buffer,
 					urb->actual_length);
@@ -244,6 +260,8 @@ static void bcd2000_input_complete(struct urb *urb)
 		dev_err(&bcd2k->dev->dev, PREFIX
 			"%s: usb_submit_urb() failed, ret=%d\n",
 			__func__, ret);
+
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
 }
 
 static const struct snd_rawmidi_ops bcd2000_midi_output = {
@@ -348,16 +366,28 @@ static int bcd2000_init_midi(struct bcd2000 *bcd2k)
 	return 0;
 }
 
+static void bcd2000_midi_free(struct bcd2000 *bcd2k,
+			      struct urb **urb_p)
+{
+	struct urb *urb = *urb_p;
+	unsigned long flags;
+
+	if (!urb)
+		return;
+
+	usb_poison_urb(urb);
+	spin_lock_irqsave(&bcd2k->midi_lock, flags);
+	*urb_p = NULL;
+	spin_unlock_irqrestore(&bcd2k->midi_lock, flags);
+
+	usb_free_urb(urb);
+}
+
 static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
 						struct usb_interface *interface)
 {
-	usb_poison_urb(bcd2k->midi_out_urb);
-	usb_poison_urb(bcd2k->midi_in_urb);
-
-	usb_free_urb(bcd2k->midi_out_urb);
-	usb_free_urb(bcd2k->midi_in_urb);
-	bcd2k->midi_out_urb = NULL;
-	bcd2k->midi_in_urb = NULL;
+	bcd2000_midi_free(bcd2k, &bcd2k->midi_out_urb);
+	bcd2000_midi_free(bcd2k, &bcd2k->midi_in_urb);
 
 	if (bcd2k->intf) {
 		usb_set_intfdata(bcd2k->intf, NULL);
@@ -397,6 +427,7 @@ static int bcd2000_probe(struct usb_interface *interface,
 	bcd2k->card = card;
 	bcd2k->card_index = card_index;
 	bcd2k->intf = interface;
+	spin_lock_init(&bcd2k->midi_lock);
 
 	snd_card_set_dev(card, &interface->dev);
 
-- 
2.34.1

