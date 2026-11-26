Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669282;
	b=XroA+5GNVLo5iRloU5aKwLG7vNQda7OdHPNo7PknJ67oF8klK6W0QJdNCEuPnrdkS/tK
	 I5Wa8Kz/q86aeBokM8qn7L5PYi4J8nmlSxjY6hCS4S5GhCvW1sdjAKAX8/yd/E2VHUPik
	 /1wWioPB4eTChyZpopVFTjmADDNUJVcPlblRuxMWvYVtMj+OvJ9BKEmoSIXc5Ljw3/jVQ
	 1dGcIml6yUf/NrLpBSwqV1tYZvb3PssKVsaAYb60WTWQWFunhesuVMBLaepdpE23vRg/m
	 5ix4evuxahLsbQo/g3REoaU3HSJP4aZPoNGszEC93r5Z1CQ0XDJiwHIBN/pm0Cg2CuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GJs6vioW8110MEVA2E8Io7+PwxQnvTNQrB14h3wQi04=;
	b=Gyv62+JBV/Po3Q3+i0Sfa26qjg4X/NtX9VyebMSr1MyQTU7luUzL39utvStgn7t37zXq
	 DMcWNIrTCAzBq2hbAso/cv57ns15MVfYXg1yJC6el0Xeu085emuBfN1bqx7+VlQ7p6tZZ
	 xTEXgD3F/u+PNZnGrPLZZdA1qQbbMeUVBxK7wcHD6gnTde4dVN/D2q+jYp1/DInbo2tpA
	 zoGXRcJLAoIcxC/l8zKYTXzaiCIVWwnDkTnE9G4JZQJfWtKA7r2H6k2a7fMqH2MH5wBtu
	 YgIVEeQquzMnoHxvBA9XGj/0YGkkmLKmAN3fV8nDqnflLQvBdyj9F2i3+m68+sUAXfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfJzgkbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED5606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfJzgkbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB41F000C0;
	Thu, 26 Nov 2026 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669281;
	bh=GJs6vioW8110MEVA2E8Io7+PwxQnvTNQrB14h3wQi04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfJzgkbn/YtRks0RWXp9Rpwp/nYTcD8PTZ2jj/Sr5wLPD/NEL832XbERGszgFjNY0
	 sWvaSLEBRbGmTHYLpZw7Nsl3B+foyd39tTgnLpk5bYc7+xc6mPmBNDg8yVZk8m1O5O
	 zoNxe8MDBnmVsqRkgbRXUQILOSqvaCWjxomsU2ie2sWLRZsiszesAPO6vpasFQnxP2
	 rlA/JLRNDrwSQDGJrsYVrXRpPz8lnNKRU4XALvvbAEouqlSWsDIGiDe2yrje0uZdvn
	 hMgVzMjvEZ4X8Q3gL5dCSFvvpQrj0h/3aK5bjdL/fzEV2nPt1A4jGpucEJQtpQSlaS
	 gWW8rWAY2hx6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Claude Opus 5 <noreply@anthropic.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] dm: fix use-after-free when dm_get_device() widens the open mode
Date: Thu, 26 Nov 2026 00:01:19 -0500
Message-ID: <20261126050026.2084106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-pardon-rinsing-acab@gregkh>
References: <2026112538-pardon-rinsing-acab@gregkh>
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
[ sashal: Adapted dm_get_device() and dm_put_device() to the older code, which takes devices_lock and exits through unlock_ret_r/unlock_ret labels instead of returning directly, with kmalloc_obj() context differences. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c |   2 +-
 drivers/md/dm-table.c | 142 +++++++++++++++++++++++-------------------
 drivers/md/dm.c       |   2 +-
 drivers/md/dm.h       |  18 +++++-
 4 files changed, 97 insertions(+), 67 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index bf547ffb9647e..671cac33b2563 100644
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
index 505f8a900ec9e..35eac563f016c 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -167,14 +167,16 @@ int dm_table_create(struct dm_table **result, blk_mode_t mode,
 
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
@@ -220,12 +222,27 @@ static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
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
@@ -305,31 +322,6 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
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
  * Note: the __ref annotation is because this function can call the __init
  * marked early_lookup_bdev when called during early boot code from dm-init.c.
@@ -362,7 +354,9 @@ EXPORT_SYMBOL(dm_devt_from_path);
 
 /*
  * Add a device to the list, or just increment the usage count if
- * it's already present.
+ * it's already present with a mode that covers the requested one.
+ * Otherwise open the device again with the requested mode, so the
+ * dm_devs returned earlier stay valid.
  */
 int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 		  struct dm_dev **result)
@@ -370,6 +364,7 @@ int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	int r;
 	dev_t dev;
 	struct dm_dev_internal *dd;
+	struct dm_dev_ref *ref;
 	struct dm_table *t = ti->table;
 
 	BUG_ON(!t);
@@ -384,34 +379,48 @@ int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	down_write(&t->devices_lock);
 
 	dd = find_device(&t->devices, dev);
-	if (!dd) {
-		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	if (dd) {
+		ref = find_ref(dd, mode);
+		if (ref) {
+			refcount_inc(&ref->count);
+			goto out;
+		}
+	} else {
+		dd = kmalloc_obj(*dd);
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
+	ref = kmalloc_obj(*ref);
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
@@ -458,26 +467,31 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
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
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1df8a808d279e..11facf9a195cb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1611,7 +1611,7 @@ static void __send_empty_flush(struct clone_info *ci)
 			 */
 			clone = alloc_tio(ci, NULL, 0, &len, GFP_NOIO);
 			atomic_add(1, &ci->io->io_count);
-			bio_set_dev(clone, dd->dm_dev->bdev);
+			bio_set_dev(clone, dd->bdev);
 			clone->bi_end_io = clone_endio;
 			dm_submit_bio_remap(clone, NULL);
 		}
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 8887c1f65639d..8160a6993c85b 100644
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

