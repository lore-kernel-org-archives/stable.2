Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5747729E;
	Tue, 15 Sep 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461188; cv=none; b=RdIPCjGJQpfH+WrdEZEkMy/aA1YGb4JjSf+4jW2ftAg1b6rg7kNumA4/HbpMrWhfj5P0PCGzTTB9It3N2punBtdhWBue/oB0XL1jt6N7PdTlgeY/qzzOqyEHZHbO+jOQ4Tu7o4lKWy6NOjzJ+QoTOXMEPfGKKzwHn91Yo61Hc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461188; c=relaxed/simple;
	bh=rSfoErJNiGhYOLFlwZ8B3IrTpHvf3lTCgyNGPfFxSi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bduyh6P8ruc6tYk/DkHKSlE4LuTy5Tu4uTy4r/5iUpLkaPK5WoGO/3/dUByyJYN+6wbrrJtltJ8Fb28o3vO1O+51PLmBvPKIbVK8i4w1glhduxVY4wgttFPHwkaftBa8X82GY69BmlnjJn3GjVFst+nmr2xS5vB6xHF8HhqZE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rVCx/FP0; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=s/cRRlZe; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rVCx/FP0";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="s/cRRlZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461183; bh=rSfoErJNiGhYOLFlwZ8B3IrTpHvf3lTCgyNGPfFxSi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVCx/FP0wUTzaGOvLVIN+rpMTqXyYct6y6iat+d7t8HgK3bGKTbiI6bXGKBg/VcRd
	 L74fqD0cOg6D1z/EGzoeFpCY/XbqmBbXS1zAbUJPxdhHozoBSJlEGpbkG1+HPGc/H/
	 HQR6+kLnJ47Un+8kxGh4HRalF3TTsCDq8c33iIccNhqn8Wl9yYzdF8d+ntwkI447nT
	 a+IEDio3NCNeH/eQ3fvTgqsQpTncyv/dXjt7ZMHbPyei5bwG+hehXvMHZOAm0Roq2f
	 8cVdXWra/ToIHmA8Gp36sLsRwC7muMIv533ICa03D9SzGh9Y6bw0gfeNbYddcrN8Tj
	 9UMOg6/RRLXQw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 87B0040BAF; Tue, 15 Sep 2026 09:33:03 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461182; bh=rSfoErJNiGhYOLFlwZ8B3IrTpHvf3lTCgyNGPfFxSi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/cRRlZe/nlzPqyJEWGtxQisDty/C95xmuKhwppYWNf1NhmSJpXpTxCzd7/1wqqzK
	 QvS88ZTEAghx1r7/WGqmIJX813pTrpGlx66ionY+BUZKAKA6FSkFN6Y5S5qwkv537g
	 UFeSckvRS4At1KN8gHohSL+LYMsPAM4hnJRyKxkWxqRPan1uEePTPLV4JJF8bfpja7
	 P5p1aar6oW52WfA8yutvW5HN2Z3cFCAkcBxmWF+9UMmPrVHG53eOoWO5xvuQM4bsJQ
	 +pjDvU9xSHbti8VhhxoMQOZoL9iBv1dqPuh/NAXe6lHUEtZq9hx5+qOiaOoHDxNmkj
	 Z0ElgNtJ92CDw==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id A0DB840155;
	Tue, 15 Sep 2026 09:33:01 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/20] media: rc: Add missing locking for keymap
Date: Tue, 15 Sep 2026 09:32:15 +0100
Message-ID: <5c2951b6680a99239aa7c983e65570c1314a9c03.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
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

Add lockdep assertions where locks are required.

ir_free_table() should only be called for non-TX devices else we will
use a spinlock without iniitializing it.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 86 +++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 53e39b7a489a..67d86b8ea5e0 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -104,7 +104,6 @@ static struct rc_map_list *seek_rc_map(const char *name)
 
 struct rc_map *rc_map_get(const char *name)
 {
-
 	struct rc_map_list *map;
 
 	map = seek_rc_map(name);
@@ -201,7 +200,7 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
  * ir_create_table() - initializes a scancode table
  * @dev:	the rc_dev device
  * @rc_map:	the rc_map to initialize
- * @name:	name to assign to the table
+ * @map_name:	name to assign to the table
  * @rc_proto:	ir type to assign to the new table
  * @size:	initial size of the table
  *
@@ -211,23 +210,31 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
  * return:	zero on success or a negative error code
  */
 static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
-			   const char *name, u64 rc_proto, size_t size)
+			   const char *map_name, u64 rc_proto, size_t size)
 {
+	struct rc_map_table *scan;
 	unsigned int alloc;
-	rc_map->name = kstrdup(name, GFP_KERNEL);
-	if (!rc_map->name)
+	char *name;
+
+	name = kstrdup(map_name, GFP_KERNEL);
+	if (!name)
 		return -ENOMEM;
+
 	alloc = roundup_pow_of_two(size);
-	rc_map->rc_proto = rc_proto;
-	rc_map->len = 0;
-	rc_map->size = alloc;
-	rc_map->scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
-	if (!rc_map->scan) {
-		kfree(rc_map->name);
-		rc_map->name = NULL;
+	scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
+	if (!scan) {
+		kfree(name);
 		return -ENOMEM;
 	}
 
+	scoped_guard(spinlock_irqsave, &rc_map->lock) {
+		rc_map->name = name;
+		rc_map->scan = scan;
+		rc_map->rc_proto = rc_proto;
+		rc_map->len = 0;
+		rc_map->size = alloc;
+	}
+
 	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%zu bytes)\n",
 		alloc, alloc * sizeof(struct rc_map_table));
 	return 0;
@@ -237,16 +244,26 @@ static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
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
@@ -266,6 +283,8 @@ static int ir_resize_table(struct rc_dev *dev, struct rc_map *rc_map,
 	unsigned int newsize = rc_map->size;
 	struct rc_map_table *newscan;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	if (rc_map->size == rc_map->len) {
 		/* All entries in use -> grow keytable */
 		if (newsize >= IR_TAB_MAX_ENTRIES)
@@ -317,6 +336,8 @@ static unsigned int ir_update_mapping(struct rc_dev *dev,
 	int old_keycode = rc_map->scan[index].keycode;
 	int i;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	/* Did the user wish to remove the mapping? */
 	if (new_keycode == KEY_RESERVED || new_keycode == KEY_UNKNOWN) {
 		dev_dbg(&dev->dev, "#%d: Deleting scan 0x%04llx\n",
@@ -372,6 +393,8 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 {
 	unsigned int i;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	/*
 	 * Unfortunately, some hardware-based IR decoders don't provide
 	 * all bits for the complete IR code. In general, they provide only
@@ -396,7 +419,7 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 	/* No previous mapping found, we might need to grow the table */
 	if (rc_map->size == rc_map->len) {
 		if (!resize || ir_resize_table(dev, rc_map, GFP_ATOMIC))
-			return -1U;
+			return UINT_MAX;
 	}
 
 	/* i is the proper index to insert our new keycode */
@@ -478,16 +501,18 @@ static int ir_setkeytable(struct rc_dev *dev, const struct rc_map *from)
 	if (rc)
 		return rc;
 
-	for (i = 0; i < from->size; i++) {
-		index = ir_establish_scancode(dev, rc_map,
-					      from->scan[i].scancode, false);
-		if (index >= rc_map->len) {
-			rc = -ENOMEM;
-			break;
-		}
+	scoped_guard(spinlock_irqsave, &rc_map->lock) {
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
@@ -523,6 +548,8 @@ static unsigned int ir_lookup_by_scancode(const struct rc_map *rc_map,
 {
 	struct rc_map_table *res;
 
+	lockdep_assert_held(&rc_map->lock);
+
 	res = bsearch(&scancode, rc_map->scan, rc_map->len,
 		      sizeof(struct rc_map_table), rc_map_cmp);
 	if (!res)
@@ -1989,7 +2016,8 @@ int rc_register_device(struct rc_dev *dev)
 	scoped_guard(mutex, &dev->lock)
 		dev->registered = false;
 out_free_table:
-	ir_free_table(&dev->rc_map);
+	if (dev->driver_type != RC_DRIVER_IR_RAW_TX)
+		ir_free_table(&dev->rc_map);
 out_raw:
 	ida_free(&rc_ida, minor);
 	return rc;
-- 
2.55.0

