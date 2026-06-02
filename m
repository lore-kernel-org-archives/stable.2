Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40810372044;
	Tue,  2 Jun 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419547; cv=none; b=ko3922wPA2F+wvaL99BiVyUb2DIg0oy6mrMg+cO+kJrw0yYHYgoaKNjjOi2j9Hg/oGWx26/VyqiNwLi8zFSpv8/o8PYALR1JFF6xSDwUZN6n8fhkXWhlzYoTuvHdG+t7A7a59rEWgDbN3NHdn9TLcUFGVD3CSMAYda6bcvMYVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419547; c=relaxed/simple;
	bh=HlLsK/9IZkDbvTvpnp2GQNyEw+bkcj1UhTsbwLMLH54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGxeQlZdXfV3BQ/JmWxrk1pMDiVS482I1JduxAro+3KR+2U0NLHzOUdz6ZKOtStL69j4DA6xy7phSAWGJWkIhI2hGyUVZaAFP2tAVEZkrj0i1oM63a7kp1S/Vz4uP9co4ev4Jzea41MZenh2rvsq7x3kAUbHFk5sTVqrdcKU66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPiu5Y2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPiu5Y2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48FA1F00893;
	Tue,  2 Jun 2026 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419544;
	bh=yibPAJqJKnP4lRaKaf0w74V6T2wSul4RlYZkqtEKyho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPiu5Y2CdDCdXU5lUe6+ncSRNeQ3gkA5V4vqeaVLQxmZAz3RV3QM4+Or5yL0uY7B2
	 YkqQbuUd2/wqAGgejU6WjJgZDbph+dHBD97GfAAEIyNsNf+2FoyoY9B9IQ5d6kBmDx
	 +5JTMWO6bQxWvHrPLTzYaONFr188TCweMl9pp4s+pahj1foi8iDSMiKvslR2Bl3pR0
	 vOQHbhJoQUri5hS7/YTNwoppoKT4/HVg1eT/VEN+dtlFJ6CWmjXj7VOR9qPuhIDxal
	 1c8DiQ7Oq95QKaQH5jBfsVQsEy5QgiFPOi/68n705cq1N6NCimKolAd4WNPwPP8/qL
	 8NRokMMYa9D4A==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
Date: Tue,  2 Jun 2026 09:59:00 -0700
Message-ID: <20260602165901.52800-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602165901.52800-1-oupton@kernel.org>
References: <20260602165901.52800-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XN has already been extracted from its bitfield position so using
FIELD_PREP() on the mask that clears XN[0] is completely broken, having
the effect of unconditionally granting execute permissions...

Fix the obvious mistake by manipulating the right bit.

Cc: stable@vger.kernel.org
Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 091544e6af44..a0eb83319c2e 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= 0b10;
 
 	switch (xn) {
 	case 0b00:
@@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= 0b10;
 
 	switch (xn) {
 	case 0b00:
-- 
2.47.3

