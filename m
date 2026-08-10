Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72732BE65B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339210; cv=none; b=K0Y3U7EHqoS2bYuFwVmCOr0f/6W17BP93D1cHLcI/z5tzqPsu0pNyGm2givWwXL5dSKrnY4oL8YwYo9ALXIzklrUFRGvGpIuIvMAUGe3Qmu7NRJRgXH0iAUOJsCjgsxED9J+aveLoXbjzNPU1Pc3F6nzQeeGzTfLlmDz1O64aR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339210; c=relaxed/simple;
	bh=1KP0j+Z9Xjfz9CCe8x/jnSsr1HjJjCfNwayy4ADOdqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hssIma5dr92Ngsq4SvY8zeRcm+VFnQIrVm3TABL1UHjE4uFyfq16eyVNlZztpdFrkLJmXaU06FYRBphsKadij8owWCHamC1kN74xrLyyH966JXEmAxVo4apJCmdgBBUdsF0pdbxZr8FAXTOTXFnSJK/FKDPnJ1HkhZP02pXeunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwcDqLZ3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwcDqLZ3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d032846c95so18269865ad.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786339208; x=1786944008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWXz/e0n5lm+MT92XILqIlrqg25Ed4hmuECxqi4QCyA=;
        b=JwcDqLZ3LvRoNyEOQgo+tF3VHRhdN1MtS1Cpbp7+mtidLBhgLkp3JWfKJuO894zfKo
         OfV2vLNGTiIfgxgBQ27kjpbmGaNnwjODPFsyvC99nOILuZ0RWkM0fDXjAJhRF8jvgjn/
         Vz+TcWeKsvwtyGYQAQHIMezmTfWi8U6Z0PesdX5K1SOMGMU+Eqq5R3Gg5qnQJKNKvN45
         rw07kVMKi9wP9+eK+QOP8dMkc+48rvY/odABDGQBSmCselPnLde+zkopS/1qOTTWPuUx
         aDh8lR6cK7+vdmY2rbM/B2Vg6gQSI+TI1hk+5m3zrbuYAsSp7Vn339tCcWlyGWBzRtve
         FXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786339208; x=1786944008;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWXz/e0n5lm+MT92XILqIlrqg25Ed4hmuECxqi4QCyA=;
        b=eib4Okba1dexaZRcVTMqRkXdtxClU7yy1zOm2StuFi49XVc9eqlICjScV0tfmnsO2H
         6LovCYU47g5XTMamo/2LsKsPeJUW/hY7/Nmu6KxqfN5H66ighH4XZFaUI8neVnAEvz8R
         SN1yc0yFe7wommIVsaRQKTuz+sDhRtjuvSfKCNO6BOdNtuSBLG0PSZakm/VQKald9m+3
         jTBicLcYfX2HCLNYMaXzKV4380dzHIziHki6yzP5hcZ2XnZ2nPLHY/90g9aFHz6x4gsX
         1IUj/NM6oBi8egr3pAo4NouMmTtib59AjZDwjZ9CapLitMl+LeDriPYcDSB5R8Osrbo/
         GILg==
X-Forwarded-Encrypted: i=1; AHgh+RpKnFyi92bPd+Mkal6le8gNU5x1Cb5NdQnBBNNq9pJ3/NBP/XJS705pezyeUz1Ou3UTl/PQv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUzzX/26e8GPC/Qpx+uYVuUz4U/E0VsoGAoSLkWDUN1hOxQky
	3+bzwrMctJk1gcciQjjaa5wD2YoYbFerXP9yq2WsSICzXna1oKNotbGo
X-Gm-Gg: AR+sD13TZqCiZd7jnGIexk5xRrYZ/49vJB9PKk67AyuljZImW+JFMasSDUyVIpScpQE
	xp+me7KX/Mg7qhCyUme+/0cGGmZgJgkoRlMfVumGve6jZPo9qCvqZ50ipXSdYLtqLnxNT+INwJ6
	im0PzfJpQpHNAWRrCjU4a4ua0SGxksy0yd36U/MRR4E1DeY00Dm2Kdus6+brXcq148TaZsAC+6W
	VisTzDgh/mzkr+e63HIeaVZxJpteFGLXuSITs3DMFIJ9Vmwssy5yvQLPfaSFG1+nQN9pdf+8lSz
	xK9OXmt85xZCNe0o5gfZbDm58bD0JWJlfLF8OlUK2Ms3/h0tMuGa1mxdrv/RzfQuS8x4YxDK1bu
	WlwVgZ06GTcCzFhxA953IBOdNoh0xJf8EG34wMLweoNXjmMFeOOOkV/OfS4usKD2SSZquS7yOk3
	qT3vhvWzF6hMNU8WfDPkmy9Op7+XwSvBkjNCdmIQq/lRdhQDCUBd2Yr8S/pjgwuD1ylhOnUIQ1j
	237tkM=
X-Received: by 2002:a17:903:17c3:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2d0ca165189mr476837175ad.0.1786339207834;
        Sun, 09 Aug 2026 22:20:07 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac191sm28749235ad.15.2026.08.09.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:20:07 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 3/4] ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
Date: Mon, 10 Aug 2026 14:19:40 +0900
Message-ID: <20260810-topic-attr-list-lock-v6-v6-3-e3fb8c4494d3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810-topic-attr-list-lock-v6-v6-0-e3fb8c4494d3@gmail.com>
References: <20260810-topic-attr-list-lock-v6-v6-0-e3fb8c4494d3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20987; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=1KP0j+Z9Xjfz9CCe8x/jnSsr1HjJjCfNwayy4ADOdqY=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqeV3dONvdYCteqVsYmcBa86mjEm1HBLy4amN1P
 l7gHNs15BGJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCanld3QAKCRA08jD6945I
 08EcEACXwSAiDNS84nyLHOHZBo4VwRzwhdkaWXy4iAKMu0AAU/Q/6MW0CbaMG8OWSL9ZCw/rGaF
 QhOLGM4S4xkmu1rChnGmrEG5McNGWtj5FLTuvDK5ZLEVgZbcFlRZjBxCBRYRzywTGF0z5T+Fegp
 Fb0NCqEfmrxye1IFNKOXvS9Jd6if5dxmpgKR9GQGxxHOmAgM5lHdFHltd9+N2CwXxUOsJbp2xdP
 2nbAE7/nUrlp7qHLc3QvCi3tkCBt23Cg1onkHlxIET0e88wKcWlz3BNN/E9MG2Pzhvwio2oV/lp
 CJ7f75N0nPdwoYcnckndTYIMrLvuTRyUlEw2AKLQC/Uy4w3tJT/Q3UwmkxC0CiSyyH8wo3rjUjo
 oQ+LDpfZFF6UU/IU0lqlqCuIqhUkTYFaKnXOmvNvvfsjDRxkISCa1lZQA+zZpcfHKF0NoiUNLg7
 rqM2CnQu1FG6uAbHEVKtvPaJSWKpNJ++GhIa1n345bl3YwhZi3O6XyviwSKLMStG6oABOK+EslQ
 nNlJSyLw6gIfPfLY7UvSTzY11tyXfS+Rib1iTEfdEIizOFsmHk1/R+6b+/nGLSSlIcesig9X4DP
 UhuGPeoNSAZycn2kjR6tJH6hRSRxyiRHSD4k130rNZkKkkpyU/EygqyuieXYAaziopVA8FEsDWt G1PO+Wf2IeDCXzA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

ntfs_attr_record_rm() and ntfs_inode_add_attrlist() update the
in-memory attribute list without any lock, so a concurrent reader can
observe an inconsistent trio. Teardown can also free a buffer that a
concurrent ntfs_attrlist_entry_add()/rm() transaction still owns while
it sleeps in ntfs_attrlist_update().

Protect both functions with attr_list_persist_lock for their whole
publish/persist or teardown sequence, and with attr_list_lock (write)
around the actual buffer pointer/size/gen updates.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c   | 140 ++++++++++++++++++++++++++++++++++++++++++-----------
 fs/ntfs/attrib.h   |   2 +-
 fs/ntfs/attrlist.c |  34 ++++++-------
 fs/ntfs/attrlist.h |   2 +-
 fs/ntfs/index.c    |  23 +++++++--
 fs/ntfs/inode.c    |  27 ++++++++++-
 fs/ntfs/namei.c    |   2 +-
 fs/ntfs/super.c    |   2 +-
 8 files changed, 177 insertions(+), 55 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ef918a73fb0c..f45f0289e3d3 100644
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
 	int err;
+	bool attrlist_locked = persist_locked;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->mrec || !ctx->attr)
 		return -EINVAL;
@@ -2825,10 +2829,18 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 	else
 		base_ni = ctx->ntfs_ino;
 
+	/* Keep ALE removal and the follow-up need check in one transaction. */
+	if (!attrlist_locked && type != AT_ATTRIBUTE_LIST &&
+	    NInoAttrList(base_ni)) {
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
 
@@ -2837,19 +2849,42 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
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
@@ -2857,17 +2892,18 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
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
@@ -2878,7 +2914,7 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 		if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, CASE_SENSITIVE,
 					0, NULL, 0, ctx)) {
 			ntfs_debug("Couldn't find attribute list. Succeed anyway.\n");
-			return 0;
+			goto out_unlock;
 		}
 		/* Deallocate clusters. */
 		if (ctx->attr->non_resident) {
@@ -2889,16 +2925,16 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
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
@@ -2914,7 +2950,10 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 		}
 
 	}
-	return 0;
+out_unlock:
+	if (attrlist_locked && !persist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
+	return err;
 }
 
 /*
@@ -3545,6 +3584,12 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
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
@@ -3627,6 +3672,8 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 	a = (struct attr_record *)nctx->attr;
 	base_ni = ntfs_attr_ctx_base_ni(ctx);
 
+	lockdep_assert_held(&base_ni->attr_list_persist_lock);
+
 	down_write(&base_ni->attr_list_lock);
 	ale = ntfs_attrlist_find_exact_locked(base_ni, &ctx->al_exact);
 	if (!ale) {
@@ -4049,7 +4096,14 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4185,8 +4239,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -5014,30 +5076,42 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
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
@@ -5085,15 +5159,27 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
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
 
@@ -5454,7 +5540,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
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
index ede16196ed0c..f62d72857558 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3048,14 +3048,20 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	struct attr_list_entry *ale = NULL;
 	struct mft_record *ni_mrec;
 	u32 attr_al_len;
+	bool attrlist_locked = false;
 
 	if (!ni)
 		return -EINVAL;
 
 	ntfs_debug("inode %llu\n", ni->mft_no);
 
+	/* Serialize the initial state check and attribute-list publication. */
+	mutex_lock(&ni->attr_list_persist_lock);
+	attrlist_locked = true;
+
 	if (NInoAttrList(ni) || ni->nr_extents) {
 		ntfs_error(ni->vol->sb, "Inode already has attribute list");
+		mutex_unlock(&ni->attr_list_persist_lock);
 		return -EEXIST;
 	}
 
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
@@ -3152,28 +3161,36 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	if (err < 0)
 		goto remove_attrlist_record;
 
+	mutex_unlock(&ni->attr_list_persist_lock);
+	attrlist_locked = false;
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
@@ -3200,10 +3217,16 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
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
+	if (attrlist_locked)
+		mutex_unlock(&ni->attr_list_persist_lock);
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
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

