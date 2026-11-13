Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597729;
	b=zkh0OZ6kavMNF+SgFwzn66M7gyOGeO9XI3OOaW6wgne1bc6SpI4cKiNu6ztyb3DF9fxb
	 sCzQhVXrjask4W4Hb3Hof8VFJ8oxpcncXk5HPIAC409XOQXnD99v00Al8iWoM+7DCw1Xq
	 irMR4AX7UqL/Q9KF1n50M2hlLX3RvyBA5ICZRSK/VL1AsQCqx/tY5OUgSatseMpxyW5qB
	 /y4DRn5ZSVdmGWqtjyBSagP/RinllnXxPS43vG3UQ9O7epUJu8HzdQ/X0hhEPySTCLcsB
	 Hmx02Op38YtiDOk2WoytHFp9kkz2+2nlBlEHxOCyR3sIt0E0pWXSpo/r1BksLKFePTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IqKczo/Kf1/w2lyMd7VArM2SiybYGaD+66Xdpsa1e5w=;
	b=I/8IQqx0Rx1LiSv84sFWcXbNKYhAXbna7WJhQfJ2V5udif10wLj7dCjCrWsuZGbvoxXL
	 Uvvp/ZQyPHedEZENCzpFzXRNp6edsQ2O/Px2G0xX+kwZYQ9Zactz+ABiPncIr3WlNq/Zd
	 AXA05GgFI57bC5SF5F7gfJ9nH3/KUqBXhspBJ2evA9669NXCKowzhqm/HP3qP1VZQqogC
	 7GMGLBiVoedExVZyBPVBY4xA/hiawatasz6F8drX8NfDoBnAlo2CYvV7GKATa6hCSR5d4
	 01vZqr8Vry7yMVTjotbWDKMn6+7l3rbcrovGOLn0Rr4qmz4N1fHjFbS9TvfCY2Ot77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1ZhTSPf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA7606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1ZhTSPf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF331F000C4;
	Fri, 13 Nov 2026 19:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597729;
	bh=IqKczo/Kf1/w2lyMd7VArM2SiybYGaD+66Xdpsa1e5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G1ZhTSPfNvT0mq7z3DnC/DGygE7Ebkn3WMWJHlVoMxVbk9chxevz6t2tMiOCNmlaB
	 SCCbyXkzL/S3NizO1xOfnepkumglQ2HXHGgfYz/wBYrMWNldon6BnNLFe6Gl/OLCAf
	 79P4YgHJLnTGujIKtdtYJUe33/1y8K/YdvZ7HI7bmptkbRC4syIIr2GH3JFqykY4yr
	 JKlx3n7Ajuu/6VM3SC30QHEOX2M48XOyNf9HZgQFqrO9OpTciG1zOkhxGgCBSc34T2
	 k1LiHWHCSF7wnPZ6KpYJ2sCWrAT0nHvp7iDYYMQOHmcAkhVpUIxhtpXcbG1HQaYqhf
	 1i3R9mp0OfTaw==
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
Subject: [PATCH 6.1.y] mm/khugepaged: flush deferred unmaps before dropping a failed folio
Date: Fri, 13 Nov 2026 14:22:06 -0500
Message-ID: <20261113192136.2318393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201646-failed-6.1-854e5ff8b3ce@kernel.org>
References: <20261109201646-failed-6.1-854e5ff8b3ce@kernel.org>
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
[ sashal: adjusted context and comments to use pages instead of folios ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9738b70bbd453..f21b78228cb40 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2011,6 +2011,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		WARN_ON_ONCE(xas_error(&xas));
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
@@ -2056,9 +2061,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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

