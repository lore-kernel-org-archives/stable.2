Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317BB3BADA9;
	Mon, 10 Aug 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357866; cv=none; b=FgjdXPDFjp++hblDkDr/XZOkebSF19M/GLipb/ye5/Vs+ZuVthNxgNP+aXgyM8d0luU9TRih7NlvL2wHjARc+cVUIj+1Z18ucuSN0ZuMVCJrKHmRPIKoJL7G1a/7QWOaYK1362R2nankNAr8poJ72cXBECAxe+QIc0+y6dofvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357866; c=relaxed/simple;
	bh=3hXKKeklNdpltdfsQs+YsPkHnJJ+W0maf0thog6BFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+N91aXR4ax77j02VopOGjN4Cc2/YhmzRrfRVBTUKt71kn5ru8eq4UpnIHzzZXKE8wmu8A3dAVAjck5zh89IbcjvsHoyRtRWMqLcuuBGUXM9FQf6WfbK3oC4Sy01IxMdzN97YOxL0GOmpkvr1ZaLv3/WtcCvESYgd2D7/jR8UDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=njzlT9FM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="njzlT9FM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61EF314BF;
	Mon, 10 Aug 2026 03:31:00 -0700 (PDT)
Received: from gentoo-vm (kajpuc01-mac-mini.manchester.arm.com [10.33.9.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB2F43F86F;
	Mon, 10 Aug 2026 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786357864; bh=3hXKKeklNdpltdfsQs+YsPkHnJJ+W0maf0thog6BFQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=njzlT9FMwAxw1HqCriBdVfiHc59llRi17BuSWTiw+ENxz1C9nHWHuzoKtBtaNKj1J
	 i5zdUMXfgfJV1bUYNbUzK517LWCfvQSy7W9wKeJUq48Bk+rcU8lQVLQjGolKeHMidY
	 lhc8jj7k1wZhmiAYnVVsURLaqyAyE2/cyRFFutTA=
From: Kajetan Puchalski <kajetan.puchalski@arm.com>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jic23@kernel.org,
	Sascha.Bischoff@arm.comzenghui.yu@linux.dev,
	kajetan.puchalski@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic: Fix detection of MI on no pending LR
Date: Mon, 10 Aug 2026 11:29:24 +0100
Message-ID: <20260810102923.2426475-2-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the ARM GICv3 spec, the maintenance interrupt identified by
ICH_MISR_EL2.NP is asserted when it is enabled and no List register is
in pending state. This is further described in the document as "no List
registers with the State field set to 0b01 (pending)". By checking only
the pending bit of the LR (bit 62), KVM currently asserts the MI when
there are no LRs in "pending" or "pending and active" states.
Fix the detection logic to consider only the "pending" state.

Cc: stable@vger.kernel.org
Fixes: 96c2f03311de ("KVM: arm64: nv: Plumb handling of GICv3 EL2 accesses")
Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 arch/arm64/kvm/vgic/vgic-v3-nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
index 5c69fa615823..e3e84d7f5ad5 100644
--- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
+++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
@@ -152,7 +152,7 @@ static void vgic_compute_mi_state(struct kvm_vcpu *vcpu, struct mi_state *mi_sta
 			eisr |= BIT(i);
 		if (!(lr & ICH_LR_STATE))
 			elrsr |= BIT(i);
-		pend |= (lr & ICH_LR_PENDING_BIT);
+		pend |= (lr & ICH_LR_STATE) == ICH_LR_PENDING_BIT;
 	}
 
 	mi_state->eisr	= eisr;
-- 
2.51.0

