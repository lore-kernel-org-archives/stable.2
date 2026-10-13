Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377C3D16F1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899896; cv=none; b=Y5G/34OL4kitnn1cT6j2xi49qdDvPGo6XjslojNgT4FUCtcfAHblTmTZy5teco95gJjBBJ7TKUX7zprQXvprMbR/c6L5I9e/m1k7zFpGVLfdNZ1wd0EfLHa9fHy3yIpVaaiBefDOHIwAg+bT8WaXC3UVhkv7ZU+mJtTyEJ4l5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899896; c=relaxed/simple;
	bh=D4hcC+wS9Avj3WsvBaSEWVYaNJeNtG00RgxewDzY1p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5BgkIOCd4E6TPKyOGSUr2SigSni/eBDLJbP5eQTPxvB2va0uZ6T7Zl26OJIVPyqJ4RYfU1/DYLJZbX67/rsPSxbBzWCfVxUMRdAlo1tL/ypnpOG4c4lduDTtrLMO3BtQUHuiHDapX12MKDr5/92QABF5xFYPqtsrqyDlJpoq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dajg6YVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dajg6YVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F9B1F00898;
	Tue, 13 Oct 2026 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899894;
	bh=ZyxeJCjk6xnU4tcki0x/BFvjHOQGThN9pIZtpsgcKgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dajg6YVF08VL9laTPUbqEmKWGHJ3CXG6N3gLUIPcEvS3Eh25kikpbBuBCGj0NZA5S
	 XI9tuYJ3DSmXoATYM/1S7zFvvRlL6o/WXCwGrMAuq1IAI2XTbSjNJUvq04AV9SEgB8
	 gW6Ic4ArPUXPY/pgry4/RNP2vDOD7SGM324XK6M8AOPVPMo1DVCoc1ls2cxityAvI3
	 zwNPVzCPTYFuGhovAa+lRQOzZt5ydgt3FW24HY67spvHA7e0X9S8V03xIhQ35gDz6D
	 9bdJBRT5KIAj3/xudOOBlPfyr4uxyJsoJFbmGQcf1tueGdoMOE1sQAKS3SnbmtcLEF
	 WGPwrN+Rcu5ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	syzbot+675c91651049ad042c5f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] dm-integrity: validate the superblock on resume
Date: Tue, 13 Oct 2026 09:58:12 -0400
Message-ID: <20261013135651.3952606-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013135651.3952606-1-sashal@kernel.org>
References: <2026101259-length-disaster-0090@gregkh>
 <20261013135651.3952606-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit fc79aeb86a2c244c1f1894e2d8f2966fe2b60fa2 ]

dm_integrity_resume() re-reads the superblock from the device so that it
picks up the flags and the recalculate position. It performs no
validation on the result, while the constructor validates the superblock
it reads and sizes all the in-memory structures according to it. The user
may modify the superblock on the underlying device while the dm-integrity
device is suspended, so that the two no longer agree.

In particular, access_journal_data() shifts the journal entry index by
ic->sb->log2_sectors_per_block, while ic->journal_section_sectors and the
journal page list were computed with the value that was present at
constructor time. Increasing log2_sectors_per_block makes the index run
past the end of the journal, and dm-integrity then writes 512 bytes
through lowmem_page_address(NULL).

Snapshot the validated superblock in the constructor and refuse to resume
if any of the fields that describe the on-disk geometry changed.

Reported-by: syzbot+675c91651049ad042c5f@syzkaller.appspotmail.com
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 118ba36e446c ("dm-integrity: fix recalculation in bitmap mode")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index cded0607b39c0..3b36f4b8ec67b 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -180,6 +180,7 @@ struct dm_integrity_c {
 	struct dm_bufio_client *bufio;
 	struct workqueue_struct *metadata_wq;
 	struct superblock *sb;
+	struct superblock *sb_copy;
 	unsigned int journal_pages;
 	unsigned int n_bitmap_blocks;
 
@@ -3857,6 +3858,35 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 	ic->journal_uptodate = true;
 }
 
+/*
+ * The superblock is re-read from the device on every resume, so that we pick
+ * up the flags and the recalculate position. The geometry described by the
+ * superblock must not change though - the in-memory structures (and the
+ * journal in particular) were sized according to the superblock that was
+ * validated in the constructor. Reject a superblock that was modified behind
+ * our back.
+ *
+ * Only the fields that the driver never rewrites may be tested here. In
+ * particular, "version" is recalculated by sb_set_version on every superblock
+ * write and it depends on SB_FLAG_RECALCULATING and SB_FLAG_DIRTY_BITMAP, and
+ * SB_FLAG_DISCARD_KEYED may be set by dm_integrity_resume itself.
+ */
+static bool superblock_changed(struct dm_integrity_c *ic)
+{
+	const __le32 immutable_flags = cpu_to_le32(SB_FLAG_HAVE_JOURNAL_MAC |
+						   SB_FLAG_FIXED_PADDING |
+						   SB_FLAG_FIXED_HMAC |
+						   SB_FLAG_INLINE);
+
+	return memcmp(ic->sb->magic, ic->sb_copy->magic, sizeof(ic->sb->magic)) != 0 ||
+	       ic->sb->log2_interleave_sectors != ic->sb_copy->log2_interleave_sectors ||
+	       ic->sb->integrity_tag_size != ic->sb_copy->integrity_tag_size ||
+	       ic->sb->journal_sections != ic->sb_copy->journal_sections ||
+	       ic->sb->log2_sectors_per_block != ic->sb_copy->log2_sectors_per_block ||
+	       ((ic->sb->flags ^ ic->sb_copy->flags) & immutable_flags) != 0 ||
+	       memcmp(ic->sb->salt, ic->sb_copy->salt, SALT_SIZE) != 0;
+}
+
 static void dm_integrity_resume(struct dm_target *ti)
 {
 	struct dm_integrity_c *ic = ti->private;
@@ -3875,6 +3905,18 @@ static void dm_integrity_resume(struct dm_target *ti)
 	if (r)
 		dm_integrity_io_error(ic, "reading superblock", r);
 
+	if (unlikely(superblock_changed(ic))) {
+		/*
+		 * Restore the superblock that we validated in the constructor,
+		 * so that the rest of the driver doesn't operate on values
+		 * that don't match the in-memory structures.
+		 */
+		memcpy(ic->sb, ic->sb_copy, sizeof(struct superblock));
+		DMERR("The superblock was changed while the device was suspended");
+		dm_integrity_io_error(ic, "superblock check", -EINVAL);
+		goto skip_writes;
+	}
+
 	if (ic->mode == 'R')
 		goto skip_writes;
 
@@ -5421,6 +5463,13 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		ic->just_formatted = true;
 	}
 
+	ic->sb_copy = kmemdup(ic->sb, sizeof(struct superblock), GFP_KERNEL);
+	if (!ic->sb_copy) {
+		ti->error = "Cannot allocate superblock copy";
+		r = -ENOMEM;
+		goto bad;
+	}
+
 	if (!ic->meta_dev && ic->mode != 'I') {
 		r = dm_set_target_max_io_len(ti, 1U << ic->sb->log2_interleave_sectors);
 		if (r)
@@ -5519,6 +5568,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	kvfree(ic->journal_tree);
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
+	kfree(ic->sb_copy);
 
 	if (ic->internal_shash)
 		crypto_free_shash(ic->internal_shash);
-- 
2.53.0

