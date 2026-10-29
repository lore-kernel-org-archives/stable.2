Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296379;
	b=n6X0w85jVxWg3F6usn/UK+Kq+yutNvGT7AEXFix3atmMG9G/NzD8F5uFJyhXbAAXwLGY
	 Me55hdVn2L/H/+9fG8S+FeUjgQPb7TSxYRBYRVjYxyAwjc0TvKMhvMDDsuuXw+4zW8J5W
	 MelkL+8Rm6WxCPuCKCBtpgn6y5VadkyztryAZV0hxf1tgPk5LXrWEchnAtiCTK9iAgTNm
	 TI490lpD5OCZn+f77uglNdraKi7N7vH+SdwyyQ/lzIVVWmLvU+XbL1FtG8ECVusMfZi8+
	 vfnW/KprmER0J8l5zwbzLh3qYt7lW/FE5B3A85gmtBglt0kWC1GJ70GvzEKUdl9cZGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296379;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S5U2Nx4uu0l5UY+vpx3TvB7FV+qMp+ahvwvUvYtuJ00=;
	b=eiV70QpppVvWckMkaC/ehXfZhcjEI0LII5hrJ0alfeyPlkJr/NKo1rq+4r/bahTHNmgh
	 3cNbs2qmuE2pDhPx2eE+CZ76FAgbMHE2dOzlBwkx5fbPrk1wuytsc3gEsZ6HVAZQy4gjo
	 rjLB1+P/Sd80KQahcWod4VqJYq0B3FVMBTiNZDTqk93NfwAU5SJhyVsMmJsyo8kepFbqQ
	 7tkA8F8U4ElnHOcP1RFcobb/Pda/EK5jqkxS9yMyNXA8C0Vm1b7ELFA9z6m6ew0G6N5Hx
	 drXu47c1HcerRrMGdOx8rTDwYUHQq+0P68xxk87hgVtiuKDCrlkIy+rWMiR03KgmDmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NV2zPwOw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D6606A326;
	Thu, 29 Oct 2026 17:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 622D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NV2zPwOw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5B6D169E;
	Thu, 29 Oct 2026 10:52:54 -0700 (PDT)
Received: from workstation-e142269.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2693F59E;
	Thu, 29 Oct 2026 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793296377; bh=xrY9NPZLAByOeK2cryjztDk7I9iH/vElRi5/N8juw04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NV2zPwOwPWucx2y+IgN5JcV+z1JRay0Ov2VIsmtxTY03FiQHkZQqvAxIyIcL8iW6l
	 +RujiVAVn1IE7J1lE2FTIrozzsEEdzbVcPnQ3bcqiR1b9hiO6+Bo5XivlYaAJ9GqVN
	 8LiXkpR+86e+iXVe0B0BawRRkJlG1vBaLzR5psiI=
From: Wei-Lin Chang <weilin.chang@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: arm64: Fix dirty logging detection in ring-only mode
Date: Thu, 29 Oct 2026 17:52:37 +0000
Message-ID: <20261029175238.3214788-2-weilin.chang@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029175238.3214788-1-weilin.chang@arm.com>
References: <20261029175238.3214788-1-weilin.chang@arm.com>
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

When checking whether a memslot has dirty logging enabled, the
KVM_MEM_LOG_DIRTY_PAGES flag is the source of truth. Previously in
memslot_is_logging() we were testing the dirty bitmap only and did not
consider dirty ring.

With the ring and no bitmap, a logged memslot can still get block
mappings, so guest writes to most of a block are never logged and a
migration can copy stale memory.

Fix this by using kvm_slot_dirty_track_enabled() instead which checks
KVM_MEM_LOG_DIRTY_PAGES, within memslot_is_logging().

Fixes: 9cb1096f8590 ("KVM: arm64: Enable ring-based dirty memory tracking")
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 705f6d84770e..c7df646af79f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -176,7 +176,7 @@ static int kvm_mmu_split_huge_pages(struct kvm *kvm, phys_addr_t addr,
 
 static bool memslot_is_logging(struct kvm_memory_slot *memslot)
 {
-	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
+	return kvm_slot_dirty_track_enabled(memslot) && !(memslot->flags & KVM_MEM_READONLY);
 }
 
 static int pkvm_flush_remote_tlbs(struct kvm *kvm)
-- 
2.43.0

