Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06E3CCFC4;
	Thu,  1 Oct 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855198; cv=none; b=YwBpWfpPlHU+z50Nc6za8r8v6+1p7EfOKx/6OL25MlXLKuSNYAHWkw77yZIePhdSWvnafF0amzMGPrmjn0PtfZUuLU9yx1W/8e3Q4B+JU0qagbEb3GqMFdJXQ21dQfRvmqn7hpm/WfyM/l2rQqpzgI7njewsO1dJD/xHsy26YfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855198; c=relaxed/simple;
	bh=JHgxlnB6jw6ORN1jX8Etktnu14Bw2fKR9549FTDrZ5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hqu2kBRi0Aqu7p+50IfdDM0+xyS4ZiUU+lmAJXiQYCFt3BMGvSF5wu8k9EFcdlCmo/IL5UCoP++BmSt1+R99lrAKl2dJRZGgnONjk/MAa61E7pW+jz5OqQKkVWz2STXVTwMhm+vP2fiVyYj8uTNBV95v8WBjvHsBpD6/utgPAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=rr+B/Jrv; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="rr+B/Jrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790855186; x=1822391186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4coXXwK8WnaYhrOkWQjGjpZC4j0JtBULNCR/Pi28nw0=;
  b=rr+B/JrvKHUV6/e+NGm8o3Uyftbt3QfESHMSROTG6E7dg8PRHG12AZmQ
   FehgkKfbFqBOkm5uUA0IRIU48BR31Mxi+lu01312Q1xZ09gI6k1RgZI3n
   Ta2bWhGuBPSoRgzLMtCKPADZ9R4+x9Jnc1oOINV37zEdpAXA2VkH1CQIt
   Ja+0PndAMfb2eSOaOQ98tPwxZxWx9twOSBF3GncnxpKBgdYsazSvaxkVd
   qAhm5oeBIOsHQ7cg/jDvxokd8CTEN7lfrtDhsCvhSzTVHVHmcmp7rEJsw
   RDp/cFUyqESRbCo/gPIH9Dy3+Pd/HLPka/BOafwM2Q4b2DBeQIhlmtuVv
   A==;
X-CSE-ConnectionGUID: pshJg3xMTXyQG03ad2lIFA==
X-CSE-MsgGUID: fuF4RMtXRfaK0ZDDpSBu+A==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="30033437"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:46:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:23414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 7e5bb1df-3c99-43e5-95c7-fefdbc4cde39; Thu, 1 Oct 2026 11:46:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7e5bb1df-3c99-43e5-95c7-fefdbc4cde39
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 11:46:05 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Thu, 1 Oct 2026
 11:46:04 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y 2/4] fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
Date: Thu, 1 Oct 2026 11:45:47 +0000
Message-ID: <20261001114549.162469-3-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001114549.162469-1-nagornyi@amazon.de>
References: <20261001114549.162469-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 2afd4d267e6dbaec8d3ccd4f5396cb84bc67aa2e ]

Extended the `mi_enum_attr()` function interface with an additional
parameter, `struct ntfs_inode *ni`, to allow marking the inode
as bad as soon as an error is detected.

Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Backport to 6.1.y: passed `ni` to an extra `mi_find_attr()` caller
that mainline had refactored differently. `mi_find_attr()`'s `name_len`
argument is kept as 6.1.y's `size_t`. Kept 6.1.y's last resident fields
check in `mi_enum_attr()` but replaced `return NULL` with `goto out`. ]

Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
(cherry picked from commit 2afd4d267e6dbaec8d3ccd4f5396cb84bc67aa2e)
---
 fs/ntfs3/attrib.c  | 11 ++++---
 fs/ntfs3/frecord.c | 59 ++++++++++++++++++----------------
 fs/ntfs3/ntfs_fs.h | 21 ++++++------
 fs/ntfs3/record.c  | 79 ++++++++++++++++++++++++----------------------
 4 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index f4573d276a2c..db4f2dffed95 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -815,7 +815,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (err)
 			goto out;

-		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len,
+				    &le->id);
 		if (!attr) {
 			err = -EINVAL;
 			goto bad_inode;
@@ -1166,7 +1167,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 				goto out;
 			}

-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -1786,7 +1787,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 				goto out;
 			}

-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -2031,8 +2032,8 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				}

 				/* Look for required attribute. */
-				attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL,
-						    0, &le->id);
+				attr = mi_find_attr(ni, mi, NULL, ATTR_DATA,
+						    NULL, 0, &le->id);
 				if (!attr) {
 					err = -EINVAL;
 					goto out;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index fcdaea02ba04..17559fca5984 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -75,7 +75,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;

-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO))
 		    : NULL;
 }
@@ -89,7 +89,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;

-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);

 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5))
 		    : NULL;
@@ -201,7 +201,8 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 			*mi = &ni->mi;

 		/* Look for required attribute in primary record. */
-		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, attr, type, name, name_len,
+				    NULL);
 	}

 	/* First look for list entry of required type. */
@@ -217,7 +218,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return NULL;

 	/* Look for required attribute. */
-	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, m, NULL, type, name, name_len, &le->id);

 	if (!attr)
 		goto out;
@@ -258,7 +259,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (mi)
 			*mi = &ni->mi;
 		/* Enum attributes in primary record. */
-		return mi_enum_attr(&ni->mi, attr);
+		return mi_enum_attr(ni, &ni->mi, attr);
 	}

 	/* Get next list entry. */
@@ -274,7 +275,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		*mi = mi2;

 	/* Find attribute in loaded record. */
-	return rec_find_attr_le(mi2, le2);
+	return rec_find_attr_le(ni, mi2, le2);
 }

 /*
@@ -292,7 +293,8 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (!ni->attr_list.size) {
 		if (pmi)
 			*pmi = &ni->mi;
-		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    NULL);
 	}

 	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
@@ -318,7 +320,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (pmi)
 		*pmi = mi;

-	attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
 	if (!attr)
 		return NULL;

@@ -399,7 +401,8 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	int diff;

 	if (base_only || type == ATTR_LIST || !ni->attr_list.size) {
-		attr = mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    id);
 		if (!attr)
 			return -ENOENT;

@@ -438,7 +441,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,

 		al_remove_le(ni, le);

-		attr = mi_find_attr(mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len, id);
 		if (!attr)
 			return -ENOENT;

@@ -486,7 +489,7 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		name = le->name;
 	}

-	attr = mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	attr = mi_insert_attr(ni, mi, type, name, name_len, asize, name_off);
 	if (!attr) {
 		if (le_added)
 			al_remove_le(ni, le);
@@ -670,7 +673,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	if (err)
 		return err;

-	attr_list = mi_find_attr(&ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
+	attr_list = mi_find_attr(ni, &ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
 	if (!attr_list)
 		return 0;

@@ -692,7 +695,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			return 0;

-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			return 0;
@@ -728,7 +731,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 			goto out;
 		}

-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr) {
 			/* Should never happened, 'cause already checked. */
@@ -737,7 +740,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);

 		/* Insert into primary record. */
-		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
+		attr_ins = mi_insert_attr(ni, &ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
 		if (!attr_ins) {
@@ -765,7 +768,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			continue;

-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			continue;
@@ -830,7 +833,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	free_b = 0;
 	attr = NULL;

-	for (; (attr = mi_enum_attr(&ni->mi, attr)); le = Add2Ptr(le, sz)) {
+	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
 		le->type = attr->type;
 		le->size = cpu_to_le16(sz);
@@ -885,7 +888,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		u32 asize = le32_to_cpu(b->size);
 		u16 name_off = le16_to_cpu(b->name_off);

-		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+		attr = mi_insert_attr(ni, mi, b->type, Add2Ptr(b, name_off),
 				      b->name_len, asize, name_off);
 		if (!attr)
 			goto out1;
@@ -908,7 +911,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 			goto out1;
 	}

-	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+	attr = mi_insert_attr(ni, &ni->mi, ATTR_LIST, NULL, 0,
 			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
 	if (!attr)
 		goto out1;
@@ -995,13 +998,13 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		mi = rb_entry(node, struct mft_inode, node);

 		if (is_mft_data &&
-		    (mi_enum_attr(mi, NULL) ||
+		    (mi_enum_attr(ni, mi, NULL) ||
 		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
 			/* We can't accept this record 'cause MFT's bootstrapping. */
 			continue;
 		}
 		if (is_mft &&
-		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+		    mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
 			/*
 			 * This child record already has a ATTR_DATA.
 			 * So it can't accept any other records.
@@ -1010,7 +1013,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		}

 		if ((type != ATTR_NAME || name_len) &&
-		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+		    mi_find_attr(ni, mi, NULL, type, name, name_len, NULL)) {
 			/* Only indexed attributes can share same record. */
 			continue;
 		}
@@ -1159,7 +1162,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	/* Estimate the result of moving all possible attributes away. */
 	attr = NULL;

-	while ((attr = mi_enum_attr(&ni->mi, attr))) {
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr))) {
 		if (attr->type == ATTR_STD)
 			continue;
 		if (attr->type == ATTR_LIST)
@@ -1177,7 +1180,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	attr = NULL;

 	for (;;) {
-		attr = mi_enum_attr(&ni->mi, attr);
+		attr = mi_enum_attr(ni, &ni->mi, attr);
 		if (!attr) {
 			/* We should never be here 'cause we have already check this case. */
 			err = -EINVAL;
@@ -1261,7 +1264,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
 		mi = rb_entry(node, struct mft_inode, node);

-		attr = mi_enum_attr(mi, NULL);
+		attr = mi_enum_attr(ni, mi, NULL);

 		if (!attr) {
 			mft_min = mi->rno;
@@ -1282,7 +1285,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 		ni_remove_mi(ni, mi_new);
 	}

-	attr = mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
 	if (!attr) {
 		err = -EINVAL;
 		goto out;
@@ -1399,7 +1402,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 			continue;

 		/* Find attribute in primary record. */
-		attr = rec_find_attr_le(&ni->mi, le);
+		attr = rec_find_attr_le(ni, &ni->mi, le);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
@@ -3436,7 +3439,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!mi->dirty)
 			continue;

-		is_empty = !mi_enum_attr(mi, NULL);
+		is_empty = !mi_enum_attr(ni, mi, NULL);

 		if (is_empty)
 			clear_rec_inuse(mi->mrec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 482958c01644..d29fdefb477b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -733,23 +733,24 @@ int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
 void mi_put(struct mft_inode *mi);
 int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
 int mi_read(struct mft_inode *mi, bool is_mft);
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr);
-// TODO: id?
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    size_t name_len, const __le16 *id);
-static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr);
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, size_t name_len, const __le16 *id);
+static inline struct ATTRIB *rec_find_attr_le(struct ntfs_inode *ni,
+					      struct mft_inode *rec,
 					      struct ATTR_LIST_ENTRY *le)
 {
-	return mi_find_attr(rec, NULL, le->type, le_name(le), le->name_len,
+	return mi_find_attr(ni, rec, NULL, le->type, le_name(le), le->name_len,
 			    &le->id);
 }
 int mi_write(struct mft_inode *mi, int wait);
 int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 		  __le16 flags, bool is_mft);
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off);
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off);

 bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		    struct ATTRIB *attr);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index d8d43f6a96fd..1393e93fef13 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -31,7 +31,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
  *
  * Return: Unused attribute id that is less than mrec->next_attr_id.
  */
-static __le16 mi_new_attt_id(struct mft_inode *mi)
+static __le16 mi_new_attt_id(struct ntfs_inode *ni, struct mft_inode *mi)
 {
 	u16 free_id, max_id, t16;
 	struct MFT_REC *rec = mi->mrec;
@@ -52,7 +52,7 @@ static __le16 mi_new_attt_id(struct mft_inode *mi)
 	attr = NULL;

 	for (;;) {
-		attr = mi_enum_attr(mi, attr);
+		attr = mi_enum_attr(ni, mi, attr);
 		if (!attr) {
 			rec->next_attr_id = cpu_to_le16(max_id + 1);
 			mi->dirty = true;
@@ -189,7 +189,8 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	return err;
 }

-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
@@ -203,11 +204,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off = le16_to_cpu(rec->attr_off);

 		if (used > total)
-			return NULL;
+			goto out;

 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
 		    !IS_ALIGNED(off, 8)) {
-			return NULL;
+			goto out;
 		}

 		/* Skip non-resident records. */
@@ -237,7 +238,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
-		return NULL;
+		goto out;
 	}

 	if (attr->type == ATTR_END) {
@@ -248,41 +249,41 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
 	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
-		return NULL;
+		goto out;

 	/* attributes in record must be ordered by type */
 	if (t32 < prev_type)
-		return NULL;
+		goto out;

 	asize = le32_to_cpu(attr->size);

 	if (!IS_ALIGNED(asize, 8))
-		return NULL;
+		goto out;

 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
-		return NULL;
+		goto out;

 	/* Can we use the field attr->non_res. */
 	if (off + 9 > used)
-		return NULL;
+		goto out;

 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
-			return NULL;
+			goto out;

 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
-			return NULL;
+			goto out;

 		if (le32_to_cpu(attr->res.data_size) > asize - t16)
-			return NULL;
+			goto out;

 		if (attr->name_len &&
 		    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len > t16) {
-			return NULL;
+			goto out;
 		}

 		return attr;
@@ -290,71 +291,75 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)

 	/* Check nonresident fields. */
 	if (attr->non_res != 1)
-		return NULL;
+		goto out;

 	/* Can we use memory including attr->nres.valid_size? */
 	if (asize < SIZEOF_NONRESIDENT)
-		return NULL;
+		goto out;

 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
-		return NULL;
+		goto out;

 	t32 = sizeof(short) * attr->name_len;
 	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
-		return NULL;
+		goto out;

 	/* Check start/end vcn. */
 	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
-		return NULL;
+		goto out;

 	data_size = le64_to_cpu(attr->nres.data_size);
 	if (le64_to_cpu(attr->nres.valid_size) > data_size)
-		return NULL;
+		goto out;

 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (data_size > alloc_size)
-		return NULL;
+		goto out;

 	t32 = mi->sbi->cluster_mask;
 	if (alloc_size & t32)
-		return NULL;
+		goto out;

 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
 		/* Can we use memory including attr->nres.total_size? */
 		if (asize < SIZEOF_NONRESIDENT_EX)
-			return NULL;
+			goto out;

 		tot_size = le64_to_cpu(attr->nres.total_size);
 		if (tot_size & t32)
-			return NULL;
+			goto out;

 		if (tot_size > alloc_size)
-			return NULL;
+			goto out;
 	} else {
 		if (attr->nres.c_unit)
-			return NULL;
+			goto out;

 		if (alloc_size > mi->sbi->volume.size)
-			return NULL;
+			goto out;
 	}

 	return attr;
+
+out:
+	_ntfs_bad_inode(&ni->vfs_inode);
+	return NULL;
 }

 /*
  * mi_find_attr - Find the attribute by type and name and id.
  */
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    size_t name_len, const __le16 *id)
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, size_t name_len, const __le16 *id)
 {
 	u32 type_in = le32_to_cpu(type);
 	u32 atype;

 next_attr:
-	attr = mi_enum_attr(mi, attr);
+	attr = mi_enum_attr(ni, mi, attr);
 	if (!attr)
 		return NULL;

@@ -460,9 +465,9 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
  *
  * Return: Not full constructed attribute or NULL if not possible to create.
  */
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off)
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off)
 {
 	size_t tail;
 	struct ATTRIB *attr;
@@ -482,7 +487,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	 * at which we should insert it.
 	 */
 	attr = NULL;
-	while ((attr = mi_enum_attr(mi, attr))) {
+	while ((attr = mi_enum_attr(ni, mi, attr))) {
 		diff = compare_attr(attr, type, name, name_len, upcase);

 		if (diff < 0)
@@ -500,7 +505,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 		tail = used - PtrOffset(rec, attr);
 	}

-	id = mi_new_attt_id(mi);
+	id = mi_new_attt_id(ni, mi);

 	memmove(Add2Ptr(attr, asize), attr, tail);
 	memset(attr, 0, asize);
--
2.50.1

