Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573C3750DB
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973081; cv=none; b=V2axTsxFYf6vSfVlW8BYKjis9QveUfW4fHbjSGTBqLcMsRgMH9pbA0pPkM9rlXpj+rVvopRV1FFnfrI2koPephzEOJoFfw4V9ad3alilXOT8MtFnOjndQTJ3EYBKcIvfq1JI6u00Yt4mWTzgM+hOzENO2Ma4i4vHgXqHOsj5OU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973081; c=relaxed/simple;
	bh=+kNcA79EtbPfcjk/SU6XRo/q1lsGc0aB1oTij7qO0Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlR+euehOYBcPThs6QP+H+MefPq3Hx827OKVetoB+ZT0ROw5eQ2P5OJz1RrDoxikJVEnvVSMiUv7S6JtIgPMDp9xcyokKvXa5GiQnaSdKq12+nsfbzIFEprY14o1flupcDBM8rx2/9/UZei+xhCpgnJGustj8bpFU/HEHOGNb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj2EHEzw; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj2EHEzw"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so17488555ad.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789973079; x=1790577879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9VlVhneZ4C5fzkdt1w3V+LFgBwJNAJsLJbNLPan0zM=;
        b=jj2EHEzwAkfMwWvGWZc/maWbX9np7y9XIdWTaiwo7kGLUdbLL8xTQDAkz2oZ21YbM6
         0O5QhM+7ZafCEwb7naeXPb7rqOzKxTzUpY/Xv62idsXW9FjRGhDh7TG3lG/PyzQq+4H7
         nkiLHnStVhLIc1cyED86A3vkoaohUlGdpZFe/6Ke/AV86dHY30ySqrL4phJsg+ulqH5j
         NgQv0fvhsd5Jfrldm3+iUCa+9kcPk2PSM+7DvNYVAwjFTeaswrojdZbwVEroJQBhRlh0
         6JvTFKy91AB+D1bBt08Gs/BTOar3Gdek06tbUJh8zV7ZP/tayZchSaknIwNi04pt8Lup
         dhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789973079; x=1790577879;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9VlVhneZ4C5fzkdt1w3V+LFgBwJNAJsLJbNLPan0zM=;
        b=QQC71FlYv/gmJ4ZK7Uo4Ms3iFLNW/fN/tGe/oow5nD+VyGBebAXWHMMNo5rvIoRC2Z
         Jx/FkrKw9XGpOHI6A0kUQdlz9lG+dMiub2PyFazdUTiPeOp5jpqs1AOCm9heB/YLM4Ma
         GTRJ+YYokLNwC86o91cX2ZdnTacP6Ne8T82/Aatct4RnwquaEPAm1zV1X2e+f5CmS4HZ
         BmwsfDNnEyc1QnASv9QEgSs/4qt3bmKUz05CCsgiA+K0weVUhJgnAgTkNI/N8yq5cYxA
         byu8rSzMoS5+yUDl8K/XihOEL+N0oL6dtAvcIt1veSkZMx4r2BB+WcT2Rfta0aSXjNda
         GM6w==
X-Forwarded-Encrypted: i=1; AKwUvBx1HdZwv8LrxYE++urTdGvUJrtr1uHLO0SVkaprK2U4PNgl6v4xsFgZyil/O40mU3mCG7F4hxE=@vger.kernel.org
X-Gm-Message-State: AFuF++ltKU+lbI/YaGnkRcZXqtThVUOd1yBa7sGjsWJ35rITUVI+t7RI
	Srl/7k8/HSk4YrntnE3Z1cE7HoV2MqcnUycHlMdLgWe+f7ccjgw0SSgiEZ73tA==
X-Gm-Gg: AYBFou1KlGDyC8+qrBZAQDImYonYPFPILpIfoTvEmPZz7pcjQyPdJjvFyzi1KHd9bzT
	0AbfjcJFB3bu+utScTZLCWHrU/bmHiFpl4hh2Z6esVG0Tz8JSKccakOZ2G1t8UT/7ZHJCS1jwXd
	DAbX5TvCFwMSQNmn2mcuAQjHlGHVwDRnkDOC9kc2Qndt7PTVt8RtXFqnZ0OXwuq0p3muh+wMp11
	VfKwh1iW7hJ7k0KCVoIgk4rMO/yvMhInyfZz1KLdQdv4pgBSZZhftQr74EAq7eeGZA4tCBUYfuO
	ZFugp69HYreIldqqYCF4Bo/hHwDfv1VC48197DNHA4v7+COAL7789XDjFvP2dM4vKizWm6eLV+2
	ZOmgESAmdLOEKGtnPM2d3aWN6JxNyoJRPBzAt18jUr21FBEAjLiNa+t80piE21P7EGjTcg2U1mf
	KuH3SnL1IwQTq8jX4d+slgyBUYC0GcpWBJp58VKQR+01F5NF9hAx34vD9+cpoEZ7VFXNiSnTK2M
	Xlf6g==
X-Received: by 2002:a17:902:e745:b0:2dd:ad73:c98d with SMTP id d9443c01a7336-2ddb1bdefcdmr133638535ad.37.1789973079250;
        Sun, 20 Sep 2026 23:44:39 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm28097345ad.81.2026.09.20.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:44:38 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v6 05/10] ntfs: track direct MFT writes until BIO completion
Date: Mon, 21 Sep 2026 15:44:07 +0900
Message-ID: <20260921-topic-4kn-lkml-v6-5-75069f590b22@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12240; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=+kNcA79EtbPfcjk/SU6XRo/q1lsGc0aB1oTij7qO0Sk=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqsNILWnIG8nSj3Rnbr/TclHAwpPFY2dV+uWBiC
 cFkqwBY3zKJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCarDSCwAKCRA08jD6945I
 05/tD/0Yq97TFwuzSX4I52STFJLxOtq/OUL99oGlD+f6AHcGRrOfE1b2PY1eMhPuHTaIP2nSoKf
 bZvEGR0Hb5n9NiBO3+hXm7lneP6Ib7IL1jWBqsKIsb7PJoS9RzgB/jt+XWtnPB0PgZ7Q7bHKPiC
 JJ178nl1smeA+Ge8TW2+UI/JPosHMgo18ukoUUee8hZiQq8bwPJiFZV62mLHVBkToWSvHR9d/MJ
 ufyq4sMH1oRw7OHdEzsgkxJoEPiUU0xFgoJC2F34CkBXd9kbfIwoa85Q0UdBPs2+kC5QWWFNno8
 MtZ8I1rbCWnqpk2zuKmIPWAZ3fTz74+jvoJ0HnOtod2pt/jgem2clnAljSPlWuz8S4omLJOPm1m
 IxJOKm2AzkshFJr7VpYfQ3+JmEKnekmHCFaMtlZGS1Rjnu/RCmuCLC+ZK1MSkBpx45zCuySM+WW
 ixP5kW3IA8Mec3qn5TqiRPZ7TsTxbRPQBLrZDN56nLZLurz1KAwSwMlJMKK+F2f4cv6TdwPnHYh
 vXZfT/eGecFqtfsLiLSpsX+r7XLZ1h9+1UOXhZpM8s8IYujhhQbMUsipxM3HeXAbniHGukz8gLw
 TgSTG34OJ/gYhB1v7HM+ruNoVhOHfrzJ8LGiodJftGTUi4cMpu6uGb7pIGOM7gjakIe31hglMr9 w01Kvj122jNt5LA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Use an aggregate parent BIO, with optional chained child BIOs, for direct
MFT record writes. Keep the folio reference and PG_writeback set until all
physical segments complete.

For asynchronous writes, release the parent BIO embedded in the write
context before ending folio writeback. Synchronous callers retain ownership
of the parent BIO after waiting.

Wait for any prior folio writeback before modifying a direct MFT record.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/mft.c   | 236 ++++++++++++++++++++++++++++++++++++++++++++------------
 fs/ntfs/mft.h   |  15 ++--
 fs/ntfs/super.c |  10 +++
 3 files changed, 206 insertions(+), 55 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index c7577c322454..51066b403757 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -10,6 +10,7 @@
 
 #include <linux/writeback.h>
 #include <linux/bio.h>
+#include <linux/completion.h>
 #include <linux/iomap.h>
 
 #include "bitmap.h"
@@ -450,6 +451,91 @@ static void ntfs_bio_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+struct ntfs_mft_write_ctx {
+	struct folio *folio;
+	struct address_space *mapping;
+	struct ntfs_volume *vol;
+	struct completion *done;
+	int error;
+	bool writeback_started;
+	struct bio bio;
+};
+
+static struct bio_set ntfs_mft_bioset;
+
+int ntfs_mft_bioset_init(void)
+{
+	return bioset_init(&ntfs_mft_bioset, BIO_POOL_SIZE,
+			   offsetof(struct ntfs_mft_write_ctx, bio),
+			   BIOSET_NEED_BVECS);
+}
+
+void ntfs_mft_bioset_exit(void)
+{
+	bioset_exit(&ntfs_mft_bioset);
+}
+
+static void ntfs_mft_end_io(struct bio *bio)
+{
+	struct ntfs_mft_write_ctx *ctx =
+		container_of(bio, struct ntfs_mft_write_ctx, bio);
+	struct folio *folio = ctx->folio;
+	struct completion *done = ctx->done;
+	int err;
+
+	if (bio->bi_status)
+		err = blk_status_to_errno(bio->bi_status);
+	else
+		err = ctx->error;
+	if (err) {
+		mapping_set_error(ctx->mapping, err);
+		NVolSetErrors(ctx->vol);
+		ntfs_error(ctx->vol->sb, "I/O error while writing MFT: %d",
+			   err);
+	}
+
+	if (!done)
+		bio_put(bio);
+	folio_end_writeback(folio);
+	folio_put(folio);
+	if (done)
+		complete(done);
+}
+
+static void ntfs_start_mft_writeback(struct ntfs_mft_write_ctx *ctx)
+{
+	if (ctx->writeback_started)
+		return;
+
+	inode_attach_wb(ctx->mapping->host, NULL);
+	folio_get(ctx->folio);
+	folio_start_writeback(ctx->folio);
+	ctx->writeback_started = true;
+}
+
+static struct bio *ntfs_alloc_mft_parent_bio(struct ntfs_volume *vol,
+					     struct folio *folio,
+					     struct completion *done)
+{
+	struct ntfs_mft_write_ctx *ctx;
+	struct bio *parent;
+
+	parent = bio_alloc_bioset(vol->sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOIO,
+				  &ntfs_mft_bioset);
+	if (!parent)
+		return NULL;
+
+	ctx = container_of(parent, struct ntfs_mft_write_ctx, bio);
+	ctx->folio = folio;
+	ctx->mapping = folio->mapping;
+	ctx->vol = vol;
+	ctx->done = done;
+	ctx->error = 0;
+	ctx->writeback_started = false;
+	parent->bi_end_io = ntfs_mft_end_io;
+	return parent;
+}
+
 /*
  * Write one MFT I/O unit to $MFTMirr.  The source folio contains the MST
  * protected image that will be written to $MFT.
@@ -533,6 +619,42 @@ static int ntfs_sync_mft_mirror_record(struct ntfs_volume *vol,
 					 (u64)mft_no * vol->mft_record_size, &unit);
 }
 
+static int ntfs_prepare_mft_record_io_units(struct ntfs_inode *ni,
+					    struct ntfs_mft_io_unit units[2])
+{
+	struct ntfs_volume *vol = ni->vol;
+	u64 record_byte = (u64)ni->mft_no * vol->mft_record_size;
+	u64 disk_byte;
+	unsigned int nr_units = ni->mft_lcn_count;
+	unsigned int cluster_ofs;
+	unsigned int i;
+
+	if (!nr_units || nr_units > ARRAY_SIZE(ni->mft_lcn))
+		return -EIO;
+	for (i = 0; i < nr_units; i++)
+		if (ni->mft_lcn[i] < 0)
+			return -EIO;
+
+	cluster_ofs = ntfs_bytes_to_cluster_off(vol, record_byte);
+	disk_byte = NTFS_CLU_TO_B(vol, ni->mft_lcn[0]) + cluster_ofs;
+	units[0] = (struct ntfs_mft_io_unit){
+		.sector = ntfs_bytes_to_bio_sector(disk_byte),
+		.folio_ofs = ni->folio_ofs,
+		.len = vol->mft_record_size,
+	};
+	if (nr_units == 1)
+		return 1;
+
+	units[0].len = vol->cluster_size;
+	disk_byte = NTFS_CLU_TO_B(vol, ni->mft_lcn[1]);
+	units[1] = (struct ntfs_mft_io_unit){
+		.sector = ntfs_bytes_to_bio_sector(disk_byte),
+		.folio_ofs = ni->folio_ofs + vol->cluster_size,
+		.len = vol->mft_record_size - vol->cluster_size,
+	};
+	return 2;
+}
+
 /*
  * write_mft_record_nolock - write out a mapped (extent) mft record
  * @ni:		ntfs inode describing the mapped (extent) mft record
@@ -553,17 +675,23 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 {
 	struct ntfs_volume *vol = ni->vol;
 	struct folio *folio = ni->folio;
-	int err = 0, i = 0;
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct ntfs_mft_io_unit units[2];
+	struct ntfs_mft_write_ctx *ctx;
+	struct bio *parent, *child = NULL;
+	unsigned int nr_units;
+	int err = 0;
 	u8 *kaddr;
 	struct mft_record *fixup_m;
-	struct bio *bio;
-	unsigned int offset = 0, folio_size;
 
 	ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
 
 	WARN_ON(NInoAttr(ni));
 	WARN_ON(!folio_test_locked(folio));
 
+	if (folio_test_writeback(folio))
+		folio_wait_writeback(folio);
+
 	/*
 	 * If the struct ntfs_inode is clean no need to do anything.  If it is dirty,
 	 * mark it as clean now so that it can be redirtied later on if needed.
@@ -573,6 +701,11 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 	if (!NInoTestClearDirty(ni))
 		goto done;
 
+	err = ntfs_prepare_mft_record_io_units(ni, units);
+	if (err < 0)
+		goto err_out;
+	nr_units = err;
+
 	kaddr = kmap_local_folio(folio, 0);
 	fixup_m = (struct mft_record *)(kaddr + ni->folio_ofs);
 	memcpy(fixup_m, m, vol->mft_record_size);
@@ -584,69 +717,74 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 		goto unmap_err_out;
 	}
 
-	folio_size = vol->mft_record_size / ni->mft_lcn_count;
-	while (i < ni->mft_lcn_count) {
-		unsigned int clu_off;
-
-		clu_off = (unsigned int)((s64)ni->mft_no * vol->mft_record_size + offset) &
-			vol->cluster_size_mask;
-
-		bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOIO);
-		bio->bi_iter.bi_sector =
-			ntfs_bytes_to_bio_sector(NTFS_CLU_TO_B(vol, ni->mft_lcn[i]) +
-						 clu_off);
+	parent = ntfs_alloc_mft_parent_bio(vol, folio, sync ? &done : NULL);
+	if (!parent) {
+		err = -ENOMEM;
+		goto unmap_err_out;
+	}
+	ctx = container_of(parent, struct ntfs_mft_write_ctx, bio);
 
-		if (!bio_add_folio(bio, folio, folio_size,
-				   ni->folio_ofs + offset)) {
-			err = -EIO;
-			goto put_bio_out;
+	parent->bi_iter.bi_sector = units[0].sector;
+	if (!bio_add_folio(parent, folio, units[0].len, units[0].folio_ofs)) {
+		err = -EIO;
+		goto put_bios_out;
+	}
+
+	if (nr_units == 2) {
+		if (bio_end_sector(parent) != units[1].sector ||
+		    !bio_add_folio(parent, folio, units[1].len,
+				   units[1].folio_ofs)) {
+			child = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE,
+					  GFP_NOIO);
+			if (!child) {
+				err = -ENOMEM;
+				goto put_bios_out;
+			}
+			child->bi_iter.bi_sector = units[1].sector;
+			if (!bio_add_folio(child, folio, units[1].len,
+					   units[1].folio_ofs)) {
+				err = -EIO;
+				goto put_bios_out;
+			}
 		}
+	}
 
-		/* Synchronize the mft mirror now if not @sync. */
-		if (!sync && ni->mft_no < vol->mftmirr_size) {
-			int sub_err = ntfs_sync_mft_mirror_record(vol, folio,
-								  ni->mft_no);
-			if (unlikely(sub_err) && !err)
-				err = sub_err;
-		}
+	if (ni->mft_no < vol->mftmirr_size) {
+		err = ntfs_sync_mft_mirror_record(vol, folio, ni->mft_no);
+		if (err)
+			ctx->error = err;
+	}
 
-		if (sync) {
-			int sub_err = submit_bio_wait(bio);
+	kunmap_local(kaddr);
 
-			bio_put(bio);
-			if (unlikely(sub_err) && !err)
-				err = sub_err;
-		} else {
-			folio_get(folio);
-			bio->bi_private = folio;
-			bio->bi_end_io = ntfs_bio_end_io;
-			submit_bio(bio);
-		}
-		offset += vol->cluster_size;
-		i++;
+	ntfs_start_mft_writeback(ctx);
+	if (child) {
+		bio_chain(child, parent);
+		submit_bio(child);
 	}
+	submit_bio(parent);
 
-	/* If @sync, now synchronize the mft mirror. */
-	if (sync && ni->mft_no < vol->mftmirr_size) {
-		int sub_err =
-			ntfs_sync_mft_mirror_record(vol, folio, ni->mft_no);
-
-		if (unlikely(sub_err) && !err)
-			err = sub_err;
+	if (sync) {
+		wait_for_completion(&done);
+		if (!err && parent->bi_status)
+			err = blk_status_to_errno(parent->bi_status);
+		bio_put(parent);
 	}
-	kunmap_local(kaddr);
+
 	if (unlikely(err)) {
 		/* I/O error during writing.  This is really bad! */
 		ntfs_error(vol->sb,
 			"I/O error while writing mft record 0x%llx!  Marking base inode as bad.  You should unmount the volume and run chkdsk.",
 			ni->mft_no);
-		goto err_out;
+		return err;
 	}
 done:
 	ntfs_debug("Done.");
 	return 0;
-put_bio_out:
-	bio_put(bio);
+put_bios_out:
+	if (child)
+		bio_put(child);
+	bio_put(parent);
 unmap_err_out:
 	kunmap_local(kaddr);
 err_out:
diff --git a/fs/ntfs/mft.h b/fs/ntfs/mft.h
index eb8a6f0d7944..28a79bf4c1c6 100644
--- a/fs/ntfs/mft.h
+++ b/fs/ntfs/mft.h
@@ -42,6 +42,8 @@ static inline void mark_mft_record_dirty(struct ntfs_inode *ni)
 		__mark_mft_record_dirty(ni);
 }
 
+int ntfs_mft_bioset_init(void);
+void ntfs_mft_bioset_exit(void);
 int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int sync);
 
 /*
@@ -51,16 +53,17 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
  * @sync:	if true, wait for i/o completion
  *
  * This is just a wrapper for write_mft_record_nolock() (see mft.c), which
- * locks the page for the duration of the write.  This ensures that there are
- * no race conditions between writing the mft record via the dirty inode code
- * paths and via the page cache write back code paths or between writing
- * neighbouring mft records residing in the same page.
+ * locks the folio for the duration of the write.  The folio lock prevents
+ * races between writing the mft record via the dirty inode code paths and via
+ * page cache writeback or between neighbouring mft records residing in the
+ * same folio.
  *
  * Locking the page also serializes us against ->read_folio() if the page is not
  * uptodate.
  *
- * On success, clean the mft record and return 0.  On error, leave the mft
- * record dirty and return -errno.
+ * On success, clean the mft record and return 0.  On allocation failure,
+ * redirty the record for retry and return 0.  On other errors, return -errno
+ * and mark the volume with errors.
  */
 static inline int write_mft_record(struct ntfs_inode *ni, struct mft_record *m, int sync)
 {
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 1b66efbd3990..6a107ec0d0f6 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -18,6 +18,7 @@
 #include "sysctl.h"
 #include "logfile.h"
 #include "index.h"
+#include "mft.h"
 #include "ntfs.h"
 #include "ea.h"
 #include "volume.h"
@@ -2850,6 +2851,13 @@ static int __init init_ntfs_fs(void)
 		return err;
 	}
 
+	err = ntfs_mft_bioset_init();
+	if (err) {
+		pr_crit("Failed to initialize NTFS MFT bioset!\n");
+		ntfs_workqueue_destroy();
+		return err;
+	}
+
 	ntfs_index_ctx_cache = kmem_cache_create(ntfs_index_ctx_cache_name,
 			sizeof(struct ntfs_index_context), 0 /* offset */,
 			SLAB_HWCACHE_ALIGN, NULL /* ctor */);
@@ -2917,6 +2925,7 @@ static int __init init_ntfs_fs(void)
 actx_err_out:
 	kmem_cache_destroy(ntfs_index_ctx_cache);
 ictx_err_out:
+	ntfs_mft_bioset_exit();
 	if (!err) {
 		pr_crit("Aborting NTFS filesystem driver registration...\n");
 		err = -ENOMEM;
@@ -2935,6 +2944,7 @@ static void __exit exit_ntfs_fs(void)
 	 * destroy cache.
 	 */
 	rcu_barrier();
+	ntfs_mft_bioset_exit();
 #ifdef CONFIG_NTFS_FS_WOF_COMPRESSION
 	ntfs_wof_free_workspaces();
 #endif

-- 
2.43.0

