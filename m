Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049724;
	b=pj6cVmsYHpsnDmX73KHJ5JFQUC6b89D7T3ux5sFhZDL3AAxCPiJedg6w2IgOZsvqcm+4
	 0DqHur1Yx1pQSoVfnMCtDKzecyQjhXpBYGvaIiP07mCw7phTLiA8rRF1JXjsZccd2wmt+
	 LCJ32ZCm7cjHdX3oAT0foBeY3hB3GP9o3lcfNV43zw/5lo7OHYFeUeKRSvt2gM0hku/th
	 VGDtPX1uc7uLRe7zcegbHoCaqKXkqU9SBr1uj3BhtBFLvEtF3NNfJ2JpELb4H7Qr0PaMD
	 lukaAsSL8V0GGGjXUUdjl8IFJrC0xQI/y6wJygufhARiSAFyRn2XU0kyCmIcZLDgrnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049724;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rZcWsovhiWwEL+ahsG+xJjvOPtzGTV669HCQK/c+2wQ=;
	b=HQKBl6/61vQfBN8rN4E6vyNkhR6/yfzIOFxQBsn7iblZFvNvDmNwE/t9bqcPuDYpd+y5
	 GX9zkj8TX1F2rwusbARMLCG5/1/jrQTALIEgpjqMWDvZCSZRvj3oBUr1wJa+kCTxV/R3E
	 GS0ZR6IbUShXeNLKoP4+k5DXahcbJ1gQHpbqlN+es9oiaABS8g6cXnyeNIeUp3rXM3Ler
	 AxWYblesRH64j+dKIu3jGRP8GOghIKdPNYrk28hKwhY4+LK8AnmHb76VoZjEl+bcJLZJV
	 hfEG7LMvJr1pg/VAmRj3AIidz9Z/yBtYGTe8f9i5MHge+ahwhCqS0HNb4M7DJOdC+4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccTzIaYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccTzIaYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9D51F008A1;
	Sat,  7 Nov 2026 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049724;
	bh=rZcWsovhiWwEL+ahsG+xJjvOPtzGTV669HCQK/c+2wQ=;
	h=From:To:Cc:Subject:Date;
	b=ccTzIaYqSC19p5qiUjNi4lx0nGoUno/todCyl99T4ASp/JkKaFWHP10/To9dJaFZr
	 ScQbnCdI1wNY9EjOF8XM1BatdyUc5+IicyRlWhecUtg2g7tTpapKMVX87pSxs4cV2i
	 rdy7jlWa2lGOmaCVF5IFg577mi4ztfLEF+yfKvV6manNB/Na1d4sextg6pBalpFfru
	 Erk7kSEwU3bkAv50ohssor3wsZRo6Tf7T4GOg/QuYO2ebHkIoV4EKXPv6XBS7GHQIT
	 TRzCJT1ZOES8URJolmLUZVExT5weL7SYEXRw1RB7FnacvG0uyPdnOxRs0ZJxZLv6u5
	 9Ol7ZXNX0UfIQ==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fix volume flag update races" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:42 -0500
Message-ID: <20261107060842-failed-5.15-56a64ee0f99d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 56a64ee0f99d4ca1756cf743f951c110d39401e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060842-failed-5.15-56a64ee0f99d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 56a64ee0f99d4ca1756cf743f951c110d39401e5 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Tue, 15 Sep 2026 16:32:46 +0800
Subject: [PATCH] ntfs: fix volume flag update races

ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
vol->vol_flags outside any lock to compute the new value before handing
it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
the actual write. The read-modify-write is therefore not atomic, and two
concurrent callers can lose an update: ntfs_sync_fs() may derive a
"clean" value from vol->vol_flags while a writer concurrently records an
error and sets VOLUME_IS_DIRTY; the locked write then silently
overwrites the freshly-set dirty bit. The on-disk volume looks clean
despite the recorded errors, so chkdsk will not run on the next mount
and corrupted metadata can persist.

Fix by moving the read-modify-write inside the mrec_lock: pass the bits
to set and to clear separately, and combine them with the current flag
state under the lock inside ntfs_write_volume_flags(). The set/clear
helpers pass only the bits to modify, not the complete flag state. The
bit manipulation is done on CPU-endian values, and the result is
converted back to little-endian before storing it. The wrappers keep
their signatures so callers are unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 63 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index f7b3140049c40..5c71aaa0e25d5 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -360,31 +360,45 @@ void ntfs_handle_error(struct super_block *sb)
 }
 
 /*
- * ntfs_write_volume_flags - write new flags to the volume information flags
+ * ntfs_write_volume_flags - apply flag changes to the volume information flags
  * @vol:	ntfs volume on which to modify the flags
- * @flags:	new flags value for the volume information flags
+ * @set_bits:	bits to set in the volume information flags
+ * @clear_bits:	bits to clear in the volume information flags
  *
  * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
  * instead (see below).
  *
- * Replace the volume information flags on the volume @vol with the value
- * supplied in @flags.  Note, this overwrites the volume information flags, so
- * make sure to combine the flags you want to modify with the old flags and use
- * the result when calling ntfs_write_volume_flags().
+ * Combine @set_bits and @clear_bits with the current in-memory flag state and
+ * write the result back.  The set/clear helpers pass only the bits to modify,
+ * not the complete flag state.  The read-modify-write happens under
+ * ni->mrec_lock so that concurrent set/clear operations cannot lose updates.
+ * All bit manipulation is done on CPU-endian values, and the result is
+ * converted back to little-endian before storing it.
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
+static int ntfs_write_volume_flags(struct ntfs_volume *vol,
+		const __le16 set_bits, const __le16 clear_bits,
+		const bool skip_if_errors)
 {
 	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
 	struct volume_information *vi;
 	struct ntfs_attr_search_ctx *ctx;
+	u16 flags;
 	int err;
 
-	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
-			le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
 	mutex_lock(&ni->mrec_lock);
-	if (vol->vol_flags == flags)
+
+	if (skip_if_errors && NVolErrors(vol))
+		goto done;
+
+	flags = le16_to_cpu(vol->vol_flags);
+	flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
+	flags &= ~(le16_to_cpu(clear_bits) & le16_to_cpu(VOLUME_FLAGS_MASK));
+	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
+			le16_to_cpu(vol->vol_flags), flags);
+
+	if (le16_to_cpu(vol->vol_flags) == flags)
 		goto done;
 
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
@@ -400,7 +414,7 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
 
 	vi = (struct volume_information *)((u8 *)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
-	vol->vol_flags = vi->flags = flags;
+	vol->vol_flags = vi->flags = cpu_to_le16(flags);
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 done:
@@ -421,13 +435,14 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
  * @flags:	flags to set on the volume
  *
  * Set the bits in @flags in the volume information flags on the volume @vol.
+ * The bits are combined with the current flag state under the lock in
+ * ntfs_write_volume_flags(), so concurrent updates are not lost.
  *
  * Return 0 on success and -errno on error.
  */
 int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	flags &= VOLUME_FLAGS_MASK;
-	return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
+	return ntfs_write_volume_flags(vol, flags, 0, false);
 }
 
 /*
@@ -436,14 +451,27 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
  * @flags:	flags to clear on the volume
  *
  * Clear the bits in @flags in the volume information flags on the volume @vol.
+ * The bits are combined with the current flag state under the lock in
+ * ntfs_write_volume_flags(), so concurrent updates are not lost.
  *
  * Return 0 on success and -errno on error.
  */
 int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
 {
-	flags &= VOLUME_FLAGS_MASK;
-	flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
-	return ntfs_write_volume_flags(vol, flags);
+	return ntfs_write_volume_flags(vol, 0, flags, false);
+}
+
+/*
+ * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
+ * @vol:	ntfs volume whose dirty bit should be cleared
+ *
+ * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
+ * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
+ * recorded.
+ */
+static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
+{
+	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
 }
 
 int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
@@ -1926,8 +1954,7 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	/* If there are some dirty buffers in the bdev inode */
-	if (!NVolErrors(vol) &&
-	    ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
+	if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
 		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
 		err = -EIO;
 	}
-- 
2.53.0




