Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED321D5B0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497542; cv=none; b=WENJqoh9TRbdDuPjip4GSJl9+Ux2mohbuK51qQgn509QigwwTsZEB22uih5LFFEZ2RnkzUZLMByF4ofG+XYMG2IcjWw7cCwdS55NdEuT/7WJGuC3npWsJ8IjaxP0CXv5E7xigiBa9Qr6/t4PZxuqf8U9MBoWZ7dIZUJDDs7B0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497542; c=relaxed/simple;
	bh=7L/6CL2jTUhRzY+/8u961fBjyMETdCHne64mD2c+Brg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ3Y0/kEHG9lX0wIK6hmRyE3GLHE4mibq0NMxVLxPeJF2jacHIvsRXFxnYYCU9d3Z/0NmXZGwJXIxKYwh4u8perBJZrz1EIviDHWmW4cOs42M4J+aXB8qy/B1BedIIZ0IGQrlhvh7+OZaTE5hAE8ufS6nCbzdigaesqQkoGTaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0w/aBeJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0w/aBeJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so472756a91.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497541; x=1787102341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IvZvwH+550uI0E8ql2VQHqU2n9WP8WUJ2Hg9kzGW3Y=;
        b=o0w/aBeJIQx99zv7+cUVrFWlgGZ3T/gFm+otGt79QP/Kc8J/wX42hHzAX7cptFP/9h
         zXUb5ywcKGPSC/Z7EvbvRGdLu+9NpssvmdSGaE99yIjrlWevlEJkF85BO1t4byHtf7rd
         Ga9G30G8FVJ/xtiisewzzNA72/mYCVZ3ateuJv8ptgxKSTVpfaqRY37naLWBtif7LGjW
         2QS6xizVYQJKT7zpgcGfn/MjKg6vJpamurIOEKaFCtLkBVyjaoNi/+/GOIIo4iCrMEmL
         6oLU2B/QaSRMnS4iHisfQ8lD9hg3ByNdrrAEZC+KFACMESI8Pv/ZwvhYNW67ah1u8/aG
         wPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497541; x=1787102341;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IvZvwH+550uI0E8ql2VQHqU2n9WP8WUJ2Hg9kzGW3Y=;
        b=Yl7sEpOqmta6RfXrtcJybgiJufqB85u/uiYWjLuEuWGp3W5btV8jYUTrSAXt8l83dQ
         x9sY9/WZdyK4I7hHUN9SvhVQnq8G7TPYpCzLZjtc+l2iTRXS0scSEqq9rtapfapwss41
         p22Ta94OXW8aASlKysWvkI6lF2wzN7s2kmWgt4KGp10Tvr4J67c+HEPr0ziv5I7YPT95
         YOWTEvnfXAI09EDTUE90Jw2RqnYn1L+BOxRAgOAe89WSrUIrLQfowUEWjTyzzufeLZ/u
         Hd9X0wgPfdElFQ57QKuvA98ezWgeVmmyrCcmq0QrXED6QYE1zN3RXhIaXjaRpui/eJPc
         BAOA==
X-Forwarded-Encrypted: i=1; AHgh+Rqo3FUEouLqARIb4Mj6oakoE0EHwnR/598JUl1B+WjzKYWtD6keSX0V54IE/g4wdS++NPMXHlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+s6YMzYuRz5LRuFP6CoAad5iOqKLvIRDZ8BPBj0HzjWWUprY
	VUwGYGK2AE7mN7oFqdRKbrCMHo9fdNXZ0o8Es5irPcw8Kg4doSSROV5/
X-Gm-Gg: AR+sD11/7baxyFtA8etUbShZEc6MqsPMKlnOrTfiRbynQmGz/eghHBYLeRCCL09ir/R
	nSZCX2MwoPvK1p+uKD5jI/8MB+NKfesvbIncepzwUet6E+yKeg9flYbBn9KQlxg6PbfzdM8Gfl9
	wKMmUXxiWjxxEMcF+0FwrH0rDixJIiAx59qkpUsakLYBjxzc4tz7zEw0ZqLtpeqMlijGlnSUFou
	GwEgVJ+rZkhbRjvHUGwDIiCSEbQQ11RhimkM2G5jAifO5G/oMhPvLWRhreKBglctjfm7g3wGrqF
	VI85BatTeR1OqGrOn+e9vImCoesy9ry6gSyo25EXI5ZvFKx8zOmgGaf60+axXINCtmHIEij5k9b
	7sZjf+6TCjscRwbcJg0MxQ/rw6gRcLesuvxrJUhfKHwQE4MwuVlB94BbaLu9t/h3bJKk3/RiUl6
	3bcH5Zi27x3KSEKU8Ok9YY/cDqjhXpVe5gxiZNVLOGCTqWnFFvBXABaG+CIR7qMMFivOA=
X-Received: by 2002:a17:90b:4c90:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-393012cf07bmr1321749a91.2.1786497540678;
        Tue, 11 Aug 2026 18:19:00 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8901c1bsm1549721a91.8.2026.08.11.18.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:18:59 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 4/4] ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock
Date: Wed, 12 Aug 2026 10:18:12 +0900
Message-ID: <20260812-topic-attr-list-lock-v6-v7-4-2f35e0a38bfb@gmail.com>
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

ntfs_attr_update_mapping_pairs() updates several ALEs while rebuilding
a fragmented attribute's mapping pairs and persists the attribute
list once after the loop. Each ALE update is covered by
attr_list_lock, but the overall publish/persist sequence is not
serialized against concurrent ntfs_attrlist_entry_add()/rm() on the
same base inode.

Acquire attr_list_persist_lock once after resolving base_ni whenever
the call can touch the attribute list, and hold it across every ALE
update and the deferred ntfs_attrlist_update() call.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/all/20260702161710.2606853-1-zzzccc427@gmail.com/
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Tested-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/ntfs/inode.c  | 46 ++++++++++++++++++++++++++++++++++++++++----
 fs/ntfs/inode.h  |  1 +
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index e52acbced9c5..d3621e5c24df 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -3717,6 +3717,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		base_ni = ctx->base_ntfs_ino;
 	else
 		base_ni = ctx->ntfs_ino;
+	lockdep_assert_held(&base_ni->attr_list_persist_lock);
 
 	sb = ctx->ntfs_ino->vol->sb;
 	if (!NInoAttrList(base_ni)) {
@@ -3725,7 +3726,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		return -EINVAL;
 	}
 
-	err = ntfs_inode_attach_all_extents(ctx->ntfs_ino);
+	err = ntfs_inode_attach_all_extents_locked(ctx->ntfs_ino);
 	if (err) {
 		ntfs_error(sb, "Couldn't attach extents, inode=%llu",
 			(unsigned long long)base_ni->mft_no);
@@ -3789,7 +3790,8 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
  * update allocated and compressed size.
  */
 static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
-		struct mft_record *m, struct ntfs_attr_search_ctx *ctx)
+		struct mft_record *m, struct ntfs_attr_search_ctx *ctx,
+		bool *attrlist_locked)
 {
 	int sparse, err = 0;
 	struct ntfs_inode *base_ni;
@@ -3826,6 +3828,19 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 		    !(le32_to_cpu(m->bytes_allocated) - le32_to_cpu(m->bytes_in_use))) {
 
 			if (!NInoAttrList(base_ni)) {
+				/*
+				 * ntfs_inode_add_attrlist() acquires
+				 * attr_list_persist_lock itself, so drop it
+				 * first if our caller took it for us. Nothing
+				 * is in flight that needs protecting: without
+				 * an attribute list no ALE has been touched
+				 * yet. The -EAGAIN below makes the caller
+				 * restart and re-acquire the lock.
+				 */
+				if (*attrlist_locked) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					*attrlist_locked = false;
+				}
 				err = ntfs_inode_add_attrlist(base_ni);
 				if (err)
 					goto out;
@@ -3952,7 +3967,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build, attrlist_changed = false;
+	bool finished_build, attrlist_changed = false, attrlist_locked = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
@@ -3977,9 +3992,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	else
 		base_ni = ni;
 
+	if (ni->type != AT_ATTRIBUTE_LIST) {
+		mutex_lock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = true;
+	}
+
 	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		if (attrlist_locked)
+			mutex_unlock(&base_ni->attr_list_persist_lock);
 		return -ENOMEM;
 	}
 
@@ -4050,9 +4072,13 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			continue;
 		}
 
-		err = ntfs_attr_update_meta(a, ni, m, ctx);
+		err = ntfs_attr_update_meta(a, ni, m, ctx, &attrlist_locked);
 		if (err < 0) {
 			if (err == -EAGAIN) {
+				if (attrlist_locked) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				goto retry;
 			}
@@ -4089,6 +4115,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			 * attributes and try again.
 			 */
 			if (ni->type == AT_ATTRIBUTE_LIST) {
+				if (WARN_ON_ONCE(attrlist_locked)) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_free_space(base_ni, mp_size -
 							cur_max_mp_size)) {
@@ -4109,6 +4139,18 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
+				/*
+				 * We hold attr_list_persist_lock even when the
+				 * inode has no attribute list yet, since one
+				 * can appear under us. ntfs_inode_add_attrlist()
+				 * takes the same lock, so drop it here; no ALE
+				 * has been touched, so there is no transaction
+				 * to break, and the retry re-acquires it.
+				 */
+				if (attrlist_locked) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_add_attrlist(base_ni)) {
 					ntfs_error(sb, "Can not add attrlist");
@@ -4225,6 +4267,12 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		if (err)
 			goto put_err_out;
 	}
+	if (attrlist_locked) {
+		mutex_unlock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = false;
+	}
+	if (attrlist_changed && err)
+		goto put_err_out;
 
 	/* Deallocate not used attribute extents and return with success. */
 	if (finished_build) {
@@ -4351,6 +4399,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return 0;
 
 put_err_out:
+	if (attrlist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	return err;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index a304a2ca22d8..60a1b690dbea 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2921,6 +2921,7 @@ static struct ntfs_inode *ntfs_extent_inode_open(struct ntfs_inode *base_ni,
 
 	if (!base_ni)
 		return NULL;
+	lockdep_assert_held(&base_ni->extent_lock);
 
 	sb = base_ni->vol->sb;
 	ntfs_debug("Opening extent inode %llu (base mft record %llu).\n",
@@ -2988,15 +2989,20 @@ static struct ntfs_inode *ntfs_extent_inode_open(struct ntfs_inode *base_ni,
 }
 
 /*
- * ntfs_inode_attach_all_extents - attach all extents for target inode
+ * ntfs_inode_attach_all_extents_locked - attach all extents for target inode
  * @ni:		opened ntfs inode for which perform attach
  *
+ * Caller must hold the base inode's attr_list_persist_lock.  The attribute
+ * list buffer is replaced and freed by transactions serialized by this lock,
+ * so walking it without the lock can dereference a stale buffer.
+ *
  * Return 0 on success and error.
  */
-int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+int ntfs_inode_attach_all_extents_locked(struct ntfs_inode *ni)
 {
 	struct attr_list_entry *ale;
 	u64 prev_attached = 0;
+	int err = 0;
 
 	if (!ni) {
 		ntfs_debug("Invalid arguments.\n");
@@ -3005,6 +3011,7 @@ int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
 
 	if (NInoAttr(ni))
 		ni = ni->ext.base_ntfs_ino;
+	lockdep_assert_held(&ni->attr_list_persist_lock);
 
 	ntfs_debug("Entering for inode 0x%llx.\n", ni->mft_no);
 
@@ -3018,19 +3025,50 @@ int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
 	}
 
 	/* Walk through attribute list and attach all extents. */
+	mutex_lock(&ni->extent_lock);
 	ale = (struct attr_list_entry *)ni->attr_list;
 	while ((u8 *)ale < ni->attr_list + ni->attr_list_size) {
 		if (ni->mft_no != MREF_LE(ale->mft_reference) &&
 				prev_attached != MREF_LE(ale->mft_reference)) {
 			if (!ntfs_extent_inode_open(ni, ale->mft_reference)) {
 				ntfs_debug("Couldn't attach extent inode.\n");
-				return -1;
+				err = -1;
+				break;
 			}
 			prev_attached = MREF_LE(ale->mft_reference);
 		}
 		ale = (struct attr_list_entry *)((u8 *)ale + le16_to_cpu(ale->length));
 	}
-	return 0;
+	mutex_unlock(&ni->extent_lock);
+	return err;
+}
+
+/*
+ * ntfs_inode_attach_all_extents - attach all extents for target inode
+ * @ni:		opened ntfs inode for which perform attach
+ *
+ * Return 0 on success and error.
+ */
+int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *base_ni;
+	int err;
+
+	if (!ni) {
+		ntfs_debug("Invalid arguments.\n");
+		return -EINVAL;
+	}
+
+	if (NInoAttr(ni))
+		base_ni = ni->ext.base_ntfs_ino;
+	else
+		base_ni = ni;
+
+	mutex_lock(&base_ni->attr_list_persist_lock);
+	err = ntfs_inode_attach_all_extents_locked(base_ni);
+	mutex_unlock(&base_ni->attr_list_persist_lock);
+
+	return err;
 }
 
 /*
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index a6c5b15d648d..a02ef1e59044 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -346,6 +346,7 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 int ntfs_get_block_mft_record(struct ntfs_inode *mft_ni, struct ntfs_inode *ni);
 int __ntfs_write_inode(struct inode *vi, int sync);
 int ntfs_inode_attach_all_extents(struct ntfs_inode *ni);
+int ntfs_inode_attach_all_extents_locked(struct ntfs_inode *ni);
 int ntfs_inode_add_attrlist(struct ntfs_inode *ni);
 void ntfs_destroy_ext_inode(struct ntfs_inode *ni);
 int ntfs_inode_free_space(struct ntfs_inode *ni, int size);

-- 
2.43.0

