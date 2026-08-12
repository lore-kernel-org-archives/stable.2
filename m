Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4F21D5B0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497536; cv=none; b=kIdw5YnSILeIPJW7KdY4hS1lEtvVOfMy12JAjECf2DWcghlSq9XqlAQjoa/uwM7/j6tzxEUMNq0Z9xmSgyrys9QVWVcPR2TTC+jYVWeM3O448B1p49PNgTQ/kLm2LDXiayQv/qs8jNPS1098VamgHsxPDJwCFGAiopHd4GrNCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497536; c=relaxed/simple;
	bh=/Y+lXLOFeRWAKC9koaOIiHhomBegND/rorTLuLkD26c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXK2Lao2XYQmx7Lrh+ldoA1DBsN18hd4IwcdNghOXzq0iZuv02oOZQna18UJG9z+dJfU0N+1QvDHHm2jx3FL9UCkOYVk38OXsWZ9O95r3SaiV07ytFqOFWqd2AAY230d8r0o4KH89XLKPUNJ+0Eoru/e2FFcoaiQevpLUMdd8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+b8JXT8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+b8JXT8"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1249795a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497534; x=1787102334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAia8xdnjCEaeMsucsxHi+0mlEUE2cvY0I5YE6bGep0=;
        b=N+b8JXT8D8Y7J5WzBx5L38wRAeOlQF3GQg/vNlGu9i+74vDwq60cOYlFRKz5zP8yAv
         nYALRbOX6rELMPBaiORrfaAga1pA+zMddXtZRPrPSvkTcl45+wVrm2J5UufhV4+Ggcc1
         ybFtCLd8//wkQncQcnaLJhbGqidHu+Pc20UmnPnkQ3rxCPpLO9fM0holRqduKU46fFLR
         YnUbM34fbZH6qVy34sfTFkXpY0Ozyz4rVhfx8znpMfRJQtzEiYsDcK8vkglKnqvC4HLG
         XJ4VZDY/d+xxE0+PrsVbmgrgKXxd6+0J8jlV4bReNNHnMn6VcVg3zooc8nTxMp11JDAS
         o4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497534; x=1787102334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAia8xdnjCEaeMsucsxHi+0mlEUE2cvY0I5YE6bGep0=;
        b=OmgiGYMQ449dr1Gf663ygxX0y/tEI0f3D6m3Sn/ZE9FnkGt9gW04FQPtizKNMAHKQz
         jqAq4WARRzYlVX5lBFMcn2wT0OrfuGeFAUwWnpc2Sr/QZQ9Gyt1SsiywOG95EpUfzs5B
         8UPtg94dozqxbLFor1oZGy+ktgbUVDnHuWGE2oiiTvK0npRcNubnQLFbDzRdPp66h0cf
         DmTTgm3ySzMbpNeyUtRKVwXaJLTeL1C3M1KvVwwsZz5Q6swqZillZbdvWxxWslGUwXHx
         baDpDUvShe+uobP0JkA3mTExwywqO7CCJ9wm07Vc63awT5+EaayHZ5R9mqLThhjEp9zo
         oBlw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3tNb5kvU8y6hTZRtpUp1P8oI0dU7IwvbS72k7P4AXh9y+09cWr0EVg8Mw8qCr3gMhOD0Xx14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjhhiSZVh7AHsPJmz9E+R9SpfavOQeLeAODZhhkPZw8pjTKm8
	JExx1JRdUFBQzdykwyJZvZHdhrWSjSG+SrfTv+iO6M9U4vG1ODVXpA4B
X-Gm-Gg: AR+sD12flExl3yCxcJsfvr2iuH1ZcnBh2BRB6vFJnunns0AYbdbGQVt1gKq1JjpjsjK
	7ooriECPL4Ih3Gcp9F7f/eZaiEwlsgStc0DHG0HsBJJFx4DFggp7QwbwylZgno0MzXWHa7WZ/7V
	9OhNOMq2BlHOgeD3K9UitfWZwEihhxY/5SY6sJaLSSAkKXVVW6WtU7U/CahawXFLJXun+qF/KH3
	ymCIlYBVAMU0kt3UD3+jaThzUCM6LZNn7m91pgG2fdTbkwdQRfGBnTTvC58f5fDzHJZXkP/bo5k
	QE+y2P3njfsl4Fn7c+Z3Dvk51pRumZzjFcTGAs4vEqqkx9dynRqOSO4jjquRfGy5QD8RrkaX4ca
	ta7kwJ6YG93Gh9cTzbt0Sz3NXIC2Z9w5s5Xx7RnWxC3Z/MD8/UJZhc0zHThtsQEZjSLYZl6JvOd
	P+fUHttRjQCpOt+ISeZLsm2MRH90wS2Y51gLJGjDbxRsaRMzd7T03i5zO+m1jpTjt40dA=
X-Received: by 2002:a17:90b:3c41:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39302b08239mr452855a91.10.1786497533812;
        Tue, 11 Aug 2026 18:18:53 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8901c1bsm1549721a91.8.2026.08.11.18.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:18:52 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 3/4] ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
Date: Wed, 12 Aug 2026 10:18:11 +0900
Message-ID: <20260812-topic-attr-list-lock-v6-v7-3-2f35e0a38bfb@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
References: <20260812-topic-attr-list-lock-v6-v7-0-2f35e0a38bfb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: 8bit

ntfs_attr_record_rm() and ntfs_inode_add_attrlist() update the
in-memory attribute list without any lock, so a concurrent reader can
observe an inconsistent trio. Teardown can also free a buffer that a
concurrent ntfs_attrlist_entry_add()/rm() transaction still owns while
it sleeps in ntfs_attrlist_update().

Protect both functions with attr_list_persist_lock for their whole
publish/persist or teardown sequence, and with attr_list_lock (write)
around the actual buffer pointer/size/gen updates.

Take attr_list_persist_lock for every non-$ATTRIBUTE_LIST removal even
when no list is currently present, so creation cannot publish a stale
entry after the initial state check. Initialize the shared removal
result for successful paths, and route all attribute-list creation
failures through a common unlock path.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 fs/ntfs/attrib.c   | 141 ++++++++++++++++++++++++++++++++++++++++++-----------
 fs/ntfs/attrib.h   |   2 +-
 fs/ntfs/attrlist.c |  34 ++++++-------
 fs/ntfs/attrlist.h |   2 +-
 fs/ntfs/index.c    |  23 +++++++--
 fs/ntfs/inode.c    |  33 ++++++++++---
 fs/ntfs/namei.c    |   2 +-
 fs/ntfs/super.c    |   2 +-
 8 files changed, 179 insertions(+), 60 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ef918a73fb0c..e52acbced9c5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2801,16 +2801,20 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 
 /*
  * ntfs_attr_record_rm - remove attribute extent
- * @ctx:	search context describing the attribute which should be removed
+ * @ctx:		search context describing the attribute which should be removed
+ * @persist_locked:	true if the caller already holds
+ *			base_ni->attr_list_persist_lock for the in-flight
+ *			transaction this removal is part of
  *
  * If this function succeed, user should reinit search context if he/she wants
  * use it anymore.
  */
-int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
+int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx, bool persist_locked)
 {
 	struct ntfs_inode *base_ni, *ni;
 	__le32 type;
-	int err;
+	int err = 0;
+	bool attrlist_locked = persist_locked;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->mrec || !ctx->attr)
 		return -EINVAL;
@@ -2825,10 +2829,17 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 	else
 		base_ni = ctx->ntfs_ino;
 
+	/* Keep ALE removal and the follow-up need check in one transaction. */
+	if (!attrlist_locked && type != AT_ATTRIBUTE_LIST) {
+		mutex_lock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = true;
+	}
+
 	/* Remove attribute itself. */
 	if (ntfs_attr_record_resize(ctx->mrec, ctx->attr, 0)) {
 		ntfs_debug("Couldn't remove attribute record. Bug or damaged MFT record.\n");
-		return -EIO;
+		err = -EIO;
+		goto out_unlock;
 	}
 	mark_mft_record_dirty(ni);
 
@@ -2837,19 +2848,42 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 	 * delete $ATTRIBUTE_LIST itself.
 	 */
 	if (NInoAttrList(base_ni) && type != AT_ATTRIBUTE_LIST) {
-		err = ntfs_attrlist_entry_rm(ctx);
+		err = ntfs_attrlist_entry_rm_locked(ctx);
 		if (err) {
 			ntfs_debug("Couldn't delete record from $ATTRIBUTE_LIST.\n");
-			return err;
+			goto out_unlock;
 		}
 	}
 
 	/* Post $ATTRIBUTE_LIST delete setup. */
 	if (type == AT_ATTRIBUTE_LIST) {
+		/*
+		 * attr_list_persist_lock serializes this in-memory attr_list
+		 * teardown against a concurrent ntfs_attrlist_entry_add()/rm()
+		 * transaction on the same inode.
+		 *
+		 * @persist_locked is true when we got here from
+		 * ntfs_attr_update_mapping_pairs() rebuilding the mapping
+		 * pairs of the $ATTRIBUTE_LIST attribute itself: that call
+		 * only happens underneath ntfs_attrlist_update_locked(), which
+		 * is always invoked while already holding this same mutex for
+		 * the in-flight transaction. Taking it again here would
+		 * deadlock the caller against itself, so skip the
+		 * (re-)acquisition in that case and rely on the lock already
+		 * held further up the stack.
+		 */
+		if (!persist_locked)
+			mutex_lock(&base_ni->attr_list_persist_lock);
+		down_write(&base_ni->attr_list_lock);
 		if (NInoAttrList(base_ni) && base_ni->attr_list)
 			kvfree(base_ni->attr_list);
 		base_ni->attr_list = NULL;
+		base_ni->attr_list_size = 0;
+		base_ni->attr_list_gen++;
 		NInoClearAttrList(base_ni);
+		up_write(&base_ni->attr_list_lock);
+		if (!persist_locked)
+			mutex_unlock(&base_ni->attr_list_persist_lock);
 	}
 
 	/* Free MFT record, if it doesn't contain attributes. */
@@ -2857,17 +2891,18 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 			le16_to_cpu(ctx->mrec->attrs_offset) == 8) {
 		if (ntfs_mft_record_free(ni->vol, ni)) {
 			ntfs_debug("Couldn't free MFT record.\n");
-			return -EIO;
+			err = -EIO;
+			goto out_unlock;
 		}
 		/* Remove done if we freed base inode. */
 		if (ni == base_ni)
-			return 0;
+			goto out_unlock;
 		ntfs_inode_close(ni);
 		ctx->ntfs_ino = ni = NULL;
 	}
 
 	if (type == AT_ATTRIBUTE_LIST || !NInoAttrList(base_ni))
-		return 0;
+		goto out_unlock;
 
 	/* Remove attribute list if we don't need it any more. */
 	if (!ntfs_attrlist_need(base_ni)) {
@@ -2878,7 +2913,7 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 		if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, CASE_SENSITIVE,
 					0, NULL, 0, ctx)) {
 			ntfs_debug("Couldn't find attribute list. Succeed anyway.\n");
-			return 0;
+			goto out_unlock;
 		}
 		/* Deallocate clusters. */
 		if (ctx->attr->non_resident) {
@@ -2889,16 +2924,16 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 					ctx->attr, NULL, &new_rl_count);
 			if (IS_ERR(al_rl)) {
 				ntfs_debug("Couldn't decompress attribute list runlist. Succeed anyway.\n");
-				return 0;
+				goto out_unlock;
 			}
 			if (ntfs_cluster_free_from_rl(base_ni->vol, al_rl))
 				ntfs_debug("Leaking clusters! Run chkdsk. Couldn't free clusters from attribute list runlist.\n");
 			kvfree(al_rl);
 		}
 		/* Remove attribute record itself. */
-		if (ntfs_attr_record_rm(ctx)) {
+		if (ntfs_attr_record_rm(ctx, true)) {
 			ntfs_debug("Couldn't remove attribute list. Succeed anyway.\n");
-			return 0;
+			goto out_unlock;
 		}
 
 		na.mft_no = VFS_I(base_ni)->i_ino;
@@ -2914,7 +2949,10 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 		}
 
 	}
-	return 0;
+out_unlock:
+	if (attrlist_locked && !persist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
+	return err;
 }
 
 /*
@@ -3545,6 +3583,12 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
  * ntfs_attr_record_move_to - move attribute record to target inode
  * @ctx:	attribute search context describing the attribute record
  * @ni:		opened ntfs inode to which move attribute record
+ *
+ * Caller must hold the base inode's attr_list_persist_lock: this rewrites
+ * the moved attribute's ALE in place, and that mutation has to be part of
+ * the same transaction as the persist that follows it.  Otherwise a
+ * concurrent ntfs_attrlist_update_locked() can copy the attribute list to
+ * disk while only one of @mft_reference/@instance has been updated.
  */
 int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni)
 {
@@ -3627,6 +3671,8 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	a = (struct attr_record *)nctx->attr;
 	base_ni = ntfs_attr_ctx_base_ni(ctx);
 
+	lockdep_assert_held(&base_ni->attr_list_persist_lock);
+
 	down_write(&base_ni->attr_list_lock);
 	ale = ntfs_attrlist_find_exact_locked(base_ni, &ctx->al_exact);
 	if (!ale) {
@@ -4049,7 +4095,14 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 					ntfs_debug("Attribute list is too big. Defragment the volume\n");
 					return -ENOSPC;
 				}
-				if (ntfs_attrlist_update(base_ni))
+				/*
+				 * This call is only ever reached while
+				 * rebuilding the $ATTRIBUTE_LIST attribute's
+				 * own mapping pairs, which happens underneath
+				 * ntfs_attrlist_update_locked() while holding
+				 * persist lock.
+				 */
+				if (ntfs_attrlist_update_locked(base_ni))
 					return -EIO;
 				goto retry;
 			}
@@ -4185,8 +4238,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
 					NTFS_VCN_DELETE_MARK)
 				continue;
-			/* Remove unused attribute record. */
-			err = ntfs_attr_record_rm(ctx);
+			/*
+			 * Remove unused attribute record. When @ni is the
+			 * $ATTRIBUTE_LIST attribute itself, we only get here
+			 * underneath ntfs_attrlist_update_locked(), whose
+			 * caller already holds
+			 * base_ni->attr_list_persist_lock for this
+			 * transaction, so tell ntfs_attr_record_rm() not to
+			 * recurse into it.
+			 */
+			err = ntfs_attr_record_rm(ctx, ni->type == AT_ATTRIBUTE_LIST);
 			if (err) {
 				ntfs_error(sb, "Could not remove unused attr");
 				goto put_err_out;
@@ -5014,30 +5075,42 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	 */
 	if (attr_ni->type == AT_STANDARD_INFORMATION ||
 	    attr_ni->type == AT_ATTRIBUTE_LIST) {
+		/*
+		 * Resizing the $ATTRIBUTE_LIST attribute itself only happens
+		 * underneath ntfs_attrlist_update_locked() while already holding
+		 * attr_list_persist_lock.
+		 */
+		bool persist_locked = attr_ni->type == AT_ATTRIBUTE_LIST;
+
 		ntfs_attr_put_search_ctx(ctx);
 
 		if (!NInoAttrList(base_ni)) {
+			/* This takes attr_list_persist_lock on its own. */
 			err = ntfs_inode_add_attrlist(base_ni);
 			if (err)
 				return err;
 		}
 
+		/*
+		 * ntfs_inode_free_space() moves attributes out of the base MFT
+		 * record, rewriting their ALEs in place.  Keep those mutations
+		 * and the persist below inside one transaction.
+		 */
+		if (!persist_locked)
+			mutex_lock(&base_ni->attr_list_persist_lock);
+
 		err = ntfs_inode_free_space(base_ni, sizeof(struct attr_record));
 		if (err) {
+			if (!persist_locked)
+				mutex_unlock(&base_ni->attr_list_persist_lock);
 			err = -ENOSPC;
 			ntfs_error(sb,
 				"Couldn't free space in the MFT record to make attribute list non resident");
 			return err;
 		}
-		/*
-		 * Resizing the $ATTRIBUTE_LIST attribute itself only happens
-		 * underneath ntfs_attrlist_update_locked() while already holding
-		 * attr_list_persist_lock.
-		 */
-		if (attr_ni->type == AT_ATTRIBUTE_LIST)
-			err = ntfs_attrlist_update_locked(base_ni);
-		else
-			err = ntfs_attrlist_update(base_ni);
+		err = ntfs_attrlist_update_locked(base_ni);
+		if (!persist_locked)
+			mutex_unlock(&base_ni->attr_list_persist_lock);
 		if (err)
 			return err;
 		goto attr_resize_again;
@@ -5085,15 +5158,27 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	}
 	unmap_mft_record(ext_ni);
 
+	/*
+	 * Move the attribute and persist the resulting attribute list as one
+	 * transaction, so the ALE rewritten by ntfs_attr_record_move_to()
+	 * cannot be copied to disk half-updated.  attr_ni->type is neither
+	 * $STANDARD_INFORMATION nor $ATTRIBUTE_LIST here (both are handled
+	 * above), so we cannot already hold the lock via
+	 * ntfs_attrlist_update_locked().
+	 */
+	mutex_lock(&base_ni->attr_list_persist_lock);
+
 	/* Move attribute to it. */
 	err = ntfs_attr_record_move_to(ctx, ext_ni);
 	if (err) {
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 		ntfs_error(sb, "Couldn't move attribute to new MFT record");
 		err = -ENOMEM;
 		goto put_err_out;
 	}
 
-	err = ntfs_attrlist_update(base_ni);
+	err = ntfs_attrlist_update_locked(base_ni);
+	mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (err < 0)
 		goto put_err_out;
 
@@ -5454,7 +5539,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 	}
 	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
-		err = ntfs_attr_record_rm(ctx);
+		err = ntfs_attr_record_rm(ctx, false);
 		if (err) {
 			ntfs_error(sb,
 				"Failed to remove attribute extent. Leaving inconstant metadata.\n");
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 2e5f87abd852..ec0c846febf1 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -161,7 +161,7 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len);
 int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len);
-int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx);
+int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx, bool persist_locked);
 int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni);
 int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 		__le16 *name, u8 name_len, u8 *val, s64 size);
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index aa6d5f10bf96..bdea09efe284 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -117,23 +117,6 @@ int ntfs_attrlist_update_locked(struct ntfs_inode *base_ni)
 	return 0;
 }
 
-/*
- * ntfs_attrlist_update - persist the in-memory attribute list to disk
- * @base_ni:	base ntfs inode containing the attribute list
- *
- * Serialize the persist against concurrent attribute-list replacement
- * transactions.
- */
-int ntfs_attrlist_update(struct ntfs_inode *base_ni)
-{
-	int err;
-
-	mutex_lock(&base_ni->attr_list_persist_lock);
-	err = ntfs_attrlist_update_locked(base_ni);
-	mutex_unlock(&base_ni->attr_list_persist_lock);
-	return err;
-}
-
 /*
  * ntfs_attrlist_entry_add - add an attribute list attribute entry
  * @ni:	opened ntfs inode, which contains that attribute
@@ -328,7 +311,7 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
  *
  * Return 0 on success and -errno on error.
  */
-int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
+int ntfs_attrlist_entry_rm_locked(struct ntfs_attr_search_ctx *ctx)
 {
 	u8 *new_al = NULL;
 	int err, new_al_len;
@@ -356,7 +339,7 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		ntfs_debug("Attribute list isn't present.\n");
 		return -ENOENT;
 	}
-	mutex_lock(&base_ni->attr_list_persist_lock);
+	lockdep_assert_held(&base_ni->attr_list_persist_lock);
 
 	/*
 	 * Another thread may have removed the attribute list while we were
@@ -414,6 +397,19 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 	kvfree(old_al);
 	err = 0;
 out_unlock:
+	return err;
+}
+
+int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
+{
+	struct ntfs_inode *base_ni;
+	int err;
+
+	if (!ctx || !ctx->ntfs_ino)
+		return -EINVAL;
+	base_ni = ctx->base_ntfs_ino ? ctx->base_ntfs_ino : ctx->ntfs_ino;
+	mutex_lock(&base_ni->attr_list_persist_lock);
+	err = ntfs_attrlist_entry_rm_locked(ctx);
 	mutex_unlock(&base_ni->attr_list_persist_lock);
 	return err;
 }
diff --git a/fs/ntfs/attrlist.h b/fs/ntfs/attrlist.h
index ecb8a8c957fa..ccf61971c01e 100644
--- a/fs/ntfs/attrlist.h
+++ b/fs/ntfs/attrlist.h
@@ -15,7 +15,7 @@
 int ntfs_attrlist_need(struct ntfs_inode *ni);
 int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr);
 int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx);
-int ntfs_attrlist_update(struct ntfs_inode *base_ni);
+int ntfs_attrlist_entry_rm_locked(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attrlist_update_locked(struct ntfs_inode *base_ni);
 
 #endif /* defined _NTFS_ATTRLIST_H */
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 082fe9226c72..8c44ec25c2a2 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1348,18 +1348,35 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	 */
 	if ((ret == -ENOSPC) &&
 	    (ctx->al_cursor.valid || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+		struct ntfs_inode *base_ni;
+
 		ntfs_attr_put_search_ctx(ctx);
 		ctx = NULL;
 		ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
-		if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
+		if (!ir)
+			goto clear_bmp;
+
+		base_ni = ctx->base_ntfs_ino ? ctx->base_ntfs_ino : ctx->ntfs_ino;
+		/*
+		 * ntfs_attr_record_move_away() rewrites the moved attribute's
+		 * ALE in place, so it and the persist below have to form one
+		 * transaction.  Nothing up this call chain holds the lock:
+		 * ntfs_inode_add_attrlist() above takes it on its own, and
+		 * ntfs_attrlist_update_locked() never reaches index code.
+		 */
+		mutex_lock(&base_ni->attr_list_persist_lock);
+		if (!ntfs_attr_record_move_away(ctx, ix_root_size -
 				le32_to_cpu(ctx->attr->data.resident.value_length))) {
-			if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
-						 ctx->base_ntfs_ino : ctx->ntfs_ino))
+			if (ntfs_attrlist_update_locked(base_ni)) {
+				mutex_unlock(&base_ni->attr_list_persist_lock);
 				goto clear_bmp;
+			}
+			mutex_unlock(&base_ni->attr_list_persist_lock);
 			ntfs_attr_put_search_ctx(ctx);
 			ctx = NULL;
 			goto retry;
 		}
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	}
 clear_bmp:
 	ntfs_ibm_clear(icx, new_ib_vcn);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index ede16196ed0c..a304a2ca22d8 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3054,14 +3054,20 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 
 	ntfs_debug("inode %llu\n", ni->mft_no);
 
+	/* Serialize the initial state check and attribute-list publication. */
+	mutex_lock(&ni->attr_list_persist_lock);
+
 	if (NInoAttrList(ni) || ni->nr_extents) {
 		ntfs_error(ni->vol->sb, "Inode already has attribute list");
-		return -EEXIST;
+		err = -EEXIST;
+		goto out_unlock;
 	}
 
 	ni_mrec = map_mft_record(ni);
-	if (IS_ERR(ni_mrec))
-		return -EIO;
+	if (IS_ERR(ni_mrec)) {
+		err = -EIO;
+		goto out_unlock;
+	}
 
 	/* Form attribute list. */
 	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec);
@@ -3123,9 +3129,12 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Set in-memory attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
+	ni->attr_list_gen++;
 	NInoSetAttrList(ni);
+	up_write(&ni->attr_list_lock);
 
 	attr_al_len = offsetof(struct attr_record, data.resident.reserved) + 1 +
 		((al_len + 7) & ~7);
@@ -3151,29 +3160,35 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	err = ntfs_attrlist_update_locked(ni);
 	if (err < 0)
 		goto remove_attrlist_record;
-
+	mutex_unlock(&ni->attr_list_persist_lock);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 	return 0;
 
 remove_attrlist_record:
-	/* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = NULL;
+	ni->attr_list_gen++;
 	NInoClearAttrList(ni);
+	up_write(&ni->attr_list_lock);
+
 	/* Remove $ATTRIBUTE_LIST record. */
 	ntfs_attr_reinit_search_ctx(ctx);
 	if (!ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0,
 				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-		if (ntfs_attr_record_rm(ctx))
+		if (ntfs_attr_record_rm(ctx, true))
 			ntfs_error(ni->vol->sb, "Rollback failed to remove attrlist");
 	} else {
 		ntfs_error(ni->vol->sb, "Rollback failed to find attrlist");
 	}
 
 	/* Setup back in-memory runlist. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
+	ni->attr_list_gen++;
 	NInoSetAttrList(ni);
+	up_write(&ni->attr_list_lock);
 rollback:
 	/*
 	 * Scan attribute list for attributes that placed not in the base MFT
@@ -3200,15 +3215,21 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Remove in-memory attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = NULL;
 	ni->attr_list_size = 0;
+	ni->attr_list_gen++;
 	NInoClearAttrList(ni);
 	NInoClearAttrListDirty(ni);
+	up_write(&ni->attr_list_lock);
+
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
 	kvfree(al);
 	unmap_mft_record(ni);
+out_unlock:
+	mutex_unlock(&ni->attr_list_persist_lock);
 	return err;
 }
 
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 96045face63f..09deb96533d1 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -938,7 +938,7 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	if (err)
 		goto err_out;
 
-	err = ntfs_attr_record_rm(actx);
+	err = ntfs_attr_record_rm(actx, false);
 	if (err)
 		goto err_out;
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 8abe7bee4c0d..6d28c4c25a05 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -485,7 +485,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 	ret = ntfs_attr_lookup(AT_VOLUME_NAME, NULL, 0, 0, 0, NULL, 0,
 			       ctx);
 	if (!ret)
-		ret = ntfs_attr_record_rm(ctx);
+		ret = ntfs_attr_record_rm(ctx, false);
 	else if (ret == -ENOENT)
 		ret = 0;
 	ntfs_attr_put_search_ctx(ctx);

-- 
2.43.0

