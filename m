Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427282;
	b=cCSiQzq5had5j/QZ6UJrxw+EEZdNm8WOuOqDC89RKRBA78G9YN5BGH2Xze0MX0mOWThW
	 Fq5QC4cZoFFqhA08yimI6jX0KlKgzDYfy8rErVB5CRb8kb9jKgT1pROlK+o3wKJJAv8tv
	 TqkiyRkISbMucWGorf22y87vPRmV9MZGw21j+iOZNSqzpaHtXzaias54voa+Xhc3J653g
	 tq037W+9HqfstIU8tP3mOXDYh+x74kieFVEU7Dbb9wp20PAtkdwc2/Bib9BfECFTbKKQ6
	 R8kBNOPS0o6/lMP4524PvhAUtIWTmtFyCPX3AGv5cJpq4hZMI7N4fD+XkSb7fVN4byQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xXoaW7puZQVXtPvVEP8J871ckV5Jm7nnXRP/lyhSBaM=;
	b=RoIYHM+IA8op9nHK6+W8gX4GStWPXE2r9xJz3NlvG744KIwOUcO3/neHvBwRXjAQd1Sj
	 UFpyAmC7JsX+NjngNKyaj6zQ9B/j0daurqKRs8KK9auUEs+8WvJflvz8wfQjpFpY3mPlk
	 bG048WlbCurpjQDq3bnIXKY7k1VT9FnJygywG9ZH04MLWoZMTz1osBTliOq1Pfvgcavv/
	 OlFwg0IB/4ecKkm1Z+4VlJ+lBaR8QJuNRZd7Nf51SZ4QAd+a9w5j6gGVB2Bk/4WUXt7sV
	 /ZLM2Y5VKiknNHYDwuzNn63NPCEpyD7HIUJ+QdVLK/CGwrac4oCkbEFntg5eF7G/yOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=cDRx5VKa;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE29606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE29606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=cDRx5VKa
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e47347279so1749211f8f.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795427280; x=1796032080; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xXoaW7puZQVXtPvVEP8J871ckV5Jm7nnXRP/lyhSBaM=;
        b=cDRx5VKaRZr23mtKysSknJ0mCuExdPqtt4rwbBGe1jtrHNJTBbvGqDtqXWwYn/QI/7
         YLzKmxT3p/PZF+1ZnUnsvINT9+g5UbeFOwPwSdcGWrzvnGhQ8aoxvRcfFowrAuxv13q3
         amPNZqECsB+GeIztDdxp3yI1NwxldImQsSNpoH8U89kqNlFQ73AJhR9E4nZhSDwTdpPf
         d7MoGqfFogKmMpTKxyV1X6Skc7D0vTt9b7A0cDC1M+BMIlJma5/JLhdUQInfvPEUDdW7
         lWAV9kIUtRLOdrW88c770R0cWkvI1VV8QeZBcRWW1TnM38o8pJxHKRvlSr02j9OTCP3A
         5nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795427280; x=1796032080;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xXoaW7puZQVXtPvVEP8J871ckV5Jm7nnXRP/lyhSBaM=;
        b=Q0lLMjhbAt/LRTU73mzV7HhSQH1OPqGHl7v8JFB9WFvfNiMk03pH5II3hePyG+Lju5
         3VIqthgqqGC6wVBbIbjv7+Vzd12JSdzjM15z4dBZ41i7bbyZc/v6neROAW2L6VtEYcot
         dmOF+HaXQXPWAcv7HONfFdsJ2DbfKS0YMQYLmL6shAiQaVhZUHHYrOOiJ4Q8Y4vNEQYi
         BVtP/cudGTuf0MVcO95EaVhSpyXZYXsR5wtYV2VcWu59wtnd7HvzyZp+gPjyEs7h5esa
         WNLh/Buy17Gep1yuEnTl4d/eZFXDHJmSHimzjLkGmnlCAd6VMhNud9DS5Sq1t4FNhVBL
         3K5A==
X-Forwarded-Encrypted: i=1; AL+hErGTTgwvSjzDSyjnYJMajtQZnLcl+pvf1vsdS6LJMNadIAfdF10QSLZYmZ5nfmAB19FBGC6v/lo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i7KE5PWlac4gUAWx/DDVMpawhBCXBbHzI3eIC+lXLVFj8+ydC
	Ty1vuCIRFCHWc6vDM3fGLcro3Y66uCvf/IgRL4+E09M/gETYdM+lk/ZxmdjFpVAw3hA=
X-Gm-Gg: AZFdTZcgizkwXJb15tOAEz4oAEgH+uorl8y9kttxoCzRKbCKaHdadAxchOICPGPWA/W
	8Ig9PrhBoWRllDbV9t6LS4IA/MtuvaWdbra1MQ9/RppOYjbLi3Jbas+uGfSfgfPkQt1cAi0Ffco
	bK0C43E7YRS3klG4N/sl2IPXQS2hCUiorl5aJCgEE7wgjAPqrkOgVA1/kjF7FjlG7DlSlKjegkU
	gXEh2IIqrLQ+o0vMCIkzCQQD2KboebCQWHTeHLkRU7NFXSROo2bCqt5KMWOFXuqiD/FJYkRrlAD
	CTx55uXqEurPBecRwSF7Cns7Ga+ZLS116POxzoCE0cAkPmMXURPLXC+sO+Bvvx8ZEwV+VlXMTgy
	2hTVIC5rLzU7aF1Jb9FiBHY8hlrRYrNzBHFVtCNAbmnHi1TshSvQnOWbQsxB38f0juVgHT8P3hq
	OkKO3XxSpJdZZZi3MWAYlsUMB1OrlCXMfwFbDFhxCazmKUPlqb2AEiGwcW6D8qUiefMDLx82BDq
	naH74M4ajjwnh5SpCrphIBbr2w6vl5rfvSzKZHTASmRS+lQGnuuj22ZWLPPGYOLURtFxBY0TZPE
	RHSP9UidPWoC5zPRqvRp
X-Received: by 2002:a05:6000:26c1:b0:4b3:b495:d5ad with SMTP id ffacd0b85a97d-4b3b495d6efmr3113266f8f.23.1795427279778;
        Mon, 23 Nov 2026 01:47:59 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm17295126f8f.35.2026.11.23.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:47:59 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Mon, 23 Nov 2026 12:47:42 +0300
Subject: [PATCH] KVM: arm64: nv: Reset MMIO state when committing a nested
 exception
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
Message-Id: <20261123-stale_mmio-v1-1-73f9c67a1bb0@pereq.eu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MTQqDMBBGryKzbsAkNEKvUkqZxKmO1FgyKoJ4d
 5N20+X7ft4OQolJ4FbtkGhl4Slm0JcKQo+xI8VtZjC1cVqbWsmMb3qOI08KrUXXNNZ6d4V8+CR
 68faV3R8/lsUPFOZiKAuPQsonjKEv0Z+rNHAcJ++xAeuQAAAA
X-Change-ID: 20261120-stale_mmio-a33a67733b65
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Dan Carpenter <dan@pereq.eu>
X-Mailer: b4 0.16.0

KVM has two ways to commit a pending exception, commit_pending_events()
which also resets the MMIO emulation state, and a direct call to
__kvm_adjust_pc() which doesn't.  The EL1 to EL2 path in
kvm_inject_nested() uses __kvm_adjust_pc(), but it needs to use
commit_pending_events() instead.

The scenario is: the vcpu exits to userspace for an MMIO access and
userspace then injects a synchronous external abort or an SError using
the KVM_SET_VCPU_EVENTS ioctl.  If the vcpu is in L2 context and L1 has
asked for the exception, then kvm_inject_nested() enters the exception
straight away and vcpu->mmio_needed stays set.  On the next KVM_RUN,
kvm_handle_mmio_return() completes the access in L1's context so it
skips the first instruction of L1's exception vector and writes the
MMIO data to one of L1's registers.

Replace the __kvm_adjust_pc() with commit_pending_events() so that the
MMIO emulation state is cleared.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-221074@kernel.org/
Fixes: 9aba641b9ec2 ("KVM: arm64: nv: Respect exception routing rules for SEAs")
Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/emulate-nested.c   | 2 +-
 arch/arm64/kvm/guest.c            | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0614c3b3a40d..c75b0c623824 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1354,6 +1354,7 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 
 int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
+void commit_pending_events(struct kvm_vcpu *vcpu);
 
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 39136a89d74b..5a7019bb719b 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2921,7 +2921,7 @@ static int kvm_inject_nested(struct kvm_vcpu *vcpu, u64 esr_el2,
 	 * Make sure the exception actually took place before we load
 	 * the new context.
 	 */
-	__kvm_adjust_pc(vcpu);
+	commit_pending_events(vcpu);
 
 	kvm_arch_vcpu_load(vcpu, smp_processor_id());
 	vcpu_clear_flag(vcpu, IN_NESTED_EXCEPTION);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index ba4570c52a91..b7d36c2abfdf 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -770,7 +770,7 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static void commit_pending_events(struct kvm_vcpu *vcpu)
+void commit_pending_events(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu_get_flag(vcpu, PENDING_EXCEPTION))
 		return;

---
base-commit: 5a7235e9adff42aa043ac9473dbeb0354dca0967
change-id: 20261120-stale_mmio-a33a67733b65

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

