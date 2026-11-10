Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321230;
	b=ymtMw+xGoIhTRZ3VZeICK5o4uS6LQjAsYUWKd8nZycihAxYgr7qRRvjAkJ3F3StSwmu9
	 wrxvbl4BtRHEzZv8OhQCWQQvOa723aI5f9s7sD4ER6rAr4a90YRKI8nWNb2XevfBvss4v
	 O1nW8NmGw4LSNSQYnYjy5D2d/Qu9ogVyqWs6S5nz+c9PCFSwm5vXnr0JvmzZ7M+rI6wYD
	 OtlqVPVtRzEgskYmRaOd7GeO+ZjTh04vWAoXfkiOoQBfNp59URmoQKnmoReb5zfCveZID
	 tFlge8AgvrhgHu+ZHzJpM5C2E+GVTl/uzDmOofUaSfiL4ta1Qk9GZCDeuDRdtDXGkqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wfc1sRKGcwwSf0wu9O4vW1WBKh8AoDtVUTJZyiRCXo8=;
	b=iP+GhDhtuz/QEb0CpnL5w0ktx3KupbINgQPvHUGeO1/YRZ82TOtg+GidqVv5jTmziyCF
	 7o0PORWWcwNNtXiyHJqZd9bRxZO+k7JyTep4VAXW5B4tSSfTrYVjWIJWGzTh6fTbgLOTn
	 PSoCbAOtoM+m+ICbEE8IxcPIfIBPyVVgLqHc6IH5QyFN3pywfK2sJHNU0fB0etZT0oIxx
	 gKHpWegWqAqX+0hbpw15qf/PEs+pHDYB9Wzf9bdvRbwnXAc1M4qQLTUxWSVH49zIvKyOn
	 VKFF9hWg4e0DJeXRn7ZKF/eAsncvJjh4niiK7S+dD+G4SmviiOU26iCDDwxTmRsC1Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXM6vuwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3703606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXM6vuwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991DA1F0089F;
	Tue, 10 Nov 2026 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321229;
	bh=wfc1sRKGcwwSf0wu9O4vW1WBKh8AoDtVUTJZyiRCXo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXM6vuwZ1htjCwvtIb2bcCFOfcxEzNpb+GS8R5pTU6n4MFFsUtYHw34ktrTw0FI8n
	 pTyH8tEz7WRSxsu55yLOAv7e2PY6HeFNzQxBiQCOCLUFxzW7wU3P0KIVM2cA95ohg4
	 8i+vVwyhsQHtXCzqJ/F6sNUcTSr/yrgpw/AdlZomAHmwbTqGjgU/omBnFGKC+iTC4t
	 DCzFCgReLlZoJFZpoYosaEh9PwN4ImDyN+j+6BBbnQaRJdgaR+7YHDMaVYK5548fz1
	 sM0HOKrGBqv40ACFO/nh+S2kA55Sd9rrEVWDtxfCkq0jiNOInkK3xJBtvkl4H+KB5W
	 4RyMSVMoIqiaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs
Date: Tue, 10 Nov 2026 09:33:47 -0500
Message-ID: <20261110143311.1924057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053104-failed-6.6-6c29285e78b5@kernel.org>
References: <20261107053104-failed-6.6-6c29285e78b5@kernel.org>
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

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 6c29285e78b5e4811145ebda382ac0ba732ce56a ]

Protected VM ID register emulation leaves unlisted fields at 0. This
creates two issues for TGRAN:

  * TGRAN16: 0 means non-implemented. It prevents 16KB protected VMs
    from booting even when the hardware supports it.

  * TGRAN4|TGRAN64: 0 means implemented. This may falsely advertise the
    feature even when the hardware does not support it.

Advertise all the TGRAN fields in pvmid_aa64mmfr0 so that the hardware
support is properly propagated.

Cc: stable@vger.kernel.org
Fixes: 6c30bfb18d0b ("KVM: arm64: Add handlers for protected VM System Registers")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260928095454.3255918-2-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: adapted MAX_FEAT table entries to mask-based restrictions with explicit signed clamping for TGRAN4 and TGRAN64 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 3 ++-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 37440e1dda930..fc765894f3f31 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -90,7 +90,8 @@
  */
 #define PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED (\
 	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_PARANGE), ID_AA64MMFR0_EL1_PARANGE_40) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_ASIDBITS), ID_AA64MMFR0_EL1_ASIDBITS_16) \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_ASIDBITS), ID_AA64MMFR0_EL1_ASIDBITS_16) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, TGRAN16, IMP) \
 	)
 
 /*
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index edd969a1f36b5..7614978a548d9 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -191,6 +191,15 @@ static u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
 	set_mask = get_restricted_features_unsigned(id_aa64mmfr0_el1_sys_val,
 		PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED);
 
+	set_mask |= SYS_FIELD_PREP(ID_AA64MMFR0_EL1, TGRAN4,
+		min_t(int, cpuid_feature_extract_signed_field(id_aa64mmfr0_el1_sys_val,
+							 ID_AA64MMFR0_EL1_TGRAN4_SHIFT),
+		      ID_AA64MMFR0_EL1_TGRAN4_IMP));
+	set_mask |= SYS_FIELD_PREP(ID_AA64MMFR0_EL1, TGRAN64,
+		min_t(int, cpuid_feature_extract_signed_field(id_aa64mmfr0_el1_sys_val,
+							 ID_AA64MMFR0_EL1_TGRAN64_SHIFT),
+		      ID_AA64MMFR0_EL1_TGRAN64_IMP));
+
 	return (id_aa64mmfr0_el1_sys_val & PVM_ID_AA64MMFR0_ALLOW) | set_mask;
 }
 
-- 
2.53.0

