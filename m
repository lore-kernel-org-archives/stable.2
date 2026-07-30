Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D43A4F35
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387436; cv=none; b=oYVjgsIxt5IcNPySWRy+5rod0/gJVO+TglMq+IFGQ94L5MmLM/fepyFfNf+68FuEIY94W2o3ROBvyL/Ft6pTNZf6WQtljxdfImpvJYh+9ypqgwtAd9hrEM3SA9I6wJWRmlUs6N+aqA0EbhXOcHh8gCY0Yj/cLgv12ui6Mv/Fm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387436; c=relaxed/simple;
	bh=9XBvHat/s3s0SOpTqfMbJVgrtlZ8oOBTRDq9UDYzGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AombPtcqbcwCtTmRUJ4xKzdZEUtPX9DCsehJXPa2acUmHhrfxKHxDAKHKOXoAtRaDkYQYUWmy87CwhNCByyOBjcOP8+vopQnE09L2O6Yqo8FZDra7O17EGmB796db5C+oEAsuPzf6sE+B9GtRGgH+Gs6QGMQmwahwROZQjPgQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw4Whkrw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw4Whkrw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf52d15d88so16302745ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785387434; x=1785992234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qURMdIA34CKyjqLkDIq3HnEzln8S+2wLoVCqh/odCh4=;
        b=Xw4WhkrwaGN4x8FiIm/e3BFzX1sFWHSL5nMzatQrYcrSrvPCvqhwAV/zyftfklqTff
         zEbpK8ebv3byeZCE6u7IgHgCZiNTkNofur9z/z16NqAdKOSFDbUMejBbZwEcZ4PT8us1
         xUKDN0uNnfGS5iB74NAHSFaf74/DOY97cGwSn4ZiTWmNnB9LG4TooktzlvaS9CmSTFT0
         72lQuRhFK0a1BqHflbvm0FYN7OgA1ufifjD1ywsW7K0jfpOGVoZdktAAyPzf1Sa2p2cn
         unXmSNq4925SB1HcgTUF7y2QwlXth7Ws0c8ioN+cOO3lO6gzEAKZPiLJ5FxatXXDjCZt
         G01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387434; x=1785992234;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qURMdIA34CKyjqLkDIq3HnEzln8S+2wLoVCqh/odCh4=;
        b=ph1fyMG3UtYMWGV3XYfC+fqMjfCddNWVMbMLnv+tUdN23pGHoORPsylGdY63Rep6IW
         yGEHGopeHPhoWDkC1Jpn2+RY9c4NHVUCKZHoIDZBO6lO6dBkF441d3Q9OPJf8S9Sdhrw
         w4h+oau4vPQMs5JU/CIefgD7bqqMUattN86iObqpQH4wH2zRAr1SCkmA2PF5Tr8ekmDF
         803EN9Wzqr1hVMxd/EiOmQp5a5nE1nfBWiezq+8fqH2b2ZihJwGHib9Sj9g+Nk/I+dnF
         9aI7hRx8ua8Ca9nr/1Y5SNfn71i8WgWYBKds1yn1hs46HgdNy6BIORN3co5aUYkMWUaf
         6SfA==
X-Forwarded-Encrypted: i=1; AHgh+RqfyQXuGopQ4ZJJ3JKmgGdh9rBsfFkP8EMWGwN8Em58xuba81CZqDfjnNb1/jkj5v+xiJg8aTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvWn4TvCGxK5bgYQ5jlOmCeHqgxxGB53PdTmk85PlAJ1y52ZQ
	ZFwaIoy6TgW/o/a4VQUR7XZe9eksroC2aNcSGlO5c3jh+nvkRvtNNi7Q
X-Gm-Gg: AR+sD11Lb2TSnoF/QYt/2K/zMsZvAZtPYHedAY3rh3XsxiDKRVYoJBDUFtEJFhzP3lM
	m2gK5DUR1AWAuZOqeZGscs/hUzdPDCEQaMIRXoXUJzsidTY1REI+pxNP0xvnh13upTFKRH3C1NL
	NfRNGXR2dxQQEVTk2WhHxfiWEmcqUf+P3LdD9UyLIZUXrTRb9j5FJyE6wEdxrsY44lyUcBgRAUF
	NuZ9gY4oYNSgaV7Lt5anpDXxIt1oylmQNp+AAd+ErhKotW3Mcf5lQ/SvfP4HuVQE3VSpYrdSPUy
	msmn9nVG3yoyE4V/FtN2y8TFJ3M48CTl011utxYGmSjrGPGwPRpEyBE8FAPhaxw++ZUbm8lWBYy
	YcFvBFV0X825Tc7APcQnE+Cm5qsoCGLaqqb8EQ96GUqbRY04p8g262+X0H55dSBMtb5mnwH5uP1
	pa0darvIPhdivk9xo7k8h6hVt+AVDi/TzyjX6oG4d7qjbpwUjB7/PQMM8zScLUZV30+YnAkayHa
	zjfVFSZX9ly6Zjf/3K/lEI=
X-Received: by 2002:a17:902:fd87:b0:2ca:b48f:3395 with SMTP id d9443c01a7336-2d035cd397bmr12520485ad.34.1785387434139;
        Wed, 29 Jul 2026 21:57:14 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46969sm19875325ad.25.2026.07.29.21.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:57:13 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 4/4] ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock
Date: Thu, 30 Jul 2026 13:56:15 +0900
Message-ID: <20260730-topic-attr-list-lock-v6-v4-4-80d5fe0a6951@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785387323; l=4387; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=9XBvHat/s3s0SOpTqfMbJVgrtlZ8oOBTRDq9UDYzGcA=; b=EzODELIuVIGWadJaRrv4M8qaxLG5TxiKBZRkmKgGUHTNZLNlBHEob8l11zUQmRI7xOGJUXOp1 AYWT8oBlMwdDXtnK2GrK7i+tEWQAae5V4Ii50dZ6LXnNMmT7mQ3FVSa
X-Developer-Key: i=hyc.lee@gmail.com; a=ed25519; pk=XjFN8PRLk/ZCdNmwABbNomUbzLtXDFRX8iJkKn3fgGc=
Content-Transfer-Encoding: 8bit

ntfs_attr_update_mapping_pairs() updates several ALEs while rebuilding
a fragmented attribute's mapping pairs and persists the attribute
list once after the loop.  Each ALE update is covered by
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
 fs/ntfs/attrib.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 0fdcf6757d02..0ef3b6d61b2f 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -3905,7 +3905,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build, attrlist_changed = false;
+	bool finished_build, attrlist_changed = false, attrlist_locked = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
@@ -3930,9 +3930,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	else
 		base_ni = ni;
 
+	if (NInoAttrList(base_ni) && ni->type != AT_ATTRIBUTE_LIST) {
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
 
@@ -4006,6 +4013,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		err = ntfs_attr_update_meta(a, ni, m, ctx);
 		if (err < 0) {
 			if (err == -EAGAIN) {
+				if (attrlist_locked) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				goto retry;
 			}
@@ -4042,19 +4053,34 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
 
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
+				if (WARN_ON_ONCE(attrlist_locked)) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_add_attrlist(base_ni)) {
 					ntfs_error(sb, "Can not add attrlist");
@@ -4171,6 +4197,12 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4298,6 +4330,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return 0;
 
 put_err_out:
+	if (attrlist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	return err;

-- 
2.43.0

