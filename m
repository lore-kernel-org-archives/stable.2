Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020421;
	b=Wh5JLk/j5gPjws/AAwQDpLEvpJiYhSFCWDplYU8An+Sb2W4CMgktyxlvsousj/eZLXX+
	 2H/C4add2hThrNKO56l6q3YWGP73923KdZ3j/mQpm7tahUqkLzJFfRsyJDKSRaYoBHKdB
	 P3OFcKiG/Et+vjiiR+sx3j6ANqyDj5Rn/3IynsNe5WQd07Z0mHU8OBdaivf7CmdZYOeqX
	 bAUaAues5KPT5SlwzN+ZQVUnkMKNIRQpVoF5ctOk+1xOfykDl6A+31xy07nGZKPBzyelV
	 2J/qfqnIxpvO+ezIz2p6C8C1C0KDFGHwmnNB+BpvF0BSq8B20zvlXDzrsrvSLRq+wlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020421;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Q/y7yCV+up50CdEFG6e6TuT1KUYZwO9yqWXepSDNQQc=;
	b=jPYNSxgOa0jqU/NNYasY1/tGnP2FmV4lrXE7Fw5zKDsLMebTrEMFBP2lgRsRtrZq+g5j
	 /nFLIoki15pnlIk2plyRl/ExWsEA7c3mAbVImW3PmgE4gZicE/FDq2rCpIYFNNymBkZh3
	 M+wjlfmZPKZtG3X/vSZobm2RVE4SoSCbLzmmLjU/zx63/HlIQppWD3JKSM+OmdavBZDcT
	 mM5ZZC9sYUGNqSheAgGHVBOx/AJ/vFP06YTs+UqZoPOBS88Qz5BTnplZWGJCiER+HZLqD
	 JfSOrb1G5AefLYNIRO2CN7qQxDFBU4SUKSDqfIjHafQZxV27878fG/Mgo9GArMy0/Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC1606A32D;
	Mon, 26 Oct 2026 13:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EDC1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Q/y7yCV+up
	50CdEFG6e6TuT1KUYZwO9yqWXepSDNQQc=; b=TLanqbc4Nn7CTYkSiLxdZcAOKF
	PF1nApdP2/QgfXbEd1tNUaMkgTVyXKIEmb45zCXLWRIqPu/FFNicrpJ4Dut/k4Wi
	Fic2215yYsbTL39EnXLZR1E4rXoHdr2zL7G7nuUud9nPjKIeB2XXBnCyg0/lp8WM
	efFRHxBsbba937OPo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGzwT4Ud9qpbvpAA--.46932S2;
	Mon, 26 Oct 2026 21:13:29 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] media: dvb-core: wait for a running frontend ioctl before device removal
Date: Mon, 26 Oct 2026 21:13:28 +0800
Message-Id: <20261026131328.15875-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGzwT4Ud9qpbvpAA--.46932S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrW5AF1xtF4kGw4rWF17Jrb_yoW7KF48pa
	93ArWYkFWDCws2ywnrtw48JF9Yyw4ftFWUKa42g3WDXw1rurW7CFyUKa4jgFnxArs2krWj
	q3ZYgFyUC3yDAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUyDPiUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUSD2reHcC-YwAAsv

dvb_frontend_stop() runs in the device removal path, when the
frontend is unregistered.  An ioctl that is already running at that
point holds fepriv->sem for its whole duration, but it checks ->exit
only right after taking the semaphore, so one that started before
->exit was set can still be inside the driver while the driver state
is being freed.

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
proceed while a callback is using the driver state.  The wait is done
while holding the semaphore, and ->exit is set back to
DVB_FE_NORMAL_EXIT there if the frontend thread cleared it on its way
out, so that ioctls arriving later return -ENODEV before they reach
the driver.

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
v3:
  - Release the semaphore that dvb_frontend_start() takes for a
    frontend thread when kthread_stop() stopped that thread before it
    ran, which would otherwise block the wait below forever.
  - Restore ->exit while the semaphore is held, since the frontend
    thread can clear it on its way out.
  - Check ->exit in the compat property ioctl path, which bypasses
    the check in dvb_frontend_do_ioctl().
  Code and commit message changes, from review comments.

 drivers/media/dvb-core/dvb_frontend.c | 37 ++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..89a7cb109de6 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -817,13 +817,33 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
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
+	 * An ioctl holds fepriv->sem for its whole duration, but checks
+	 * ->exit only after taking it.  One that started before ->exit was
+	 * set above can still be running inside the driver, whose state is
+	 * about to be removed, so wait for it here instead of re-initialising
+	 * the semaphore.  The frontend thread may also have exited on its own
+	 * and left ->exit at DVB_FE_NO_EXIT, so restore it while holding the
+	 * semaphore; ioctls that arrive later then return -ENODEV.
+	 */
+	down(&fepriv->sem);
+	if (fe->exit == DVB_FE_NO_EXIT)
+		fe->exit = DVB_FE_NORMAL_EXIT;
+	up(&fepriv->sem);
 
 	/* paranoia check in case a signal arrived */
 	if (fepriv->thread)
@@ -2246,6 +2266,11 @@ static long dvb_frontend_compat_ioctl(struct file *file, unsigned int cmd,
 		if (down_interruptible(&fepriv->sem))
 			return -ERESTARTSYS;
 
+		if (fe->exit != DVB_FE_NO_EXIT) {
+			up(&fepriv->sem);
+			return -ENODEV;
+		}
+
 		err = dvb_frontend_handle_compat_ioctl(file, cmd, arg);
 
 		up(&fepriv->sem);
-- 
2.34.1

