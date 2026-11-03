Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692482;
	b=LpHyhqjZVXrqq9rNArpTMj4gjKkVhY+fyALG7fXXKaYfeuiu/ur6pdIcevJ4T6GLH95G
	 YY7pO21Umqea4rnMNfdt2fjHZUQozfDYhX2lIVoydXHkfMH+HnHi+lCk6fTFr+/oOZ9Sq
	 x68popb4H7vSJbLmphBTpzg6vMOxMF46Ljo4vJjT2lDfPbJtVwpNsLww45dvekyDKgtHX
	 mT5CbksFLLrjp1f0MR32TiLKdpDXYdQscoC4Qq8y+JteJ6E6qVUxdQ39NEkpx2JTch9Ne
	 pSDwVL1rFqzvEc/k4X+Z6FST+sKbEF5IFDw/cbHUJniMniP+EWrMbKQp9GUhvmRZt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692482;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=3AVUzai6kUvRwEMdGkNO6IDLtw6WkIQXLNpWFxmybmw=;
	b=OPQeqAC+63P3VNV1o972EHspb+3JQSFRlevzsE5p9uMphp2N2mzs13fKO+ZZYY5BUis3
	 IJCdMIfyGxyNmw5wn+Rla3+QoQQ1Mb2dwt3GN0PElS+v3zy/s8l/OawaDX3HLpLYVSjJD
	 6lElEZO0C1lGzTrSlO4Y8aORn2/AJepsLuVhU8fp2ERH1aOv6URxIAN4YJppQjzn3wWAo
	 Sg3wTFWmZrcss37vYI5UHdVQWVHosrSW0D+1DLMRgTeIwlSC1aPplygpBWgKj6CCLMI9M
	 lNPWYoX/jCYHygbVRV7v8xkSkasDR5HPqcVi2YikbV0EtllCdVDfCj/8lZ2+ch4cLQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989CF606A329;
	Tue,  3 Nov 2026 07:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989CF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3AVUzai6kUvRwEMdGkNO6IDLtw6WkIQXLN
	pWFxmybmw=; b=xIZ7SuypzZlMlV2ZQO/8x2Nj3/RmX3pYxH5lGv0+Ex0drpWa9e
	8WoiIeL1tmA7Q+jFR629zDf5bOBrH3O4zrKuE+jbSYF9LnZKtoaBFa7IlclhAId0
	YxuCdKfycPSq9b6mKs/cKhiQ6z7igOGoOg2DXBAwLjOJ++/mOQ3xsDIY8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2fP8sk+lqE0IdAQ--.49868S3;
	Tue, 03 Nov 2026 15:54:26 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v5 1/3] media: dvb-core: fix use-after-free in dvb_remove_device()
Date: Tue,  3 Nov 2026 15:54:18 +0800
Message-Id: <20261103075420.7772-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2fP8sk+lqE0IdAQ--.49868S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18tr1DGry3tr47AFy7Jrb_yoW7Aw13pF
	Z8Wa45KrWq9r4xWr4UAF1jvF95Cr1Sy34rCrWSkrn7KF43JFyIyrZ5ta4UJa13A397AFyU
	XFW7Jr1kW3yUCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUF2NNUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2rop1WenQAAs+

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

A devtmpfs or udev open() that arrives between device_create() and the
publication finds dvb_minors[minor] still empty and gets -ENODEV, the
same answer it gets for a minor that does not exist yet.  Closing that
window would require holding minor_rwsem across device_create(), which
would serialize every DVB open() against the uevent handling of the
new node; the window is a few instructions wide and userspace retries.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..ef88a6395442 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,7 +545,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	dvbdev->minor = minor;
-	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
@@ -583,6 +582,18 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		return PTR_ERR(clsdev);
 	}
 
+	/*
+	 * dvb_minors[] is what dvb_device_open() follows, so fill it in
+	 * only now that dvb_register_media_device() and device_create()
+	 * have succeeded: an entry that is reachable while those can still
+	 * fail would let a concurrent open() take a reference of its own to
+	 * the object the error paths are about to free, together with the
+	 * private data behind it.
+	 */
+	down_write(&minor_rwsem);
+	dvb_minors[minor] = dvb_device_get(dvbdev);
+	up_write(&minor_rwsem);
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
@@ -598,7 +609,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -606,6 +616,13 @@ void dvb_remove_device(struct dvb_device *dvbdev)
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

