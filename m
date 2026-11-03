Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793739651;
	b=JLP90TEs/U8/BbqicErQwASVkcWPQs/bR7y+p6fN/5YmrfGXGgOcc2AtwVcDaYn2t1WD
	 CzzXMvMkGmLeGCgWvjMQcfGtMHyfFQNKYwJD2bmiNjpGMhDjfDndEp9H23rJjvUjPmc9V
	 aw82o3BhtEL8OxkAU8L/hBFZIVj4wqL3N9UK6/T2HtKdMMcx3AtoPaOuIhQ7F2iJyrotJ
	 pB6uz/7Dbmb/t0xStjlCe82KRK+nImkCTX/4wu30O+eFRB7AjTFQtdHyqmJdeGty+ClNd
	 Szdrii7VBj8gnGFMBBA0IBbDw55NuqSYXUc6/2uF6UaRsXIibMjaFaCTlKIixlqvFHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739651;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SAHyYVdxgXEikOMk1urxi7cb5S18I8Y179gtTzRwTU0=;
	b=NE0365EwvBnD5y0KK6FxBtyTXqsCIRLICrd4p/qGsoYB0SOE4PDU+Z2CcB9ijNmuGKag
	 dWuUsXbg6C6Gd8KIGtchlcDUQER9DGo93xclxVTbFNpDOlTDcdsLJ99DRPyNnG4q52vKC
	 46AHaW+hoJzr1OfXHwPR00he3mB84qma55J3rdJn3+CFGNbLFJtocU4x5jyVf2szCRnl5
	 anoG6vK7Sc9g+46VZ5wpzNolBRkI3kXGeelf0GShhQnf3EA/WlZKAYrSs55SqDJh4oR5r
	 XbSq42KCFpYMWlGF/MkhE1wS1re74o2i6mYRkzYuqj3wC+oZQn/8l3khoJgVN1cOmxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyAzXQoE;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CD606A31B;
	Tue,  3 Nov 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyAzXQoE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793739651;
	b=17SeHNT7+EG8bbFzM8r35XCY62Xw2NeQd2KkLIvAZOm1QPFfSXSIgw+ZPlqFAiLHW60w
	 31pwWsijGvU4JZU4VWYfWpnhyEQbsoEyjilQGXcphtX8KfROgCsPXf5A6mg8wcbNFvDZV
	 gVGv7TSy0SqB/Y+hn10/PtkVlTTyMN5wgAomgf18uUE2fMAMc4tcrgMyoAwiLfcybHK3b
	 IfzaIuI2KGsxjFZ0EjSi4d+889GReC5AVyEJRb/Z6yOEgeVPaihTKcQ31YFH2WcI/AdZk
	 ciIEyOWABLrLqUfR4o34YxEtY8n8c1vA6Zi0AjkU6xPD+zHt6ICHfSZbtBLrIXs1AyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739651;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SAHyYVdxgXEikOMk1urxi7cb5S18I8Y179gtTzRwTU0=;
	b=vpc+b7F+MeoTj1DgX1FCgUD2etFnxmtfH71rp8u4wqW1s1ApOfOFhLvMbIH34EUMRxX5
	 IXXYWqIY7uKzRhFtqk+o5Uecr2iBgMp00F+0ISLBmHgqhcYNr+AOr1GbJjY7+AInmSxna
	 kG+cG0WxiZlTCfqrU4SsJmM8rus+5R3Y8ektNpr0/pPTt48K6MTmpr6Dx76VyH2Dix8Ah
	 +Y0tswVZdON+xKmF7p/x2eX6orkpp3siDXH1wOefrYi0kQGm28BtQyryx9npcqTUMITLf
	 9zJqZ4r8TEhFfCjhoNtoXLJQfCcKrL9yxieEUjeeTbnwqxJsKOxtcLCx2f6AtIOBsUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EEF281F00A02;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739651;
	bh=SAHyYVdxgXEikOMk1urxi7cb5S18I8Y179gtTzRwTU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JyAzXQoELmfNVCI57CaFpnoNbuBgYwXPfuYbj9BZtpNuVo+eYLNs8EMpFEgsnN9QQ
	 Rs79vNp6s7y6LYcjwDfX4Zgm3FQhXGZHH7YBg0/hWVPgHeo/AdJHMWcMBwsdslsKQG
	 zBX+s/F7wGjfHPmIYK86Cett46ABNKdftmuU6bjJ+1CMeTt7EKvgXfZSUM6Drhe98c
	 aB0qvTtT9eYnPnPJszQe7SG8qkGA8KYqn/Fs1IfZ1LqPx7y2D9ILELxSDidXSjE3CS
	 MdM1V/m+cnQrR7b3shrmUG0aj2TKYF7LZb1pVlBHOByDhRsVTg/xZOpmVOBZjRivy1
	 x/KxNdMet+ZrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6826146B21;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 16:00:50 -0500
Subject: [PATCH v2 2/2] mm/hugetlb: clear the hugetlb flag before leaking a
 hwpoisoned folio
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-hugetlb-hwpoison-leak-v2-2-98085750c145@columbia.edu>
References: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
In-Reply-To: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, 
 Zi Yan <ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, 
 Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793739649; l=3741;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=p3cGeIhEss5lhmQM33p4Lp9XHqkwwMIQoTW5yzc7mbM=;
 b=PGA1VtdllP0dw4XcQ0InOdQX6BI+3QMcqOt1iWyGu2HdO7JdQSgJa7wvu5TUQOhX7H0SM+agA
 32NCczq4qtNBwO7Lc2Rr5EVpRvJxUGwC1a8+OzEyFhLN8OhDW/zKXeg
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

If hugetlb_update_hwpoison() fails to allocate a raw_hwp_page, the folio
is marked raw_hwp_unreliable and __update_and_free_hugetlb_folio() leaks
it intentionally.  With hugetlb_free_vmemmap=on, it's leaked before the
hugetlb flag is cleared, since commit 32c877191e02 ("hugetlb: do not
clear hugetlb dtor until allocating vmemmap") doesn't remove the flag
until the vmemmap is restored.  The leaked folio is then a hugetlb folio
with refcount 0 and on no list (the same state as a hugetlb folio that
is being freed), but nothing is freeing it, and
dissolve_free_hugetlb_folio() keeps retrying on it.  Offlining its
memory block then never completes, even on SIGKILL, and other tasks
block on the memory hotplug lock:

  [    3.271255] Memory failure: 0x20007: recovery action for free huge page: Failed
  [   41.729695] INFO: task hugeoffline:77 blocked for more than 20 seconds.
  ...
  [   41.733014]  get_online_mems+0xc1/0xd0
  [   41.733026]  soft_offline_page+0xfd/0x9b0

alloc_and_dissolve_hugetlb_folio() loops on it the same way.  The
refcount is 0 since commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race
with speculative PFN walkers").  Before that these paths failed with
-EBUSY.

Check raw_hwp_unreliable after the hugetlb flag is cleared so that the
folio is leaked as a non-hugetlb folio, as without vmemmap
optimization.  unpoison_memory() keeps refusing to unpoison it.  With
the fix, offlining retries as it does for any page it can't isolate,
and stops on a signal.

Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
This relies on Kaitao's "mm/hugetlb: preserve persistent flags when
returning folios to the pool" [1] (673b553e2bba in mm-new).  The check
now comes after hugetlb_vmemmap_restore_folio(), so on a restore failure
add_hugetlb_folio() must keep raw_hwp_unreliable.  It would be good to
take [1] to stable along with this one.

This changes the same lines as patch 07/15 of Matthew's "Use
generic_file_read_iter() in hugetlbfs" series [2].  On top of that
series, the check goes right after the folio_clear_hugetlb() call.

[1] https://lore.kernel.org/all/20261102024910.31486-3-kaitao.cheng@linux.dev/
[2] https://lore.kernel.org/all/20260805210557.1118966-8-willy@infradead.org/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/hugeoffline.c
---
 mm/hugetlb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 779b1de33c78..cdeb8923083f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1480,13 +1480,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
-	/*
-	 * If we don't know which subpages are hwpoisoned, we can't free
-	 * the hugepage, so it's leaked intentionally.
-	 */
-	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return;
-
 	/*
 	 * If folio is not vmemmap optimized (!clear_flag), then the folio
 	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore_folio
@@ -1514,6 +1507,14 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * If we don't know which subpages are hwpoisoned, we can't free
+	 * the hugepage, so it's leaked intentionally, but only once it is
+	 * no longer a hugetlb folio.
+	 */
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+		return;
+
 	/*
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.

-- 
2.53.0


