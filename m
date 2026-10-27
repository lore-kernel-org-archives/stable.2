Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067751;
	b=QUUTvb509Ho8R5Al1oLMuh47hEwBTeCwHBqhRbFuSe4l4NqwJB4u59myYEyof2/2QnVA
	 q7cIz+K0Hkk7syiTHctsMxDqQ8z+NcwC+giHg8X4tOuSlHrK0wsMgTSlawtXHEJmHCFLJ
	 wGcevgCn9bqISgVC9TF34HEo95VQQYvrCkeB+wWnIcAwh80kPJLjW7DcoYMFVKnlGwpLb
	 JX9Sz3hLUt7EF4qbUiV64vLigUd0uoDqSXX57XyGHi/jzrqSyIze6AugA+g9rFJYBuOou
	 eI1/MEXrRe4t24eYcqJU9Q74djQ7KWFlKd75IHSsBXNpJuzTDcWyxFcblZe6HzKeCXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067751;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KZJuOZ7FxPDPoqziqkzLwr1usJTRrA9RZ4eiUv0khSw=;
	b=XDC5ExXNR0eMpFCq5FN2KgBmmDsuwV1DOcDF+r9Vpq6lTVwQS3p1+yPC7sHi5rWTVa5I
	 SZJhooDySpc9e74m8Oc54ucr3O+Dg+INSySvmzIi2k+s4BF3WULIG0D98YZiSAqGdavsV
	 OP5T8SXj4RIYYTQZtiVxQ7p+okjsBNDswWuHtFkYYLRt/PWq97Y0ZHMLpXi2ZUcZ0kj8d
	 Bc+uizX83zqC6OGpFWG1g5r9DfWQuykUVoc6YEmPaquCkZesA1vxWtuSwLOm7eRK3ifUv
	 2UqFnGUt8W2jkOKAJZjFmk8OSF3wi5Ih7VBMJDRNq2FdsItIN2u4Wrt73aCXy2G1ZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31C606A31F;
	Tue, 27 Oct 2026 02:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F31C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KZJuOZ7FxP
	DPoqziqkzLwr1usJTRrA9RZ4eiUv0khSw=; b=N+Jq5GntYmak0hdhj9FNxb5Bin
	kPZFnGtVjZCXTOfZ78Ruj0Erd8LocDNOB/q0SAbBCz9rYSH+xJ+bP8ziw6/HyO9A
	kDclMyLBuYlduhg7uUoDWDDA6WCqtNo8B4Xn0LVxRAspZeBLA3vQol7E2e5cfO3D
	9Sz1U5MiQGfSHS4yA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBma_7XCuBqUVXsAA--.1339S2;
	Tue, 27 Oct 2026 10:22:16 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] media: dvb-core: wait for a running frontend ioctl before device removal
Date: Tue, 27 Oct 2026 10:22:14 +0800
Message-Id: <20261027022214.14345-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkBma_7XCuBqUVXsAA--.1339S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW5AF1xtF4kGw4rWF17Jrb_yoWxtF4rpF
	Z3Ary5KF4DGw1xtw1qyw4DJFnYyw4ftFWUGa4xG3WrJw4rCrZ7GFy8Ka4qqF13Ars2kF4j
	qanYgFyUA39rAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bea0dUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNNOzAAAsQ

dvb_frontend_stop() runs in the device removal path, when the
frontend is unregistered.  An ioctl that is already running at that
point has taken fepriv->sem and calls into the driver, but it checks
->exit only right after taking the semaphore, so one that started
before ->exit was set can still be inside the driver while the driver
state is being freed.

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
proceed while a callback is using the driver state.  When the frontend
is being removed, ->exit is set back to DVB_FE_NORMAL_EXIT there if the
frontend thread cleared it on its way out, so that ioctls arriving
later return -ENODEV before they reach the driver.  The same function
also runs when a stopping thread is replaced on open, and
dvb_frontend_start() sets ->exit again for the new thread there, so
the restore is done for removal only.

dvb_frontend_start() takes fepriv->sem and leaves it to the new
thread to release.  If kthread_stop() stops that thread before
threadfn() runs, nobody releases that hold, which would block the
wait above forever; release it and clear ->thread in that case.

The compat property ioctls take the same semaphore but bypass the
->exit check in dvb_frontend_do_ioctl(), so check ->exit after taking
the semaphore there as well.

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
v4:
  - Set ->exit back to DVB_FE_NORMAL_EXIT only when the frontend is
    being removed.  dvb_frontend_stop() also runs when a stopping
    thread is replaced on open, where dvb_frontend_start() sets
    ->exit again; restoring it there would leave a live device
    rejecting ioctls if the open gives up early.
  - Do not claim that an ioctl holds the semaphore for its whole
    duration: the blocking FE_GET_EVENT wait drops it while it
    sleeps, which is a separate path and unchanged here.
  Code and commit message changes, from review comments.

 drivers/media/dvb-core/dvb_frontend.c | 44 +++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..ec8a6c271c33 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -807,7 +807,7 @@ static int dvb_frontend_thread(void *data)
 	return 0;
 }
 
-static void dvb_frontend_stop(struct dvb_frontend *fe)
+static void dvb_frontend_stop(struct dvb_frontend *fe, bool removing)
 {
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
@@ -817,13 +817,34 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread)
-		return;
-
-	kthread_stop(fepriv->thread);
+	if (fepriv->thread) {
+		/*
+		 * kthread_stop() returns -EINTR when it stopped the thread
+		 * before threadfn() ran.  That thread never released the
+		 * semaphore dvb_frontend_start() took for it, nor cleared
+		 * ->thread.
+		 */
+		if (kthread_stop(fepriv->thread) == -EINTR) {
+			up(&fepriv->sem);
+			fepriv->thread = NULL;
+		}
+		fepriv->state = FESTATE_IDLE;
+	}
 
-	sema_init(&fepriv->sem, 1);
-	fepriv->state = FESTATE_IDLE;
+	/*
+	 * An ioctl calls into the driver while holding fepriv->sem, but
+	 * checks ->exit only after taking it.  One that started before
+	 * ->exit was set above can still be running inside the driver, whose
+	 * state is about to be removed, so wait for it here instead of
+	 * re-initialising the semaphore.  When the frontend is being removed
+	 * the thread may also have exited on its own and left ->exit at
+	 * DVB_FE_NO_EXIT; restore it while holding the semaphore, so that
+	 * ioctls arriving later return -ENODEV.
+	 */
+	down(&fepriv->sem);
+	if (removing && fe->exit == DVB_FE_NO_EXIT)
+		fe->exit = DVB_FE_NORMAL_EXIT;
+	up(&fepriv->sem);
 
 	/* paranoia check in case a signal arrived */
 	if (fepriv->thread)
@@ -866,7 +887,7 @@ static int dvb_frontend_start(struct dvb_frontend *fe)
 		if (fe->exit == DVB_FE_NO_EXIT)
 			return 0;
 		else
-			dvb_frontend_stop(fe);
+			dvb_frontend_stop(fe, false);
 	}
 
 	if (signal_pending(current))
@@ -2246,6 +2267,11 @@ static long dvb_frontend_compat_ioctl(struct file *file, unsigned int cmd,
 		if (down_interruptible(&fepriv->sem))
 			return -ERESTARTSYS;
 
+		if (fe->exit != DVB_FE_NO_EXIT) {
+			up(&fepriv->sem);
+			return -ENODEV;
+		}
+
 		err = dvb_frontend_handle_compat_ioctl(file, cmd, arg);
 
 		up(&fepriv->sem);
@@ -3099,7 +3125,7 @@ int dvb_unregister_frontend(struct dvb_frontend *fe)
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	mutex_lock(&frontend_mutex);
-	dvb_frontend_stop(fe);
+	dvb_frontend_stop(fe, true);
 	dvb_remove_device(fepriv->dvbdev);
 
 	/* fe is invalid now */
-- 
2.34.1

