Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AD379EF7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387431; cv=none; b=o9SxYRVggzUrU6FrOLYU++2gF5IPp3h7Gvy3LJn71qWhNrBREOFcKNo+4BHKYJ9pLCgPKQICbCSCso3mWibJh1swvrggEuHK4JxqqR70nMLV5KXKIjvCWaCWiDaRa6WetmGI2PIEJ4vRgR+429/tarozLkmKa0cyYObeIeApYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387431; c=relaxed/simple;
	bh=Kl3eWN+ectH2lmXRi3PVBfBXXp5AUimHw6z7FIkQwO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtzxC+Q6HW0LjBHfGo9BIwE/03jgPVfVTU9QGwyUj3guVwnL9VOuVi23cfjpjWaWhokmLtLVMZzQTQr6koZOAELh5TMf52kAKwkKMiuvLt2/ZsKnZZ0/U+4h0TVOH/w4MDXAsIS1e1WVSEJSTtEiUEa1zRS68V5KnxSBHPPC5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSfQX6RG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSfQX6RG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf41bab353so29263365ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785387430; x=1785992230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KncaE4prH9uwEM7HOZQQkhU+SOiEkuZBd/8TeS6vi5g=;
        b=PSfQX6RGtI0x1P7EgTnyJvWqD56GoFsq5jy6QOEB/Kmqhcp9DWujErtgfRxdr/aR8+
         UZeOgkc8CzngpZlHAfC1gvqvM42mS2ONFMY+AZjxj25aIynX+KwTMui4mL7aE+XxZ5rR
         roxIiPaRtnC8shIXwpwjvcYHEOZ5uBX7dgED60RJf/FpufBr0Tb5ZaL/OMR2d+8SXuhO
         6UaNtqWBdoqA8LRNI8v2rJ0+hsqhAmWfUoksIsQE+RPjvRfPt7F3DzpQka3FSwUP+i1H
         ZEBhFI/nYwHBhxwekUnDSLFh+QzSGHqaFDUOEABogeFnY7aJT+MmsemmyBxpGvmcgyOo
         jvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387430; x=1785992230;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KncaE4prH9uwEM7HOZQQkhU+SOiEkuZBd/8TeS6vi5g=;
        b=MrecmTPhu5tyOjLp9BgwPoN1EBTO+o/12e1dLWf5yMhz/l+YPS8hj061cWDAGPlzL8
         9WiaOkCtJBbEDUSN3bzlapNC57w0U2ftN3rh+gJwVlg6gXrcxKjpF1MSOJZK8PstfaKF
         HE4wumVGpiETfEXIqyIqp0PgYzNtwdkgRGzqgcVwp0uiopiHzpU4WqFJZgp5RFpcbrxV
         QLnGjYMMBXaV9GqXj0LP9MlXpr2a05w7r9sB87r8O7p6YhSGtf3tdxv5URNI5NzINlZO
         pZHl1DC5ClzfqIyQ1qNQmeP4ebgck7HY9SuDBK+o45OQCOPmz8BQop7otkGNmCOUzreT
         PVrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2PnBBPsY9vOUFZr/R3pAenpL4GbUYufHZHINy++R7CWdPAFgKM7Hn+UWGUcFG9vaibHhm36s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy623D/LO1+OeG+Sva9zDddXCjrbAZrILRuEIvFCtEVecaHP74a
	NkVhlVqTMIjqbN1ETJ8niAWUyeauVbWjjNBQ4t5r7lXP7CsMvN5oiRGU
X-Gm-Gg: AR+sD12Xz8JE/6Xz8BntE4UwohvxfuOZGii+yX0ZsXy1cOk1cDamgcgnG3qh8cTYZT+
	rO5ruksJ++EThBjnF4Gvd9l7w6SCedVjGN3pal5NsOlb5pFDWHDPvRmtC37relomvSqf44wJ6DM
	iIw5ePYATJZBqLAVonwGUvNCt6ohuYGtoAvv4uY+AEiua7q62X72bxs37bYPms4uv/2zS6hD98z
	VJZQPdSxkUAJsHOd9mN52Et7PL0XfJ2GEX1wBzZf0b3qKGQ72MBSl/Lq/G7TLY8YEzcJfln76iv
	Gziafdwn5bcqRepXzHIB2YVjAEc+EOap4GKnmjrB+c6PJBsVjx196bThE/24H5DGTvbvZ3a78xC
	SQInnRjISZywvpehqzflXfeblYHkfd5jt4vesd3oxjXht9wa259gGAdTSMpvJrDFgemPfNWgJ5Z
	wVeE95iXPBdmFelnsj9V9e5B2K+mX6DfORV8wLIBGeu9T6m0M0ADp43aeAmra6umQcEp+9fhTY2
	dYObb4ejFgg
X-Received: by 2002:a17:902:d2d2:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2d035d3be92mr13930085ad.44.1785387429567;
        Wed, 29 Jul 2026 21:57:09 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46969sm19875325ad.25.2026.07.29.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:57:08 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/4] ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
Date: Thu, 30 Jul 2026 13:56:14 +0900
Message-ID: <20260730-topic-attr-list-lock-v6-v4-3-80d5fe0a6951@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730-topic-attr-list-lock-v6-v4-0-80d5fe0a6951@gmail.com>
References: <20260730-topic-attr-list-lock-v6-v4-0-80d5fe0a6951@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785387323; l=9392; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=Kl3eWN+ectH2lmXRi3PVBfBXXp5AUimHw6z7FIkQwO4=; b=tAd6LeUOFe/NoNMCXwDTkDM3hrlOOqCeAxfbE2wQb8alOcen2Z36gIryhDyt4aOVaxINaecvr XnzsrIezOCPCDxEo3DB7KuRje+EXO1sC4bCwVe8QNBUWn+eYwEIGM2m
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
index e9004d410918..0fdcf6757d02 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2774,12 +2774,15 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 
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
@@ -2819,10 +2822,33 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 
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
@@ -2869,7 +2895,7 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 			kvfree(al_rl);
 		}
 		/* Remove attribute record itself. */
-		if (ntfs_attr_record_rm(ctx)) {
+		if (ntfs_attr_record_rm(ctx, false)) {
 			ntfs_debug("Couldn't remove attribute list. Succeed anyway.\n");
 			return 0;
 		}
@@ -4158,8 +4184,17 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -5417,7 +5452,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
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
index f9d3e37f99e7..0297de482a36 100644
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

