Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45138E5FE;
	Thu, 15 Oct 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080724; cv=none; b=eqJ8DSKYXepNiQLtBGrxKWpGtKjPXE6U1fft9g87C+XqE6rSxsCZoU6xLy+dfhFlwmEduTm+m1W+jayDWbLtbR1n8iSmQA6/VskxNtVffqOLpFI8x9TMI2nWpjvP3XkaZ282907Gahc6DYUYX0CcBLnBp/vVhrzSL5qNpI2VipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080724; c=relaxed/simple;
	bh=oOaZB/KrJS+U4ldA4bFNevO3jUMakzIRmYaYXmQDZWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rren9kRqx2P8MP60C0i8xTmPR+bWRyUwb8eg5ASpKwDOXS2GA+1mvXD5HTlK4BP3t2YOgcyX9FxtmLGZd9lZmlUupKvkFDrO6PyR/YrFXVN4xwDN4F/wJa98PtLYNx89Ph+Wv3AKsd5581Y2+YaoNNFKKBV2+/qfhffybqPolkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=lJblSupF reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="lJblSupF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=9YA6tJgduUfXuXbHzBSH6n4F9YgUReV3qi
	W+Dk7pAC0=; b=lJblSupFyPpwNWlI+b2J4pEOaWIGEZy8jggANZ/Fm1N6iT8CKm
	SH5wB8Fw1EDYxlifeFrTsj53FvbYxZT5hV7olVH7o6FkyM8z9JS9q+HyozdxK5WV
	Sx86rEVC1sVB5imsdPt4w5WSu9dBlQdM0KeezuE2dxM9pS5yIY9h9VMWk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.59])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAWOwE3+9BqqQmlAA--.58379S5;
	Fri, 16 Oct 2026 00:11:38 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v2 3/3] media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open chardevs
Date: Fri, 16 Oct 2026 00:11:34 +0800
Message-Id: <20261015161134.10425-4-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161134.10425-1-25031212351@stu.xidian.edu.cn>
References: <20261015161134.10425-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkAWOwE3+9BqqQmlAA--.58379S5
X-Coremail-Antispam: 1UD129KBjvJXoWfGrWrtFyrXF13uF17GFy3Arb_yoWDWw4Dpa
	1DKFW5KrWUGrn7Ww4UArn8Xrs5Ga1vka4rKryxGw1agFs3C34UGry8Kry5tr4rG397JFy2
	q3WUWryUKF1UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
	kF7I0En4kS14v26r126r1DMxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7VUUU5r7UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUHD2rQ7rwJjAABsj

On USB unbind (physical disconnect or usbfs USBDEVFS_DISCONNECT_CLAIM /
USBDEVFS_RESET / USBDEVFS_SETCONFIGURATION), dvb_usb_device_exit() ->
dvb_usb_exit() tears the whole "struct dvb_usb_device" down while
userspace may still hold open /dev/dvb/adapter*/frontend* file
descriptors and while the kdvb-ad-X-fe-Y thread is still running.

The post-disconnect paths then trip over the freed object:

  * i2c_transfer(&d->i2c_adap) from a frontend's ->release() /
    ->init() reads i2c_adap.bus_lock etc. out of freed memory
    (KASAN reports A/D in the bug report);
  * dvb_usb_generic_rw() / ttusb2_i2c_xfer() lock/unlock
    &d->usb_mutex / &d->i2c_mutex inside freed memory
    (KASAN UAF writes, UBSAN qspinlock splats, and a NULL dereference
    where "d" was gone entirely);
  * dvb_usb_fe_wakeup() / dvb_usb_fe_sleep() call
    dvb_usb_device_power_ctrl() -> ttusb2_power_ctrl() on freed "d".

struct dvb_usb_device has no refcount, so there is no way to keep it
alive until the last chardev user is gone.  Add one:

  * New fields "struct kref kref" and "int dead" in struct
    dvb_usb_device.
  * New helpers dvb_usb_device_get() / dvb_usb_device_put(); the
    release function frees ->priv and "d" once the last reference
    is dropped.
  * dvb_usb_device_init() initialises the kref; dvb_usb_exit() no
    longer frees "d" but marks it ->dead, keeps doing all the
    subsystem teardown (remote, adapters, i2c, priv_destroy), and
    drops the framework reference.  The object itself is freed by
    the last put().
  * The places that can outlive disconnect now pin the device:
      - dvb_usb_fe_wakeup() / dvb_usb_fe_sleep() get/put around the
        power-control + fe_init/fe_sleep calls;
      - dvb_usb_generic_rw() gets a ref for the duration of the USB
        I/O;
      - ttusb2_i2c_xfer() gets a ref around its i2c work.
    If the device is ->dead they skip the USB I/O and return -ENODEV /
    the original error path instead of touching a gone udev.

Because the kref lives inside the object itself, every consumer that
wants to probe "is it dead?" does so while holding a ref, so the flag
can never be read from freed memory.  With the object kept alive, the
mutexes and the i2c_adapter embedded in it are also still valid, which
is what the KASAN/UBSAN reports were complaining about.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  | 20 ++++++++++++---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 32 ++++++++++++++++++++++--
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  | 15 +++++++++--
 drivers/media/usb/dvb-usb/dvb-usb.h      | 13 ++++++++++
 drivers/media/usb/dvb-usb/ttusb2.c       | 18 ++++++++++---
 5 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 029dad86a059..e9c15a477103 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -251,26 +251,38 @@ static int dvb_usb_fe_wakeup(struct dvb_frontend *fe)
 {
 	struct dvb_usb_adapter *adap = fe->dvb->priv;
 
-	dvb_usb_device_power_ctrl(adap->dev, 1);
+	if (!dvb_usb_device_get(adap->dev))
+		return -ENODEV;
+
+	if (!adap->dev->dead)
+		dvb_usb_device_power_ctrl(adap->dev, 1);
 
 	dvb_usb_set_active_fe(fe, 1);
 
-	if (adap->fe_adap[fe->id].fe_init)
+	if (!adap->dev->dead && adap->fe_adap[fe->id].fe_init)
 		adap->fe_adap[fe->id].fe_init(fe);
 
+	dvb_usb_device_put(adap->dev);
 	return 0;
 }
 
 static int dvb_usb_fe_sleep(struct dvb_frontend *fe)
 {
 	struct dvb_usb_adapter *adap = fe->dvb->priv;
+	int ret = 0;
 
-	if (adap->fe_adap[fe->id].fe_sleep)
+	if (!dvb_usb_device_get(adap->dev))
+		return -ENODEV;
+
+	if (!adap->dev->dead && adap->fe_adap[fe->id].fe_sleep)
 		adap->fe_adap[fe->id].fe_sleep(fe);
 
 	dvb_usb_set_active_fe(fe, 0);
 
-	return dvb_usb_device_power_ctrl(adap->dev, 0);
+	if (!adap->dev->dead)
+		ret = dvb_usb_device_power_ctrl(adap->dev, 0);
+	dvb_usb_device_put(adap->dev);
+	return ret;
 }
 
 int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 6d2672bcc69b..3b68d914e647 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -136,9 +136,35 @@ static int dvb_usb_adapter_exit(struct dvb_usb_device *d)
 
 
 /* general initialization functions */
+static void dvb_usb_free_device(struct kref *ref)
+{
+	struct dvb_usb_device *d =
+		container_of(ref, struct dvb_usb_device, kref);
+
+	kfree(d->priv);
+	kfree(d);
+}
+
+struct dvb_usb_device *dvb_usb_device_get(struct dvb_usb_device *d)
+{
+	if (!d)
+		return NULL;
+	kref_get(&d->kref);
+	return d;
+}
+EXPORT_SYMBOL(dvb_usb_device_get);
+
+void dvb_usb_device_put(struct dvb_usb_device *d)
+{
+	if (d)
+		kref_put(&d->kref, dvb_usb_free_device);
+}
+EXPORT_SYMBOL(dvb_usb_device_put);
+
 static int dvb_usb_exit(struct dvb_usb_device *d)
 {
 	deb_info("state before exiting everything: %x\n", d->state);
+	d->dead = 1;
 	dvb_usb_remote_exit(d);
 	dvb_usb_adapter_exit(d);
 	dvb_usb_i2c_exit(d);
@@ -148,8 +174,8 @@ static int dvb_usb_exit(struct dvb_usb_device *d)
 	if (d->priv != NULL && d->props.priv_destroy != NULL)
 		d->props.priv_destroy(d);
 
-	kfree(d->priv);
-	kfree(d);
+	/* last put() frees the device */
+	dvb_usb_device_put(d);
 	return 0;
 }
 
@@ -157,6 +183,7 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 {
 	int ret = 0;
 
+	kref_init(&d->kref);
 	mutex_init(&d->data_mutex);
 	mutex_init(&d->usb_mutex);
 	mutex_init(&d->i2c_mutex);
@@ -303,6 +330,7 @@ int dvb_usb_device_init(struct usb_interface *intf,
 	info("found a '%s' in warm state.", desc->name);
 	d->udev = udev;
 	d->desc = desc;
+	d->dead = 0;
 	d->owner = owner;
 
 	usb_set_intfdata(intf, d);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-urb.c b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
index 2aabf90d8697..6f949b6c3499 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-urb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
@@ -17,13 +17,22 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 	if (!d || wbuf == NULL || wlen == 0)
 		return -EINVAL;
 
+	if (!dvb_usb_device_get(d))
+		return -ENODEV;
+
 	if (d->props.generic_bulk_ctrl_endpoint == 0) {
 		err("endpoint for generic control not specified.");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (d->dead) {
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if ((ret = mutex_lock_interruptible(&d->usb_mutex)))
-		return ret;
+		goto out;
 
 	deb_xfer(">>> ");
 	debug_dump(wbuf,wlen,deb_xfer);
@@ -57,6 +66,8 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 	}
 
 	mutex_unlock(&d->usb_mutex);
+out:
+	dvb_usb_device_put(d);
 	return ret;
 }
 EXPORT_SYMBOL(dvb_usb_generic_rw);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb.h b/drivers/media/usb/dvb-usb/dvb-usb.h
index 550006a8d86f..311cd3abb60a 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb.h
+++ b/drivers/media/usb/dvb-usb/dvb-usb.h
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <media/rc-core.h>
 
@@ -429,6 +430,12 @@ struct dvb_usb_adapter {
 /**
  * struct dvb_usb_device - object of a DVB USB device
  * @props: copy of the struct dvb_usb_properties this device belongs to.
+ * @kref: refcount; the object is only freed once every user that can
+ *	outlive USB disconnect (frontend file descriptors, the frontend
+ *	thread, in-flight i2c/usb transfers) has dropped its reference.
+ * @dead: set once the USB device is gone; USB/i2c workers must check
+ *	this while holding @kref and skip real hardware I/O.  Protects
+ *	access to @udev and to the mutexes below.
  * @desc: pointer to the device's struct dvb_usb_device_description.
  * @state: initialization and runtime state of the device.
  *
@@ -462,6 +469,9 @@ struct dvb_usb_device {
 	struct dvb_usb_device_properties props;
 	const struct dvb_usb_device_description *desc;
 
+	struct kref kref;
+	int dead;
+
 	struct usb_device *udev;
 
 #define DVB_USB_STATE_INIT        0x000
@@ -502,6 +512,9 @@ extern int dvb_usb_device_init(struct usb_interface *,
 			       short *adapter_nums);
 extern void dvb_usb_device_exit(struct usb_interface *);
 
+struct dvb_usb_device *dvb_usb_device_get(struct dvb_usb_device *d);
+void dvb_usb_device_put(struct dvb_usb_device *d);
+
 /* the generic read/write method for device control */
 extern int __must_check
 dvb_usb_generic_rw(struct dvb_usb_device *, u8 *, u16, u8 *, u16, int);
diff --git a/drivers/media/usb/dvb-usb/ttusb2.c b/drivers/media/usb/dvb-usb/ttusb2.c
index acde6149d278..0e63511c0b3e 100644
--- a/drivers/media/usb/dvb-usb/ttusb2.c
+++ b/drivers/media/usb/dvb-usb/ttusb2.c
@@ -369,10 +369,20 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	static u8 obuf[60], ibuf[60];
-	int i, write_read, read;
+	int i = 0, write_read, read;
 
-	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
-		return -EAGAIN;
+	if (!dvb_usb_device_get(d))
+		return -ENODEV;
+
+	if (d->dead) {
+		i = -ENODEV;
+		goto out;
+	}
+
+	if (mutex_lock_interruptible(&d->i2c_mutex) < 0) {
+		i = -EAGAIN;
+		goto out;
+	}
 
 	if (num > 2)
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
@@ -426,6 +436,8 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 	}
 
 	mutex_unlock(&d->i2c_mutex);
+out:
+	dvb_usb_device_put(d);
 	return i;
 }
 
-- 
2.34.1

