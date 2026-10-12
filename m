Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009348C8CE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816835; cv=none; b=U06s3q/+NtksO3zWM76qFPKmecgByUDJtstigdarvWjwnDlNb085XuG5Kj9JkbrQnXdS7KLjliPGtudt75f/G2pN1RqrL/z7gLmnhTinjV3pqwWSpUpXs4JEVuE2t70W4U365I6x3LjN/N62n0atwPmN+Zw5N1xAqaP5GlTAJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816835; c=relaxed/simple;
	bh=OYs95rvRXKn3qo30dbzwJgwtoUomDd80669R7evLeQM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jVur2aSaIHKzJZS6tD/NEH4tMZlCxP03bu8jMPNSRYNTF+5dmlirf/bxUkMAiPP/gI1XNl9Y0gHV2IHU3TulJr9RYW+psGV9hvI7TTHgcliohdZb6kim5/iibqz64HTHJ+qD68GEmOgmjBTkPl5mK4rnjtiSZguXAO1oIUPY1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tR1Ml5DL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tR1Ml5DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B941F0089B;
	Mon, 12 Oct 2026 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791816833;
	bh=+nH8Lew9DTS/Eimi5WURpGMt/EbfCL53lpMxdhDzZS0=;
	h=Subject:To:Cc:From:Date;
	b=tR1Ml5DLhlE5QbyeMzz0tyy28okEHEjAc2KczEoHcIaEr5kl+WorRF2PlgvyC5gKf
	 D7sV3TJTTgnN7zCB6jvl0BgohAXUUbBP6DYyQhJIiBXBb8p3Ji8jyIaxzn5MhRCte8
	 sRAs5fUKCZVO16UHYbAwDFN9Y4NLpZynS/rJBVVk=
Subject: FAILED: patch "[PATCH] dm-integrity: validate the superblock on resume" failed to apply to 7.2-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:53:59 +0200
Message-ID: <2026101259-length-disaster-0090@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x fc79aeb86a2c244c1f1894e2d8f2966fe2b60fa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101259-length-disaster-0090@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc79aeb86a2c244c1f1894e2d8f2966fe2b60fa2 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 30 Sep 2026 18:42:20 +0200
Subject: [PATCH] dm-integrity: validate the superblock on resume

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

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 0862f31b8498..802b377613b0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -180,6 +180,7 @@ struct dm_integrity_c {
 	struct dm_bufio_client *bufio;
 	struct workqueue_struct *metadata_wq;
 	struct superblock *sb;
+	struct superblock *sb_copy;
 	unsigned int journal_pages;
 	unsigned int n_bitmap_blocks;
 
@@ -3858,6 +3859,35 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
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
@@ -3876,6 +3906,18 @@ static void dm_integrity_resume(struct dm_target *ti)
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
 
@@ -5427,6 +5469,13 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
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
@@ -5525,6 +5574,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	kvfree(ic->journal_tree);
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
+	kfree(ic->sb_copy);
 
 	if (ic->internal_shash)
 		crypto_free_shash(ic->internal_shash);

