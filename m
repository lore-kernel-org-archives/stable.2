Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEB4DEC09;
	Fri, 16 Oct 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164289; cv=none; b=DnLReKPQJ6FLaUz8/y0Zz1feeB+3rCwXMI1rv0/r5RYS8R5+OL4nJJ7lEPB5NADVWajS/KasZERzXRWQfk1cGnFGhjyjKgLnV3C3o6pgZfJvgu8bKsO35GS/ITfARDUffBkgNdeTRv5mSqDVbTRjVd0r7YRqbqZgWLY/VjA1Zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164289; c=relaxed/simple;
	bh=jFs9n1BfR3VD5lCN6ZXKIFXE0UT5pYthTn3LLB23l5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=omdVqUpRR2lJugM9i75+yctgiPMUxvO38wI/6/yzB2Ezmdw0XgcEN7YX1XPBZKzpwjQkxodJQTEr7g0fboUtgBlZP72Fgh/MB26TgU2zn7nUZ79WWWVADyyH+XtsK861OPln+hmiHRtKEzAFE5XK1rBCJXlKcdVSdOBYYdRgAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=LAzih0XY reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="LAzih0XY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=VHBUwNboFU
	UJcwmvxksUrPdGG8z/KFswwUvlcxH/EIg=; b=LAzih0XYBkfAf7Z+HUt+Iqq/TX
	4qLCAW5SjAXh16LJbMwFry/tBpPW06qkRzQ0YdIE+fsQbwj9D1tkYNP758jm+K1j
	p2d0jlIF8hl62gfKE7kHbLflV1WpVrElpBL22jKuzx0wwMk2x3Oj5avrnz23C9Qg
	+iQtVNEYv6gFyby8Q=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.96])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2_6tQdJqjqqrAA--.19227S2;
	Fri, 16 Oct 2026 23:24:30 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH] media: dvb-core: wait for a running frontend ioctl before device removal
Date: Fri, 16 Oct 2026 23:24:28 +0800
Message-Id: <20261016152428.10684-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkDW2_6tQdJqjqqrAA--.19227S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xAr43Ar43Gw4fXr4fXwb_yoW5KrW8pa
	93CryYkFWDCw4Iywn0vw1UJF95Aw4fGFWUKryxW3WDXr1rCa92kFyvka4UWFnxArs2yrW2
	vwn5XFy7CFZ8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUsZ23UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rSPdECvAAAsp

dvb_frontend_stop() runs in the device removal path, when the
frontend is unregistered.  An ioctl that is already running at that
point holds fepriv->sem for its whole duration, but it checks ->exit
only before it calls into the driver, so a driver callback can still
be executing while the driver state is being freed.

Two cases were not synchronised at all:

  - when the frontend device node was opened read-only, no frontend
    thread is started, so fepriv->thread is NULL and the function
    returned immediately.  Unlike the other legacy statistics ioctls,
    which return -EAGAIN, FE_READ_STATUS is allowed to run without the
    thread, so its callback can be running when the removal path frees
    the driver state;

  - when a thread exists, the thread takes fepriv->sem on its way out,
    but that acquisition is interruptible.  If it is interrupted, the
    sema_init() that followed discarded the hold of a running ioctl and
    left the semaphore with a surplus count, which also allowed two
    ioctls to call into the driver at the same time.

A use-after-free read was observed on a Twinhan USB2.0 DVB-T receiver
after the USB device had been disconnected, while the frontend device
node was still open:

  Read of size 8 at addr ffff8880068c8e90
  vp7045_usb_op drivers/media/usb/dvb-usb/vp7045.c:61
  vp7045_read_reg drivers/media/usb/dvb-usb/vp7045.c:86
  vp7045_fe_read_status drivers/media/usb/dvb-usb/vp7045-fe.c:29
  dvb_frontend_do_ioctl drivers/media/dvb-core/dvb_frontend.c:2101
  dvb_usercopy drivers/media/dvb-core/dvbdev.c:996

vp7045_usb_op() builds the receive control pipe from d->udev, but the
dvb_usb_device holding it had already been freed by dvb_usb_exit().

Wait for such an ioctl instead of re-initialising the semaphore,
whether or not a frontend thread exists, so that the removal cannot
proceed while a callback is using the driver state.  Ioctls that
arrive later see ->exit and return -ENODEV before they reach the
driver.

Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_frontend.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..076e24ea8a4b 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -817,13 +817,21 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread)
-		return;
-
-	kthread_stop(fepriv->thread);
+	if (fepriv->thread) {
+		kthread_stop(fepriv->thread);
+		fepriv->state = FESTATE_IDLE;
+	}
 
-	sema_init(&fepriv->sem, 1);
-	fepriv->state = FESTATE_IDLE;
+	/*
+	 * An ioctl holds fepriv->sem for its whole duration, but it checks
+	 * ->exit only before it calls into the driver.  One that started
+	 * before ->exit was set above can still be running inside the driver,
+	 * whose state is about to be removed, so wait for it here instead of
+	 * re-initialising the semaphore.  Ioctls that arrive from now on see
+	 * ->exit and return -ENODEV without reaching the driver.
+	 */
+	down(&fepriv->sem);
+	up(&fepriv->sem);
 
 	/* paranoia check in case a signal arrived */
 	if (fepriv->thread)
-- 
2.34.1

