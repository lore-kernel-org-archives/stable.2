Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F63ED3BA
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566092; cv=none; b=ieMkK3FVFXNFvBrCW7WLSDlu4Cqtw5epk1/csDLtQd5RfWSD/cS8KGjYUT0+7n9u5ppJ0lBB/aKq3quYEJb4DMu4mCtKYicH5WWFsnamUr+Cr7FQYJE2qZ/fUjL0VyG/wKdF4x2qkCJHNs4oiDmP+h7ylBdOcvWFDabD8jxTv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566092; c=relaxed/simple;
	bh=3RMRvX4rfv4Zikl7lf4YYQDCdkYXWDBC95DUBSsIcrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDE/A7wX8S/+Y2tPZ/rYCQtO2NEOtwFHkZNthWbBi4/arBplzZkBouBk5o4ZhG0fmwHCq/W43VCqEseMJXbiUggQ2r7/pdwEq/G0rdXq0apKcJ1Q4/C+oc57sYtbDVcejd1ONJEVGg65OdeWZhxHLRMiO8IAVYlkzLqVP8+JszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ekfEqHXD; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ekfEqHXD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PFQg/hV4T9rW1r0dVEyP1eY8RRhTyOhCmYxwkxWgSmk=;
	b=ekfEqHXDmGuudTmmYMl9Bg1ZBrAwVOJJDODCQ/wRf8so6+n5t54Wd8ItASTatZHbJxEpcGDHu
	pDTenzOoFCeDq5GYGnPLCGGHMwg8EFYWB00Bqqde3Ci7iml66GhAqU1x3Zl4z2DKrgnKgaNe4wX
	Y1KjwwC2XP4CMaPeTDwqU3U=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hT5tN66DPzKm5m
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:57:16 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (unknown [7.202.181.14])
	by mail.maildlp.com (Postfix) with ESMTPS id E34444056C
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:08:04 +0800 (CST)
Received: from dggphicprd10024.huawei.com (10.243.6.112) by
 kwepemf100015.china.huawei.com (7.202.181.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 18:08:04 +0800
From: Abbott Liu <liuwenliang@huawei.com>
To: <patchwork@huawei.com>
CC: Abbott Liu <liuwenliang@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] RAS: Fix inverted context info bounds check in ARM processor errors
Date: Mon, 24 Aug 2026 10:07:15 +0000
Message-ID: <20260824100716.3507949-2-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824100716.3507949-1-liuwenliang@huawei.com>
References: <20260824100716.3507949-1-liuwenliang@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100015.china.huawei.com (7.202.181.14)

Commit 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past
allocated memory") tried to read ctx_info->size only while the context
header is still inside the error section, but the bounds check it
added is inverted:

	if (sz + (long)ctx_info - (long)err >= err->section_length)
		sz += ctx_info->size;

sz plus the offset of ctx_info within the section being greater than
or equal to section_length means that the context header is already
past the end of the section, so ctx_info->size is dereferenced exactly
when that is not allowed. Conversely, while the header is inside the
section, ctx_info->size is never added to sz, so ctx_info only
advances by the header size and every following iteration parses
payload data as a context header.

Change the comparison from >= to <= so that ctx_info->size is only
read while the context header lies within the section.

Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
Cc: stable@vger.kernel.org
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 drivers/ras/ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 03df3db62334..4ca3435d90a2 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -74,9 +74,8 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	for (n = 0; n < err->context_info_num; n++) {
 		sz = sizeof(struct cper_arm_ctx_info);
 
-		if (sz + (long)ctx_info - (long)err >= err->section_length)
+		if (sz + (long)ctx_info - (long)err <= err->section_length)
 			sz += ctx_info->size;
-
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
-- 
2.43.0

