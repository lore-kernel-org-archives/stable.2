Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954254DAF4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873715; cv=none; b=KxsMad1QJ3maZECeoZ3yPq7zMQtjxJOvoFqCPojkPrzHid10bw2GDNlHUMU80zPJkOi4e8dl/Md6WM1U2FTgwJvlDJEXKtCQ/oI8OwZoaUPb0YLvlG7AITnKrD6KtVeTq+thBtJetWmW6dJd0KHdV4Ch2zaj+yvVBGVtsGu02qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873715; c=relaxed/simple;
	bh=pgYO5F07vAjyjZZxywRAUgLDuqJN/Edeh3d2JntgReo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI2oBvl9Hh/gqc0Jb0DbvhsXVAj/PHTxT8KpyH6+D74KwPSPBrlBbp5ZBgLCTvngfqC8284qpY0OTxCLL9DVsYtPOHjxVdbjEmt52vnZljOTVBr6FSg3LjvLOcUrOGuvqHO/Qa8rLM57qsRsG9ocGKa6wEIsCmGW4u3NKt9j8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFloy1DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFloy1DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03AA1F00ACF;
	Tue,  8 Sep 2026 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873713;
	bh=/wZDj9uebFbdMyVKBKkMzueDFreuZbiUheBuOChPTHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFloy1DW50JLluJ8zs4bmQ2B9eSM/l7SoWDW7Kzb72TMQ8zt/8agvw001COJqq7ZX
	 4NL1umaGhJHhD8D3fbq5lLuKK4Y1oPkgOsLXKLDw2/MwsI/P1EjLY6OowKq/hW3brN
	 WIfqCL60RBaGJVAAF8rAAlfaDrWJeFuqcYcvBuL35ayaztH3Al3xoqpflc7+3MRKk/
	 cUrad1upCUonspmKuc9uXTRC78TE3CsJ0CUPV2l5LBnBiwqidUk61oT70+VJMHKSwZ
	 iYo32JAq7JibwPxgBSob0kW20mU2FXzXlcOZiIDhwlroD4eUjFxumGR7pCsnI0FkoY
	 N5IqI0CCZ07OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm array: validate array block headers on read
Date: Tue,  8 Sep 2026 09:21:50 -0400
Message-ID: <20260908132150.2288286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-header-ideally-ce6b@gregkh>
References: <2026090304-header-ideally-ce6b@gregkh>
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
index 1f1dd077d3f84..18f6bc0bbafa5 100644
--- a/drivers/md/persistent-data/dm-array.c
+++ b/drivers/md/persistent-data/dm-array.c
@@ -37,6 +37,14 @@ struct array_block {
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
@@ -54,6 +62,7 @@ static int array_block_check(struct dm_block_validator *v,
 			     size_t size_of_block)
 {
 	struct array_block *bh_le = dm_block_data(b);
+	uint32_t nr_entries, max_entries, value_size;
 	__le32 csum_disk;
 
 	if (dm_block_location(b) != le64_to_cpu(bh_le->blocknr)) {
@@ -73,6 +82,26 @@ static int array_block_check(struct dm_block_validator *v,
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
 
@@ -136,14 +165,6 @@ static void dec_ablock_entries(struct dm_array_info *info, struct array_block *a
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

