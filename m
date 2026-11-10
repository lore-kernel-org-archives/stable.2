Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321498;
	b=UVBflg1L5XWPxKJIH52tgUVYh4e5ZtJsGQWEO/E5H1IU3kikBbUBM47+RhKeMLoKnYZq
	 BBMRwZ0u+9A4OTO4fr+YpsFAhIZW+dAiUxrtA5T9o34EOZvZ4bifVqDmvq9ZXk9W7b6if
	 tgefmhGbYgUyEE5poc2kHNE5RbB8/QLLgxrKa4mMiaA00JgRoG09+AOAZFdBd5uu8M/cv
	 Ey1Db4O/cryo+jEDWVZZO7iC6UOm9XkcRwMEel9rNSKIVPCEvGJmHhKrWaLCxkiTMVsXd
	 45JD4RW6i4gO9osjVqZqbNAKz2eos1+4Zhm97Fk/TwxqNkyMhUW2kgUBtATRrjfVbbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3xHTm2+sWMYD93fVwF3/HSZLrkT9R7Hlm4v1L1v2SWI=;
	b=cvhmcpMw2QK60PXnc3QSKU3zeakRimCo5wsEiyv2nd/E5v6rGA1ZIepczw7BrcWGLHeA
	 zSbcvdJY9XUC5T4XvTtkXNJoETTLG035V32dhAXIW6IQmpacZOtjwdi2YCdtWNw1f+lSF
	 aZzQtavd403eSFI+t+S/xv4t+9gCMxJq1ZKzTdQj/ckgIBubAnTnLsB78nvaP6gRCMAH3
	 3Ymg+g2L1137/9i9U9GE0uJ1JUyeppinMpV94Q2IU1AkjNJgL/fUdstKeP4M62DGK+J+4
	 Afp8a/fFH1Uw3YhEiEgL+7nzy+Vj32/0e+aPnyeWfV1VWmN7FM9mz4btHHf52l6+HhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL5Pv4Sy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F6606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL5Pv4Sy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE491F0089F;
	Tue, 10 Nov 2026 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321498;
	bh=3xHTm2+sWMYD93fVwF3/HSZLrkT9R7Hlm4v1L1v2SWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hL5Pv4SydUU5NwaE5KOiEcL5/jlxvb/ihpsUBXw+KE6Bk9NM8+y0EQb6AdPYEnRCE
	 JeSZbyQdUvB/fJa16akff+6hdNrS/yCnyTl1JtlZrEfbFUEEEBetwHJCoDHpyDRWj7
	 QA9RZchuYF26F7OLlWdrJYZS2+Ppz5ZXGyE2Ol3SSQdbJvwWeCyutclCV9K3TFexiv
	 99is3cTAmCOj+T9vZ98BaqJmQZa8k5xf9UCKw51tYcbPQcbIMu+UUBHNwzwdCCLP+3
	 pnkMpLTo69KySmyOoYUlHGdYVCMEJrxUsK1lsASMlnYxGCeWs/nzfEMYXvlgtEML2W
	 Aqb8hOi8/0LZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs
Date: Tue, 10 Nov 2026 09:38:15 -0500
Message-ID: <20261110143744.1938826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054345-failed-6.1-6c29285e78b5@kernel.org>
References: <20261107054345-failed-6.1-6c29285e78b5@kernel.org>
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
[ sashal: adapted MAX_FEAT table entries to mask-based feature restrictions with explicit signed-field clamping ]
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
index 3d5121ee39777..20ba05ff34209 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -190,6 +190,15 @@ static u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
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

