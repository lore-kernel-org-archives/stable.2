Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACB309F09
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604365; cv=none; b=dgzpOexuFaqsWit/st5Iy+dbl2VOzF/DYs/5Dg8WTW7MurVj78DSArZhcuWFG3EhDpo5X6ZHJMUyShIqjWeAMGSLefThS/OC/z/j2SAKeSqRskMR+Xj2e5vE0qdhucof2Y5Krz8kBBk8a3C6tsCSl8i1dP1azwOmK/nS5uFIqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604365; c=relaxed/simple;
	bh=m4yH7TxfsXQUadd5/cuyd3XF+4WM/hOOK19WwbXkqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6VhEfabEovaP4zIr/2TzQGrXCPDJ19D+MdTbtv6eJrQfVDca/091nTfrg8t2KKB9tyaV96/hzzM7U8WvWwCk8q2baDFZ8SUo/LBTw2tnpnDMNyq8m5PrietJ84XrKkX5gOqawClF/V+Xp2AMCMy7Jo12e8WfLy0226WFFew0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9XmQTR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9XmQTR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC2B1F00899;
	Thu, 17 Sep 2026 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604364;
	bh=RSvYzOF+BtluAr6x638LEak+0zjkQ3Pt1MGUq9cFut8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9XmQTR+Jh9c2zBtH24UEHKCLVXazvXX03R953AWH+xT4q4vuKikdMDom1chnEDJO
	 Xn8nujrnnaT7dJpORIGfeqqP2CMYRsZB5D+hBnbZysgXvkBj3fMqS5GEFbLj2eti3k
	 vdWjB+lPbgfzJYuqA5hy6dlTcPRRw7s/TdSg0Sq/h2UchIx83vS/pPjLHvFxDjw/58
	 Ud98estjr/y1opCNc075Is6MHCbd8beolN+BA2+MzILaYhuTM1MVmZGi5BTFaC4el9
	 pM5ton/OIXXs8JZusCKbx7lBflvFg8EmAlFOWPO6jfNdlLYEfYcXQyu9ebbuiGUoRh
	 edQWxFd3YcfcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] erofs: add sysfs feature entry for xattr prefixes
Date: Wed, 16 Sep 2026 20:19:21 -0400
Message-ID: <20260917001921.3361341-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917001921.3361341-1-sashal@kernel.org>
References: <2026091649-edging-stroller-a208@gregkh>
 <20260917001921.3361341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit 839f075aabdf5c21048f9801b87c0b841dd3d064 ]

Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.

Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
Cc: stable@vger.kernel.org # 6.4+
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
 fs/erofs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index e4cf6fc6a1066..0b8b4354e40b8 100644
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
index 3a9a5fa000ae9..60527159bfe76 100644
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
2.53.0

