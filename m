Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048702;
	b=PFgKhZ+Wqlx3s/i+Jj1F9EzZwFFKT2BWyUIH8vU6TnJ/BXzVRv3s/tJA5WDgvefFxj0t
	 79zVCMnoO2k8kHmlCToCMtMv8AbB2VjKC8UA72wkMtDlGYssDsEDBru1pEjCVsQVgUH+A
	 nIU5Nznevp5NN8rq2boTI+GkGZBR7vtlssUX5i8CtfZ/EKLAp2DhUj0C7soN482uRoqol
	 l8IZVsC55x7sbEeSlSH01XT0FTz6qYIBGxmfrQBov8drH0S7y6sH7kE/9Tpk+BuloSovv
	 EOaaH9mZLsguxamH5ad+YA4bGmxj42RN/nvwlXICrvqgWIWvqT/wP5S5Yet2Cp5PbYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0D5iegoNJToxft5zbf7AeiECcNrKYRRpx3j3MWJJOdY=;
	b=2ey3cHXDJGUFrO0PqfcEsNBswhK3guNIrl036Q8dkS7F2ReaJ0OOROkaOkIwBJOxxgS6
	 G+Ccmf4dorxF51RDeLTQpuAdAMF6eWjISs6fe6eiReheVmN9EV2E/eniMT6zJKzv6//IZ
	 cZTxsOxkHZ5rLTrWvUh6m8rN8hJrm4VVLEc/Gj0Q7IL82ls+9KmO3H/q+XUMfE/v2yivc
	 rVDDAdJfe48tzs386oyjrmFB9ygnGw57jTvMJOEaJxFmaP3AmLffEPzUW8p3cMw6dwfc1
	 /gPBuaTDSO6AOOvjIHbl9fl6psvV4q5+wI5lgrsuZ++nVmJlH+MPgjIDEuPg5PPY7TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TREWtcn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E32606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TREWtcn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B261F0089F;
	Sat,  7 Nov 2026 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048701;
	bh=0D5iegoNJToxft5zbf7AeiECcNrKYRRpx3j3MWJJOdY=;
	h=From:To:Cc:Subject:Date;
	b=TREWtcn97EbO69EoPSxYQpqX3ugieKnaTNIP3BVK5xVtfi1k+yu3QVWlopdVa3prO
	 J2zM7Oi5Fjq4HKkyjaIyd9LPXwsD3+4jrSqe0oHen+VuYntcU8cI2cpQP9cIjHQw0y
	 GDKSDgorHKFdczJIYUYmuwDu5JauMqPC8jeFYmEnrZg+iWBOPyXtwX03SmbEbjDfMO
	 y8ysXyb3v2gwsmD+vrkwImZN6Du7PaXEkbH5FkiE5sFK9+8gKb7zT1oe+KJeGKYbQv
	 1Rqbyge0l5+XpY8QMamej/fAGWPx8VYI8fFEwt8f4uu7Zth4YxQXH84ASzF20f/HqI
	 Kcs8IOx2ITgRg==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	hyc.lee@gmail.com,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: fix volume flag update races" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:39 -0500
Message-ID: <20261107055139-failed-6.1-56a64ee0f99d@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 56a64ee0f99d4ca1756cf743f951c110d39401e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055139-failed-6.1-56a64ee0f99d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




