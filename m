Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158E42A781
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281951; cv=none; b=f2d41Lz7Azt2RBubolTUQM/lBLTBpZzjVKAhs6WefPqRzxY6mb/IHQvzv7ubIcWttTVJfne8Br2MHNbVXuuTQdOGF/TsKYR5m+PH/caKdWpsHs9RkyjWPo0F2WW4vtJUQaw4rQbVB0aMgF8erEN7hQ3hWSlDPglL42pGxfcQZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281951; c=relaxed/simple;
	bh=dgnHhHyEIe4ZtXMsk4RtlrsmC2mde+LTiOxOlAdq06c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIoOtIXkmpWVrf9+aFjwZgGugKFuvf4Q8mtahYIfKfmyGK0+ffjcAy6WIGDMPawboqziZplRyd3a+KPWQYc9P8LK0GS2asFJYpQMS1nW3eD89Z6IAPiP6YgXNs3Uufi5fmMxnzaBTyHFUe6SgTi95QQ+TD1vB4J1WY3JTu3WjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+WcQ4Go; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+WcQ4Go"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so375374b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785281943; x=1785886743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZeF3NjCJfGzDL8tFHI5LR7Nm5QzY73IHVIwbFDJPGJ8=;
        b=a+WcQ4GojvkRMlR0iI6ZcUjHuE/mHuxAZ78YB21vZ49XeAbnyZSMkTQ+BnVwiVwoQm
         pcGEMh7YnQH7rui+MhpSrh+NUKn70aLrsMqM/Yjg3Bwg4xU58VgeI0ZNioU7qTG261yo
         5AXCC5/Z2ZxxRzcqndJjtvaELddnceFFXyf4nvd3i4fW1WcHdFuG0KW+gt9qYEQTbixZ
         Fe20i1+BmkdguGCdlE5X6VnIdW7Iua/QzBnsMpeDOx7LmNbtnhfE+hR+buepIFxEMjXB
         G7pClrndka0qPPsmR21y2uIHvV9ppWKInR0Kyyg8qPF6crkCV0aFQO9STQ17uK1HRjO4
         mvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281943; x=1785886743;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeF3NjCJfGzDL8tFHI5LR7Nm5QzY73IHVIwbFDJPGJ8=;
        b=BgOgnUYJrrXkveEXRFiO9YX+JgAvRPlLzQsFOkZ8y8uSQ6nItegpKjUjRct2SdYcbk
         Kqd+rjpvZOVRLp0Y0voMynSsaG6aN8TgkRQDmSVuo2mh4OffLi+1CUnM19CfK3rRVQek
         F0oZNlJkGZP6KfjPNbouDiMf2MSdOXvmTxO7EKO3atjRafyh+yEyQv2w5G6S6qo5454G
         1a/Rbu0KRJa2g9tyDRyTkwc3d9KbQfEusz5+mAzhFHM5CrDQTrzuDT43nldX3fvIdZ61
         2Hot/0xsD3B7AHNCE4JZLvBraqXfTMRwaTn9TsylViMaWSEFF5tzuy3RzxNatq7vQGvk
         1fEA==
X-Forwarded-Encrypted: i=1; AHgh+RrXIkleM1PskUV6I9XKDtQcGsRczIEcx2CWkSN3gS4pFHu64Rrh4gqn1KaFsE2jLPgFhXCox8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlrFccFa9SsIuLI7h2o4wtdKwWuTXNBhfvI4Z3Y6Ykvn6e8vi
	vPx/JmrB7KD401yLvSDgfJOWzX5T/Dq7TM17gNybHMhrtNyVKMKI7Gwr
X-Gm-Gg: AR+sD13+fqhCmm6dHh6ZlV78sRJBRWi7/V3VTZbmpgSTDcrWM4KJXZ1XMlT9n9G52DZ
	LiLgqTZj4Lb3KoRdNQW25VUP7CDb4TiQypsLq5RbDCbIaXiXTeI2hQ7s6LOQ02JlIh0RPfI1o2r
	BNoJbAz3j1CxgJrWAjjkSyMB9GzqbUu8Mj/H4gJdTXQ79S6beTgOnijFAUj1uUPSKPSR0XgkLjc
	R6Pa2kki9d1NWLXQvGKrE3oMLey8IDEaPAMWmRVX7UzpS6sH/l1VaOqMr2j56k/ZesTlhlek6DS
	jrsnJzKWuDH2xKAZUl4yEGmLWWa9Pr+xdETlMY+YbamoqhsTt9D67ZApsgaOPlIFHScAzPuDWKG
	qDERVRTCDdN4c4ClAXTOR5U/bHO5g2oV7wrcBGRygLocPOKpbRlWAEQu4WXzKz+WciNu9qImpVw
	wwqccTSnfLgcmZPz5AkO6uOKQ9qTujAzkgfvmjvGqczVDCCOHXLfT1STZwSzzgXq1F8iHO4eDGl
	bDgZK42wIXG
X-Received: by 2002:a05:6a00:3d06:b0:848:5f4f:289a with SMTP id d2e1a72fcca58-84e9331bca0mr4966226b3a.49.1785281943187;
        Tue, 28 Jul 2026 16:39:03 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm496896b3a.35.2026.07.28.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:39:02 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] ntfs: protect attribute-list buffer replacement with attr_list_persist_lock
Date: Wed, 29 Jul 2026 08:38:30 +0900
Message-ID: <20260729-topic-attr-list-lock-v6-v3-2-7f690b9b98ad@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281796; l=10596; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=dgnHhHyEIe4ZtXMsk4RtlrsmC2mde+LTiOxOlAdq06c=; b=6zsYeUfJVB4PbfR+s3nj4d64/mukvUeDQ/1xO0k+aHUsJlyjlzfRtrfY5Cy/1BXAZEXTOKC0C 2UzhU4JXNXAAdGg5GhgfqFFb3Bkmjy74KUMcH9zr+q88f+gD36UVjV4
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
Content-Transfer-Encoding: 8bit

ntfs_attrlist_entry_add() and ntfs_attrlist_entry_rm() replace the
in-memory attribute-list buffer and then persist it to disk.  The swap
is protected by attr_list_lock, but persisting can sleep and recurse,
so that lock cannot be held across it.

Add attr_list_persist_lock, a mutex that covers the entire
publish/swap/persist/rollback transaction for each caller.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c   |   4 +-
 fs/ntfs/attrib.h   |   2 +
 fs/ntfs/attrlist.c | 128 ++++++++++++++++++++++++++++++++++++++++++-----------
 fs/ntfs/inode.c    |   1 +
 fs/ntfs/inode.h    |   3 ++
 5 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 1f473ef9b102..b99468dd0bba 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -83,8 +83,8 @@ bool ntfs_attrlist_exact_key_eq(const struct attr_list_entry *ale,
 	return ale->name_length == key->name_len;
 }
 
-static struct attr_list_entry *ntfs_attrlist_find_exact_locked(struct ntfs_inode *base_ni,
-							       struct ntfs_attrlist_exact *exact)
+struct attr_list_entry *ntfs_attrlist_find_exact_locked(struct ntfs_inode *base_ni,
+							struct ntfs_attrlist_exact *exact)
 {
 	struct attr_list_entry *ale;
 	u8 *al_end;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index a39719f75d06..2e5f87abd852 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -129,6 +129,8 @@ void ntfs_attrlist_exact_key_from_ale(struct ntfs_attrlist_exact_key *key,
 				      const struct attr_list_entry *ale);
 bool ntfs_attrlist_exact_key_eq(const struct attr_list_entry *ale,
 				const struct ntfs_attrlist_exact_key *key);
+struct attr_list_entry *ntfs_attrlist_find_exact_locked(struct ntfs_inode *base_ni,
+							struct ntfs_attrlist_exact *exact);
 int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
 		const __le32 type, const s64 size);
 int ntfs_attr_can_be_resident(const struct ntfs_volume *vol,
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index b8594037df40..fde4178ffb2f 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -122,12 +122,13 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 {
 	struct attr_list_entry *ale;
 	__le64 mref;
-	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_attr_search_ctx *ctx = NULL;
 	u8 *new_al;
 	int entry_len, entry_offset, err;
 	struct mft_record *ni_mrec;
 	u8 *old_al;
 	__le64 lowest_vcn;
+	bool found, rollback;
 
 	if (!ni || !attr) {
 		ntfs_debug("Invalid arguments.\n");
@@ -153,13 +154,16 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		ntfs_debug("Attribute list isn't present.\n");
 		return -ENOENT;
 	}
+	mutex_lock(&ni->attr_list_persist_lock);
 
-	/* Determine size and allocate memory for new attribute list. */
+	/* Determine size of new attribute list entry. */
 	entry_len = (sizeof(struct attr_list_entry) + sizeof(__le16) *
 			attr->name_length + 7) & ~7;
-	new_al = kvzalloc(ni->attr_list_size + entry_len, GFP_NOFS);
-	if (!new_al)
-		return -ENOMEM;
+
+retry_lookup:
+	new_al = NULL;
+	found = false;
+	rollback = false;
 
 	/* Find place for the new entry. */
 	ctx = ntfs_attr_get_search_ctx(ni, NULL);
@@ -181,29 +185,54 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 			le16_to_cpu(attr->data.resident.value_offset)), (attr->non_resident) ?
 			0 : le32_to_cpu(attr->data.resident.value_length), ctx);
 	if (!err) {
+		found = true;
 		/* Found some extent, check it to be before new extent. */
 		if (ctx->al_exact.key.lowest_vcn == lowest_vcn) {
 			err = -EEXIST;
 			ntfs_debug("Such attribute already present in the attribute list.\n");
-			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
-		/* Add new entry after this extent. */
-		entry_offset = ctx->al_exact.off +
-			le16_to_cpu(((struct attr_list_entry *)(ni->attr_list +
-								ctx->al_exact.off))->length);
 	} else {
 		/* Check for real errors. */
 		if (err != -ENOENT) {
 			ntfs_debug("Attribute lookup failed.\n");
-			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
 		/* No previous extents found. */
+	}
+
+	down_write(&ni->attr_list_lock);
+	if (found) {
+		if (ctx->al_exact.gen != ni->attr_list_gen) {
+			up_write(&ni->attr_list_lock);
+			ntfs_attr_put_search_ctx(ctx);
+			ctx = NULL;
+			goto retry_lookup;
+		}
+		ale = ntfs_attrlist_find_exact_locked(ni, &ctx->al_exact);
+		if (!ale) {
+			up_write(&ni->attr_list_lock);
+			err = -EIO;
+			goto err_out;
+		}
+		entry_offset = (u8 *)ale - ni->attr_list + le16_to_cpu(ale->length);
+	} else {
+		if (!ctx->al_insert.valid ||
+		    ctx->al_insert.gen != ni->attr_list_gen) {
+			up_write(&ni->attr_list_lock);
+			ntfs_attr_put_search_ctx(ctx);
+			ctx = NULL;
+			goto retry_lookup;
+		}
 		entry_offset = ctx->al_insert.off;
 	}
-	/* Don't need it anymore, @ctx->al_entry points to @ni->attr_list. */
-	ntfs_attr_put_search_ctx(ctx);
+
+	new_al = kvzalloc(ni->attr_list_size + entry_len, GFP_NOFS);
+	if (!new_al) {
+		up_write(&ni->attr_list_lock);
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	/* Set pointer to new entry. */
 	ale = (struct attr_list_entry *)(new_al + entry_offset);
@@ -231,17 +260,34 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	old_al = ni->attr_list;
 	ni->attr_list = new_al;
 	ni->attr_list_size = ni->attr_list_size + entry_len;
+	ni->attr_list_gen++;
+	up_write(&ni->attr_list_lock);
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
 
 	err = ntfs_attrlist_update(ni);
 	if (err) {
-		ni->attr_list = old_al;
-		ni->attr_list_size -= entry_len;
+		down_write(&ni->attr_list_lock);
+		if (ni->attr_list == new_al) {
+			ni->attr_list = old_al;
+			ni->attr_list_size -= entry_len;
+			ni->attr_list_gen++;
+			rollback = true;
+		}
+		up_write(&ni->attr_list_lock);
+		if (!rollback)
+			new_al = NULL;
 		goto err_out;
 	}
 	kvfree(old_al);
+	mutex_unlock(&ni->attr_list_persist_lock);
 	return 0;
 err_out:
-	kvfree(new_al);
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (new_al)
+		kvfree(new_al);
+	mutex_unlock(&ni->attr_list_persist_lock);
 	return err;
 }
 
@@ -255,10 +301,12 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
  */
 int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 {
-	u8 *new_al;
-	int new_al_len;
+	u8 *new_al = NULL;
+	int err, new_al_len;
+	bool rollback;
 	struct ntfs_inode *base_ni;
 	struct attr_list_entry *ale;
+	u8 *old_al;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->al_exact.valid) {
 		ntfs_debug("Invalid arguments.\n");
@@ -269,9 +317,6 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		base_ni = ctx->base_ntfs_ino;
 	else
 		base_ni = ctx->ntfs_ino;
-	if (ctx->al_exact.off >= base_ni->attr_list_size)
-		return -EIO;
-	ale = (struct attr_list_entry *)(base_ni->attr_list + ctx->al_exact.off);
 
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld.\n",
 		   (long long)ctx->ntfs_ino->mft_no,
@@ -282,12 +327,24 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		ntfs_debug("Attribute list isn't present.\n");
 		return -ENOENT;
 	}
+	mutex_lock(&base_ni->attr_list_persist_lock);
+
+	down_write(&base_ni->attr_list_lock);
+	ale = ntfs_attrlist_find_exact_locked(base_ni, &ctx->al_exact);
+	if (!ale) {
+		up_write(&base_ni->attr_list_lock);
+		err = -EIO;
+		goto out_unlock;
+	}
 
 	/* Allocate memory for new attribute list. */
 	new_al_len = base_ni->attr_list_size - le16_to_cpu(ale->length);
 	new_al = kvzalloc(new_al_len, GFP_NOFS);
-	if (!new_al)
-		return -ENOMEM;
+	if (!new_al) {
+		up_write(&base_ni->attr_list_lock);
+		err = -ENOMEM;
+		goto out_unlock;
+	}
 
 	/* Copy entries from old attribute list to new. */
 	memcpy(new_al, base_ni->attr_list, (u8 *)ale - base_ni->attr_list);
@@ -295,9 +352,30 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 				ale->length), new_al_len - ((u8 *)ale - base_ni->attr_list));
 
 	/* Set new runlist. */
-	kvfree(base_ni->attr_list);
+	old_al = base_ni->attr_list;
 	base_ni->attr_list = new_al;
 	base_ni->attr_list_size = new_al_len;
+	base_ni->attr_list_gen++;
+	up_write(&base_ni->attr_list_lock);
 
-	return ntfs_attrlist_update(base_ni);
+	err = ntfs_attrlist_update(base_ni);
+	if (err) {
+		rollback = false;
+		down_write(&base_ni->attr_list_lock);
+		if (base_ni->attr_list == new_al) {
+			base_ni->attr_list = old_al;
+			base_ni->attr_list_size += le16_to_cpu(ale->length);
+			base_ni->attr_list_gen++;
+			rollback = true;
+		}
+		up_write(&base_ni->attr_list_lock);
+		if (rollback)
+			kvfree(new_al);
+		goto out_unlock;
+	}
+	kvfree(old_al);
+	err = 0;
+out_unlock:
+	mutex_unlock(&base_ni->attr_list_persist_lock);
+	return err;
 }
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 72d8b6c9016b..c568ddf851f4 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -476,6 +476,7 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->folio_ofs = 0;
 	ni->mrec = NULL;
 	init_rwsem(&ni->attr_list_lock);
+	mutex_init(&ni->attr_list_persist_lock);
 	ni->attr_list_gen = 0;
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index a99c228184ce..ee7e5ec6ade4 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -69,6 +69,7 @@ enum ntfs_inode_mutex_lock_class {
  * functions). Setup during read_inode for all inodes with attribute
  * lists. Only valid if NI_AttrList is set in state.
  * @attr_list_lock: Protects in-memory attribute list state.
+ * @attr_list_persist_lock: Serializes attribute list replacement and persist.
  * @attr_list_gen: Generation of the in-memory attribute list state.
  * @attr_list_size: Length of attribute list value in bytes.
  * @attr_list: Attribute list value itself.
@@ -123,6 +124,8 @@ struct ntfs_inode {
 	s64 mft_lcn[2];
 	unsigned int mft_lcn_count;
 	struct rw_semaphore attr_list_lock;
+	/* Serializes attribute list replacement and persist. */
+	struct mutex attr_list_persist_lock;
 	u64 attr_list_gen;
 	u32 attr_list_size;
 	u8 *attr_list;

-- 
2.43.0

