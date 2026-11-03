Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694660;
	b=1sMAj3TGCWCf8hJrPjyz1M7jhtMFQV13hs/VpM959wPOGZyGq+wCA4KaYHiqH/k7e7/m
	 eOP3RpFxL0uUWKc2JTouUL+PyIoGxa5aCnbWb8qd8HOxdi9QBX1NEBoabeh/1QhIXSiEP
	 CvtRY03+y2T6jg2MKY5u/NL0LrESQ0LYSh/J8OF96f9gX2OLuyAedEEvNWc5ikQ8xMsDT
	 Z8ybD19URlDq1kssbM4wjV7B3htKte3nyOp7j78y6MYfpqKDb/MvcjFvPg7B7FEk6SkOL
	 gnsmGExjhfoawv+TWE4WgnlMKf1xQGizEa7naj0n6XPO5lvAfG+VQGyx6lDZ1Cpn8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694660;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=eYfqA49ihTRFWel/cC4uB+tcn89pO9R5yeKU1En/+xY=;
	b=y6riGpNzt98khAa2USoYg7NblPe6khLp4JiKsPme4JULeYdU0EY3hmeuL6hRoP0Sd9Nr
	 B3gWjTFUVesOdMpxpdwNbqtD2xtYhMCDqtoMtrWCo6njh5RBm201AvmDDjMalsMoFS8oi
	 r/UhlA0985R4yhwMoYIRScxM4eHxqGRJSChVmBm0BdeaIDuS1qxFG1s5xYOorbq+pir5C
	 N2eflbLV76uyCln8L/fo/PuLVsf63zHLBGeN+kv20Hebu3HfN4U43Z8RACfbvOwskOvFx
	 kQbg+schBnGlPcdnftisRpj9R/BYfTKOZWWlvbURMf8A8U6TXcdIdKbORBukoTu3bHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44960A262D;
	Tue,  3 Nov 2026 08:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD44960A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=eYfqA49ihTRFWel/cC4uB+tcn89pO9R5ye
	KU1En/+xY=; b=HuXyY09azhxIUad4JutvEpvPl28nmfjz5EBGlT5hvpHgTBBHzt
	Bp+WNEE8Q+CG+eatjgLCnNVAGBBAnwz9bKQ4/mY/MCxUPH45wyjkKxM4mwTxLHKQ
	ZNNuHFa+HOjA5A9QeaqG+JQT3lGXPnPdXIpbgIfzTiX1Uf7joY/HmKQoo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCGqgCwm+lqS+8dAQ--.21892S5;
	Tue, 03 Nov 2026 16:30:48 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v6 3/3] media: dvb-usb: refcount dvb_usb_device to fix disconnect UAF on open chardevs
Date: Tue,  3 Nov 2026 16:30:39 +0800
Message-Id: <20261103083039.33430-4-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103083039.33430-1-25031212351@stu.xidian.edu.cn>
References: <20261103083039.33430-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCGqgCwm+lqS+8dAQ--.21892S5
X-Coremail-Antispam: 1UD129KBjvAXoWftw45Xw1xtr18XFykXry5Arb_yoW8ZF4kCo
	WIqw4fJw4rJw40k3yktF1DKryjga97WanxWwsxCr4kZ3yI9Fs8Jw45Gws8Xw1Igrs5Krnr
	t34DJ3y5Jw48Jr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOf7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUomhOUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1WnDQAAsX

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
  * dvb_usb_fe_wakeup() / dvb_usb_fe_sleep(), dvb_usb_generic_rw()
    and ttusb2_i2c_xfer() check ->dead, and check it again right
    after taking their mutex, so they skip the hardware access
    instead of touching a device that is gone.

The transfer paths take no reference of their own.  Frontend
callbacks already run under the reference of the frontend they are
called for, and the remote-control work is cancelled synchronously
before the framework reference is dropped, so a transient reference
there would not extend any lifetime.  It would only move the last
put() into the middle of a transfer: dvb_usb_generic_rw() runs under
->master_xfer(), so the last put() could arrive inside
i2c_transfer(), and the release function would then call
i2c_del_adapter() - which waits for the users of the very adapter the
transfer is still holding - or take the transfer's bus lock apart in
freed memory.  Keeping the references where the lifetime is decided,
in the bus binding and in the frontends, makes the last put() happen
outside of any transfer.

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
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c  |  58 +++++++++++-
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 108 ++++++++++++++++++-----
 drivers/media/usb/dvb-usb/dvb-usb-urb.c  |  17 +++-
 drivers/media/usb/dvb-usb/dvb-usb.h      |  21 +++++
 drivers/media/usb/dvb-usb/ttusb2.c       |  20 ++++-
 5 files changed, 193 insertions(+), 31 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 029dad86a059..7ab19afd9ec4 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -8,6 +8,7 @@
  * linux-dvb API.
  */
 #include "dvb-usb-common.h"
+#include <linux/module.h>
 #include <media/media-device.h>
 
 /* does the complete input transfer handling */
@@ -251,11 +252,12 @@ static int dvb_usb_fe_wakeup(struct dvb_frontend *fe)
 {
 	struct dvb_usb_adapter *adap = fe->dvb->priv;
 
-	dvb_usb_device_power_ctrl(adap->dev, 1);
+	if (!adap->dev->dead)
+		dvb_usb_device_power_ctrl(adap->dev, 1);
 
 	dvb_usb_set_active_fe(fe, 1);
 
-	if (adap->fe_adap[fe->id].fe_init)
+	if (!adap->dev->dead && adap->fe_adap[fe->id].fe_init)
 		adap->fe_adap[fe->id].fe_init(fe);
 
 	return 0;
@@ -264,13 +266,37 @@ static int dvb_usb_fe_wakeup(struct dvb_frontend *fe)
 static int dvb_usb_fe_sleep(struct dvb_frontend *fe)
 {
 	struct dvb_usb_adapter *adap = fe->dvb->priv;
+	int ret = 0;
 
-	if (adap->fe_adap[fe->id].fe_sleep)
+	if (!adap->dev->dead && adap->fe_adap[fe->id].fe_sleep)
 		adap->fe_adap[fe->id].fe_sleep(fe);
 
 	dvb_usb_set_active_fe(fe, 0);
 
-	return dvb_usb_device_power_ctrl(adap->dev, 0);
+	if (!adap->dev->dead)
+		ret = dvb_usb_device_power_ctrl(adap->dev, 0);
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
@@ -304,10 +330,20 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
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
@@ -317,6 +353,20 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
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
index 6d2672bcc69b..54df285edb9a 100644
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
@@ -136,20 +135,66 @@ static int dvb_usb_adapter_exit(struct dvb_usb_device *d)
 
 
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
+	 *
+	 * The transfer paths hold no reference of their own, so this never
+	 * runs from inside ->master_xfer(): i2c_del_adapter() below would
+	 * otherwise tear the adapter down underneath the transfer that is
+	 * still using it.
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
 
@@ -157,6 +202,7 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 {
 	int ret = 0;
 
+	kref_init(&d->kref);
 	mutex_init(&d->data_mutex);
 	mutex_init(&d->usb_mutex);
 	mutex_init(&d->i2c_mutex);
@@ -172,8 +218,13 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
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
 
@@ -182,10 +233,10 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
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
@@ -194,15 +245,15 @@ static int dvb_usb_init(struct dvb_usb_device *d, short *adapter_nums)
 
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
 
@@ -303,8 +354,12 @@ int dvb_usb_device_init(struct usb_interface *intf,
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
@@ -321,7 +376,16 @@ int dvb_usb_device_init(struct usb_interface *intf,
 
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
index 2aabf90d8697..16e573c7f6b7 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-urb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
@@ -19,11 +19,23 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 
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
@@ -57,6 +69,7 @@ int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
 	}
 
 	mutex_unlock(&d->usb_mutex);
+out:
 	return ret;
 }
 EXPORT_SYMBOL(dvb_usb_generic_rw);
diff --git a/drivers/media/usb/dvb-usb/dvb-usb.h b/drivers/media/usb/dvb-usb/dvb-usb.h
index 550006a8d86f..d1a0b485ab3d 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb.h
+++ b/drivers/media/usb/dvb-usb/dvb-usb.h
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <media/rc-core.h>
 
@@ -362,6 +363,7 @@ struct usb_data_stream {
  * @fe: frontend
  * @fe_init:  rerouted frontend-init (wakeup) function.
  * @fe_sleep: rerouted frontend-sleep function.
+ * @fe_release: rerouted frontend-release function.
  * @stream: the usb data stream.
  * @pid_filtering: is hardware pid_filtering used or not.
  * @max_feed_count: how many feeds can be handled simultaneously by this
@@ -373,6 +375,7 @@ struct dvb_usb_fe_adapter {
 
 	int (*fe_init)  (struct dvb_frontend *);
 	int (*fe_sleep) (struct dvb_frontend *);
+	void (*fe_release)(struct dvb_frontend *fe);
 
 	struct usb_data_stream stream;
 
@@ -429,6 +432,12 @@ struct dvb_usb_adapter {
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
@@ -462,6 +471,9 @@ struct dvb_usb_device {
 	struct dvb_usb_device_properties props;
 	const struct dvb_usb_device_description *desc;
 
+	struct kref kref;
+	int dead;
+
 	struct usb_device *udev;
 
 #define DVB_USB_STATE_INIT        0x000
@@ -502,6 +514,15 @@ extern int dvb_usb_device_init(struct usb_interface *,
 			       short *adapter_nums);
 extern void dvb_usb_device_exit(struct usb_interface *);
 
+/*
+ * References are held by the bus binding and by every registered
+ * frontend.  The transfer paths deliberately take none: they run under
+ * one of those, and a reference of their own could be the last one,
+ * making the release function run in the middle of a transfer.
+ */
+struct dvb_usb_device *dvb_usb_device_get(struct dvb_usb_device *d);
+void dvb_usb_device_put(struct dvb_usb_device *d);
+
 /* the generic read/write method for device control */
 extern int __must_check
 dvb_usb_generic_rw(struct dvb_usb_device *, u8 *, u16, u8 *, u16, int);
diff --git a/drivers/media/usb/dvb-usb/ttusb2.c b/drivers/media/usb/dvb-usb/ttusb2.c
index acde6149d278..9246fc9f9bd6 100644
--- a/drivers/media/usb/dvb-usb/ttusb2.c
+++ b/drivers/media/usb/dvb-usb/ttusb2.c
@@ -369,10 +369,23 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	static u8 obuf[60], ibuf[60];
-	int i, write_read, read;
+	int i = 0, write_read, read;
 
-	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
-		return -EAGAIN;
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
@@ -426,6 +439,7 @@ static int ttusb2_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 	}
 
 	mutex_unlock(&d->i2c_mutex);
+out:
 	return i;
 }
 
-- 
2.34.1

