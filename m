Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739651;
	b=5Ir/6G+vGUq2LquEsLsNOpuCshUSqYPJDev4K/1q1+dtEjNDB8pmDMvjxRWEme6FzcWW
	 UEb/X6OmnOIcdGa9GdsnVivrNF5uCUStwVXuGOqh2E2VJF+l5wOoN1NY8vRKB4zehwjud
	 jwoCjZIbtWNgrczVSi7AFupnMLKD6m8I6cIouYns+K/V6Bj9qZP5VrnH16usZLRGQNGFr
	 iInsQ8XIamWQnapF3umJFvo75PoGvS780E19dB9vYpvImv/rN7hwPi95re530ELdyJg7F
	 Csspk4Swt/jGiiZ0RR8JEsI8Bo2w9YlGbB5C1Yr65G9rzfR8xWsxVUZ/c6bwt7SxXkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739651;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wHJUzXmrAF9C150R57fNbacGrKg8aH4pOauYcunkpBc=;
	b=dpSQaTK/LQUfilYUfu9agST97RiUWhroTl+9lLzzPMSEb+piSNxYl4tkOZGxLIDE9bSr
	 foUP/yv8KEYSLOVsLpHSXagEdo8ovXubM7iYQ+eHrD1LFX9Y9jSxsv+fTlwJ1NkWq06FY
	 WuGojT95/p/DJStIV8Ic52vfNk+mj3Ty4nNbMBW2Hj7ufQzD4ariY3fogWj9GlE7/2+Ni
	 iKsbs6n5jZSeGjMGhu/momVdsh3RqOtIBsogfatMms6Z/Ay1u+0GK/1Z1TZ3POyKgIvvU
	 KbThHxp8EGk1InEi3XubMAv6VctDL6838JMku0skM4z/c8DqRtZPh/FSvOCuuAKTeMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDmzrH7j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CB606A324;
	Tue,  3 Nov 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDmzrH7j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793739650;
	b=mYesL1myPZGvUVULRmgcNIrdN4oShjQDfGH8gAkoLB2UAL0SnS8QBqQA2l+lQ51c/CUx
	 eJm/aW3iQS/R3seGf153siMGdPzf1GKArLNAt61gcHY/Op1mExSZnCjYHoT7YfoYjhhqi
	 c0rUCjfBg3Lvq2RAIpF1HKhCJjGk+vfMeSaZCPoeUCFkHDXPgaRcdo27Vn9nzPtZwTzWZ
	 4v420gHEmFt5VRy5WuP/typ5TFAPXrBFUnqFgoqW7xMiaYQ1RMDsDUAjqrZxYC8hTPpaL
	 9pEl1vjLoYWsQv/ksPM5wmhF8Bxtg2sIJEukZsl/kJ3AVFLSrOPLrKlgBkHYeIcE9ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739650;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wHJUzXmrAF9C150R57fNbacGrKg8aH4pOauYcunkpBc=;
	b=Q5fR2i0knS07LPktU+AKdmzgfHZFR9H2e4kHycQG44tzzlChoUxCFEfc9JUApK4MuMpF
	 rilZKyK63OsE9sMhVeeXzeEC1EQBQFD9qKOvghVmfRfaFVXg1RDAx9v8aeUOjzAqx/eRF
	 sRcr1xh1sd+X6taJtFQ3fVuStZ6HiZMMcWnQf4ZxGabvc86/0GRKNriqByDpQ59HDw+b5
	 0E54jnJgQ92AwNoDKtIC8VyvDfgLK4qFQ3CmeHtibEcOTxNLB9LObGpUeYrGSOhNq9nhj
	 sv9LHhpPfL7V4d4x63foKGlL/uhA1AlM3UXCjwgbhC4k9Q4g+ejeJBfy9n7zUSYbcRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EEFBA1F00A20;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739650;
	bh=wHJUzXmrAF9C150R57fNbacGrKg8aH4pOauYcunkpBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SDmzrH7jCpkAPutlRcigOiRnlE0QoFf9Ww5DcM8AOIlsuwsQNig5d48FH8qXds9GU
	 pLxQWQagZ58xiHkvYuCOe1u1dxeV3BU/VAVtS65thyUFe5utqmNjUdZ2kmrSJfekdd
	 E9OR4KoSqZuuD5CovsyXzSWa2/Z/HWiP7hAdgE4GvJczYEtTH66alKOHidAlofre/U
	 GEdUO4Z0DGze8gKPTV7Zr7JBWprzc+pTHhffUFQm2HBy/AdVZgmA1tbH43J0OYMCq6
	 LnnVY/jwQNg/Ko4Tc1bOhgTF18yZPT0s59IviN5W01LeUk/xDFcUJrjsiJK9ZiYzrr
	 TlOHpB5lVDOfQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5AB1E46B12;
	Tue,  3 Nov 2026 21:00:49 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 16:00:49 -0500
Subject: [PATCH v2 1/2] mm/memory-failure: don't unpoison a leaked
 raw_hwp_unreliable folio
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
Message-Id: <20261103-hugetlb-hwpoison-leak-v2-1-98085750c145@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793739649; l=1959;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=QKydKJ4ULQzr2TWbUaUZ31FxafHdsfMjukKm4+Y/tFQ=;
 b=SJLl5itZOXZdXocudWDHOPpqGm7WPscqvj34RDOCSjv1/dQqDbfcDehqvMdV2OWf4dkqSsplW
 3LJLVsPFS7OBgAZhQlhMVCsD6I7lz3GBvWfObDnz22fxvnZpxoyC9Ux
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

If memory_failure() can't save the raw error page of a hugetlb folio,
it marks the folio raw_hwp_unreliable and unpoison_memory() refuses to
unpoison it, since we don't know which subpages are poisoned.  Once the
folio is freed, __update_and_free_hugetlb_folio() leaks it on purpose.
If its hugetlb flag is cleared by then, e.g., without vmemmap
optimization, unpoison_memory() doesn't see a hugetlb folio anymore.
It treats the leaked folio as a normal page and clears PG_hwpoison on
its head, while the poisoned subpages are still unknown.

The leaked folio is still a large folio and raw_hwp_unreliable stays set
in folio->private.  We now check it on any large folio before taking the
page, so unpoison_memory() refuses the folio whether it's still hugetlb
or not.  With the fix, it returns -EBUSY for the leaked folio as it did
before the folio was freed.

Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Closes: https://lore.kernel.org/all/ae6058ae-3703-a1d5-d82f-4102b46f227b@huawei.com/
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
 mm/memory-failure.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b215312f261b..496eacbefdf2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2809,6 +2809,15 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * A hugetlb folio without reliable raw error info is leaked once it
+	 * is freed, and its hugetlb flag may be cleared by then.  Check the
+	 * flag in folio->private, which stays set on the leaked folio.
+	 */
+	if (folio_test_large(folio) &&
+	    folio_test_hugetlb_raw_hwp_unreliable(folio))
+		goto unlock_mutex;
+
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
 		if (folio_test_hugetlb(folio)) {

-- 
2.53.0


