Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606355;
	b=3nTn/mL6jZxPOo0grR5jtHOcm3lb7WY4UpbupKe41u7IkI5wBTNi0ksovK4M3DqE5aqW
	 Nt9MvAPWETJ+ePVOOkOW3WeEMzNiCB49+FzwiV2cTtP32/z6jCU7BD4jLwqLW4RzfqHQO
	 XdvdpRduIleoDzBjx6oOT5MJ7SGMe4aBdScDIaRoFNSWlQ0IF5V6uCPk8xN2qPKMsXTBK
	 rQUZjZryM3++MbtD7oWsUcxp7sjm5QEY0wiEANRe/yBvNNEKIPOxUpQTegEmAkgbQn2EM
	 oOa5WYkJrfW9zAr7ssbJDV6AQCo57su+XfqaIbSFAiGiqhQgABBU/lir7dadi5iDa+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606355;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BLmOg9RLSv+qB+M1h/XwBSDbXgByQp+lGqUG24OUMMk=;
	b=PFD1JSs3pnppeacl71H0GklYq3QazYWT2wH68Wa5OWVsg703w29xAjkntUJxXbcZxEjI
	 NvsRzD4zLsEEbSzMZkSneVZTQSq5XXvwJ57hCPD445wSSTTHeCprgUbkZSfzTN8Zp/Fkh
	 MbfcXkXjdgT6noLt02T6HsGUX98VVLtYHWzt9hhbDsUTotlLj/WHrc9Gz4dyjMTFmk5xx
	 DR00t+1l/fgRDYbuQY55ov1mah/k0dx0UZQkMer4cLf52RNcx34Kt3dMt8xdXw/cubZx1
	 mPFEp6GJDrp9lWVpRxfti45/1ytYEezvfsdSi/N9kph1ykE52FNwayPa/xe9eYa+nQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cexUk+HC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07B606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cexUk+HC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F60C1F000D1;
	Wed, 25 Nov 2026 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606355;
	bh=BLmOg9RLSv+qB+M1h/XwBSDbXgByQp+lGqUG24OUMMk=;
	h=Subject:To:Cc:From:Date;
	b=cexUk+HCrh1cBLqyQZCRE1FY/LsAVkiD7HX8XAUgvHgq02G0VFpRuXydtUKN1IcCY
	 ib1OkTQd3dcq+EEgQhYlbCG5hH5qPVT5kBpW5sitvsq0O+UqDskql7eZfBOaAHUTle
	 EVjNxzc8zrrY7hTVoG2MztRBdOf79vLxFe8LZa8U=
Subject: FAILED: patch "[PATCH] dm: fix use-after-free when dm_get_device() widens the open" failed to apply to 5.10-stable tree
To: mtsai@redhat.com,mpatocka@redhat.com,noreply@anthropic.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:40 +0100
Message-ID: <2026112540-keg-disabled-e7cf@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c834161ded1a141a58d5f03b24f6894291222c96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-keg-disabled-e7cf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c834161ded1a141a58d5f03b24f6894291222c96 Mon Sep 17 00:00:00 2001
From: Ming-Hung Tsai <mtsai@redhat.com>
Date: Fri, 6 Nov 2026 19:59:22 +0100
Subject: [PATCH] dm: fix use-after-free when dm_get_device() widens the open
 mode

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

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 8f945f0aeda5..4a7cb0926c17 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1794,7 +1794,7 @@ static void retrieve_deps(struct dm_table *table,
 	deps->count = count;
 	count = 0;
 	list_for_each_entry(dd, dm_table_get_devices(table), list)
-		deps->dev[count++] = huge_encode_dev(dd->dm_dev->bdev->bd_dev);
+		deps->dev[count++] = huge_encode_dev(dd->bdev->bd_dev);
 
 	param->data_size = param->data_start + needed;
 }
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index a483f49dd4ce..db1ec4ae8e56 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -165,14 +165,16 @@ int dm_table_create(struct dm_table **result, blk_mode_t mode,
 
 static void free_devices(struct list_head *devices, struct mapped_device *md)
 {
-	struct list_head *tmp, *next;
+	struct dm_dev_internal *dd, *dd_next;
+	struct dm_dev_ref *ref, *ref_next;
 
-	list_for_each_safe(tmp, next, devices) {
-		struct dm_dev_internal *dd =
-		    list_entry(tmp, struct dm_dev_internal, list);
-		DMWARN("%s: dm_table_destroy: dm_put_device call missing for %s",
-		       dm_device_name(md), dd->dm_dev->name);
-		dm_put_table_device(md, dd->dm_dev);
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
@@ -218,12 +220,27 @@ static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
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
@@ -303,31 +320,6 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
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
@@ -360,7 +352,9 @@ EXPORT_SYMBOL(dm_devt_from_path);
 
 /*
  * Add a device to the list, or just increment the usage count if
- * it's already present.
+ * it's already present with a mode that covers the requested one.
+ * Otherwise open the device again with the requested mode, so the
+ * dm_devs returned earlier stay valid.
  */
 int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 		  struct dm_dev **result)
@@ -368,6 +362,7 @@ int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	int r;
 	dev_t dev;
 	struct dm_dev_internal *dd;
+	struct dm_dev_ref *ref;
 	struct dm_table *t = ti->table;
 
 	BUG_ON(!t);
@@ -380,30 +375,46 @@ int dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 		return -EINVAL;
 
 	dd = find_device(&t->devices, dev);
-	if (!dd) {
+	if (dd) {
+		ref = find_ref(dd, mode);
+		if (ref) {
+			refcount_inc(&ref->count);
+			goto out;
+		}
+	} else {
 		dd = kmalloc_obj(*dd);
 		if (!dd)
 			return -ENOMEM;
-
-		r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev);
-		if (r) {
-			kfree(dd);
-			return r;
-		}
-
-		refcount_set(&dd->count, 1);
-		list_add(&dd->list, &t->devices);
-		goto out;
-
-	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
-		if (r)
-			return r;
+		INIT_LIST_HEAD(&dd->refs);
 	}
-	refcount_inc(&dd->count);
+
+	ref = kmalloc_obj(*ref);
+	if (!ref) {
+		r = -ENOMEM;
+		goto bad;
+	}
+
+	r = dm_get_table_device(t->md, dev, mode, &ref->dm_dev);
+	if (r) {
+		kfree(ref);
+		goto bad;
+	}
+	refcount_set(&ref->count, 1);
+
+	/* A device in the list always has at least one ref */
+	if (list_empty(&dd->refs)) {
+		dd->bdev = ref->dm_dev->bdev;
+		list_add(&dd->list, &t->devices);
+	}
+	list_add_tail(&ref->list, &dd->refs);
 out:
-	*result = dd->dm_dev;
+	*result = ref->dm_dev;
 	return 0;
+
+bad:
+	if (list_empty(&dd->refs))
+		kfree(dd);
+	return r;
 }
 EXPORT_SYMBOL(dm_get_device);
 
@@ -453,23 +464,28 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
  */
 void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
-	int found = 0;
 	struct list_head *devices = &ti->table->devices;
 	struct dm_dev_internal *dd;
+	struct dm_dev_ref *ref;
 
-	list_for_each_entry(dd, devices, list) {
-		if (dd->dm_dev == d) {
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
-		DMERR("%s: device %s not in table devices list",
-		      dm_device_name(ti->table->md), d->name);
+	list_for_each_entry(dd, devices, list)
+		list_for_each_entry(ref, &dd->refs, list)
+			if (ref->dm_dev == d)
+				goto found;
+
+	DMERR("%s: device %s not in table devices list",
+	      dm_device_name(ti->table->md), d->name);
+	return;
+
+found:
+	if (!refcount_dec_and_test(&ref->count))
 		return;
-	}
-	if (refcount_dec_and_test(&dd->count)) {
-		dm_put_table_device(ti->table->md, d);
+
+	dm_put_table_device(ti->table->md, d);
+	list_del(&ref->list);
+	kfree(ref);
+
+	if (list_empty(&dd->refs)) {
 		list_del(&dd->list);
 		kfree(dd);
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 12c26f42ce51..a73355c0125c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1588,7 +1588,7 @@ static void __send_empty_flush(struct clone_info *ci)
 			 */
 			clone = alloc_tio(ci, NULL, 0, &len, GFP_NOIO);
 			atomic_add(1, &ci->io->io_count);
-			bio_set_dev(clone, dd->dm_dev->bdev);
+			bio_set_dev(clone, dd->bdev);
 			clone->bi_end_io = clone_endio;
 			dm_submit_bio_remap(clone, NULL);
 		}
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 7a795979ec72..34f58060243f 100644
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
 

