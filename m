Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841166;
	b=vaH91SKyMws1NSWNG+qK9a01SeNFnppNpQCX7kY+z7BKludtPtFLBWBmRlVLfxkQ0wvz
	 NIqguNLHKo97/tNaXBItC6/8Ne5x1FOS3t/0YPuHVzpQWKLU/2AT4Zqr5e9mwq3afE4p5
	 8rgZQPSZdUFQUA1VP22uSFrcve49oIpJvC6ylxJ19rGKopEwi9fKb8A6ocp69A/OjE7X2
	 3MpafUIrHupd8lTu4iygguYYtnaRTnYuwF9rT7AH65MzZafVWEPLHbhMreeMjXwyEjyTN
	 6LBsRBspxgBTRez6X2bF7Z9Jt0Og3PSGkLOe735Mf5T5uTfXlOYt0GLeEP0JJ0xSB8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xY6xx9AzDCW/geo4ye3mUqt+cF8oouoODCvhkTp5flE=;
	b=e2AP+2OMo2oSjl47uPk9q2mOPllYfvr9mBwK4WkjqtCaD+EJwsoSUIJfVxVxjxa/0alh
	 bkGXc/qHUfUaP/mZbrbIoQ5kwOJ5ln5/I1Kr5yoPlIrUpkOuRxcyGB8wWnqnoEIuQAbx0
	 wCcA3OoW+wrBbiRkuV933Af6WVBeCOBVkvFChSaBj8gra6e9XZK38fEBQErhCTjAV/3SK
	 9HL/Sd6TeaBDG0lhI7hSehfiJYCSCaeeHMO68wm7LmDOkShO1z9p2bPfMthGMZsE/qUMT
	 BrKAz+xiTxvJ38cqrptDwMJrUPOI0BEXBzpQFBEu2cllMlSusvbQWDOkReCtbGXHCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WzxCNmgn;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241E606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E241E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WzxCNmgn
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e977109392so9167275ad.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792841164; x=1793445964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY6xx9AzDCW/geo4ye3mUqt+cF8oouoODCvhkTp5flE=;
        b=WzxCNmgn3LZ1yXea7zEUF8Vfk51pT9SnUiaAiYmHNZPsiQo6QnUcBRyY/KSG4EPy9o
         cC71R4TSHOl+/P95thRSMHGw91N+Wr/aAbLdUDtfB0/ql4p7L59RKs1zQiNAKBxHdyTA
         rrCI3OhRnwiqXfX4gljuY+JJgrg8ITpLfwqV8Vlx6Vfj/sNm8plRq+7kUeKj+enqmODn
         47Ldhsfu7/5SYtR6OxLYeS72csNyKNG2nj0Cgd5EK/OXJg+5aL3suk7GNN/skr0ZzoVn
         SBUcKoKBD/rOsjheVGw5NwvQ2F3BCoGss4WyO/Ruvb4xc/PdaKp2k5GcAi47H1A0Lbyp
         /ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841164; x=1793445964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY6xx9AzDCW/geo4ye3mUqt+cF8oouoODCvhkTp5flE=;
        b=ohtpLt9TLxMBwUU0MqEIXvrV5od1pxwKhog8ZKBPnNKDgzY5J9oGFnwEJpOmWlCgVE
         1VyezsWEaqibgd/w/SGEN1SR+ijYZ92TMZjUApBSxHe+F3M4C8EU2+/MieXDnKJhO+EE
         4en3n3YC44MikLFnbZ4GCrG/OuUXoW/X+A8wNV4vJG5mnKIfK6T7HD7GwxFaimuoqBZL
         i1JlgDETsYEYrO8RMp45f89WZPFQFihgpcagF2IEyNB3xelYEM68hXavgdDCFBvOb8bd
         DRsDckZvZfVE/8XL9hQh9Enucr8u272qEdZTjw2gC2zcciSPeX5+uBcqa1RtwtRWRIuo
         QFbA==
X-Forwarded-Encrypted: i=1; AKwUvByaCBdyHfpauaF/akgtEd7ApgCm1jzExWn9+Eq9cvAJh3Y/fMmZTJtE0knmZ7NF7AK7b8pGseo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0k/a3SsrNSy8NGWdGINfNCBs+fJXNVWTw6ZoqyoEfp8o7O1Ry
	+ETmQ2T7vf5XvYp7qMdTgHQPYTGuqXsblz0MA1S2LDj24xeWZzOKJd/k3mFHsPlTunQ=
X-Gm-Gg: AYBFou0a8UhehYNZPq19PCqHCmUE9GbExJqB0/tAprqI8PV+A20JnbGbmsmfxzlhe/a
	JKgDr+eN51X4k58Bkf//5n8XnlxWpo/E3UmPsi651t8hmruVRoumWr31ksU4vUbb2VGyHjDOKOl
	BWYPuiijAdnDVU5qAO0JWDpAxxSJeRcg2IV0P835VZCBjXc8iiiucn0+P420aZOig+Mlt6zrXXj
	SN0wUp8svgaVNLEQAnZgXnogW7OOK3RcuETQJOeCbP7oZsQmGwPjEy2pF3+jB7JVUvajRVsdUl8
	YIOXnHp1C55O1fK7ok0MClmm09hWH8jRHC/qwoWmg6900PmIobdFS6u8l53itgfHWhl7m61zV+s
	ewifazXbFuammwZuqNXWOxM81nPkK82Zvt6qpgo6RsO6EmzcZLURggXspPLwSbFUCqWk2d4d1BS
	YucaUYGnR44IvFMuvhHVVY6V4sevSuxkslBfuqT+bNAUh2cMWxTbVXoYyXh4oommMxuxXR9zhvQ
	tSK36VkckIYUO1jFGoPs3W12WUeOztzCD4RDXI5Ey6t89xfvBeSqEil9aJqN90kA2VRIVvKkSP0
X-Received: by 2002:a17:902:dac8:b0:2ea:4c42:573c with SMTP id d9443c01a7336-2ea9c875775mr14472985ad.51.1792841164138;
        Sat, 24 Oct 2026 04:26:04 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b11fc1fsm4944875ad.26.2026.10.24.04.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:26:03 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5] dax/bus: Fix Device DAX range alignment validation
Date: Sat, 24 Oct 2026 19:25:55 +0800
Message-ID: <20261024112555.2476001-1-songmuchun@bytedance.com>
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

Only range sizes are currently validated against dev_dax->align. A
dynamic device can therefore select a large-page alignment and allocate a
range whose start is not naturally aligned.

Sashiko found that memmap_init_zone_device() could then initialize the
struct pages with a large-page order for a physical range that is not
naturally aligned. A subsequent write to a userspace mapping then
triggered a kernel panic in testing.

The automatic resize path can also split a size-aligned request across
arbitrary free gaps. When devices with different alignments fragment a
region, this can extend a range by less than the device alignment. A later
allocation then fails, leaving the failed resize partially applied.

Initialize the device alignment before its first allocation. Validate both
the start and size of allocated and adjusted ranges. Use the same
aligned-gap iterator for free-space accounting and range allocation so the
pre-check and allocation path cannot diverge. Skip unusable gaps and
serialize size validation with alignment updates.

Static Device DAX already has a pre-populated pgmap whose full range was
validated against memremap_compat_align(). Its usable data range may begin
after namespace metadata, so require only dev_dax->align for static
devices. Dynamic Device DAX builds its pgmap from the allocated ranges and
must continue to satisfy both alignments.

Fixes: 6d82120f4156 ("device-dax: add an 'align' attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v5:
- Describe the reproduced memmap_init_zone_device() failure in the commit
  message (suggested by Alison Schofield)
- Share aligned gap traversal between the pre-check and allocation paths
  (suggested by Alison Schofield)
- Clean up the alignment helpers and document their contracts (suggested
  by Alison Schofield)

v4:
- Use dev_dax->align alone for static Device DAX ranges to preserve
  older 4K namespaces (reported by Alison Schofield)
- Condense the commit message to the failure scenarios and required fixes
  (suggested by Alison Schofield)

v3:
- Serialize size alignment validation with alignment updates to avoid a
  partial shrink after a concurrent alignment change (reported by Sashiko)
- Document the size validation serialization in the commit message

v2:
- Keep the alloc_is_aligned() name to avoid unrelated helper renaming
  (suggested by Dave Jiang)
- Move this patch after the mapping error reporting fix for independent
  backports (suggested by Dave Jiang)
---
 drivers/dax/bus.c | 208 +++++++++++++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 68 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264af..83add0037b3d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -848,6 +848,95 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
+static unsigned long dev_dax_min_align(struct dev_dax *dev_dax)
+{
+	/*
+	 * A static device has a pre-populated pgmap whose range already
+	 * satisfies memremap_compat_align(). Its data range may start after
+	 * metadata at dev_dax->align granularity.
+	 */
+	if (static_dev_dax(dev_dax))
+		return dev_dax->align;
+
+	/*
+	 * The minimum mapping granularity for a dynamic device instance is a
+	 * single subsection, unless the arch says otherwise.
+	 */
+	return max_t(unsigned long, dev_dax->align, memremap_compat_align());
+}
+
+static bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
+{
+	return IS_ALIGNED(size, dev_dax_min_align(dev_dax));
+}
+
+static bool range_is_aligned(struct dev_dax *dev_dax, u64 start,
+			     resource_size_t size)
+{
+	return IS_ALIGNED(start | size, dev_dax_min_align(dev_dax));
+}
+
+/* Return usable aligned gap size and update *aligned_start. */
+static resource_size_t aligned_gap_size(struct dev_dax *dev_dax,
+		resource_size_t *aligned_start, resource_size_t end)
+{
+	unsigned long min_align = dev_dax_min_align(dev_dax);
+	resource_size_t start = ALIGN(*aligned_start, min_align);
+
+	if (start < *aligned_start || start > end)
+		return 0;
+
+	*aligned_start = start;
+	return ALIGN_DOWN(end - start + 1, min_align);
+}
+
+struct dax_region_gap {
+	struct resource *prev;
+	resource_size_t start;
+	resource_size_t size;
+};
+
+/*
+ * Find the next usable aligned gap. Return the cursor for the next iteration
+ * with @gap describing the gap, or NULL when no gap remains. Pass NULL as
+ * @cursor to start the iteration.
+ */
+static struct resource *dax_region_next_gap(struct dev_dax *dev_dax,
+		struct resource *cursor, struct dax_region_gap *gap)
+{
+	struct resource *region_res = &dev_dax->region->res;
+
+	while (cursor != region_res) {
+		struct resource *res = cursor;
+		struct resource *next = res ? res->sibling : region_res->child;
+		resource_size_t end;
+
+		/* Use the region resource as the end-of-iteration sentinel. */
+		cursor = next ? : region_res;
+
+		if (res && res->end >= region_res->end)
+			return NULL;
+
+		gap->start = res ? res->end + 1 : region_res->start;
+		if (next) {
+			if (next->start <= gap->start)
+				continue;
+			end = next->start - 1;
+		} else {
+			end = region_res->end;
+		}
+
+		gap->size = aligned_gap_size(dev_dax, &gap->start, end);
+		if (!gap->size)
+			continue;
+
+		gap->prev = res;
+		return cursor;
+	}
+
+	return NULL;
+}
+
 static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
@@ -870,6 +959,9 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
+	if (!range_is_aligned(dev_dax, start, size))
+		return -EINVAL;
+
 	alloc = __request_region(res, start, size, dev_name(dev), 0);
 	if (!alloc)
 		return -ENOMEM;
@@ -923,6 +1015,9 @@ static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, r
 	if (dev_WARN_ONCE(dev, !size, "deletion is handled by dev_dax_shrink\n"))
 		return -EINVAL;
 
+	if (!range_is_aligned(dev_dax, range->start, size))
+		return -EINVAL;
+
 	rc = adjust_resource(res, range->start, size);
 	if (rc)
 		return rc;
@@ -955,15 +1050,6 @@ static ssize_t size_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", size);
 }
 
-static bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
-{
-	/*
-	 * The minimum mapping granularity for a device instance is a
-	 * single subsection, unless the arch says otherwise.
-	 */
-	return IS_ALIGNED(size, max_t(unsigned long, dev_dax->align, memremap_compat_align()));
-}
-
 static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 {
 	resource_size_t to_shrink = dev_dax_size(dev_dax) - size;
@@ -1030,77 +1116,63 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 	return true;
 }
 
-static ssize_t dev_dax_resize(struct dax_region *dax_region,
-		struct dev_dax *dev_dax, resource_size_t size)
+static resource_size_t dax_region_aligned_avail_size(struct dev_dax *dev_dax)
+{
+	struct resource *cursor = NULL;
+	struct dax_region_gap gap;
+	resource_size_t avail = 0;
+
+	lockdep_assert_held_write(&dax_region_rwsem);
+
+	while ((cursor = dax_region_next_gap(dev_dax, cursor, &gap)))
+		avail += gap.size;
+
+	return avail;
+}
+
+static ssize_t dev_dax_resize(struct dev_dax *dev_dax, resource_size_t size)
 {
-	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
 	resource_size_t dev_size = dev_dax_size(dev_dax);
-	struct resource *region_res = &dax_region->res;
+	struct resource *cursor = NULL;
+	struct dax_region_gap gap;
 	struct device *dev = &dev_dax->dev;
-	struct resource *res, *first;
-	resource_size_t alloc = 0;
-	int rc;
+	resource_size_t to_alloc = size - dev_size;
 
 	if (dev->driver)
 		return -EBUSY;
 	if (size == dev_size)
 		return 0;
-	if (size > dev_size && size - dev_size > avail)
-		return -ENOSPC;
 	if (size < dev_size)
 		return dev_dax_shrink(dev_dax, size);
 
-	to_alloc = size - dev_size;
 	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
 			"resize of %pa misaligned\n", &to_alloc))
 		return -ENXIO;
 
+	if (to_alloc > dax_region_aligned_avail_size(dev_dax))
+		return -ENOSPC;
+
 	/*
 	 * Expand the device into the unused portion of the region. This
 	 * may involve adjusting the end of an existing resource, or
 	 * allocating a new resource.
 	 */
-retry:
-	first = region_res->child;
-	if (!first)
-		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
-
-	rc = -ENOSPC;
-	for (res = first; res; res = res->sibling) {
-		struct resource *next = res->sibling;
-
-		/* space at the beginning of the region */
-		if (res == first && res->start > dax_region->res.start) {
-			alloc = min(res->start - dax_region->res.start, to_alloc);
-			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
-			break;
-		}
-
-		alloc = 0;
-		/* space between allocations */
-		if (next && next->start > res->end + 1)
-			alloc = min(next->start - (res->end + 1), to_alloc);
-
-		/* space at the end of the region */
-		if (!alloc && !next && res->end < region_res->end)
-			alloc = min(region_res->end - res->end, to_alloc);
-
-		if (!alloc)
-			continue;
-
-		if (adjust_ok(dev_dax, res)) {
-			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
-			break;
-		}
-		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
-		break;
+	while (to_alloc && (cursor = dax_region_next_gap(dev_dax, cursor, &gap))) {
+		resource_size_t alloc = min(gap.size, to_alloc);
+		int ret;
+
+		if (gap.prev && gap.start == gap.prev->end + 1 &&
+		    adjust_ok(dev_dax, gap.prev))
+			ret = adjust_dev_dax_range(dev_dax, gap.prev,
+					resource_size(gap.prev) + alloc);
+		else
+			ret = alloc_dev_dax_range(dev_dax, gap.start, alloc);
+		if (ret)
+			return ret;
+		to_alloc -= alloc;
 	}
-	if (rc)
-		return rc;
-	to_alloc -= alloc;
-	if (to_alloc)
-		goto retry;
-	return 0;
+
+	return to_alloc ? -ENOSPC : 0;
 }
 
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
@@ -1115,11 +1187,6 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	if (!alloc_is_aligned(dev_dax, val)) {
-		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
-		return -EINVAL;
-	}
-
 	rc = down_write_killable(&dax_region_rwsem);
 	if (rc)
 		return rc;
@@ -1130,8 +1197,13 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	rc = down_write_killable(&dax_dev_rwsem);
 	if (rc)
 		goto err_dev;
+	if (!alloc_is_aligned(dev_dax, val)) {
+		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
+		rc = -EINVAL;
+		goto err_dev;
+	}
 
-	rc = dev_dax_resize(dax_region, dev_dax, val);
+	rc = dev_dax_resize(dev_dax, val);
 
 err_dev:
 	up_write(&dax_dev_rwsem);
@@ -1224,9 +1296,9 @@ static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
 	int i;
 
 	for (i = 0; i < dev_dax->nr_range; i++) {
-		size_t len = range_len(&dev_dax->ranges[i].range);
+		struct range *range = &dev_dax->ranges[i].range;
 
-		if (!alloc_is_aligned(dev_dax, len)) {
+		if (!range_is_aligned(dev_dax, range->start, range_len(range))) {
 			dev_dbg(dev, "%s: align %u invalid for range %d\n",
 				__func__, dev_dax->align, i);
 			return -EINVAL;
@@ -1464,6 +1536,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 		return ERR_PTR(-ENOMEM);
 
 	dev_dax->region = dax_region;
+	dev_dax->align = dax_region->align;
 	if (is_static(dax_region)) {
 		if (dev_WARN_ONCE(parent, data->id < 0,
 				"dynamic id specified to static region\n")) {
@@ -1522,7 +1595,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
-	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.54.0

