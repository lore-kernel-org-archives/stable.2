Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAC31E823
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479421; cv=none; b=Hgns5dXbSZ5u0nywgaNZ2yMGpkmBCEZRo9i2eG+doHSVxUGVpakOmP1QpC3okBLroOIHsTrNGiMkNemQ50YlLXnQBy9DElrTGelTo+1oE1G3he4p7lN58ssWb+/aelYVROaXx9YRfQFdaCSrRsDGIYXcmO2ND6jHgposX+8sGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479421; c=relaxed/simple;
	bh=hppceOpWXiCC7EqCtZd1R6pLABgHvNnChLrbRyiLF/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxZc0j3MeZf0WACKPmdGwphrqb+L/HDT0aHFjrlbyX8Ze5LrtQZAuTmll7D/Cc0GQs1tK4iQ0LaUC1h47vpVl6aQ5xKWsT1lD+4FTo3F9nc9FW6JOJPSU87BhDJtyRccXw8ml4QCjN8U2bTkuWOBBwA2xgImEygljv+pnNgNcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLI1xRJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLI1xRJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466DF1F00A3D;
	Thu,  3 Sep 2026 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479419;
	bh=/7NUdW/hMwX+Ft52klzjW8ibceNApwTOHTPTfCH+5g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLI1xRJceX8D3Dq2k7ExNYUibgNSTTQhfeaxOdnfYwzvfEN4CtHHoGtlvihQL+sT/
	 OFhqaoKnidep4eXPYrjijvITFl4OEvE7mrzILC2ja/g7I82ENFCPc9YbKE6aWvBVNN
	 bcvtGLjJLe4+GsBdsOgtqKM4FczCnF0Bj5x8vJJRFwMZl/OmIDSlJ1vR2pNjSNvfcq
	 KL2PURDLe1sxfLFooqGous1JH1LhoeuM6wNii/ZJydzUkmqYq6SlL05vl9dBNm/VMG
	 HgkHPbO7pQFq6GC3orqVKNZIEAUER1agh0vcUNfHpDuNowI3ykVFY9QwqQaS26IqdN
	 /Kf8+piy6Q0EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Liu <ye.liu@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_owner: use memcg_data snapshot to avoid TOCTOU in print_page_owner_memcg()
Date: Thu,  3 Sep 2026 19:50:16 -0400
Message-ID: <20260903235016.1804338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-dayroom-oblong-b702@gregkh>
References: <2026090314-dayroom-oblong-b702@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Liu <ye.liu@linux.dev>

[ Upstream commit 90f095b816e25c6a9e4446d299bac5007fdcb3df ]

print_page_owner_memcg() reads page->memcg_data via READ_ONCE() at the
start to guard against tail pages and NULL data.  However, it later
re-reads page->memcg_data locklessly in two places:

1: page_memcg_check(page)

2: PageMemcgKmem(page) (via folio_memcg_kmem(), which includes
   VM_BUG_ON assertions for tail pages and MEMCG_DATA_OBJEXTS)

If the page is concurrently freed and reallocated as a THP tail page or
slab page between these calls, the VM_BUG_ON assertions can trigger on
CONFIG_DEBUG_VM=y builds, crashing the kernel.

Fix both TOCTOU issues by using the memcg_data snapshot throughout.

Link: https://lore.kernel.org/20260714015117.78351-10-ye.liu@linux.dev
Fixes: fcf8935832b8 ("mm/page_owner: print memcg information")
Signed-off-by: Ye Liu <ye.liu@linux.dev>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted memcg_data decoding to Linux 6.6’s mixed mem_cgroup and obj_cgroup representation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_owner.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4e2723e1b300d..e76bd0fad80ee 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -363,20 +363,28 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 {
 #ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 	bool online;
 	char name[80];
 
 	rcu_read_lock();
 	memcg_data = READ_ONCE(page->memcg_data);
-	if (!memcg_data)
+	if (!memcg_data || PageTail(page))
 		goto out_unlock;
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJCGS) {
 		ret += scnprintf(kbuf + ret, count - ret,
 				"Slab cache page\n");
+		goto out_unlock;
+	}
 
-	memcg = page_memcg_check(page);
+	if (memcg_data & MEMCG_DATA_KMEM) {
+		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		memcg = objcg ? obj_cgroup_memcg(objcg) : NULL;
+	} else {
+		memcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	}
 	if (!memcg)
 		goto out_unlock;
 
@@ -384,7 +392,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	cgroup_name(memcg->css.cgroup, name, sizeof(name));
 	ret += scnprintf(kbuf + ret, count - ret,
 			"Charged %sto %smemcg %s\n",
-			PageMemcgKmem(page) ? "(via objcg) " : "",
+			(memcg_data & MEMCG_DATA_KMEM) ? "(via objcg) " : "",
 			online ? "" : "offline ",
 			name);
 out_unlock:
-- 
2.53.0

