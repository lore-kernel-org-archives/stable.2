Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510B385D7F;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337380; cv=none; b=k1SglyMiANrZCmXpa3RKb+Glkg425NtoryGMv0oz7NkmquLB4BG7RacNFruHVXmofJs/uOE0obbMxkNdXx7dDpqD08glTsXcW2KnI6vC5q+r2q5cQINncElHQGf1Sn5PaHN3CQVHv6cpceGHSrtzFPBCRwkmUlX98FxAO8cjjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337380; c=relaxed/simple;
	bh=+5j0hNzbRt7EoX7vcWXrnLmcUDM4afqudgCGYcyrSqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mndWhGkXA4vBWcvnEvlhzDjPHPcZkulbVIjS0M/XdwoHvh3Eh8wuKgellkPw3KLmsF4H6xN3KErski/cOxLzNLZ2e53E9nRDTP26+lHru/f9W9frftgkALgyAtm9fF3vgwzt6nT9bppR5ivmUiKZXv+xdHOPZYtHVLBLiRto2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzsI+juK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzsI+juK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 661A5C2BCFA;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788337380;
	bh=+5j0hNzbRt7EoX7vcWXrnLmcUDM4afqudgCGYcyrSqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WzsI+juK01svCEGlyGV1qbLaFotopPEguiB6aYIoA+luLq0V5Ey2VI/RcvLk0Pm2Y
	 cxrYQnq1xBiqMWnLEmDlWrH/Xc5NmKRBUkoSGf7q2aLI5I16pUxu6eUKt98AS7DAor
	 S+yzMmX7g9Y/0jXDNdUAKg62MILM8v+tHMrN6KCfRuDgGe+zwoZ//HCaN6HrmeYmXF
	 Lxt5LeO7K3x9k/fvbxVFbYKIEiE0YVdPhNwNC0YYYOZxsXb6RcCAWuPkFnVmoeyG3q
	 SHgmY0xXxveUwxI6TcLtC2NwN6b+7kP+eJ4rt17FLb+S4u7/PXFu+wuahVB+WK+ZyI
	 B/FB0dtIoommw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592CC61DFD;
	Wed,  2 Sep 2026 08:23:00 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 02 Sep 2026 01:22:56 -0700
Subject: [PATCH 1/2] mm: hugetlb: Return -ENOSPC on memcg charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-1-e3e8942c141b@google.com>
References: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-0-e3e8942c141b@google.com>
In-Reply-To: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-0-e3e8942c141b@google.com>
To: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Hongxiang Lou <louhongxiang@huawei.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Peter Xu <peterx@redhat.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, jthoughton@google.com, 
 fvdl@google.com, rientjes@google.com, vannapurve@google.com, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788337379; l=2356;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/vykoq6S6jD//j5trcHGMPdPAWTe6fd8Rz8OBB/ktN8=;
 b=wfhCNMZJJPNgBW2NCuyx+S9kXKexZ/7agd6XgUhL9IqhUo4tUieNAIWP9hMWipNtrK3C44qW0
 13Wicfdb6QrCDmoerV5o/WOzDWglesoWpZgvyIRqJUraxYeITnwVTp2
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
currently propagates this error. This results in the page fault handler
returning VM_FAULT_OOM.

Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
they bypass the OOM killer. Returning VM_FAULT_OOM to the #PF handler
without triggering the OOM killer (or having it make progress) leads to
an infinite loop of retrying the fault.

Avoid this loop by returning -ENOSPC when charging fails, which maps to
VM_FAULT_SIGBUS, terminating the process cleanly.

Make mem_cgroup_charge_hugetlb() fault handling use a common error handling
path, the same handling used for hugetlb_cgroup_uncharge_cgroup{,_rsvd}(),
which also don't trigger the OOM killer and hence opt to terminate the
process with a SIGBUS.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7857728457952..01b57f6d3b804 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2823,7 +2823,6 @@ void wait_for_freed_hugetlb_folios(void)
  *
  * Return: A pointer to the allocated folio, or an ERR_PTR on failure.
  *         -ENOSPC if cgroup charging fails or no folio is available.
- *         -ENOMEM if mem cgroup charging fails.
  */
 struct folio *hugetlb_alloc_folio(struct hstate *h,
 		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
@@ -2896,7 +2895,18 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 		 * were committed to the folio and freeing the folio
 		 * would have cleared those up.
 		 */
-		return ERR_PTR(ret);
+		/*
+		 * Return -ENOSPC when this function fails to allocate
+		 * or charge a huge page. If a standard (PAGE_SIZE)
+		 * page allocation fails, the OOM killer is given a
+		 * chance to run, which may resolve the failure on
+		 * retry. However, for HugeTLB allocations, the OOM
+		 * killer is not triggered.  Returning -ENOMEM (or
+		 * anything resulting in VM_FAULT_OOM) would leak to
+		 * the #PF handler, causing it to loop indefinitely
+		 * retrying the fault.
+		 */
+		return ERR_PTR(-ENOSPC);
 	}
 
 	return folio;

-- 
2.55.0.970.g62bdec98f9-goog


