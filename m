Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597548;
	b=heKFma83BtVZu47FIblndYqruDgi+CVHfskw7uwwxRq4KyhM8eBIJV4KN6+yWb57z2rT
	 RrSvTXuP6Co1pyP+Pk7Ryx1XOIJwJa+Wz6jdENT3NtAeEOGyCxNfiJseyWm8FgVrrYeVH
	 UF6Tl2rDePvhIcajxBlZHxoJnqf7WNOnhY/OkSs15BAVikAnGZnlLuv3Dpuydo0bEeyOR
	 Fg8RToRaLBec0bX6NvofoFvCcWCUEHId3HK3zsoRiZbXxxzbUpkswAEzDmM8Tq+9hxzhy
	 dZ1Eh0Qr524ub9ZB8N4ODv047TbBX35jzTNU8HLvYwh7WRvTDQlupyevh53a53JC1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GDyxkB3EB84MtBboCW4xm0OV9AxbT21vpAxfS0ReNCM=;
	b=1oGzZdraDsHmeIOGnzKVnBywfDla7ACrxNzTdzNtZSPQX2noFmTmmlyYypF3r8cL9Uaf
	 fLU60DfLUKJd9CeLYIOnX8c0e4PuBdNP0vkhUngzNedwajwrjeINuHobKbrB/VkdxfUz0
	 AfCPR+/kGMOOfZ6uGlsGUMfdpmkzh19/k2IM0tNI4b1tMgyRnFDubV6OcNOCx2/+j349X
	 /b2D+Ec6DrrD4Xkt1tNU3pmWMRS3u+AGKXrP1XecPQLrGHdVm2bh2SHZm/4F8tcLKRKpw
	 g6ekap7pLsGXtD8ezVmhWcsuUHj4qI0KsVrUF4L1i8EEdClxw7IwBbdLCH2P07S0q1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeMZs0Fp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DD606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeMZs0Fp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31831F000C4;
	Fri, 13 Nov 2026 19:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597547;
	bh=GDyxkB3EB84MtBboCW4xm0OV9AxbT21vpAxfS0ReNCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeMZs0FpY91ppSX1Ft7pKC/k1sieiKVpBRYCbEZzu/kEbFF9LuUUEJHAcfXYItGoT
	 3lrb7M0xmi3CIY15Mc4e82bN7H2golJsGXtWpwa5hKjAEwtNZwjAVHSAWKs6oFpu9N
	 PQcVtrRzpU86A9RL+OpvqjCQZJ9bqmEFb5cUl5HcIY6pqVCree2ndIsa371rNyqnLE
	 fqW+xbWhJR/6uao+EHvo+xf0nhkoY5qlpId4vNLBl4JJ+95lxmz31NR5/396lfNzQW
	 DxBezyVkdad01V00YLYEyHAKa5Blx4OQA9SY/xVEv9+i5HFAamy/NdBsKGhzixt3qS
	 dDd4kelPomwXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/khugepaged: flush deferred unmaps before dropping a failed folio
Date: Fri, 13 Nov 2026 14:19:04 -0500
Message-ID: <20261113191837.2249604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201204-failed-6.6-854e5ff8b3ce@kernel.org>
References: <20261109201204-failed-6.6-854e5ff8b3ce@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 854e5ff8b3ce2a776586cabebaeae645c992345b ]

collapse_file() can fail its reference-count or dirty-folio check after
unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
then unlock it and drop the lookup reference before reaching the common
try_to_unmap_flush().

The page-cache reference does not keep the folio stable once the lock is
released.  Another collapse can replace and free it.  With its PTEs
already gone, that collapse cannot flush the first task's per-task TLB
batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU can
therefore retain a user translation to the freed folio.  This has been
reproduced with unprivileged MADV_COLLAPSE on a memfd.

Flush at out_unlock while the lookup reference and folio lock are still
held.  The common flush continues to cover the accumulated pagelist on
both success and rollback, preserving batching on successful collapses.

Link: https://lore.kernel.org/20261007041001.43181-1-kylebot@openai.com
Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Assisted-by: LLM
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted folio-based cleanup context to the existing unlock_page(page) and put_page(page) calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c0a3d09cfd976..8a907d636c454 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1999,6 +1999,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		list_add_tail(&page->lru, &pagelist);
 		continue;
 out_unlock:
+		/*
+		 * The page may have been unmapped with TTU_BATCH_FLUSH.
+		 * Flush before releasing the lock and our last reference.
+		 */
+		try_to_unmap_flush();
 		unlock_page(page);
 		put_page(page);
 		goto xa_unlocked;
@@ -2024,9 +2029,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 xa_unlocked:
 
 	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
+	 * Flush before copying the pages, or releasing them in rollback.
+	 * This is a no-op if out_unlock already flushed the batch.
 	 */
 	try_to_unmap_flush();
 
-- 
2.53.0

