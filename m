Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA05293E0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865649; cv=none; b=utND9xNARoNWYus+7S37KWCJ/2/fD5hV03W5I3LE30FM6/sEw+Kn9nUwu7fBYpHsu3os549J4r9BGKxRIncf5H/Pvto5ga7ggS/u8b2mU/dGvJijfd+XJVqd3FztoqWNcCFkymhM2DwysAesP4LP0jWsUA4qWZvHETUbcohA+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865649; c=relaxed/simple;
	bh=DqhRUW75apnnRm/+NgVuUwPZB14lDLNVV5b0Gd4lk2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHavpHSHvIZ+VBhlfYdzj0rGN/JG5T5YEAr60e2AaNStZmj/r61yp7OqRZVjKDcgF67DRbFec3dYE1mN1geK06NMtp+h8pyz1xRX4x+s4l/f9/t+buZwCf0D4WeBjqOk6vdgR1UmbFK5kw3RnEfvS5lqQuC5iDOaa4HMrdSETbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FY3PH6e4; arc=none smtp.client-ip=95.215.58.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FY3PH6e4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DqhRUW75apnnRm/+NgVuUwPZB14lDLNVV5b0Gd4lk2M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788865643; v=1; x=1789470443;
 b=FY3PH6e4/aYAD4gMScM9UVHyVreFsVQy0ehzn3Ul7lA4Ok8aMo5YJtREe2gK8WO3ZNWHPdVQ
 VqpQsEyfnPgMIofhh3IxjpYsazAxmONZvQrcw52uxHV0s8dHDHtgfY20aHO1kB1fO8MPyMimsBu
 v8tTj891DabCsbMH2koAMVSk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b5834c5c726827b5;
	Tue, 08 Sep 2026 11:07:22 +0000
X-Mizu-Trace-ID: b5834c5c726827b5
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Keir Fraser <keirf@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Tue,  8 Sep 2026 12:07:10 +0100
Message-Id: <20260908110713.1540304-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260908110713.1540304-1-fuad.tabba@linux.dev>
References: <20260908110713.1540304-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix_host_ownership() walks only the linear-map alias of each memblock
region, and the per-CPU hyp stack, mapped in the private VA range for
its guard page, has none.

Walk each stack's VA range with the same walker.

Fixes: 1a919b17ef012 ("KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack")
Reported-by: Hiroyuki Katsura <hk590@cam.ac.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 75b00c3233102..362f2891cb32e 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -269,6 +269,16 @@ static int fix_host_ownership(void)
 			return ret;
 	}
 
+	/* The stacks sit in the private VA range, not the linear map. */
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr(&kvm_init_params, i);
+		u64 start = params->stack_hyp_va - NVHE_STACK_SIZE;
+
+		ret = kvm_pgtable_walk(&pkvm_pgtable, start, NVHE_STACK_SIZE, &walker);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.39.5

