Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D350E5B3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902359; cv=none; b=pdxXUh9z5tsAAViWYrYSCQd1tpfcKKGMZG88KE1Q+PdFAWFME6T7xKDVT5ih04snwg/Z1Q01bKtr2NRx+CTNQjte0JufFxcvd5bidRwuLxNvI51XBtg+lZb32r72YrwSU7U8w446qVNj0dAUVZ7ahMjpX68o3jM8PD4QQrCgeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902359; c=relaxed/simple;
	bh=oe8Drzfjj85au7eivPRTwtw4/c5OnvTMlyT2vHkmkwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOZuQYve1PC3WqasaUBAEFNWOzJHFHjneBR3YPDDCmewWuhxMFdA52LVc+mW+FXiqLgaZCDQjr/8rdYdEVWhpkAVmpnsSA10OlxMGD91QJanbG/kHBUL+CfUo4UDB3xQpbCWn1UJWP5nRiXovJry1HD1maHV8pl4cenlacNVpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ8x4YpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ8x4YpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AEB1F00898;
	Tue, 13 Oct 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902358;
	bh=o9Th+wdjx1Qztp/lr1YdIHJ41XfeQTqD7oEXCTRwAe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJ8x4YpW2DBFNmk5OoXTWbf4gMF+l4SoQ3nLDeTboWKvw4MPL5bQ0WFl21ift2Dwj
	 28iSrt1Oxv/opiNcx+nP6MUyRr++TLb5e9nvJa3FPQ6tLCZHFeZMBWf4Trq0SZwu7U
	 unL4n/jVnMehgtb6Tx1T3IeONIwQZ1fuDWmkMEMTdySN5X+m7Tfw8IrdrHGMNjua7X
	 6scNQvVtYTRvYfN9UF+ZAjItOefmsB84rGKL48s0YJj+84IEU4WiZciQBQDcxszg5L
	 35U+I2vzJu5ZabbX5YEL3COR6JMj8CnOXUbmAK8Bpy/nr7VEAMp7d6XhH9zb/0Rmzm
	 DZrcP4DpRjULw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] dm-integrity: rename internal_hash
Date: Tue, 13 Oct 2026 10:39:15 -0400
Message-ID: <20261013143848.4044801-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143848.4044801-1-sashal@kernel.org>
References: <2026101250-why-icon-9fa2@gregkh>
 <20261013143848.4044801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit e8a052ee1fb570b8e07f05f65752646eaac74355 ]

Rename "internal_hash" to "internal_shash" and introduce a boolean value
"internal_hash".

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Stable-dep-of: 764b683a6180 ("dm-integrity: fix buffer overflow in inline mode with large tag size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 76d0c84380a8c..bdc83a5f583b9 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -219,10 +219,11 @@ struct dm_integrity_c {
 	__u8 log2_blocks_per_bitmap_bit;
 
 	unsigned char mode;
+	bool internal_hash;
 
 	int failed;
 
-	struct crypto_shash *internal_hash;
+	struct crypto_shash *internal_shash;
 	unsigned int internal_hash_digestsize;
 
 	struct dm_target *ti;
@@ -1635,11 +1636,11 @@ static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector
 				      const char *data, char *result)
 {
 	__le64 sector_le = cpu_to_le64(sector);
-	SHASH_DESC_ON_STACK(req, ic->internal_hash);
+	SHASH_DESC_ON_STACK(req, ic->internal_shash);
 	int r;
 	unsigned int digest_size;
 
-	req->tfm = ic->internal_hash;
+	req->tfm = ic->internal_shash;
 
 	r = crypto_shash_init(req);
 	if (unlikely(r < 0)) {
@@ -4700,12 +4701,14 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		buffer_sectors = 1;
 	ic->log2_buffer_sectors = min((int)__fls(buffer_sectors), 31 - SECTOR_SHIFT);
 
-	r = get_mac(&ic->internal_hash, &ic->internal_hash_alg, &ti->error,
+	r = get_mac(&ic->internal_shash, &ic->internal_hash_alg, &ti->error,
 		    "Invalid internal hash", "Error setting internal hash key");
 	if (r)
 		goto bad;
-	if (ic->internal_hash)
-		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_hash);
+	if (ic->internal_shash) {
+		ic->internal_hash = true;
+		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_shash);
+	}
 
 	r = get_mac(&ic->journal_mac, &ic->journal_mac_alg, &ti->error,
 		    "Invalid journal mac", "Error setting journal mac key");
@@ -5239,8 +5242,8 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
 
-	if (ic->internal_hash)
-		crypto_free_shash(ic->internal_hash);
+	if (ic->internal_shash)
+		crypto_free_shash(ic->internal_shash);
 	free_alg(&ic->internal_hash_alg);
 
 	if (ic->journal_crypt)
-- 
2.53.0

