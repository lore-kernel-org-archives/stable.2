Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126E374E67;
	Sat, 17 Oct 2026 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202177; cv=none; b=CEBsSpSyeN9imlOS8b8YicPyte3+Fd6jNC6W8lHN1tsY4kT2CBiYBiR4MgIIatEE6qlYy01jm8VGPQsLkptqa57RIWbglL8iQyc6VcQ2RBd4suLzUbkf8Yn8Xx4e+Wo48tRui4IQIjHp/ewEKxg3nLZKy2w1Y6bVqQW5CR6Z8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202177; c=relaxed/simple;
	bh=45WcHNsOVp1HM/8758RiYYNvHu7k+O2D8ACwzC9ol7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rd/BhGSOgZBGRChoD4SmHawYr4ffKXnMtv654l5O41byIeYY9OFDAkJ2IoRp1hkrgQvClbu0Cd1l7L/omBK228WvieBs9+6MOgjXDgD5Yigm36uO53C9aBPcBY+wSoyIBlouRQAzzXKw3GJC9s5s8jXAcMSP7xRJvIhs1cVSduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=PKA3cJVa reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="PKA3cJVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=N1yKU6KUXc
	N58NtjXxKl0TZoGUc3TbGdFqR8Lm4dw1M=; b=PKA3cJVamnrhxz/9IPqfjx+O6n
	BjO91HPTeRkvcchnoZ6hLZtcsXpeF3BXivs6LkhX/ImxR+2dJimN+dPgRpp+DmlG
	UjbOjWVfDUEohJ9N0YcICd/36jlUkTqEmLDRPIuQqNbAoUJs2Y4GLp2+8Ht5vNLY
	dNY/TSJ9xU6y68Z7w=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.50])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2PgSq1dJqqf2tAA--.53186S2;
	Sat, 17 Oct 2026 09:55:54 +0800 (CST)
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
Subject: [PATCH v2] media: dvb-core: wait for a running frontend ioctl before device removal
Date: Sat, 17 Oct 2026 09:55:53 +0800
Message-Id: <20261017015553.5846-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkD2PgSq1dJqqf2tAA--.53186S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xAr43Ar43Gw4fXr4fXwb_yoWrZrW5pa
	93AryYkFWDGw4Iywn0yw18JF95Aw4fJFWUK34xGw1DXr1rCFZ2kFykKa4UWFnxArs2yayj
	q3ZagFy7CFWDAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUJD2rSQD1C9wAAsx

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

Both the early return and the semaphore reset have been in this
function since the initial git import of the tree.  An attempt in
2022 to close this race, commit 6769a0b7ee0c ("media: dvb-core: Fix
use-after-free on race condition at dvb_frontend"), waited for every
user of the device node to close it, and was reverted by
commit ec21a38df77a ("Revert "media: dvb-core: Fix use-after-free
on race condition at dvb_frontend"") after it blocked the open path
for minutes.  The wait added here covers only the ioctl that is
still running, and is taken after the frontend thread has exited.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
  - Add the Fixes: tag that the media CI requires when Cc'ing
    stable@vger.kernel.org.
  - Quote the referenced commits as 'commit <id> ("<title>")' in
    the description.
  Commit message only, no code change.

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

