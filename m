Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5E50E580
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902359; cv=none; b=HWBlEpJxgKPRXvVkRALaIzyvmnKiZYa8LiKBVjaPk1oIfpbxJFgy31K6T4aQISFSx/c5tMs33NyBZem7wY2qUVSqjmhhYaYFPLwVTyRNVcgbJ2GMH9ptAfE0GT0UbwTnjrQDEzzx3LsYcFOQGShZIpEKfCueDijYyB6xEgUFkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902359; c=relaxed/simple;
	bh=QCDJqDHuW8qATLmfJfOxejt1KAYjkH/HrUwHy8v4foc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6bL7WG4ma1awnO9OnDib+XmX+Q1nzLyDxON+iLv3SDHm+nGQW/wbXYZkYEKOwqikij3MKZf4ZvrHUpqisFZP50apEl5aJ7ovdKbpzrqRQknW7m2gHMAJMrTFdXSD8VQl7T962KAzekwqIpAG0KQzyCgTQqUwKMAHEFEf1CLtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4KF2oF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4KF2oF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B81F000FF;
	Tue, 13 Oct 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902357;
	bh=pAFLsoDeDdHBvW56ODvbvYNp6B9VK44kgXQpZZquvCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4KF2oF7tMrLZJxVBRNj1PeQZ6D2UkH0VA+FGMQ03gF6/+C6V3p4n+VHR2puA6Gnj
	 vcOaOfWi6A/ByqwnfyGAQCiGEMOkLUyU7OgqhgawtKkff8q0B8YcaTU7jguNbU/f8Z
	 V9hJ4126Lv12mHCx5UgTgv0fCqUIeExZG6Vq9GP6T3RXXLP3UFRZrxbqsWEqy49pXT
	 CSlAqQiq70pw2phv1qbRNg8hqrGWMew6MPhwJITVYZtAN4g6NCwK1q5HV15MRsdeiJ
	 iro7KL51IUf11DM0QkeA7TJ6NvnYvvZhuIyF2k6/9mU8c+bCVN5mz1XSTXFNCaLAgC
	 k8CL/Y1JyCq7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] dm-integrity: use internal variable for digestsize
Date: Tue, 13 Oct 2026 10:39:14 -0400
Message-ID: <20261013143848.4044801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101250-why-icon-9fa2@gregkh>
References: <2026101250-why-icon-9fa2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit e4cc9deca3da48986072327ae2eeb18e6fd0165d ]

Instead of calling digestsize() each time the digestsize for
the internal hash is needed, store the digestsize in a new
field internal_hash_digestsize within struct dm_integrity_c
once and use this value when needed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Stable-dep-of: 764b683a6180 ("dm-integrity: fix buffer overflow in inline mode with large tag size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 0a7be46701a9c..76d0c84380a8c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -223,6 +223,7 @@ struct dm_integrity_c {
 	int failed;
 
 	struct crypto_shash *internal_hash;
+	unsigned int internal_hash_digestsize;
 
 	struct dm_target *ti;
 
@@ -1672,7 +1673,7 @@ static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector
 		goto failed;
 	}
 
-	digest_size = crypto_shash_digestsize(ic->internal_hash);
+	digest_size = ic->internal_hash_digestsize;
 	if (unlikely(digest_size < ic->tag_size))
 		memset(result + digest_size, 0, ic->tag_size - digest_size);
 
@@ -1772,7 +1773,7 @@ static void integrity_metadata(struct work_struct *w)
 	if (ic->internal_hash) {
 		struct bvec_iter iter;
 		struct bio_vec bv;
-		unsigned int digest_size = crypto_shash_digestsize(ic->internal_hash);
+		unsigned int digest_size = ic->internal_hash_digestsize;
 		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		char *checksums;
 		unsigned int extra_space = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
@@ -2120,7 +2121,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				} while (++s < ic->sectors_per_block);
 
 				if (ic->internal_hash) {
-					unsigned int digest_size = crypto_shash_digestsize(ic->internal_hash);
+					unsigned int digest_size = ic->internal_hash_digestsize;
 
 					if (unlikely(digest_size > ic->tag_size)) {
 						char checksums_onstack[HASH_MAX_DIGESTSIZE];
@@ -2427,7 +2428,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	if (!dio->integrity_payload) {
 		unsigned digest_size, extra_size;
 		dio->payload_len = ic->tuple_size * (bio_sectors(bio) >> ic->sb->log2_sectors_per_block);
-		digest_size = crypto_shash_digestsize(ic->internal_hash);
+		digest_size = ic->internal_hash_digestsize;
 		extra_size = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
 		dio->payload_len += extra_size;
 		dio->integrity_payload = kmalloc(dio->payload_len, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
@@ -2590,7 +2591,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bio_put(outgoing_bio);
 
 		integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, outgoing_data, digest);
-		if (unlikely(crypto_memneq(digest, dio->integrity_payload, min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
+		if (unlikely(crypto_memneq(digest, dio->integrity_payload, min(ic->internal_hash_digestsize, ic->tag_size)))) {
 			DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
 				ic->dev->bdev, dio->bio_details.bi_iter.bi_sector);
 			atomic64_inc(&ic->number_of_mismatches);
@@ -2630,7 +2631,7 @@ static int dm_integrity_end_io(struct dm_target *ti, struct bio *bio, blk_status
 				//memset(mem, 0xff, ic->sectors_per_block << SECTOR_SHIFT);
 				integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem, digest);
 				if (unlikely(crypto_memneq(digest, dio->integrity_payload + pos,
-						min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
+						min(ic->internal_hash_digestsize, ic->tag_size)))) {
 					kunmap_local(mem);
 					dm_integrity_free_payload(dio);
 					INIT_WORK(&dio->work, dm_integrity_inline_recheck);
@@ -3012,8 +3013,8 @@ static void integrity_recalc(struct work_struct *w)
 		goto free_ret;
 	}
 	recalc_tags_size = (recalc_sectors >> ic->sb->log2_sectors_per_block) * ic->tag_size;
-	if (crypto_shash_digestsize(ic->internal_hash) > ic->tag_size)
-		recalc_tags_size += crypto_shash_digestsize(ic->internal_hash) - ic->tag_size;
+	if (ic->internal_hash_digestsize > ic->tag_size)
+		recalc_tags_size += ic->internal_hash_digestsize - ic->tag_size;
 	recalc_tags = kvmalloc(recalc_tags_size, GFP_NOIO);
 	if (!recalc_tags) {
 		vfree(recalc_buffer);
@@ -3172,8 +3173,8 @@ static void integrity_recalc_inline(struct work_struct *w)
 	}
 
 	recalc_tags_size = (recalc_sectors >> ic->sb->log2_sectors_per_block) * ic->tuple_size;
-	if (crypto_shash_digestsize(ic->internal_hash) > ic->tuple_size)
-		recalc_tags_size += crypto_shash_digestsize(ic->internal_hash) - ic->tuple_size;
+	if (ic->internal_hash_digestsize > ic->tuple_size)
+		recalc_tags_size += ic->internal_hash_digestsize - ic->tuple_size;
 	recalc_tags = kmalloc(recalc_tags_size, GFP_NOIO | __GFP_NOWARN);
 	if (!recalc_tags) {
 		kfree(recalc_buffer);
@@ -4703,6 +4704,8 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		    "Invalid internal hash", "Error setting internal hash key");
 	if (r)
 		goto bad;
+	if (ic->internal_hash)
+		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_hash);
 
 	r = get_mac(&ic->journal_mac, &ic->journal_mac_alg, &ti->error,
 		    "Invalid journal mac", "Error setting journal mac key");
@@ -4715,7 +4718,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 			r = -EINVAL;
 			goto bad;
 		}
-		ic->tag_size = crypto_shash_digestsize(ic->internal_hash);
+		ic->tag_size = ic->internal_hash_digestsize;
 	}
 	if (ic->tag_size > MAX_TAG_SIZE) {
 		ti->error = "Too big tag size";
-- 
2.53.0

