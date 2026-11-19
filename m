Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094767;
	b=vlvBxsmXvoc6s0Vvv4nrzR9kErLHfOhJywSiaZCPmhV2Rw/EUXj03TrO09pzQ0Uswl1v
	 FP4IU9GdFOtTkMkOxJwFIrytL3aQzKiXxKgvtMzzgxEhXUV2v+ZV289YkhtWTxPlGu1Lf
	 C85leEQBKlKM2L4ami/GEW+uVkjU3+Pvgz8u/786D2FEVpVvw+mmVEHjkmyRCoTI+yYWe
	 3MxuRFOs6kSrxdawVUDoeCZXUD9rl0hm5k7gpy+bMfZWMP0YcBkkGQwsmqo1RRkLA/8qe
	 YE/SMCvGAi5Gvk/pPsWqHR37Z2BNrx4zIgXFOakoen3FUDEPGtX69Fjwz9lDTDihw8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9RCUmBluXL32Xv+pv5scriRF4mb+lkStDc3uAW97NWc=;
	b=wjauM7ALwpnKWq4AZUAIYuKaPMadiyx0Cb/r2SNL48hUSy4SWEKaxth4YR1ttVruYPtm
	 v6Z5tyztnYJbh3aTPrt/0xBGFgpfzfEm2IMP5WrvfV2xcx53SaXva7EIWgIvHUx7c3jNe
	 4frfGJI3oHdQwWsASLds3MpGdWSteEa/O46nF+w5D84GEJbcMHJjh76zed8IMjUz/61hf
	 T9sZUjV4DjP25aq0SPcmZ7lRRDovIrQMV/0N8YZaOuZIqAOBBqXamjvcEnPMtMYIfGfpJ
	 LdEi8KqG2/USQHSwidGtedeAuDZkNiWZejoNN0wXaK21fW+vmnLGSN42Y4ZW7TudHxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=OkwIP4N1;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4C606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD4C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=OkwIP4N1
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a42b34e930so1877816f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795094765; x=1795699565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9RCUmBluXL32Xv+pv5scriRF4mb+lkStDc3uAW97NWc=;
        b=OkwIP4N15nLQkLcESeqM0GWzfQC60R+UTVj5sSh6QoAPepZbtgJpMpI3HbBoOzohIz
         hiuuZV81XQWrIvJ4ySrZ5tJU3uNMq22mrhsEDgeBqCWBYTLO8/9JjK3Ni4ydsg4PjwVx
         en8GWOmCj9oEGh044+1r+QE2Izy52nmf5Z/zXa416b93K/2LtMWNe5TfH8l3tXEzFD5d
         igRLobaiYBSlS1GgFUmj0CD7/ZLGmPEGVEIhRkudgXR8UVDXfs0Vdmdg+gWx1bEDup6C
         pKJhVBTNOkXRUhWFgyhrYoY46HccmMLMAyXlWmgjDHE0UYp/xy9Zg9BNhGwFSCOEc2fr
         3fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094765; x=1795699565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RCUmBluXL32Xv+pv5scriRF4mb+lkStDc3uAW97NWc=;
        b=ep+FrPEMcmc2jOffmV8Im2pQpg24c7VuHdx0BBwS+BtltFBhfUJZh5FloE2CuwEaK1
         iKUjtIHOKx1+J/34Ye2wzlxx7HpQdOFm7UaUiaKP9WDTtOyiWpd6gGiCVjQn5RwiPgt5
         pyPZQPbuJ7SM5/BuBuMd7EyXeKemTgsvu0wo4rsWrsx7cCxnH847WMwZHuASEXn4SRml
         jVwGbca1wlG+feFxtAEMuhM7Y6Vq/kwOtHkAu9pYwC0Rx0Ib/uz+hVGMc8nVdb6kB/Th
         chVRBI15EPNyj6vThBnUJHKFlddmMr0m4X9X8aDHHR+SylYxPaikdl+0De+GjxNrtK5Y
         M0SA==
X-Forwarded-Encrypted: i=1; AL+hErHPFXpd9EpRGju/sR05vgmHqne6b2ny02sezEEBtdUoLohU3JyR2bnBuKtoK9yNHWggO6VlquQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/smmK1GMc4feVTp1I9m5on3SUuv+dx5R12uYrhzIV/Ll1Z5hky
	DllXBop2q7FTz5dvSR6HptbgPynKO9S+q8LXfJCEOWHs4eRqvr7+I5boLkiXkYlywc4=
X-Gm-Gg: AYBFou3ep1tAyGx2S0iazOxhRwa5CQpKpcKP6JjuaEhlM/UHeWjsLwPUuDmlC70HlI9
	8r19LmkXSC72k/36aarPyYlTVDvVMq6FVGfMyReiUQUU3RYBWJYEhiju7YBxsYnYLfFzG3Jbbul
	OlL66wfqjOiEoUGuZwmTy6hBgAacVx+5EKgRHQ1bEfTquic2pXqB1CbNPhQekIIaaSlKQwTOyr4
	osLKtzJd1Ml8xv5DEWDbYCLZd9aGdX+czxXoXDq6Zam/DqEGJwd7dHwLeW/8pXjcN3t40g+PqEC
	RMj1HUcr2c9UJZFTXltuksuxCINX1AZnjC6PRAlkm1Z5vdSCdqSINQPVzx4uOlSRrI3+fJ65z7T
	6FBfbS7SGOoYb/7aYUMkjA7/ygYeL2Xd5+UGtFu8NAGH6A9x2258vUpoFTU5Vrb5yLzCQpGDtjI
	AplgfFiXdJ8iw0F48Gk1DMY+7QSfX+w9mkLTRdEYsmFB86QRLRHUmTPNYYP8717yVZEdpWQKZyc
	bWilqW121VriFUmlHP7jwz1xp9YENUExxXE2VNlbeKyVek061t4hTnSq4svJzKsu4691GZmISva
	PGf7V1+iV8bmMAC9GYo=
X-Received: by 2002:a05:600d:19:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb8701a2eamr15744495e9.17.1795094765053;
        Thu, 19 Nov 2026 05:26:05 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85342cedsm36282605e9.4.2026.11.19.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:26:04 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Thu, 19 Nov 2026 16:25:35 +0300
Subject: [PATCH v2 2/4] KVM: arm64: Trap TCR2_EL1 writes when S1PIE or
 S1POE is hidden
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
Message-Id: <20261119-nv-tcr2-v2-2-3deb1a6cdba8@pereq.eu>
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

A VMM can offer FEAT_TCR2 to a guest but hide FEAT_S1PIE or FEAT_S1POE,
for example this is done to keep the VM migratable.  KVM then stops
loading the PIR_EL1, PIRE0_EL1 and POR_EL1 registers for that guest.  But
the guest's writes to the TCR2_EL1 register don't trap, and the CPU still
acts on its PIE, POE and E0POE bits.

If a guest turned these features on, it would run with the permission
settings another VM left on the CPU.  Technically this is a kind of
information leak and a guest could figure out another guests permission
setting based on which accesses fault.

For these VMs, set the TCR_EL1 bit in HFGWTR_EL2 so that writes to
TCR_EL1 and TCR2_EL1 trap, and clear the hidden bits in a new
access_tcr2_el1() handler.

Fixes: 58627b722ee2 ("KVM: arm64: Make PIR{,E0}_EL1 UNDEF if S1PIE is not advertised to the guest")
Fixes: b86c9bea6349 ("KVM: arm64: Save/restore POE registers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: This is a new patch

This is only a partial fix, I will update nested virtualization in the
next patch and the !vcpu_has_nv(vcpu) condition in __compute_hfgwtr() will
go away.
---
 arch/arm64/kvm/config.c   |  5 +++++
 arch/arm64/kvm/sys_regs.c | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index e295435a30b8..f756f7c4fdf8 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1896,6 +1896,11 @@ static void __compute_hfgwtr(struct kvm_vcpu *vcpu)
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_38))
 		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
+
+	/* The CPU acts on hidden TCR2_EL1 bits, so trap writes to clear them */
+	if (!vcpu_has_nv(vcpu) && kvm_has_tcr2(vcpu->kvm) &&
+	    (!kvm_has_s1pie(vcpu->kvm) || !kvm_has_s1poe(vcpu->kvm)))
+		*vcpu_fgt(vcpu, HFGWTR_EL2) |= HFGWTR_EL2_TCR_EL1;
 }
 
 static void __compute_hdfgwtr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index afd7e76bedff..3899702d438b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -615,6 +615,18 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool access_tcr2_el1(struct kvm_vcpu *vcpu,
+			    struct sys_reg_params *p,
+			    const struct sys_reg_desc *r)
+{
+	if (!kvm_has_s1pie(vcpu->kvm))
+		p->regval &= ~TCR2_EL1_PIE;
+	if (!kvm_has_s1poe(vcpu->kvm))
+		p->regval &= ~(TCR2_EL1_POE | TCR2_EL1_E0POE);
+
+	return access_vm_reg(vcpu, p, r);
+}
+
 static bool access_actlr(struct kvm_vcpu *vcpu,
 			 struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
@@ -3501,7 +3513,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
-	{ SYS_DESC(SYS_TCR2_EL1), access_vm_reg, reset_val, TCR2_EL1, 0,
+	{ SYS_DESC(SYS_TCR2_EL1), access_tcr2_el1, reset_val, TCR2_EL1, 0,
 	  .visibility = tcr2_visibility },
 
 	PTRAUTH_KEY(APIA),

-- 
2.53.0

