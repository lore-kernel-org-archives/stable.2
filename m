Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451609;
	b=vFriGVMGV9Ehx+cYHxQ/oUlkCfbCWdjqM9p5UwZXujvgNG8yCbOZESFrsz4i7uAx3K/m
	 K+mB98r39gOSVCQhGW/q+skLqf8doaO5X1PMjaj1HokKh17HFdmm0SWV62DCG/qyHyFad
	 mC0fD8IVxlBlI1CwjR/BEuJAIjD07wwrOSNO8/7Wburtd58wzqESpo4TD1zk+NNG8Grw2
	 Cngux2ACeYEhTXn+zv94x1J7L+cm2XTtbmd5tUoJnh6zb6uRaEAEtC58tTuMjO3FVreG3
	 vmIGJuVCLwtNA3fir+kYDJlk2RlNBy1yDqbetVJu/LaB4mv2k2aKz4rKR09lhDVsTgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451609;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G976aLSquKCcdH7Ogl2LQAUo5cChr1sJGUGr2ohKZsw=;
	b=4s5HfU8J6/1oqSusqPNwTtLQgBhv+ri8b9+v8YaL0rHSFW4De9V1849+NwNbS9Rz1dNP
	 2ZN6UDyotvsmVqTzBX/VMIyM9eoPJXtvEimX4Q9fRv+sNbHBvGu0hmPjDzzxDReMHV6l5
	 snBxSYhy59664HUCrQ1m765IpxcfcYLG5mapIKCYnlOkFMar0Hv2tPUK4G3kFpV2UgX5W
	 6kn+vcP7EzN3qB38c85EMfawsOU093vBmGfyG1McZhdZepvkJHDjB1OrlAhOgcDZUecdH
	 fdfLa8MpQMUtTqjq9v35gKfjfURpARhywT5LqlPpbVNqQtvtxzD0okm+QyYl7xbeOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lhiY8j35;
	arc=none smtp.remote-ip=95.215.58.144
Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48481606A331
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48481606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lhiY8j35
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E4KTVYZa4EaH7tbY0q+Km6luC5aM7T4+GRj8B16qzEE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451607; v=1; x=1796056407;
 b=lhiY8j356DctKds/1LkWMP1w9ks9GgPpYfJ5av6sF9SNvskpDlFYI8CaC8KCt10aSuWUjMXk
 gCoGqsLu39VoxBfRYo1O0aOYTuCIpN+HYUL878KOT0gxxFeHb66uIhqD4Uut2qTtdoBGZPzCVb6
 JJG7wwnJRm3vE+Iaz3H5SFxQ=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a33978e7f9751d3e;
	Mon, 23 Nov 2026 16:33:26 +0000
X-Mizu-Trace-ID: a33978e7f9751d3e
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/5] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Mon, 23 Nov 2026 08:32:11 -0800
Message-ID: <20261123163301.1568240-6-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device-private PMDs represent mapped pages, but smaps_pmd_entry()
passes present=false to smaps_account(). That treats them like migration
entries: mapcounts are ignored, PSS is charged in full, and exclusive
mappings are accounted as shared.

Match smaps_pte_entry() and mark device-private PMDs as present so
smaps_account() uses mapcounts for PSS and private/shared accounting.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 34aaf80cd46cc2..fd32840a8cd7c3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1034,8 +1034,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(pmdval);
 
-		if (softleaf_has_pfn(entry))
+		if (softleaf_has_pfn(entry)) {
+			if (softleaf_is_device_private(entry))
+				present = true;
 			page = softleaf_to_page(entry);
+		}
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
-- 
2.53.1-Meta

