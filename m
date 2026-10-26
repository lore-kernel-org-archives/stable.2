Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023593;
	b=c2hSoE4a0XYMSo0zDR/VFNJVZaoQiXfey1O/P+umi2Gi5vtHSveKzTju+p8EvOcvltf6
	 UVD7/DD/Iz8xX3c4QfBPWnnYdh2Uh1GBt/zOcqHUyErIDWm6JVXwrBNSyWoxrDbVZ9PPY
	 RVF8LkLS3W0TBigaardoUi8bI2wtDl9sxhzdst7IrWI26GbwzvHV73m5j8paMc/ufH7me
	 QFxpf3+ctcD5I4vpDoNLfnVBqTyKKMicb4m4LxMMcQ/NGzesBKxKUzmT19uhulOpVm6LU
	 xL9fwF3RXjl/CNrh5QkkdQY34C99R2s01t4bTrSEII1J+Gp2o69kmlMWFLW0HpDBaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023593;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HmrH/TGWyb0rSuPIo9zqb3R5Gwa7ppDeLL7nHFi+ICE=;
	b=LoX3mNMOkXmpBw11ZWuoaDyOni5QzN/NmzgzUAeqmYzsTPQfa0Jt+Shl8+QmjRRCqNrA
	 aWcdffyu3/UknQbdc89B9r8J4f4MfT6Whix24EdNyeNGVj02Ho7cabNoj4+680h2k6SGt
	 eYRRGfY1LwEzLWiXXi7y/775MHJQmUgJdiENYkT2A2uK+1EdX2IY+puxocUjTj0RLFNnw
	 zmQ6cl5GGvLNARhkXXbMoMF+hhDGMvJ4E4ZadgUIVtwNXLoRbBbQ/CCqwTby1RmN85edR
	 1E1UfqYgU+6ufctEon9XXNimN/S0TJg5KUm9OOK8KQg6WOeTDJ1tQ162fJ4GZQEePmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD3606A31D;
	Mon, 26 Oct 2026 14:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=HmrH/TGWyb
	0rSuPIo9zqb3R5Gwa7ppDeLL7nHFi+ICE=; b=aFidpKlotDxiog9KDJ1un9przG
	1e0TStCYVEFGUzcU9G3EqAfArsOZaGbIBXi3kuxczun1V6sGNLqI1k+HyXsJEIJK
	69tKStdQ98t0BwQjdfM14CSjsz3chvlUb0Ur5naqDGBe2jpyTx8EvCP7VX7jeDbD
	pIirDfYYNcoJ/3UiI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkA2fQJaXt9q6ezpAA--.6916S2;
	Mon, 26 Oct 2026 22:06:18 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v2] media: dvb-core: prevent frontend thread resurrection after unregister
Date: Mon, 26 Oct 2026 22:06:18 +0800
Message-Id: <20261026140618.20173-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BLQMCkA2fQJaXt9q6ezpAA--.6916S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW3AF4kJr1xJF1UWF4Uurg_yoWxWF17pF
	WkJry5KFWqkw1xXr4vy3Zrur90vw1xGayUG347Gay3Cr1fGFWSgrW8ta4DX3W3ArZ3Jr4q
	qw17WFW8ua9rJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbpVbDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUSD2reG1PLYAAAsO

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
registration references.  The resurrected kthread never holds a reference
on the frontend object itself, so once the last file descriptor was
closed, dvb_frontend_release() dropped the final reference and freed the
frontend state while the kthread was still running, resulting in the
use-after-free reported above.

Close that window by unregistering the device node before the thread is
stopped.  dvb_device_open() invokes the frontend open handler while
holding minor_rwsem for reading, and dvb_remove_device() takes the same
lock for writing, so once dvb_remove_device() has returned no open can
reach dvb_frontend_start() any more and the kthread cannot be restarted
after dvb_frontend_stop() has killed it.  Mark the frontend removed after
the thread has terminated, so that the marker is written only once the
thread is gone.

Make the removal state sticky in the frontend as well:

- do not overwrite DVB_FE_DEVICE_REMOVED when the thread notices the exit
  condition;
- do not derive DVB_FE_DEVICE_REMOVED from kthread_should_stop() when the
  thread returns.  Restarting an idle frontend stops the thread through
  kthread_stop() as well, and treating that as a removal left the device
  unusable;
- keep the DVB_FE_DEVICE_REMOVED check in dvb_frontend_start() and the
  reset in dvb_register_frontend() as a second line of defence, which
  also covers drivers that mark the frontend removed themselves.

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
Changes since v1:
 - remove the device node before the frontend thread is stopped and
   set DVB_FE_DEVICE_REMOVED only after dvb_frontend_stop() has
   returned.  Unregistering the device node takes minor_rwsem for
   writing, so no open can restart the kthread once it has returned,
   and the marker is written when the thread is already gone.
 - do not derive DVB_FE_DEVICE_REMOVED from kthread_should_stop()
   when the thread returns: restarting an idle frontend stops the
   thread the same way, which would leave the device unusable.
 - do not overwrite DVB_FE_DEVICE_REMOVED with DVB_FE_NORMAL_EXIT in
   the thread exit path.

 drivers/media/dvb-core/dvb_frontend.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index d082b6c57c76..74c8042d84fc 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -688,7 +688,8 @@ static int dvb_frontend_thread(void *data)
 			/* got signal or quitting */
 			if (!down_interruptible(&fepriv->sem))
 				semheld = true;
-			fe->exit = DVB_FE_NORMAL_EXIT;
+			if (fe->exit != DVB_FE_DEVICE_REMOVED)
+				fe->exit = DVB_FE_NORMAL_EXIT;
 			break;
 		}
 
@@ -794,9 +795,7 @@ static int dvb_frontend_thread(void *data)
 	}
 
 	fepriv->thread = NULL;
-	if (kthread_should_stop())
-		fe->exit = DVB_FE_DEVICE_REMOVED;
-	else
+	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NO_EXIT;
 	mb();
 
@@ -873,6 +872,11 @@ static int dvb_frontend_start(struct dvb_frontend *fe)
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
@@ -3042,6 +3046,7 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	init_waitqueue_head(&fepriv->events.wait_queue);
 	mutex_init(&fepriv->events.mtx);
 	fe->dvb = dvb;
+	fe->exit = DVB_FE_NO_EXIT;
 	fepriv->inversion = INVERSION_OFF;
 
 	dev_info(fe->dvb->device,
@@ -3076,8 +3081,18 @@ int dvb_unregister_frontend(struct dvb_frontend *fe)
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	mutex_lock(&frontend_mutex);
-	dvb_frontend_stop(fe);
+	/*
+	 * Remove the device node before stopping the thread.  New opens
+	 * cannot enter dvb_frontend_open() once dvb_remove_device() has
+	 * returned, because dvb_device_open() calls the frontend open
+	 * handler while holding minor_rwsem for reading and
+	 * dvb_remove_device() takes it for writing.  This guarantees that
+	 * dvb_frontend_start() cannot restart the kthread after it has
+	 * been stopped here.
+	 */
 	dvb_remove_device(fepriv->dvbdev);
+	dvb_frontend_stop(fe);
+	fe->exit = DVB_FE_DEVICE_REMOVED;
 
 	/* fe is invalid now */
 	mutex_unlock(&frontend_mutex);
-- 
2.34.1

