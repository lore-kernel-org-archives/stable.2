Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC74544894
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872351; cv=none; b=sMtu9qcwab/G2rX44thR7nUMIHX62yylzyOUJvPhwD5NiBti5aJj2PP9MO22u/oK4x2OHzHy60O9E952spcr10S4YGIvoZR5VkCsz/c5o94K/1OPyiQkwD8ISz2fNaWHnt/RWaG/+VWr5KBfcvx07J7f6BJ0aumwYbezPmdS4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872351; c=relaxed/simple;
	bh=+IXRPg1w0sEum97fott1YcLJHZDABqPLNwNwetNu8HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzvrOv42NiKom/dxS8y/akcOIADOh+34HPKqfIiXK4Yx9rUwitJbBnKGz+k1uFAKk7T/2KD5eBgX39m+RwoMc5e2tv7KqLGQru90ZRqJC/AC34+nXW2rCUh2ZLPQZWrbJB8caZTpzaUVevvePY7G7haWYquRg9jHb+ICujSEZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D519+CYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D519+CYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A011F00A3D;
	Tue,  8 Sep 2026 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872346;
	bh=yBWxfQ4q1Vg16sSsyL5QbktmQE1dQlLR8d/7G6oUk/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D519+CYX8Fop7acVBxB/MSb16wHl3XOw0RQdClMgon9dDu7An/Kgu/8vT9v71ZVRb
	 UVrB33+jUaFPwKt3cs5P1YAqY3Q/n/niwcEMAgifqUza0twj2ISOKlu7HsSOJL5By7
	 17GVBDG5CvMggvSZWi7QQRFxUe5Upnle61m8Wk1GuVG54wNsS/LcdmSGiE82KVkH91
	 frpu11nvqLe317OV6zD2QuWw0H8d6JpLsRo+lY6veTQjb79MRyiQMcJVVZpOv8kQIN
	 YXFddAn9R3S07i3YE2vIOCcmwsNnupIBHkxfVh3GPIKZntbt9717aieSz1JvKFaDlm
	 EGN0kPnIn4l3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm array: validate array block headers on read
Date: Tue,  8 Sep 2026 08:59:03 -0400
Message-ID: <20260908125903.2182068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-flyover-viscous-2098@gregkh>
References: <2026090303-flyover-viscous-2098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 2965787723084835b18dfe993cd450ebf5bd4540 ]

array_block_check() validates blocknr and csum and nothing else, while
node_check(), next to it, has bounded the structural fields since both
were written. dm_array_cursor_next() takes its loop bound from the
on-disk nr_entries and element_at() is unguarded pointer arithmetic, so
a count larger than the block holds keeps the cursor in one block while
the index grows past it and the read walks off the dm-bufio buffer --
dm_cache_load_mappings() drives it once per cache block at activation.

Check the header against itself: reject a zero value_size, require
max_entries to equal calc_max_entries() for that value_size and block
size, and require nr_entries to fit. Equality rather than an upper bound,
since a count below the real capacity trips BUG_ON() in fill_ablock() and
trim_ablock(). Metadata dm-array writes satisfies all three.

Fixes: 6513c29f44f2 ("dm persistent data: add transactional array")
Suggested-by: Ming-Hung Tsai <mtsai@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Ming-Hung Tsai <mtsai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ retained Linux 6.6’s non-const validator callback signature due to the missing constification commit. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/persistent-data/dm-array.c | 37 +++++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/md/persistent-data/dm-array.c b/drivers/md/persistent-data/dm-array.c
index b1fdfe53e9377..9663abdb91404 100644
--- a/drivers/md/persistent-data/dm-array.c
+++ b/drivers/md/persistent-data/dm-array.c
@@ -38,6 +38,14 @@ struct array_block {
  */
 #define CSUM_XOR 595846735
 
+/*
+ * Each array block can hold this many values.
+ */
+static uint32_t calc_max_entries(size_t value_size, size_t size_of_block)
+{
+	return (size_of_block - sizeof(struct array_block)) / value_size;
+}
+
 static void array_block_prepare_for_write(struct dm_block_validator *v,
 					  struct dm_block *b,
 					  size_t size_of_block)
@@ -55,6 +63,7 @@ static int array_block_check(struct dm_block_validator *v,
 			     size_t size_of_block)
 {
 	struct array_block *bh_le = dm_block_data(b);
+	uint32_t nr_entries, max_entries, value_size;
 	__le32 csum_disk;
 
 	if (dm_block_location(b) != le64_to_cpu(bh_le->blocknr)) {
@@ -74,6 +83,26 @@ static int array_block_check(struct dm_block_validator *v,
 		return -EILSEQ;
 	}
 
+	nr_entries = le32_to_cpu(bh_le->nr_entries);
+	max_entries = le32_to_cpu(bh_le->max_entries);
+	value_size = le32_to_cpu(bh_le->value_size);
+
+	if (!value_size) {
+		DMERR_LIMIT("%s failed: value_size is zero", __func__);
+		return -EILSEQ;
+	}
+
+	if (max_entries != calc_max_entries(value_size, size_of_block)) {
+		DMERR_LIMIT("%s failed: max_entries %u invalid for value_size %u",
+			    __func__, max_entries, value_size);
+		return -EILSEQ;
+	}
+
+	if (nr_entries > max_entries) {
+		DMERR_LIMIT("%s failed: too many entries", __func__);
+		return -EILSEQ;
+	}
+
 	return 0;
 }
 
@@ -138,14 +167,6 @@ static void dec_ablock_entries(struct dm_array_info *info, struct array_block *a
 		on_entries(info, ab, vt->dec);
 }
 
-/*
- * Each array block can hold this many values.
- */
-static uint32_t calc_max_entries(size_t value_size, size_t size_of_block)
-{
-	return (size_of_block - sizeof(struct array_block)) / value_size;
-}
-
 /*
  * Allocate a new array block.  The caller will need to unlock block.
  */
-- 
2.53.0

