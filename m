Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D43B71C9;
	Sun, 27 Sep 2026 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501912; cv=none; b=H6i0zSGKe/HVLb8n2BGA0yfzerHGGOv3WuxKMyyYBCKDj3i2xL1OjlpAeCEJ1jWTUvBGAcv6xcpU6/MgrecrIcntJmu0UpObjG5RJ0H6oVBeXvIA10EXQNzVpB06TyJ+5xEM/PjcRXMH2AAZZzraU+E9vmL0AjbwmEe5dcvBfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501912; c=relaxed/simple;
	bh=2l4Hi3y9o3HxQSFPtHdBa11ZZwacjHWpt7g2c4kS1sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agCMcbEmTpz/bDIc8e4Jg0X6cy4X/YRa3qtqecCDnralAjAK0S9D2fPxHlStdKw8Jid1CcU0UAhClgKqjcKQVGN0GMnHDYtZKwg1Vg0sHcmEgwIHPj5vrlFtOSuV1rsVlllpMjDEs0RGYSqzPDj7IQLccGXSoCDeFSJmLh2fg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZUb0TGbf; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZUb0TGbf"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f3b6cf2d;
	Sun, 27 Sep 2026 17:38:14 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] ALSA: mpu401: shut down timer before freeing MPU
Date: Sun, 27 Sep 2026 17:38:09 +0800
Message-Id: <20260927093809.681726-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e23ab9d103a1kunm5d6e184b1af966
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEJOVkMaT08YTU5KGEIaTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZUb0TGbfGnyLDTmBtkeUjihSrTN/Iuujf7EX2knV3k9p8iWF2LAuVvnwhxEZrlFYO5tS+uJ39S64hTq5luMeoBMhScH3nbRoUB+qK85kWCQfECGu9Vxa7ReiBLpiFYTxybcFr+4P8EKuawGUPCfXgU2THpx2CCu2Me0+kcTuOv8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=HOPBJDR0pukmgoFg4cqmMdY+N2Zflb5+jqfGmgNcjZk=;
	h=date:mime-version:subject:message-id:from;

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
---
 sound/drivers/mpu401/mpu401_uart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 6de03d72a908..fcf2b686f9f5 100644
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
2.34.1
