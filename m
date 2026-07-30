Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CA357D10
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387427; cv=none; b=tmrsL+9xLPQwgzMbHJUIxjoWaMwudvfLz1vrEBPNBRldrFOdSz1ZW5E6HeN8nOMB/rK9ziV7zSKgeExaHKBPz6dHn6OP1ysYPC6jt0WMlFN+QaxZobMVJQCqv2l/glxwZAfSGblkwS4wIjka8+Ra3gb0SmOdPv7e6XCYK4kJ908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387427; c=relaxed/simple;
	bh=57a9sBgC9YJLftUK48YjBIc6efieAmBX5Kh/Mj61g8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md0qBQKH5/fvMwOd4m0QIPl3f9a85uWYtbfTNcXapUhqSDMSS5uK+tLdRCtNpgH4UghfBi0dil1tf6Qrpc87WMYspOpY6dOQBVaWL8NGj8MQswTBqVg1I6HmZmkL4aKj4RGrg/qS2B51OGxxJI6tHmLBcpI0hXT2JkOI0MQPpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9wJUFbI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9wJUFbI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so19999265ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785387425; x=1785992225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Igf6uU1g5HjNrp8vTZaiGpb9cgO9f7p2l27x+V0nu2Y=;
        b=f9wJUFbICdUhNI0HqRPCv0F9zj3i7CzFMWmLqWRVGvKr1nzly3MN1nqImvFXUefXBZ
         HQLE5Ej2EhJl9sbDhmadC77hj2QnA62MKgU/1s4dB7b1hv1OR5UAgW/41PgOqH506eUJ
         LFrrFOCzFP5xryIKhCb0z4VZOvYbWevovVLx6vmP4GD4xC0dGhDgc8wNQYqeVx1I9FD1
         VrmZ5I7Ic8+TPIHLilTeVMW2B8clcbICqA6FZsWPbf4bMKG8KVcC1xxljEplSpMGqtFq
         058+ruEKFyly6BusKWo8sNCG254OSU4I8JrXggUKUiDkwcCZsUN/71S6sd/0BaYDxpu/
         H1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387425; x=1785992225;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Igf6uU1g5HjNrp8vTZaiGpb9cgO9f7p2l27x+V0nu2Y=;
        b=gcucNBJHbmzJjr5R3a+8hBjLGmf8sviiLc8vZx9RD2gRvV0mfid/mYNQ5JeVv/fb3u
         GjhSDaMoGlIEPHqDnTlE6IUenJ3GMOcfBoDkF244Dq/fvTe586QFpoiFGVC49gJkIzyB
         +9tLz1OjNpEO6x0LQsVgxsFNy0YEXXpLp8WyCvnRkZFDuj1fIAIUc3m5jY99XTqZXYHQ
         cffBajIg8nbnzsdqEwSLTZmeR/TuSX/BdiVVfXaO0V5zYg0bv6PIAMIQiby3MY2t+xTG
         bQM4Sxjz31HXLYxQ6YfXj2Iht9hJ3po3aQrd2hbQ9T9h9Xn2Ij9Og6VVu1WCy25nEkgB
         XkMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8GIFpkXh+ShH0L+64EvZv5WMC9URlZLRh/UlV8y+lJFrhBGbruSCFd2pZEakfRMzVIBCwgTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGz5tw5dlRRW+xQyR5KZ1xUJucW2eV+t85k3L7MmjVTN48AE/
	Eku4Y6u7RMXBNcRHdHu70UHzMP54Ft0VCCQUnoOegRR2vg42x+738kLzECCLyg==
X-Gm-Gg: AR+sD10rV5ksLB1iENYBIBQDWez5fN//FyQCc33WkLb8XTwQSU0drWplX78AALSxG2v
	pZkLthWPV2AdcNPqpZ7gTDET+8XhD7RWLvSAurAIC2JdLoQq5A521WT4ZnLajnzj8ErdSCr3rO7
	g11QXKcuGnqhPmXkz+tAX3OrurPbp/5PEO77XssobpMqlXDHRdKluVuniN6f414la/T/fvJPhjf
	JcwOKvQ0fL96A0f5STiYjlMcczCE8qjpyA+dmylaS2RhwpXIJQblILVBY67io1JBk3WwWtj4vor
	YeHnKmr65CzcsKGBQndNRBASIwYNJPMH0SjBR3EliDLpLQqWD9G+KjLVW4Q3bY3QVlawt76fKiu
	iHGvyvq6Q84dRxijRkZueNNh+WBGX6H5SCQz8Jhn3j1806HV9cQPJ94BDZvdvkovoce6eG4U5gt
	9pc39kK0jsB8xiyV8nIlZhmOCUmJzyKpDTJbJfcfBjKkVr4KtiFKYbwn1dbYe5r+3qcg8echjK6
	wv8WtmxiwqT
X-Received: by 2002:a17:903:2b0b:b0:2cf:a5da:705e with SMTP id d9443c01a7336-2d035d28f16mr12281285ad.41.1785387424981;
        Wed, 29 Jul 2026 21:57:04 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46969sm19875325ad.25.2026.07.29.21.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:57:04 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] ntfs: protect attribute-list buffer replacement with attr_list_persist_lock
Date: Thu, 30 Jul 2026 13:56:13 +0900
Message-ID: <20260730-topic-attr-list-lock-v6-v4-2-80d5fe0a6951@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785387323; l=14043; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=57a9sBgC9YJLftUK48YjBIc6efieAmBX5Kh/Mj61g8o=; b=EjeUEjp/cy+Cw5VbLuqcmiqk5LoKlKnBG1NjhVpsrrEqvQ0Ekf1ZoDcSrbF25v5z0lZDqIMn8 NyuxTbVx9r3C+CxsDMrJumsBApJMYSplp8UA2uqEwXkL0u5+xts9gZw
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
 fs/ntfs/attrib.c   |  18 ++++--
 fs/ntfs/attrib.h   |   2 +
 fs/ntfs/attrlist.c | 170 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrlist.h |   1 +
 fs/ntfs/inode.c    |   3 +-
 fs/ntfs/inode.h    |   3 +
 6 files changed, 164 insertions(+), 33 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 6b932feb1a36..e9004d410918 100644
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
@@ -3765,7 +3765,7 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 				goto out;
 			}
 
-			err = ntfs_attrlist_update(base_ni);
+			err = ntfs_attrlist_update_locked(base_ni);
 			if (err)
 				goto out;
 			err = -EAGAIN;
@@ -4141,7 +4141,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	}
 
 	if (attrlist_changed) {
-		err = ntfs_attrlist_update(base_ni);
+		err = ntfs_attrlist_update_locked(base_ni);
 		if (err)
 			goto put_err_out;
 	}
@@ -4992,7 +4992,15 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 				"Couldn't free space in the MFT record to make attribute list non resident");
 			return err;
 		}
-		err = ntfs_attrlist_update(base_ni);
+		/*
+		 * Resizing the $ATTRIBUTE_LIST attribute itself only happens
+		 * underneath ntfs_attrlist_update_locked() while already holding
+		 * attr_list_persist_lock.
+		 */
+		if (attr_ni->type == AT_ATTRIBUTE_LIST)
+			err = ntfs_attrlist_update_locked(base_ni);
+		else
+			err = ntfs_attrlist_update(base_ni);
 		if (err)
 			return err;
 		goto attr_resize_again;
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
index b8594037df40..60f3dcedde6f 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -51,7 +51,13 @@ int ntfs_attrlist_need(struct ntfs_inode *ni)
 	return 0;
 }
 
-int ntfs_attrlist_update(struct ntfs_inode *base_ni)
+/*
+ * ntfs_attrlist_update_locked - persist the in-memory attribute list to disk
+ * @base_ni:	base ntfs inode containing the attribute list
+ *
+ * Caller must hold @base_ni->attr_list_persist_lock.
+ */
+int ntfs_attrlist_update_locked(struct ntfs_inode *base_ni)
 {
 	struct inode *attr_vi;
 	struct ntfs_inode *attr_ni;
@@ -111,6 +117,23 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
 	return 0;
 }
 
+/*
+ * ntfs_attrlist_update - persist the in-memory attribute list to disk
+ * @base_ni:	base ntfs inode containing the attribute list
+ *
+ * Serialize the persist against concurrent attribute-list replacement
+ * transactions.
+ */
+int ntfs_attrlist_update(struct ntfs_inode *base_ni)
+{
+	int err;
+
+	mutex_lock(&base_ni->attr_list_persist_lock);
+	err = ntfs_attrlist_update_locked(base_ni);
+	mutex_unlock(&base_ni->attr_list_persist_lock);
+	return err;
+}
+
 /*
  * ntfs_attrlist_entry_add - add an attribute list attribute entry
  * @ni:	opened ntfs inode, which contains that attribute
@@ -122,12 +145,13 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
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
@@ -154,12 +178,21 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		return -ENOENT;
 	}
 
-	/* Determine size and allocate memory for new attribute list. */
+	mutex_lock(&ni->attr_list_persist_lock);
+
+	if (!NInoAttrList(ni) || !ni->attr_list) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
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
@@ -181,29 +214,54 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
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
@@ -231,17 +289,34 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	old_al = ni->attr_list;
 	ni->attr_list = new_al;
 	ni->attr_list_size = ni->attr_list_size + entry_len;
+	ni->attr_list_gen++;
+	up_write(&ni->attr_list_lock);
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
 
-	err = ntfs_attrlist_update(ni);
+	err = ntfs_attrlist_update_locked(ni);
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
 
@@ -255,10 +330,12 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
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
@@ -269,9 +346,6 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		base_ni = ctx->base_ntfs_ino;
 	else
 		base_ni = ctx->ntfs_ino;
-	if (ctx->al_exact.off >= base_ni->attr_list_size)
-		return -EIO;
-	ale = (struct attr_list_entry *)(base_ni->attr_list + ctx->al_exact.off);
 
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld.\n",
 		   (long long)ctx->ntfs_ino->mft_no,
@@ -282,12 +356,33 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 		ntfs_debug("Attribute list isn't present.\n");
 		return -ENOENT;
 	}
+	mutex_lock(&base_ni->attr_list_persist_lock);
+
+	/*
+	 * Another thread may have removed the attribute list while we were
+	 * waiting for the mutex.
+	 */
+	if (!NInoAttrList(base_ni) || !base_ni->attr_list) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
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
@@ -295,9 +390,30 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 				ale->length), new_al_len - ((u8 *)ale - base_ni->attr_list));
 
 	/* Set new runlist. */
-	kvfree(base_ni->attr_list);
+	old_al = base_ni->attr_list;
 	base_ni->attr_list = new_al;
 	base_ni->attr_list_size = new_al_len;
+	base_ni->attr_list_gen++;
+	up_write(&base_ni->attr_list_lock);
 
-	return ntfs_attrlist_update(base_ni);
+	err = ntfs_attrlist_update_locked(base_ni);
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
diff --git a/fs/ntfs/attrlist.h b/fs/ntfs/attrlist.h
index 1892a3934d3a..ecb8a8c957fa 100644
--- a/fs/ntfs/attrlist.h
+++ b/fs/ntfs/attrlist.h
@@ -16,5 +16,6 @@ int ntfs_attrlist_need(struct ntfs_inode *ni);
 int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr);
 int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attrlist_update(struct ntfs_inode *base_ni);
+int ntfs_attrlist_update_locked(struct ntfs_inode *base_ni);
 
 #endif /* defined _NTFS_ATTRLIST_H */
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 72d8b6c9016b..f9d3e37f99e7 100644
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
@@ -3148,7 +3149,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		goto rollback;
 	}
 
-	err = ntfs_attrlist_update(ni);
+	err = ntfs_attrlist_update_locked(ni);
 	if (err < 0)
 		goto remove_attrlist_record;
 
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

