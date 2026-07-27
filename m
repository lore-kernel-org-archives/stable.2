Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8823CB56C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181856; cv=none; b=aOadSFmCvNhblEcfI6gjM3W8CWhD6I9lTv0U6sQaMGs5/QYZfVEarRIhMAGSIoBwZU2PcS/CqBRafVEVeI20cUEk8x2c8pw5diMocPcUI6VP6fSae4lw+MEdfJhVE9R/Pgm0Mtd4AsB2uq5gM0mEGBCRKrN4/nvetveXqk/TYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181856; c=relaxed/simple;
	bh=gRf3Ee/BTryAma9f/Fi9VuXlzfibOc7rYX+5McAwmWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhnXn5kH2GgXFDyjuqSPcZQIixlQrFc5+a2woCLUdiB31oxDEca532FqKJ7O7LybIk/Zk2vv2Bdm+xXsxRXpxRr0pGi4zPr7S06ASLJUYentzGZNW+ZcatZEI2bOEh/bYV3f4TXPXGOoE2vaOyQLwBUDPQvhFsrzbbqHSySl8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzA4ZnsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzA4ZnsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBB1F000E9;
	Mon, 27 Jul 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181854;
	bh=g6A4aBqUpfioOav2/mrPzSdhGx89zauff6q08WEcTao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzA4ZnsVUYnLweASRczuwsWMrZw0FBXYOpOn7AN5PD/ZvNAQ7MPXwbK1Rvss8Xef1
	 JUBHLStQhGV2GIeupHKXTuvTEECRfmbErug6xoTeu0bVJu1UKOYVWXHP1AMqc8uNEn
	 Av+3qRiKaFQV+cfsIXQ5yfNrE1YPrv/vIf7S2+mDiu4f8/FZHatwPijkotoQwBoJS+
	 130HB+fkOKvf67JotfCEw6ORrN/7iounvUNUyXBJQJ/WOwrFSoxYCDX5BVbTHySqRE
	 aoJTa2fpk9qM0uA080NhUhfSDKkhzbLhluD4ipvUu/hmsARxV3r/JGsP6H+opuKC6u
	 mAYohTaYxA4cA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] dm: fix trailing statements
Date: Mon, 27 Jul 2026 15:50:47 -0400
Message-ID: <20260727195052.1774404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072050-armless-fidelity-4a3f@gregkh>
References: <2026072050-armless-fidelity-4a3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 03b18887703c5fa342896e52e873812ea33d964b ]

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: edf025f08385 ("dm-integrity: don't increment hash_offset twice")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-flakey.c          |  3 +-
 drivers/md/dm-integrity.c       | 54 +++++++++++++++++----------------
 drivers/md/dm-io.c              | 26 ++++++++--------
 drivers/md/dm-snap-persistent.c | 20 ++++++------
 drivers/md/dm-snap.c            |  3 +-
 drivers/md/dm-table.c           |  3 +-
 drivers/md/dm-verity-target.c   |  6 ++--
 drivers/md/dm-writecache.c      | 12 +++++---
 8 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 3b34270ce607e3..8b48beec9c7d7a 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -356,8 +356,7 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 		if (test_bit(DROP_WRITES, &fc->flags)) {
 			bio_endio(bio);
 			return DM_MAPIO_SUBMITTED;
-		}
-		else if (test_bit(ERROR_WRITES, &fc->flags)) {
+		} else if (test_bit(ERROR_WRITES, &fc->flags)) {
 			bio_io_error(bio);
 			return DM_MAPIO_SUBMITTED;
 		}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index c70dc64200d820..772d8f678b816c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -680,16 +680,18 @@ static bool block_bitmap_op(struct dm_integrity_c *ic, struct page_list *bitmap,
 	} else if (mode == BITMAP_OP_CLEAR) {
 		if (!bit && this_end_bit == PAGE_SIZE * 8 - 1)
 			clear_page(data);
-		else while (bit <= this_end_bit) {
-			if (!(bit % BITS_PER_LONG) && this_end_bit >= bit + BITS_PER_LONG - 1) {
-				do {
-					data[bit / BITS_PER_LONG] = 0;
-					bit += BITS_PER_LONG;
-				} while (this_end_bit >= bit + BITS_PER_LONG - 1);
-				continue;
+		else {
+			while (bit <= this_end_bit) {
+				if (!(bit % BITS_PER_LONG) && this_end_bit >= bit + BITS_PER_LONG - 1) {
+					do {
+						data[bit / BITS_PER_LONG] = 0;
+						bit += BITS_PER_LONG;
+					} while (this_end_bit >= bit + BITS_PER_LONG - 1);
+					continue;
+				}
+				__clear_bit(bit, data);
+				bit++;
 			}
-			__clear_bit(bit, data);
-			bit++;
 		}
 	} else {
 		BUG();
@@ -2084,23 +2086,23 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				unsigned int tag_todo = ic->tag_size;
 				char *tag_ptr = journal_entry_tag(ic, je);
 
-				if (bip) do {
-					struct bio_vec biv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
-					unsigned int tag_now = min(biv.bv_len, tag_todo);
-					char *tag_addr;
-					BUG_ON(PageHighMem(biv.bv_page));
-					tag_addr = bvec_virt(&biv);
-					if (likely(dio->op == REQ_OP_WRITE))
-						memcpy(tag_ptr, tag_addr, tag_now);
-					else
-						memcpy(tag_addr, tag_ptr, tag_now);
-					bvec_iter_advance(bip->bip_vec, &bip->bip_iter, tag_now);
-					tag_ptr += tag_now;
-					tag_todo -= tag_now;
-				} while (unlikely(tag_todo)); else {
-					if (likely(dio->op == REQ_OP_WRITE))
-						memset(tag_ptr, 0, tag_todo);
-				}
+				if (bip) {
+					do {
+						struct bio_vec biv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
+						unsigned int tag_now = min(biv.bv_len, tag_todo);
+						char *tag_addr;
+						BUG_ON(PageHighMem(biv.bv_page));
+						tag_addr = bvec_virt(&biv);
+						if (likely(dio->op == REQ_OP_WRITE))
+							memcpy(tag_ptr, tag_addr, tag_now);
+						else
+							memcpy(tag_addr, tag_ptr, tag_now);
+						bvec_iter_advance(bip->bip_vec, &bip->bip_iter, tag_now);
+						tag_ptr += tag_now;
+						tag_todo -= tag_now;
+					} while (unlikely(tag_todo));
+				} else if (likely(dio->op == REQ_OP_WRITE))
+					memset(tag_ptr, 0, tag_todo);
 			}
 
 			if (likely(dio->op == REQ_OP_WRITE)) {
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index ec97658387c39d..e45587e89ece6a 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -351,18 +351,20 @@ static void do_region(const blk_opf_t opf, unsigned int region,
 			num_sectors = min_t(sector_t, special_cmd_max_sectors, remaining);
 			bio->bi_iter.bi_size = num_sectors << SECTOR_SHIFT;
 			remaining -= num_sectors;
-		} else while (remaining) {
-			/*
-			 * Try and add as many pages as possible.
-			 */
-			dp->get_page(dp, &page, &len, &offset);
-			len = min(len, to_bytes(remaining));
-			if (!bio_add_page(bio, page, len, offset))
-				break;
-
-			offset = 0;
-			remaining -= to_sector(len);
-			dp->next_page(dp);
+		} else {
+			while (remaining) {
+				/*
+				 * Try and add as many pages as possible.
+				 */
+				dp->get_page(dp, &page, &len, &offset);
+				len = min(len, to_bytes(remaining));
+				if (!bio_add_page(bio, page, len, offset))
+					break;
+
+				offset = 0;
+				remaining -= to_sector(len);
+				dp->next_page(dp);
+			}
 		}
 
 		atomic_inc(&io->count);
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index eee1cd3aa3fcf2..16d81840df0fbc 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -514,15 +514,17 @@ static int read_exceptions(struct pstore *ps,
 		if (unlikely(prefetch_area < ps->current_area))
 			prefetch_area = ps->current_area;
 
-		if (DM_PREFETCH_CHUNKS) do {
-			chunk_t pf_chunk = area_location(ps, prefetch_area);
-			if (unlikely(pf_chunk >= dm_bufio_get_device_size(client)))
-				break;
-			dm_bufio_prefetch(client, pf_chunk, 1);
-			prefetch_area++;
-			if (unlikely(!prefetch_area))
-				break;
-		} while (prefetch_area <= ps->current_area + DM_PREFETCH_CHUNKS);
+		if (DM_PREFETCH_CHUNKS) {
+			do {
+				chunk_t pf_chunk = area_location(ps, prefetch_area);
+				if (unlikely(pf_chunk >= dm_bufio_get_device_size(client)))
+					break;
+				dm_bufio_prefetch(client, pf_chunk, 1);
+				prefetch_area++;
+				if (unlikely(!prefetch_area))
+					break;
+			} while (prefetch_area <= ps->current_area + DM_PREFETCH_CHUNKS);
+		}
 
 		chunk = area_location(ps, ps->current_area);
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1c601508ce0b46..1a8d808292e62c 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2339,8 +2339,7 @@ static void snapshot_status(struct dm_target *ti, status_type_t type,
 				       (unsigned long long)sectors_allocated,
 				       (unsigned long long)total_sectors,
 				       (unsigned long long)metadata_sectors);
-			}
-			else
+			} else
 				DMEMIT("Unknown");
 		}
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index f18e47a24454af..8e0b9783f3da30 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1982,8 +1982,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable))
 			set_dax_synchronous(t->md->dax_dev);
-	}
-	else
+	} else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
 
 	if (dm_table_any_dev_attr(t, device_dax_write_cache_enabled, NULL))
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 53150024d2dd4e..4cd2a273c1f955 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -333,10 +333,8 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			 */
 			r = -EAGAIN;
 			goto release_ret_r;
-		}
-		else if (verity_fec_decode(v, io,
-					   DM_VERITY_BLOCK_TYPE_METADATA,
-					   hash_block, data, NULL) == 0)
+		} else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_METADATA,
+					     hash_block, data, NULL) == 0)
 			aux->hash_verified = 1;
 		else if (verity_handle_err(v,
 					   DM_VERITY_BLOCK_TYPE_METADATA,
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 20fc84b24fc75f..6debfdd3340f19 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -941,7 +941,8 @@ static void writecache_suspend(struct dm_target *ti)
 	wc_lock(wc);
 	if (flush_on_suspend)
 		wc->writeback_all--;
-	while (writecache_wait_for_writeback(wc));
+	while (writecache_wait_for_writeback(wc))
+		;
 
 	if (WC_MODE_PMEM(wc))
 		persistent_memory_flush_cache(wc->memory_map, wc->memory_map_size);
@@ -2087,7 +2088,8 @@ static void writecache_writeback(struct work_struct *work)
 
 	if (unlikely(wc->writeback_all)) {
 		wc_lock(wc);
-		while (writecache_wait_for_writeback(wc));
+		while (writecache_wait_for_writeback(wc))
+			;
 		wc_unlock(wc);
 	}
 }
@@ -2445,12 +2447,14 @@ static int writecache_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			if (WC_MODE_PMEM(wc)) {
 				wc->writeback_fua = true;
 				wc->writeback_fua_set = true;
-			} else goto invalid_optional;
+			} else
+				goto invalid_optional;
 		} else if (!strcasecmp(string, "nofua")) {
 			if (WC_MODE_PMEM(wc)) {
 				wc->writeback_fua = false;
 				wc->writeback_fua_set = true;
-			} else goto invalid_optional;
+			} else
+				goto invalid_optional;
 		} else if (!strcasecmp(string, "metadata_only")) {
 			wc->metadata_only = true;
 		} else if (!strcasecmp(string, "pause_writeback") && opt_params >= 1) {
-- 
2.53.0

