Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045B3BFAEA;
	Wed, 23 Sep 2026 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155537; cv=none; b=ClGWNF4YTL1pNhghVtAL3RNHrQSoJl5zQeO/SiSV9EPyWCm2mjqmk7IstiU6Qgw9keB8JdFVZ40jQ7iNFNCyeWzCUxbrlw0oRjGl6sLt7bOYCxvi/awMQbewmWpVSA5/Ug1ZDPToU8hnq9mmbDZm5dsciPdM78tPmV/Wu7UdmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155537; c=relaxed/simple;
	bh=nwjgiG58dbg8QXgrIujS5kkvDkFVeEV/roefytOgGDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auFmIg00FY0NyyuPOHk9F+Lcnp0d8fDip3Fz6FCYS4twHlxBctJBmDpwu23iIpxZf4ro5iQGj6LP1JBfa7Gwts0q0FavStKqaFBIKT+CqlXPjTXfBSS/J8sl+63lUOB4NQS/Aek/6jU0b1UZ0/w9j7W26t9Dg0bSngKsAhPuMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=ejEQA94w reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="ejEQA94w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=xGWTUt2t371Cnu03fnjFQX0nTdO+7X2DfL
	qBuDqxQGg=; b=ejEQA94wsVR/opxn5iN3o6VzVT1wOOsyizeYwv/B/JLH1EP/SV
	1+V3Wk9UcuiRxTF34XQN3ukQ5M4aZUNGuK31ZWnNVaPVDSIiuc6evGiP0tDfWose
	8rp2a4tbZhXiJqQj75ivDMwUv1FDFkkxf/H/OhwGCb9GXb/PNpfQUco80=
Received: from localhost.localdomain (unknown [113.200.174.5])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkA2FjUAm7NqdssuAA--.1462S3;
	Wed, 23 Sep 2026 17:25:27 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patrick.boettcher@posteo.de,
	Yuanzhe Liu <25031212351@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] media: dvb-core: fix use-after-free in dvb_remove_device() and dvb_device_open()
Date: Wed, 23 Sep 2026 17:24:51 +0800
Message-ID: <20260923092454.969-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260923092454.969-1-25031212351@stu.xidian.edu.cn>
References: <20260923092454.969-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkA2FjUAm7NqdssuAA--.1462S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18tr1DWrW5CF17CFyUZFb_yoW7Cw1fpF
	ZIga45KrWDKr40gr4xAF109F9xArnay3yruFWagr97Kr4fJry5tryvyFWjyw17JrZ7JFyj
	qrW3Gryku3y5Jr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv04
	87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67
	IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1LvKDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2qyndayuwABsV

dvb_remove_device() clears dvb_minors[] and drops the minors-table
reference under minor_rwsem, but then keeps using "dvbdev":

	down_write(&minor_rwsem);
	dvb_minors[dvbdev->minor] = NULL;
	dvb_device_put(dvbdev);          /* may kfree(dvbdev) */
	up_write(&minor_rwsem);

	dvb_media_device_free(dvbdev);
	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
	list_del(&dvbdev->list_head);

If the put() frees the object (e.g. USB disconnect racing with an
in-flight open() that still holds a reference of its own, or an open()
error path having already dropped the last open() reference), the
remaining three statements are use-after-free. KASAN reports the read
of dvbdev->minor inside device_destroy(), and the list_del() then
writes list poison into the freed object.

dvb_unregister_device() has the same shape: it calls
dvb_remove_device() and then dvb_device_put(), i.e. it relies on
dvb_remove_device() not consuming the caller's reference.

Fix both by making the reference accounting symmetric:

- dvb_remove_device() no longer touches the kref at all. It removes
  the minors entry, frees the media resources, destroys the class
  device and unlinks the object from the adapter list. Everything it
  needs from "dvbdev" is done while the object is still alive; the
  caller still owns its reference.
- dvb_unregister_device() now drops both references the device
  actually holds: the minors-table one and the caller's initial one.
  All in-tree callers that want the object gone already call
  dvb_unregister_device(), so the extra put() restores the previous
  net refcount balance while keeping the object alive until after the
  last use.

While at it, close the dvb_device_open() race that supplied the stale
pointer in the first place: it fetched dvb_minors[minor] under
down_read(&minor_rwsem), but only called dvb_device_get() after a
sequence that a concurrent dvb_remove_device() could preempt to free
the object. KASAN caught this as a read of ->fops on a freed
kmalloc-128 object, together with "refcount_t: addition on 0"
warnings on the same path.

Do the whole lookup + pin atomically under minor_rwsem: take the kref
while still holding the read lock (which excludes the only writer,
dvb_remove_device()), and only then call file->f_op->open().

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d32..9eb8862 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -87,6 +87,8 @@ static int dvb_device_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev;
 	unsigned int minor = iminor(inode);
+	const struct file_operations *new_fops;
+	int err = 0;
 
 	if (minor >= MAX_DVB_MINORS)
 		return -ENODEV;
@@ -94,25 +96,33 @@ static int dvb_device_open(struct inode *inode, struct file *file)
 	mutex_lock(&dvbdev_mutex);
 	down_read(&minor_rwsem);
 
+	/*
+	 * Look the device up and pin it while still holding minor_rwsem.
+	 * dvb_remove_device() takes the write side to clear the entry, so
+	 * once the kref has been taken the object cannot be freed until
+	 * we drop it again.
+	 */
 	dvbdev = dvb_minors[minor];
 
-	if (dvbdev && dvbdev->fops) {
-		int err = 0;
-		const struct file_operations *new_fops;
-
-		new_fops = fops_get(dvbdev->fops);
-		if (!new_fops)
-			goto fail;
-		file->private_data = dvb_device_get(dvbdev);
-		replace_fops(file, new_fops);
-		if (file->f_op->open)
-			err = file->f_op->open(inode, file);
-		up_read(&minor_rwsem);
-		mutex_unlock(&dvbdev_mutex);
-		if (err)
-			dvb_device_put(dvbdev);
-		return err;
+	if (!dvbdev || !dvbdev->fops)
+		goto fail;
+
+	/* Pin the device before dropping minor_rwsem. */
+	file->private_data = dvb_device_get(dvbdev);
+	new_fops = fops_get(dvbdev->fops);
+	up_read(&minor_rwsem);
+	mutex_unlock(&dvbdev_mutex);
+
+	if (!new_fops) {
+		dvb_device_put(dvbdev);
+		return -ENODEV;
 	}
+	replace_fops(file, new_fops);
+	if (file->f_op->open)
+		err = file->f_op->open(inode, file);
+	if (err)
+		dvb_device_put(dvbdev);
+	return err;
 fail:
 	up_read(&minor_rwsem);
 	mutex_unlock(&dvbdev_mutex);
@@ -596,9 +606,16 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 	if (!dvbdev)
 		return;
 
+	/*
+	 * Stop new opens first, then tear down everything that still
+	 * needs the object.  We must not drop the kref here: our caller
+	 * still owns a reference and keeps using the object after this
+	 * function returns.  The minors-table reference is dropped in
+	 * dvb_unregister_device() instead, pairing the dvb_device_get()
+	 * that installed the entry in dvb_register_device().
+	 */
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -632,6 +649,13 @@ void dvb_device_put(struct dvb_device *dvbdev)
 void dvb_unregister_device(struct dvb_device *dvbdev)
 {
 	dvb_remove_device(dvbdev);
+
+	/*
+	 * Drop both the minors-table reference and the caller's own one.
+	 * The object is only freed once every open() fd has dropped its
+	 * reference too.
+	 */
+	dvb_device_put(dvbdev);
 	dvb_device_put(dvbdev);
 }
 EXPORT_SYMBOL(dvb_unregister_device);
-- 
2.45.1.windows.1

