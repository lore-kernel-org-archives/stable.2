Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FE11CAF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198710; cv=none; b=jK45NPuP6gGJ2ZCCrB/yoehdkM5vK/EPPOyE+ujKZTYhydRKyg+MdPSfXSl0FN7OHsreyNCLkJ05XtCSmWIUynE4HhSRDE4lGtSbhttdNyq7efguCWVIMZyosBQ14oGR2VnhRDLFBgI8Wh33BqdzaaI9/ikrdYdKaV0LHJw6axw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198710; c=relaxed/simple;
	bh=+Q+1BeRkhfsZhiSz5zUSW238r3gbT6Xcsv4QSHp9nSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNsBgD6TfpID81Pl2bXQo5rFgLXNaVel+5KzKFIqz9EoBuh4gWTlWeuWOqnuJ3xKNqetjn7pF1IWUxWwwgBTBJY1+g8IR7NtZpEgj5JA2Mu0zJh4IaCcuVK5snfLC/WMorbKAYCn5ANdpivQhGgIKklEOah3ObTXQSD/fdh+MFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DldAlUns; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DldAlUns"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e584c7a5bso1606452b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785198708; x=1785803508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFNTOxT4ezFw/LVbKZk4FyM5znd+D7rQoQl5m1eBEgI=;
        b=DldAlUnsft0iWVO9LGFYJUy8Ra6pQLHi7vu701l7ofEMakAm/59QvHRn/2pJlmERrd
         pI518GOYXhLwwr4tUXXQetmsuGSlutyz1hyG1VSPsyh20ckYW38M0WBknidiUNNk2M90
         VU3KNcbSZl79Vc5+xpj31dEllh2oCFC+i5f60TlSm52EcQr8ruXolo1ebIKSGRYoZ8kw
         OCcYJgOTCFDZtca7qa/HcuLoDJEQH48UAXHaFLVSUKehCrbQtmlPsa3ctCa+EnAapoQJ
         9or0n0lg/VQKoI7RztwQNXZINmROpweZNodEzJCey0fDr77p3DoC8CEw9Hh1XRGmhHoD
         7/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198708; x=1785803508;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFNTOxT4ezFw/LVbKZk4FyM5znd+D7rQoQl5m1eBEgI=;
        b=UzMxuDpU5XGXzDOEJhqWs9YNlKomw5fRZR7nlzu4N+ZNy1QqSihVi0R4uKYXuHsznp
         YFOR8vifV4ln+Buzfj/sP3yXENwSQ1xmLHd3hy1MZfXOeLFYp25TbJA0O+oU93FHE3+5
         hls+eOcWBjlEv+K4ebK+HqFRklkhzUc11hqEQTCo5P++g5+sKfDchV1SibZAKJeV0ms9
         gE/zbVix18hPX751PXU93jLUl/V7ZNxVyeaYHBY7auek3N3b/bwJPCLGpL4qLwazljxT
         NXd+WlI4c43liLCvXUd5AL8fpcX1yMousJoosmMImXndphRAzJJT30wgQvt6dVkh64RD
         xn0w==
X-Forwarded-Encrypted: i=1; AHgh+Rq0c4HBNOEsooe5vhJVEiBdKW03jeMI4S6DFHp3AMvjbxtmFlJLvkO8VC+6w8CH7BqqSW7HVMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJh0nHhRGqitjzehKzb6QNdZ5+n3J0jEUp4oul7vedu3EtobV
	RTb7w3rVEHycVxEioP4WSqi0txZV06H+HArRgy30eWvYkIzHzvjy5PPh
X-Gm-Gg: AR+sD127MbRWmQBn7W/w5nJOLcmkXup21LteIkNJcCFvgr6VwutnWpYt+xXDSLRSHmN
	eV/AU/jvTyArgKDzoody+e41oQqNuAieXgR28WQSenkHeAeQEUVstSf4XI5etu6iw2Eq25xeDsu
	9lLR/315FiL7SWP5OMoEl3z71UhaBaaHmDcMaSTMOBp7tMW6dOoJ9TuvDYLK+iPy1S6JZGVSynt
	LvWSyMCcjCU/JA1+IcHANKsHAyoAKZcVQO+hX27BrsuYs2IzxWs7cuxHMLmhEFesiTO+VuBtHcn
	VnPt16NJwBk6GPNDrdVPnUFnyHh1WzrtGorP3rAA6SMWIaRuV46cnv/zUfI9mHpueg8LfUCwoQY
	UoEco+G2473jzA8RxCF5LXKZuYHW8zp4WBEMr2M6jJP4lEAb9Q7RNeH8uhXRl4AaBmiIqOgfFq7
	J1Fm5Z+b9Ze5gBdVQxSIWOVRAGHw==
X-Received: by 2002:a05:6a00:1795:b0:847:8e98:9a4b with SMTP id d2e1a72fcca58-84e9325bb83mr149422b3a.34.1785198708015;
        Mon, 27 Jul 2026 17:31:48 -0700 (PDT)
Received: from hyunchul-PC01.tail461a24.ts.net ([125.177.232.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f54esm3571094b3a.20.2026.07.27.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:31:47 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] ntfs: protect mapping-pairs attr-list updates with attr_list_persist_lock
Date: Tue, 28 Jul 2026 09:30:51 +0900
Message-ID: <20260728-topic-attr-list-lock-v6-v2-4-270ad764d0a4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785198351; l=4062; i=hyc.lee@gmail.com; s=20260727; h=from:subject:message-id; bh=+Q+1BeRkhfsZhiSz5zUSW238r3gbT6Xcsv4QSHp9nSU=; b=8gbBGELXTWuBwuQVY0jcFDa9O4wW56K03MXKtyZCyssX/gbfshdol4G+DHJKhMAS7rVNlvFbd O16pXv6/DGWBpPqp3jFHrnyDBkkGnbPRnrp0Kk5wUw43e3Lqhqs/xcl
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
 fs/ntfs/attrib.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 00ff223d9c21..85736af66bb1 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -3887,7 +3887,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	struct attr_record *a;
 	s64 stop_vcn;
 	int err = 0, mp_size, cur_max_mp_size, exp_max_mp_size;
-	bool finished_build, attrlist_changed = false;
+	bool finished_build, attrlist_changed = false, attrlist_locked = false;
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
@@ -3912,9 +3912,16 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
 
@@ -3989,6 +3996,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4025,6 +4036,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
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
@@ -4038,6 +4053,10 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
+				if (WARN_ON_ONCE(attrlist_locked)) {
+					mutex_unlock(&base_ni->attr_list_persist_lock);
+					attrlist_locked = false;
+				}
 				ntfs_attr_put_search_ctx(ctx);
 				if (ntfs_inode_add_attrlist(base_ni)) {
 					ntfs_error(sb, "Can not add attrlist");
@@ -4151,9 +4170,13 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 
 	if (attrlist_changed) {
 		err = ntfs_attrlist_update(base_ni);
-		if (err)
-			goto put_err_out;
 	}
+	if (attrlist_locked) {
+		mutex_unlock(&base_ni->attr_list_persist_lock);
+		attrlist_locked = false;
+	}
+	if (attrlist_changed && err)
+		goto put_err_out;
 
 	/* Deallocate not used attribute extents and return with success. */
 	if (finished_build) {
@@ -4272,6 +4295,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return 0;
 
 put_err_out:
+	if (attrlist_locked)
+		mutex_unlock(&base_ni->attr_list_persist_lock);
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	return err;

-- 
2.43.0

