Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821027;
	b=5F0Bw4Q2OjVHm1Kr9txXxTe/g8lLQhqCknpgoNFEIfH8QPrM5whdBiLa1Jlj/wgCUY20
	 QQKQYqGt6J9BnzzKPx3VfbVc3gE8JFamercL9dMkhS3xU8ECjCXnPmQpy8VbcE6UHFwlv
	 mxNXCyRm0dXDr1LYkjvSINw7yh0FZIX0oHLgPSIHirqLPPMEsey7myOXPd5eAtsztSR3j
	 rs7kTL4U7HDd3TrTlhS17iqpLYXZSqae5gGHxF8Z8cU5TZdyfl22wWFXd8IRUhgQ4+wx2
	 R0JeY402xkgpzz9ilhpnkO1cRYrk5mwu+0K4LlfKZWmMHblxRcjBrslGUkYthds8E6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hYCIJyyhNvNUexJjlwv2my3b5F/WENWDx79yHOyBGJU=;
	b=V1LpH+CgV5GRD1xmRZ41w/PvSqUEBTc5RHKRpNr2TMw0QZx+4Gi6YS0WjKlDxj10Qmi8
	 2SctHqeS02X94zi73Hgr2Ricmt2kIhQw7U4X6aPRhHHRS3+TPiyUizIukbD+Lz22nJVwE
	 KrvzNj+l6QnjETYqrheRYBV0IqtHHn4lk12nR5AQKuRlLm5m2gdHumhqwgG5x7NTjVavW
	 K4laOdZvwL37nJcwCWfcBM/36cRAwYIT/TEbaoA80Q4bqI78G2EbdjIjuot7PfVsLx1/9
	 ZlpkhQZxARoqkIWVu1jESZUiLT50efPUB7RaHUm78jKCt1gvs3SrlHUSoTxyTJBNQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sph9PBq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F486070E77
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sph9PBq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8223C1F0093A;
	Wed,  4 Nov 2026 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821026;
	bh=hYCIJyyhNvNUexJjlwv2my3b5F/WENWDx79yHOyBGJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sph9PBq/25VUtg4Mq7AftOaKIlI5fvKekGLhjzTu1aIemGuwUBCCukqLKp0zDCoWB
	 APLifqUDkZtWMH6/XFRNZkpu+lbLlJHaXY9RUCItKBmI9ePK0YTkc7Za0YyJtiOwIh
	 dV8DE4jmbHqhBApdGDQSuvJChVvcCQuHaVjEvFgPbAUGd5j8EjzJNwzMOTjoE+wPVr
	 Vgm3VPpPPxd3o9CgMFPCZgs+7mieevI267Fi0G8veIs6DWHwEjKlaZfTGzVl0i9lDZ
	 eBay41eNiy/0PgNxSq1EEiSYd3V84a+GUP+KuvfAUL9D177UhdZ/Z2ycJ8jjuC9frn
	 DE0IDWeJ/VwhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
Date: Wed,  4 Nov 2026 14:37:03 -0500
Message-ID: <20261104193642.3970538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110447-cucumber-tummy-2f42@gregkh>
References: <2026110447-cucumber-tummy-2f42@gregkh>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit d8a9cd7fd2fb01211430c933932da58839b8ca65 ]

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Link: https://lore.kernel.org/20261015-urgent_fixes-v1-3-42796911043b@kernel.org
Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted folio-based code and comments to page-based APIs in hugetlb_mcopy_atomic_pte() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 947610e37a33c..e8ee7ef7fe03b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5390,11 +5390,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	if (!is_continue)
 		SetHPageMigratable(page);
 	if (vm_shared || is_continue)
 		unlock_page(page);
+
+	/*
+	 * Hold the PTL until we're done with the page: the page table owns the
+	 * page reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;
-- 
2.53.0

