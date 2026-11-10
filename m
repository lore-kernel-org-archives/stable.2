Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320925;
	b=2eLnfFQDZnMUxdfV6kNF0qJfwkPOQbStZIZIJKTEQpDcf04vy2Un1heMzMTCcPkH2mO4
	 RuKEIYmO3BJEefdjeO565TqSwHgaWVnbKMqJ7fk/dmf4QcmzwSaktUQ9v3xVulnea1/9N
	 s/CXuPG7HrzCCJBCOmecjkv41jQeqiszuNft0hlM85pcFhFFhet7GU4aIf0X1zwP7OvIT
	 9RwX4eHAdMVpMFovjU0PaFU4pODX8yfZfPcGrqs/LW6ivsrEbYU+ypgWkKIksnsjyFmwU
	 GmY5Klg7voOgoqOMWIvJPf6mk6AfXdPabFX2Hcrti9SXCIeKFfaL0KQWNPOFy6wuq2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Utbn+yyZ7sIxxPCueyFxfPam+mNukGo9dB2tyOIqX3o=;
	b=XGlFmNLOO2ATWAc+S1U2VMvnG92hY2N/Eq+qtMSOqISl2dii6HGBe05Wi9EYAjuAzWO6
	 4oJ+CHd040G1iaDgquBhfKF21hB2Zd4Udr3zyoFEICW2nQ4+ice9379LWDGhCQ5lXvmmp
	 xkFpUKZUTFwJjvbWfAknRzSVf9ygbkTXbnopUAhrKtwV0Gy2ZkSt143nicHrpcri/rF8z
	 riBvB7kxOAX9xnSCYoNL9ajI2J9AKbvIrTR696GOtUcJbGEoHiz4yWZ18P6ia3dYzE5fH
	 rrV+uTa7QrgffGFJQww/RVV+LKk8P3icRErUIjqlibdRfTE7/83dIRcWd7I41gAwqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi+VBmex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB0606A9B2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi+VBmex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBAF1F0089F;
	Tue, 10 Nov 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320924;
	bh=Utbn+yyZ7sIxxPCueyFxfPam+mNukGo9dB2tyOIqX3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pi+VBmexJxwNPAFQg5CqwtKdTxuMYiRdqsxbu3DKUyv4d0+UGuOcMOfFV8gOQKfLW
	 CgeeJbJ9B9JKch0H+IA3Lrc9ayJD1r998dOHKOlfXYON/GNHqqAAERCqHamf2bGz8/
	 bah0Hjpg2HN7gyVMowIxAOIHrV64uYaztQBWfzSj3LX5K140GZKA7BG/sEDODc11rH
	 YQ+g7AAFYaMpTFZ7HrpCe2DnBcyGlH0lUUSI8eJqUfWA+zlk7WTQMzvGDqUUonN7Tx
	 UiiZcWaMYjD9X+NRclJr+lGuMYZjdkBvaqIJi6LHHHROP/LNrrCnloFVc2KJuDkNDO
	 5GIPlpI5tqGTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Fuad Tabba <tabba@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Fix MMFR0 TGRAN advertisement for pVMs
Date: Tue, 10 Nov 2026 09:28:42 -0500
Message-ID: <20261110142821.1866022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051835-failed-6.12-6c29285e78b5@kernel.org>
References: <20261107051835-failed-6.12-6c29285e78b5@kernel.org>
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
[ sashal: adapted MAX_FEAT table entries to the existing unsigned restriction mask and signed-field limits in get_pvm_id_aa64mmfr0() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 3 ++-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index f957890c7e381..3a9909f565f28 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -92,7 +92,8 @@
  */
 #define PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED (\
 	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_PARANGE), ID_AA64MMFR0_EL1_PARANGE_40) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_ASIDBITS), ID_AA64MMFR0_EL1_ASIDBITS_16) \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_ASIDBITS), ID_AA64MMFR0_EL1_ASIDBITS_16) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, TGRAN16, IMP) \
 	)
 
 /*
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 2860548d42508..039badc77bf16 100644
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

