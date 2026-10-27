Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066303;
	b=iHl3bsqqM3f2nyQ82gTzuF4zhr3OpvNPO/EKHRUY9VYM+FNWyJ8/SgL3s7jdX1yktfou
	 VCxcPvTr1N8FO/jPKKi712h6AtmuY3XHHtvTSR02525n6E5iYpRAeyUKuORC6hXAE4EbK
	 dMk6FNgVklD83EPWEppQg7bfZ+JRjV+UFE3bKKpon9N2jrcpoChG6Mwg8lPmBoqtC9YFZ
	 Dp3E93mRVe7Msx3vibkBjucnHxg7ibfskj7d0ka2+4ZQYNFnKApfCsznGZHOC3W2KYdpe
	 ybeCPG5e//R+fs318yTfC7wk6JuXP8Ww4s+WZHvDWrQThzwQ5dcVgru/YWotM8aBeaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066303;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Wm8AUX6Xet/LamVBk8KisuXq2LijwhxrxBLBvOUjfGE=;
	b=4Yqj9MEdOU7zKa2bdjRjXaBVHfzWrfRQjRMmKsDSUEyXL9xRGM+yfjrIMEbN3v4h4VnK
	 7nyjPTXBofMVKjsfQQqWulRDDzSCRwbidIuqrTAT+V2DRI2LxNiCJITNAkT4A8wFtMsuk
	 DX1W2Uzg+FPvJXgyM1VXENwjRSlWVs+WzN7vF/DCCQvjuBAWwI2S8le6Is1fkv1tW0YZU
	 N+3GjSfx5w/Phu0OQoRBpvVrKyDRxEyxtaHdcvN+6A0hlCq6tcAv6j77HA6TBzmJYaGh1
	 OWaEQuo2EMF1t5YaYNCgR4VHitKfR8/RhQGNCw/z7Z/XHVnavDGcb3aaNTeiI6glgBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4A606A32A;
	Tue, 27 Oct 2026 01:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D4A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Wm8AUX6Xet/LamVBk8KisuXq2LijwhxrxB
	LBvOUjfGE=; b=npg6+QLffMA3PGap+Gq837s5XvB6PCj7DUVp07L/p4dOgUqX/L
	J+ID4qCT8VZHJTC0PQ/lQOIxns5gmALG3hERHz3DPbXsg1xP+5P3o6nl02XIlHR7
	c9JjLRCl9mpaAwnvFQgUgJk14ieBxo0dh3z6NkFqKLWmSCvkp1lYjnqhk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnAEsBeBqxnzsAA--.34537S5;
	Tue, 27 Oct 2026 09:58:18 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v3 3/3] media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open chardevs
Date: Tue, 27 Oct 2026 09:58:04 +0800
Message-Id: <20261027015804.13148-4-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027015804.13148-1-25031212351@stu.xidian.edu.cn>
References: <20261027015804.13148-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnAEsBeBqxnzsAA--.34537S5
X-Coremail-Antispam: 1UD129KBjvAXoWfGrW7Ar15Kw4xZFW8Ary3CFg_yoW8Gr15Xo
	Wxtw4fXw4rJr4jkrWktF1jgry0gFZ7GanxWr43Cr4kZ3yI9Fs5Jw45Gw45Xw18Wrs5Krnr
	t34DJrW5Jw4UJr48n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOa7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	CY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JUyRRiUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2rfb0FFJgAAsj

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

The reference has to cover the whole lifetime of a frontend, not
just individual calls: closing the last file descriptor after
disconnect runs __dvb_frontend_free() -> fe->ops.release(), which
still talks to the demodulator over i2c.  Therefore:

  * dvb_usb_adapter_frontend_init() takes a reference per registered
    frontend, saves the driver's release callback and installs
    dvb_usb_fe_release() as fe->ops.release; the wrapper calls the
    original callback and then drops the reference.  The DVB core
    invokes fe->ops.release() exactly once, when the frontend object
    is finally freed, so the object stays alive until the last fd is
    closed and dvb_unregister_frontend()/dvb_frontend_detach() have
    run.  The failed-registration path drops the reference itself.
  * usb_get_dev() / usb_put_dev() tie the underlying "struct
    usb_device" to the same lifetime, so late USB helpers either
    work or fail cleanly on a disconnected device instead of
    dereferencing freed memory.
  * dvb_usb_fe_wakeup() / dvb_usb_fe_sleep() pin the device around
    the power-control + fe_init/fe_sleep calls;
  * dvb_usb_generic_rw() and ttusb2_i2c_xfer() pin the device for
    the duration of the USB/i2c work, check ->dead right after
    taking their mutex and skip the hardware access if the device is
    gone.

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
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  | 42 +++++++++++++++++++++---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 41 +++++++++++++++++++++--
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  | 21 ++++++++++--
 drivers/media/usb/dvb-usb/dvb-usb.h      | 14 ++++++++
 drivers/media/usb/dvb-usb/ttusb2.c       | 18 ++++++++--
 5 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 029dad86a059..2554894f0523 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -251,26 +251,47 @@ static int dvb_usb_fe_wakeup(struct dvb_frontend *fe)
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
+
+	if (!dvb_usb_device_get(adap->dev))
+		return -ENODEV;
 
-	if (adap->fe_adap[fe->id].fe_sleep)
+	if (!adap->dev->dead && adap->fe_adap[fe->id].fe_sleep)
 		adap->fe_adap[fe->id].fe_sleep(fe);
 
 	dvb_usb_set_active_fe(fe, 0);
 
-	return dvb_usb_device_power_ctrl(adap->dev, 0);
+	if (!adap->dev->dead)
+		ret = dvb_usb_device_power_ctrl(adap->dev, 0);
+	dvb_usb_device_put(adap->dev);
+	return ret;
+}
+
+static void dvb_usb_fe_release(struct dvb_frontend *fe)
+{
+	struct dvb_usb_adapter *adap = fe->dvb->priv;
+
+	if (adap->fe_adap[fe->id].fe_release)
+		adap->fe_adap[fe->id].fe_release(fe);
+	dvb_usb_device_put(adap->dev);
 }
 
 int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
@@ -304,10 +325,20 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
 		adap->fe_adap[i].fe->ops.init  = dvb_usb_fe_wakeup;
 		adap->fe_adap[i].fe_sleep = adap->fe_adap[i].fe->ops.sleep;
 		adap->fe_adap[i].fe->ops.sleep = dvb_usb_fe_sleep;
+		adap->fe_adap[i].fe_release = adap->fe_adap[i].fe->ops.release;
+
+		/*
+		 * A frontend file descriptor can outlive USB disconnect.
+		 * Hold a reference for the whole frontend lifetime: the
+		 * release callback and the frontend thread then still run
+		 * against a live struct dvb_usb_device.
+		 */
+		dvb_usb_device_get(adap->dev);
 
 		if (dvb_register_frontend(&adap->dvb_adap, adap->fe_adap[i].fe)) {
 			err("Frontend %d registration failed.", i);
 			dvb_frontend_detach(adap->fe_adap[i].fe);
+			dvb_usb_device_put(adap->dev);
 			adap->fe_adap[i].fe = NULL;
 			/* In error case, do not try register more FEs,
 			 * still leaving already registered FEs alive. */
@@ -317,6 +348,9 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
 				return 0;
 		}
 
+		/* from now on the frontend owns the reference */
+		adap->fe_adap[i].fe->ops.release = dvb_usb_fe_release;
+
 		/* only attach the tuner if the demod is there */
 		if (adap->props.fe[i].tuner_attach != NULL)
 			adap->props.fe[i].tuner_attach(adap);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 6d2672bcc69b..8756ce18f1d7 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -136,9 +136,36 @@ static int dvb_usb_adapter_exit(struct dvb_usb_device *d)
 
 
 /* general initialization functions */
+static void dvb_usb_free_device(struct kref *ref)
+{
+	struct dvb_usb_device *d =
+		container_of(ref, struct dvb_usb_device, kref);
+
+	usb_put_dev(d->udev);
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
@@ -148,8 +175,8 @@ static int dvb_usb_exit(struct dvb_usb_device *d)
 	if (d->priv != NULL && d->props.priv_destroy != NULL)
 		d->props.priv_destroy(d);
 
-	kfree(d->priv);
-	kfree(d);
+	/* last put() frees the device */
+	dvb_usb_device_put(d);
 	return 0;
 }
 
@@ -157,6 +184,7 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 {
 	int ret = 0;
 
+	kref_init(&d->kref);
 	mutex_init(&d->data_mutex);
 	mutex_init(&d->usb_mutex);
 	mutex_init(&d->i2c_mutex);
@@ -303,8 +331,12 @@ int dvb_usb_device_init(struct usb_interface *intf,
 	info("found a '%s' in warm state.", desc->name);
 	d->udev = udev;
 	d->desc = desc;
+	d->dead = 0;
 	d->owner = owner;
 
+	/* keep the usb_device alive for as long as the object itself */
+	usb_get_dev(udev);
+
 	usb_set_intfdata(intf, d);
 
 	ret = dvb_usb_init(d, adapter_nums);
@@ -321,7 +353,10 @@ int dvb_usb_device_init(struct usb_interface *intf,
 
  error:
 	usb_set_intfdata(intf, NULL);
-	kfree(d);
+	if (d->udev)
+		dvb_usb_device_put(d);
+	else
+		kfree(d);
 	return ret;
 }
 EXPORT_SYMBOL(dvb_usb_device_init);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-urb.c b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
index 2aabf90d8697..b8f51104092f 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-urb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
@@ -17,13 +17,28 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
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
+
+	if (d->dead) {
+		mutex_unlock(&d->usb_mutex);
+		ret = -ENODEV;
+		goto out;
+	}
 
 	deb_xfer(">>> ");
 	debug_dump(wbuf,wlen,deb_xfer);
@@ -57,6 +72,8 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 	}
 
 	mutex_unlock(&d->usb_mutex);
+out:
+	dvb_usb_device_put(d);
 	return ret;
 }
 EXPORT_SYMBOL(dvb_usb_generic_rw);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb.h b/drivers/media/usb/dvb-usb/dvb-usb.h
index 550006a8d86f..53647f9cf34d 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb.h
+++ b/drivers/media/usb/dvb-usb/dvb-usb.h
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <media/rc-core.h>
 
@@ -373,6 +374,7 @@ struct dvb_usb_fe_adapter {
 
 	int (*fe_init)  (struct dvb_frontend *);
 	int (*fe_sleep) (struct dvb_frontend *);
+	void (*fe_release)(struct dvb_frontend *fe);
 
 	struct usb_data_stream stream;
 
@@ -429,6 +431,12 @@ struct dvb_usb_adapter {
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
@@ -462,6 +470,9 @@ struct dvb_usb_device {
 	struct dvb_usb_device_properties props;
 	const struct dvb_usb_device_description *desc;
 
+	struct kref kref;
+	int dead;
+
 	struct usb_device *udev;
 
 #define DVB_USB_STATE_INIT        0x000
@@ -502,6 +513,9 @@ extern int dvb_usb_device_init(struct usb_interface *,
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

