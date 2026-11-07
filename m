Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049233;
	b=HHr+mQMWxzcXDDX+CPktwejSIZ+DiZc3nYioPluf/JEVEVFKd8sBiHLfAfnepjKrXzzS
	 d6UJ0rtUu7i6fPMxa0sQznM+DA5Ax+BtlzC/lrvg3VAOSYRNFRAvpjUB0Hi+c2Aa4PSB6
	 U6TlhweAGfY91S7dv3OWuZA2PYa+UHnQxIzABa5YCo1pdA4S4Idf2i/Q933pSEBLpiXBn
	 /RlieOKSNSwieKTCSd3Z4YyoAqKs0Hf/w7Mum3Yl3tfS/NpUv5i6C7yQjPGZNwJcmFQcj
	 Ska4RAZW0wklnM3xjB+SNI8ekpq+B/nvwNG2KfH6W7qwH6L9JvxUIa4xuESdLO4XKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tD0znRbnEpcJWVQ5GcH7Fsj6l11HHYhzcGL2ABD4zLE=;
	b=DsohQxUMlixhVQb4agCqc0YTNmhEc6J/S1mDSKTMVhoRQbIOoLGYe9ftwyPBAtFwVEX8
	 eA8CS5sVQSKJGJ7MompQUVdsp3PPZGwrT+gbu5lDKApy1wA8s3FgVbUA/Kp4HEiGZsoaH
	 frDEeuU/BYzonWuoHYDEKl133nTKSwArodfvM2Dxs4JF/GnFuwgecPsj5Wncu374EXMge
	 dnygLTmsnmfLrCCewXrJ3J/1lE06MSvoLG/PXuYXtLQkwc38KucbKqzgXIjHxOcOVCRbb
	 W44SR26vsCK4QBRY4gkWYfq1TZImWhEiGsp6ssQKe66K18ArgRyPjzLLj0+r7N51HRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRNH+tK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C55606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRNH+tK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0221F0089F;
	Sat,  7 Nov 2026 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049233;
	bh=tD0znRbnEpcJWVQ5GcH7Fsj6l11HHYhzcGL2ABD4zLE=;
	h=From:To:Cc:Subject:Date;
	b=BRNH+tK4iDvRTYau2ezT+3+J9PxfldzWrzLsO0uxrEqBnc8py1B8tl7sJMXbxiDtZ
	 +J8zmXFH80qlu+oyyoyZPu/p6ecZJWTXrcuM0J6T20fKASaNB1Ez8S1VvQLHl2Ef27
	 glGN85paKUxrCRJe4GPIlVeeNPkxecugWCtQXN/0NkdWRO+kMtW0/CzVrJo9HU7b2D
	 vucq9N6x/vvKJPx9UrOJWxJKe/Pu5OO24Km3Mn5mRE0LkSYVX/g1CvrN4vel6DDCpH
	 LJBZW0H1m2tgScdG4NKXahVp3fj+6bUOLPpmkli+D5aVffZjrUCYD86y+mNS3QIgaU
	 PejSOCu2VmkVQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: mpu401: shut down timer before freeing MPU" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:31 -0500
Message-ID: <20261107060031-failed-5.15-9332af5220d4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9332af5220d42341bb1446a62c545c0518e990ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060031-failed-5.15-9332af5220d4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9332af5220d42341bb1446a62c545c0518e990ef Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun, 27 Sep 2026 17:38:09 +0800
Subject: [PATCH] ALSA: mpu401: shut down timer before freeing MPU

When an MPU401 interface has no usable IRQ, the driver polls raw-MIDI
input and output with a timer. During raw-MIDI teardown, the timer callback
can already be running when snd_mpu401_uart_remove_timer() clears the last
mode bit and calls timer_delete(). That API neither waits for a running
callback nor prevents it from rearming the timer, and free_irq() does not
synchronize timer callbacks. snd_mpu401_uart_free() can therefore release
mpu while the timer callback still uses it.

Initialize the timer once when the MPU object is created and only rearm it
while a timer mode is active. Shut it down synchronously after freeing the
IRQ so an in-flight callback completes before mpu and its resources are
released.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260927093809.681726-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 6de03d72a9087..fcf2b686f9f5e 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -155,20 +155,20 @@ static void snd_mpu401_uart_timer(struct timer_list *t)
 
 	scoped_guard(spinlock_irqsave, &mpu->timer_lock) {
 		/*mpu->mode |= MPU401_MODE_TIMER;*/
-		mod_timer(&mpu->timer,  1 + jiffies);
+		if (mpu->timer_invoked)
+			mod_timer(&mpu->timer,  1 + jiffies);
 	}
 	if (mpu->rmidi)
 		_snd_mpu401_uart_interrupt(mpu);
 }
 
 /*
- * initialize the timer callback if not programmed yet
+ * arm the timer if it is not already active
  */
 static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 {
 	guard(spinlock_irqsave)(&mpu->timer_lock);
 	if (mpu->timer_invoked == 0) {
-		timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 		mod_timer(&mpu->timer, 1 + jiffies);
 	} 
 	mpu->timer_invoked |= input ? MPU401_MODE_INPUT_TIMER :
@@ -474,6 +474,7 @@ static void snd_mpu401_uart_free(struct snd_rawmidi *rmidi)
 	struct snd_mpu401 *mpu = rmidi->private_data;
 	if (mpu->irq >= 0)
 		free_irq(mpu->irq, (void *) mpu);
+	timer_shutdown_sync(&mpu->timer);
 	release_and_free_resource(mpu->res);
 	kfree(mpu);
 }
@@ -528,6 +529,7 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 	spin_lock_init(&mpu->input_lock);
 	spin_lock_init(&mpu->output_lock);
 	spin_lock_init(&mpu->timer_lock);
+	timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 	mpu->hardware = hardware;
 	mpu->irq = -1;
 	mpu->rmidi = rmidi;
-- 
2.53.0




