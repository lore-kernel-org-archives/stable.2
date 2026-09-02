Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92132FA30;
	Wed,  2 Sep 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313852; cv=none; b=sQqNomedb7KVcQNtbAsYsw/Afnez6uqgodZTfPebyqaYthEwbodBuykyXu8scPnEmmOThf/17JUTGmaQ8l0P8GPO0GvPTITy/lixuS1sbVojXATDtVrlT91jTa2B8xkspGcrtuXz5e9tQ85G8AIVMbLsuJ8lZYVMFE6WU1hkJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313852; c=relaxed/simple;
	bh=aw7gSclGgHOMYFXM65JfqIZ5vPSvREto+oXqw0aBrWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/otNW6bKcqJkG4bR5Fu0WaDiQBqlMMUZ+eZ4N+WZUcIs89CA0B3WSNyfhNaRqxlnX5fJI/x0+554cNyv4NIxwllXVIEe32FrUweO3tNRXEf+HQIYAy7RBAqDYcgN5FyjjIhzcrCNd14H0mC8/QRu0oQnnnfGy6DWXsTxwCIm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cGuxcfEq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cGuxcfEq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788313840; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lyyoECC/D8UwO02gtsoFLJImfW9pm0Ve/cCx7wNXS4c=;
	b=cGuxcfEqeq7YbyQZBaaWnThZluw+jBNakWQGs4MX2Bx0izYWb2+GCa9+fm6hi7ZqnX89QlNfhIbeXdGXPeCE1QeBWo/zbSpO+IYv2PLq0BtSPHBbFZ32uXK4JVaVXV87rFnUwnpGXojbrShLci77Ht7FPQnPkf2C/k7iwy6PuHo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XAAsUwd_1788313839;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0XAAsUwd_1788313839 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 09:50:40 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] erofs: add sysfs feature entry for xattr prefixes
Date: Wed,  2 Sep 2026 09:50:39 +0800
Message-Id: <20260902015039.54190-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.

Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
Cc: <stable@vger.kernel.org> # 6.4+
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v2:
- add Reviewed-by tag (Gao Xiang)
- update list in Documentation/ABI/testing/sysfs-fs-erofs
(https://sashiko.dev/#/patchset/20260901062243.109172-1-jefflexu%40linux.alibaba.com)
---
 Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
 fs/erofs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index e4cf6fc6a106..0b8b4354e40b 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,7 +5,7 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		compr_cfgs, big_pcluster, chunked_file, device_table,
 		compr_head2, sb_chksum, ztailpacking, dedupe, fragments,
-		48bit, metabox.
+		xattr_prefixes, 48bit, metabox.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 6734483a440f..dfcec9376cd5 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -95,6 +95,7 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+EROFS_ATTR_FEATURE(xattr_prefixes);
 EROFS_ATTR_FEATURE(48bit);
 EROFS_ATTR_FEATURE(metabox);
 
@@ -108,6 +109,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+	ATTR_LIST(xattr_prefixes),
 	ATTR_LIST(48bit),
 	ATTR_LIST(metabox),
 	NULL,
-- 
2.19.1.6.gb485710b

