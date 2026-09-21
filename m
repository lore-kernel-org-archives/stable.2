Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B93890EC
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973076; cv=none; b=BuSwg5+rMvwh2rRW+1FDvgq0F7giSWFDQTAJh8LQbuWaJJINBnmG7XWRK2OYSjAABISKmIsFg/BE7PCBCp+8PxqM+QBMisaUIpDdgKtSwy1e2BVdfDEfbCjywEgZMXSxnQZEKA7szEr2KuLwpDrgOb08ud9IReAoB7U8K6C/KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973076; c=relaxed/simple;
	bh=8d+jNPn6pFoBzn3oi+uAyDZswZ/0wXxkVHKBDxGIVI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l99K/CQb5Q+JfhbyTWWu8uHbsHvvFe6PXc+mA3t25GJT+ccN3b1pLvhoTmJVjsLJ2ZzZn+srL4JZ6T6wD6r4EdLhs0tR3SZawh9cGeOkQpOnCMXwTnpKc/phR9sRJcolw66Q1XH7AYxFzIgq8iuWpchpQaWMaXVk6E+F+4RRa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDSNs2it; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDSNs2it"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so31048195ad.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789973074; x=1790577874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=np+0nndZvh0ruLFsAg5UmGJj5l4g4gOoBBJ1iI+Qq1Y=;
        b=pDSNs2itt9Jpa1tpcwNLeHb7LjxbWAJPUvWnpCM228NdYTxJ5T3lk7vw2TuJL0Bwxj
         tsFeVTa2eWkMN8cwncFIev8rBOQIB2YpACyzUpHcwOXq+kikzf0cyqrMQYhfpBv4564+
         sgRj5bwPmRuxgSbFEvg/CjxTbTRaEdnrIGjvNwCoKsiLWyFID9ayRYCdkoCZKR2S7ZvD
         aAdgmLvdfngFcwF0iUeAB6IbgyILcq9/mUf554brR5A0KLKi7XpYMjKqN3BkFdGbcDxX
         b7JVBzph7g1OYsOwBAlLF+c8dTrV9SVRqBvV/YXro3qHzVCmEONzP1yucq6in8xXLKYb
         Yadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789973074; x=1790577874;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=np+0nndZvh0ruLFsAg5UmGJj5l4g4gOoBBJ1iI+Qq1Y=;
        b=ASHTNt/Tf6Loz5OI195eKHWeq44czRSmp7WiJHKz//x/yE6VuRdgXAZ16Lt3ckQ8F7
         TTNCCvCPrf9axy3IiDJu9UYjJWL5AmlcFX2PYl24DLFUoS8PWjSpJB5vn9L6f3yEsFD7
         dtIg29eaiu8J4EHs2FbB4sC0WoFV5DyJi+16A20286/6jjKmWAmpaYrVJxOCA4zFpsP2
         EIO7HqLWIiLrW423IV+zzh66r0EN0cOIIdRpRe+DqoPolYGnm8kssW23niOerYEBDEuD
         7VkjZScXENppOeoEg3MSPD1om3A4ueTIj5FwcryvyEpjvMAFk2swkux8/lT7eyVDqV8O
         6YvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxscexWZGfPGYzjsVKJy/OUobp2H1TlbuBGu0YLI58plW8X5gmvtJytwtqL3cSJ6gxiwtKeeis=@vger.kernel.org
X-Gm-Message-State: AFuF++l2mvOChQ+gm+V1E19HWS0JVCtERs3TzlPM4EIb2DVniPzl0llK
	2sGjOIcdS9h2FikseoNuNWayx0y/UUqCXOHCknAcqvooDJM/jdjEEoGs
X-Gm-Gg: AYBFou2mWeYosNoEvhhUPpzjKJ0iy8QvoqWw5/SXs+9BVPSULKkjQQmAOvkgonygiPB
	0+UPN42Dql0xwl1w2v3ANx+6AHwrjDmS/8so242Y8ddJumtiu7BIUBULxkeDR0bpykdEhSuu+J6
	QE51p1DQQ1mHudePa9TE/1k81EF7Nx0zlJT0bwWUSpavqRySIFt9QMhp2obPo3lPyvZm0G618eY
	BSpycn30OpkEV/eeDdlu8jGpMeOrjLM1f0nZ8VdWFV1QOCKerY8roQF5FezXKKkqJWc8JY0ucN0
	eaN97VIBJ0U83TdTWYU5VT6lo7dbiXsVFTtmbAwBub1OuPFO6J1jnmmp0G9pllLcntRuETDpbFa
	8QX8ZlQGJhelWIeZNjTKMw1iKMWcyw4QqzetVfb5zKGD2sEUuJsldfiY2rtehwxO7c1ndZhbm35
	fY0VMyvEVBjXKfW4NYCWGNiOSWZQAiFA9sJmjFgxSDp4v/gcr0chDE+ipcsQ33EbkTRFcZu7ecf
	pYcWaA6SXP9HGYA
X-Received: by 2002:a17:903:1b08:b0:2dd:c100:9440 with SMTP id d9443c01a7336-2ddc1009c6bmr89511145ad.62.1789973073929;
        Sun, 20 Sep 2026 23:44:33 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm28097345ad.81.2026.09.20.23.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:44:32 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v6 03/10] ntfs: write MFT mirror data in mapped I/O units
Date: Mon, 21 Sep 2026 15:44:05 +0900
Message-ID: <20260921-topic-4kn-lkml-v6-3-75069f590b22@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
References: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7930; i=hyc.lee@gmail.com; h=from:subject:message-id; bh=8d+jNPn6pFoBzn3oi+uAyDZswZ/0wXxkVHKBDxGIVI4=; b=kA0DAAoBNPIw+veOSNMByyZiAGqw0grIu5I43l+a/+6N0ni13nxqhHeVJiOk69DSbeq/KpLAK okCMwQAAQoAHRYhBNWFKcxTduNtbh5vYjTyMPr3jkjTBQJqsNIKAAoJEDTyMPr3jkjTA5sQAIBG De3sErI9H6asYzR36yb/VPfIVDbiW9o6RpgYYXcdu+3dLEK05TXLUQssoUQWGBzA6li418c9LGu rmaBkmfwpN1maof6dfgbzCH7nSsBlS98yIWQ8VJXULIgxK1gwG2PWPzjXzKY6cilmFM7Ak0LvQP AUXhUOBQHjkTvwEa5bAayhdIZ1ZVjF8RvV86ELa4fzQ6JlFiKa5+JtX2lTGKCy4/uyaozyMgHQd qv7U7MkcT2dXqC2xr/ChPZPS8BrMXU5dM9kjxuyMIhnoSNC3h4+Pyhfuz6NNPBKzT1ZMyIk5nOi 4c836qF+b+OlIKChdUdM3I0iWedJUwBJ8r70cuHcOi/d/mjFtC6S+d43xENxVMjw0n6fVBKlwbp TLvBASg2LjDSXDRgdn1W+s6QdjdvoXlOCuq5H55V1MR+GrzOuKHOPKTMOBHlZSqxf54OzPFGkjk xQuo+LzdyTt8eyWxnNX6Cnsg06Z6rPMRZNznqwqVlCd1ynQyM2i3JRSYa/ey5xoD0W2D/DkJTfh l/EfAq91n2ixox+iDRpJG3VR8RcFfgW8MIEykjFwMw3mLFAfqiOgQQPp1kZjZlrhyHymR90bsJz aTFbTtKuJDPJkHOOanSU/StdL9h7LneIeburHJO711QZhzv0rHOLlBYEnsAbj2ALiRDZtckVvJb //YBZ
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Replace the record-specific mirror writer with a unit-based helper
and use a stack-allocated BIO for synchronous mirror writes.

Route write_mft_record_nolock() and ntfs_write_mft_block() through
the common mirror primitive. The helper only returns errors, So callers
handle volume error reporting and retry policy.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/mft.c | 142 ++++++++++++++++++++++++++++++----------------------------
 fs/ntfs/mft.h |   2 -
 2 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index c9ea11198aa6..b102e0204eba 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -429,6 +429,12 @@ void __mark_mft_record_dirty(struct ntfs_inode *ni)
 	__mark_inode_dirty(VFS_I(base_ni), I_DIRTY_DATASYNC);
 }
 
+struct ntfs_mft_io_unit {
+	sector_t sector;
+	unsigned int folio_ofs;
+	unsigned int len;
+};
+
 /*
  * ntfs_bio_end_io - bio completion callback for MFT record writes
  *
@@ -445,65 +451,60 @@ static void ntfs_bio_end_io(struct bio *bio)
 }
 
 /*
- * ntfs_sync_mft_mirror - synchronize an mft record to the mft mirror
- * @vol:	ntfs volume on which the mft record to synchronize resides
- * @mft_no:	mft record number of mft record to synchronize
- * @m:		mapped, mst protected (extent) mft record to synchronize
- *
- * Write the mapped, mst protected (extent) mft record @m with mft record
- * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol.
- *
- * On success return 0.  On error return -errno and set the volume errors flag
- * in the ntfs volume @vol.
- *
- * NOTE:  We always perform synchronous i/o.
+ * Write one MFT I/O unit to $MFTMirr.  The source folio contains the MST
+ * protected image that will be written to $MFT.
  */
-int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
-		struct mft_record *m)
+static int ntfs_sync_mft_mirror_unit(struct ntfs_volume *vol,
+				     struct folio *source, u64 mirror_file_ofs,
+				     const struct ntfs_mft_io_unit *unit)
 {
-	u8 *kmirr;
-	struct folio *folio;
-	unsigned int folio_ofs;
-	int err = 0;
-	struct bio *bio;
+	struct folio *mirror;
+	struct bio_vec bvec;
+	struct bio bio;
+	u64 mirror_size;
+	unsigned int mirror_ofs;
+	u8 *src, *dst;
+	int err;
 
-	ntfs_debug("Entering for inode 0x%llx.", mft_no);
+	if (unlikely(!vol->mftmirr_ino))
+		return -EIO;
+
+	mirror_size = (u64)vol->mftmirr_size * vol->mft_record_size;
+	if (mirror_file_ofs >= mirror_size ||
+	    unit->len > mirror_size - mirror_file_ofs)
+		return -EIO;
+	if (unit->folio_ofs + unit->len > folio_size(source))
+		return -EIO;
 
-	if (unlikely(!vol->mftmirr_ino)) {
-		/* This could happen during umount... */
+	mirror = read_mapping_folio(vol->mftmirr_ino->i_mapping,
+				    mirror_file_ofs >> PAGE_SHIFT, NULL);
+	if (IS_ERR(mirror))
+		return PTR_ERR(mirror);
+
+	folio_lock(mirror);
+	if (folio_test_writeback(mirror))
+		folio_wait_writeback(mirror);
+	mirror_ofs = mirror_file_ofs - folio_pos(mirror);
+	if (mirror_ofs + unit->len > folio_size(mirror)) {
 		err = -EIO;
-		goto err_out;
-	}
-	/* Get the page containing the mirror copy of the mft record @m. */
-	folio = read_mapping_folio(vol->mftmirr_ino->i_mapping,
-			NTFS_MFT_NR_TO_PIDX(vol, mft_no), NULL);
-	if (IS_ERR(folio)) {
-		ntfs_error(vol->sb, "Failed to map mft mirror page.");
-		err = PTR_ERR(folio);
-		goto err_out;
+		goto out_unlock;
 	}
 
-	folio_lock(folio);
-	folio_clear_uptodate(folio);
-	/* Offset of the mft mirror record inside the page. */
-	folio_ofs = NTFS_MFT_NR_TO_POFS(vol, mft_no);
-	/* The address in the page of the mirror copy of the mft record @m. */
-	kmirr = kmap_local_folio(folio, 0) + folio_ofs;
-	/* Copy the mst protected mft record to the mirror. */
-	memcpy(kmirr, m, vol->mft_record_size);
-	kunmap_local(kmirr);
-
-	bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOIO);
-	bio->bi_iter.bi_sector =
-		ntfs_bytes_to_bio_sector(NTFS_CLU_TO_B(vol, vol->mftmirr_lcn) +
-					 ((u64)folio->index << PAGE_SHIFT) +
-					 folio_ofs);
-
-	if (bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs))
-		err = submit_bio_wait(bio);
-	else
+	folio_clear_uptodate(mirror);
+	src = kmap_local_folio(source, unit->folio_ofs);
+	dst = kmap_local_folio(mirror, mirror_ofs);
+	memcpy(dst, src, unit->len);
+	kunmap_local(dst);
+	kunmap_local(src);
+
+	bio_init(&bio, vol->sb->s_bdev, &bvec, 1, REQ_OP_WRITE);
+	bio.bi_iter.bi_sector = ntfs_bytes_to_bio_sector(NTFS_CLU_TO_B(vol, vol->mftmirr_lcn) +
+							 mirror_file_ofs);
+	if (!bio_add_folio(&bio, mirror, unit->len, mirror_ofs))
 		err = -EIO;
-	bio_put(bio);
+	else
+		err = submit_bio_wait(&bio);
+	bio_uninit(&bio);
 
 	/*
 	 * The in-memory mirror is now valid because we just memcpy()'d the
@@ -512,23 +513,26 @@ int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
 	 * the stale on-disk mirror and overwrite this copy.  The error is
 	 * propagated to the caller via @err.
 	 */
-	folio_mark_uptodate(folio);
+	folio_mark_uptodate(mirror);
 
-	folio_unlock(folio);
-	folio_put(folio);
-	if (likely(!err)) {
-		ntfs_debug("Done.");
-	} else {
-		ntfs_error(vol->sb, "I/O error while writing mft mirror record 0x%llx!", mft_no);
-err_out:
-		ntfs_error(vol->sb,
-			"Failed to synchronize $MFTMirr (error code %i).  Volume will be left marked dirty on umount.  Run chkdsk on the partition after umounting to correct this.",
-			err);
-		NVolSetErrors(vol);
-	}
+out_unlock:
+	folio_unlock(mirror);
+	folio_put(mirror);
 	return err;
 }
 
+static int ntfs_sync_mft_mirror_record(struct ntfs_volume *vol,
+				       struct folio *source, const u64 mft_no)
+{
+	struct ntfs_mft_io_unit unit = {
+		.folio_ofs = NTFS_MFT_NR_TO_POFS(vol, mft_no),
+		.len = vol->mft_record_size,
+	};
+
+	return ntfs_sync_mft_mirror_unit(vol, source,
+					 (u64)mft_no * vol->mft_record_size, &unit);
+}
+
 /*
  * write_mft_record_nolock - write out a mapped (extent) mft record
  * @ni:		ntfs inode describing the mapped (extent) mft record
@@ -600,8 +604,8 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 
 		/* Synchronize the mft mirror now if not @sync. */
 		if (!sync && ni->mft_no < vol->mftmirr_size) {
-			int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no,
-							   fixup_m);
+			int sub_err = ntfs_sync_mft_mirror_record(vol, folio,
+								  ni->mft_no);
 			if (unlikely(sub_err) && !err)
 				err = sub_err;
 		}
@@ -624,7 +628,8 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 
 	/* If @sync, now synchronize the mft mirror. */
 	if (sync && ni->mft_no < vol->mftmirr_size) {
-		int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+		int sub_err =
+			ntfs_sync_mft_mirror_record(vol, folio, ni->mft_no);
 
 		if (unlikely(sub_err) && !err)
 			err = sub_err;
@@ -3031,8 +3036,7 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 			prev_mft_ofs = mft_ofs;
 
 			if (mft_no < vol->mftmirr_size) {
-				int sub_err = ntfs_sync_mft_mirror(vol, mft_no,
-						(struct mft_record *)(kaddr + mft_ofs));
+				int sub_err = ntfs_sync_mft_mirror_record(vol, folio, mft_no);
 
 				if (unlikely(sub_err) && !err)
 					err = sub_err;
diff --git a/fs/ntfs/mft.h b/fs/ntfs/mft.h
index ed5c1d595c0d..eb8a6f0d7944 100644
--- a/fs/ntfs/mft.h
+++ b/fs/ntfs/mft.h
@@ -42,8 +42,6 @@ static inline void mark_mft_record_dirty(struct ntfs_inode *ni)
 		__mark_mft_record_dirty(ni);
 }
 
-int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
-		struct mft_record *m);
 int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int sync);
 
 /*

-- 
2.43.0

