Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794137F74B;
	Thu, 15 Oct 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080717; cv=none; b=g38Q9n77B3gdPm24mZQDVAaKoOjr36abaHyn5SJO+0fUeJ6HSgJW8IMO2oVmdP4cDN4Szv+oE7jmQWIigYIUICEKQynUzYXCIWnLafHezlSs/OQq4Bxu9ikTwBZ1ElnunFkIk+e0UwUnChJvGODLi4UMUoWt/pjqhqA9vj8xEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080717; c=relaxed/simple;
	bh=0dyQ4hQlXgUouOVKa9bWV0guUdmgx6p8arnPiTS4dyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1Ic90XlNOYLIpb/V0JPH3s+14pmKNT28xRTrZfMDPkfX/V4X2XPj4d9aKNtbUbuFRFIbWZIL6/BuaKIB8fTl48qh1jXV1XzW54l+V2hm8y/5/fGDe9t0yfQE1me3ZJ6HDrOl9l1SSpxeKqlGMCMZsIXulFgbx1ydKOQ3DqMnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=UX8dPuCO reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="UX8dPuCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=timllQBsrVmrZh5n1Ol+pGuc1wlMudyaff
	2+nWHQ1dg=; b=UX8dPuCOYCVjfPobjALswg9kyEqQ9Vzgx39UPbjwTWMEME/fL4
	9TTMgQie8B3QSFQBJZ4jwYnDHw1pCzxq94HMnUAExuJfveu9f1NHPMV+qrHrnDq6
	Fho2gBn0vyXoATWU9Xpg82xoM1bsiRLY3OwCQQY2E1uAHC1S8fWeJUYiE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.59])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAWOwE3+9BqqQmlAA--.58379S3;
	Fri, 16 Oct 2026 00:11:36 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v2 1/3] media: dvb-core: fix use-after-free in dvb_remove_device() and dvb_device_open()
Date: Fri, 16 Oct 2026 00:11:32 +0800
Message-Id: <20261015161134.10425-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkAWOwE3+9BqqQmlAA--.58379S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18tr1DWrW5CF17CFyUZFb_yoW7uF4kpF
	ZIga45KrWDKr40gr47AF109F98Arnay3yruFWa9r97Kr4fJrySyryvyFWUAr13JrZ7AFyj
	qry3Gryku3y5Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
	kF7I0En4kS14v26r126r1DMxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRiiiStUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUHD2rQ7rwJiwABsk

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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvbdev.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..9eb88625c7f6 100644
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
2.34.1

