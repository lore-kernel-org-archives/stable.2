Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89913C9C4;
	Sat, 11 Jul 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743606; cv=none; b=KcLAB1y2Zn5apUP5dvgOPK6NMkaK8d3h1oOOLdUpml/v9KhroL5hypePa4aNRLFTCbc97Sp6KJPLh69vejxTc4x1C9gt3ziOBMNobAzAPnCPfgXScI9HKx0e4VnSfjPEeo5DKxTVw2CVY/EzlXVe1OW8seLWSWGQfo5sg/C8SRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743606; c=relaxed/simple;
	bh=wL/rTiue4eDZMYo1E6xOL0tZBPsxYjpn9iZ320TLD/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJJmiv2q/imP24oZU30okDztFk79jP7KwWJvwLIdFTCEOUGpZotcvcmPoOS12zrwtn9G/f+CAjy6/Qf/SpBMVoVGs61JhSTgcGju0Ms8HfEIiKkGwQNTUF/Om+JvVGdDNTo+hNykGRTIjXtpuG1fPcBiR+osEirNxtEoQZtQZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c742c4a07cdf11f1aa26b74ffac11d73-20260711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8f0cc9af-a872-43b3-8a0c-47185e98c887,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d01a9fcadf696ed342315feaf3c2f80d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c742c4a07cdf11f1aa26b74ffac11d73-20260711
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1833275747; Sat, 11 Jul 2026 12:19:58 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	qi.zheng@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm: shrinker: Fix double-free in alloc_shrinker_info error path
Date: Sat, 11 Jul 2026 12:19:54 +0800
Message-Id: <20260711041954.95749-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In alloc_shrinker_info(), when shrinker_unit_alloc() fails for a node,
the error handler calls free_shrinker_info() which iterates over ALL
nodes and tries to free their shrinker_info. For the failed node,
rcu_assign_pointer() was skipped, so its shrinker_info still points
to old data. This causes double-free of valid shrinker_info structures.

Fix by tracking which node failed and only freeing shrinker_info
structures that were successfully assigned via rcu_assign_pointer()
in this call. Failed/unhandled nodes are left untouched.

Fixes: 15e8156713cc ("mm: shrinker: avoid memleak in alloc_shrinker_info")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 mm/shrinker.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 7082d01c8c9d..92c6cb455fc9 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -78,6 +78,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	int nid, ret = 0;
 	int array_size = 0;
+	int failed_nid;
 
 	mutex_lock(&shrinker_mutex);
 	array_size = shrinker_unit_size(shrinker_nr_max);
@@ -98,8 +99,18 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	return ret;
 
 err:
+	failed_nid = nid;
+	for_each_node(nid) {
+		struct shrinker_info *info;
+
+		if (nid >= failed_nid)
+			break;
+		info = shrinker_info_protected(memcg, nid);
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, NULL);
+		shrinker_unit_free(info, 0);
+		kvfree(info);
+	}
 	mutex_unlock(&shrinker_mutex);
-	free_shrinker_info(memcg);
 	return -ENOMEM;
 }
 
-- 
2.25.1

