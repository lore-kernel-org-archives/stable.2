Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917731;
	b=vNAc8Qf2uzvOWY1dA2ikryxR7LyY+fxwr5ZVmFKyCKj1QkgLOzdzOFOVNClNphNJWiKc
	 hqFOYegGjg5xseYv7OlijyJ6X5kQlWmLbTHBOtWWyt4DSzqPC4z37LjOaTdjSskNVEMHZ
	 XvDVnHj4YdvsfW+6iwUTPcJ9D87qdWtpBb5VmnIWoCIwOmADVbzIYUMP0tMfbb9IpjUv+
	 h8ApLoj5U9sE2ioUUgXIkFEstq1FequbLoiyzMbWI+/hVoj/+v7N+3xRXf7gCQmlOnP6o
	 crb8O4dyHmXbPRIlt4ZwJDH8u5x47W/K3tfnkXBirK/JM3ihA20F9NUvGKm0B/cDeqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917731;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XHsHQOEJb3CJGb0dyhyAhjJ4f3CKAMOllBH9b+JYEWs=;
	b=J9lnB0skoG+G5P+wMdr/b/W5sS+KWIGkdgPq/QxwSbUW8Kl9oITPh7s8jCqHUnh0U/Ja
	 s50d83UYykVK5dqiphSs4OuiHIH1fvmW9oLDUNl7gmDzRVaaQN9tmTMm0T2ofpYQc/0IL
	 bON0C/yVJdzvGbuHx8opXiu50x0abe/DnlVmqQCq4+kLwSYqRRtk65WUNKpqwO/oYs0Da
	 xyZqEAMUydQmWeGjXJhfb2pbwOujGPE4EuWPlzs+ZgVc6n0osteALjrzzb0RmzYkLr9W+
	 O8fyB6GWkHgFRwevSnuk7CWfIWpkSBe8JJFEmFA1KdotVqu/OzCk/ePEQR/a48GovWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjKWZGml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B9606A31B;
	Thu,  5 Nov 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjKWZGml
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793917731;
	b=pB3M06+QiiBeEGiyeR5Jn33gSExURVpZBeX7HOXNqKyOVe7fdo1/swx+8EvtXzYU0fMZ
	 RPs7o1kStKXrBYbCoxqHibOhmMMVHrvgn+xXZ9C1pKA/M4iQfvFrdQ1zzgDGcCyKFt/gj
	 eFzo6xYZxlSjismiFgnJ0kOSjvax9OJUEoNA6zb1Fuoq6/260JAoHkcIS1hOsnJjqcffQ
	 IGFjle8jxD7hZhAr2dJ9siCMjMDox499S7S6x0oMHVuyW3r7i0T9VdCq56BZU11TyiyXl
	 VZnl1Fh9tGvRvhBAGJ4bf99px3gIXMhib+IZuNNw3mffbavHi0mQgi1PRCyGFGWbMFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793917731;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XHsHQOEJb3CJGb0dyhyAhjJ4f3CKAMOllBH9b+JYEWs=;
	b=T2JUXqa6NSVrDCMs8GKL+vLJESHV3vJu6IAtEClspeJi8rLBPVUyBb/vgEm56iu/9Omo
	 YIishrvFslDoPSC1B4ZMyYaGuKPOjvaPLqIiLrfN68svbiNXsIGaDap1BO60Lqochv4f9
	 GWgaVPU4wjf6OmC3hUYx0s/+jYE8kQxe3lj1f2c6wdCcprzdOcCCA5pXspjulvVkc6OWz
	 ZEupO2TZIQEHmo/Jw1S7zWOg5bLSsqj9F8UrhBJPrub1rci8YJIhP7kdYW7xLz/nsmVqk
	 aamcXS22gCqQ8Ja3JyyY2Fb6/106ll/8HcBMczPQNsszBiQt1W3sSXyOp+G7YWJEtpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7165A1F008A1;
	Thu,  5 Nov 2026 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917731;
	bh=XHsHQOEJb3CJGb0dyhyAhjJ4f3CKAMOllBH9b+JYEWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RjKWZGmlKrkzq450SX3vBuNoStwEzyEJa7btx9vhw5GoVr7ZW6sArUgonrgnplzNR
	 Mz3xQvRaDZOum07DuyAyBLk9sgR0lTdU7JhP5yeUlCvq34d+rUh1M4yU91kJnvhkyI
	 8HOWyX4ueCELFX1/kr7bgsVvgESFbFS4lX7ogD56RSHoPRn/Pm512k6Wtk5+l+ClNq
	 d8MMXWq9M+BYS0RtqPidvJReV13wkxwlBSjEU56o9cH0/Trxm1CFDUGd/dCUnjZGTL
	 AxzGkZrtuXuUxMk4qxXrcDlY9SI4aLhKtgxpfzNb0XCP2cl2E66KENBj1/gQa6sDIJ
	 cYUQyxedsWM2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EA29841E10;
	Thu,  5 Nov 2026 22:28:49 +0000 (UTC)
From: Xuheng Li via B4 Relay <devnull+xuheng.cs.columbia.edu@kernel.org>
Date: Thu, 05 Nov 2026 22:28:50 +0000
Subject: [PATCH 1/3] KVM: arm64: Compute the hyp pool size in 64 bits
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
Message-Id: <20261105-hyp-pool-and-map-v1-1-756bb5d8e067@cs.columbia.edu>
References: <20261105-hyp-pool-and-map-v1-0-756bb5d8e067@cs.columbia.edu>
In-Reply-To: <20261105-hyp-pool-and-map-v1-0-756bb5d8e067@cs.columbia.edu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xuheng Li <xuheng@cs.columbia.edu>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793917729; l=2873;
 i=xuheng@cs.columbia.edu; s=20261028; h=from:subject:message-id;
 bh=UxuVgBjPBETyOHIqHbEHAWaoxXnBBnvVmnBeY1ybafA=;
 b=j9yH+aaCv6O2qR5kWkR35pr2U+iHzJ4e49Ta/xuKRt8WMXlEXE3VrDsW3x/tw1Ag3OsxxiFMq
 s0jXWQBw68lBQs2POH+PpP/WYzowh9qbNa32gIpdjHLnA3+Krye1ZQ8
X-Developer-Key: i=xuheng@cs.columbia.edu; a=ed25519;
 pk=L1HVV+goqxYmEMO/OXakL6uf9isSpgk2QrLlFqyZ2Qs=
X-Endpoint-Received: by B4 Relay for xuheng@cs.columbia.edu/20261028 with
 auth_id=1349
X-Original-From: Xuheng Li <xuheng@cs.columbia.edu>
Reply-To: xuheng@cs.columbia.edu
Content-Transfer-Encoding: 7bit

From: Xuheng Li <xuheng@cs.columbia.edu>

hyp_pool_init() takes the pool size as an unsigned int number of pages
and computes the size in bytes as nr_pages << PAGE_SHIFT, in 32 bits.
For a pool of 4 GiB or more (nr_pages >= 2^20 with 4 KiB pages) the
shift overflows, and both pool->range_end and pool->max_order are
derived from the truncated size.

The two large pools are sized from the amount of memory:
hyp_s1_pgtable_pages() for hpool and host_s2_pgtable_pages() for
host_s2_pool both provision page-granular tables for all of memory,
about one page per 2 MiB of RAM, so they reach 4 GiB on a machine with
about 2 TiB of RAM.  Arm systems of that size exist, for example AWS
Graviton4 x8g.metal-48xl instances (3 TiB) and Ampere Altra Max
servers (up to 4 TiB per socket).

With a truncated range_end, most of the pool lies outside
[range_start, range_end), so __hyp_attach_page() treats those pages as
external order-0 pages that never coalesce, and the pool cannot satisfy
multi-page allocations.  What that does depends on the host's IPA size,
since the only multi-page allocation from these pools is the host
stage-2 PGD in host_s2_zalloc_pages_exact():

 - With a 44- or 48-bit PARange the PGD is a single page.  pKVM boots,
   but both pools run with a wrong range and maximum order, and any
   later multi-page allocation from them would fail.

 - With a 42-bit PARange the PGD is eight concatenated level-1 tables.
   Its allocation fails, and host_s2_zalloc_pages_exact() calls
   hyp_split_page() on the result before checking it for NULL, so pKVM
   initialisation operates on a bogus struct hyp_page instead of failing
   with -ENOMEM.

Compute the size in 64 bits.

Fixes: 8e17c66249e9 ("KVM: arm64: Introduce a Hyp buddy page allocator")
Cc: stable@vger.kernel.org
Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
---
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 57f86aa0f..e7c10d2f7 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -233,16 +233,16 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 		  unsigned int reserved_pages)
 {
 	phys_addr_t phys = hyp_pfn_to_phys(pfn);
+	u64 size = (u64)nr_pages << PAGE_SHIFT;
 	struct hyp_page *p;
 	int i;
 
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order = min(MAX_PAGE_ORDER,
-			      get_order(nr_pages << PAGE_SHIFT));
+	pool->max_order = min(MAX_PAGE_ORDER, get_order(size));
 	for (i = 0; i <= pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start = phys;
-	pool->range_end = phys + (nr_pages << PAGE_SHIFT);
+	pool->range_end = phys + size;
 
 	/* Init the vmemmap portion */
 	p = hyp_phys_to_page(phys);

-- 
2.53.0


