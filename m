Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00021D5B0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497531; cv=none; b=iT7FecOkbNDhP0GvEX0aF6QW0y7c0DsRBPEr4Sx++zDECgYXNtkiZFobX9hnoB9KiaGiH5j/jXNtd/bvXTAWdYkbXgHvEQIuyZIBXYTgBbCwkPasCgwHGG2V+w4ZVb2y5fVwj5Xxdx0oBmKa+msyRUuZiZSelFHmMiMkUDPu9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497531; c=relaxed/simple;
	bh=YSz+l+UkNez2fVDggZCcuMfVSBdgLFQnKOdosPXaTDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZrWUGnjTw40yll4hOvQaIeILQ3bmBK90kzkbsptodiNHEMWG5COEFnp8Cm9ZlhUCo8ckWJEdmotQjPkjJjh6Ddpbr6D0NQk3srTGlsmACmRC1dpzG/y2/ATT3ZtRTG29fIdsHBQhpsH6stVoY16D9FtySWuyP3Ck2Z+PBLS2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3OFkadu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3OFkadu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3900e39d935so606571a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497529; x=1787102329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mp3qDJzNF5z8s/pXETwTP0WmVZfpFwIh+/McpzDDlz0=;
        b=A3OFkadu9JD97ZJLQ8PSTfjTS2fQEiz2KWZCZ3wuD38rQFpnKl0puBqXHVUuytFxMd
         x7fkXdCIa1+SxuRBQICgTs9oxp5vDNZ7DsPBh66NbXjkOkc/RGZ9bWvu30Px0+z7ymD0
         nPM0UYacKH6iPlcV71/V6hu9JhiX+ETgVTDVp81Tcy7ZBEJ+macM7C3/oKE6SzGMcEle
         TekU78fydkU6w4WZvHBMwBEeM5zZxz29EKgsYIdNU6ClDQY4IzlcxHd/YQ7+qedSc/Bj
         VgATe1cFezYzG2pdSEpZXY+vNsLVXYAAbLn8IlVE1/xaADsMFRfA3Fo1SOYmWaZnOVNf
         eekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497529; x=1787102329;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mp3qDJzNF5z8s/pXETwTP0WmVZfpFwIh+/McpzDDlz0=;
        b=HuIzPPodKHXCRzglDA9mG70mw7v58AZU7lMKewnQtL1kKDb5kSk85WRYzft2IV1EQl
         V1KQ3HU7RGt8oK074X5DYC383XXSYb+RzP50AIoQ/XRDCQVHw1FoMW+h7CVqvFb5UWqr
         YReVZBxJPFb6N9P8EDCZR0yqLtv7Ppkw30aDCiAbwXcmCZNRbklQB08dtOW4um0JKOza
         sx1vVgIWNtSkGmg94CuVbXUX0GvBFBqGZq9uw30xfr4+6dZSd77WHiZvG2uUSySjeHtE
         /huJKrhDz31Tv/t4krQAhr5Ljok4nJTCorJzC4fTTD+9wWUWQOdDvv0oqoNYTW6fTpif
         cSdw==
X-Forwarded-Encrypted: i=1; AHgh+RocVCLkAfkrdhWbBmr5I6Be1nPqgkA97hPiXtu9v6mWRsjJs1+nL7MQsD2jtDYJ6eYm5h4VNS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO8eBTHF265IwklSgT74BDb3C2Hgrb87NIU0TIl1c3CyOGWRRw
	BEfM9pOJQFC+vgPFXOa7RFfDu5+RH5lAOA/2XlovstB8va10B5l853XD
X-Gm-Gg: AR+sD13wEBsZiB4FQ1wR3fHcfFV+pdB0rPaZCDe28gkZhYQpGWJG0fVVTW8xEg0veoI
	+Dhb3jNEi9PRt7Zv4urlWYKjgRr/dnmZTO+RjvPiCQo7nSuc5LFm1Ws7I/sGS67lCQ0ZX2ZVT8p
	2VzQVIm5kMg8qQXULx2c4iYFaWxcfgwUtcsP8ZEWwmA+Z/Dt47OmfM+njXSItdvMNKztb9OKQew
	DJf8oZCHoWWVZL9ZytqIhVkoU52MpX8Qc6eEK5t+/eBLlLqw9QVWPhcQUsYT/ht2QcuMJ87bgYb
	XqxLlMPDjRZ04LKMykamPA3hj2eToVDFpWWT6+jWpQxsiWtLXTTns9nWVv2qO/f30dsQqt3P41u
	qrSXvBWHeDrMH2kD4Zeit4HcY6WlwQqR94fxMA+NNeHL6INsd+ykft9bWdUTUL+s5sPGwqThN6d
	LEOKdt2ZLG3wk4/WVWOqM0U+1BtYmXTC99XF3Q+5IEtoKpSSq7J9RkeTEa/BFWYGC4LHiSFKwBx
	gI/Vw==
X-Received: by 2002:a17:90a:60f:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39302882a32mr732420a91.10.1786497529024;
        Tue, 11 Aug 2026 18:18:49 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8901c1bsm1549721a91.8.2026.08.11.18.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:18:48 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 2/4] ntfs: protect attribute-list buffer replacement with attr_list_persist_lock
Date: Wed, 12 Aug 2026 10:18:10 +0900
Message-ID: <20260812-topic-attr-list-lock-v6-v7-2-2f35e0a38bfb@gmail.com>
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

ntfs_attrlist_entry_add() and ntfs_attrlist_entry_rm() replace the
in-memory attribute-list buffer and then persist it to disk. The swap
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
 fs/ntfs/attrlist.c | 172 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrlist.h |   1 +
 fs/ntfs/inode.c    |   3 +-
 fs/ntfs/inode.h    |   3 +
 6 files changed, 165 insertions(+), 34 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 0f48dd923b72..ef918a73fb0c 100644
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
@@ -3792,7 +3792,7 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 				goto out;
 			}
 
-			err = ntfs_attrlist_update(base_ni);
+			err = ntfs_attrlist_update_locked(base_ni);
 			if (err)
 				goto out;
 			err = -EAGAIN;
@@ -4168,7 +4168,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	}
 
 	if (attrlist_changed) {
-		err = ntfs_attrlist_update(base_ni);
+		err = ntfs_attrlist_update_locked(base_ni);
 		if (err)
 			goto put_err_out;
 	}
@@ -5029,7 +5029,15 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
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
index b8594037df40..aa6d5f10bf96 100644
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
-	u8 *new_al;
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	u8 *new_al = NULL;
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
index 38206e2009e2..ede16196ed0c 100644
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
@@ -3147,7 +3148,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		goto rollback;
 	}
 
-	err = ntfs_attrlist_update(ni);
+	err = ntfs_attrlist_update_locked(ni);
 	if (err < 0)
 		goto remove_attrlist_record;
 
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index ed00e06c5d14..a6c5b15d648d 100644
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

