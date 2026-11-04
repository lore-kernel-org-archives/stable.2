Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820087;
	b=4J1VS9EWxENxNEwNYStdi9VFV9oEDJ0/rGSpS8LAdM/lEnfzEcQzXcwnIG0Z0ZVAaxKy
	 +rAy0nThkfYEAbZEOcsvK1ukYwa5vG5mhllw/JgYfRU7tzEAbbyAw2c39aFrtDsaAimOF
	 suyzMHFYlqswehqpLKSgsq6/m69LRdWoSMhRcHcGQQSmQtQ8WztBY6WzgBK56oMvlaHoH
	 r/HbQroxnGmDGsF3zVkf5iTndEuQf5+kdUlkxlZH04r2hTYAsjWUUirs84vOjBdYAyvjK
	 jydS8HO6tlaJF4naQrDw1auO2U4xIAl754b4cWXoB/zJeppHPFChqPgh8DFEyc9qV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=czjvP+09qJENsIiqgPnTAKq7Thsq/blplo0IcQ8YHFY=;
	b=j0OhBCqOxgTA4cOwg1/z6Qq608/NYGNq6vDUPCja36ohN1KW9yf4NSUHPf2An9k86Cg+
	 pSnrCEfOLVDzR/ufXe52WL0Mozjly/HxFyS7syg8GD8tZJWsu2VTAE6QhcXz4MdgiJNTP
	 6Bxa+AdX6gri97wJ12AKkKNEBI9mAbnNX+XA+thk/Qt7CH494JXY9eGXfXvV0b5Z3DRWH
	 u5O+S9EBG6lBnzTEu8bKYQH7QCgsaDY33pKqxFf6YcJwCVc/TGKI2F/F9LRXzlnM9RFNl
	 TwHIJpe+IuFxMOahMc4xXyLHoo5+M4I6RRX5NoKCclolTw6XDWbokMa98ZG59CG6HvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cn0QWLiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CF606AB2B;
	Wed,  4 Nov 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cn0QWLiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38E81F00A02;
	Wed,  4 Nov 2026 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820086;
	bh=czjvP+09qJENsIiqgPnTAKq7Thsq/blplo0IcQ8YHFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cn0QWLiWV0U/5mJ7R5OSu4kuJT4LtkNa9eGZdjgL1TLlN8smXhvVobuDu+yZnXIAy
	 GnSIiwAUR3LZkEkreW+RiKUdxSFOgSupfAvfgBoMnPd8iq8a3cSSEF/981jImhd+6r
	 BQRnBJwUUscXC5uPyES9nORqfjWHNLh58sbJjerUU/1iRzRpWnWPDxrttP6ddC3HMd
	 moXJn2cUe05c/xL9fVlTDHeSvldHIqAn9fTMIOnGNPaHas3wbRYqrBDjyv5sbNvZ7V
	 i/fyfaC2o/NzHS5t0YkTC/3dmkrg6yPHb8t8fClrfA0vqbrIF2+cU84d3AJW5mS8iS
	 TdnVlDcwrB/6Q==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] KVM: arm64: nv: Disallow KVM_CAP_ARM_MTE + FEAT_EL2
Date: Wed,  4 Nov 2026 11:21:17 -0800
Message-ID: <20261104192124.3932743-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104192124.3932743-1-oupton@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org>
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

KVM's nested implementation already hides FEAT_MTE and its laundry list
of derivatives from an NV guest. While good, this is insonsistent with
the UAPI which does not explicitly prevent the combination of MTE and
NV.

Bite the bullet and refuse to create a nested VM if KVM_CAP_ARM_MTE has
been enabled.

Cc: stable@vger.kernel.org
Fixes: a7484c80e5ca ("KVM: arm64: Allow userspace to request KVM_ARM_VCPU_EL2*")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/arm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 157bf4b81202..a750413c684b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1793,13 +1793,15 @@ static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 	    !test_bit(KVM_ARM_VCPU_PMU_V3, &features))
 		return -EINVAL;
 
+	/* MTE is incompatible with AArch32 and nested virt */
+	if (kvm_has_mte(vcpu->kvm) &&
+	    (test_bit(KVM_ARM_VCPU_EL1_32BIT, &features) ||
+	     test_bit(KVM_ARM_VCPU_HAS_EL2, &features)))
+		return -EINVAL;
+
 	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
 		return 0;
 
-	/* MTE is incompatible with AArch32 */
-	if (kvm_has_mte(vcpu->kvm))
-		return -EINVAL;
-
 	/* NV is incompatible with AArch32 */
 	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
 		return -EINVAL;
-- 
2.47.3

