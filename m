Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802753;
	b=3z3Bu6fMYVP00+H26/j0ARQ4rVm0Ya/8hIcLiz2Lv3X8R5l/Xn3HcZpH35uL7J47oe+v
	 KexIv2TvQR0Xe4ywx91dvrgrIHgyt94HvD2G+H1elT4YIMI9as1WFXzbapFbKHV1uZi2Z
	 hmLCxVDGd2JchVU9H/9FYqr0fcinBve40W+6fnCdQBx55cT2EkEulJrGH5/6adGc+IQpE
	 bvDWFDQ1hM3rOCwZdsPKPl+ErJFFDmVQ8rYQtFB7/G5/VAUSjK6GOsssequbrluu1jsnt
	 FUeNIkjwIa4DrPPmY48RdBi/PXHMZcuBxwbKznj9oMHbqazUTrXY4oljmY0wl2vOmIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802753;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8Lfn8ctIYJiyRlZcsiw6Qy2gh4DMOHRj0Ezb8G97DWg=;
	b=SBUpvoAoQ8LuG1PxzHmDjpisQvN3xHJNNU3qKnLlHEWHJ0rn76trV2Fz5YmrrlrEv/Aa
	 LiMYF5/uSEHVHs1Rht43DBBcKgG8B+bRT3MRpNnckaE1ilvD5E7XXYdnZ63Z1JYTJ+ytW
	 VxuFqQOSBAoKj5gqCJCx6nP3ISb6vpgthguOx2PTMnq7hJ8N7Cyq0fSFSmtQO2KVwb0at
	 LmydAHFN7WmUfsDKMDgroXZo3sW+z51Gpg6B6vJrKfL1X0u40e2U9csZ7hV4bAIUp32yZ
	 egAlNalCJY3ExD8vSmg8nO6offrvo0tR3UY3YXm/OX5qTts6aY7lABsqRu/67IA5w0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=s1jKhZMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD648606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=s1jKhZMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC541F000C1;
	Wed,  4 Nov 2026 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802752;
	bh=8Lfn8ctIYJiyRlZcsiw6Qy2gh4DMOHRj0Ezb8G97DWg=;
	h=Subject:To:Cc:From:Date;
	b=s1jKhZMTa2G79wd/5AnCt4UF7z+v0LlqKO95mCE4Cz4hf/KuTNuQ/mCwadt2knmV8
	 F+W4/FNUvc2B5fgtABApMPF/uMvia2i0KKHg9nDzsN3wJbbZb6NR6NH6c+NO1ppLUU
	 pMuIUHYJKpqv1B2Y8/Q0SEM6TX7KBDszB9UZN8Q4=
Subject: FAILED: patch "[PATCH] media: rc: Add missing locking for keymap" failed to apply to 6.18-stable tree
To: sean@mess.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:32:24 +0100
Message-ID: <2026110424-plant-jarring-53b7@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ab9567336171e46ce9e03ee126902b3fd7901baa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110424-plant-jarring-53b7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab9567336171e46ce9e03ee126902b3fd7901baa Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Wed, 12 Aug 2026 14:03:10 +0100
Subject: [PATCH] media: rc: Add missing locking for keymap

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
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

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
@@ -1989,7 +2016,8 @@ out_rx_free:
 	scoped_guard(mutex, &dev->lock)
 		dev->registered = false;
 out_free_table:
-	ir_free_table(&dev->rc_map);
+	if (dev->driver_type != RC_DRIVER_IR_RAW_TX)
+		ir_free_table(&dev->rc_map);
 out_raw:
 	ida_free(&rc_ida, minor);
 	return rc;

