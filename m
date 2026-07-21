Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734C1EDA0F;
	Tue, 21 Jul 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637296; cv=none; b=alIkRXUXuRjzdefsyMqZvER1VqZG1hbsNMewp7bg1TsTBTNktCAbSSh0dbtfTvYDylVDLGRfxwg25Cq/J0VpFjgPmzZ4SelwAUDmXqzlLzsZsqZJtFMQsIZ31/8e+cj4BYgYczIwec+zVwR3zhpBXizHmXamI3AF20oASvwhNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637296; c=relaxed/simple;
	bh=WTWsdk0tiyN6gtuMp8CDi20si1ZRC85em22vHK/UEcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfwEamE6rEipHHPcEm7rOQxTXGxZ0h0boCHMYrdArt7Tcjgvn/k6dOuSpZEaFzi4Y69qdekojtKIUjokuvO7958EPE9+0lYMNkGnoaGsnlrdrjr94WM4tQq48GZRFnv/H/jiTud5JdQ/7mgyGmR4kSiqIh2uvrGxOQT7SOZYvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n1X+slWl; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n1X+slWl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9KtnsxyRZEF01/CsKv9VL4GH6V2rNoA4quHnbHU4djg=;
	b=n1X+slWlhhk0evH11mpxM4aZ/9CGHMh4mT0sZD1ksMsDzo8Lk9G9xsQrAyW1oR/Eikwdd62rY
	YyJ7eVY+UQ83gHM7Xw6EHWJibAsivs69M2fXYJ2OEnivjKoCGC9rkWUBLoXQGlKQVz27LZrWBMp
	oUxdyX7L9VKHrk7g9qkDmGY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h4Gmq0WMYz12LDV;
	Tue, 21 Jul 2026 20:25:15 +0800 (CST)
Received: from kwepemo200010.china.huawei.com (unknown [7.202.195.178])
	by mail.maildlp.com (Postfix) with ESMTPS id 621A740579;
	Tue, 21 Jul 2026 20:34:49 +0800 (CST)
Received: from huawei.com (10.44.142.85) by kwepemo200010.china.huawei.com
 (7.202.195.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 21 Jul
 2026 20:34:48 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <stable@vger.kernel.org>
CC: Naoya Horiguchi <naoya.horiguchi@nec.com>, Andrew Morton
	<akpm@linux-foundation.org>, Miaohe Lin <linmiaohe@huawei.com>, Sasha Levin
	<sashal@kernel.org>, Jane Chu <jane.chu@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
	<wangkefeng.wang@huawei.com>, <xiqi2@huawei.com>
Subject: [PATCH 6.6.y] mm/memory-failure: fix missing ->mf_stats count when hugetlb folio already poisoned
Date: Tue, 21 Jul 2026 20:19:56 +0800
Message-ID: <20260721121956.124887-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200010.china.huawei.com (7.202.195.178)

[ Upstream commit a148a2040191b12b45b82cb29c281cb3036baf90 ]

When a new subpage is poisoned on a hugetlb folio that has already been
marked hwpoison (MF_HUGETLB_FOLIO_PRE_POISONED), hugetlb_update_hwpoison()
increments num_poisoned_pages directly, but the per-node ->mf_stats is
not updated because this path bypasses action_result().

The upstream commit fixed this by routing all counting through
action_result(), but the backport to 6.6 as commit 252bb328b36f applied
only the refactoring without the core counting fix. This patch adds the
missing update_per_node_mf_stats() call to fix the inconsistency.

Fixes: 252bb328b36f ("mm/memory-failure: fix missing ->mf_stats count in hugetlb poison")
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 mm/memory-failure.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 86cdf36ee3bb..5f9203bf8ec1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1947,8 +1947,10 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 		raw_hwp->page = page;
 		llist_add(&raw_hwp->node, head);
 		/* the first error event will be counted in action_result(). */
-		if (ret)
+		if (ret) {
 			num_poisoned_pages_inc(page_to_pfn(page));
+			update_per_node_mf_stats(page_to_pfn(page), MF_FAILED);
+		}
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
-- 
2.33.0

