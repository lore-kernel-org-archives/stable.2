Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692483;
	b=f+Wi+sKkX1mIrvpCuAHF6iWYq5u7Iqp9ID2/jGZa/KptuYYqWIoW4Bxu9NN1WfdznqTM
	 i9poZCVTgpCYW6YP+sphOUQCPuhCMF1pABR0fzNui/SJZm8LJ4Owi0Ipp/8kEovyxmSHs
	 EvOOElvgzWfyWtfvazzlZvZCHzuK7AKokUJEYXdL7b+lwqlZBu7hWio6zGkTUbmVdtSnX
	 aOUcj1fIj8cmh5kKibT5pxyKhGzyVyv111BoGfIGmNQ+RkdkomfPcHw+V/uWLGiRhBuwW
	 Xo0UiT3Xme7+M6fD524OUk5LXCkQn2fu6b5R1so5MwNRy/4ftND3oUbL8yUTFaqaSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692483;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=7IOKxDlU5sstMJOS7LOLpWk4/C6NE4NW6K+lpUtvmz8=;
	b=iFh8pI3Ijc75XVCD/J45WNHVSwzxsQAEVpWQvM8LOE8v0A6T7HsXs11DQFQmkkZhWnOZ
	 hyuMNBCBa7YTt3OJjookTsOvAnsWUif0iB6nJVT7PJymZcDiq60wcz4r+hvVEa/Yxjy3Z
	 45UrDTfSkeqcJOPhgdFUuVOogwOrektiUy62tBarnedu/iuneUpwbpS41jmxCF+CUVQO/
	 Q8syz4ZCek4xkVuIeceXxbkfdds+SLSUv0NPJHbuKZeF3eGsx1atidufq0ygrvDink1R4
	 l3p1oAH7OYxMYModN3QtUdIBmGGq8w0f50hOo2MB4ia/5BrJxCAVtr3bUXYOj3K4yqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E8606A32D;
	Tue,  3 Nov 2026 07:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377E8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7IOKxDlU5sstMJOS7LOLpWk4/C6NE4NW6K
	+lpUtvmz8=; b=KzLPqjgQ64NvBaDLABy/8wXsswDYaX2745XolIda4kHailrBUz
	dWBDfGi5PGjVXznlSmDLoekLbJDok4NWkWimNpEFFwliG4CaoX46wz2gonalGqJ6
	QgL0BsaSkNvlNW+7tY3CWNV0HuTCJvht3iLQt7i3mHqJMcX4mcpvBv0H4=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2fP8sk+lqE0IdAQ--.49868S5;
	Tue, 03 Nov 2026 15:54:28 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v5 3/3] media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open chardevs
Date: Tue,  3 Nov 2026 15:54:20 +0800
Message-Id: <20261103075420.7772-4-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103075420.7772-1-25031212351@stu.xidian.edu.cn>
References: <20261103075420.7772-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2fP8sk+lqE0IdAQ--.49868S5
X-Coremail-Antispam: 1UD129KBjvAXoWfGrW7tF1xCFyDXw1fCFyfWFg_yoW8CF48Ko
	WIqw4fJw4rJw4jkrWktF1DKryjgFZ7WanxWwsxCr4kZ3yI9Fs8Xw45Gws8Xw1Igrs5Krnr
	t34DJrZ8Jw48Jr4xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOh7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
	Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
	8v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjh0ePUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2roqcKa2gAAsn

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
    release function frees the object once the last reference is
    dropped.
  * dvb_usb_device_init() initialises the kref; dvb_usb_exit() no
    longer frees "d" but marks it ->dead and drops the framework
    reference.  The error path of dvb_usb_device_init() marks the
    device dead as well.

The reference has to cover the whole lifetime of a frontend, not
just individual calls: closing the last file descriptor after
disconnect runs __dvb_frontend_free() -> fe->ops.release(), which
still talks to the demodulator over i2c.  Therefore:

  * dvb_usb_adapter_frontend_init() takes a reference per registered
    frontend, saves the driver's release callback and installs
    dvb_usb_fe_release() as fe->ops.release.  The wrapper calls the
    original callback, calls dvb_detach() on it when
    CONFIG_MEDIA_ATTACH is enabled, and then drops the dvb_usb_device
    reference.  A failed registration drops the reference itself and
    keeps the driver callback installed, so the core detaches it as
    before.  The wrapper is installed only after a successful
    dvb_register_frontend(), because the early registration failure
    paths do not set fe->dvb yet.
  * dvb_frontend_invoke_release() applies dvb_detach() to
    fe->ops.release itself, which is the wrapper now, so the module
    reference it drops is taken with __module_get(THIS_MODULE) when
    the wrapper is installed.  Both sides are conditional on
    CONFIG_MEDIA_ATTACH; without the matching get(), the module
    reference counting would be off by one in both directions.
  * dvb_usb_adapter_init() calls dvb_usb_adapter_frontend_exit() when
    a failure happens after the frontends were registered, instead
    of leaking the registered frontends and their references.
  * usb_get_dev() / usb_put_dev() tie the underlying "struct
    usb_device" to the same lifetime, so late USB helpers either
    work or fail cleanly on a disconnected device instead of
    dereferencing freed memory.
  * dvb_usb_fe_wakeup() / dvb_usb_fe_sleep() pin the device around
    the power-control + fe_init/fe_sleep calls;
  * dvb_usb_generic_rw() and ttusb2_i2c_xfer() pin the device for
    the duration of the USB/i2c work and check ->dead right after
    taking their mutex, skipping the hardware access if the device
    is gone.

Keeping "struct dvb_usb_device" alive is not enough on its own: the
disconnect path also released the things an open frontend still reaches
through it.  The I2C adapter was unregistered (i2c_del_adapter() even
zeroes adap->dev, dropping the adapdata that every *_i2c_xfer()
callback dereferences), ->priv_destroy() ran - for cxusb that
destroys the mutex that cxusb_medion_put() still takes from
fe->ops.ts_bus_ctrl() in the frontend's ->release(), and the
per-adapter private data was freed while tuner callbacks such as
dib3000mb_i2c_gate_ctrl() still read adap->priv.  Move all of that to
dvb_usb_free_device(): the I2C adapter, the driver ->priv_destroy()
callback, the per-adapter private data and ->priv are released when the
last reference is dropped, so nothing a frontend can call is taken away
while a file descriptor is still open, and the adapter is not
unregistered while a transfer can still race the unregistration.

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
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  |  66 ++++++++++++++-
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 103 ++++++++++++++++++-----
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  |  21 ++++-
 drivers/media/usb/dvb-usb/dvb-usb.h      |  14 +++
 drivers/media/usb/dvb-usb/ttusb2.c       |  24 +++++-
 5 files changed, 197 insertions(+), 31 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 029dad86a059..61af74df41d8 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -8,6 +8,7 @@
  * linux-dvb API.
  */
 #include "dvb-usb-common.h"
+#include <linux/module.h>
 #include <media/media-device.h>
 
 /* does the complete input transfer handling */
@@ -251,26 +252,59 @@ static int dvb_usb_fe_wakeup(struct dvb_frontend *fe)
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
+	void (*release)(struct dvb_frontend *frontend) =
+		adap->fe_adap[fe->id].fe_release;
+
+	if (release) {
+		release(fe);
+#ifdef CONFIG_MEDIA_ATTACH
+		/*
+		 * __dvb_frontend_free() detaches fe->ops.release, which is
+		 * this wrapper now, so the driver callback is left
+		 * attached.  Drop the reference dvb_attach() took instead.
+		 */
+		dvb_detach(release);
+#endif
+	}
+
+	dvb_usb_device_put(adap->dev);
 }
 
 int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
@@ -304,10 +338,20 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
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
@@ -317,6 +361,20 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
 				return 0;
 		}
 
+		/*
+		 * From now on the frontend owns the reference.  Under
+		 * CONFIG_MEDIA_ATTACH, dvb_frontend_invoke_release() drops a
+		 * module reference on fe->ops.release, which is the wrapper
+		 * from here on; take it, and the wrapper detaches the driver
+		 * callback in turn.  The registration error path above runs
+		 * with the driver callback still installed and is not
+		 * affected.
+		 */
+#ifdef CONFIG_MEDIA_ATTACH
+		__module_get(THIS_MODULE);
+#endif
+		adap->fe_adap[i].fe->ops.release = dvb_usb_fe_release;
+
 		/* only attach the tuner if the demod is there */
 		if (adap->props.fe[i].tuner_attach != NULL)
 			adap->props.fe[i].tuner_attach(adap);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 6d2672bcc69b..a2e0fc48031c 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -111,11 +111,11 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	return 0;
 
 frontend_init_err:
+	dvb_usb_adapter_frontend_exit(adap);
 	dvb_usb_adapter_dvb_exit(adap);
 dvb_init_err:
 	dvb_usb_adapter_stream_exit(adap);
 stream_init_err:
-	kfree(adap->priv);
 	return ret;
 }
 
@@ -127,7 +127,6 @@ static int dvb_usb_adapter_exit(struct dvb_usb_device *d)
 		dvb_usb_adapter_frontend_exit(&d->adapter[n]);
 		dvb_usb_adapter_dvb_exit(&d->adapter[n]);
 		dvb_usb_adapter_stream_exit(&d->adapter[n]);
-		kfree(d->adapter[n].priv);
 	}
 	d->num_adapters_initialized = 0;
 	d->state &= ~DVB_USB_STATE_DVB;
@@ -136,20 +135,61 @@ static int dvb_usb_adapter_exit(struct dvb_usb_device *d)
 
 
 /* general initialization functions */
+static void dvb_usb_free_device(struct kref *ref)
+{
+	struct dvb_usb_device *d =
+		container_of(ref, struct dvb_usb_device, kref);
+	int n;
+
+	/*
+	 * This is the last reference, so no frontend file descriptor can
+	 * start a callback or an I2C transfer any more: unregister the
+	 * adapter and release the private data that the disconnect path
+	 * had to leave in place for those callbacks.
+	 */
+	dvb_usb_i2c_exit(d);
+	if (d->priv != NULL && d->props.priv_destroy != NULL)
+		d->props.priv_destroy(d);
+	for (n = 0; n < d->props.num_adapters; n++)
+		kfree(d->adapter[n].priv);
+	kfree(d->priv);
+	usb_put_dev(d->udev);
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
-	dvb_usb_i2c_exit(d);
 	deb_info("state should be zero now: %x\n", d->state);
-	d->state = DVB_USB_STATE_INIT;
-
-	if (d->priv != NULL && d->props.priv_destroy != NULL)
-		d->props.priv_destroy(d);
 
-	kfree(d->priv);
-	kfree(d);
+	/*
+	 * DVB_USB_STATE_I2C is still set: the adapter stays registered
+	 * until dvb_usb_free_device() runs, so that a frontend that
+	 * userspace has not closed yet cannot race the unregistration.
+	 * The same holds for the driver private data, which its callbacks
+	 * (including ->master_xfer) keep using.  The last put() releases
+	 * all of it.
+	 */
+	dvb_usb_device_put(d);
 	return 0;
 }
 
@@ -157,6 +197,7 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 {
 	int ret = 0;
 
+	kref_init(&d->kref);
 	mutex_init(&d->data_mutex);
 	mutex_init(&d->usb_mutex);
 	mutex_init(&d->i2c_mutex);
@@ -172,8 +213,13 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
 		if (d->props.priv_init != NULL) {
 			ret = d->props.priv_init(d);
-			if (ret != 0)
-				goto err_priv_init;
+			if (ret != 0) {
+				/* nothing can reference ->priv yet */
+				d->dead = 1;
+				kfree(d->priv);
+				d->priv = NULL;
+				return ret;
+			}
 		}
 	}
 
@@ -182,10 +228,10 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
 	ret = dvb_usb_i2c_init(d);
 	if (ret)
-		goto err_i2c_init;
+		goto error;
 	ret = dvb_usb_adapter_init(d, adapter_nums);
 	if (ret)
-		goto err_adapter_init;
+		goto error;
 
 	if ((ret = dvb_usb_remote_init(d)))
 		err("could not initialize remote control.");
@@ -194,15 +240,15 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
 	return 0;
 
-err_adapter_init:
+error:
+	/*
+	 * A frontend that userspace already opened keeps the device alive
+	 * and can still run callbacks that look at ->dead, so mark it dead
+	 * here.  The I2C adapter and the private data are released from
+	 * dvb_usb_free_device(), after the last reference is gone.
+	 */
+	d->dead = 1;
 	dvb_usb_adapter_exit(d);
-	dvb_usb_i2c_exit(d);
-err_i2c_init:
-	if (d->priv && d->props.priv_destroy)
-		d->props.priv_destroy(d);
-err_priv_init:
-	kfree(d->priv);
-	d->priv = NULL;
 	return ret;
 }
 
@@ -303,8 +349,12 @@ int dvb_usb_device_init(struct usb_interface *intf,
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
@@ -321,7 +371,16 @@ int dvb_usb_device_init(struct usb_interface *intf,
 
  error:
 	usb_set_intfdata(intf, NULL);
-	kfree(d);
+	/*
+	 * dvb_usb_init() may have initialised the kref and left the
+	 * object reachable from an open frontend; drop this reference and
+	 * let the last one free it.
+	 */
+	d->dead = 1;
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
index acde6149d278..aae99d7ab27e 100644
--- a/drivers/media/usb/dvb-usb/ttusb2.c
+++ b/drivers/media/usb/dvb-usb/ttusb2.c
@@ -369,10 +369,26 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
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
+
+	if (d->dead) {
+		mutex_unlock(&d->i2c_mutex);
+		i = -ENODEV;
+		goto out;
+	}
 
 	if (num > 2)
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
@@ -426,6 +442,8 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 	}
 
 	mutex_unlock(&d->i2c_mutex);
+out:
+	dvb_usb_device_put(d);
 	return i;
 }
 
-- 
2.34.1

