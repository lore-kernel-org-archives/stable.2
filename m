Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631229;
	b=HuhObGSDIcRWQGSVu9Rp76KkcaCDAdlm5CqbqeUN5PF/gV4sv6j266zxttwFtQypgC/q
	 KbbSoek6TLYi5fJJtsirGuyz+wOYFMb+NoCTtFPQkGsXXvYTgQDabYhhzwT1Kbe/g/o8l
	 EPLm9QZ8IHoiIflAY9kEgDIO397TL/ID3lrqVCVIcr8O1m0jrKHrbvnDzasCo2pJHLyid
	 38TtlNCAH40xxKpxBZ0ueELJHFDTPNSekCA9qhydXNyXNxNj1qKgYpF95VGie4VKAeih0
	 hmQXy1+7+1wrkS2auR6uodkFAS5GH8rlMY/98hoI9TunZ5BnrSMw4U98BTC7QD6+CjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T7om26OeJicnOx5stP3SgFdoC9BfNYzufMAyDNSKjpY=;
	b=cfQFpOBajtTUyyrIiUseKj7aC2/h+96F4bdGudlGP41Kjd9a4kYG/GYv4SO+UUghZ4gB
	 OKdkOCxFTCqAWGleVMsSzKecj179doL8/U0c3LRU7FaV1dqPisT3nx1UTHSgKsPYYs0Dn
	 CBZd2Q0mY8o9SI1Zucm+CNTRKCdTjtf7I2yHm4CYTUNC7un1PlRYFAq1f7EUinblrggtl
	 eKGcfbWSNKM3vBFavkgUGlejqHngyCw1ezqHMV8STQAbClLIwKr1ZoQNXc13AUeMTmh5W
	 oQXKlwLzVAqdbn64/bsFBEDW006mkrGXd3/y6mpsF0+Lvvrda8K0Jkuu/yVBvQP9CHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MalWx9LB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B6606A327;
	Wed, 25 Nov 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MalWx9LB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8C11F000CA;
	Wed, 25 Nov 2026 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631229;
	bh=T7om26OeJicnOx5stP3SgFdoC9BfNYzufMAyDNSKjpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MalWx9LBl6OXP/IkhbnWUyrbBDSREXTIj0wkacDk1bi1q6UArAIvnDE1tEET/IVKx
	 fWjN0yYZ6WXQImSQbbRagAXtQ/J4Kwxx9N2OrQhKNe5pwYWIXPhExijet9NFtKDwCx
	 MwENSHF+KR4M2NtfBoW+y1A8NnQoe1vlkGWTRoDI9D1e2TXE6xUmUxr6CLWihemaX7
	 M2W0ooCdkLNpo7Q3N6GrIOOnXzJFRAKf+ONDxIXy/Ob4eBSAsc0k2gGGQLuroSHWlu
	 Z4C45rScxddPw0wlFt7+yNJ/sQJ+bBpw3/MmG+Y2Kv+uClY9E2Qursvhm4zx071xe/
	 zqWsU9M7Zgulg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86/pmu: Recalc PMC emulation when deferring counter reprogramming
Date: Wed, 25 Nov 2026 18:27:01 +0000
Message-ID: <20261125182703.1694998-2-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
In-Reply-To: <20261125182703.1694998-1-yosry@kernel.org>
References: <20261125182703.1694998-1-yosry@kernel.org>
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

In preparation for always deferring counter reprogramming, recalculate
PMC emulation for each counter first. On AMD, this would make sure that
mode changes (e.g. via VMRUN or toggling EFER.SVME) are immediately
propagated before instruction emulation completes, such that
instructions are counted in the mode they retire in as hardware does.

This gives kvm_pmu_request_counters_reprogram() similar treatment to
kvm_pmu_request_counter_reprogram(), as done in commit 5dfd498bad5f
("KVM: x86/pmu: Calculate set of to-be-emulated PMCs at time of
WRMSRs").

Now that kvm_pmu_request_counter_reprogram() is just a single-counter
version of kvm_pmu_request_counters_reprogram(), just call the latter
from the former.

No functional change intended, as all architectural mode-changing paths
on AMD do not currently defer counter reprogramming.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f48..8aa9db1569167 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -218,26 +218,27 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
 void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 
-static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
-{
-	kvm_pmu_recalc_pmc_emulation(pmc_to_pmu(pmc), pmc);
-
-	set_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi);
-	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
-}
-
 static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu,
 						u64 counters,
 						bool defer)
 {
+	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
+	struct kvm_pmc *pmc;
+	int bit;
+
 	if (!counters)
 		return;
 
 	atomic64_or(counters, &pmu->__reprogram_pmi);
-	if (defer)
+	if (defer) {
+		BUILD_BUG_ON(sizeof(bitmap) != sizeof(counters));
+		bitmap_from_u64(bitmap, counters);
+		kvm_for_each_pmc(pmu, pmc, bit, bitmap)
+			kvm_pmu_recalc_pmc_emulation(pmu, pmc);
 		kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
-	else
+	} else {
 		kvm_pmu_handle_event(pmu_to_vcpu(pmu));
+	}
 }
 
 static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
@@ -246,6 +247,11 @@ static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
 	__kvm_pmu_reprogram_counters(pmu, counters, true);
 }
 
+static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
+{
+	kvm_pmu_request_counters_reprogram(pmc_to_pmu(pmc), BIT_ULL(pmc->idx));
+}
+
 /*
  * Check if a PMC is enabled by comparing it against global_ctrl bits.
  *
-- 
2.56.1.839.g22a8290db9-goog

