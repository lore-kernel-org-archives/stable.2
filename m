Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDA3DD52C;
	Wed, 24 Jun 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322762; cv=none; b=KubtuwOTPewEBWKnmIKgXVUlYFxfPTTj1cHfGWvg48Z1RiBTj6qNcsi4Y6ULvgqpBf9uoIvyPYVxIcM1c8pTLL/WP2qksZR+wBGRkczYQzUQnB1KJGZQ1qoT3bynvlSPmAdA5tdaVtWgpFOQTpi0r8FqqS2gT8gnxPr3sK43U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322762; c=relaxed/simple;
	bh=D8aUp4dSTtnGkUeXyqOTVQT5OY3uZCW5aN+rjBL9vQI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z8h2EQ+sLf47BJNVIWODUJxj5PMfBFKdiy/6t+wfYEbxsIsDIkrv2d4duiRPmGDV1Fhi2hR4oYZWlr4wKV2A5Q8jQ+E5AtLhFbrJnxwbSVIG9Y9tKHczq3VXjnEqwhskkS4ZpqGSs618y3zKdcICFyVXYLKidggAaTToWUOclpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ciwM3wOz; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="ciwM3wOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782322757;
	bh=TDjKCkoTg3i3GJZfWXyR5+GUBGu//vlWsGB4F0dmV4Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ciwM3wOzJiNUs9hD46zOJThBt7YPMtL/k/p9dVCqH1KYu7qZoemAdmdruaiiUvu48
	 9o7H9pb8nWu5/BilyRLbEobRRVaHbB+AuVdfAZp6+xmgHDqfqbqHKkHKlPV3Hc359s
	 ydlPyM9DdLtAqKgZhkjV9s/nyFKsqe1Ujx2sjnh0=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glq1d5z0sz10sb;
	Wed, 24 Jun 2026 17:39:17 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glq1d131zz10sH;
	Wed, 24 Jun 2026 17:39:17 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:39:16 +0100
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
CC: Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Steffen Eiden <seiden@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Vincent Donnefort <vdonnefort@google.com>, Gavin Shan <gshan@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/3=5D_KVM=3A_arm64=3A_top_up_s?=
 =?US-ASCII?Q?tage_2_memcache_for_dirty_logging_faults?=
In-Reply-To: <20260624160028.15591-4-include@grrlz.net>
References: <20260624160028.15591-1-include@grrlz.net> <20260624160028.15591-4-include@grrlz.net>
Message-ID: <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 24, 2026 5:00:28 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>Dirty logging forces new stage 2 mappings down to page size, but
>it does not always remove an existing block mapping before the next
>fault. Eager splitting is best effort and is disabled by default.
>
>A permission fault on such a block can still need a page table page
>to install the smaller mapping. Top up the memcache for any permission
>fault while dirty logging is active, not only for write faults.
>
>The issue was discovered [1] by Sashiko.
>
>Link: https://lore.kernel.org/all/59984F6D-06F2-4302-BDD7-92DF334E8FA0@grrlz.net/T/#t [1]
>
>Fixes: 6f745f1bb5bf ("KVM: arm64: Convert user_mem_abort() to generic page-table API")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bradley Morgan <include@grrlz.net>
>---
> arch/arm64/kvm/mmu.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>index 3f57f6825a33..8911e319e6fa 100644
>--- a/arch/arm64/kvm/mmu.c
>+++ b/arch/arm64/kvm/mmu.c
>@@ -2122,13 +2122,12 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
> 	 * Permission faults just need to update the existing leaf entry,
> 	 * and so normally don't require allocations from the memcache. The
> 	 * only exception to this is when dirty logging is enabled at runtime
>-	 * and a write fault needs to collapse a block entry into a table. With
>-	 * pKVM, they may still need a fresh mapping object if the fault turns
>-	 * page entries into a block entry.
>+	 * and a fault needs to collapse a block entry into a table. With pKVM,
>+	 * they may still need a fresh mapping object if the fault turns page
>+	 * entries into a block entry.
> 	 */
> 	memcache = get_mmu_memcache(s2fd->vcpu);
>-	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
>-			    kvm_is_write_fault(s2fd->vcpu))) {
>+	if (!perm_fault || memslot_is_logging(s2fd->memslot)) {
> 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
> 		if (ret)
> 			return ret;
>

Note: Patch 3 seems to conflict because of patch 2 (the comments)


Oops! :(

V4 (after people have their review go), will contain one commit (patch
3) with the updated comments.

Patch 1 and 2 applies as usual.

Apologies for my messup. 

Thanks!
