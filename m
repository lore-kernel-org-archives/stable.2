Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589802;
	b=Nt7GOQlgnO51eurHXc/XMA+Xd7eTZk0omGd5HMh0F3WQxcKQV+LIjgolcCeB5J6GIrZF
	 KdgBwGK0mcBDN4dRwqsRVC/GbVC1WiABLT32u2KrrUBFMLOWN6NmwHGFGewqmI7oPuoG2
	 GhmkSNzK5uOzedIanY8pWBQv/EQ3phQzYFqPr2bQHafC7HHrbr9eZxEjuGaQGFsTaTh7A
	 9+qxK9ybZmjJRoy4RjnHY3VzjBJzb0tj3lRM9ix8IxhmdoXILdiRtGEAsmnWOcY3FgJn8
	 S+mPlYj3JzraviKTh3gdl8KDhxPleiignVlW5s73W4I9Dg6t3c+hJPNqJsfY3ZCgA1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
	b=StmmlzZEmaJIPYqWa6DaNuAHgMWoJoQDMaX/LEH0fIb0JhCigqoGcO5bJQaxpuk+5MfM
	 TkVQZqapmwsEFJTApL6KMoOaWNQ/eCwPdCEVO3f/a3AUsu7Fkn+he+MYC/DKoARujely5
	 uKDDxNepPNA1MlyS1xaHiTe+Eq4vbTFtqjm2bJFmD9fziSWr1YHnZkumDE55XrmSM4EsX
	 UXu6Ppl37rwkRLUps7xas5QJJoEOsE9+NhJqHp8y9zj9RYrky5Ezu8oXZXrY+J8UwB7RA
	 36WqO85tPATS4PqpJEX83I3Q/mVsEH2kMFjWm/j2aqYt2QT4lN48Wpp204Fe0gCDKaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="W5U/UJS+";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A525606A688
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A525606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=W5U/UJS+
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a9be758734so3345470f8f.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589800; x=1796194600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
        b=W5U/UJS+7cfwYVajRpOi1u5K/6enm8FRZrPwbeutwCW4xLqgOknI08L1TNMXxVbepI
         NbhoW10qnRAA/6YxRG/xf6WHlyq7lrXl4tlqcWW0vl9JbeyAU2F3GWUmBIkHyfAcr10H
         NiOhpglsfS50EIaUgLY5CoBeg1lqXcUUYcunr3nxmU049foJ0lSaknlm87DL8j1jE5b3
         2JPHzJSOzbE2aOUFuJXAtR6mCyIxkqZoZ8ub7iJ4GUNATeuKGpJQLio5moQvND/BkYL+
         uaZjEirGchKB3KaH91m02dg/WQmcrzfDBlVIBBWz7JVCKI6AkOhDFcWe2HjWBUSP+4nQ
         E2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589800; x=1796194600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
        b=NGxcaor7X9p+tcKqHAYTxbFPG5SnTAhS3k8xAN7RKEo7e4j+4JyUCPwLxIVyVcWR2U
         nR/zfI7O4MC2pb6bsrDf0CXIhd5dOG7V3k2ecZBIv/kEFIcxU4NKTXG1a8vrkwvNtdf1
         fb5ZT4731MCNBnV4RkYQ3Tmy0UKgousV2Slr+TDmB49VkpicxweGI0jXpJWVRGqcWRro
         Cf+SzhqdovnTo/u/O5OjQhm7Ge5WZNiPW/RE2W4g1+X+snusTvuiOU1138vlk5aYTR5B
         x4+pjEOAVm2iZLanNip/C158oklpv838pERKePdTK6QQ3M8m/hxPpK+xLC63GlpLe53s
         OMfw==
X-Forwarded-Encrypted: i=1; AL+hErFAJ/amTbd1es8qfHaK8NsYboPQnFN17w9EdsDslJZqLVnXmqHFdMe+cIEogTlFv2sAEhwvltk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7zfZllvhY9QBQs3ugM+j4U3hHv3AzvJzEEzAtq1dgXEIynMVp
	1t2CzRUaMDqZb3hcXW4nA8rdLO4Z9NpLts0VIqaoXVbbssUv/JFXYzh8bOtUW6gx1ao=
X-Gm-Gg: AZFdTZeAVTbc/5poTjq+PbD+PYwVSjDhhbQ5PMp68oVaELZgta6b3qInMiQ6nf+hFoI
	RICc7LuFSPgoTkAUUzzf7Ax9n5CsOochgbKLe7tGQtGRehNoGsUJrNlsarDFB0N2t/P5/fuE1y5
	x7SvbE4rG4ALVesLoveFGBt0ChCY521YciHEDsupez3etBHNGeSUQdG+O5uiZf+PvmrzRDgQgj5
	AG8hscDItBPC2agM+gs16UtfLq7KqUrtvCR/wEqBstWjl7Gw+S67L7nahfuRAQwFHrFEL60TXUM
	R0XqPVehrSv796m0PMsrVd7eDeiD6y/y/mRvd1XowdBYY1OTsR/1rt1kgzyY/PafF2dRdkdNKtz
	LYaZEPyTz91bfFzD56UE48JWO3gcAnPnyy54cFpRC3GuEq47i19cARK4YvkbU7ZuzTWJspNjbyg
	6msWdZBobS9nxbFRUmUrCRl7EmSAOgCFrDN8SGP/H+A2X9Jn+j0bnWN7b8+N1Aju3qP4QO3LKPu
	YpoFLcgP1PaEx9M6E02QRfNZswYPloFYyRnUm/BYf05j4hKeulGgZWgBKdbi5BzStgmq6J2fYop
	Focr/igIYDHozU/zejE=
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id ffacd0b85a97d-4ac7595721cmr27351070f8f.40.1795589799898;
        Tue, 24 Nov 2026 22:56:39 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm32730554f8f.28.2026.11.24.22.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:39 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:17 +0300
Subject: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1 when
 resetting a vcpu
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
Message-Id: <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

Resetting a vcpu keeps the old values of SP_EL1, ELR_EL1 and SPSR_EL1.
Commit e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
changed the reset to only clear the general purpose registers, SP, PC
and PSTATE, and later commits moved these three registers to the system
register array without a reset value.  Commit 85d703746154 ("KVM: arm64:
Fully zero the vcpu state on reset") fixed the FP registers and the
32-bit SPSRs the same commit missed, but not these three.

The impact is that the guest that boots next can read the previous
kernel's stack pointer and exception return address.  KVM_GET_ONE_REG
also returns the old values to userspace, and a rebooted VM doesn't
start in the same state as a new one.

Zero them in kvm_reset_vcpu().

Fixes: e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
 arch/arm64/kvm/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 26081d273408..9c1b42890c96 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Reset core registers */
 	kvm_reset_vcpu_core(vcpu);
+	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
+	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
+	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);
 	vcpu->mmio_needed = false;
 
 	/* Reset system registers */

-- 
2.53.0

