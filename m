Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D237754D;
	Wed, 24 Jun 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323174; cv=none; b=CrP+qv2KC2n0XThCHS7hYsjEJY1dHaXj/pvcy5k9s0pTTHtJXRulSzGOEiAxJIhrFbgfEyQo6LIp4wLMfgcMZe8ZEEYCwqvtVW5BEnI4SRs/Z8Zeho41gv8GYiD9/onQZG5AS8HgtAwaMlLbSe5xy00J8yRxcNlSTbU4k09TCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323174; c=relaxed/simple;
	bh=ek7of7SQjem5cMKKZF+sVTxo/ly3jE4WY7lkXW18b80=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=n77jdSPX8esOKzlBxy7qJNekjBleNT+BwIJtwebB/1mpzuIr8RY8hjTfhFddTZJfwbfBzYF0WxnMFwAd2CDD5xKpqLQwLKjAJbrGu6O35DX9O8Vc2cFgP+9iJkfbcd+9CpOtdb9V90JXXPC6EYrNCyevORn28LJENRFu13LbYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YK+fmlkx; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="YK+fmlkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782323172;
	bh=c00+0nK5vMbExFKRuy9+Yjtee5J5k7Q2Yj2gd1s+mO8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YK+fmlkx08peqVre3hV18ZN/FO7pa1Oo9lrTGDKgNbFs/Y5wEUdbfigg1mP2NlIv/
	 jWwf2bclVjAPoTOOVT3Cri14Cd4dNWkrUs4kwGWv8PfEw0bmkpITw5rN7Pl/ZG37PX
	 6GzDctpnS7k5Iz3pIGB3em1hEzURKyN4I2eZLi1M=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glq9c0hFnz10sp;
	Wed, 24 Jun 2026 17:46:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glq9b3p7pz10sm;
	Wed, 24 Jun 2026 17:46:11 +0000 (UTC)
Date: Wed, 24 Jun 2026 18:46:10 +0100
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
In-Reply-To: <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net>
References: <20260624160028.15591-1-include@grrlz.net> <20260624160028.15591-4-include@grrlz.net> <9FCEC7E9-DE50-443F-8E82-9FA22CA15ED6@grrlz.net>
Message-ID: <6FBA06E8-B0C4-444C-B226-0B756C0172A7@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 24, 2026 6:39:16 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>On June 24, 2026 5:00:28 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
>wrote:
>>Dirty logging forces new stage 2 mappings down to page size, but
>>it does not always remove an existing block mapping before the next
>>fault. Eager splitting is best effort and is disabled by default.
>>
>>A permission fault on such a block can still need a page table page
>>to install the smaller mapping. Top up the memcache for any permission
>>fault while dirty logging is active, not only for write faults.
>>
>>The issue was discovered [1] by Sashiko.
>>
>>Link:
>https://lore.kernel.org/all/59984F6D-06F2-4302-BDD7-92DF334E8FA0@grrlz.net/T/#t
>[1]
>>
>>Fixes: 6f745f1bb5bf ("KVM: arm64: Convert user_mem_abort() to generic
>page-table API")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Bradley Morgan <include@grrlz.net>
>>---
>> arch/arm64/kvm/mmu.c | 9 ++++-----
>> 1 file changed, 4 insertions(+), 5 deletions(-)
>>
>>diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>index 3f57f6825a33..8911e319e6fa 100644
>>--- a/arch/arm64/kvm/mmu.c
>>+++ b/arch/arm64/kvm/mmu.c
>>@@ -2122,13 +2122,12 @@ static int user_mem_abort(const struct
>kvm_s2_fault_desc *s2fd)
>> 	 * Permission faults just need to update the existing leaf entry,
>> 	 * and so normally don't require allocations from the memcache. The
>> 	 * only exception to this is when dirty logging is enabled at runtime
>>-	 * and a write fault needs to collapse a block entry into a table. With
>>-	 * pKVM, they may still need a fresh mapping object if the fault turns
>>-	 * page entries into a block entry.
>>+	 * and a fault needs to collapse a block entry into a table. With pKVM,
>>+	 * they may still need a fresh mapping object if the fault turns page
>>+	 * entries into a block entry.
>> 	 */
>> 	memcache = get_mmu_memcache(s2fd->vcpu);
>>-	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
>>-			    kvm_is_write_fault(s2fd->vcpu))) {
>>+	if (!perm_fault || memslot_is_logging(s2fd->memslot)) {
>> 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
>> 		if (ret)
>> 			return ret;
>>
>
>Note: Patch 3 seems to conflict because of patch 2 (the comments)
>
>
>Oops! :(
>
>V4 (after people have their review go), will contain one commit (patch
>3) with the updated comments.
>
>Patch 1 and 2 applies as usual.
>
>Apologies for my messup. 
>
>Thanks!


Actually. Hmm.

I'll just drop patches 2 and 3, I'll do them at a later date, please
disregard patches 2 and 3, patch 1 doesn't rely on 2 and 3..

If you guys wanna have a look feel free! :)

Thanks!
