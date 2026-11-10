Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330106;
	b=nCgHrRG56jO1/kVe7WiJP2WW/20p/FN/5yDAL8McJRtt3G25Ev0HhLZ2Fi1DwEpDCBrb
	 tDnM1tUHsitCt9YdGq0zNjCzVW4GI5INtxo6VrVcceHHko1ScZ/+qqm4bpufkie7Weqtd
	 wTVct26A5HHAuFGNnwKTprc6r2MT6opPKYxgihEuL2uDUrZXLQ9WraOvS4XQprEGyWCQy
	 4uOTZVwilh7J/ObicCYdxbYZ3xd1bYjcFGPiOaw0+bl/KaiCrLjePtCVguBcqbgu0ntQm
	 KMu4J4pXz/LxyiVeItPAX5oSTT4kr7YErM2jy0YymbnhQ2ilLLohTJikpBZ3uvYkCWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZEfJ+FoBZE/WPYeBgWFbac0JSzMWG12Id7xGOgbY0Tc=;
	b=lvSgbsUfwz8MCgxEsfz5UeLTEcxzAIyZUyoj5LBcSkWgSvqoW1M0+OotunZB5Ns18610
	 SSvO7WCf/2mOTjsKztFJYNZJuAWT81Htk9XY5h7xkfIfeZ/HD14MCN/+XZDvhGjKQKwik
	 ci1A+hD01IkHh11XjVF3SI7UGWnGpukHoqChpUWyNaDhoWHBwVIGQXQtKqZve8GS36fVX
	 7lcIieWAqyPTyhksTXaUWgVPiqASn4latomR7gtTYVOGeTmexBEP6kPnfH+orEkPEGHk/
	 ObPUHFqYoKP3bX/MRQ9sgRn6p7O9WqNuZjkKUPGjyyUYsTA1diklL7a7blPMdJb7pmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjyJr583;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE50606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjyJr583
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0C21F0089F;
	Tue, 10 Nov 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330106;
	bh=ZEfJ+FoBZE/WPYeBgWFbac0JSzMWG12Id7xGOgbY0Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjyJr583MbXWqFk5NEICoILgaQSK47orGBWFrKaG2QyUS7sdY7PM3Gpv5MdDDNPO+
	 MkXqxHXpbVGnmiERnFXPL7ZSpDZA6q5rzkhT85RrWUCVrmeh4W2bu+NXgu1oiAQudF
	 PEr6SqKtepF84p19dPBmanb4Ov44+Yk8OEDi1eP9I7Wiwz93JHREYWDPGNF+E+zXN9
	 BImJVsadSj5ZjnpSU0Cx4P1SqPFJRMpcS7eCGkTsZolEsaFXLXCDg+S+m+UW3w7iLY
	 MIJbF8bho8LbYLSk0DBviH/mbQFfjfTz4V50KygG9Cy0B0xGn1Q6W8qd5Iw0aZuup3
	 4EclWLdcuCCpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: mpu401: shut down timer before freeing MPU
Date: Tue, 10 Nov 2026 12:01:44 -0500
Message-ID: <20261110170127.2610182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051758-failed-6.12-9332af5220d4@kernel.org>
References: <20261107051758-failed-6.12-9332af5220d4@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 9332af5220d42341bb1446a62c545c0518e990ef ]

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
[ sashal: Adapted scoped_guard() locking to the existing spin_lock_irqsave() and spin_unlock_irqrestore() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 8e3318e177179..86235aefab02d 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -162,14 +162,15 @@ static void snd_mpu401_uart_timer(struct timer_list *t)
 
 	spin_lock_irqsave(&mpu->timer_lock, flags);
 	/*mpu->mode |= MPU401_MODE_TIMER;*/
-	mod_timer(&mpu->timer,  1 + jiffies);
+	if (mpu->timer_invoked)
+		mod_timer(&mpu->timer,  1 + jiffies);
 	spin_unlock_irqrestore(&mpu->timer_lock, flags);
 	if (mpu->rmidi)
 		_snd_mpu401_uart_interrupt(mpu);
 }
 
 /*
- * initialize the timer callback if not programmed yet
+ * arm the timer if it is not already active
  */
 static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 {
@@ -177,7 +178,6 @@ static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 
 	spin_lock_irqsave (&mpu->timer_lock, flags);
 	if (mpu->timer_invoked == 0) {
-		timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 		mod_timer(&mpu->timer, 1 + jiffies);
 	} 
 	mpu->timer_invoked |= input ? MPU401_MODE_INPUT_TIMER :
@@ -493,6 +493,7 @@ static void snd_mpu401_uart_free(struct snd_rawmidi *rmidi)
 	struct snd_mpu401 *mpu = rmidi->private_data;
 	if (mpu->irq >= 0)
 		free_irq(mpu->irq, (void *) mpu);
+	timer_shutdown_sync(&mpu->timer);
 	release_and_free_resource(mpu->res);
 	kfree(mpu);
 }
@@ -547,6 +548,7 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 	spin_lock_init(&mpu->input_lock);
 	spin_lock_init(&mpu->output_lock);
 	spin_lock_init(&mpu->timer_lock);
+	timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 	mpu->hardware = hardware;
 	mpu->irq = -1;
 	mpu->rmidi = rmidi;
-- 
2.53.0

