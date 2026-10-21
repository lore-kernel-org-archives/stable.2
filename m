Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580491;
	b=I4ITWEDahz9Cgc1rok/uu8w4wfr8ZM34IDn2lTBA8QyOeKCU7TLnVSR13ueMo/auM1Z5
	 d17+I42x1q0ZngftHy9mzQVb4jG/PR605JoRmpVip1LDBwqCcz4W2Wh1+MuDO39gJD3Ep
	 5Opp0qTNtxFFRunj1JPBT/COuol/ilIraSFrDqSWqHj9E0wJUAN82EM51sl0yvYdyhsCo
	 qmnOpg0JginuTmRYAwDRdIXJIs2fIBP0XbNQELhpo0k0LYJAbtGdbohtFIlZChQ1QOXj2
	 2+pXiOFdM8gs9gSJywVJR1trF6Q2K0F1aZXzmzQp/CHtIDN81/FbiXSdmbAuL2lNfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HHIgomAuSYfj1cAFxx866cqVmlDtzOuB8qVUxKcbrHo=;
	b=0L9pe1o6HlQkBy83R361Gkt+LTVP9x8dpSrPtKBzTPf6GjbUSk3W8UA6Zr2nc9PsSht3
	 kMaNxXDRuMWrF027SdqlLgfx8UB803WOGY44wdQgtoZ1oFbKfkL6t0bdS91jeTYCmyUud
	 YTmYdouA2tNlEppFUL0feDZBMxy+TFm25ucPQ58/2NkVHfGi+BQeISqP+busnsdQhN3dC
	 I6Ir2u+B/uIN+VWOxFo/3b023S45PfTbu0+t0JBA/0ZoaAoIGtkQWlajc3kv3wHC6FiQ9
	 rE5tgzVfuolh3joD1dQEXCVFXMT1epPuyLTpnDPVE9YYsfYKs2vd168DXVz0MLDNWCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V9bpuW8U;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB55606A32A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB55606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V9bpuW8U
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso4320795e9.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792580489; x=1793185289; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHIgomAuSYfj1cAFxx866cqVmlDtzOuB8qVUxKcbrHo=;
        b=V9bpuW8UywYqiVSH/ybkQwLV9t3PUHOP3fGZBbJqgoPV0lRbzH8mK4zA4jgHnvGPr8
         N7yiH5HQT0/j1wPqqVn+vqpsmswM8WhklWceiDc7GDJVik8kKukQvpSScxzq83JXlDj7
         pi515AgTjacjMFigD2/XocZcEMYDDM6kEFy+WVbL4fovvQh3CJ1jcvNFT0l02d8fag6r
         LwHqcMuODaO/2/bpe6VMdo/6B7Vs1UGBbzoh3/BUFK/jngVJ2+eXtcpXgf1rSf6a1Oeo
         JmgEwkIqWEooLw36/hztOCdBLO5mKSXBzYqx8iYIxbN4uwPi3Jx3mF25a0NkLrFlWQlV
         ewUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580489; x=1793185289;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHIgomAuSYfj1cAFxx866cqVmlDtzOuB8qVUxKcbrHo=;
        b=Fqk+PkO8EU3L2lKq3JAnPj1aOU7MublwlJZTifcyw5PaXW7ln61Iw2KgJXe2pBjGko
         JhR2k6jWFkyx4LrD39Huqf8qunQuHRwJQ9InnFlwTyzJZX4nQI8pIcSkbiX1wiMdTqjn
         w2kQ3LkUyqCm9hksx7KUAR5CfB8N1TyARgMIbCX1S4h4G9OqC2LCa4bPd3lgK/f4YUcS
         OUl+I1xL2a7h4TksMy+CmoyqgEg6MdnydXPQUqLAHzA3zfE4/YiU2lqLaUdEYINr6A4E
         hQH4PzJyNg8yZ35AVCj6uv10QcLwIVtQtvBE2eXGfeRJ3tbQ+zghiLAjktzopO1X3CIY
         gRcw==
X-Forwarded-Encrypted: i=1; AKwUvBxpZNEdKNHFsII0yfwaiNWjjsvfPR4FKYXO5CgG5uNe6Wcl2iyCtFxSl4UtjS2GOuJG1hW3Ny0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX/t5QQ5IpdCtMNJ33xAt6M/EF7As949672Ir/AOfZ054meZ/3
	D6DChrZrfhFEEQhsWWsybiB+iOXwmels+mlCFgpL5rVDLxLg2M/6LiUI5b8VL66wF3d3M9uAE63
	mDCoEAKb+YdyHAqYeAOOpbQ==
X-Received: from wrnv18.prod.google.com ([2002:adf:ebd2:0:b0:48d:f214:2440])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3507:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a1fd8cd9e8mr34109435e9.1.1792580489307;
 Wed, 21 Oct 2026 04:01:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:00:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021110000.508827-1-vdonnefort@google.com>
Subject: [PATCH v1] KVM: arm64: pkvm: Clear GICv3 LRs in the hypervisor
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The LR registers are architecturally UNKNOWN when the CPU boots or
resumes. However, in protected mode, only the used ones are reset.
During boot the HVC __vgic_v3_init_lrs() is never called because
vgic_present is only set in init_subsystems(), after cpu_hyp_init() was
called. Also, the PM notifier isn't registered for pKVM and the HVC
becomes unavailable after the host is deprivileged.

Let the hypervisor itself clear those registers on CPU_ON, resume and
before deprivileging the host.

Cc: stable@vger.kernel.org
Fixes: fa8c3d65538a ("KVM: arm64: Keep nVHE EL2 vector installed")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 3 +++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index ac64a036b0a9..0e0ca29b224b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -754,6 +754,9 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
 
 static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
 {
+	if (hyp_gicv3_nr_lr)
+		__vgic_v3_init_lrs();
+
 	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index e20db999e328..a0e17e416bb5 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -213,6 +213,9 @@ static void __noreturn __kvm_host_psci_cpu_entry(unsigned long pc, unsigned long
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
+	if (hyp_gicv3_nr_lr)
+		__vgic_v3_init_lrs();
+
 	trace_hyp_exit(host_ctxt, HYP_REASON_PSCI);
 	__host_enter(host_ctxt);
 }

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.56.0.212.g129ede20d9-goog

