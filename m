Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799423;
	b=0gMxjYx0RwImXeT36EFhfPa9fU8Q6SIfWtxO2N7KAZ8mjso3FR9851Ul2Ddl9fTi6XGr
	 NHE24dv7cUQhYtsZgubI1Txc1bhz0Rbz6aMUfmo1kT6MsgMS46UphrMPgWTziezavEjuz
	 8M4BNxKRcnKsWBhVUXzkrOubWI0lbHcbY2gTU6uNYZkTOEQ5XqeJAnKkcLb06mJOjhrEz
	 10dbfZ/nV/9qSFx3p525/BHjTL8oHAxATmXQ4OZ5Wkj9Of1nDwWJMF1qBLfehbytfjf4L
	 dJ4u715HtnmO0DMZDz++CF7kaDc3HHJOakhtxmdnn0WFZwS9dorAldBkmHxuJ/ncNDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799423;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KXgCuXTDg+HNIi4LmSjU0o65XumS2iOut0f5G1XePbA=;
	b=iEkok+0iRxSzYWfbFpG7l6t5bRtBQuEbb+qf3/8+KwROKL+FD9yuQj0NOoyzS5wG21LG
	 8/gIzAjZYzMOPELUwVPKWG/Q6GsqzWj6knm0ynHpZwNbjgacvyNxJMitxZ9YxGM5KWgTp
	 1yxjS3X03lExfYVPl2abXpT7j+VFZvFbW2ulZE5YhaRj2mBSvxvpmUMtdFL/YAB87Ot4K
	 o3KnCN78nRS0fB+IouzD5FQIbCtXP2K0o0CHlxphNhZZV2oD9XO/FyGBjGOE/mTELJ/l/
	 K/KiYhL4r0rIPi9crMKU4rHd9S60xqVvjIwmRNu7UiplJK4TF36JLeBAfAW27cNPu9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cew49g21;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAE606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cew49g21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609761F000C1;
	Wed,  4 Nov 2026 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799422;
	bh=KXgCuXTDg+HNIi4LmSjU0o65XumS2iOut0f5G1XePbA=;
	h=Subject:To:Cc:From:Date;
	b=cew49g21qvnqn/S1HB4+qLOmsI4T6+Cu1x/d5C2kVRRsTvVGHhpHnZuQpLCnJW0Nr
	 82phNSkOiwCRac3rie9zA4BBnct3oHTPqEt0FcuU/AqyUovAj7v7NRC7LeZs11Qvss
	 GLOT/CPxenlMFCvpGVg3eDCxoM+m0rUWFu/5xGTA=
Subject: FAILED: patch "[PATCH] pps: generators: fix use-after-free when closing a removed" failed to apply to 6.18-stable tree
To: danishkhateeb03@gmail.com,giometti@enneenne.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:37:01 +0100
Message-ID: <2026110401-glitch-riveting-80d2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d19552611cb2eb6329826871565e5309bec2f288
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-glitch-riveting-80d2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d19552611cb2eb6329826871565e5309bec2f288 Mon Sep 17 00:00:00 2001
From: Danish Khateeb <danishkhateeb03@gmail.com>
Date: Tue, 29 Sep 2026 07:49:34 -0500
Subject: [PATCH] pps: generators: fix use-after-free when closing a removed
 device

The cdev of a PPS generator is embedded in struct pps_gen_device, but
nothing ties the lifetime of that structure to the cdev: pps_gen is
freed by the release function of its device, and an open file holds a
device reference only until pps_gen_cdev_release() drops it.

When the generator is unregistered while /dev/pps-genN is open, that
put_device() drops the last reference and frees pps_gen, and __fput()
then calls cdev_put() on the freed cdev:

  BUG: KASAN: slab-use-after-free in cdev_put+0x53/0x60
  Read of size 8 at addr ffff88801383e138 by task ppsgen64/149
  Call Trace:
   cdev_put+0x53/0x60
   __fput+0x745/0xad0
   fput_close_sync+0xd9/0x1b0
   __x64_sys_close+0x86/0xf0
  ...
  Freed by task 149:
   kfree+0x25a/0x6d0
   device_release+0xca/0x3c0
   kobject_put+0x169/0x320
   pps_gen_cdev_release+0x51/0x80
   __fput+0x36a/0xad0

pps.c had the same bug, fixed in commit c79a39dc8d06 ("pps: Fix a
use-after-free").

Fix it the usual way: embed the struct device in pps_gen_device and
register both with cdev_device_add(). This makes the device the parent
of the cdev, so the cdev holds a device reference until the last file
is closed.

Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://patch.msgid.link/20260929124937.51114-2-danishkhateeb03@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index 5e207c75e340..059f4fe6c9b4 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -63,7 +63,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 
 	switch (cmd) {
 	case PPS_GEN_SETENABLE:
-		dev_dbg(pps_gen->dev, "PPS_GEN_SETENABLE\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_SETENABLE\n");
 
 		ret = get_user(status, uiuarg);
 		if (ret)
@@ -77,7 +77,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_GEN_USESYSTEMCLOCK:
-		dev_dbg(pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
 
 		ret = put_user(pps_gen->info->use_system_clock, uiuarg);
 		if (ret)
@@ -89,12 +89,12 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		struct pps_gen_event info;
 		unsigned int ev = pps_gen->last_ev;
 
-		dev_dbg(pps_gen->dev, "PPS_GEN_FETCHEVENT\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_FETCHEVENT\n");
 
 		ret = wait_event_interruptible(pps_gen->queue,
 				ev != pps_gen->last_ev);
 		if (ret == -ERESTARTSYS) {
-			dev_dbg(pps_gen->dev, "pending signal caught\n");
+			dev_dbg(&pps_gen->dev, "pending signal caught\n");
 			return -EINTR;
 		}
 
@@ -121,7 +121,7 @@ static int pps_gen_cdev_open(struct inode *inode, struct file *file)
 	struct pps_gen_device *pps_gen = container_of(inode->i_cdev,
 				struct pps_gen_device, cdev);
 
-	get_device(pps_gen->dev);
+	get_device(&pps_gen->dev);
 	file->private_data = pps_gen;
 	return 0;
 }
@@ -130,7 +130,7 @@ static int pps_gen_cdev_release(struct inode *inode, struct file *file)
 {
 	struct pps_gen_device *pps_gen = file->private_data;
 
-	put_device(pps_gen->dev);
+	put_device(&pps_gen->dev);
 	return 0;
 }
 
@@ -151,19 +151,15 @@ static void pps_gen_device_destruct(struct device *dev)
 {
 	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
 
-	cdev_del(&pps_gen->cdev);
-
 	pr_debug("deallocating pps-gen%d\n", pps_gen->id);
 	ida_free(&pps_gen_ida, pps_gen->id);
 
-	kfree(dev);
 	kfree(pps_gen);
 }
 
 static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 {
 	int err;
-	dev_t devt;
 
 	err = ida_alloc_max(&pps_gen_ida, PPS_GEN_MAX_SOURCES - 1, GFP_KERNEL);
 	if (err < 0) {
@@ -171,46 +167,52 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 			pr_err("too many PPS sources in the system\n");
 			err = -EBUSY;
 		}
+		kfree(pps_gen);
 		return err;
 	}
 	pps_gen->id = err;
 
-	devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
+	/*
+	 * From here on pps_gen belongs to its device and is freed by
+	 * pps_gen_device_destruct(). The cdev holds a reference to the
+	 * device, so pps_gen stays around until the last file is closed.
+	 */
+	device_initialize(&pps_gen->dev);
+	pps_gen->dev.class = &pps_gen_class;
+	pps_gen->dev.parent = pps_gen->info->parent;
+	pps_gen->dev.devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
+	pps_gen->dev.release = pps_gen_device_destruct;
+	dev_set_drvdata(&pps_gen->dev, pps_gen);
 
 	cdev_init(&pps_gen->cdev, &pps_gen_cdev_fops);
 	pps_gen->cdev.owner = pps_gen->info->owner;
 
-	err = cdev_add(&pps_gen->cdev, devt, 1);
+	err = dev_set_name(&pps_gen->dev, "pps-gen%d", pps_gen->id);
+	if (err)
+		goto put_dev;
+
+	err = cdev_device_add(&pps_gen->cdev, &pps_gen->dev);
 	if (err) {
 		pr_err("failed to add char device %d:%d\n",
 				MAJOR(pps_gen_devt), pps_gen->id);
-		goto free_ida;
+		goto put_dev;
 	}
-	pps_gen->dev = device_create(&pps_gen_class, pps_gen->info->parent, devt,
-				     pps_gen, "pps-gen%d", pps_gen->id);
-	if (IS_ERR(pps_gen->dev)) {
-		err = PTR_ERR(pps_gen->dev);
-		goto del_cdev;
-	}
-	pps_gen->dev->release = pps_gen_device_destruct;
-	dev_set_drvdata(pps_gen->dev, pps_gen);
 
 	pr_debug("generator got cdev (%d:%d)\n",
 			MAJOR(pps_gen_devt), pps_gen->id);
 
 	return 0;
 
-del_cdev:
-	cdev_del(&pps_gen->cdev);
-free_ida:
-	ida_free(&pps_gen_ida, pps_gen->id);
+put_dev:
+	put_device(&pps_gen->dev);
 	return err;
 }
 
 static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
 {
 	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
-	device_destroy(&pps_gen_class, pps_gen->dev->devt);
+	cdev_device_del(&pps_gen->cdev, &pps_gen->dev);
+	put_device(&pps_gen->dev);
 }
 
 /*
@@ -244,18 +246,15 @@ struct pps_gen_device *pps_gen_register_source(const struct pps_gen_source_info
 	init_waitqueue_head(&pps_gen->queue);
 	spin_lock_init(&pps_gen->lock);
 
-	/* Create the char device */
+	/* Create the char device, this frees pps_gen on failure */
 	err = pps_gen_register_cdev(pps_gen);
 	if (err < 0) {
 		pr_err(" unable to create char device\n");
-		goto kfree_pps_gen;
+		goto pps_gen_register_source_exit;
 	}
 
 	return pps_gen;
 
-kfree_pps_gen:
-	kfree(pps_gen);
-
 pps_gen_register_source_exit:
 	pr_err("unable to register generator\n");
 
@@ -289,7 +288,7 @@ void pps_gen_event(struct pps_gen_device *pps_gen,
 {
 	unsigned long flags;
 
-	dev_dbg(pps_gen->dev, "PPS generator event %u\n", event);
+	dev_dbg(&pps_gen->dev, "PPS generator event %u\n", event);
 
 	spin_lock_irqsave(&pps_gen->lock, flags);
 
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
index 6214c8aa2e02..f26f6aac000d 100644
--- a/include/linux/pps_gen_kernel.h
+++ b/include/linux/pps_gen_kernel.h
@@ -54,7 +54,7 @@ struct pps_gen_device {
 
 	unsigned int id;			/* PPS generator unique ID */
 	struct cdev cdev;
-	struct device *dev;
+	struct device dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
 };

