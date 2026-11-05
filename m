Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844059;
	b=F4IVhNtKz2KNWXupUGyN0NtP6KqLSiS+DJ96Nhv8YLVR5/FpZ0fO4CZ4EguLW5KKrPnY
	 672mWHm4C/hBADFM4jxyapj8A0qltvACX51LumHIrN5NJWHsc86nhRiu0J7DzHUOIkZ3/
	 doyoxmFEsLCib3U76E/2T/TB3yDRakyXm05ixjrQvoGA2pYaHcyk/A4gx0mlktkN0Gmba
	 VzGhoEwVtmytzsC/nyi5yM6w1zqspG/9AAd49uvhL5Zmo6kEmy2mDHb/S5717Od/2KFfi
	 iW+BuCqDcDVoDezssVCxGS7sJhChV/C4+Lwe/BWMsFXFGu/rnDXyq4nkMfdh3I9VMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gz5+BocdYpnSvVOth2dHz4qKFUJVFS8aPsP2PRCOQ2A=;
	b=zuotTXo11jPIohL9m+hixuYB4v+ckShbXgVMS77c2ls3l9VpW/Ol3N3cHci3Zrrz+pAg
	 iw80P6AwpFTQfxZmThnyBq7WvKUfvbOAVzRCFMYdx3CXXsWkD/TzU4crpXDwr8wX0sLLy
	 b15LnvTgVuc9dmm7tGlkB1L1HxwWvu8KL/rHLe5vi6TfNCE3zU40Onp6YoVmyVSe/qGUK
	 sBMWI7D0UymCicSnd9jr5i6PeaNW2sLs3fozNU4gDH4ZyJCa/Ty+NuuEwb6p88SnQqSdJ
	 m8/KEpHlp4q16VeOWab8umDAFn8yhX+LUsxyN89pffcIAAoIDu1qg3B8d88Xg661img==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBes1gC5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC24606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBes1gC5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5220D1F000C1;
	Thu,  5 Nov 2026 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844058;
	bh=Gz5+BocdYpnSvVOth2dHz4qKFUJVFS8aPsP2PRCOQ2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBes1gC5TAvfeYJ+kExmniLYvPkUcoR6WYrRCkXL4pxzGeHZdefanLtmwruXrxgNb
	 kLNZOO+Qqy/JCaLMvoCs9whh4ml3F7tnImi1NNyoyEIv0dQ62XFIu6KIU/rYLQrV/S
	 5P2e9JQLwgB+521KBfj1gXjLaqXOvXvg/j6xKBj/6kIPE15qtyf0sPqIlYjjM6UoOr
	 4+4YVAuAK4H+lihpM3wrQVvVGOzmFhh0bsvKlwfmF49GW1FLA8UgCxV7qBy3v2gfXO
	 ffH8iGp6O5aDy7h9fMyiQW580KROB/YqFZ0gfzryR5k77YzWDGUMaqIwMXWT87V9QC
	 Kw9OlWuyUSuRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] media: rc: Replace open coded krealloc() for keymap
Date: Wed,  4 Nov 2026 21:00:55 -0500
Message-ID: <20261105020040.1096758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-pamperer-waltz-9ca3@gregkh>
References: <2026110424-pamperer-waltz-9ca3@gregkh>
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

From: Sean Young <sean@mess.org>

[ Upstream commit e4b4aa413cc2e48a261c8c513ced964a3390c0cf ]

Replace open coded krealloc() and remove superfluous member of struct
rc_map - we don't need to track both the size in bytes and entries.

Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: ab9567336171 ("media: rc: Add missing locking for keymap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-main.c | 45 +++++++++++++++++++-------------------
 include/media/rc-map.h     |  2 --
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 85c9be43b9127..81f3aafcae8f4 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -17,9 +17,8 @@
 #include <linux/module.h>
 #include "rc-core-priv.h"
 
-/* Sizes are in bytes, 256 bytes allows for 32 entries on x64 */
-#define IR_TAB_MIN_SIZE	256
-#define IR_TAB_MAX_SIZE	8192
+#define IR_TAB_MIN_ENTRIES	32
+#define IR_TAB_MAX_ENTRIES	1024
 
 static const struct {
 	const char *name;
@@ -214,21 +213,23 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
 static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
 			   const char *name, u64 rc_proto, size_t size)
 {
+	unsigned int alloc;
 	rc_map->name = kstrdup(name, GFP_KERNEL);
 	if (!rc_map->name)
 		return -ENOMEM;
+	alloc = roundup_pow_of_two(size);
 	rc_map->rc_proto = rc_proto;
-	rc_map->alloc = roundup_pow_of_two(size * sizeof(struct rc_map_table));
-	rc_map->size = rc_map->alloc / sizeof(struct rc_map_table);
-	rc_map->scan = kmalloc(rc_map->alloc, GFP_KERNEL);
+	rc_map->len = 0;
+	rc_map->size = alloc;
+	rc_map->scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
 	if (!rc_map->scan) {
 		kfree(rc_map->name);
 		rc_map->name = NULL;
 		return -ENOMEM;
 	}
 
-	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%u bytes)\n",
-		rc_map->size, rc_map->alloc);
+	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%zu bytes)\n",
+		alloc, alloc * sizeof(struct rc_map_table));
 	return 0;
 }
 
@@ -262,38 +263,36 @@ static void ir_free_table(struct rc_map *rc_map)
 static int ir_resize_table(struct rc_dev *dev, struct rc_map *rc_map,
 			   gfp_t gfp_flags)
 {
-	unsigned int oldalloc = rc_map->alloc;
-	unsigned int newalloc = oldalloc;
-	struct rc_map_table *oldscan = rc_map->scan;
+	unsigned int newsize = rc_map->size;
 	struct rc_map_table *newscan;
 
 	if (rc_map->size == rc_map->len) {
 		/* All entries in use -> grow keytable */
-		if (rc_map->alloc >= IR_TAB_MAX_SIZE)
+		if (newsize >= IR_TAB_MAX_ENTRIES)
 			return -ENOMEM;
 
-		newalloc *= 2;
-		dev_dbg(&dev->dev, "Growing table to %u bytes\n", newalloc);
+		newsize *= 2;
+
+		dev_dbg(&dev->dev, "Growing table to %u entries\n", newsize);
 	}
 
-	if ((rc_map->len * 3 < rc_map->size) && (oldalloc > IR_TAB_MIN_SIZE)) {
+	if (rc_map->len * 3 < rc_map->size && rc_map->size > IR_TAB_MIN_ENTRIES) {
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
 
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index d95ed3e96de28..f167c37179c8f 100644
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
2.53.0

