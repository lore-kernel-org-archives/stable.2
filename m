Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0234EF03;
	Tue, 29 Sep 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672056; cv=none; b=Two0IPY2pqhfRiZhYfb3Bb9oa3wY72Kttyzdn1lgzI6QZU6TAPn16KtYXR1UBUMM5N5rIGqOS/GOecIQNgQ18uaJMqmeob3Q4ll7fGb0iggBHooxznOJEmSH5r6qvuJXDvbOHN2iJaqzfEMEdhnWmODGgD8DN88446w5YCDRN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672056; c=relaxed/simple;
	bh=lUrySG/jm80puZrcq02QzsRK7Mp2Ld9acO27B5sNS5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ac9KHXtGYWnzb0xb3/w+Op5heNqXCMGdYptRYaAVMNebF96LwduJP0qaSAekx3YmP3ZBfpY75+8Bm/dkEuSPE+Sm37ECSx/Ecaah+2VkGfY89C99VKzCox+/VD309bEJztwmKp6vqxCivVs2AMV1lS7mdc5+F7nghPCgwtalcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GSjuP/oO; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GSjuP/oO"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f7b7026e;
	Tue, 29 Sep 2026 16:54:08 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] m68k: dmasound: Keep the Q40 IRQ handler registered
Date: Tue, 29 Sep 2026 16:54:00 +0800
Message-Id: <20260929085400.2068977-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ec5f110a03a1kunma537a55d232819
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaThoZVhkfTkwfQ0ofT0JKGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GSjuP/oOg5AurSnebE2QRMIF3Bi8wTRrs0eBFtIY+Z9uK7pclQWL8Xfnv6JJfZCbzC7Y0X1prwI/bQmUJf4QWzTDSFx9oyLuEvoOWd67OhIa26U2l1Ob8P3t3iaN2rwYUmTmMnKs2226SbwKKWu/9XzaXtOf+y90oIzY0P0AI/w=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=AoWEI7pahTOAco4vMxztOXzb5FoJIqqWUv3rtaSs8rg=;
	h=date:mime-version:subject:message-id:from;

Q40PlayNextFrame() re-registers the sample IRQ after stopping it. This
function can be called with dmasound.lock held and from the sample IRQ
handler, so free_irq() and request_irq() can sleep or deadlock. A failed
re-registration can also leave playback without an IRQ.

Register one handler for the lifetime of the driver and select mono or
stereo sample handling inside that handler. Call the frame completion
path after releasing dmasound.lock so it can refill the queue safely.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/oss/dmasound/dmasound_q40.c | 65 ++++++++++++++-----------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_q40.c b/sound/oss/dmasound/dmasound_q40.c
index e25a78dd1..339311e5d 100644
--- a/sound/oss/dmasound/dmasound_q40.c
+++ b/sound/oss/dmasound/dmasound_q40.c
@@ -49,9 +49,8 @@ static int Q40SetFormat(int format);
 static int Q40SetVolume(int volume);
 static void Q40PlayNextFrame(int index);
 static void Q40Play(void);
-static irqreturn_t Q40StereoInterrupt(int irq, void *dummy);
-static irqreturn_t Q40MonoInterrupt(int irq, void *dummy);
-static void Q40Interrupt(void);
+static irqreturn_t q40_audio_interrupt(int irq, void *dummy);
+static void q40_frame_done(void);
 
 
 /*** Mid level stuff *********************************************************/
@@ -372,8 +371,8 @@ static void Q40Free(void *ptr, unsigned int size)
 static int __init Q40IrqInit(void)
 {
 	/* Register interrupt handler. */
-	if (request_irq(Q40_IRQ_SAMPLE, Q40StereoInterrupt, 0,
-		    "DMA sound", Q40Interrupt))
+	if (request_irq(Q40_IRQ_SAMPLE, q40_audio_interrupt, 0,
+			"DMA sound", q40_frame_done))
 		return 0;
 
 	return(1);
@@ -384,7 +383,7 @@ static int __init Q40IrqInit(void)
 static void Q40IrqCleanUp(void)
 {
         master_outb(0,SAMPLE_ENABLE_REG);
-	free_irq(Q40_IRQ_SAMPLE, Q40Interrupt);
+	free_irq(Q40_IRQ_SAMPLE, q40_frame_done);
 }
 #endif /* MODULE */
 
@@ -403,7 +402,6 @@ static void Q40PlayNextFrame(int index)
 	u_char *start;
 	u_long size;
 	u_char speed;
-	int error;
 
 	/* used by Q40Play() if all doubts whether there really is something
 	 * to be played are already wiped out.
@@ -420,15 +418,6 @@ static void Q40PlayNextFrame(int index)
 	speed=(dmasound.hard.speed==10000 ? 0 : 1);
 
 	master_outb( 0,SAMPLE_ENABLE_REG);
-	free_irq(Q40_IRQ_SAMPLE, Q40Interrupt);
-	if (dmasound.soft.stereo)
-		error = request_irq(Q40_IRQ_SAMPLE, Q40StereoInterrupt, 0,
-				    "Q40 sound", Q40Interrupt);
-	  else
-		error = request_irq(Q40_IRQ_SAMPLE, Q40MonoInterrupt, 0,
-				    "Q40 sound", Q40Interrupt);
-	if (error && printk_ratelimit())
-		pr_err("Couldn't register sound interrupt\n");
 
 	master_outb( speed, SAMPLE_RATE_REG);
 	master_outb( 1,SAMPLE_CLEAR_REG);
@@ -456,31 +445,35 @@ static void Q40Play(void)
 	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
-static irqreturn_t Q40StereoInterrupt(int irq, void *dummy)
-{
-	spin_lock(&dmasound.lock);
-        if (q40_sc>1){
-            *DAC_LEFT=*q40_pp++;
-	    *DAC_RIGHT=*q40_pp++;
-	    q40_sc -=2;
-	    master_outb(1,SAMPLE_CLEAR_REG);
-	}else Q40Interrupt();
-	spin_unlock(&dmasound.lock);
-	return IRQ_HANDLED;
-}
-static irqreturn_t Q40MonoInterrupt(int irq, void *dummy)
+static irqreturn_t q40_audio_interrupt(int irq, void *dummy)
 {
+	bool frame_done = false;
+
 	spin_lock(&dmasound.lock);
-        if (q40_sc>0){
-            *DAC_LEFT=*q40_pp;
-	    *DAC_RIGHT=*q40_pp++;
-	    q40_sc --;
-	    master_outb(1,SAMPLE_CLEAR_REG);
-	}else Q40Interrupt();
+	if (dmasound.hard.stereo) {
+		if (q40_sc > 1) {
+			*DAC_LEFT = *q40_pp++;
+			*DAC_RIGHT = *q40_pp++;
+			q40_sc -= 2;
+			master_outb(1, SAMPLE_CLEAR_REG);
+		} else {
+			frame_done = true;
+		}
+	} else if (q40_sc > 0) {
+		*DAC_LEFT = *q40_pp;
+		*DAC_RIGHT = *q40_pp++;
+		q40_sc--;
+		master_outb(1, SAMPLE_CLEAR_REG);
+	} else {
+		frame_done = true;
+	}
 	spin_unlock(&dmasound.lock);
+	if (frame_done)
+		q40_frame_done();
 	return IRQ_HANDLED;
 }
-static void Q40Interrupt(void)
+
+static void q40_frame_done(void)
 {
 	if (!write_sq.active) {
 	          /* playing was interrupted and sq_reset() has already cleared
-- 
2.34.1
