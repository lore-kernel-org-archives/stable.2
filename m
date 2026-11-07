Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049750;
	b=WzREJ79k4aMmCWfRF3ArgRM8jLz8PKKqPKZlsYLqeJcQA2NHWts/QWBdKCQX9Mjv0ou9
	 4etWk21OX0h5Mqjuwy6mtJHlKrECeuIwyexV6LJwo0od5zV175mXEUNrkrVeQ/iMehbK3
	 QXHB3sIoZ9PsY7PSk/niwsq081m7SQqIgLJrLzq6CTUDRBi2GwULD++5dF6nfDxITeVu9
	 EroItKC4foQipBedZU+5jm3svbf+MdMRAKTpA/xjsHFcibVcLli2lzYcXSVyUC8RxWoLR
	 WJbQNB+14JRDvxJ4Axy91mjDgb1dw0MPBRwi0yZBRDrEdow/UDytGGMAYmP8/T6uqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PG21dteEtOL+t4Ov8msRntgkXy2JUvi5QxgwROLJJ1o=;
	b=BybEMK7fUCqRR4s7KTrcKKNJ0B2AaYJGcHY6QW6oXuKwKRfU0xMGAOXubjkUDZcmWqnB
	 8jcUOpSs2uA6EMKI+O18IHdVk0fsGIPMwjeVanh6qXm9G1hB7O5jQrkTPS+vOS1+PyWYd
	 sE496IT+WQ0f28OTbb9/KCT1uArk/wNXfmLF3/mcp/qnE8DGWjbJ7OTfFGDV9YjAd/EzR
	 9BjH3ikBu1QaEJbC0IJQ4ZqVUe/jPeeDxNVKzrAtaejmFQFFTC/DiwIF85yXtDfmPSkfX
	 /+dNjlamC7c0/F9ZtqWgZ4KG1yvNbF4t2/Pe5zVUt9ueWHS8pP8LS9EDS6NvKn2c9QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2J8PVO1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9354606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2J8PVO1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A56D1F008A1;
	Sat,  7 Nov 2026 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049749;
	bh=PG21dteEtOL+t4Ov8msRntgkXy2JUvi5QxgwROLJJ1o=;
	h=From:To:Cc:Subject:Date;
	b=i2J8PVO1f+3IxwNARidLv/Y7TBNYtYpXy0ky3S6XzyXAoXHEWrWPVdg8pOps9FOA9
	 TBX68N2INq87NVFs2HpLiAaF1xOzvc9I9+KSQ8QeH4u1bPxZB9WIXGZbR7Kui8tqZN
	 Em3DQ6bYEIRwu4aUupNW5U4ZuM6DLo26UPQ0Q1j5l+GtGsyJX9Yr8yciRJfVbLDhnd
	 vrWtpSDmmwCnFyqqh0LHrvI0Cbm9sWU0Ex7aA0Ml10Q3PzhehVdOjRXaFzkWRcsmPn
	 Dd219g3biqZOixHNILf64SwkOEqJB3Me88al3/TMjGE1xam3XFa/nIK777WOCLfw2y
	 Yk9sqY0jktx3g==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: add a runlist merge that leaves the source runlist to the caller" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:09:07 -0500
Message-ID: <20261107060907-failed-5.15-c6ee0986b807@kernel.org>
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
git cherry-pick -x c6ee0986b80715c44d547e9cbdc1a72ad855071c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060907-failed-5.15-c6ee0986b807@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c6ee0986b80715c44d547e9cbdc1a72ad855071c Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Fri, 2 Oct 2026 12:34:58 +0800
Subject: [PATCH] ntfs: add a runlist merge that leaves the source runlist to
 the caller

ntfs_runlists_merge() frees the source runlist once its runs are in the
destination.  A caller that may have to undo the merge then has to work
out its runs again from the merged runlist, where the first and the
last of them may have been coalesced with neighbouring runs.

Add ntfs_runlists_merge_keep_src(), which neither modifies nor frees
the source runlist.  For that, ntfs_rl_append() and ntfs_rl_replace()
now merge the right-hand end into the copied run in the destination
instead of into the last source run before copying it, and the merge
helpers take the source as const, so the compiler checks that none of
them writes to it.  The merged runlist is the same as before.

For every caller, a source runlist without any mapped run, which the
merge already warns about, now fails with -EINVAL instead of carrying
on with nothing to insert: with no run copied, the right-hand merge
into the destination would index before the insertion point.

The next patch uses ntfs_runlists_merge_keep_src() to free exactly the
clusters it allocated when it has to undo an $MFT data extension.

Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Cc: stable@vger.kernel.org # needed by the next patch
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/runlist.c | 98 ++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/runlist.h |  3 ++
 2 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index f13d28c15887d..76ba6ab72b8a6 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -47,7 +47,7 @@ static inline void ntfs_rl_mm(struct runlist_element *base, int dst, int src, in
  * @srcbase.
  */
 static inline void ntfs_rl_mc(struct runlist_element *dstbase, int dst,
-		struct runlist_element *srcbase, int src, int size)
+		const struct runlist_element *srcbase, int src, int size)
 {
 	if (likely(size > 0))
 		memcpy(dstbase + dst, srcbase + src, size * sizeof(*dstbase));
@@ -152,8 +152,8 @@ static inline struct runlist_element *ntfs_rl_realloc_nofail(struct runlist_elem
  * Return: true   Success, the runlists can be merged.
  *	   false  Failure, the runlists cannot be merged.
  */
-static inline bool ntfs_are_rl_mergeable(struct runlist_element *dst,
-		struct runlist_element *src)
+static inline bool ntfs_are_rl_mergeable(const struct runlist_element *dst,
+		const struct runlist_element *src)
 {
 	/* We can merge unmapped regions even if they are misaligned. */
 	if ((dst->lcn == LCN_RL_NOT_MAPPED) && (src->lcn == LCN_RL_NOT_MAPPED))
@@ -186,7 +186,8 @@ static inline bool ntfs_are_rl_mergeable(struct runlist_element *dst,
  *
  * It is up to the caller to serialize access to the runlists @dst and @src.
  */
-static inline void __ntfs_rl_merge(struct runlist_element *dst, struct runlist_element *src)
+static inline void __ntfs_rl_merge(struct runlist_element *dst,
+		const struct runlist_element *src)
 {
 	dst->length += src->length;
 }
@@ -214,10 +215,11 @@ static inline void __ntfs_rl_merge(struct runlist_element *dst, struct runlist_e
  * On error, return -errno. Both runlists are left unmodified.
  */
 static inline struct runlist_element *ntfs_rl_append(struct runlist_element *dst,
-		int dsize, struct runlist_element *src, int ssize, int loc,
+		int dsize, const struct runlist_element *src, int ssize, int loc,
 		size_t *new_size)
 {
 	bool right = false;	/* Right end of @src needs merging. */
+	s64 right_length = 0;	/* Length of the run merged at the right. */
 	int marker;		/* End of the inserted runs. */
 
 	/* First, check if the right hand end needs merging. */
@@ -235,9 +237,9 @@ static inline struct runlist_element *ntfs_rl_append(struct runlist_element *dst
 	 * original runlists.
 	 */
 
-	/* First, merge the right hand end, if necessary. */
+	/* Remember the run that the right hand end absorbs, if any. */
 	if (right)
-		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
+		right_length = dst[loc + 1].length;
 
 	/* First run after the @src runs that have been inserted. */
 	marker = loc + ssize + 1;
@@ -246,6 +248,9 @@ static inline struct runlist_element *ntfs_rl_append(struct runlist_element *dst
 	ntfs_rl_mm(dst, marker, loc + 1 + right, dsize - (loc + 1 + right));
 	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
 
+	/* Merge the right hand end into the copy, leaving @src intact. */
+	dst[marker - 1].length += right_length;
+
 	/* Adjust the size of the preceding hole. */
 	dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
 
@@ -279,7 +284,7 @@ static inline struct runlist_element *ntfs_rl_append(struct runlist_element *dst
  * On error, return -errno. Both runlists are left unmodified.
  */
 static inline struct runlist_element *ntfs_rl_insert(struct runlist_element *dst,
-		int dsize, struct runlist_element *src, int ssize, int loc,
+		int dsize, const struct runlist_element *src, int ssize, int loc,
 		size_t *new_size)
 {
 	bool left = false;	/* Left end of @src needs merging. */
@@ -374,12 +379,13 @@ static inline struct runlist_element *ntfs_rl_insert(struct runlist_element *dst
  * On error, return -errno. Both runlists are left unmodified.
  */
 static inline struct runlist_element *ntfs_rl_replace(struct runlist_element *dst,
-		int dsize, struct runlist_element *src, int ssize, int loc,
+		int dsize, const struct runlist_element *src, int ssize, int loc,
 		size_t *new_size)
 {
 	int delta;
 	bool left = false;	/* Left end of @src needs merging. */
 	bool right = false;	/* Right end of @src needs merging. */
+	s64 right_length = 0;	/* Length of the run merged at the right. */
 	int tail;		/* Start of tail of @dst. */
 	int marker;		/* End of the inserted runs. */
 
@@ -405,9 +411,12 @@ static inline struct runlist_element *ntfs_rl_replace(struct runlist_element *ds
 	 * original runlists.
 	 */
 
-	/* First, merge the left and right ends, if necessary. */
+	/*
+	 * Remember the run that the right hand end absorbs, if any, then
+	 * merge the left hand end.
+	 */
 	if (right)
-		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
+		right_length = dst[loc + 1].length;
 	if (left)
 		__ntfs_rl_merge(dst + loc - 1, src);
 	/*
@@ -432,6 +441,13 @@ static inline struct runlist_element *ntfs_rl_replace(struct runlist_element *ds
 	ntfs_rl_mm(dst, marker, tail, dsize - tail);
 	ntfs_rl_mc(dst, loc, src, left, ssize - left);
 
+	/*
+	 * Merge the right hand end into the last run of @src, now in @dst at
+	 * @marker - 1 (or into @dst[@loc - 1] if that absorbed all of @src),
+	 * leaving @src intact.
+	 */
+	dst[marker - 1].length += right_length;
+
 	/* We may have changed the length of the file, so fix the end marker. */
 	if (dsize - tail > 0 && dst[marker].lcn == LCN_ENOENT)
 		dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
@@ -461,7 +477,7 @@ static inline struct runlist_element *ntfs_rl_replace(struct runlist_element *ds
  * On error, return -errno. Both runlists are left unmodified.
  */
 static inline struct runlist_element *ntfs_rl_split(struct runlist_element *dst, int dsize,
-		struct runlist_element *src, int ssize, int loc,
+		const struct runlist_element *src, int ssize, int loc,
 		size_t *new_size)
 {
 	/* Space required: @dst size + @src size + one new hole. */
@@ -488,11 +504,12 @@ static inline struct runlist_element *ntfs_rl_split(struct runlist_element *dst,
 }
 
 /*
- * ntfs_runlists_merge - merge two runlists into one
+ * __ntfs_runlists_merge - merge two runlists into one
  * @d_runlist: destination runlist structure to merge into
  * @srl: source runlist to merge from
  * @s_rl_count: number of elements in @srl (0 to auto-detect)
  * @new_rl_count: on success, set to the new combined runlist size
+ * @keep_srl: leave @srl to the caller instead of deallocating it
  *
  * First we sanity check the two runlists @srl and @drl to make sure that they
  * are sensible and can be merged. The runlist @srl must be either after the
@@ -515,13 +532,14 @@ static inline struct runlist_element *ntfs_rl_split(struct runlist_element *dst,
  * On success, return a pointer to the new, combined, runlist. Note, both
  * runlists @drl and @srl are deallocated before returning so you cannot use
  * the pointers for anything any more. (Strictly speaking the returned runlist
- * may be the same as @dst but this is irrelevant.)
+ * may be the same as @dst but this is irrelevant.)  If @keep_srl is true,
+ * @srl is neither modified nor deallocated, and @drl must not be NULL.
  *
  * On error, return -errno. Both runlists are left unmodified.
  */
-struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
-				     struct runlist_element *srl, size_t s_rl_count,
-				     size_t *new_rl_count)
+static struct runlist_element *__ntfs_runlists_merge(struct runlist *d_runlist,
+		struct runlist_element *srl, size_t s_rl_count,
+		size_t *new_rl_count, bool keep_srl)
 {
 	int di, si;		/* Current index into @[ds]rl. */
 	int sstart;		/* First index with lcn > LCN_RL_NOT_MAPPED. */
@@ -553,6 +571,8 @@ struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
 
 	/* Check for the case where the first mapping is being done now. */
 	if (unlikely(!drl)) {
+		if (WARN_ON(keep_srl))
+			return ERR_PTR(-EINVAL);
 		drl = srl;
 		/* Complete the source runlist if necessary. */
 		if (unlikely(drl[0].vcn)) {
@@ -582,7 +602,8 @@ struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
 		si++;
 
 	/* Can't have an entirely unmapped source runlist. */
-	WARN_ON(!srl[si].length);
+	if (WARN_ON(!srl[si].length))
+		return ERR_PTR(-EINVAL);
 
 	/* Record the starting points. */
 	sstart = si;
@@ -652,7 +673,8 @@ struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
 		ntfs_error(NULL, "Merge failed.");
 		return drl;
 	}
-	kvfree(srl);
+	if (!keep_srl)
+		kvfree(srl);
 	if (marker) {
 		ntfs_debug("Triggering marker code.");
 		for (ds = dend; drl[ds].length; ds++)
@@ -713,6 +735,44 @@ struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
 	return drl;
 }
 
+/*
+ * ntfs_runlists_merge - merge two runlists into one
+ * @d_runlist: destination runlist structure to merge into
+ * @srl: source runlist to merge from, deallocated on success
+ * @s_rl_count: number of elements in @srl (0 to auto-detect)
+ * @new_rl_count: on success, set to the new combined runlist size
+ *
+ * See __ntfs_runlists_merge().
+ */
+struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
+		struct runlist_element *srl, size_t s_rl_count,
+		size_t *new_rl_count)
+{
+	return __ntfs_runlists_merge(d_runlist, srl, s_rl_count, new_rl_count,
+			false);
+}
+
+/*
+ * ntfs_runlists_merge_keep_src - merge two runlists, keeping the source
+ * @d_runlist: destination runlist structure to merge into, not empty
+ * @srl: source runlist to merge from
+ * @s_rl_count: number of elements in @srl (0 to auto-detect)
+ * @new_rl_count: on success, set to the new combined runlist size
+ *
+ * Like ntfs_runlists_merge(), but @srl is neither modified nor deallocated,
+ * on success or on error, and remains the caller's to kvfree().  Even when
+ * runs of @srl are coalesced with runs of @d_runlist, @srl keeps describing
+ * exactly its own runs, e.g. the clusters a caller has to free to undo the
+ * merge.
+ */
+struct runlist_element *ntfs_runlists_merge_keep_src(struct runlist *d_runlist,
+		struct runlist_element *srl, size_t s_rl_count,
+		size_t *new_rl_count)
+{
+	return __ntfs_runlists_merge(d_runlist, srl, s_rl_count, new_rl_count,
+			true);
+}
+
 /*
  * ntfs_mapping_pairs_decompress - convert mapping pairs array to runlist
  * @vol: ntfs volume
diff --git a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
index cc92e09fbf682..0d4c32b1a338f 100644
--- a/fs/ntfs/runlist.h
+++ b/fs/ntfs/runlist.h
@@ -68,6 +68,9 @@ enum {
 struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
 		struct runlist_element *srl, size_t s_rl_count,
 		size_t *new_rl_count);
+struct runlist_element *ntfs_runlists_merge_keep_src(struct runlist *d_runlist,
+		struct runlist_element *srl, size_t s_rl_count,
+		size_t *new_rl_count);
 struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *vol,
 		const struct attr_record *attr, struct runlist *old_runlist,
 		size_t *new_rl_count);
-- 
2.53.0




