Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336103;
	b=DdzcLJw2SonN5fbTAGr4FarOGzwm6mr4P0lg0dXA2R9ho/Op4/3TKYXehis0wmZQX4TZ
	 hGELUnCMO3plDQECAVVsGNPHMOU0ha1/IItK6WwRzTzcWxG1fKQ+b5vjFPmjZD2b+JRcv
	 iyaFwu2taX1IkwaG0ni5+w5jY9m4DM0sRyPFH22c0IQ/gBHjHntdnxWrF4G0TSnZnB6nT
	 0bzj22c+0/urEPFk3eZLEONvkIvsCHVdoGAbCURGEbJUAw3MjCT0iz2SnV3+QJvXpFsv7
	 iWRS2Bp+OHQVKD1q9gccqxUrU0OyQACxpaFgw0L4NO5EgvDoJByqGBDM/NxwDqsUT9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hxRf8whrXGLetCHBrJ6e1C3oIkTkwpG5Ny6Kk54iEMs=;
	b=Zm8gA6T0yT3yKcZqqUjG1WQ+0ZKr3vbHnc+Pb+IzlITM6wBfQq05x76tHiG//EEtA2+U
	 7Iu9kbsK3oMGRoJQJBkXHoXpZTJDKdefza+dhXHeI0gehO44B8FuL1FJqloLZ2dGcDJFs
	 kWPwqDpv6WzmM/DbaoRhNt8gsB4kEM+86WVp5Hx/vZyudGSgf45NbmUgEYU7Tdwpg5ykq
	 KRkB0iPejOJ3xAVqhacEXE1bsmjuJHy9h+pFC94PzG2sqxxR+/Qa4vJqyGDpHo5UOqYBI
	 Qn6o7NgXG4P8Isn2MqdidNNoK/JL9DpTDCCVgEcvk0E5fgWLSiVAvOL0f2EJEuvzwqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYduN6LR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F1606C6DF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYduN6LR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C231F0089F;
	Tue, 10 Nov 2026 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336103;
	bh=hxRf8whrXGLetCHBrJ6e1C3oIkTkwpG5Ny6Kk54iEMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYduN6LR0ng5Vx+fJyP5/nLg8550FMolenvcC2ZnLf564bu/1ycVnvgy+MOel47Cu
	 cVRY7T5XYmcKUGq27Fk8BbgPVppbOFyb+k7y5P3YQ+5tq2MFm/AQdyzF6ixKLIHMxc
	 BjZhNjOWvy/BnvXJht30hamgMIETrPL57LSmDHa3bkZ99YF0rDIASaVwAQAiiDfSvF
	 P5143x4+t7aa5jyL3/YsBoL+rVCnOCSoekzZfcB74zI6CCydqfer4QStT+c6e9RfKo
	 y/0No68nQQfKS6CwjgKEenuA43lnos2VH/Tzq4u1Id2WoeO5wYaivb5qEy/APJG6tG
	 2acGHn6W82Szg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: mpu401: shut down timer before freeing MPU
Date: Tue, 10 Nov 2026 13:41:41 -0500
Message-ID: <20261110184015.2886320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061719-failed-5.10-9332af5220d4@kernel.org>
References: <20261107061719-failed-5.10-9332af5220d4@kernel.org>
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
[ sashal: Replaced unavailable timer_shutdown_sync() with timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 65982d6babfc6..b8df6bf288ad4 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -161,14 +161,15 @@ static void snd_mpu401_uart_timer(struct timer_list *t)
 
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
@@ -176,7 +177,6 @@ static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 
 	spin_lock_irqsave (&mpu->timer_lock, flags);
 	if (mpu->timer_invoked == 0) {
-		timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 		mod_timer(&mpu->timer, 1 + jiffies);
 	} 
 	mpu->timer_invoked |= input ? MPU401_MODE_INPUT_TIMER :
@@ -484,6 +484,7 @@ static void snd_mpu401_uart_free(struct snd_rawmidi *rmidi)
 	struct snd_mpu401 *mpu = rmidi->private_data;
 	if (mpu->irq >= 0)
 		free_irq(mpu->irq, (void *) mpu);
+	timer_delete_sync(&mpu->timer);
 	release_and_free_resource(mpu->res);
 	kfree(mpu);
 }
@@ -537,6 +538,7 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 	spin_lock_init(&mpu->input_lock);
 	spin_lock_init(&mpu->output_lock);
 	spin_lock_init(&mpu->timer_lock);
+	timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 	mpu->hardware = hardware;
 	mpu->irq = -1;
 	if (! (info_flags & MPU401_INFO_INTEGRATED)) {
-- 
2.53.0

