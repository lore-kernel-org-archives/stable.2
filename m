Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714117;
	b=wQtYSh/oHHN30znEIefHI3tYb1lcvGsGOtn4c4iMzmuoA+oLI/XhHzcnAB7tsRyH/Gkc
	 dFnOmzDIVsrQDviXkTMBZKVs7ul2KCXLFv9PKxZWbHNhkmRdrzjtI+SoJHG1Ds92liwSv
	 IvGbMPkg9oEcUQOauPq7Hq2LXpZrFCVikfz8gXvYSspXr3qVk4TK1/cdJnuQq2W8WujGS
	 M7h2bkRdFlXd9FDjCjlSkO3rniqM9smAEHATN1C//s2gi+1lxOKG8JMKLA9z6cLuhndr8
	 Lge9vzeccL6dSX7Hj8B4espPLMmADcTeagv2FWRGRT1PaU+vWih1SfzLNgpZ3G7lycQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714117;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Mo6mJy5Hh3bbllZKhy/yN/eCAsi9fRKSUsnKIZPM6Ao=;
	b=b9rdXv7ugDMu8IoRuDIRrLX7CuXqeYjt2heLx6oOPe1hd0fZZsbAyEoCS8uU+/FfbF1Z
	 Aj3RdFHIDTEtX1VIw9/3DH8Dp23Gagd5RVhMIP/kTHO/aGwP9VvJgl8zgG2+zTnaWPHbu
	 3BSblRrZFgSm6rg0kQrWarzRlOrduG5FhuYcwU2n1a7y+IohTpAi+Wqm0pAn5J1Kk0VEv
	 PvP5xGricqsqE2/CG8tT7bRFG0frn+QdH5hHJAnnClG2q65vkWiRzRzuAA4gwfvZsi/db
	 CoW1Nk04T4UvlA71zIZuDG5X7MpSeKPIzDlzgBDMmTUib/MPdMxFjMUy8492gRERFwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD31k10T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614A606A31C;
	Thu, 26 Nov 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD31k10T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DCB1F000C0;
	Thu, 26 Nov 2026 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714116;
	bh=Mo6mJy5Hh3bbllZKhy/yN/eCAsi9fRKSUsnKIZPM6Ao=;
	h=From:Date:Subject:To:Cc;
	b=bD31k10T/JAWg+cRqAY/9nim3nmVHpAQHaUnDXMd2cimwRhbRDLMHFYSaA/AxJKUg
	 nfRww66TUDMLHhZhOB50AQrtpcJ7ps3ldSb8K4XG9L/xfr1MA+R+3lCMCp/rjtfnuu
	 fu+lsiAXjkhrADSMJ2nX9HO9MO4XtGkoj3kJJmvBxsQMK9Co6DjPhhVJw1zbn1I8D5
	 eG+D4+HmbAi/5pI6DHZmc8EnuKFD224G55BIoZukAvVPPihuVKXDPDljUBHssBKCyM
	 gJZPku19GSC+ysSb2+OWDc9+OrnNb21XQKCN1TpULViPLpqGIfyhDAsnH5il2cckuF
	 5A4xk+NPVVYMA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 26 Nov 2026 17:28:29 +0000
Subject: [PATCH] KVM: arm64: Top up the mmu memcache on user fault for NV
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-fix-nv-cache-topup-v1-1-a22c936872fe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+2AE4rUXEVcpHFSZxNDoiKId
 y/0HeDdaFpNGzzdqHpasy3Dk3SEuIb8VbYFnuB6N4i4gZNdnE+OIa7K+1aOwmP4SFrebuzlhY5
 Qqia7/uk0P88PmEXUFGQAAAA=
X-Change-ID: 20261126-fix-nv-cache-topup-9ab1fd829014
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <christoffer.dall@linaro.org>, 
 Jintack Lim <jintack.lim@linaro.org>, Leonardo Bras <leo.bras@arm.com>, 
 Wei-Lin Chang <weilin.chang@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Usama Arif <usama.arif@linux.dev>, 
 ljs@kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=ljs@kernel.org;
 h=from:subject:message-id; bh=FvxCZDQw6W6TzJrba57LnkLP53Dmvj5bR2gjbKB4X0s=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5cuxNdi53XfS9YnWUQpXpUo63zQ4P1x27te7k8XNfz
 BQLfi1k7ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEni9mZJj2nGdBZgznvZu9
 E8NeK2Wd9zQK3evqYdGzpSTf1Ua8s5uR4cDP3wf+Lzgtz9S8fuKil1d9HsipaLiVH65ROFDesbL
 hPisA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The S2 user fault path tops up the MMU memcache (used for page table
pre-allocation as the point at which page tables are installed may not
allocate) except when:

* It's a permission fault AND
* dirty page logging is disabled AND
* pKVM is disabled

At which point it is assumed no page table will be allocated.

However nested virtualisation adds another edge case - the mapping size of
a shadow S2 is clamped to that of the guest's own S2. If the guest
hypervisor replaces a block mapping with a table, a permission fault on the
shadow block has to be mapped at PAGE_SIZE, which requires a page table to
collapse the block into.

With the memcache empty, kvm_mmu_memory_cache_alloc() hits its
guest-triggerable WARN_ON(!nobjs) and falls back to a GFP_ATOMIC allocation
under mmu_lock, with a BUG_ON() if that fails.

Therefore, also top up the memcache for permission faults taken on a
shadow S2.

Note that dirty logging had a similar issue, addressed in commit
56fd1fc526e6 ("KVM: arm64: Top up stage-2 memcache for dirty logging
faults").

Fixes: fd276e71d1e7 ("KVM: arm64: nv: Handle shadow stage 2 page faults")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a0d4981ebb99..e09a8f2c0482 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2256,16 +2256,18 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd,
 
 	/*
 	 * Permission faults just need to update the existing leaf entry,
-	 * and so normally don't require allocations from the memcache. The
-	 * only exception to this is when dirty logging is enabled at runtime
+	 * and so normally don't require allocations from the memcache. One
+	 * exception to this is when dirty logging is enabled at runtime
 	 * and a fault needs to collapse a block entry into a table.
 	 * Under pKVM a permission fault can also collapse pages into a block,
 	 * which needs a fresh mapping object, and the hypervisor requires the
 	 * min-pages memcache even when the install allocates nothing.
+	 * With nested, a shadow stage-2 block may also need to be collapsed
+	 * into a table if the guest's own stage-2 mapping has become smaller.
 	 */
 	memcache = get_mmu_memcache(s2fd->vcpu);
 	if (!perm_fault || memslot_is_logging(s2fd->memslot) ||
-	    is_protected_kvm_enabled()) {
+	    is_protected_kvm_enabled() || s2fd->nested) {
 		ret = topup_mmu_memcache(s2fd->mmu, memcache);
 		if (ret)
 			return ret;

---
base-commit: 012e4bc01e339a65dc7c59181b5efb33b171d12c
change-id: 20261126-fix-nv-cache-topup-9ab1fd829014

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

