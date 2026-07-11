Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260925A321;
	Sat, 11 Jul 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759598; cv=none; b=m9WVijtQxrIiFt6FqWvfqjCkhHEBFSPERgVT5v81PymeI7wW1aZ7GwSNm5A7bk8Po7dBq1E3m+qbx/Ch+fUfaCkrt47FjvEikxx4wTCcXaHheHxzMsRhoig/OUUy0I+4nwZ4mGQbS3C6mmB/0tSdW4zVASOc4j03KCsyFwiAcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759598; c=relaxed/simple;
	bh=UHx/KdCEcvLTVbw6712hkv9ymSBOuVmMerQXaBS5Xe8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=afwcsvuvGZ5h5c44hEx9IYCpwMi5iGFgJW6VhkWsfr+1pXxx7fxlyeA4YUdAHnPET3XFiSnMAi9qnKCnlYk7q8ifvwuCktJMWJ9n/Igz3pEucLSd9qK4WMyEq/qqO+yJgk5Pp67bLJv5ZGHIJsxbjMQ2AkLB06Z+zf+bDtZxL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 01f9e8747d0511f1aa26b74ffac11d73-20260711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba486e74-fc71-4415-8b5a-585d5b3e3a08,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6be4078e0d1b9d067f170c49f73b2977,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 01f9e8747d0511f1aa26b74ffac11d73-20260711
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 798131107; Sat, 11 Jul 2026 16:46:28 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm: huge_memory: Fix kobject cleanup in thpsize_create error
Date: Sat, 11 Jul 2026 16:46:24 +0800
Message-Id: <20260711084624.207777-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kobject_init_and_add() fails, the kobject API requires calling
kobject_put() to properly clean up the memory, not direct kfree().

According to the kobject API documentation, kobject_init_and_add()
calls kobject_init() internally. If the subsequent kobject_add()
fails, the kobject has still been initialized and must be cleaned up
via the reference count mechanism (kobject_put), not direct kfree().

Direct kfree() leaves the kobject's internal state (including the
reference count and kset membership) uncleaned, which can cause:
 - Memory leaks of kobject internal structures
 - Potential use-after-free if there are pending references
 - Inconsistent state with the rest of the error handling code

This fix matches the pattern used elsewhere in the kernel and in the
same function (err_put label) which correctly uses kobject_put().

Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..7aeb17d60ac7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -819,7 +819,7 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
 	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
 				   "hugepages-%lukB", size);
 	if (ret) {
-		kfree(thpsize);
+		kobject_put(&thpsize->kobj);
 		goto err;
 	}
 
-- 
2.25.1

