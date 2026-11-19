Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094770;
	b=hQTYJ6CWzWQFdb5x4P6jgTPVV2k3cu096OhiMIQ4wxtxI6gsFKaCQxNmPBG24NzLu6VY
	 JEsoOFt3RXwekMPPm74/R5EGHOruM9UyEOQscGP2z+a3jk5O/oq6HHzOG22vSjK5J3p1X
	 W5gpC6x+PiMI4G2MSvGCHIFSqFev2QLKUoWwQk5+AmfcM/La6zVfGAalHsayl4IyjgNXr
	 BfL+y1Fjz5B84YdcVGTjt5CL5O034ElCYMW8cpWrycT2Yb/p8AbsH7G5Z3JY49Yo7Fvlj
	 DcoHIifk/b+kzSooQ8/6i1Zbqo4DJU/phDHGBhdQQWVKcnl+Ex7665iSKkwNO+LpH6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ntk4mAK9p6PJOEu3vzXljUNzscjCYNCzCNuBX536B0c=;
	b=oGs5nIFjcGWYsj35vJx08a9sFxGzHfb3Mg+YN61W8SdNxfyMY1cHvfcFXSovG9myKTm0
	 mDMb6zfNKuqfDM9hgzcBuk9GbHnBF5+arRzKzhojQa6FcWnUsECItFJY3BsuHCY77doKv
	 4x8Qy6ES0cBuZ3hcIai9R1t0nQ4hIxJiIWGtQLjpssG9dXDPzug+Ewm8mt8ZUh5Zyq2zc
	 uhC5dG0nhnZ9dY2JQJgvggBlcuU3A3EKJoT4UuCSIu6h15Ew+fKR5/YkEF0hLR/nJJDi5
	 dnfBaufdO6CFRg/Rh0eONMR70nMvAs/kscsgKQhcHMcA6MYCmnvNNVXXAHr5TbTvSNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Cjt1a2ml;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B4606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Cjt1a2ml
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1315849f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795094768; x=1795699568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntk4mAK9p6PJOEu3vzXljUNzscjCYNCzCNuBX536B0c=;
        b=Cjt1a2mlRWXyMviwuMh+VOmC+TpVtgyWRa+xDpY5hqL9uz5YUtzSbRflD+573o5Wo4
         IdGF8i4oxtDqtKoK5IdfHtQhqdaP76c7EngSOUnjMsTKuaCAFii+yku3QcNMz8I6917u
         3hklPwQ2/RKnf0mzrHqq1hKDJvnsaJ7cPQ4jJ4+P4lvYIL8v75BndeCVkWb91TQDrdno
         xj86fwimJCQQNGFuQqMeilAGK0tx+uf06S7+wA9D4F2qhaMtIjvw7N9wxnrMuA1SGcae
         SlpVP6RDKGR9sY5Tr1V4YYBK/Dp2DUoHxbN5XgK6qLSHVmPI4/5iZ0Fc3HjHNRN9DT/s
         2y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094768; x=1795699568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntk4mAK9p6PJOEu3vzXljUNzscjCYNCzCNuBX536B0c=;
        b=Q5pl5ZMY+54J1KsTRBMiY6mGw5DdCz2QYn7dmgs8KuQZpb65aKay3lq/6jpiNI6bbr
         cdDZ76hrXMjFiHjVh4/bijWtDlo4o+2Jlza+Q+bkdjl7A0GiCw81AI39WVBVC4PI+KvQ
         tw3DpHoHGqtH1sFyUvr4WG0piVO4eDuUTJCfcYX2oLfJ/hFcFCkOJTMt2bkur2vfRxr5
         VTTe1pFHMBMG1sM/bpv7+FfKo88Ezlg8XN/Vh2OQlHE4y2YPm1OEU+v4/ZiUYQItp2N1
         YtB2oUUJD6EcUiLWX0wnm3TUHjQxHDH77LkTCa9+MqhfeuGZEqUYGByJh+S+Lcw2ritp
         E4DQ==
X-Forwarded-Encrypted: i=1; AL+hErGy1W6TNSS4ZRObVQnV0I+zxvSOen4ig5rXk2suqOaLT/I9/sudwYC9NrQ51oLWMpBkx5/r9Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2Ns3p6aladQAo53fWoOEfD5Aan/QgL8nYOloWD/QJ5As1sYlq
	XWo7xRAfPqcuKzacVn/lLfEpRgytgpTleJgR3vt6gNg1O+Zc9jMA8zhtTVdlp+mWpKE=
X-Gm-Gg: AZFdTZdCMXYfSIDnG1MOt8krNlQt8n2/gqZAUu+xBUQ5u/p5/ggefUGgBifjEalPG9J
	H1y0/l1jR05VG9Di87xau6iGCngWvZ4+b1lii3vNU7vOBl1A7cqUDb9lff44zYbi5Ef9AptH1eJ
	iM+yHcGkZOY5+gk2iBYXBxBjCXOzsG+wRdfqTnPNe2fJhhRUqqCOaZ244hN7djSGd7X1u8vWBnB
	U4cR1OgcckpH87giHPyx9uZoyu6bMdr+Q0nlkDxXcHEJYCljFVb9tLS5lo09MgDp6AMcTP3paRm
	LK/B4EKFZZBgS/fErW6OPVi9il8ZEGN+H/ekLGUAL96xDASkXkA5CtxisHs+TydZEBM1/zuPvn0
	vhJtGPUDXRvSpllBznObrDLHUxCeHftrTZsRJSF50eFduyKf3ndTtAbwqTsPiFo1eXLY2B2JosM
	EuT0VsHf5jjYaFZRrbu5oWlVg3WcN+PsSJ8b8arzktpP3neqQwe/aWuNyeYB+6aHT8iKgzdChcH
	zQS5gMe+R3sKjF00acYB3s9VAaU7CmlMJmXahjTatEVVSQiBS0gvFS7qQ2E2ZhpkvrV/TUPThga
	r+mAQpKqc0Dr6awq6V8=
X-Received: by 2002:a05:6000:2210:b0:4a7:790c:4a56 with SMTP id ffacd0b85a97d-4a7790c4b2fmr10368485f8f.33.1795094768046;
        Thu, 19 Nov 2026 05:26:08 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6573baa9fsm11452563f8f.57.2026.11.19.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:26:07 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Thu, 19 Nov 2026 16:25:36 +0300
Subject: [PATCH v2 3/4] KVM: arm64: nv: Clear hidden TCR2 bits for nested
 guests
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
Message-Id: <20261119-nv-tcr2-v2-3-3deb1a6cdba8@pereq.eu>
References: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
In-Reply-To: <20261119-nv-tcr2-v2-0-3deb1a6cdba8@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jintack Lim <jintack.lim@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

The previous patch added traps for TCR2_EL1 writes on VMs that have
FEAT_TCR2 but not FEAT_S1PIE or FEAT_S1POE.  This patch extends that
fix to cover nested virtualization.

The bug is that a KVM can hide the PIE and POE bits in TCR2_EL1 but a VM
can still write to them.  It obviously makes no sense to hide a register
from the VM but still allow writes. The implication of this bug is a
small information leak because a VM can determine the permission bits of
another VM's page tables.

The previous patch trapped writes to TCR2_EL1 but nested virtualization
is more complicated because we have to deal with TCR2_EL2 as well.  A
trapped TCR2_EL1 write has to go to either TCR2_EL2 or TCR2_EL1 depending
on who made it.  With nested virtualization the hidden bits can reach the
hardware in three ways:

- A guest hypervisor at vEL2 writes its TCR2_EL2.
- An L2 writes its own TCR2_EL1.
- An L1 writes its L2's TCR2_EL1 in the VNCR page, which KVM loads as is.

To fix this, remove the vcpu_has_nv() check in __compute_hfgwtr() so that
these writes are trapped too.  When the guest hypervisor is at vEL2,
update TCR2_EL2 and TCR_EL2 instead of L2's registers.  Also clear the
hidden bits in __sysreg_restore_el1_state() when it loads a guest's
TCR2_EL1.

Fixes: 58627b722ee2 ("KVM: arm64: Make PIR{,E0}_EL1 UNDEF if S1PIE is not advertised to the guest")
Fixes: b86c9bea6349 ("KVM: arm64: Save/restore POE registers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: This is a new patch
---
 arch/arm64/kvm/config.c                    |  2 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 10 +++++++++-
 arch/arm64/kvm/sys_regs.c                  | 19 ++++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index f756f7c4fdf8..8bde0a5eafb6 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1898,7 +1898,7 @@ static void __compute_hfgwtr(struct kvm_vcpu *vcpu)
 		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
 
 	/* The CPU acts on hidden TCR2_EL1 bits, so trap writes to clear them */
-	if (!vcpu_has_nv(vcpu) && kvm_has_tcr2(vcpu->kvm) &&
+	if (kvm_has_tcr2(vcpu->kvm) &&
 	    (!kvm_has_s1pie(vcpu->kvm) || !kvm_has_s1poe(vcpu->kvm)))
 		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
 }
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4a008c8a696b..d6e8bab14ed3 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -261,7 +261,15 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
 	write_sysreg_el1(ctxt_sys_reg(ctxt, TTBR0_EL1),	SYS_TTBR0);
 	write_sysreg_el1(ctxt_sys_reg(ctxt, TTBR1_EL1),	SYS_TTBR1);
 	if (ctxt_has_tcrx(ctxt)) {
-		write_sysreg_el1(ctxt_sys_reg(ctxt, TCR2_EL1),	SYS_TCR2);
+		u64 tcr2 = ctxt_sys_reg(ctxt, TCR2_EL1);
+
+		if (ctxt_is_guest(ctxt)) {
+			if (!ctxt_has_s1pie(ctxt))
+				tcr2 &= ~TCR2_EL1_PIE;
+			if (!ctxt_has_s1poe(ctxt))
+				tcr2 &= ~(TCR2_EL1_POE | TCR2_EL1_E0POE);
+		}
+		write_sysreg_el1(tcr2, SYS_TCR2);
 
 		if (ctxt_has_s1pie(ctxt)) {
 			write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3899702d438b..e4a3beac6ec9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -624,6 +624,23 @@ static bool access_tcr2_el1(struct kvm_vcpu *vcpu,
 	if (!kvm_has_s1poe(vcpu->kvm))
 		p->regval &= ~(TCR2_EL1_POE | TCR2_EL1_E0POE);
 
+	if (is_hyp_ctxt(vcpu) && vcpu_el2_e2h_is_set(vcpu)) {
+		vcpu_write_sys_reg(vcpu, p->regval, TCR2_EL2);
+		return true;
+	}
+
+	return access_vm_reg(vcpu, p, r);
+}
+
+static bool access_tcr_el1(struct kvm_vcpu *vcpu,
+			   struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	if (is_hyp_ctxt(vcpu) && vcpu_el2_e2h_is_set(vcpu)) {
+		vcpu_write_sys_reg(vcpu, p->regval, TCR_EL2);
+		return true;
+	}
+
 	return access_vm_reg(vcpu, p, r);
 }
 
@@ -3512,7 +3529,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
-	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
+	{ SYS_DESC(SYS_TCR_EL1), access_tcr_el1, reset_val, TCR_EL1, 0 },
 	{ SYS_DESC(SYS_TCR2_EL1), access_tcr2_el1, reset_val, TCR2_EL1, 0,
 	  .visibility = tcr2_visibility },
 

-- 
2.53.0

