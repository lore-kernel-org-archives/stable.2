Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A744683F;
	Tue, 14 Jul 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031841; cv=none; b=ScQYlQptVeLQ8by0iw+nlAqj0rkWSL4xa8jh7eMVn/9IsbtjjBjLxWjz0MdOdhxJr6VlKIZJZDUrmX4uibaN4ymI11GBqDGnD4DUE8NM9lshZcRwbbJWUeg7wD2juwx3LCDmM5ctj9gsTBBZw4p6HO0DmPYG21abD3kwLZKPDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031841; c=relaxed/simple;
	bh=JAXHDQ65haSpPHSaLQiKhpO66Y7VCX6bh7SRJntNok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D17JTVhnxCQZP1HFh7GXARG2Kbv/q1NEoo3q+uvV3oKIaiwOAsE0hdiXO9JmBmfZwEjLcAaq6bRJayx2LQcM5btVAS2+OyBRPMdwpfGZ+2bLKS17FIN84FV53Z/qFmfRlLtKOCxcHMLHXiykNOVs8mtbD4lZs+K2EtU30uMt/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HfeikRSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fREjrIAb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HfeikRSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fREjrIAb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 374987A00CF;
	Tue, 14 Jul 2026 08:23:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 08:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784031831; x=
	1784118231; bh=0g5oskdRgsUXvKNkDRa5faJ7aqOeb+0ELgNs1jz8A+Y=; b=H
	feikRSq/NAyfMt025iRCTPpadEaUfC2Icr1aPhqdRQ7KTT8SeDEptHSw1oAfQFVn
	KfffwSoGjaHKQFJG1SPNYfr8osmRwmuYtjtEuAj75ffoXnixJZm9Y7jnyah2LA25
	0kh+DNPjtS5SgbNNMUHpSERBZmu9GIzS6wG3OL0RO54EGk9BgNbCskvBuNcvvkZE
	QkxCWbY4MoVtbHUA6dAnOTnr+kL8zJPX9/eKQApEH9K8yikF5bQZQIKFLcamHXO0
	s9kzHbI46Qle2Bi/iPhtyIr5/WtAJU2imS0yT64M6beuwvYyroFDlomGh5yMFCWl
	tP9vR/qG27PWmf7Xv5CEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784031831; x=1784118231; bh=0
	g5oskdRgsUXvKNkDRa5faJ7aqOeb+0ELgNs1jz8A+Y=; b=fREjrIAbdI17ntVKn
	MB8by3SxPUcW3qO+KdLZmEPeeGg/KmqRBtZY2cGUwwodsgX01r2DBhm3Vggp8Xp4
	Nx/TuVnCQ3caFCL3j/F6RJHYYtFxL7gNELaTuw2lrIgxkyOycoI8y3aAqua9BMcV
	5In2SikhPIDHqwBClDyojalCuSbrlTXSvRF/cQOJVZ+34LZZflIShhgrgIRZWN40
	uV/R78R6/2BAjtvJozMVj81zg3PF0uvG2/qLmbzsnufNejX5UiHYYw9nuv0Zc2G0
	mnQmTP1NC6roq364QNHm6zVcAPm1lOiryt2rN3IiJqtgBRakt6qj912NEVZqNP2r
	+nFBQ==
X-ME-Sender: <xms:VipWan-T4oIkmEE6r-RYnazwK1uosYc4Fu7pVMMok0k7wdanYCJJ5w>
    <xme:VipWaom-4uKH2gmRoBmAjhG7P5Bp4JOu4JmbwGCEjP77oKlqz-YNZ6YJcSVM8mwsN
    7Av-nMQLiNDi5DSB4ZlSJO_54wbujBcSjxF_jTzk-N6zgHUaHY8KQ>
X-ME-Received: <xmr:VipWatl-UvnLzBaKQMjcjXNEEI4g2vnjNayF_EaNh47KKQCMy9VjbulQXvL-MA>
X-ME-Proxy-Cause: dmFkZTFBvxovr0fjL2SDlhw64F6oFGvIraiDu6TVCnqgYaAZRHolensvaRSdeNznP8dyQu
    Coman3QLm+Yiv7vIU4gCaDoV3zjPLAT5xMyob2T/RAiyCRcX5nino2GdJfXAIhMAG9Vfbt
    8DmmQq188Z2uGp2nkuYEczpQaZcUln/b+ViESl/1sRXWiXixSkmKZ86RELzVQX1c5DoIyj
    VYLQxCZGhSirPmfYkfg5Z9MFDCczGvA5NVGnQNjEY+/Dc2Z4MeErYRkfr5HJBXVY0/+gwS
    wMHbPHqeV/WaAxudjO5n+4mCCjxtqKMzuTd7bYDWa5SZhntkJG3EmwdwQQDclBgW6W8CDd
    Myk1BCEsjZDtocKPq6SFh76ysa5Z+9HMjeF/GuQroKl+BKIQFyK58Hi1iBuv4PrSsdBoed
    qUKBlvXQLkXzvgPziLsgfGTHmGmaAYjCQitkrzLMJEtaJKPypXwEldF3t7zIQu4Y1iJZYP
    8JdHx+ZsougTMMNwOza4whUv7GUcGNzNVeniMjQ2nZ9bV7QR6oLgFbrAdUOB3q2DJGK6ko
    zjyFXvlBDUY3Dzjs61NkrSzXWUrHB86X9Z7AAS4GNjT7SNVwPl59/T1j+4ANijkQkYvFDr
    dHPg2tBOQ5IC/khlzTXlr1HzV0jz38hy2O+EhVl5dFQ+G65hq3VRfujqMbdQ
X-ME-Proxy: <xmx:VipWaktHJkAeUtY-3ehPTHEiwmneLsjIQotS6AjWgmhehaovG-lL3g>
    <xmx:VipWavKjkYAgFgpOkSsTVPy1W9BeDBe7-Ya_Ni_bBcKY_s7fghEVJg>
    <xmx:VipWahgk2ekyQF3e_pOaqup5HSWggwV5e-FDz82enjE4dFc1_wJxFQ>
    <xmx:VipWajunbTktYq9IirahUkKY51FmLr8wyUmpYNbdz6VzleU4DCVw3A>
    <xmx:VypWaugA_oyUVVqDplVi0s1VjO-1ZohE-PREermaSY2lbZedakUOpWiU>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 08:23:50 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	Hao Zhang <hao_zhang_kdev@163.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the poisoned subpage, locked across split
Date: Tue, 14 Jul 2026 13:23:40 +0100
Message-ID: <20260714122344.351895-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714122344.351895-1-kirill@shutemov.name>
References: <20260714122344.351895-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

try_to_split_thp_page() locked the poisoned page and passed it to
split_huge_page_to_order(), which returns that very page locked to the
caller.  For a tail page that means __folio_split() runs with @lock_at
pointing into the middle of the folio.

__folio_split() dereferences the mapping after the split completes
(shmem_uncharge(), i_mmap_unlock_read()).  The only thing keeping the
inode alive across that is the locked @lock_at folio: while it stays in
the page cache, eviction cannot complete.

But a tail @lock_at can lie beyond EOF -- e.g. part of a shmem THP that
reaches past i_size while the file is being truncated.  The split then
drops it from the page cache yet still returns it locked, so the pin is
gone and a racing final iput() can evict and RCU-free the inode while
__folio_split() is still running:

  BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
   i_mmap_unlock_read include/linux/fs.h:537 [inline]
   __folio_split+0x732/0x1640 mm/huge_memory.c:4100
   try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
   memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470

  Freed by task 4601:
   shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
   evict+0x57f/0xac0 fs/inode.c:870

Split the folio as a folio, via split_folio_to_order(), so the head is
the anchor left locked.  The head is piece 0, which the beyond-EOF drop
loop never removes (it starts at folio_next(folio)), so the split always
leaves it in the page cache and the inode stays pinned for the whole of
__folio_split().  memory_failure() and soft offline re-lock the poisoned
subpage's folio themselves after the split, so they do not depend on it
being returned locked.

Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory-failure.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..68d42cbed458 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1657,11 +1657,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 static int try_to_split_thp_page(struct page *page, unsigned int new_order,
 		bool release)
 {
+	struct folio *folio = page_folio(page);
 	int ret;
 
-	lock_page(page);
-	ret = split_huge_page_to_order(page, new_order);
-	unlock_page(page);
+	/*
+	 * Lock and split at the head, not the poisoned subpage: __folio_split()
+	 * keeps the anchor folio locked and needs it to stay in the page cache
+	 * to pin the inode. A tail beyond EOF would be dropped yet returned
+	 * locked, losing that pin. The caller re-locks @page afterwards.
+	 */
+	folio_lock(folio);
+	ret = split_folio_to_order(folio, new_order);
+	folio_unlock(folio);
 
 	if (ret && release)
 		put_page(page);
-- 
2.54.0

