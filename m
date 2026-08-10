Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E0392C2E
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339213; cv=none; b=olGKAWFw6qn4+Hb8ThzlCet+XRR4JuKA4Z4bjJRavUKej/NJNOltQ7vE1KuotLSVUyXgdUFAKVJzmJJL4cSBPRjLkGpbRU6qwiVad8+O0XvoQo1VUkWDZa9hksL2FFREL9IIPWndzg5V0SRseu2llpwh0YLcAie+hT6Q8KSi5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339213; c=relaxed/simple;
	bh=+dIAtgTl8zTgGmwmddPgYmLCh/rwaNskrVPR8D+FcL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oibzlSzv5JyLDpJ0dnXiGIWXsAcLkxUubCR+lx6uwENVWCdlmb9YSRa2jm422/U6U0ZBhxo1kYjirtV/UEYURYa5qCMyXLE4Rb2bnAeMPEl3sD2ISq5VxNjtLox3IRIIK0WoHWsgpcLqnR2qydQoLOqazOWav51jv3mMbBvQZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+LCTYdJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+LCTYdJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce98cb8165so12640995ad.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786339211; x=1786944011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ydk2qA2ievpCRWUQNUyDGVlHRr+esfMkMWAoxsjxlKQ=;
        b=N+LCTYdJ23JkYQ0AZxf3SHLEMqgrN9WPYdtfZdXGJTwCH5RpYTd7XyfuwXSFWLrVJl
         8wftqphZiFnylzf3qAZgcfSimQBl5L3kQ/QhFuxOrIYjc5RCAqwGQZU0PlhQdBZIwRnY
         0w9S7T9mdOu9A4sShXs/+z0/b0//QGgtmkfCDLvk9J+vz9fu00CbN9N5Niw7ZCpyKizY
         VMt2jmqHlqunxYyOJjcCBXKuzBS4vvNsC07mNnO1g21Z13IJSkkYryI6o28vzm5jsfAj
         gD39x9GtTr98o5RPC2VLlKIFERqlQxgzgfevAEzazeoikfJbIhrRzvfEdDmv1xRbnKk3
         xMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786339211; x=1786944011;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydk2qA2ievpCRWUQNUyDGVlHRr+esfMkMWAoxsjxlKQ=;
        b=N/lAHKKLanFmp4AsEjOJm70IahffWTsszcFRn0Wo0UoioD32ArIBglCsNeFeZAKUHy
         LUDb48Q014O0UOIig22yHSDQH8TKmUWA75aLn/gavGZQzMwTGPblgQbviTIFPQSPvGJ/
         5JfQyJIfXn2YOyite/gmtIJrvY0g1C8Us6CojMM1UODDK6jO9fcp/TuDdlSXXmDhmfZu
         6yyJm0Ilh3A6AtpkyjdLGimiAW/McklP2zf46852hRw3uSBZ1h6SQI6dQKyON7y8JfsE
         gB3gFunBpR5SRGCFjUDoIxMTBJwU9LSmCpLU65dcn0Z9YeHrG4YJ3nBiUGp3ueuT3BNt
         Rh1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8WKPUpzSpc6Jy12Hk7ERTMdX2BUEH6490WRfM3BjKt/bTfBv3e3Dr1Cef9h01X35yB6Qfbqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9rDV4FLRek0rxTG/eX3rjh62aF1MSvXvGboflAoazGajiYlz
	C3Bxu5fn5sOazBuvHWqpKPxsYcynyH1Yv5mJ7mbnnwdeG48wvSZ1rSb4u2ddxg==
X-Gm-Gg: AR+sD10x3GPqTStRQud9bUFmT//9SittxFSwKURPzi/CGWm4YsduVDEjo5ssUJ9lRIz
	FIqA9VIbq3YdAyb8XEkU2nA1w8fuFgYGLHHnVOwklEHJyHuGYj+UhPnA59NoSH+MsSW5j70e41/
	c/99KAQuE012lvnxRH43B/8N+nuNV6az0wpmLxlXyPGHn5DuHBjOX/Hh4KDIxH7pejvJ2IT18Ty
	MmUWtR3WKhQfKltndyPx+a4o6aJNZW8F3oyO/CFpvvc7vrdsfbLTnS5INRFiPc+4jzKlfZH7jyd
	05oMuNYCaezuROmD1W55eTmppp0cpslKcCfwc4Sp6cgjqrMRj93dz7utjtJ/1AuV45CCGu2Fapm
	LOxc57jy40YHmwISmcR4i503907ZqFnyPh1QChGovNV7qiM9gam11kkI2or3fTrUTGd7CHA5lwp
	P6hsXLrDgr6+8IE4Dto/slLmDpBbwTOtFQge3VPp/iPrVHfzeHQoX903TirtL0AQTrzrk=
X-Received: by 2002:a17:902:e84c:b0:2cf:af20:4254 with SMTP id d9443c01a7336-2d2b2e5e10cmr175755275ad.10.1786339210593;
        Sun, 09 Aug 2026 22:20:10 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac191sm28749235ad.15.2026.08.09.22.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:20:09 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/4] ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock
Date: Mon, 10 Aug 2026 14:19:41 +0900
Message-ID: <20260810-topic-attr-list-lock-v6-v6-4-e3fb8c4494d3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9978; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=+dIAtgTl8zTgGmwmddPgYmLCh/rwaNskrVPR8D+FcL0=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqeV3dlSj/dUHU3pTUo8eSsg55PifsepTGkePwg
 Ezx2zgosEOJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCanld3QAKCRA08jD6945I
 010wD/9O83FTbK1kp8P1b72mj4Ko32h8ChvhfYjN8SQnDAejuhmVKBidfT0U/FuA0IKRMTpckr7
 BfnOynsCX9tZwTnn+WHYAfIiGGEGwPLC6ND7a6HKFGRXs5Hdre73bKCGwzHoNVbeamTyHsWu4Q9
 1zaCf8hB2Ztj39602YDKIsf3CjW9SOSzG9NOLBN3S5ZYF+u8m/AkPA4Oisy/GbfFKOVq5sClNtb
 4M7m5+xnIRqVIDCvoyYULeOiiwRIjGY7+St3Xuj4sRzEkWb84RLQBfrFmKHAh95+pgyS02ZQrwv
 57a7wUAGxaeMkJhnOuXkFEK4heE31WWi8CUPj5uoJDvijTyCUJr7iLlqLhtpHMYInF5xsktgdiL
 cCvHsUASj63FQV2NJu2xxbdYNyNy8cOQ1i4uSyUK0xnsM4NtoOuuLCI2H+CoDX/9mSK3ihvvG9V
 00nj3BBEE825S0wXakPSlZx8dyRUCUxyxetPdCRm6hf7Q/mn969xzwTCmeOiVV15ewoG7AV5EBR
 pTyxRyXRCgGfxsiBVBoU1eiVgQZ9uy/hlSdimM47dx3Q1I1AqHkxHc15iOLt79tGEkvhSyiOCg6
 DDUwoZJkwSAPi9crsbK3sxIUkezKVhZIiKs1uOc5MwecD6AGPO0dB5W+mQWhuCwfTteBUGGd3OB zEHhFye1176heHA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
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
index f45f0289e3d3..2eac3493a43c 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -3718,6 +3718,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		base_ni = ctx->base_ntfs_ino;
 	else
 		base_ni = ctx->ntfs_ino;
+	lockdep_assert_held(&base_ni->attr_list_persist_lock);
 
 	sb = ctx->ntfs_ino->vol->sb;
 	if (!NInoAttrList(base_ni)) {
@@ -3726,7 +3727,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		return -EINVAL;
 	}
 
-	err = ntfs_inode_attach_all_extents(ctx->ntfs_ino);
+	err = ntfs_inode_attach_all_extents_locked(ctx->ntfs_ino);
 	if (err) {
 		ntfs_error(sb, "Couldn't attach extents, inode=%llu",
 			(unsigned long long)base_ni->mft_no);
@@ -3790,7 +3791,8 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
  * update allocated and compressed size.
  */
 static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
-		struct mft_record *m, struct ntfs_attr_search_ctx *ctx)
+		struct mft_record *m, struct ntfs_attr_search_ctx *ctx,
+		bool *attrlist_locked)
 {
 	int sparse, err = 0;
 	struct ntfs_inode *base_ni;
@@ -3827,6 +3829,19 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
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
@@ -3953,7 +3968,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build, attrlist_changed = false;
+	bool finished_build, attrlist_changed = false, attrlist_locked = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
@@ -3978,9 +3993,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
 
@@ -4051,9 +4073,13 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4090,6 +4116,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4110,6 +4140,18 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
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
@@ -4226,6 +4268,12 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4352,6 +4400,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return 0;
 
 put_err_out:
+	if (attrlist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	return err;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f62d72857558..a52762b4659f 100644
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

