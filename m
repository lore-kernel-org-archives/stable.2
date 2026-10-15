Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7647ACCB;
	Thu, 15 Oct 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049066; cv=none; b=kvhbpYsJ5TgNaStQxG9wEaAN3IorrNzdChsvUm39EC4T2IhnnKPa4e2rVw6zrwAsG2j4mSVwLbuZT68nA09YXo/6U1CNAtRvrh8YtdQHI5GjJRc7JwjAce0bicFFa5wEEl8QRf6467Ubq5fiIErzql6nLNced+zpkzHzUw5Ew/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049066; c=relaxed/simple;
	bh=JkHHNgajNIi21dLKcEUnhbwqeP1oYRSfSI+q1Lv0snE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WN13+1QVruvm3JshFvYZbAqdstNx6cWzrYTmq9A017Ix05UBxUS+KFqL+854N7LP5V1f42T+tgT+E1bC/SWxDI2cZUO7ip3W0BN0vEHDDBhEj3Kjau4XQfCgPDy9pBIsHY+dJX+6tat5JHAB41aAyYBa2x80iMdjCvUScf8RbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=VTF7R2QP reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="VTF7R2QP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=PCKRTBESFf
	T+/ncAMlToa5Ok9BfMsEykK8bbFWXICZU=; b=VTF7R2QPfE5L2GXX6hn3TwebYv
	/lgsDlgL1k9c38Wy6SB6Ly1+BDxsc0XQKqO8aCdyOS4D2zCNttrUhmAtBTJNPNrC
	z6AoBkj0X/zerPg+b0T0JvRWSXahsl+GDAYHHD6LEOXlMd6dNEhXNo0/Ke4h7QTc
	ZHRYmxOSm0rUTYzqo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.94])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDGDwWCf9BqbMmgAA--.38329S2;
	Thu, 15 Oct 2026 15:23:47 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH] media: dvb-core: prevent frontend thread resurrection after unregister
Date: Thu, 15 Oct 2026 15:23:45 +0800
Message-Id: <20261015072345.11129-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkDGDwWCf9BqbMmgAA--.38329S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW3AF4kJrykCw1fAF4Utwb_yoW7XFW8pF
	WkJry5KF4Utw12qr4qy3Zrur90vw1xGFWUG347Ga13Ar4fGFWIgry8ta4DXrnxAr4fAr4q
	qwnxWFW8u3y7AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQID7UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2rPmtGsgwAAsN

A use-after-free read in dvb_frontend_thread() was observed when a DVB USB
device was disconnected concurrently with userspace opening and closing the
frontend device node:

  BUG: KASAN: slab-use-after-free in dvb_frontend_thread+0x1380/0x1620
  Read of size 8 at addr ffff888008dd4320
  Comm: kdvb-ad-0-fe-0 Not tainted 7.1.2-dirty #81
  dvb_frontend_should_wakeup drivers/media/dvb-core/dvb_frontend.c:641
  dvb_frontend_thread drivers/media/dvb-core/dvb_frontend.c:682

  Allocated by the frontend attach path:
   cinergyt2_fe_attach+0x... (drivers/media/usb/dvb-usb/cinergyT2-fe.c:271)

  Freed by the final frontend release:
   dvb_frontend_put+0x... (drivers/media/dvb-core/dvb_frontend.c)
   dvb_frontend_release+0x... (drivers/media/dvb-core/dvb_frontend.c:2934)

On disconnect, dvb_unregister_frontend() stops the frontend kthread through
dvb_frontend_stop() and unregisters the dvb device, but it never marked the
frontend itself as removed: fe->exit was left at DVB_FE_NORMAL_EXIT, or at
DVB_FE_NO_EXIT when no thread was running.  dvb_frontend_open() does not
hold frontend_mutex, and dvb_frontend_start() did not check the removal
state at all, so an open racing with dvb_unregister_frontend() passed the
DVB_FE_DEVICE_REMOVED check in dvb_frontend_open(), unconditionally reset
fe->exit to DVB_FE_NO_EXIT and spawned a new kthread on a frontend that
was being removed.

dvb_unregister_frontend() and dvb_frontend_detach() then dropped both
registration references.  The resurrected kthread itself never holds a
reference on the frontend object, so once the last file descriptor was
closed, dvb_frontend_release() dropped the final reference and freed the
frontend state while the kthread was still running, resulting in the
use-after-free reported above.

Fix the lifetime break by making removal a permanent state:

- set fe->exit to DVB_FE_DEVICE_REMOVED in dvb_unregister_frontend()
  under frontend_mutex before stopping the thread; dvb_frontend_stop()
  already preserves this value and dvb_frontend_is_exiting() then makes
  a running thread exit immediately;
- check DVB_FE_DEVICE_REMOVED in dvb_frontend_start() after taking
  fepriv->sem and fail with -ENODEV; the thread's exit path writes
  fe->exit under the same semaphore and dvb_frontend_stop() returns only
  after kthread_stop() observed that write, so the check cannot miss a
  concurrent removal and the unconditional fe->exit = DVB_FE_NO_EXIT
  reset can no longer undo it;
- do not clear DVB_FE_DEVICE_REMOVED in dvb_frontend_thread() when the
  thread exits on its own, so the removal marker survives;
- initialize fe->exit to DVB_FE_NO_EXIT in dvb_register_frontend(), so
  a frontend object that is registered again after unregister remains
  usable.

em28xx already sets DVB_FE_DEVICE_REMOVED manually before unregistering
its frontends; the core now provides this protection for every dvb-core
user.

Fixes: 1f862a68df24 ("[media] dvb_frontend: move kref to struct dvb_frontend")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_frontend.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index d082b6c57c76..d06f16b2ab84 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -796,7 +796,7 @@ static int dvb_frontend_thread(void *data)
 	fepriv->thread = NULL;
 	if (kthread_should_stop())
 		fe->exit = DVB_FE_DEVICE_REMOVED;
-	else
+	else if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NO_EXIT;
 	mb();
 
@@ -873,6 +873,11 @@ static int dvb_frontend_start(struct dvb_frontend *fe)
 	if (down_interruptible(&fepriv->sem))
 		return -EINTR;
 
+	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
+		up(&fepriv->sem);
+		return -ENODEV;
+	}
+
 	fepriv->state = FESTATE_IDLE;
 	fe->exit = DVB_FE_NO_EXIT;
 	fepriv->thread = NULL;
@@ -3042,6 +3047,7 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	init_waitqueue_head(&fepriv->events.wait_queue);
 	mutex_init(&fepriv->events.mtx);
 	fe->dvb = dvb;
+	fe->exit = DVB_FE_NO_EXIT;
 	fepriv->inversion = INVERSION_OFF;
 
 	dev_info(fe->dvb->device,
@@ -3076,6 +3082,13 @@ int dvb_unregister_frontend(struct dvb_frontend *fe)
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	mutex_lock(&frontend_mutex);
+	/*
+	 * Mark the frontend as removed before stopping the thread, so that
+	 * a racing dvb_frontend_open() cannot restart the kthread via
+	 * dvb_frontend_start() and leave it running after the last
+	 * reference on the frontend object is dropped.
+	 */
+	fe->exit = DVB_FE_DEVICE_REMOVED;
 	dvb_frontend_stop(fe);
 	dvb_remove_device(fepriv->dvbdev);
 
-- 
2.34.1

