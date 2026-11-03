Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716804;
	b=y74JH2CkjJpvxjyk+Idv2VkshabTc9dhdrJBdnMNIu688EeC0FrWLLOgX6004f4k9OKl
	 CYFAkfPiDSBoLcud8ZjjXOU4R2+ebIPqC0BilCztmo7W50gYixVTnXMXrNqFtSME3TvFC
	 D9/SBB7Y72bx0HGkC5ytmH6+yj8H2kOd5DcCzxnUrt0uz19uTAWy5xe3K0haLboHHmUXE
	 Ywt+7jG+YFUWBoSC9+ZdBS4kzuzs0rD8uAbocWXlFJRMRqN74oHvQlkvSZUlKhGUanuJB
	 KjkCHFW4GoDsKerDl00bCJL3Es32z+AJauLDWj5L0MBQ/j+O0MATTFFDFZQp40LMjKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=74TICv+5YStubfX2CIPIev5r7m1jpYD7cBYYlpnMb3c=;
	b=WA6BkDK7Gr0JmpMoTVinLWwp2Mt7pciMQjhC4kDlHp/a0mOhDRCdP0JYTvcVduRAA7C5
	 +50syb0MGIj8zXdMVJtvCm+sQn4qTdo1dP6ekOp8xm2c++EKR77QfVcgBNE3L6c2Dhj+w
	 lTXWE8jm0gz/1ZjOngtQl1r2cBMuL3h/zoR9SJAD6d8pKAyU/cixTd60Wy2vDsKynKDXK
	 VoSUlbPtvhfLBG6GCqAkDrAhe4298WG0wr0Seu+C75gAl4h7oGdfN1FEd+KNEWva+Awil
	 BgAIVRDKqwFceVFU7wQjd3JNFL9MiUjaJxI5vhsX7Kii8aIQLe4uQ21WAzW6wkAVOcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ep1kDC;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927E606A33C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C927E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ep1kDC
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1967687b3a.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716803; x=1794321603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=74TICv+5YStubfX2CIPIev5r7m1jpYD7cBYYlpnMb3c=;
        b=N7Ep1kDCzVNomuGJHpe2I/4RMBqyaaKuxuM1BbIcB/kj/0FOOH4oACX/VW9QZ40Y3w
         HmWXuV47iazMKSg6grKpCjto8Xvi4QCcFK32oLQzyToFgo0w8YI/63kcamuo9br1kCp/
         102I+7f2dkVzZo4TU5KZT0fTWZlMMVnUxezRlDumbbV8mXSBJqsRi9ZBCMVUGpr7exNq
         iNjdf3ZF+IogZXUZN2yy//FtuNNxRnWyJFlTQPpeOd7aia/3Ou9dssQIqPnc02JYjeH1
         dVMY5lI3IwrcIlvf4Y8ZxjlrSmTXSwPHS7Uc532mAaOhN1rjsKWIMqejuNcjzAR2LJUN
         IQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716803; x=1794321603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74TICv+5YStubfX2CIPIev5r7m1jpYD7cBYYlpnMb3c=;
        b=e7XGgJoCfWlWtJJ0b58SYUCZi9W4wAwU4XXUPDngJ9wcTaR5wRzQ4SmNU7MVZApMQH
         P7WyEtfWefZw/wpfVDPHAMCGwBOZay6sElOZ65h3bm2oKFSutSez8wl6ayClZunj7/uY
         PQt4qdI3xYAPXt8J0pvq18/IyjMspzvUAKv1L8wEK+aKbwzxXH14BMvrlLCdpCYPla1a
         oV5fVoiUXggCbbiD/vxZaV8gfOnGMzSu1AJ0liyktSIArIciKWX+EvAQXpePjZH/Iw82
         X2GHwYRaTNRl7T5GLp+z42uCKfTB4c5bBPruFvrgaM88Kti8I6wtdhS/71Y9QBsW60c2
         hbCw==
X-Forwarded-Encrypted: i=1; AKwUvBxkYzBKK0f726t3jWHyufDbPs3owGyNoIwRbjoAMSJqculy0CX8VUwTFGxZey2V1T8ZkKdhqtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cfwJLPzVd6YoLilftpfPB7nYKiCqxjjHry+AdZUixtST57ay9
	WSOCnDCEDMIAV/WWVFCGb8m3tWh2/GfDC4m1FcpP/xCmbiReu5YCM4zl
X-Gm-Gg: AYBFou1cJupnmKYzAKKY/0SKG9wEpyUGn54oDjvYpsUW7Ie1kD/3oHWZNXS8r1VsDi/
	CLT0AbeV/lm60ftkjNWNzsKMHQMdurfCVR8u/DXQjqsjvoycO6Jpsyr/bS7pnlZ2IhuFMAfDoYs
	Z4GfvFL+KvkT2XJJwak+RySEBaTVf7J1nare29PNNj2qRveHDX+oeRZy5vhl1ggo1U9DajCkqns
	e9XgXxXDb9w3eAj1O8pXD5T7TVBkCnm8SIXStD3S3FQxGCby322vBdZ1q+lwctT5CAiVsCxVXZe
	vk3J1fFMqo/VdDKljWruL3vbP8FmCwj15GBQUKR4nOoBYgF9EFFELpde8DEzKcHYbGJF75oNrJF
	iAnsn7g8hmbe7cVHSlu9GVm+MLpgeTfVHaE+LfgfXgcQJ4cUB+EjTZRxjwbfKCAhkcOAj4f0tzn
	YlYjrGaNUjOA8Bfaez3YWba6bbkD3B0egP3wcrcW08V+8ek3QuITQuhnwT+qRREYzzpswqoOeSA
	svFqvaqU9gwnYV8O9UZLtZbRhEBupM3gSqlDxPQLVJQka4cxRvbrPhZ5qOogAoIXdNnh8K+atmP
	CTVR3zNl23Yem7J32pTFrCPPzhFnSkRFaHTQYkxyTuUDqd7htd138PQ7VlPQAQzE
X-Received: by 2002:a05:6a00:4fc1:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a9be58968emr10639554b3a.20.1793716802603;
        Tue, 03 Nov 2026 06:40:02 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:314f:4575:be3:a064])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fda1asm3349224b3a.6.2026.11.03.06.39.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 06:40:01 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: amit.kumar-mahapatra@amd.com,
	luca.ceresoli@bootlin.com,
	harshit.m.mogalapalli@oracle.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] mtd: virt-concat: Tear the concat down when its master goes away
Date: Tue,  3 Nov 2026 22:39:53 +0800
Message-ID: <20261103143953.69642-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Partitions that are part of a virtual concatenation are never registered
on their own: add_mtd_partitions() hands them to mtd_virt_concat_add() and
skips them, so they are not on the parent's partition list either. The
concatenated device is registered with a copy of the first partition's
struct device, whose parent is the master's device.

When the master is unregistered, mtd_virt_concat_destroy() looks for a
concat item whose DT nodes include the master's of_node. The items hold
the partition nodes, so nothing ever matches: the concat stays registered
and keeps the master's device alive (it stays in the idr and in
/proc/mtd), while the driver frees the master. Reading /proc/mtd then
uses freed memory, and so does device_shutdown(). The concat's partitions
are leaked, and since the item's subdev count is never reset, binding the
driver again writes past the end of concat->subdev[].

The matching branch is reached only from the MTD core's module exit,
which cannot run while the concat is registered (it holds a reference on
the module). There, a failed add_mtd_device() frees the caller's mtd
instead of the child. The concat also puts references on its parts that
it never took.

Find the concats to tear down by the master of their parts instead.
Unregister each one that includes a partition of the master that goes
away, free those partitions and drop them from the item, which keeps its
DT nodes and the other parts, so the concat is joined again when the
master comes back. Do not put references that were never taken, and only
unregister a concat at module exit if it is registered.

For this to work when the parts are on different masters, and when the
concat is in use as its master goes away:
- Keep each part in the slot of its DT node, rather than in the order the
  parts are registered, so that a part whose master comes back does not
  end up last.
- Register the device that mtd_concat_create() returns, instead of a
  copy of it in the item: an item can then be joined again while the old
  device is still open, and the error path of add_mtd_device() no longer
  frees the erase regions the copy still points to.
- Keep the device and its name until its last user puts it, through the
  _get_device() and _put_device() hooks.
- Count the references to each part, held by the item and by each
  device that includes it, so that a part is freed only once no device
  in use includes it: the other master can go away too, or the item can
  be joined again, while the old device is open. The parts left in the
  items are freed at module exit.

Tested on QEMU (arm64 virt, TCG) with KASAN, physmap and the MTD core as
modules, with two partitions of the CFI flash joined by
part-concat-next, and with one partition on each of the two flash banks
described as two flash devices: unbind the first flash, bind it again,
unbind it again, unload the modules. Without this patch the first unbind
leaves the devices behind and each read of /proc/mtd gives KASAN
slab-use-after-free reports in mtd_proc_show(), binding again gives
slab-out-of-bounds writes in mtd_virt_concat_add(), the MTD core cannot
be unloaded, and device_shutdown() at power-off reports use-after-free
and refcount_t underflow. With it the concat is removed on unbind,
created again with its parts in order and readable after binding, and
the MTD core unloads, with no reports. Failing each of the first eight
allocations under mtd_virt_concat_create_join() when binding again fails
the bind, with no reports. The same steps without part-concat-next are
clean with and without this patch.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype
    (its report was the add_mtd_device() failure path in
    mtd_virt_concat_destroy(); running it showed the teardown problem).
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    Changes in v3, after the Sashiko review of v2:
    - Count the references to each part instead of keeping only the parts
      of the master that went away with the open device. In v2 a part of
      the other master was freed when that master went away too, or when
      the item was joined again, while the old device still pointed to it.
    - Free the parts left in the items at module exit.
    
    Changes in v2, after the Sashiko review of v1:
    - Keep each part in the slot of its DT node. With a concat across two
      flash devices, v1 joined it again as kbb-kba-concat after the first
      flash was bound again.
    - Register the device returned by mtd_concat_create() instead of a copy
      in the item. This also removes the double free of the erase regions
      after a failed add_mtd_device(). That path is not reachable on QEMU,
      whose CFI flash has a single erase region, so it is not tested.
    - Keep the concat and its name until the last user puts the concat.
    
    An MTD device held open while its flash driver is unbound gives KASAN
    use-after-free reports in the MTD core and the CFI driver, with or
    without this patch, for a plain partition too: the driver frees the
    master while the open device, whose struct device has the master's as
    its parent, is still around. With this patch a concat held open across
    the unbind gets reports of the same kind, none of them in
    mtd_virt_concat.c. That includes holding the concat across the two
    flash devices open while both are unbound, or while the first is
    unbound, bound again and the second unbound, and then reading its
    second part: with v2 these also used the second part after
    mtd_virt_concat_destroy() had freed it. Closing the device then frees
    its parts.
    
    v2: https://lore.kernel.org/all/20261103080327.90193-1-izaiahsun@gmail.com/
    v1: https://lore.kernel.org/all/20261102083045.8512-1-izaiahsun@gmail.com/

 drivers/mtd/mtd_virt_concat.c | 228 +++++++++++++++++++++-------------
 include/linux/mtd/concat.h    |  14 +--
 2 files changed, 148 insertions(+), 94 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 40b300021dda..84d044bd00e9 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -26,15 +26,32 @@ static LIST_HEAD(concat_node_list);
  * @head: List handle
  * @count: Number of nodes
  * @nodes: Pointer to the nodes (partitions) to concatenate
- * @concat: Concatenation container
+ * @concat: Parts found so far: subdev[i] is the partition of nodes[i], or NULL.
+ *          Each holds a reference to its part.
+ * @vdev: The concatenated device, if it is registered
  */
 struct mtd_virt_concat_node {
 	struct list_head head;
 	unsigned int count;
 	struct mtd_concat *concat;
+	struct mtd_virt_concat_dev *vdev;
 	struct device_node *nodes[] __counted_by(count);
 };
 
+/**
+ * struct mtd_virt_concat_dev - A concatenated device
+ * @mtd: The device, from mtd_concat_create()
+ * @refs: One for the registration and one for each user of the device
+ * @num_parts: Number of entries in @parts
+ * @parts: The parts of the device, each holding a reference to its part
+ */
+struct mtd_virt_concat_dev {
+	struct mtd_info *mtd;
+	struct kref refs;
+	unsigned int num_parts;
+	struct mtd_info *parts[] __counted_by(num_parts);
+};
+
 /**
  * mtd_is_part_concat - Check if the device is already part
  *                       of a concatenated device
@@ -57,94 +74,122 @@ static bool mtd_is_part_concat(struct device_node *dev)
 	return false;
 }
 
-static void mtd_virt_concat_put_mtd_devices(struct mtd_concat *concat)
+/*
+ * A part is never registered on its own, so its refcnt, which the MTD core
+ * only uses for registered devices, counts the concat item and the
+ * concatenated devices that hold it. A part can outlive its master's
+ * unregistration in a concatenated device that is still in use.
+ */
+static void mtd_virt_concat_free_part(struct kref *refcnt)
 {
-	int i;
+	struct mtd_info *part = container_of(refcnt, struct mtd_info, refcnt);
+
+	kfree(part->name);
+	kfree(part);
+}
+
+static void mtd_virt_concat_put_part(struct mtd_info *part)
+{
+	kref_put(&part->refcnt, mtd_virt_concat_free_part);
+}
+
+static void mtd_virt_concat_release(struct kref *refs)
+{
+	struct mtd_virt_concat_dev *vdev =
+		container_of(refs, struct mtd_virt_concat_dev, refs);
+	unsigned int i;
+
+	kfree(vdev->mtd->name);
+	mtd_concat_destroy(vdev->mtd);
+	for (i = 0; i < vdev->num_parts; i++)
+		mtd_virt_concat_put_part(vdev->parts[i]);
+	kfree(vdev);
+}
+
+/*
+ * A concatenated device has no parent, so it is its own master: the MTD core
+ * calls these for each of its users, the last _put_device() after it is done
+ * with the device.
+ */
+static int mtd_virt_concat_get_device(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_dev *vdev = mtd->priv;
 
-	for (i = 0; i < concat->num_subdev; i++)
-		put_mtd_device(concat->subdev[i]);
+	kref_get(&vdev->refs);
+	return 0;
+}
+
+static void mtd_virt_concat_put_device(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_dev *vdev = mtd->priv;
+
+	kref_put(&vdev->refs, mtd_virt_concat_release);
+}
+
+/* Unregister the concatenated device of @item, if it is registered */
+static void mtd_virt_concat_unregister(struct mtd_virt_concat_node *item)
+{
+	struct mtd_virt_concat_dev *vdev = item->vdev;
+
+	if (vdev) {
+		item->vdev = NULL;
+		del_mtd_device(vdev->mtd);
+		kref_put(&vdev->refs, mtd_virt_concat_release);
+	}
 }
 
 void mtd_virt_concat_destroy_joins(void)
 {
-	struct mtd_virt_concat_node *item, *tmp;
-	struct mtd_info *mtd;
+	struct mtd_virt_concat_node *item;
+	int idx;
 
-	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
-		mtd = &item->concat->mtd;
-		if (item->concat) {
-			mtd_device_unregister(mtd);
-			kfree(mtd->name);
-			mtd_virt_concat_put_mtd_devices(item->concat);
-			mtd_concat_destroy(mtd);
+	list_for_each_entry(item, &concat_node_list, head) {
+		mtd_virt_concat_unregister(item);
+		for (idx = 0; idx < item->count; idx++) {
+			if (item->concat->subdev[idx])
+				mtd_virt_concat_put_part(item->concat->subdev[idx]);
 		}
+		kfree(item->concat);
+		item->concat = NULL;
 	}
 }
 
 /**
- * mtd_virt_concat_destroy - Destroy the concat that includes the mtd object
+ * mtd_virt_concat_destroy - Destroy the concats that include partitions of
+ *                           an MTD device
  * @mtd:        pointer to 'mtd_info'
  *
- * Return: 0 on success, -error otherwise.
+ * Called when the master of @mtd is unregistered. Partitions of that master
+ * that are part of a concatenation were never registered on their own, so
+ * unregister every concat that includes one of them, and free them once no
+ * concatenated device that is still in use holds them. The other parts stay
+ * with the concat item, which is joined again once all its parts are back.
+ *
+ * Return: 0.
  */
 int mtd_virt_concat_destroy(struct mtd_info *mtd)
 {
-	struct mtd_info *child, *master = mtd_get_master(mtd);
-	struct mtd_virt_concat_node *item, *tmp;
+	struct mtd_info *part, *master = mtd_get_master(mtd);
+	struct mtd_virt_concat_node *item;
 	struct mtd_concat *concat;
-	int idx, ret = 0;
-	bool is_mtd_found;
-
-	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
-		is_mtd_found = false;
+	int idx;
 
-		/* Find the concat item that hold the mtd device */
-		for (idx = 0; idx < item->count; idx++) {
-			if (item->nodes[idx] == mtd->dev.of_node) {
-				is_mtd_found = true;
-				break;
-			}
-		}
-		if (!is_mtd_found)
-			continue;
+	list_for_each_entry(item, &concat_node_list, head) {
 		concat = item->concat;
 
-		/*
-		 * Since this concatenated device is being removed, retrieve
-		 * all MTD devices that are part of it and register them
-		 * individually.
-		 */
-		for (idx = 0; idx < concat->num_subdev; idx++) {
-			child = concat->subdev[idx];
-			if (child->dev.of_node != mtd->dev.of_node) {
-				ret = add_mtd_device(child);
-				if (ret)
-					goto out;
-			}
-		}
-		/* Destroy the concat */
-		if (concat->mtd.name) {
-			del_mtd_device(&concat->mtd);
-			kfree(concat->mtd.name);
-			mtd_virt_concat_put_mtd_devices(item->concat);
-			mtd_concat_destroy(&concat->mtd);
+		for (idx = 0; idx < item->count; idx++) {
+			part = concat->subdev[idx];
+			if (!part || mtd_get_master(part) != master)
+				continue;
+
+			mtd_virt_concat_unregister(item);
+			concat->subdev[idx] = NULL;
+			concat->num_subdev--;
+			mtd_virt_concat_put_part(part);
 		}
-
-		list_del(&item->head);
-		for (idx = 0; idx < item->count; idx++)
-			of_node_put(item->nodes[idx]);
-
-		kfree(item);
 	}
-	return 0;
-out:
-	mutex_lock(&master->master.partitions_lock);
-	list_del(&child->part.node);
-	mutex_unlock(&master->master.partitions_lock);
-	kfree(mtd->name);
-	kfree(mtd);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -226,7 +271,11 @@ bool mtd_virt_concat_add(struct mtd_info *mtd)
 		concat = item->concat;
 		for (idx = 0; idx < item->count; idx++) {
 			if (item->nodes[idx] == mtd->dev.of_node) {
-				concat->subdev[concat->num_subdev++] = mtd;
+				if (concat->subdev[idx])
+					return false;
+				kref_init(&mtd->refcnt);
+				concat->subdev[idx] = mtd;
+				concat->num_subdev++;
 				return true;
 			}
 		}
@@ -287,6 +336,7 @@ int mtd_virt_concat_node_create(void)
 int mtd_virt_concat_create_join(void)
 {
 	struct mtd_virt_concat_node *item;
+	struct mtd_virt_concat_dev *vdev;
 	struct mtd_concat *concat;
 	struct mtd_info *mtd;
 	ssize_t name_sz;
@@ -301,7 +351,7 @@ int mtd_virt_concat_create_join(void)
 		 * concatenation are not handy, concat MTD device can't be
 		 * created hence switch to next concat device.
 		 */
-		if (item->count != concat->num_subdev) {
+		if (item->count != concat->num_subdev || item->vdev) {
 			continue;
 		} else {
 			/* Calculate the legth of the name of the virtual device */
@@ -309,10 +359,8 @@ int mtd_virt_concat_create_join(void)
 				name_sz += (strlen(concat->subdev[idx]->name) + 1);
 			name_sz += strlen(CONCAT_POSTFIX);
 			name = kmalloc(name_sz + 1, GFP_KERNEL);
-			if (!name) {
-				mtd_virt_concat_put_mtd_devices(concat);
+			if (!name)
 				return -ENOMEM;
-			}
 
 			ret = 0;
 			for (idx = 0; idx < concat->num_subdev; idx++) {
@@ -321,34 +369,40 @@ int mtd_virt_concat_create_join(void)
 			}
 			sprintf((name + ret), CONCAT_POSTFIX);
 
-			if (concat->mtd.name) {
-				ret = memcmp(concat->mtd.name, name, name_sz);
-				if (ret == 0) {
-					kfree(name);
-					continue;
-				}
+			vdev = kzalloc_flex(*vdev, parts, item->count);
+			if (!vdev) {
+				kfree(name);
+				return -ENOMEM;
 			}
+			vdev->num_parts = item->count;
+
 			mtd = mtd_concat_create(concat->subdev, concat->num_subdev, name);
 			if (!mtd) {
+				kfree(vdev);
 				kfree(name);
 				return -ENXIO;
 			}
-			concat->mtd = *mtd;
 			/* Arbitrary set the first device as parent */
-			concat->mtd.dev.parent = concat->subdev[0]->dev.parent;
-			concat->mtd.dev = concat->subdev[0]->dev;
+			mtd->dev = concat->subdev[0]->dev;
+			mtd->priv = vdev;
+			mtd->_get_device = mtd_virt_concat_get_device;
+			mtd->_put_device = mtd_virt_concat_put_device;
+			vdev->mtd = mtd;
+			kref_init(&vdev->refs);
+			for (idx = 0; idx < item->count; idx++) {
+				vdev->parts[idx] = concat->subdev[idx];
+				kref_get(&vdev->parts[idx]->refcnt);
+			}
 
 			/* Add the mtd device */
-			ret = add_mtd_device(&concat->mtd);
-			if (ret)
-				goto destroy_concat;
+			ret = add_mtd_device(mtd);
+			if (ret) {
+				kref_put(&vdev->refs, mtd_virt_concat_release);
+				return ret;
+			}
+			item->vdev = vdev;
 		}
 	}
 
 	return 0;
-
-destroy_concat:
-	mtd_concat_destroy(mtd);
-
-	return ret;
 }
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index f8d4d6ac1fc1..4c09b4f5b6e9 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -62,16 +62,16 @@ bool mtd_virt_concat_add(struct mtd_info *mtd);
 int mtd_virt_concat_create_join(void);
 
 /**
- * mtd_virt_concat_destroy - Remove the concat that includes a specific mtd device
- *                           as one of its components.
+ * mtd_virt_concat_destroy - Remove the concats that include partitions of a
+ *                           specific mtd device as components.
  * @mtd: pointer to MTD device info structure.
  *
- * Returns 0 on succes, or a negative error code.
- *
- * If the mtd_info object is part of a concatenated device, all other MTD devices
- * within that concat are registered individually. The concatenated device is then
- * removed, along with its concatenation component.
+ * Returns 0.
  *
+ * Called when the master of @mtd is unregistered: every concatenated device
+ * with a partition of that master is unregistered, and those partitions are
+ * freed once it is no longer in use. The concatenation is created again when
+ * all its parts are back.
  */
 int mtd_virt_concat_destroy(struct mtd_info *mtd);
 

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

