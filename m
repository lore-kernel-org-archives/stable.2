Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A546C854
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547475; cv=none; b=frri7YQ7PSE2a/C7IAJE0j5mIiBaxfwfq9YMuMNGieeVdb8f6I/+aQIBzvInSQ8Va5GCyLNx/eGUc9ktUeo6YcDu0Zji+zzZ9MBfhwm/XzmgtKEYGDJtSGs0tjukptZHCEJdcPR4BF2XYS8yOzch+EX4uGFKAcBwUOlZV8yI9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547475; c=relaxed/simple;
	bh=ctKy9QzkrwFGINprhmFaQJweDP8zUfKnXLJOi5JxMXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPHQAO2XcxxKFrcNu8LJCc045UBDHdswIkqWMZogUoX9oSG31RlA134A1nNXzQ5SZ1le2h/AlxN0Nk7dJGmfk6a9MirxIHn5u15R2Dc7gXNZI/wMoy+aMKlA2RYHgdn5ajgZZwYJeNRoHtSJ2BdLvs8QHfFSehCbFZgjhPH7eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgFNm2Vn; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgFNm2Vn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ctKy9QzkrwFGINprhmFaQJweDP8zUfKnXLJOi5JxMXU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789547471; v=1; x=1790152271;
 b=AgFNm2VnNdjkZPK3FoTPXyUYKwnvLAjjx97ROTlgoK00kvbaILlkMr1BMkIYiJwnD+lITBzn
 8bI994nBfpEdLvcXScNHy6e4krwFQ6MP1GxtcgOs4TeK0+EFwHGq8hPzAhjTCrJmaPgIb8tgSJ3
 IJ0sKD2SXm6IbKUjv91IIyYI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31b1eb0a7dd8dbd5;
	Wed, 16 Sep 2026 08:31:11 +0000
X-Mizu-Trace-ID: 31b1eb0a7dd8dbd5
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Wed, 16 Sep 2026 16:30:28 +0800
Subject: [PATCH 2/2] mm/hugetlb_cgroup: move per-node usage on cgroup
 reparenting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-for-hugetlb-charge-v1-2-70fb708b2e4a@kylinos.cn>
References: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
In-Reply-To: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Mina Almasry <almasrymina@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>, 
 hongfu.li@linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789547446; l=1229;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=UjdBnpGGbOAqmA9LTLWjpAUbVlww5rMxQAkpfS0ZMyo=;
 b=ht4ri1aXNFZvYlT+1QIBQBgJWaE7t/rotF/BblSeGXDJHsFmSPTwmcEDqMtwNsXeN8hyCqSqs
 CQpwPDRXgTiCgE6aVzX9GGGePHdVM0RVWmMMkAvzDA5Qvu7iZRMvggb
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
---
 mm/hugetlb_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 1040406e7e1d..3f5ec4a06b25 100644
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

