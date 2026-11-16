Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819224;
	b=J3dwdeAto8n7zJJGIBrJH4OePnHaaKfHQyd+1GbeW/BqI6Ome3LXRhMb8WRohSPLVpkA
	 sSsyJNt5MsRg8l0TFZI3xznNEG5V2n9o4dK7W3g3BU/5KK4bhA9kI3LSZsfRbkEs8fEN2
	 phk+K3vLO5NXgRt/bD+JQ/lC6mjvG38ZckrIGgAFwkOYMY/xQIQxxbF68HnAMnLmMS0zG
	 GkQwkQbSH2eI/fEFAUlilC51DnBZNiBZsyb8CmaNdtQ/fg4yc8GGElPpHaelTQApEX6Dq
	 CBLyabJvt6Ur/D1KQvM4ZyupHb49hyJCwYIjvRyukbgFWpJdOnpU6ffGN2KoVNt7rIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819224;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=gsHe6c6lRbMYZcSq9KWEJivUoTmxsVWW6P/M/igGehA=;
	b=hTu6I3Luoxomd5nzFp64J0k1NT7POG+DhNvHG16yEpK2hyM07yk/oQ/CXfY+NP9YXvWY
	 pl1eYh+OJK/47GhQ2EDkrm+8AWvDeANAhNp5d/hAhGG5oFnmubvTRu91IWEFfbtzEAc4u
	 Vbx2aA9EhL5Ud6YryFqafuTghgmvoGSBjJyVNfk+/PN7c/kHmPUQM7SuxXEV8Fql6lhcr
	 MtnpVXgo+YrUMMoEluSo5x5mlLf55OQgxnar2kyWUXv1Uw1eEFtCK9R/DM+WTjA+1SGyO
	 kazmudibRflDAdxaepW67UzOR8oNmANsQGHvH5QIO3uXlj4/lnoYYh87jnzllny8jGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA38606A32A;
	Mon, 16 Nov 2026 08:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA38606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=gsHe6c6lRb
	MYZcSq9KWEJivUoTmxsVWW6P/M/igGehA=; b=ID3o2F3frx1brUxS8TuEo/L/2x
	Ofrd95cvHhL6dKSI+S2/v1VLOIaynAicOmYaP/uVXRjMmrwQaV38UY8IG0HyMN96
	aJBCzRfySp69iTn3P+L9CWuv6C/rUxT9jGINCIEf3CK7CtiiX0eGMmCMivFtQm79
	EmV7SvOsjtjIcDNAk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2uv2JxPpqL2G1AQ--.43460S2;
	Mon, 16 Nov 2026 16:53:31 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] comedi: defer freeing async areas that still have pollers
Date: Mon, 16 Nov 2026 16:53:28 +0800
Message-Id: <20261116085328.11090-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkC2uv2JxPpqL2G1AQ--.43460S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48KrWfJFW8Gw15Cw13twb_yoW7JFy8pF
	s8AFy5KFZ5Gr4fuFs7Jw4jvF1fZws2ga43Kryxuw1j93sxtF9xtFyvyFy5tF4DAFZ2yF42
	qr47XrWrCrZ8JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgR6zDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytetsAABsK

comedi_device_detach_cleanup() frees the async area of every subdevice.
The async area contains the wait queue head that comedi_poll() queues
pollers on, and a poller is not removed while comedi_poll() runs:
comedi_poll() only holds dev->attach_lock while adding the wait queue
entry, and the entry is removed later by poll_freewait() when the poll
system call returns.

Detaching through the COMEDI_DEVCONFIG ioctl is guarded by
is_device_busy(), which refuses to detach while the wait queue has
sleepers.  Removing the hardware is not: comedi_release_hardware_device()
calls comedi_free_board_dev(), which detaches unconditionally.  Unplugging
a USB COMEDI device while a task is polling it therefore frees the async
area from under that task, and the task hits a use-after-free when
poll_freewait() locks the freed wait queue head:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
  Write of size 4 at addr ffff888004508498
  Call Trace:
   _raw_spin_lock_irqsave
   remove_wait_queue
   free_poll_entry
   poll_freewait
   do_sys_poll

Every task that can have an entry queued on async->wait_head holds a
reference to the COMEDI device file, and comedi_open() holds a reference
to the COMEDI device for as long as the file is open.  The device
therefore cannot be released until the poll system call is done with the
wait queue, so move async areas that still have waiters to a list and
free them from comedi_dev_kref_release() instead of freeing them at
detach time.

Fixes: 2f3fdcd7ce93 ("staging: comedi: add rw_semaphore to protect against device detachment")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/comedi/comedi_fops.c     |  8 ++++++++
 drivers/comedi/drivers.c         | 14 +++++++++++++-
 include/linux/comedi/comedidev.h |  8 ++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 9a65dc5d62a4..932e35d7f68c 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -106,6 +106,7 @@ static struct cdev comedi_cdev;
 static void comedi_device_init(struct comedi_device *dev)
 {
 	kref_init(&dev->refcount);
+	INIT_LIST_HEAD(&dev->async_free_list);
 	spin_lock_init(&dev->spinlock);
 	mutex_init(&dev->mutex);
 	init_rwsem(&dev->attach_lock);
@@ -116,6 +117,13 @@ static void comedi_dev_kref_release(struct kref *kref)
 {
 	struct comedi_device *dev =
 		container_of(kref, struct comedi_device, refcount);
+	struct comedi_async *async, *tmp;
+
+	list_for_each_entry_safe(async, tmp, &dev->async_free_list,
+				 free_list) {
+		list_del(&async->free_list);
+		kfree(async);
+	}
 
 	mutex_destroy(&dev->mutex);
 	put_device(dev->class_dev);
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 3f75485338a1..f91535fccd2b 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -168,7 +168,19 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 			comedi_free_subdevice_minor(s);
 			if (s->async) {
 				comedi_buf_alloc(dev, s, 0);
-				kfree(s->async);
+				/*
+				 * A task that is polling the device file may still
+				 * have an entry queued on the wait queue inside the
+				 * async area.  Such a task holds a reference to the
+				 * device file, which keeps the COMEDI device itself
+				 * alive until the poll is done with it, so defer
+				 * the release until the device is released.
+				 */
+				if (wq_has_sleeper(&s->async->wait_head))
+					list_add_tail(&s->async->free_list,
+						      &dev->async_free_list);
+				else
+					kfree(s->async);
 			}
 			kfree(s->readback);
 		}
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index 577a08f37aee..54e324c0614f 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/comedi.h>
 
@@ -365,6 +366,11 @@ struct comedi_async {
 	unsigned int cb_mask;
 	int (*inttrig)(struct comedi_device *dev, struct comedi_subdevice *s,
 		       unsigned int x);
+	/*
+	 * Link in &struct comedi_device.async_free_list when the async area
+	 * cannot be freed at detach time because pollers may still use it.
+	 */
+	struct list_head free_list;
 };
 
 /**
@@ -558,6 +564,8 @@ struct comedi_device {
 
 	int n_subdevices;
 	struct comedi_subdevice *subdevices;
+	/* async areas waiting for the last user of the device */
+	struct list_head async_free_list;
 
 	/* dumb */
 	void __iomem *mmio;
-- 
2.34.1

