Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694657;
	b=UIhOfPi92jvafezdW3fLbdW12HKeCJ+92PKOOCRjLmc1NjcmpsIKRN0WEDgixbnzZlGv
	 eWtRaKSbmtWqUf67OtVuEDz26baqi46P8Hb/xy8O0DGIVMpA3ca2or1NW+LpLkVw64x+D
	 S3BwJBP2XgKGCOuyhUd1CcanS8zikhawsMLX2E6ru3fxbCyn5Pne2Se/W4ydzyv/eiya8
	 +q9W+7THt/tiiSetohurNJE8s9A26wOW3+EREmHDmIFqW8UKtcWLV4VLq6LAl3hahuRes
	 umNSWcr8uQpsb80RvXUgwEKSFCuXp++iW1GF3vXhd91vsHKA5yEcrH/9cBfCSlo2Bkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694657;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=7uG+Z6VfUclGYun6DBbyH359pqxKumrSn2/QKYWV7K4=;
	b=mNssflwwR4O+JfLwnMWrVRiU//2ijgE4rLkY93itb230SNefapIbul5L+Imnj0MpgdS6
	 jn5ZmASfjUXuUtkoZZNEsgvuZ1zzlGxSxX1YcJBToh+DAg5TCoujGs81H6SaDET1al2en
	 XMkXadc3mQFFnGsgaXXdZVo6k4A6nly8leI04GYI6UXhAadXEPT4wtB41N6JJ1cXUynDa
	 Yi6YqSTJ/z41kWoQI84CAKY912M/g7TnRBsLUY2hDMEqc1Mro1C+EK8iGfusCcwojx/iN
	 ppwTUxugHLflCoYC+/78FMCeW4UmWK+XI7p7J3dbcOqfZjrbhpvMjo48c1Wv2u0nHTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B960A380F;
	Tue,  3 Nov 2026 08:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056B960A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7uG+Z6VfUclGYun6DBbyH359pqxKumrSn2
	/QKYWV7K4=; b=oxw2TPQKHSnxNGpGYNQ/A6sUyAm3uoXzWgUixL2qbL6D2vW6l5
	shNZdZ8VoRDUfP1394Gy1FFILG3S/KzDXXBf/fwpuMkwFVUklfcccnGagcVt4Kbr
	QDcViXXrITueMvjlyBOgg5VqrlxlBbgMVBy6otG43MsiizqQAlhbQUWcc=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCGqgCwm+lqS+8dAQ--.21892S3;
	Tue, 03 Nov 2026 16:30:46 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v6 1/3] media: dvb-core: fix use-after-free in dvb_remove_device()
Date: Tue,  3 Nov 2026 16:30:37 +0800
Message-Id: <20261103083039.33430-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCGqgCwm+lqS+8dAQ--.21892S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18tr1DGry3tr47AFy7Jrb_yoWxXrWxpF
	Z8Wa45KrWq9r4kWr4UAF1UZF98Cr1Sv34rCrWIkr97Kr43JrySyrZ0ya45Ja13A397Aa4j
	qFW7Jr1kW3y5C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU0PfPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1WnCgABsR

dvb_remove_device() clears dvb_minors[] and drops the minors-table
reference while holding minor_rwsem, but then keeps using "dvbdev":

	down_write(&minor_rwsem);
	dvb_minors[dvbdev->minor] = NULL;
	dvb_device_put(dvbdev);          /* may kfree(dvbdev) */
	up_write(&minor_rwsem);

	dvb_media_device_free(dvbdev);
	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
	list_del(&dvbdev->list_head);

If the put() happens to drop the last reference, the remaining three
statements are use-after-free.  KASAN reports the read of dvbdev->minor
inside device_destroy(), and the list_del() then writes list poison
into the freed object.

The reference accounting itself is fine: dvb_unregister_device()
pairs the put() with its own one for the caller, and direct callers
such as dvb_unregister_frontend() and dvb_ca_en50221_release() rely
on dvb_remove_device() consuming the minors-table reference only.
The problem is the ordering, so move the put() after the last use of
the object.  The entry is already gone from dvb_minors[], hence no
concurrent open() can acquire a new reference in between.

dvb_register_device() has the mirror problem.  It fills in
dvb_minors[minor] before calling dvb_register_media_device() and
device_create(), and when one of them fails it frees the object and
the file operations:

	dvbdev->minor = minor;
	dvb_minors[minor] = dvb_device_get(dvbdev);
	up_write(&minor_rwsem);
	ret = dvb_register_media_device(...);       /* may fail */
	if (ret) { ...; kfree(dvbdev); }            /* entry stays */
	clsdev = device_create(...);                /* may fail */
	if (IS_ERR(clsdev)) { ...; kfree(dvbdev); } /* entry stays */

An open() that arrives in that window follows the array entry, takes
a reference of its own and runs the file operations of a device whose
registration has not completed, while the error path frees the object
under it and the caller frees the private data behind it.  The array
entry is left behind as well, pointing at freed memory.

The minor number only has to be handed out once, and that is already
guaranteed by dvbdev_register_lock, which is held for the whole
function.  Filling in dvb_minors[] is what makes the device reachable,
so do that last: pick the minor as before, but publish the entry only
after dvb_register_media_device() and device_create() have succeeded.
Since nothing can have looked the device up, the error paths keep
releasing it with a plain kfree(), exactly as they do now, instead of
unpublishing an entry and dropping references that were never taken.

Publishing the entry late leaves a window between device_create() and
the publication in which an open() of the new node finds the entry
empty and fails with -ENODEV even though the node is complete.
dvb_device_open() takes minor_rwsem before it looks the entry up, so
hold the lock across device_create() and the publication: a racing
open() then waits, and sees a device whose entry is already there.
device_create() only fills in the new device and runs its devnode and
uevent callbacks, none of which takes minor_rwsem, and registration
does not take dvbdev_mutex, which dvb_device_open() acquires before
the lock; the lock order is unchanged.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..bd7f52718426 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,7 +545,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	dvbdev->minor = minor;
-	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
@@ -564,6 +563,20 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		return ret;
 	}
 
+	/*
+	 * dvb_minors[] is what dvb_device_open() follows, so publish the
+	 * entry only after device_create() has succeeded: an entry that is
+	 * reachable while it can still fail would let a concurrent open()
+	 * take a reference of its own to the object the error path is
+	 * about to free, together with the private data behind it.
+	 *
+	 * Take minor_rwsem before device_create() and hold it until the
+	 * entry is published.  dvb_device_open() acquires it before it
+	 * looks the minor up, so an open() that races with the
+	 * registration waits for the node to become usable instead of
+	 * finding it without an entry and failing with -ENODEV.
+	 */
+	down_write(&minor_rwsem);
 	clsdev = device_create(dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
@@ -579,10 +592,14 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 		*pdvbdev = NULL;
+		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
 
+	dvb_minors[minor] = dvb_device_get(dvbdev);
+	up_write(&minor_rwsem);
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
@@ -598,7 +615,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -606,6 +622,13 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
 
 	list_del(&dvbdev->list_head);
+
+	/*
+	 * Drop the minors-table reference only after the last use of the
+	 * object above: should this be the last reference, freeing it any
+	 * earlier would turn those statements into a use-after-free.
+	 */
+	dvb_device_put(dvbdev);
 }
 EXPORT_SYMBOL(dvb_remove_device);
 
-- 
2.34.1

