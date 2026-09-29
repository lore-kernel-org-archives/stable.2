Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93D4E06FC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719455; cv=none; b=pRKjCZKtuEEFqcmzlDFasy5Z0fv54r8Pgsen8qBrHmTi0MuQDJ7hhicwgRH/2716Twwwhm9QzoMcqPu6N18e2vSmgN6IoYAVuFUsZm582OP/aYc5Cu3yxpH2lpY7ooESkGF3iivg6ctouf69Nra1ix/rbHSn6K8/hKI2X5BjBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719455; c=relaxed/simple;
	bh=YxAlMmfVcm2W4cU7DakMAjMJLU1Lttxry7DoFyXpeys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XjQCCiAWfCt+uLKxHvIHYWLWq7YcfODClFdELqtqwYmkc56s9FkC6uriCFchGk0UeBrJL7Hr1SaSJCYqHgiIrvIQxx3FjUw52bCKehx6Gt6hW5JglpAsM+/iyjEzCcuo2uPlzhULEkwVcwx4CovFcFyueRuERICchMPLqaBbf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boaIMtN2; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boaIMtN2"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e9eso7106508b6e.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790719453; x=1791324253; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dGp94WLO2gdDysa7HIE4Qlt4fCj3et0VUDMOFJDyak=;
        b=boaIMtN2F6SKV2UXWEPsvgpSaMqoKNFG/ApU+MhZ+og2UKQrQP7mNh6kTpcpcIzVcS
         yNkgdsT6pe/Jf8/OfpIbSRozzY6/k0c2U/4TSTds7WBfIK1AivvQh9Bg38Z9Z56++j+k
         +pHOX8lPnIhBhF6kQo9i798bMg54JxcZqJ1Sftz0uxcLZhkKaD48VjvT9oa+MUS/cNLM
         pCGCXYP9bQ24ZNQni2pLLVVAZ0SuxFOa6Frnkp493wo6hcw1rjshn5sBnskxjTBnbaUi
         Z1/qsjSpufk6NvF9kAV+xeZDIwgx4rVTgvpfM3G7stq1mIl+YWgNKFEB6otNjTUuV7H0
         b9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790719453; x=1791324253;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1dGp94WLO2gdDysa7HIE4Qlt4fCj3et0VUDMOFJDyak=;
        b=lLmt3Kcu68Ffpl5VXwFPgNHQ+iHIjka1Cf5R+ZHsvZgdbNo5+92FjkaUhuGkgdY/Pm
         1u/LnKLHc8ui3EejmXvtZBiQFt1V5wYqUjPmh0QvQCZp2oX2xITulzjfRE4fToR63p9/
         fMlrHUyTm6kIfDUvUBLhPebp3jK/inSj9Weible110bHOFqN77uYCnRn/VmuC4fQVswH
         I7iZU+VjO5FnoQIDPhacyse5589W0FnHx+oDD6gN2JKvcGB2OslJHzpXrgD9hY2r3EJN
         54czGpFf6T4+j3sHSbYNamDDW14uf0/TnomNbw7/iCE0tox7/kHVAEcIB9sIkmICwFBV
         gqQg==
X-Forwarded-Encrypted: i=1; AKwUvBw9D+/OcKFBltngkiCjgT1XAsZldF0prsA/Cye5nZW3mPGwVmUe1DroN4Ju7iReH9hNiGt2xus=@vger.kernel.org
X-Gm-Message-State: AFuF++nk5lBv1EiNO/7K6a9FTbe5u5vdN6qQGGYHaJVsoiGyPk9bk/I1
	bc+UXhMM+sXZpnUEZyvYqrNqEXZJ9NKmFtZ+K7gnCIlKkevVn5hOnAIcO1qztmeIJ34ljSdhlwf
	gn8DxGVMFqggGUslXwcwBIG4bXA==
X-Received: from jabgg6.prod.google.com ([2002:a05:6638:6906:b0:5f6:798e:166d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1927:b0:4ec:f57c:f81a with SMTP id 5614622812f47-4f074dcd517mr1045481b6e.12.1790719452327;
 Tue, 29 Sep 2026 15:04:12 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:04:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929220411.3756519-1-coltonlewis@google.com>
Subject: [PATCH] KVM: arm64: Check ID_AA64DFR0_EL1.PMUVer in reset_pmevtyper()
From: Colton Lewis <coltonlewis@google.com>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When userspace initializes a vCPU with KVM_ARM_VCPU_PMU_V3 but sets
ID_AA64DFR0_EL1.PMUVer to NI (0) or IMP_DEF (0xf, which is sanitized to
NI), resetting the vCPU invokes reset_pmevtyper(). Because
reset_pmevtyper() only checks kvm_vcpu_has_pmu(), it proceeds to call
kvm_pmu_evtyper_mask(), which reads PMUVer == 0 from ID_AA64DFR0_EL1 and
triggers a WARN_ONCE("Unknown PMU version 0") in __kvm_pmu_event_mask().

Check ID_AA64DFR0_EL1.PMUVer directly in reset_pmevtyper() via
kvm_has_feat() instead of kvm_vcpu_has_pmu() so that PMEVTYPER<n>_EL0
resets to 0 without querying the event mask when PMUv3 is not exposed to
the guest.

Fixes: bc512d6a9b92 ("KVM: arm64: Make PMEVTYPER<n>_EL0.NSH RES0 if EL2 isn't advertised")
Suggested-by: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a2f4e769a4282..0bb3c2f10a22c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1060,7 +1060,7 @@ static u64 reset_pmevcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 static u64 reset_pmevtyper(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	/* This thing will UNDEF, who cares about the reset value? */
-	if (!kvm_vcpu_has_pmu(vcpu))
+	if (!kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, IMP))
 		return 0;
 
 	reset_unknown(vcpu, r);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

