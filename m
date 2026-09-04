Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D6274FD1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489352; cv=none; b=cp/k3hcosbvE4qsaD7LATlFYb2xbr/30sQ6RmsqF7odxkEDC1U9uDAAaRFsXCw28cPsH5eP2Z+4yXVFXbZZ1wwhDIGczadrSMJsInyyTMPf3+2JqH6xe8huqIlE0YQM7Wmypxq/+JWBXbdbLqc3EtWGpTMdeLXG00I442J1tJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489352; c=relaxed/simple;
	bh=4JKEYQzKbDjGWZn7gEVxFlDKKbc1S9tEBBO+tJ0HHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRz4vM8pbDaX4GqecjofZ+AarWEsjuU0XxdO/BPMxS3jtoPAdmXQbbXWMTWWnVF+VMY7kLx/hQUFw3iWz1/Uz+E2dt3sj6PiovW2pt/FxNe41TpVI614p2bibZXwIFNkwlILpiFqSFR9KFl+MA0p+D6zQzJi7KHgMD5SR2ToC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZMqAsRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZMqAsRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67AF1F000E9;
	Fri,  4 Sep 2026 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788489351;
	bh=cmc20mIYNtkacC7SrGcD4efxDWx5wrDUiIxC1Gbf1CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZMqAsROTg7S8D1VRwyYwfDOr3ryVqCXaQuWaSaSnz2HansFypOG2nqa1+MgJ4ecF
	 AWv0q7fsBaSRBMd5qC24691x6Hnw1N4HpKXQNI3R5wCPCd5Kzxf9ZjzvklYiWa8d/B
	 3omcteFdpmoqNtgj5zCl44kNC79MTu2hPYSvawbD5cAsEizWj2cz0A0nxo/GZ9G/Ay
	 UGo+VHNRlU1P9YGYmnw3qQ5Q+TRM4zo7nu/zM3kwG74RdRlUvPlIvC/hqgub3yB8s7
	 FB1uHGNMPRsv/a3rX0iJAA8sne/EX9n82vlOuoOFS/i+9W3XD7SUMWP+l35bjkqPrr
	 jDwsAFoBfUOlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] slab: simplify init_kmem_cache_nodes() error handling
Date: Thu,  3 Sep 2026 22:35:46 -0400
Message-ID: <20260904023549.2231387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-stool-flyaway-37a0@gregkh>
References: <2026090309-stool-flyaway-37a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 9d4e6ab865c48c70e684b176d3ee1574d092626f ]

We don't need to call free_kmem_cache_nodes() immediately when failing
to allocate a kmem_cache_node, because when we return 0,
do_kmem_cache_create() calls __kmem_cache_release() which also performs
free_kmem_cache_nodes().

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: 7e98f8563956 ("mm/slub: fix missing debugfs entries for caches created before sysfs init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b61225c3503bf..68407f1177482 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5323,10 +5323,8 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
 
-		if (!n) {
-			free_kmem_cache_nodes(s);
+		if (!n)
 			return 0;
-		}
 
 		init_kmem_cache_node(n);
 		s->node[node] = n;
-- 
2.53.0

