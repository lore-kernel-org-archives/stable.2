Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330952;
	b=NHShvkEXdI8dAboC0eojdCUHI3cRX4JfvmeFNjDTQ9veyKtaZ2xfaPvqTEPQ9JFlhTPC
	 1HNs+I80QCZ0qT+L8YXO5/yztMuAyOh794m8kxD5AS9WS6aFnPKw8FtwBNAo13q51mEUL
	 C0fAUKiwTfjHFv2+DdV8WSqhkulKrMGklYIRXPgM0znostAjtYFcu2qe583tYUquCyXgQ
	 84edkbbWbCPitrduNiJbEksHstF5qqWq2WdRTWqveFj3y/M8xSFZurRtCpbyMPoNC/O9M
	 gE240OfstPCDualVUTskegDC/Wfez+2n3NSwDWEjuc4Are4y1Xk3kJVtuXgwqmuiQxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vtuHy6jvbktSiyM4/wGY117xUnty90W7uRaDmT5Xbw4=;
	b=g9n1u+FEfPrro5o3Icn3lkoI5zoWoDxMjoNTSGTMRQ8u61TOQvM0/QAaNawinnngQlmI
	 jILTYQWpQIptyalgIKz+Q9e+f0SH4C77kV6jsssqUpsL0qID8uRrYGBWACPh/73GdrpgE
	 69pMibfVJe+igH8xnU1mbhCP3rCALjlNpTmVESUalNIJde4qkfh1zxYgXId80pr4cu19g
	 qtChFQP7kEp9DzFl2R5krUApT/TQyVcsgBbXt9K4RxmLGo9WhdqZZROr3KdQbZKPZ4SOC
	 Jg+2fhmpfct24q/AYx+k0L6VMHv626Q/bpE5HZOEzuM0tXQqcB4mkwgsDwHAqCfdocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFoWQqLt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFoWQqLt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9268D1F0089F;
	Tue, 10 Nov 2026 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330952;
	bh=vtuHy6jvbktSiyM4/wGY117xUnty90W7uRaDmT5Xbw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFoWQqLtNATIUNRzkF+mQ/C35CeIw/ILo9LAgyJjp0Y7HCq9gRs5VRBPRCCMJsPhz
	 xAXrXeUXdjz6Vtco7DCUIni6q5QuudCA1n1ayurxKlwSvL3zNHewSaZGUD4EAoknPc
	 MyLgj61/aD3uMIowir/vGK+O8ttiFr5rcSdWX6QSSrrIjpXJw1ta6qZGkW5UmUrQQE
	 x4oxoP13+Lngb+PvJx21EcBv5TO1YKyk5/k5PENWzzcOISVsChM3UE5yAY4wUuFAMV
	 NFnZIuVFiMDhnwg8AVjPrTT+TUU14fZ737roXiE9r3uCyO+ym3+KmbzWYH2LtzNPa9
	 TdMEc/IlrCqLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: mpu401: shut down timer before freeing MPU
Date: Tue, 10 Nov 2026 12:15:50 -0500
Message-ID: <20261110171516.2731239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060031-failed-5.15-9332af5220d4@kernel.org>
References: <20261107060031-failed-5.15-9332af5220d4@kernel.org>
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
[ sashal: adjusted context for explicit spin_lock_irqsave()/spin_unlock_irqrestore() calls instead of guard-based locking ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index f435b9b4ae241..e920a290ba1b6 100644
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
@@ -490,6 +490,7 @@ static void snd_mpu401_uart_free(struct snd_rawmidi *rmidi)
 	struct snd_mpu401 *mpu = rmidi->private_data;
 	if (mpu->irq >= 0)
 		free_irq(mpu->irq, (void *) mpu);
+	timer_shutdown_sync(&mpu->timer);
 	release_and_free_resource(mpu->res);
 	kfree(mpu);
 }
@@ -544,6 +545,7 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 	spin_lock_init(&mpu->input_lock);
 	spin_lock_init(&mpu->output_lock);
 	spin_lock_init(&mpu->timer_lock);
+	timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 	mpu->hardware = hardware;
 	mpu->irq = -1;
 	if (! (info_flags & MPU401_INFO_INTEGRATED)) {
-- 
2.53.0

