Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669750;
	b=hXt6lGHnUsh6yGnx2Cx8TFZleJRAv0gcGDv51VOHq91UxEyqpW8w++EG6YUTrZHcQRxi
	 XFp5TNTGGLYVl+jfAxo1YgPhDaLXPOKeTdOya3HUZXizj1BoWlIVSBpbwcXIxpVhL9Pt8
	 IY1jDUaEwqXUxmCjOGuf1ka1fAdor6krunq3Rg2LecV4diyx2n5Rv7CRQMnId4loqvZ0d
	 Oq1OeWbwFxuLRk0GmhSji5JgzHmLjiB3LPWukuFSj34YT3CCnuW4WvPFMg2DT0M6qx7mi
	 k2u8v/BTwPZxjc35/uj3tfE0mFUYWHOTpFMhdTIJY6ib99A/0ePPz1OmBAUl0hShRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c7lyk/n343fo6fCvX23riaW0IjC+xzroFfb7mcPkwVE=;
	b=GkP6VZw/dDnFCB3V/qyQ/vbzpCXX4e8wu+QpxbMBuTRoUozYclT0OKTpqwx9sduNC4MB
	 i6QAOlsiDv2rjd2GFuW95oNfacEdet3PoaV0AZUN7uDzXe2JHUzRRz8JL4E5zy6nWIMV4
	 lg7DzbinPdLl5xXT3MD5r60yH8rzLapwIf95NAxIG+JwhX8BqP30DyB5fNqKtmU83pDGE
	 SgpDjVUyXzKctYlCeFhoXyR/fZJAWQRycedOODsv203DNhxIK43g3g9zGu9KOvQKTtcgo
	 2ZQtJQttHRocftuAo/Qvegvng6MIgafhpoVPHpkpYS6mlWwmUQCGiTdTFqSn04Fh6Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoI2gf+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF614606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoI2gf+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24971F000C4;
	Thu, 26 Nov 2026 05:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669749;
	bh=c7lyk/n343fo6fCvX23riaW0IjC+xzroFfb7mcPkwVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XoI2gf+CFQr3LIIrfkrexUIKoPlL0qjTqrsL6C8ufBup887yl9RkSUdjVWlpKXjtA
	 F5d+xNI3idfCb6G3Qgbgwl81f61Znn1n+HucRIfghtLcyd/IEHmbTyDhosuFGglEMt
	 fx8SN9kssxs+MXDHd5k4K8imnOyFBREF38O27L/APhS9y0E7uwBD9hSuiggpcvbpX3
	 whAVL5NrKbnfh+qembnN7KLz4ECDDLau2K5w5vWcwO5owe7v5qejj1vJE1vb4kRq5u
	 HFs2BiscZ/6FHt01mUMBT0Ajcl937NYUJYZvZYzUPbbuA4f+ymi0zmeHEyd/KuZeb8
	 srDIbTaa0g3gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Claude Opus 5 <noreply@anthropic.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm: fix use-after-free when dm_get_device() widens the open mode
Date: Thu, 26 Nov 2026 00:09:07 -0500
Message-ID: <20261126050849.2095894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-glamour-jujitsu-b9a7@gregkh>
References: <2026112539-glamour-jujitsu-b9a7@gregkh>
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

From: Ming-Hung Tsai <mtsai@redhat.com>

[ Upstream commit c834161ded1a141a58d5f03b24f6894291222c96 ]

There's an UAF bug in dm_get_device(): when a table construction calls
dm_get_device() on the same device twice with widen access mode (e.g.,
read-only first then read-write), the second dm_get_device() calls
upgrade_mode(), which reopens the device in upgraded mode, making
previously returned dm_dev* a stale pointer.

Fixing approaches:
- Add per-mode views (dm_dev_ref) from a per-device dm_dev_internal to
  multiple table_devices.
- Keep reusing the dm_dev_ref when the requested mode is included, i.e.,
  a read-only reference can reuse the read-write opened device within a
  table.
- Maintain a canonical block_device pointer in dm_dev_internal for
  handling the DM_TABLE_DEPS ioctl.

Also tweak the way of mode sharing check in find_ref() to
"(x & mask) == mask". The result stays the same to the previous
upgrade_mode() guard "(x | mask) == x".

Pros: keep the relationship between dm_dev_internal and table_device:
one dm_dev_internal per device, regardless the mode, so the output of
DMM_TABLE_DEPS ioctl unchanged.

Cons: extra dm_dev_ref allocation.

Note that now the table_device's count not necessarily mean the number
tables referecing this <dev, mode> pair, since we're allowing multiple
references within a table.

Signed-off-by: Ming Hung Tsai <mtsai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
Fixes: 86f1152b117a ("dm: allow active and inactive tables to share dm_devs")
Cc: stable@vger.kernel.org
[ sashal: Adapted the patch to keep the per-table devices_lock locking, use kmalloc instead of kmalloc_obj, and fix dm_table_get_integrity_disk() instead of the dm.c hunk. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c |   2 +-
 drivers/md/dm-table.c | 142 +++++++++++++++++++++++-------------------
 drivers/md/dm.h       |  18 +++++-
 3 files changed, 96 insertions(+), 66 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 862ac077696be..b3a4a8814361e 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1685,7 +1685,7 @@ static void retrieve_deps(struct dm_table *table,
 	deps->count = count;
 	count = 0;
 	list_for_each_entry(dd, dm_table_get_devices(table), list)
-		deps->dev[count++] = huge_encode_dev(dd->dm_dev->bdev->bd_dev);
+		deps->dev[count++] = huge_encode_dev(dd->bdev->bd_dev);
 
 	param->data_size = param->data_start + needed;
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 6d4ce9790a564..4920ae3c44c01 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -166,14 +166,16 @@ int dm_table_create(struct dm_table **result, blk_mode_t mode,
 
 static void free_devices(struct list_head *devices, struct mapped_device *md)
 {
-	struct list_head *tmp, *next;
-
-	list_for_each_safe(tmp, next, devices) {
-		struct dm_dev_internal *dd =
-		    list_entry(tmp, struct dm_dev_internal, list);
-		DMWARN("%s: dm_table_destroy: dm_put_device call missing for %s",
-		       dm_device_name(md), dd->dm_dev->name);
-		dm_put_table_device(md, dd->dm_dev);
+	struct dm_dev_internal *dd, *dd_next;
+	struct dm_dev_ref *ref, *ref_next;
+
+	list_for_each_entry_safe(dd, dd_next, devices, list) {
+		list_for_each_entry_safe(ref, ref_next, &dd->refs, list) {
+			DMWARN("%s: dm_table_destroy: dm_put_device call missing for %s",
+			       dm_device_name(md), ref->dm_dev->name);
+			dm_put_table_device(md, ref->dm_dev);
+			kfree(ref);
+		}
 		kfree(dd);
 	}
 }
@@ -219,12 +221,27 @@ static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
 	struct dm_dev_internal *dd;
 
 	list_for_each_entry(dd, l, list)
-		if (dd->dm_dev->bdev->bd_dev == dev)
+		if (dd->bdev->bd_dev == dev)
 			return dd;
 
 	return NULL;
 }
 
+/*
+ * See if the device is already open with a mode that covers the
+ * requested one.
+ */
+static struct dm_dev_ref *find_ref(struct dm_dev_internal *dd, blk_mode_t mode)
+{
+	struct dm_dev_ref *ref;
+
+	list_for_each_entry(ref, &dd->refs, list)
+		if ((ref->dm_dev->mode & mode) == mode)
+			return ref;
+
+	return NULL;
+}
+
 /*
  * If possible, this checks an area of a destination device is invalid.
  */
@@ -304,34 +321,11 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
-/*
- * This upgrades the mode on an already open dm_dev, being
- * careful to leave things as they were if we fail to reopen the
- * device and not to touch the existing bdev field in case
- * it is accessed concurrently.
- */
-static int upgrade_mode(struct dm_dev_internal *dd, blk_mode_t new_mode,
-			struct mapped_device *md)
-{
-	int r;
-	struct dm_dev *old_dev, *new_dev;
-
-	old_dev = dd->dm_dev;
-
-	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,
-				dd->dm_dev->mode | new_mode, &new_dev);
-	if (r)
-		return r;
-
-	dd->dm_dev = new_dev;
-	dm_put_table_device(md, old_dev);
-
-	return 0;
-}
-
 /*
  * Add a device to the list, or just increment the usage count if
- * it's already present.
+ * it's already present with a mode that covers the requested one.
+ * Otherwise open the device again with the requested mode, so the
+ * dm_devs returned earlier stay valid.
  *
  * Note: the __ref annotation is because this function can call the __init
  * marked early_lookup_bdev when called during early boot code from dm-init.c.
@@ -344,6 +338,7 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	unsigned int major, minor;
 	char dummy;
 	struct dm_dev_internal *dd;
+	struct dm_dev_ref *ref;
 	struct dm_table *t = ti->table;
 
 	BUG_ON(!t);
@@ -368,34 +363,48 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	down_write(&t->devices_lock);
 
 	dd = find_device(&t->devices, dev);
-	if (!dd) {
+	if (dd) {
+		ref = find_ref(dd, mode);
+		if (ref) {
+			refcount_inc(&ref->count);
+			goto out;
+		}
+	} else {
 		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
 		if (!dd) {
 			r = -ENOMEM;
 			goto unlock_ret_r;
 		}
+		INIT_LIST_HEAD(&dd->refs);
+	}
 
-		r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev);
-		if (r) {
-			kfree(dd);
-			goto unlock_ret_r;
-		}
+	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref) {
+		r = -ENOMEM;
+		goto bad;
+	}
 
-		refcount_set(&dd->count, 1);
-		list_add(&dd->list, &t->devices);
-		goto out;
+	r = dm_get_table_device(t->md, dev, mode, &ref->dm_dev);
+	if (r) {
+		kfree(ref);
+		goto bad;
+	}
+	refcount_set(&ref->count, 1);
 
-	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
-		if (r)
-			goto unlock_ret_r;
+	/* A device in the list always has at least one ref */
+	if (list_empty(&dd->refs)) {
+		dd->bdev = ref->dm_dev->bdev;
+		list_add(&dd->list, &t->devices);
 	}
-	refcount_inc(&dd->count);
+	list_add_tail(&ref->list, &dd->refs);
 out:
 	up_write(&t->devices_lock);
-	*result = dd->dm_dev;
+	*result = ref->dm_dev;
 	return 0;
 
+bad:
+	if (list_empty(&dd->refs))
+		kfree(dd);
 unlock_ret_r:
 	up_write(&t->devices_lock);
 	return r;
@@ -433,26 +442,31 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
  */
 void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
-	int found = 0;
 	struct dm_table *t = ti->table;
 	struct list_head *devices = &t->devices;
 	struct dm_dev_internal *dd;
+	struct dm_dev_ref *ref;
 
 	down_write(&t->devices_lock);
 
-	list_for_each_entry(dd, devices, list) {
-		if (dd->dm_dev == d) {
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		DMERR("%s: device %s not in table devices list",
-		      dm_device_name(t->md), d->name);
+	list_for_each_entry(dd, devices, list)
+		list_for_each_entry(ref, &dd->refs, list)
+			if (ref->dm_dev == d)
+				goto found;
+
+	DMERR("%s: device %s not in table devices list",
+	      dm_device_name(t->md), d->name);
+	goto unlock_ret;
+
+found:
+	if (!refcount_dec_and_test(&ref->count))
 		goto unlock_ret;
-	}
-	if (refcount_dec_and_test(&dd->count)) {
-		dm_put_table_device(t->md, d);
+
+	dm_put_table_device(t->md, d);
+	list_del(&ref->list);
+	kfree(ref);
+
+	if (list_empty(&dd->refs)) {
 		list_del(&dd->list);
 		kfree(dd);
 	}
@@ -1146,7 +1160,7 @@ static struct gendisk *dm_table_get_integrity_disk(struct dm_table *t)
 	}
 
 	list_for_each_entry(dd, devices, list) {
-		template_disk = dd->dm_dev->bdev->bd_disk;
+		template_disk = dd->bdev->bd_disk;
 		if (!integrity_profile_exists(template_disk))
 			goto no_integrity;
 		else if (prev_disk &&
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index f682295af91f7..1eb5afde80ae8 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -37,10 +37,26 @@
 
 /*
  * List of devices that a metadevice uses and should open/close.
+ * There is one dm_dev_internal per device. It holds one dm_dev_ref
+ * for each mode that the targets opened the device with.
  */
 struct dm_dev_internal {
 	struct list_head list;
-	refcount_t count;
+	struct block_device *bdev;
+	struct list_head refs;
+};
+
+/*
+ * One open of a device with one mode, shared by the targets of a table.
+ * dm_get_device() reuses a dm_dev_ref whose mode covers the requested
+ * mode, and adds a new one only when none does. So the dm_dev_refs of
+ * a device have different modes, and a table holds each table_device
+ * at most once. table_device->count is still the number of tables that
+ * use the table_device.
+ */
+struct dm_dev_ref {
+	struct list_head list;
+	refcount_t count;	/* dm_get_device() calls that returned dm_dev */
 	struct dm_dev *dm_dev;
 };
 
-- 
2.53.0

