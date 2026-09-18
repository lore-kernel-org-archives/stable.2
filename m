Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6922931E6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700211; cv=none; b=VOwsQFRcKwwTKnYncfbSG+nuaYsLn2PnMB81F6twsgPNklTFcCPmPC86nG2LVPu8dQtraHFDw+Fe/cxMu0grbetftjuxCEvlBMI2F4fpxSZlLqfl9MX6bwntLq6OIrccnqLkVzwn0b94A+jJ0DSv27kg8u9x37CiY0fWQOHK0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700211; c=relaxed/simple;
	bh=gMDNPKvkl43rEG07pQr1WtDNrBKGvQm6RDcbilGOvZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8/aRbWCcMd+g0pcHRm6WMpmdMwDAN9q6mMgEWQF5TV1XPBqNKtIKkVFrxEYG418cu1aOQgPT+Qke7j7Zjcgx9cNASEbkfC08G/ozGqm/9sYTtGEctHz+mI/a8VrxBx3x90hzwWBlhjRWKUk2j+v1rArXn/poj4FHWDehggwJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RVtnNC4B; arc=none smtp.client-ip=91.218.175.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RVtnNC4B"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gMDNPKvkl43rEG07pQr1WtDNrBKGvQm6RDcbilGOvZc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789700203; v=1; x=1790305003;
 b=RVtnNC4BK8QGmcO/exyqydAFSTV0YeirNb6Zjy8DVOkPRyRDYF51Et9DT/CT1DoWRv0vOBfC
 3j5NVNTKV90jkAl90kIK7SHumrAcgjCA2Kff17jp6v378K1mNF6UZLtD7DJs5F/u2OE41Oq/WPA
 gTkLOLsJbVmHP1UsH5tHoBDg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c6d4e5d4c2fa1a8;
	Fri, 18 Sep 2026 02:56:43 +0000
X-Mizu-Trace-ID: 7c6d4e5d4c2fa1a8
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Fri, 18 Sep 2026 10:56:11 +0800
Subject: [PATCH v2 2/2] mm/hugetlb_cgroup: move per-node usage on cgroup
 reparenting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-for-hugetlb-charge-v2-2-2b6d8c2bdc36@kylinos.cn>
References: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
In-Reply-To: <20260918-for-hugetlb-charge-v2-0-2b6d8c2bdc36@kylinos.cn>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Mina Almasry <almasrymina@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, hongfu.li@linux.dev, 
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789700179; l=1276;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=p5jmZoyk44qDQ7+C6YBxS0kRkY10Qpp1sAnAzxNdFPA=;
 b=/OH25k+LSrmo9fr0WYUNPHD73MaTB/ENpGnDv0ALWpziXS1YtqPaTv68o6yipqVlSRX790FDr
 6/Vk99IKXd2BHsD8X1lyrY7kNMYA3qPzOg2e3pqVT/57VMQckpUFdKU
X-Developer-Key: i=lihongfu@kylinos.cn; a=ed25519;
 pk=rUpDSpB3neoNZRlGG6dHlFb3RepiJakcev+ucyqaZzw=

From: Hongfu Li <lihongfu@kylinos.cn>

hugetlb_cgroup_css_offline() hands the folios of a dying cgroup over to
its parent with hugetlb_cgroup_move_parent(), which moves the page_counter
charges and the hugetlb_cgroup pointer of the folio but not its per-node
usage.  The parent's hugetlb.<size>.numa_stat is short by that usage while
they are charged, and underflows once they are freed, exposing incorrect
per-node usage values to userspace.

Move the per-node usage to the parent as well.  The folios keep their node
here, so only the cgroup which holds the usage changes.

Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7cf7c18119b4..3fb41311e4c7 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -241,6 +241,8 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);
 
+	hugetlb_cgroup_move_usage(h_cg, parent, folio, folio);
+
 	set_hugetlb_cgroup(folio, parent);
 out:
 	return;

-- 
2.54.0

