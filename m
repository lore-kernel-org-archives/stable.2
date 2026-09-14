Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC11E7660;
	Mon, 14 Sep 2026 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353966; cv=none; b=Ygxt/epW+TMuaZa7cnNl20jRwwZKP/h/teSpLMj/oJ0h8HF4ZOIwWPDtAo1QolRxc2U7RggyBN1COJpTDD9txrBf7eSVvo4jL31RRyYNt474iDXCNQMfjUJl5IQRLpt89KqifeAn6TXGqIuOarANCr8qfqNIIrVO/gvxZThx0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353966; c=relaxed/simple;
	bh=qK+5lPCa8HUX5/ezxo8mKK0h5kxCv4PDkQne1qYc3z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vBQc925poUT7jvO2gvf1NQcTnEsuRgEE0Z0cWQ36jyOM8/KgbzVKsbARPjpSCEuDBcaDi6TZ8QkenBc9A5O04iJtzWoTMvZKA2A4h6DTGC6C6p1Hmybok9qCvXLzRdl1W8BKo/iJVZCHqRUD1jFwEwTUKeuAhl0TN5NTSp2Yirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ad32522afe611f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bbe0c4a3-3b29-4f5b-9302-20e446aab4f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:828b17566f75bd7eb8976c8866957840,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ad32522afe611f19a56ed5b684f684d-20260914
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1935826873; Mon, 14 Sep 2026 10:45:59 +0800
From: Qiqi Liu <liuqiqi@kylinos.cn>
To: akpm@linux-foundation.org,
	vbabka@kernel.org
Cc: surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qiqi Liu <liuqiqi@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: apply per-task GFP context in bulk allocator
Date: Mon, 14 Sep 2026 10:45:55 +0800
Message-Id: <20260914024555.138125-1-liuqiqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_pages_bulk_noprof() does not call current_gfp_context(), so
per-task scoped allocation constraints (PF_MEMALLOC_NOIO,
PF_MEMALLOC_NOFS, PF_MEMALLOC_PIN) are not applied on the bulk fast
path.

The most direct consequence is PF_MEMALLOC_PIN: without clearing
__GFP_MOVABLE, prepare_alloc_pages() selects MIGRATE_MOVABLE for the
PCP list, and a task under memalloc_pin_save() receives movable
pages from the bulk allocator.

Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Cc: stable@vger.kernel.org
Signed-off-by: Qiqi Liu <liuqiqi@kylinos.cn>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..3be7288a1aa7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5207,6 +5207,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
+	gfp = current_gfp_context(gfp);
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
-- 
2.25.1

