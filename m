Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9619368957;
	Tue,  1 Sep 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243770; cv=none; b=KO4B6TqU+WD2DmEvNOnVIazJWioYW/2SALXWrjLdCQk746WQvDOcD7xCUByfAp9+BSHXZi0ydh0WHMaJJXPiz9xs3YGdqk1AxNmozF1BIYtkCj94Z15egnTHwEGp+ftMlkew0El+7XZ6r22OQA7rUWlgvCs7PSlLOcyGYOBDieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243770; c=relaxed/simple;
	bh=TwmW2Y3hTNJs+JeC5UXsySBHOgKd1pXNR1ljskMkGvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lBLe0QeyxvYF34qgiWn5+StZsRxMKxWhJb5wK92jwZPCRMm2PaKzStvLAC7AOEMX/PZkneD6t9ZTYs+SAHEVrdEhdBI65BVNyyfqCAXHpBrpsvJkGLgX3zcN32UvpSj33+xwLJCh2+ok0Zo1SMhleExw7EXuFUzj4sKAE548quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xVgwMakd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xVgwMakd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788243764; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=45ozspufcHZUV7IFzNQg9IRvWuMvisXbo+FeNLjLT5g=;
	b=xVgwMakde3XnKRKPNR0IPofuA/Hyet6cop64rDUTNoxqE38exN0cKsZ2p2m7pn8F7E7CqWZE8hcTd7aVL9zHnXINkesqCrss2Hh6cPCvn1YMv647R3gmFgPZut0BLWcTkIjJPNmtq2WarPsHpWCEsQIJCXBX1ptg+DzYjsPEza8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XA3vWPg_1788243763;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0XA3vWPg_1788243763 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:22:44 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] erofs: add sysfs feature entry for xattr prefixes
Date: Tue,  1 Sep 2026 14:22:43 +0800
Message-Id: <20260901062243.109172-1-jefflexu@linux.alibaba.com>
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
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- add Fixes tag and versioned Cc-stable tag
---
 fs/erofs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

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

