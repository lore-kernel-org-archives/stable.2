Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175D35C6AD;
	Wed,  9 Sep 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973869; cv=none; b=gMcBCPHgiA+QIy//rFvQhzDiH0hY2em3QOVt9i2sry4rAf3l08eg2dMBr49F0GpLYLEtocfnAtVo9sokf+4shqFqkp9ogcpqwNF2W3pZqcvqk6xparfY0pnE6TdlP/Cp2JOx/rkxK2O5Xdu9Uzgnbuszbba5yuzVMJWH9cShFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973869; c=relaxed/simple;
	bh=BHXEO/5ApGc8onZolC3w/bocqaSCrODRqIh7iaYmj5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkjn/JD6KPsdVi89FO7vBYYoGNOMm2VgACPwXdF1g/8yHuk+jSsy2Abtk9RgpJNRV4I/PM+Ndsk7iYVZFkcelB0VFj0+AR+BMoFO5XOO29QAO7F5hgjt15qcPJCZLI9UhUVZRLr1PseHjMLj2ajyRYMAlXVdw9bl0MOoP9Mb+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKGrHxS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKGrHxS1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02402C2BCB9;
	Wed,  9 Sep 2026 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788973869;
	bh=BHXEO/5ApGc8onZolC3w/bocqaSCrODRqIh7iaYmj5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NKGrHxS1UroPb5TIhDI3V+HA2cKcmATt/ptd/6h0S05YwRQeG6yCVM7ZgxEp2aPQW
	 rMldgq7YcPws1UsQ0pYMiLf73YoGVHt/R7yjrsCcXfyy96gDI7B9HGyk4xOr6EOqMg
	 d14kGmVVkCfLgMliF9JSFjcafMStrQqbqJWxSy4ffquEzlUZhotTK+IfDmsV5ToJ03
	 43lIbWygXQbdXy3rZaWptnNKd/wqYrZUYEXiFJK6g25BfBp1Hwbe2FVsFjkjy+JA4m
	 ti3alMa16YLFwrya6ccZyMaN0agsrHavAmrbj4cpUpudi6G1RK167m7JP41PSdPno8
	 rhkfZpXVGJ3sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D077CC79FBD;
	Wed,  9 Sep 2026 17:11:08 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 09 Sep 2026 10:11:00 -0700
Subject: [PATCH v2 1/2] mm: hugetlb: Return -ENOSPC on memcg charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-1-4b4a8a19a7f7@google.com>
References: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-0-4b4a8a19a7f7@google.com>
In-Reply-To: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-0-4b4a8a19a7f7@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788973868; l=2084;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wQGY2NqfleEKP3GcsIVv3hSYGK81wAt8iMtpppoPYIU=;
 b=ow2acPS/0lBc9uXTMEil/vfmmYchZdQPHwRPGUjyngNjaKdtya97UdQiXuHsJi/izJCrBL90Q
 x1jKApeeIl+A9bXU7EeN28MfQNXGvQh+Hma84jQ/IKEgnDjk7aUriCZ
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
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f6f58bf3db6c..522487d341841 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2825,7 +2825,6 @@ void wait_for_freed_hugetlb_folios(void)
  *
  * Return: A pointer to the allocated folio, or an ERR_PTR on failure.
  *         -ENOSPC if cgroup charging fails or no folio is available.
- *         -ENOMEM if mem cgroup charging fails.
  */
 struct folio *hugetlb_alloc_folio(struct hstate *h,
 		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
@@ -2898,7 +2897,11 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 		 * were committed to the folio and freeing the folio
 		 * would have cleared those up.
 		 */
-		return ERR_PTR(ret);
+		/*
+		 * Return -ENOSPC, since retrying the fault is futile:
+		 * the OOM killer is not triggered for HugeTLB.
+		 */
+		return ERR_PTR(-ENOSPC);
 	}
 
 	return folio;

-- 
2.55.0.1007.g17ff1f9808-goog


