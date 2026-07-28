Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E117A2E8
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198704; cv=none; b=kAeLoBJ/M5Y0z8Izxi+mCUqMBpkO30JlpjlUEHPmkgtd6X8nru7DNr4VH4OFjHcyqFfmXdMLRw1GjNucppIsoEPhDIbY121CehMEAVp0i4WmYmDfUv3e29+NjvPA3kLTb1nTeJ6vw0+CuUhZivYLSiVbqlpIMQ9BLIcGNAQDtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198704; c=relaxed/simple;
	bh=wpLlR73nDZ9Tj4/trzc2wtCRxSQRruW1vjZelT/CFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXGOD+A8IDFaPLeamPz68UwQkOnFAyQN90zEa+IjCTUY1rNCcEXnyPRDQFzOMmD1t+80FQ/+2qHBufOHbR4Q9SgVVRmf5ZSGOKIxAPv3dwJB6aioiAfDUJkoFUZ8spwSY+hZJqGYcciWreG8ApajZ49vX1A0KDrYQhvuli8xbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4jrykAR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4jrykAR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486ac3f347so422475b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785198703; x=1785803503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ptrdJnlM84nspvAhZJJQdOIAu0Xk8SBFZytDRlcH6M=;
        b=g4jrykARTJQG3H5Ogw7cBz4pbkqoposbMmCbQ2xrxs8BGVa+SSvE6b5FaeRGJjLzz/
         Az7TKUNoHifVwV0OKkGA90VMdInvkL0IsgePdd2R/f9Miy9bfHtEtjTXKprmnE9xmoei
         GLjwHSdr0Ugm9N6ZqoPlhiJMgXBTv58mrK9PEisJu3cYu2Raf1UuueJ2kG50nKja6Cvh
         UZVa1McRuN4h7etO7pVkpENW01J9DWRWhutwdhTpoZ4cTJzvwsWFoaVewwNs9vT2Xosh
         glYKs10poRojhru6lnAgZyLTSKzAS3sQ965iUeEVPJpwI50KEBMHyROr1WBTnI7F6RpZ
         Jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198703; x=1785803503;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ptrdJnlM84nspvAhZJJQdOIAu0Xk8SBFZytDRlcH6M=;
        b=T6OAzjT43Eeceod65UtmhFYUPowoy0GZW504Of9qSCxEXFJ/ip+7M+p6OxRUQm+qBC
         s1IRVAv3InHINZxiYzKcKsNsgPdECrx1DefLu1ZGwrQr9AdJIOOw5y6vjXddC8cugMpV
         I7Oy3oCS/CtI2bKOeTUd7cfa/YK8HCtY9l7smfAAzKx2IRzIEOCI+BU3wNir8k6XlzJZ
         nWGIiiF1VxzAH8WbzLSBO0vh3qKGfNigByQvr7E5QgtIXJNZoccYZT7nflKyqxs4PerJ
         58nvjTDDnhGfXMi9zHVA9rmFlCK2XGbZr4uQyK08VgvrrARAo2dYhroKr/oBZdPyoyu7
         4G6A==
X-Forwarded-Encrypted: i=1; AHgh+RrMNzVjtaRu3IuFJTj1SbeMNM5o2t1fC9Tp+16HqtB/1wLCnv0+bhrCnq5baIzWSkOE8eT9dvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VePGlGtQGMkBQoGKdoeYWEW5gCKXabx/vSkhkxiKCEpST353
	aEnkkjvR9Bg1O0wri46bULBjaUk2wq96bX7ebNS2XE498r+VDLkxOuBK
X-Gm-Gg: AR+sD10iuDf5nYW3iIQ0r4INwHSU+CUTL9cA+pQWRiCXP4YKEJVkdHX7eYaMRAtr9Hz
	5oggpTe5uvfs0jONzmyPyys+YOxDp7rQ32LSICUHBu+NZy3T8a7snrgrTHPYiNxFh6sN6Tf+WD0
	IFsqRhHbembI5LeusbpWYw7C368xt+dlI+lZIvfacbzLKhafhoziRWBDPr1Zby45BVsLAAh3U9S
	QhDP5xSIq1Jx4LNkg++j//2nH5iTcym7pa6/dyCXezOJ9XFynZ4emrrC/V3eq6xMl2rlFkn4EKh
	rk6uyqnZbVdZcWOM8dD/VfT+sRL1X6yoLLFmsyM92vJ8HvkxtGeeJqk89HNQj4rqPZXNRFdh9iR
	QDo23l4NuNHXVLRemT2t37vMsdkp8TS04pPS2VB1L/KmYPfCOWhMC4UcJ5W+Tk8itwIQquGuV7C
	d4oJtYsqfO1ANJgIoqjlegOyj9+A==
X-Received: by 2002:a05:6a00:12d1:b0:848:52bf:4296 with SMTP id d2e1a72fcca58-84e93124e23mr130675b3a.15.1785198702642;
        Mon, 27 Jul 2026 17:31:42 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f54esm3571094b3a.20.2026.07.27.17.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:31:42 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] ntfs: protect attribute-list creation/teardown with attr_list_persist_lock
Date: Tue, 28 Jul 2026 09:30:50 +0900
Message-ID: <20260728-topic-attr-list-lock-v6-v2-3-270ad764d0a4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728-topic-attr-list-lock-v6-v2-0-270ad764d0a4@gmail.com>
References: <20260728-topic-attr-list-lock-v6-v2-0-270ad764d0a4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785198351; l=4664; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=wpLlR73nDZ9Tj4/trzc2wtCRxSQRruW1vjZelT/CFP0=; b=9Y0ccAxl1v0X5+zAW3kYWHRxfzwiOx90RY6SI/L13WMhtqYYW46fheQw/PpF3ZZpZRWHPx/HC 67QeiFbTYOFDBfAVIpQND1AhkY+dtgXPuBe7n4gOkwZj36TWOzuxlr9
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
 fs/ntfs/attrib.c | 11 +++++++++++
 fs/ntfs/inode.c  | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 378e655c7028..00ff223d9c21 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2816,10 +2816,21 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 
 	/* Post $ATTRIBUTE_LIST delete setup. */
 	if (type == AT_ATTRIBUTE_LIST) {
+		/*
+		 * attr_list_persist_lock serializes this in-memory attr_list
+		 * teardown against a concurrent ntfs_attrlist_entry_add()/rm()
+		 * transaction on the same inode.
+		 */
+		mutex_lock(&base_ni->attr_list_persist_lock);
+		down_write(&base_ni->attr_list_lock);
 		if (NInoAttrList(base_ni) && base_ni->attr_list)
 			kvfree(base_ni->attr_list);
 		base_ni->attr_list = NULL;
+		base_ni->attr_list_size = 0;
+		base_ni->attr_list_gen++;
 		NInoClearAttrList(base_ni);
+		up_write(&base_ni->attr_list_lock);
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	}
 
 	/* Free MFT record, if it doesn't contain attributes. */
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index c568ddf851f4..4ac63bbd47a6 100644
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
@@ -3153,14 +3159,21 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
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
@@ -3171,10 +3184,20 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
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

-- 
2.43.0

