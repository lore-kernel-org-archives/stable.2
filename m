Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD6448CF5;
	Tue, 18 Aug 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045818; cv=none; b=ZEznQ74dYAzKE4BPZKx8TJMrHhVpmFCav2gWZExld7Uw+2M5v+qARpMnGRDu4TTV9buhHSB53oj4EmWxhfIhN2+pXIjLk17c5bkpF0S44so6yUNokJ+ma4/XIeJylCUWsXXgF17iU4AcBdUNdFvm/0p0vnHlBnr0NVZLYdVlQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045818; c=relaxed/simple;
	bh=2VHgt/Xh/MClfU18THklbNo5XLWkp11lh9BcsKjnIww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzuh6D5m/G0iPxzxckVsznPWlOH9U1sqRQQ1JztBna5Zcr2GVRaGft9XEZNpTkqGtnOqG3SdCMnRBpi6yyjBsnlyoQHZ096SuuxZcJ7NfgWq8mhhlJ678Qum99gJHkppYLrL/nEy8uDewcWOlnP+HvONKxXkG0NAWx5YpDF5A6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=P5acwYTD; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=QtxC2gvB; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="P5acwYTD";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QtxC2gvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045810; bh=2VHgt/Xh/MClfU18THklbNo5XLWkp11lh9BcsKjnIww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5acwYTDYHrNmxcHk9HWWQNF9bsYttr60rGIOKqe81ya+nRQMB7rlZ6vH0pamy2jI
	 tcisD3xhqkZNv0thVk/M5pbZZg8aaoj3KG3Cxig/1nUkuJQ+7lCTevQF7A86/ygOm6
	 1hcVxcG3MSsH5x6wKjCXdW4eVR0oGY5Qb4oI6H9VYXtnQd/CPjEcocFY4qjWQYMnXd
	 cY+w7cEiYWDQaSlT/pGBAXGefJPvsmOqBIH7Feorke16M1k8qKWQeaf2xftf6romqB
	 WX/gR0GQDJHMacTy4eV9/HdcqfL5IGVg72YFaKVi7eu4rBUMuVi6MLC8dq/P5Kiyxl
	 XwBMIV3jK4Pjg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id A77A441567; Tue, 18 Aug 2026 10:36:50 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045809; bh=2VHgt/Xh/MClfU18THklbNo5XLWkp11lh9BcsKjnIww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtxC2gvBdLAUGYstC3fiBurKBixOeRBtcl/XkEKB+Ipd63TQV3Z6eoQGvv4J7nA+m
	 Gv1yffIyaLgTONYJbx+Yyl1sg9eOIkjUpwbBLjVB0Oo6LQ0EEXPJxMC444keQxlvib
	 6gvPmDpZ4dReOc015+FancE510a5M556VhrgH6aSlC92AjDedY1eMiBzlnRWsBlFBq
	 WLsWbpu5SQWnoWHeSxdbM/GrzimHwUrByO3Xlugic5Trva2xhfM/U5CMAanpluTfRK
	 DnDBofeSVvR9vMFEdPFhTKStFtQKBK3iJSwkvI8Xj70y2HAzwsWrez8vGl5GozZIxq
	 cVbiz483AI3qQ==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id B45A1408BB;
	Tue, 18 Aug 2026 10:36:48 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] media: rc: Add missing locking for keymap
Date: Tue, 18 Aug 2026 10:36:34 +0100
Message-ID: <5d90a8222e8f994851c452fc6cfdf39d9956cc4e.1787045579.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787045579.git.sean@mess.org>
References: <cover.1787045579.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the rc_map for an rc_dev gets updated, locking is required but is
missing in places. A concurrent scancode lookup and a call to
rc_{register,unregistered}_device() could result in a use-after-free;
this could happen if IR is decoded during those function calls.

We also fix some ugliness like open-coded krealloc() and removing the
pointless alloc member of rc_map.

Add lockdep assertions where locks are required.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 122 ++++++++++++++++++++++---------------
 include/media/rc-map.h     |   2 -
 2 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 10b924186826..2586e1fa0897 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -17,9 +17,8 @@
 #include <linux/module.h>
 #include "rc-core-priv.h"
 
-/* Sizes are in bytes, 256 bytes allows for 32 entries on x64 */
-#define IR_TAB_MIN_SIZE	256
-#define IR_TAB_MAX_SIZE	8192
+#define IR_TAB_MIN_SIZE	32
+#define IR_TAB_MAX_SIZE	1024
 
 static const struct {
 	const char *name;
@@ -105,7 +104,6 @@ static struct rc_map_list *seek_rc_map(const char *name)
 
 struct rc_map *rc_map_get(const char *name)
 {
-
 	struct rc_map_list *map;
 
 	map = seek_rc_map(name);
@@ -202,7 +200,7 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
  * ir_create_table() - initializes a scancode table
  * @dev:	the rc_dev device
  * @rc_map:	the rc_map to initialize
- * @name:	name to assign to the table
+ * @map_name:	name to assign to the table
  * @rc_proto:	ir type to assign to the new table
  * @size:	initial size of the table
  *
@@ -212,23 +210,33 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
  * return:	zero on success or a negative error code
  */
 static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
-			   const char *name, u64 rc_proto, size_t size)
+			   const char *map_name, u64 rc_proto, size_t size)
 {
-	rc_map->name = kstrdup(name, GFP_KERNEL);
-	if (!rc_map->name)
+	struct rc_map_table *scan;
+	unsigned int alloc;
+	char *name;
+
+	name = kstrdup(map_name, GFP_KERNEL);
+	if (!name)
 		return -ENOMEM;
-	rc_map->rc_proto = rc_proto;
-	rc_map->alloc = roundup_pow_of_two(size * sizeof(struct rc_map_table));
-	rc_map->size = rc_map->alloc / sizeof(struct rc_map_table);
-	rc_map->scan = kmalloc(rc_map->alloc, GFP_KERNEL);
-	if (!rc_map->scan) {
-		kfree(rc_map->name);
-		rc_map->name = NULL;
+
+	alloc = roundup_pow_of_two(size);
+	scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
+	if (!scan) {
+		kfree(name);
 		return -ENOMEM;
 	}
 
-	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%u bytes)\n",
-		rc_map->size, rc_map->alloc);
+	scoped_guard(spinlock_irqsave, &dev->rc_map.lock) {
+		rc_map->name = name;
+		rc_map->scan = scan;
+		rc_map->rc_proto = rc_proto;
+		rc_map->len = 0;
+		rc_map->size = alloc;
+	}
+
+	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%zu bytes)\n",
+		rc_map->size, rc_map->size * sizeof(struct rc_map_table));
 	return 0;
 }
 
@@ -236,16 +244,26 @@ static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
  * ir_free_table() - frees memory allocated by a scancode table
  * @rc_map:	the table whose mappings need to be freed
  *
- * This routine will free memory alloctaed for key mappings used by given
+ * This routine will free memory allocated for key mappings used by given
  * scancode table.
  */
 static void ir_free_table(struct rc_map *rc_map)
 {
-	rc_map->size = 0;
-	kfree(rc_map->name);
-	rc_map->name = NULL;
-	kfree(rc_map->scan);
-	rc_map->scan = NULL;
+	struct rc_map_table *scan;
+	const char *name;
+
+	scoped_guard(spinlock_irqsave, &rc_map->lock) {
+		name = rc_map->name;
+		scan = rc_map->scan;
+
+		rc_map->size = 0;
+		rc_map->len = 0;
+		rc_map->name = NULL;
+		rc_map->scan = NULL;
+	}
+
+	kfree(name);
+	kfree(scan);
 }
 
 /**
@@ -262,38 +280,38 @@ static void ir_free_table(struct rc_map *rc_map)
 static int ir_resize_table(struct rc_dev *dev, struct rc_map *rc_map,
 			   gfp_t gfp_flags)
 {
-	unsigned int oldalloc = rc_map->alloc;
-	unsigned int newalloc = oldalloc;
-	struct rc_map_table *oldscan = rc_map->scan;
+	unsigned int newsize = rc_map->size;
 	struct rc_map_table *newscan;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	if (rc_map->size == rc_map->len) {
 		/* All entries in use -> grow keytable */
-		if (rc_map->alloc >= IR_TAB_MAX_SIZE)
+		newsize *= 2;
+
+		if (newsize >= IR_TAB_MAX_SIZE)
 			return -ENOMEM;
 
-		newalloc *= 2;
-		dev_dbg(&dev->dev, "Growing table to %u bytes\n", newalloc);
+		dev_dbg(&dev->dev, "Growing table to %u entries\n", newsize);
 	}
 
-	if ((rc_map->len * 3 < rc_map->size) && (oldalloc > IR_TAB_MIN_SIZE)) {
+	if (rc_map->len * 3 < rc_map->size && rc_map->size > IR_TAB_MIN_SIZE) {
 		/* Less than 1/3 of entries in use -> shrink keytable */
-		newalloc /= 2;
-		dev_dbg(&dev->dev, "Shrinking table to %u bytes\n", newalloc);
+		newsize /= 2;
+		dev_dbg(&dev->dev, "Shrinking table to %u entries\n", newsize);
 	}
 
-	if (newalloc == oldalloc)
+	if (newsize == rc_map->size)
 		return 0;
 
-	newscan = kmalloc(newalloc, gfp_flags);
+	newscan = krealloc_array(rc_map->scan, newsize,
+				 sizeof(struct rc_map_table), gfp_flags);
 	if (!newscan)
 		return -ENOMEM;
 
-	memcpy(newscan, rc_map->scan, rc_map->len * sizeof(struct rc_map_table));
 	rc_map->scan = newscan;
-	rc_map->alloc = newalloc;
-	rc_map->size = rc_map->alloc / sizeof(struct rc_map_table);
-	kfree(oldscan);
+	rc_map->size = newsize;
+
 	return 0;
 }
 
@@ -318,6 +336,8 @@ static unsigned int ir_update_mapping(struct rc_dev *dev,
 	int old_keycode = rc_map->scan[index].keycode;
 	int i;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	/* Did the user wish to remove the mapping? */
 	if (new_keycode == KEY_RESERVED || new_keycode == KEY_UNKNOWN) {
 		dev_dbg(&dev->dev, "#%d: Deleting scan 0x%04llx\n",
@@ -373,6 +393,8 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 {
 	unsigned int i;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	/*
 	 * Unfortunately, some hardware-based IR decoders don't provide
 	 * all bits for the complete IR code. In general, they provide only
@@ -397,7 +419,7 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 	/* No previous mapping found, we might need to grow the table */
 	if (rc_map->size == rc_map->len) {
 		if (!resize || ir_resize_table(dev, rc_map, GFP_ATOMIC))
-			return -1U;
+			return UINT_MAX;
 	}
 
 	/* i is the proper index to insert our new keycode */
@@ -479,16 +501,18 @@ static int ir_setkeytable(struct rc_dev *dev, const struct rc_map *from)
 	if (rc)
 		return rc;
 
-	for (i = 0; i < from->size; i++) {
-		index = ir_establish_scancode(dev, rc_map,
-					      from->scan[i].scancode, false);
-		if (index >= rc_map->len) {
-			rc = -ENOMEM;
-			break;
-		}
+	scoped_guard(spinlock_irqsave, &dev->rc_map.lock) {
+		for (i = 0; i < from->size; i++) {
+			index = ir_establish_scancode(dev, rc_map,
+						      from->scan[i].scancode, false);
+			if (index >= rc_map->len) {
+				rc = -ENOMEM;
+				break;
+			}
 
-		ir_update_mapping(dev, rc_map, index,
-				  from->scan[i].keycode);
+			ir_update_mapping(dev, rc_map, index,
+					  from->scan[i].keycode);
+		}
 	}
 
 	if (rc)
@@ -524,6 +548,8 @@ static unsigned int ir_lookup_by_scancode(const struct rc_map *rc_map,
 {
 	struct rc_map_table *res;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	res = bsearch(&scancode, rc_map->scan, rc_map->len,
 		      sizeof(struct rc_map_table), rc_map_cmp);
 	if (!res)
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index d95ed3e96de2..f167c37179c8 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -148,7 +148,6 @@ struct rc_map_table {
  * @scan: pointer to struct &rc_map_table
  * @size: Max number of entries
  * @len: Number of entries that are in use
- * @alloc: size of \*scan, in bytes
  * @rc_proto: type of the remote controller protocol, as defined at
  *	     enum &rc_proto
  * @name: name of the key map table
@@ -158,7 +157,6 @@ struct rc_map {
 	struct rc_map_table	*scan;
 	unsigned int		size;
 	unsigned int		len;
-	unsigned int		alloc;
 	enum rc_proto		rc_proto;
 	const char		*name;
 	spinlock_t		lock;
-- 
2.55.0

