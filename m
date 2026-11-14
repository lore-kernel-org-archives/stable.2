Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655582;
	b=JnaIu6Uz2sh8kdvniR5/6LruT1tOelygUebP++0WVUpv1T4Wnv3tg0VNGTE7qFBC7ji5
	 bLkwcHoCsa03OncZ3Ybw4xjUOG/paU6pcza3vbEmYVHGuzX+hW9rW9DG+rtqy9lharfw7
	 2FiePtl5/0L53RdcOBNxF0SwO5UXgbUdXeIZIVaINlW1L8TsK7B5t41xOqUSQJER2P1wY
	 rUNUFCnxYJ6yDv+ruXht9VnEUYTjGWizi5t3qKwbj3pwwGlaWhF2WHYqMB9VTiZYmx+f/
	 CKfdhIUXT+XeQcvLfUo7FSaPhSbpr4WvHq/iGV36g+2y+a7SiYdEctQo0NH+tjvcAGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tmdYvPt7kTC8oms8BNF2txsi8vvN5s8/xh5Ms39wPok=;
	b=yUpkUCEhZeURKyFaDG+KQ1CWO1Gfb6l1NzxMc/oS5CWoE1fAUYbupvKx/q7fEEfAo6/6
	 nH/5tSB2SxvdeYuZ1jQmUcXrXRIwAsVNTr0lBZd4XhsP+wSb41hWttBVoWrbK3xVLKJcz
	 zz0S+tvdzvTOjmdeAtnMRPqZd9jqowsiIsxmBfnz0Xpk6G3L2D9uorOEvXDerx2Ybq+Po
	 WRCFwrWikgV8tK5if/zF1cdUjw73bTj+ktykHhLN3glvoNMQHvYTzSoYnxdjE/Dy+MTQq
	 Tquh7Zb6ApFHduBunUIe2IbpVmwKUf0vZLFzjhpjaQOZpaYqfcDEKHG6iqwlYlQG9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5PF2d+t;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79643606A333
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79643606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5PF2d+t
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so2985092eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794655581; x=1795260381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tmdYvPt7kTC8oms8BNF2txsi8vvN5s8/xh5Ms39wPok=;
        b=j5PF2d+tiObrXoiqmds8cCaHxVxgQc7yIm0XnZIXWqe/YdfdyCdbXCm+p2dzr8nDBR
         FwcLXNauooXs/aySU3Qlhe4yzrq6goLUUyG2L/P58irz2cFqsIyNoHb8Cjq+f/DdbtlP
         bvGxuWHuLzqKGNa4dFfN9aKKHsnXwp4iAixdfYsfiZOcdS8UkC4mxmwWRUYOWa1Fm46w
         K7r5ZLd+RxWUgfo+roLkXXKymXb63EdHIeMKJR4vIkp58vmkzfUhJuSDCU/c9/S5CuN3
         ZA2RvcMq4f0W/K/jd8Dygvn57oJijCvD3gaE5I60KnXPJB3rmlp8sLWanjFwPzDOZ0o5
         gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655581; x=1795260381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tmdYvPt7kTC8oms8BNF2txsi8vvN5s8/xh5Ms39wPok=;
        b=O+ZN3JaMddjKoKVEa68URrRJ/rMIHJJljKLUFWynQW+SqSgmE29su+a4tk82T5tKa3
         4/UOq2YBayklVB9KQN5as+aJfmGSdHzyAURSLk+kU/qZ74BkvEqI4ldKzQ+xGBSvDwuB
         csQ0YP2FgF83QfG1Ho0T+GNxfSbDdskhFPkTvybjSNRM5r5PBlerG6PhzDycedYBA7O3
         pOU7CM6nYN2X8hDLscJYTlINNXfn5pJZN+HN94io9F8Dna5FAVqN5U+DqrcEdzhKLFqE
         hCPC5Ks+6/frNSLyhok8YQ2JsvdFgvhuyqZaJjnHgV147AeHgpGLLNOfO7TNYIEeMVdx
         TsTQ==
X-Forwarded-Encrypted: i=1; AL+hErFdjFmnCY9xxHnstqNQAinwIxx07XKVYmugU/Zi/6kAsx03w/MG2tRFZ044abGHZnvXtO8iWsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CBLH8bbuD6G/5BsDESrENvT7/v7sM4Dpe9ggpclC/xj3IdFIS
	s4QEP3Z4rPupUraPvPsmBVVuOqvS9ekqk2JFN2kFlFl+CPPhuPCW2wnup/kld7r+X5s=
X-Gm-Gg: AYBFou3ulG6RBTjRrYmFR75CTVSr1SEiugmu8fjj78fnbJ+HQ36eShbI42NBJux69lR
	lwo1ewWPZpPbJo3JSvT61cG4uAyQyP3okgLXGeuDSww9o7rUFborV2myNb2P4vQkOIzyh5+lRC7
	zMAKTjOVUnaPg9H27oPpmE2Mt448+PQn9pX6Kw85ihlIbXN2BU9ndTVNuBN2ctHRUpFId16n6KU
	d66X6qjSZh8Ytfc2enNezUok9zPE5G6C7XF+eI8J3Zo6nOa/o5A2uohoF+yYBaLomVnRYl/3Xl8
	Q/QXSeJXpqFyfyvQfZmPdzyeptfbg9PLiEVFJk2o0lcVI9v3OlWVc7YazkEXq/bXNvKB2caKlrv
	yMItTB1XL7zB2FvZcq+Yf4GJYHZ58w+G3znoTeuwC4G3sGCwJAfq5P9wbkG/AYTgy++aB6m/k+U
	xNF58R+5r2LHGbd2AoIhN4Q9vub4nQKcIMIdXuYcrUcAdirv0unZFjjG9RKUsnX3BsW1srG7Asu
	JTcsk9BjvsJ9cBK7jHWVkGMBuRO1+g4d1mGeDgIlAjWpC0EpaCP8K1sz4G20aiR3N3ESHwy67TS
	a/5T1XVdxoJvi3C4x7saAgL01zquy0BViFtObEBTmpewrUKY+LT8tvarisALJiT/MAmdEXnlIqq
	iO6j/jQ==
X-Received: by 2002:a05:693c:881a:10b0:35c:ba31:6fef with SMTP id 5a478bee46e88-37967cdd3c2mr4870211eec.36.1794655580476;
        Sat, 14 Nov 2026 03:26:20 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:9d36:3b30:f4a3:7b5f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm16190627eec.5.2026.11.14.03.26.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 03:26:19 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/3] mm/hugetlb_vmemmap: fix deadlock during PMD split
Date: Sat, 14 Nov 2026 19:25:23 +0800
Message-ID: <20261114112523.75208-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114112523.75208-1-songmuchun@bytedance.com>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
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

vmemmap_remap_range() currently walks vmemmap page tables under
init_mm.mmap_lock. If the walk reaches a leaf PMD, vmemmap_split_pmd()
allocates a PTE table with GFP_KERNEL and can enter direct reclaim:

hugetlb_vmemmap_optimize_folio()
  vmemmap_remap_range()
    mmap_read_lock(&init_mm)  <-- outer read lock
    ...
      vmemmap_split_pmd()
        pte_alloc_one_kernel(&init_mm)  /* GFP_KERNEL */
          <direct reclaim>
            ttm_pool_shrinker_scan()
              ...
                change_page_attr_set_clr()
                  mmap_read_lock(&init_mm)  <-- self-deadlock

Since commit d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on
attribute changes to avoid UAF"), reclaim through TTM can enter CPA,
which also takes init_mm.mmap_lock. If a writer is pending, the nested
read blocks behind it while the outer read cannot be released, causing a
self-deadlock.

HVO walks vmemmap ranges whose intermediate page tables remain present.
vmemmap_split_pmd() revalidates the PMD under init_mm.page_table_lock
before installing the PTE table. Use the lockless page-table walker so the
allocation no longer runs under init_mm.mmap_lock.

Fixes: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/sashiko-outbox-206969@kernel.org/
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
v3:
- Collect Reviewed-by from Jose A. Perez de Azpillaga
---
 mm/hugetlb_vmemmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6fba3184356c..5852b0a1c479 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -161,10 +161,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
-	mmap_read_lock(&init_mm);
-	ret = walk_kernel_page_table_range(start, end, &vmemmap_remap_ops,
-				    NULL, walk);
-	mmap_read_unlock(&init_mm);
+	ret = walk_kernel_page_table_range_lockless(start, end, &vmemmap_remap_ops,
+						    NULL, walk);
 	if (ret)
 		return ret;
 
-- 
2.54.0

