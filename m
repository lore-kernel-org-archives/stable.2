Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428354;
	b=rkn5dd5R8wmYhvPFGgAQZenwKehAbiiD2aGJpIHQOCkBfPv34H2swGDLom8I0hdnAE29
	 wem5YhS+pI/m3K2W1+whfa2evCSTWs6+71oioFpr+7pfSRmApKo5G5ourstjCAek2s3oi
	 4JqvBXBlsCUzMr3i7Gkm3jxX9kdTlblqpV5Ueqqhos9TLFOexqXkiqt5wjMy7Lm4WhWfY
	 f0qrpLKRdiKt+4j4670px1Qs628R88vxsNca49HhEXGRNCZ+JzE/EQquPzxuqjEXhP8eg
	 Dh2IAz/dYaiaMPNfY0ei2YIK/avFCvGHUtfWvu2oze87LSyYWDfqwWCwBegCqBqccGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Qxwqe8GUXMMOeGYRq6VI9SiKGnvgjX45C+Y5v/w1m2g=;
	b=oi4vishPlCKeXOxIJJgpJEFnpGguhF8RzZ3m3w4pnoA7IfDUEbkKy4z1uQhA/5CqLMIG
	 omTd7rrxci+5kcbUx+YtCDpA2rf7nldS/RgfeYHEh00EN/dXnK+oF7Xgbn1SX97YrI8xr
	 aR0uuYU5nLPNthCoMOiGXMwTAA/r0shwOXe9TVwH35w3hsRY25pggtqLDhFiHtbrwYX8O
	 f65oA33pBG//Y/x0kCvd4sQ0UP6/YqS5Zl6YGW6uKSjPB6P6BhfTnPtS9VPzjswX+yyWD
	 bZUAQMFcvLDPfCuUjaBHJD5WLrdW4FkCFtH3Rc3NX6SsLLTGzmOoZnBIC+gt1VW8MSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZC3DUoXm;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B8606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A0B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZC3DUoXm
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a42b34e930so2682281f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795428351; x=1796033151; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qxwqe8GUXMMOeGYRq6VI9SiKGnvgjX45C+Y5v/w1m2g=;
        b=ZC3DUoXmZubSop+wyg5almrL55EYHUkJqFvQ+qXG6ZKqEAx0OKvoxxV/GbCJJtA0Gm
         32xMKL8gUfBK+aNhrH/YJW6cQGZh3cruO5Db2KOM1pOAoxNmv3ODJqyVDS3GiK13LZUm
         LK/ds9TgH9CNsaAcXYdSOCZ4+mOOOZHxvIg5/ev4Pp/sf0jb1z9+7rTWo/1wH+EbvJf7
         hte0nPcA8RlPq93o5MBKrn2F6xQG5sR+llDk9RFVqyFTW0T+1wuqYwjalAiXcsiCE9iC
         0PZdbtY+sdG8SJFGuoecna6WNO07LLY9RMJadpmwGLEmB/0+67G/koF7nTotCND3qXeu
         v30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428351; x=1796033151;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qxwqe8GUXMMOeGYRq6VI9SiKGnvgjX45C+Y5v/w1m2g=;
        b=GpuCbiXkF9lHNS8dAN5ylMdwi9NK12kIel5uHnN1/PW4XWiHrXHF9qnkVdu3giIUGz
         nc6qGkLTnEIZll8/1bI4E7Z/79/uyX9XTo1BDO1ZyYmJeVXBVMVgFbi/VacfxmLTTTLg
         Y6C/tDtlk9fGMdlHnlrf56Xgz9+Mt3e0cqqdTh777BRO22KXouJ7rb3HuZTi62V+ctyg
         qlhKFZc2J1j/LigbOdpbKUEkBHWqxM7P6/XwICo16VqPtj7dTLPLUuW09kBKCqFqo8hS
         Xdkc5HS34g1Wtew3p4SX0PyQa5LaDewhG+9yJ7oVwM+bXcLSYtDvpeCkkz7++BuG1NT+
         nXDA==
X-Forwarded-Encrypted: i=1; AL+hErGp/8l5D8kU9HRhAl9b86NrAVMTZleBXnsQlrmJv/gWDONT+pNRw/rmapl3QNY21AfXYGioZGg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mu6fNssonalxY31FoLhk3f3FaRfjrvEg513jawxvy2DjhP5A8
	QdoITn2VYW8COgHRWdTveJx+DiM1kFG6+s6AqrT7S6cmbjtVLfCZC8HoG5XZYSw65Xs=
X-Gm-Gg: AZFdTZevx6Ez5mN3HnV9JfzY8E7sVseTW8ZsjEcviO5KFef4slkatcrfG3pb4tcLHuH
	RrVRBuzZyAzgRQaEUq6h6qAvXvqOm4qD5fNSVmy0YZPOnRG0hnvT/Mw+5VIiY7+EiXukjjufnX6
	FlBYYphdCWq5XbtPyn6LusGQuPOITrj8EywIgW94i4MlHVJkF3NXTzJQHkdh/7cjhy/6e0qE7sh
	XSgMwqwiaBgd6rjzB+dLkAr1eEA9tTZC1Hqvm7VxRlsY0mUzLQEjtYACHd40nf5F0HG2StNxMYN
	heveqqaGllyQDw8KrZsE+iZNzsGnKlHa0PAjarpSFpBfnrFEX/uawWoRLWhpC07Co/AOgighucg
	24BaB7nLjBS0YhAfys4gSeZAU1FDC0ZcRmtlA76Wv8r/RbRZ9mqp54Ynv7wtfeCeDrAvLgxopQC
	Ynz53hD+M4rWgyM7omk1KnnYy3nw1gWcwZPN0FrMwdFkYQ1ciC/oxshmZ5av3eFyp84wYsxKuz5
	6GrF6FMXWqIeZxKgketm3Ru5wWIjvF80ea1Yr63rss8hZ9805azrfd2p9vIbgThMX9PN5jkQRok
	pwMiHpvGIypVtuO25Hg=
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id ffacd0b85a97d-4af75776767mr11555729f8f.5.1795428351077;
        Mon, 23 Nov 2026 02:05:51 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm23977561f8f.24.2026.11.23.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:05:50 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Mon, 23 Nov 2026 13:05:17 +0300
Subject: [PATCH] KVM: arm64: nv: Re-inject a stored SError after the exit
 is handled
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
Message-Id: <20261123-double_exception-v1-1-cd82b59a232d@pereq.eu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WMywrCMBBFf6XM2kAnPhB/RaQkk6uNSFoyrRRK/
 91Ely7PfZyVFDlC6dKslPGOGodUgHcNSe/SAyaGwmRbe2K2rQnD7F/osAjGqYyN2x+CyNEy85n
 Kbcy4x+WrvN5+rLN/QqbqqQvvFMZnl6Sv0Z+x9rRtH/dilyqcAAAA
X-Change-ID: 20261120-double_exception-a34dcc521118
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
 stable@vger.kernel.org, Dan Carpenter <dan@pereq.eu>
X-Mailer: b4 0.16.0

KVM only has room for one pending exception or PC increment per vcpu.
If something is already pending and we try to add another through
kvm_pend_exception() or kvm_incr_pc(), it triggers a WARN().  If we add
an exception on top of an exception, the first one is lost.  If we add a
PC increment on top of an exception, the PC increment is lost and the
trapped instruction runs again.

Normally an exit handler records an exception or a PC increment, and
__kvm_adjust_pc() commits it before the next guest entry.  However, with
nested virtualization kvm_nested_sync_hwstate() can add an exception
before the exit handler runs.  It re-injects a stored SError after the
guest exits but before handle_exit(), which can pend the SError as an
exception.  The exit handler then records its own on top, for example an
HVC forwarded to the guest hypervisor, the FPAC for a failed ERETAA, or
the PC increment for a trapped instruction it has emulated.  This
triggers the WARN().

In this situation where we have two exceptions, the correct order is to
handle the exit first and then the SError.  Change the
kvm_nested_sync_hwstate() function to only store the SError.  Then
kvm_nested_flush_hwstate() uses __kvm_adjust_pc() to commit the exit
handler's exception or PC increment, re-injects the SError, and the
guest is entered.  The early re-injection was there so that a pending
SError wakes the vcpu from WFI, so kvm_arch_vcpu_runnable() now treats
a deliverable stored SError as a wakeup.

Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Fixes: ce66109cec86 ("KVM: arm64: nv: Take "masked" aborts to EL2 when HCRX_EL2.TMEA is set")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/kvm/arm.c                 |  1 +
 arch/arm64/kvm/inject_fault.c        |  6 ++++++
 arch/arm64/kvm/nested.c              | 16 ++++++----------
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 2d7c82cfb8a4..ab2ec9078b76 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -48,6 +48,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
 int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
+bool kvm_nested_serror_deliverable(struct kvm_vcpu *vcpu);
 int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
 int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a148e80d0aef..2a2add60b72d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -966,6 +966,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_EL2_VI | HCR_EL2_VF | HCR_EL2_VSE);
 
+	irq_lines |= kvm_nested_serror_deliverable(v);
 	irq_lines |= (!irqchip_in_kernel(v->kvm) &&
 		      (kvm_timer_should_notify_user(v) ||
 		       kvm_pmu_should_notify_user(v)));
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index aa2011cc0d5a..05c98acb014c 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -357,6 +357,12 @@ static bool kvm_serror_undeliverable_at_el2(struct kvm_vcpu *vcpu)
 	return !(vcpu_el2_tge_is_set(vcpu) || vcpu_el2_amo_is_set(vcpu));
 }
 
+bool kvm_nested_serror_deliverable(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_flag(vcpu, NESTED_SERROR_PENDING) &&
+	       !(vcpu_is_el2(vcpu) && kvm_serror_undeliverable_at_el2(vcpu));
+}
+
 int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	lockdep_assert_held(&vcpu->mutex);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 78d5b18dbd2d..f063c01c565a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -2213,8 +2213,11 @@ void kvm_nested_flush_hwstate(struct kvm_vcpu *vcpu)
 	if (!vcpu_has_nv(vcpu))
 		return;
 
-	if (unlikely(vcpu_test_and_clear_flag(vcpu, NESTED_SERROR_PENDING)))
+	if (unlikely(vcpu_test_and_clear_flag(vcpu, NESTED_SERROR_PENDING))) {
+		/* Commit the exit handler's exception first */
+		__kvm_adjust_pc(vcpu);
 		kvm_inject_serror_esr(vcpu, vcpu_get_vsesr(vcpu));
+	}
 
 	vgic_v3_nested_update_mi(vcpu);
 
@@ -2231,18 +2234,11 @@ void kvm_nested_sync_hwstate(struct kvm_vcpu *vcpu)
 
 	/*
 	 * We previously decided that an SError was deliverable to the guest.
-	 * Reap the pending state from HCR_EL2 and...
+	 * Reap the pending state from HCR_EL2, and re-inject it from
+	 * kvm_nested_flush_hwstate() once the exit has been handled.
 	 */
 	if (unlikely(__test_and_clear_bit(__ffs(HCR_EL2_VSE), hcr)))
 		vcpu_set_flag(vcpu, NESTED_SERROR_PENDING);
-
-	/*
-	 * Re-attempt SError injection in case the deliverability has changed,
-	 * which is necessary to faithfully emulate WFI the case of a pending
-	 * SError being a wakeup condition.
-	 */
-	if (unlikely(vcpu_test_and_clear_flag(vcpu, NESTED_SERROR_PENDING)))
-		kvm_inject_serror_esr(vcpu, vcpu_get_vsesr(vcpu));
 }
 
 /*

---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-double_exception-a34dcc521118

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

