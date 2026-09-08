Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3B48E0E8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895311; cv=none; b=DNxxnNmrfO6bNB+svplLuKi1ypD7TgaIbVSCewNz8QipUj7tzNHM9sUFMFNjIx1dVKm/li38RP2kqJd397420mELzu9u7s05cw3laZc2EFQwDxr/p1EobF2QlJ7IaUqS+xV8eHxTVC+wXERoUMmOBCA84R/A4RqGUCPpdnnNJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895311; c=relaxed/simple;
	bh=GEboJKJOM9Y7t8qaMAGcopNSrbixDPtvset0gkvVpcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiTjsFRPHKyf9fWuh4yauwvzJ58/0/2yCShvl2aPwuiIVmamfJImDPHUAoSLKvF3m34usoYLlHOt77+JI9WLCZEHWAv8H4y1kUTNYcOdn2hxnOXYNm9AlsI1m63IpAGNN55I3Mv/RdIWsqe/v9bsg1l5jVtNXIdBlGs2f69k7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZGc2uSn; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZGc2uSn"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-399213ef56cso2377521a91.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895290; x=1789500090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUfPpatWbw8AVi9xjHjjKKnbnu1YkaxWspIWuX+XZtI=;
        b=iZGc2uSntAZ69/lE3ypt1YkNfpJgwzUZ1Q6J1DA6qmCFi+2pPkG4+ZKLLuQ10eF9wO
         Rw3utNB7R7viJvRMXDQIW3vXwY8+pbeflWNjQsDFft1e+KoXmkH9aKc95kEnioRDa7Df
         R26oQcsEKpHYhUBfOdON2lQUxH2Lgp7WRJAhSBXVmqqorKqja4gmUDZ9vU4hewXrh6DF
         oSpeAbJ0RRx8pVHYtRuaMFj6qKKLt1xKt4JBC3L38ztLQSdwxt4ARd/XvUUGeNiHQ4aV
         nbLzXseQz0E3f6voa4SiZUdYvalytY694GbLMR4N/8r66cY4SwZaqV62snDgoqsHthVG
         RURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895290; x=1789500090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUfPpatWbw8AVi9xjHjjKKnbnu1YkaxWspIWuX+XZtI=;
        b=DDM7p3Zi049jibuOREo4N2weKEpnDAJklC5E8jaIccRmVzp1naT809FETEsmLyZEpV
         yMzoCALpyDHQZPEJq6PTW4r8dAMRXkrchF4ijRPX5zGUzYmQklBK/eGq+EONAv4k+owS
         j+7MZ4qCfuyLr6u207g9wnsSUSZxNhPZ3a4sIx7mj3K5A6s26zo+fCtuFDUwpX/hhaSB
         iXxuR0ImfRpRBwQRBdo/k/TI1cXyRXnjffz4r2fgOkBOWwfXQZIG7n691VHdQLh10BJH
         JG1356SgUXntXk5KDEBjeIwtfbdGo3ij3c5Q/StkMnjuM93eeMFpBtOrrxmYcUK/3c6P
         2V7A==
X-Gm-Message-State: AFuF++miMTj9BzGyZ15Dw4mY14CdC23xDQ8L5PlEk/jBxi+qDNOB5N+X
	BqB4yfOnARSHb6qov+YWgQErZKyQMf8rXNW/3J7eCmXoXSePNDVMrPEyyzWY0Eso/Fs=
X-Gm-Gg: AYBFou3P4/o/s2+h5DGv6jf4hWYz3JUy53eASxicEaW7S41B0l671dg8V8ALxLN9gW+
	ayWa3WzxiiuaRsS2XzKzkCs08Q+kJ54IPkJe/NYHH5YLBnF/RPTqg906zSEIUmlS20X2rc3uq6n
	X8n2HumQ6mPYK8DfNuYhADIM5u49UcoJFJBWqKWj0Wc+Rv7P03JXljvATKW92Vrkwqzn65kXswc
	KA6B5YJjsAZloAeBqY3aKEhZ/qLCnPjUfsmz9k3SZYBm+J9TBUe4tuEZpGdnz4JLBMyGO4PmRP7
	ZFtmprHYd7NEVmALgj8S3X7OUkHFCiNsprxCBSUQLJCKcCjcGINxZaS18fv35bbpPFZML6JmTIM
	2zjB2RR9dFbSOCL7Mu6QmgetEhs0nTzcKoJuhWNFr+UKz4hWNeroCDU9H/1KMI24E/qJjaKwkxr
	3Ahc8K69LNRMgP+Y5peRleROJEUYsaQ1rfYemL5vyuM0tfQD4BYmiibxU72fYQ2KE48WCRIYAtT
	B6Yf2dOsX4vnRDAtqEvU8ffOoe2/hKlHWF8lpHA54GzyIzVFLUaaMKTwD4WDylzz1wuKnshIWjm
	4HFs9Uc=
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3da3a16a579mr49478226637.26.1788895289556;
        Tue, 08 Sep 2026 12:21:29 -0700 (PDT)
Received: from samlap.tailb86931.ts.net (c-24-5-101-44.hsd1.ca.comcast.net. [24.5.101.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm30908496eec.23.2026.09.08.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:21:28 -0700 (PDT)
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: stable@vger.kernel.org
Cc: almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: [PATCH 5.15.y v3 v3] fs/ntfs3: Change new sparse cluster processing
Date: Tue,  8 Sep 2026 12:22:13 -0700
Message-ID: <20260908192213.1169088-1-giveback4fun@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b upstream.

Remove ntfs_sparse_cluster.

Bug: https://syzkaller.appspot.com/bug?extid=f3e5d0948a1837ed1bb0
Reported-by: syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com
Tested-by: syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3e5d0948a1837ed1bb0
Cc: <stable@vger.kernel.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
commit 406a037d93b769bca248476bd14bbe548dc1ec35 upstream.:
---
 fs/ntfs3/attrib.c  | 176 +++++++++++++++++++++++++++++++--------------
 fs/ntfs3/file.c    | 156 +++++++++-------------------------------
 fs/ntfs3/frecord.c |   2 +-
 fs/ntfs3/index.c   |   4 +-
 fs/ntfs3/inode.c   |  12 ++--
 fs/ntfs3/ntfs_fs.h |   7 +-
 6 files changed, 167 insertions(+), 190 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 872586e9598a..fe2f4888f8f9 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -173,7 +173,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn)
+			   CLST *new_lcn, CLST *new_len)
 {
 	int err;
 	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
@@ -194,11 +194,16 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		if (err)
 			goto out;
 
-		if (new_lcn && vcn == vcn0)
-			*new_lcn = lcn;
+		if (vcn == vcn0) {
+			/* Return the first fragment. */
+			if (new_lcn)
+				*new_lcn = lcn;
+			if (new_len)
+				*new_len = flen;
+		}
 
 		/* Add new fragment into run storage. */
-		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
+		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
 			/* Undo last 'ntfs_look_for_free_space' */
 			down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 			wnd_set_free(wnd, lcn, flen);
@@ -207,9 +212,20 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			goto out;
 		}
 
+		if (opt & ALLOCATE_ZERO) {
+			u8 shift = sbi->cluster_bits - SECTOR_SHIFT;
+
+			err = blkdev_issue_zeroout(sbi->sb->s_bdev,
+						   (sector_t)lcn << shift,
+						   (sector_t)flen << shift,
+						   GFP_NOFS, 0);
+			if (err)
+				goto out;
+		}
+
 		vcn += flen;
 
-		if (flen >= len || opt == ALLOCATE_MFT ||
+		if (flen >= len || (opt & ALLOCATE_MFT) ||
 		    (fr && run->count - cnt >= fr)) {
 			*alen = vcn - vcn0;
 			return 0;
@@ -287,7 +303,8 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 		const char *data = resident_data(attr);
 
 		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
-					     ALLOCATE_DEF, &alen, 0, NULL);
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out1;
 
@@ -566,13 +583,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			/* ~3 bytes per fragment. */
 			err = attr_allocate_clusters(
 				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
-				is_mft ? ALLOCATE_MFT : 0, &alen,
+				is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
 				is_mft ? 0
 				       : (sbi->record_size -
 					  le32_to_cpu(rec->used) + 8) /
 							 3 +
 						 1,
-				NULL);
+				NULL, NULL);
 			if (err)
 				goto out;
 		}
@@ -810,8 +827,19 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	return err;
 }
 
+/*
+ * attr_data_get_block - Returns 'lcn' and 'len' for given 'vcn'.
+ *
+ * @new == NULL means just to get current mapping for 'vcn'
+ * @new != NULL means allocate real cluster if 'vcn' maps to hole
+ * @zero - zeroout new allocated clusters
+ *
+ *  NOTE:
+ *  - @new != NULL is called only for sparsed or compressed attributes.
+ *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
+ */
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new)
+			CLST *len, bool *new, bool zero)
 {
 	int err = 0;
 	struct runs_tree *run = &ni->file.run;
@@ -820,29 +848,27 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
+	unsigned int fr;
 	u64 total_size;
-	u32 clst_per_frame;
-	bool ok;
 
 	if (new)
 		*new = false;
 
+	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
-	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		*len = 0;
 	up_read(&ni->file.run_lock);
 
-	if (ok && (*lcn != SPARSE_LCN || !new)) {
-		/* Normal way. */
-		return 0;
+	if (*len) {
+		if (*lcn != SPARSE_LCN || !new)
+			return 0; /* Fast normal way without allocation. */
+		else if (clen > *len)
+			clen = *len;
 	}
 
-	if (!clen)
-		clen = 1;
-
-	if (ok && clen > *len)
-		clen = *len;
-
+	/* No cluster in cache or we need to allocate cluster in hole. */
 	sbi = ni->mi.sbi;
 	cluster_bits = sbi->cluster_bits;
 
@@ -868,12 +894,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 	}
 
-	clst_per_frame = 1u << attr_b->nres.c_unit;
-	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
-
-	if (vcn + to_alloc > asize)
-		to_alloc = asize - vcn;
-
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
 
@@ -892,36 +912,68 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
 	}
 
+	/* Load in cache actual information. */
 	err = attr_load_runs(attr, ni, run, NULL);
 	if (err)
 		goto out;
 
-	if (!ok) {
-		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
-		if (ok && (*lcn != SPARSE_LCN || !new)) {
-			/* Normal way. */
-			err = 0;
-			goto ok;
-		}
+	if (!*len) {
+		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+			if (*lcn != SPARSE_LCN || !new)
+				goto ok; /* Slow normal way without allocation. */
 
-		if (!ok && !new) {
-			*len = 0;
-			err = 0;
+			if (clen > *len)
+				clen = *len;
+		} else if (!new) {
+			/* Here we may return -ENOENT.
+			 * In any case caller gets zero length. */
 			goto ok;
 		}
-
-		if (ok && clen > *len) {
-			clen = *len;
-			to_alloc = (clen + clst_per_frame - 1) &
-				   ~(clst_per_frame - 1);
-		}
 	}
 
 	if (!is_attr_ext(attr_b)) {
+		/* The code below only for sparsed or compressed attributes. */
 		err = -EINVAL;
 		goto out;
 	}
 
+	vcn0 = vcn;
+	to_alloc = clen;
+	fr = (sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1;
+	/* Allocate frame aligned clusters.
+	 * ntfs.sys usually uses 16 clusters per frame for sparsed or compressed.
+	 * ntfs3 uses 1 cluster per frame for new created sparsed files. */
+	if (attr_b->nres.c_unit) {
+		CLST clst_per_frame = 1u << attr_b->nres.c_unit;
+		CLST cmask = ~(clst_per_frame - 1);
+
+		/* Get frame aligned vcn and to_alloc. */
+		vcn = vcn0 & cmask;
+		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
+		if (fr < clst_per_frame)
+			fr = clst_per_frame;
+		zero = true;
+
+		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
+		if (vcn < svcn || evcn1 <= vcn) {
+			/* Load attribute for truncated vcn. */
+			attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0,
+					    &vcn, &mi);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+			err = attr_load_runs(attr, ni, run, NULL);
+			if (err)
+				goto out;
+		}
+	}
+
+	if (vcn + to_alloc > asize)
+		to_alloc = asize - vcn;
+
 	/* Get the last LCN to allocate from. */
 	hint = 0;
 
@@ -935,18 +987,33 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		hint = -1;
 	}
 
-	err = attr_allocate_clusters(
-		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
-		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
-		lcn);
+	/* Allocate and zeroout new clusters. */
+	err = attr_allocate_clusters(sbi, run, vcn, hint + 1, to_alloc, NULL,
+				     zero ? ALLOCATE_ZERO : ALLOCATE_DEF, &alen,
+				     fr, lcn, len);
 	if (err)
 		goto out;
 	*new = true;
 
-	end = vcn + *len;
-
+	end = vcn + alen;
 	total_size = le64_to_cpu(attr_b->nres.total_size) +
-		     ((u64)*len << cluster_bits);
+		     ((u64)alen << cluster_bits);
+
+	if (vcn != vcn0) {
+		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (*lcn == SPARSE_LCN) {
+			/* Internal error. Should not happened. */
+			WARN_ON(1);
+			err = -EINVAL;
+			goto out;
+		}
+		/* Check case when vcn0 + len overlaps new allocated clusters. */
+		if (vcn0 + *len > end)
+			*len = end - vcn0;
+	}
 
 repack:
 	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
@@ -1480,7 +1547,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST svcn, evcn1, next_svcn, len;
 	CLST vcn, end, clst_data;
 	u64 total_size, valid_size, data_size;
 
@@ -1556,8 +1623,9 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 		}
 
 		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
-					     hint + 1, len - clst_data, NULL, 0,
-					     &alen, 0, &lcn);
+					     hint + 1, len - clst_data, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 25788df25dee..2cebdccc6192 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/backing-dev.h>
+#include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/compat.h>
 #include <linux/falloc.h>
@@ -122,8 +123,8 @@ static int ntfs_extend_initialized_size(struct file *file,
 			bits = sbi->cluster_bits;
 			vcn = pos >> bits;
 
-			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen,
-						  NULL);
+			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen, NULL,
+						  false);
 			if (err)
 				goto out;
 
@@ -198,18 +199,18 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	struct address_space *mapping = inode->i_mapping;
 	u32 blocksize = 1 << inode->i_blkbits;
 	pgoff_t idx = vbo >> PAGE_SHIFT;
-	u32 z_start = vbo & (PAGE_SIZE - 1);
+	u32 from = vbo & (PAGE_SIZE - 1);
 	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	loff_t page_off;
 	struct buffer_head *head, *bh;
-	u32 bh_next, bh_off, z_end;
+	u32 bh_next, bh_off, to;
 	sector_t iblock;
 	struct page *page;
 
-	for (; idx < idx_end; idx += 1, z_start = 0) {
+	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
-		z_end = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
-							: PAGE_SIZE;
+		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
+						     : PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
 		page = find_or_create_page(mapping, idx,
@@ -226,7 +227,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		do {
 			bh_next = bh_off + blocksize;
 
-			if (bh_next <= z_start || bh_off >= z_end)
+			if (bh_next <= from || bh_off >= to)
 				continue;
 
 			if (!buffer_mapped(bh)) {
@@ -260,7 +261,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
-		zero_user_segment(page, z_start, z_end);
+		zero_user_segment(page, from, to);
 
 		unlock_page(page);
 		put_page(page);
@@ -271,81 +272,6 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	return err;
 }
 
-/*
- * ntfs_sparse_cluster - Helper function to zero a new allocated clusters.
- *
- * NOTE: 512 <= cluster size <= 2M
- */
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u64 vbo = (u64)vcn << sbi->cluster_bits;
-	u64 bytes = (u64)len << sbi->cluster_bits;
-	u32 blocksize = 1 << inode->i_blkbits;
-	pgoff_t idx0 = page0 ? page0->index : -1;
-	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
-	loff_t end = ntfs_up_cluster(sbi, vbo + bytes);
-	pgoff_t idx = vbo_clst >> PAGE_SHIFT;
-	u32 from = vbo_clst & (PAGE_SIZE - 1);
-	pgoff_t idx_end = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	loff_t page_off;
-	u32 to;
-	bool partial;
-	struct page *page;
-
-	for (; idx < idx_end; idx += 1, from = 0) {
-		page = idx == idx0 ? page0 : grab_cache_page(mapping, idx);
-
-		if (!page)
-			continue;
-
-		page_off = (loff_t)idx << PAGE_SHIFT;
-		to = (page_off + PAGE_SIZE) > end ? (end - page_off)
-						  : PAGE_SIZE;
-		partial = false;
-
-		if ((from || PAGE_SIZE != to) &&
-		    likely(!page_has_buffers(page))) {
-			create_empty_buffers(page, blocksize, 0);
-		}
-
-		if (page_has_buffers(page)) {
-			struct buffer_head *head, *bh;
-			u32 bh_off = 0;
-
-			bh = head = page_buffers(page);
-			do {
-				u32 bh_next = bh_off + blocksize;
-
-				if (from <= bh_off && bh_next <= to) {
-					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
-				} else if (!buffer_uptodate(bh)) {
-					partial = true;
-				}
-				bh_off = bh_next;
-			} while (head != (bh = bh->b_this_page));
-		}
-
-		zero_user_segment(page, from, to);
-
-		if (!partial) {
-			if (!PageUptodate(page))
-				SetPageUptodate(page);
-			set_page_dirty(page);
-		}
-
-		if (idx != idx0) {
-			unlock_page(page);
-			put_page(page);
-		}
-		cond_resched();
-	}
-	mark_inode_dirty(inode);
-}
-
 /*
  * ntfs_file_mmap - file_operations::mmap
  */
@@ -387,13 +313,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 			for (; vcn < end; vcn += len) {
 				err = attr_data_get_block(ni, vcn, 1, &lcn,
-							  &len, &new);
+							  &len, &new, true);
 				if (err)
 					goto out;
-
-				if (!new)
-					continue;
-				ntfs_sparse_cluster(inode, NULL, vcn, 1);
 			}
 		}
 
@@ -522,7 +444,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 }
 
 /*
- * ntfs_fallocate
+ * ntfs_fallocate - file_operations::ntfs_fallocate
  *
  * Preallocate space for a file. This implements ntfs's fallocate file
  * operation, which gets called from sys_fallocate system call. User
@@ -533,11 +455,13 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t end = vbo + len;
-	loff_t vbo_down = round_down(vbo, PAGE_SIZE);
+	loff_t vbo_down = round_down(vbo, max_t(unsigned long,
+						sbi->cluster_size, PAGE_SIZE));
 	loff_t i_size;
 	int err;
 
@@ -568,17 +492,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		u32 frame_size;
 		loff_t mask, vbo_a, end_a, tmp;
 
-		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-			err = -EINVAL;
-			goto out;
-		}
-
-		err = filemap_write_and_wait_range(inode->i_mapping, vbo,
-						   end - 1);
-		if (err)
-			goto out;
-
-		err = filemap_write_and_wait_range(inode->i_mapping, end,
+		err = filemap_write_and_wait_range(mapping, vbo_down,
 						   LLONG_MAX);
 		if (err)
 			goto out;
@@ -636,8 +550,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		 * Write tail of the last page before removed range since
 		 * it will get removed from the page cache below.
 		 */
-		err = filemap_write_and_wait_range(inode->i_mapping, vbo_down,
-						   vbo);
+		err = filemap_write_and_wait_range(mapping, vbo_down, vbo);
 		if (err)
 			goto out;
 
@@ -645,8 +558,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		 * Write data that will be shifted to preserve them
 		 * when discarding page cache below.
 		 */
-		err = filemap_write_and_wait_range(inode->i_mapping, end,
-						   LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
 		if (err)
 			goto out;
 
@@ -676,9 +588,22 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
 			CLST vcn = vbo >> sbi->cluster_bits;
 			CLST cend = bytes_to_cluster(sbi, end);
+			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
 			CLST lcn, clen;
 			bool new;
 
+			/*
+			 * Allocate and zero new clusters.
+			 * Zeroing these clusters may be too long.
+			 */		
+			for (; vcn < cend_v; vcn += clen) {
+				err = attr_data_get_block(ni, vcn, cend_v - vcn,
+							  &lcn, &clen, &new,
+							  true);
+				if (err)
+					goto out;
+			}
+
 			/*
 			 * Allocate but do not zero new clusters. (see below comments)
 			 * This breaks security: One can read unused on-disk areas.
@@ -687,25 +612,12 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
-							  &lcn, &clen, &new);
+							  &lcn, &clen, &new,
+							  false);
 				if (err)
 					goto out;
 				if (!new || vcn >= vcn_v)
 					continue;
-
-				/*
-				 * Unwritten area.
-				 * NTFS is not able to store several unwritten areas.
-				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters.
-				 *
-				 * Dangerous in case:
-				 * 1G of sparsed clusters + 1 cluster of data =>
-				 * valid_size == 1G + 1 cluster
-				 * fallocate(1G) will zero 1G and this can be very long
-				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'.
-				 */
-				ntfs_sparse_cluster(inode, NULL, vcn,
-						    min(vcn_v - vcn, clen));
 			}
 		}
 
@@ -927,7 +839,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		off = valid & (frame_size - 1);
 
 		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0, &lcn,
-					  &clen, NULL);
+					  &clen, NULL, false);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 62874e7f8d8f..1caf7c1bd96f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2207,7 +2207,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new);
+						  &clen, &new, false);
 			if (err)
 				goto out;
 		}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index b3f57535fe0b..e04f4c6d6390 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1454,8 +1454,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	run_init(&run);
 
-	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
-				     NULL);
+	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, ALLOCATE_DEF,
+				     &alen, 0, NULL, NULL);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index acd5be0d36c0..af55253a90b0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -590,7 +590,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	off = vbo & sbi->cluster_mask;
 	new = false;
 
-	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL);
+	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL,
+				  create && sbi->cluster_size > PAGE_SIZE);
 	if (err)
 		goto out;
 
@@ -608,11 +609,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 		WARN_ON(1);
 	}
 
-	if (new) {
+	if (new)
 		set_buffer_new(bh);
-		if ((len << cluster_bits) > block_size)
-			ntfs_sparse_cluster(inode, page, vcn, len);
-	}
 
 	lbo = ((u64)lcn << cluster_bits) + off;
 
@@ -1542,8 +1540,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
 
 			err = attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
-						     clst, NULL, 0, &alen, 0,
-						     NULL);
+						     clst, NULL, ALLOCATE_DEF,
+						     &alen, 0, NULL, NULL);
 			if (err)
 				goto out5;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a03dce278221..e485cb45c3d8 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -127,6 +127,7 @@ struct ntfs_buffers {
 enum ALLOCATE_OPT {
 	ALLOCATE_DEF = 0, // Allocate all clusters.
 	ALLOCATE_MFT = 1, // Allocate for MFT.
+	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters
 };
 
 enum bitmap_mutex_classes {
@@ -418,7 +419,7 @@ int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn);
+			   CLST *new_lcn, CLST *new_len);
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
 			  u64 new_size, struct runs_tree *run,
@@ -428,7 +429,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
 		  struct ATTRIB **ret);
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new);
+			CLST *len, bool *new, bool zero);
 int attr_data_read_resident(struct ntfs_inode *ni, struct page *page);
 int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
@@ -492,8 +493,6 @@ extern const struct file_operations ntfs_dir_operations;
 /* Globals from file.c */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len);
 int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct iattr *attr);
 int ntfs_file_open(struct inode *inode, struct file *file);
-- 
2.47.3

