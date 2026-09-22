Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280749F126
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108626; cv=none; b=izef3UzplJ8fKENTvtFcthKEQS8v80/BnXbRLTLPQMEEmrgifIGbUUjIWAUxk5/LOdZ2Z4X5ZT5EdQn/XjAgWpqcDAi/t5Ra1VekdL4Zm1dBQpudGrDY2hAIcOTx42yhYeHSMRXfZuk3wXJKVra0aTkGJgkQjPar32HnYXMhviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108626; c=relaxed/simple;
	bh=oXR+0JqHfu87eukEokpNsmREiUMPTo8HO88BW1JCCrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpT52BPweMChKdwcKsRBlURwCSqS6eYHDkVq2CbG2rIdrYk0crscoDRrwFK6NRe0bXjItDSBXfE1un7EYJ2TKDEC9wYaZI8EPPBFw1RBB+BQgbiEAbXZ5FK6sKj8mzrvbbMk/Hndar1iWFdDFr8S8O+TpxRZgOOUvHY+AJXcmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jjX/FhrV; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jjX/FhrV"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso262367eec.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1790108612; x=1790713412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5DjzabZ8BjMpxlg7TQnuj38a/x4OpYjoDV9Zo35NcDE=;
        b=jjX/FhrVKtmQ+NIZxMpQ+r/LxyJ7k03x9Rozi3TeV62sCjkGPvVSF5P5XIWwU6P8GI
         B+UlSNqwOanEDJHard3r6kA7O9KmgBBuc4wRw/joyqVc5tyDHFAqvzeanM1u0q+AiDR+
         gnfG+PlAwSoy0n/8qvxxb/zYuej9nNydPVvk977Mrk9rNdkDUW33Y/LPW6V8FWsMxQhv
         Ph+1311FPj4yHP9QYbox+z+4K5ewhQWjtGTUS+1ke9B5SRmshMg/5AZHoin801/5fzAr
         mApX4RrF2a/+9xBxJj4lOk9W0HZzenbwiOdQfBt34RxK4BppF9YZ+e2RxJ6eexXr9vj6
         6vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108612; x=1790713412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5DjzabZ8BjMpxlg7TQnuj38a/x4OpYjoDV9Zo35NcDE=;
        b=ibPrtPqHwZoqkJvd19RDPT0LGcPxAN5bRUCNlnxZTcScgb3CaVT7tHvWua0OtniMzh
         MYL8YzVom+L4WDyZO/38OCNFWxA9Lpnt3cuzkqnx7DU+RLKHzswjqAUXmXImVeF4gkia
         x9LHy4rrhJMOqPeivmHqGNuyOsWcz5dlBN/XFI5VSpRM3WgSwtzuWolfv1Hklwqqk+3+
         cjP0LQrnJxtqNdK2rryw/V/bk4vmq0N/kt8VNMyMVlMr/DqnttRkvZ5wggTPvyVEg8Cg
         I6W/4JukO5cKwZnjvkhepLCY4iE+hBN6P/ey1uVeUpdHGGpf6UDrxRSYQEqvh8MmhEjS
         ssDg==
X-Forwarded-Encrypted: i=1; AKwUvBx6fwuB27l/RpYVUrFzAtPFo9zln1xtj5G6hbJI2PgLKLaaZAKNB6Kp+1UNA1gQ4EFZHSUr5FU=@vger.kernel.org
X-Gm-Message-State: AFuF++k5ToklyBxvhREzqjf8ych4/pOvobgENYUj90M0+3+/cXYdgVWr
	NBgCuCx4FjdPuIwq7tYy2vPSKSbOeT1peotrcyx9nXHJe8RyxCI2OcfHZsvgHP375dZXRkWkIEr
	MC4UBofc4
X-Gm-Gg: AYBFou3gFDSD1/cItUhyN29f7hB4Av+jG+JNVE5izkMMLkX4I6uKIKXHfODOuMTTr6c
	rG4DAUiI55ivf9CPmcKfEUNVs6B/XFZSAy5jxfF7wUTj1DQQq8ivQ1X+ODgNoPhiNkrjSTEOAay
	FhdkHdwWTM9gTzO4EMHQ45hnYHDm5yenNAZAOgZuMBhbs9bdD2DTGzwb1s+Ux1r/qoRx/fKfHzg
	hBWCxjYC/uho3uVNHo/LNnsX6ebxd+RJJLufT30FsV31nmPfBuTDTk7UUD0BQ7xSBiHHG7XTkPz
	8OYVGvQyrh/2pbJGwuMUprA20B3GIQBSNUDGTRVqAH4tUSY1Oyn7u1t/i6O76plNb26yIN5QvZW
	0EwQipjpydyCds2SBFs0oiWzB9xcRqpqf4y2CRv0JTIALPe2OnwJJj+6Kux+Hghp+GWYJJHli/g
	I+owBzWuF1ptx9nANdQ4vLqRK+JaXsCjgK4X6VLbj9BqBF5lZu3KQsIysUAkOJFvB0BRWzPu+RU
	6DeoPe/W1V/V01XrBRhQhUnlhnCLr9MFQ==
X-Received: by 2002:a05:7301:540d:b0:33c:130b:458 with SMTP id 5a478bee46e88-33e8e986d8emr312080eec.41.1790108611306;
        Tue, 22 Sep 2026 13:23:31 -0700 (PDT)
Received: from gio.scai.dhcp.asu.edu (209-147-138-22.nat.asu.edu. [209.147.138.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fe502sm627194eec.2.2026.09.22.13.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:23:30 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: fix array out of bound access in __ocfs2_find_path()
Date: Tue, 22 Sep 2026 13:21:59 -0700
Message-ID: <20260922202159.2421642-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ocfs2_find_path() walks down the extent tree and records path by calling
find_path_ins(), which appends entry to path->p_node[]. It only has 5
spots.

A corrupted ocfs2 image whose extent block is pointing to itself causes
__ocfs2_find_path() descent endlessly, writing past the end of
path->p_node[] array.

 UBSAN: array-index-out-of-bounds in fs/ocfs2/alloc.c:677:14
 index 5 is out of range for type 'ocfs2_path_item [5]'
 Call Trace:
  <TASK>
  find_path_ins (fs/ocfs2/alloc.c:677 fs/ocfs2/alloc.c:1914)
  __ocfs2_find_path.constprop.0 (fs/ocfs2/alloc.c:1882)
  ocfs2_commit_truncate (fs/ocfs2/alloc.c:1924 fs/ocfs2/alloc.c:7286)
  ocfs2_truncate_file (fs/ocfs2/file.c:515)
  ocfs2_setattr (fs/ocfs2/file.c:1224)
  notify_change (fs/attr.c:556)
  do_truncate (fs/open.c:68)
  do_ftruncate (fs/open.c:194 (discriminator 1))
  ksys_ftruncate (fs/open.c:206)
  __x64_sys_ftruncate (fs/open.c:211 fs/open.c:209 fs/open.c:209)

Commit a406aff8c051 ("ocfs2: validate l_tree_depth to avoid
out-of-bounds access") already restricts el->l_tree_depth to be less than
OCFS2_MAX_PATH_DEPTH, which is equal to 5. However, does not handle the
infinite descent case.

Check if the el->l_tree_depth decreases on each descent. Maximum
descents are restricted to 4 and the path->p_node[] array does not
overflow.

Fixes: dcd0538ff4e8 ("ocfs2: sparse b-tree support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 fs/ocfs2/alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index be09e766ac1f..c85a472965d5 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1817,6 +1817,7 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 	int i, ret = 0;
 	u32 range;
 	u64 blkno;
+	u32 prev_depth = OCFS2_MAX_PATH_DEPTH;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
@@ -1824,14 +1825,16 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
 	el = root_el;
 	while (el->l_tree_depth) {
-		if (unlikely(le16_to_cpu(el->l_tree_depth) >= OCFS2_MAX_PATH_DEPTH)) {
+		if (unlikely(le16_to_cpu(el->l_tree_depth) >= prev_depth)) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
-				    "Owner %llu has invalid tree depth %u in extent list\n",
+				    "Owner %llu has invalid tree depth %u in extent list (max %u)\n",
 				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
-				    le16_to_cpu(el->l_tree_depth));
+				    le16_to_cpu(el->l_tree_depth), prev_depth - 1);
 			ret = -EROFS;
 			goto out;
 		}
+		prev_depth = le16_to_cpu(el->l_tree_depth);
+
 		if (!el->l_next_free_rec || !el->l_count) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
 				    "Owner %llu has empty extent list at depth %u\n"
-- 
2.43.0

