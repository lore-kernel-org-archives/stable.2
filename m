Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF341E6BD
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281952; cv=none; b=CAq4if2eIH2rUcqbdni5f6PJSBwyMRK0hlsLKIwkLHfG/deNc6x3A8L8xMan8RIx1LVuUhQ9c8wLncX2BZgnHCflC8QBGVeOj8uH8J1BQARyo7pRa8QSoWP0vaNdSDVuybi0BVZPhpDa9A3TpIe4OUf+Y0rz3WpNISECPH299Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281952; c=relaxed/simple;
	bh=sNWf8iBjosV0cXu2kA0N4QHydF0OyM3/rlPmIpS7y/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvoXXlWJm50sCJpZO8tSstXcLv3O89uF6UvJTxy2y1o8QFwLAKJ0LSH8Y7YSlumZg8YQrLcFeies4boKWRT7eeB1CMGyZqm6XH5gBXMETCIfh5uwPbRLaGW0EP19LbTkXqWfHJtDuld9ZLoqpcnwg/4AoYUUaHl3jHyKM9hozOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMN9FmQR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMN9FmQR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f236418so286506b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281948; x=1785886748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+ZpZqxWAFi8f5gAOZ2q3Q6RAdJzdouU2X3Ga3EgR4I=;
        b=cMN9FmQRhw1ip8dzY04RHKS/sDj9xM4nmtvNNNFHO6n/9JtZZUKykiT67EB8gHkYit
         1AEm5W9vfuAkcQFyT/xCQZ7v/C0EcsAtLmoxPIg/huk6UxX/YEIIlxRizOTM4fd/mpk+
         WHo+Wm9Rg+hgC8/zAfCs2Dc2lnlcqMhuTN10dN4XhPsNyvwPNtWbxXyxm+NNq3ZxUcK1
         HzXM5a2c3BmgeEb2tOjM2vS4lH40ZAiUCPYxDVn7WEZHzXfMRBRNOEB0ahLGKBZs/d7V
         kgbsJlnMLaZj8yHSLWPar9tjPU7wkNbNpKlV2IEwEQM7YRCqzRis2ZpgXjIv3UceMyd3
         Vs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281948; x=1785886748;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+ZpZqxWAFi8f5gAOZ2q3Q6RAdJzdouU2X3Ga3EgR4I=;
        b=q1l4H7o0pChHQm7EhSmmPnRkhWKFAXNtG9K2D51uGgMZfts7zn/+etI/WYSEvgVbiB
         hcpVWv2a+aKQeOiyuESGLB6+zsBrjMZI4PsC5EBDG/edw/dTEXPJkSbBWIM/IwO6acxo
         Jo5bl061OJpCmlaJQ51cn8yyvnG2IbDCvwklM4K+HltY+aBuimAT8sBFb3x5Oi21X1N4
         iQwjtSrfb4OqwUm1tOdU3kap/w/nKofJw0lH0TLX59reWjmtaVTDPJfdrg6oGr4DSlUO
         hJcguQKKokZuIk0nMx2hJGn85bMjyCsX4ToivFJlGthLowj0amb8IBLuUXZrx9cPpMsB
         6puQ==
X-Forwarded-Encrypted: i=1; AHgh+RphC8Wknz6ui9FCE5kAgg73dCIV9SCLSARIXamOIuWZDO0Nuxcb3r2cPMSgEjtWEw0ifKdAMwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsZwRq0PD4LeE5UrPAK61xdwFKMozliTWwo/3V1FYwnxr1fYg
	uKpfMqdCPkxHyA/PDEdAO9uuY9xXrKqp7sq7zt7L7ZqXXKBHfTgmYzzu
X-Gm-Gg: AR+sD13kIXKecsTC7RRVXj81GLaxbJsUmHOWSImAIAOxpt2Dqg5zN57rvvyVUrdyDoX
	bEPtuLEqXcRSKt44RccvSOyrZnwsPKFx7OwAwwV4f/Z2+eWfwSmqUElspYDwwg94gct2JLq58T5
	Zcf9t4bOIyg6lqHvcLb3vh0Cl92TqOypA9oMJbzuoIL6+I6PAvrsfEWY3qmAms66Uzqfov33znO
	Pb7+w1f1USBqkMZMEqixYg5MVP6fMNVU7izmRPWvqlSUar13kjf8KPn42+vSJxFO7fcO4pp23nq
	B7lJ4qbJHnHPpAvloLVEH8HJ851Q94b+u+8SSVCa6r0705N6x4N8BquS/ehr+/RU0b9QV7Efn22
	K815xP6fTMVtQx1LZ+YuXFp6Jm1xGXXgA8di/TndX0ErJ0bUnA+NSJHTHp8SoHtVrG+IQeJTXG6
	mcUtuNkXA4BizuLrnnVZ/SKmw74TVTDoELOl8aMRWg0HbTJPXWvDEENlOTe8ZGei816BuWr3Hca
	i2I7odaw3AfbW+zprvwgHQ=
X-Received: by 2002:a05:6a00:13a3:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84e9330f06fmr4671630b3a.76.1785281947609;
        Tue, 28 Jul 2026 16:39:07 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm496896b3a.35.2026.07.28.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:39:07 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
Date: Wed, 29 Jul 2026 08:38:31 +0900
Message-ID: <20260729-topic-attr-list-lock-v6-v3-3-7f690b9b98ad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729-topic-attr-list-lock-v6-v3-0-7f690b9b98ad@gmail.com>
References: <20260729-topic-attr-list-lock-v6-v3-0-7f690b9b98ad@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281796; l=9392; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=sNWf8iBjosV0cXu2kA0N4QHydF0OyM3/rlPmIpS7y/A=; b=1LldeajD3eQZfhZHP79IqCHvBxjdxW4Fe2QuHY4GBtg3D93ggRQmZJ5Mq6yVEWlGt8yFHB1gx mUIJ9vjwfoOCJeRB3FUbW183tGWBDXBBX0r6+yTBkTztLB9AqkylujM
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
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
 fs/ntfs/attrib.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 fs/ntfs/attrib.h |  2 +-
 fs/ntfs/inode.c  | 36 ++++++++++++++++++++++++++++++++++--
 fs/ntfs/namei.c  |  2 +-
 fs/ntfs/super.c  |  2 +-
 5 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index b99468dd0bba..b16c95d3ea97 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2771,12 +2771,15 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 
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
@@ -2816,10 +2819,33 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 
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
+		 * only happens underneath ntfs_attrlist_update(), which is
+		 * always invoked by ntfs_attrlist_entry_add()/rm() or
+		 * ntfs_inode_add_attrlist() while already holding this same
+		 * mutex. Taking it again here would deadlock the caller
+		 * against itself, so skip the (re-)acquisition in that case
+		 * and rely on the lock already held further up the stack.
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
@@ -2866,7 +2892,7 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 			kvfree(al_rl);
 		}
 		/* Remove attribute record itself. */
-		if (ntfs_attr_record_rm(ctx)) {
+		if (ntfs_attr_record_rm(ctx, false)) {
 			ntfs_debug("Couldn't remove attribute list. Succeed anyway.\n");
 			return 0;
 		}
@@ -4155,8 +4181,17 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
 					NTFS_VCN_DELETE_MARK)
 				continue;
-			/* Remove unused attribute record. */
-			err = ntfs_attr_record_rm(ctx);
+			/*
+			 * Remove unused attribute record. When @ni is the
+			 * $ATTRIBUTE_LIST attribute itself, we only get here
+			 * underneath ntfs_attrlist_update(), whose caller
+			 * (ntfs_attrlist_entry_add()/rm() or
+			 * ntfs_inode_add_attrlist()) already holds
+			 * base_ni->attr_list_persist_lock for this
+			 * transaction, so tell ntfs_attr_record_rm() not to
+			 * recurse into it.
+			 */
+			err = ntfs_attr_record_rm(ctx, ni->type == AT_ATTRIBUTE_LIST);
 			if (err) {
 				ntfs_error(sb, "Could not remove unused attr");
 				goto put_err_out;
@@ -5406,7 +5441,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
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
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index c568ddf851f4..3d69a8b68f21 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3049,6 +3049,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	struct attr_list_entry *ale = NULL;
 	struct mft_record *ni_mrec;
 	u32 attr_al_len;
+	bool attrlist_locked = false;
 
 	if (!ni)
 		return -EINVAL;
@@ -3124,9 +3125,14 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Set in-memory attribute list. */
+	mutex_lock(&ni->attr_list_persist_lock);
+	attrlist_locked = true;
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
+	ni->attr_list_gen++;
 	NInoSetAttrList(ni);
+	up_write(&ni->attr_list_lock);
 
 	attr_al_len = offsetof(struct attr_record, data.resident.reserved) + 1 +
 		((al_len + 7) & ~7);
@@ -3153,28 +3159,45 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
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
+	mutex_unlock(&ni->attr_list_persist_lock);
+	attrlist_locked = false;
+
 	/* Remove $ATTRIBUTE_LIST record. */
 	ntfs_attr_reinit_search_ctx(ctx);
 	if (!ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0,
 				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
-		if (ntfs_attr_record_rm(ctx))
+		if (ntfs_attr_record_rm(ctx, false))
 			ntfs_error(ni->vol->sb, "Rollback failed to remove attrlist");
 	} else {
 		ntfs_error(ni->vol->sb, "Rollback failed to find attrlist");
 	}
 
+	/*
+	 * Without this lock, a concurrent ntfs_attrlist_entry_add()/rm()
+	 * could replace or free @al out from under this loop.
+	 */
+	mutex_lock(&ni->attr_list_persist_lock);
+	attrlist_locked = true;
+
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
@@ -3201,10 +3224,19 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
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
+	if (attrlist_locked) {
+		mutex_unlock(&ni->attr_list_persist_lock);
+		attrlist_locked = false;
+	}
+
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 5ff25e9aaa32..9c85caa00a0c 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -941,7 +941,7 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
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

