Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789009;
	b=whD0atIibsaHiNuIR4YChPMSQdQp86+Gp9HCEkLjYqDyLtoCkr/jmMorFdW2fXht4KcG
	 AJBZQcwBXgDpUnNlXPYHSS71Fs2FowgUlidzlzkX0BQ/MPISAlR1E6I7l7yMpa0xrSmQb
	 kds5KSxL7VO3Cb+JoChauBveKpqKQzYegA8vrOI1gkSL6V7cVE4vS4JBzIDkeuTVIEsMy
	 h27s6Adu7ZNjyo7q1iKIobOyb6L6mcmC6gsi+7ALQgDh26bMK3m+kAQ/l3XpI9SKfOnml
	 9iCP4XH7DDPNrKHNHURM64Hlinab/agJAGJu3LKDy2dSb3HPB50f+2kDc51sewe+0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fwaZF0Yb7M0WWTnASHamIq+O4PcYnhbM71s65/ZFpMM=;
	b=mRAwGcYwHgCPpvWRpTotfxzRr1Qk/gifJVh7zcUxn+wKlVBlQfqMb4Zpz+ueL3ACKg0V
	 0yGuf7s1fgopjGI6H37IBPFOBgRRDHNsa8rCV1u3A0NBHC+mWoBrDfCAc1qon5fZmFDNu
	 r/D8MvKYxn3xSg82I5RukFD2Y2UkEzxlp5bqN44gD3wJxmn3yvQeXUljPCy8gbkUTr+AA
	 Tt1t7ijjKx2FMRfqO6JpZzi8gEIDXkLDRUSu/BcgntmuC2PwnF5J+AD9hSFxdLfydeXO7
	 TgQcLRjxeT+L+ipeLSy8OBDtSRS1LR+r9zoWWqDqsSuSL/luCm2t1YxHJ+RhbCzXQOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDA6djrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D008606A31E;
	Fri, 23 Oct 2026 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDA6djrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F371F031E0;
	Fri, 23 Oct 2026 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789009;
	bh=fwaZF0Yb7M0WWTnASHamIq+O4PcYnhbM71s65/ZFpMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDA6djrtre+J9vofmYzU/gb1057tTuB6TwrNqb+Ma0h959myBGwFXHRelp25sFlRr
	 4F4l02tKkzI/YCe5D5RfAOTsB3gVtb6UeJ9HzkodKxNQzf9T2eKtNLgN4dcXigcmNY
	 XTuAJZySbh/feW0UalQeycpqP2nXNi/kp8vFGc8Tc0HK57UROyukUioD52PbBJ/q9c
	 YVp/LTlDgnnclSJA39caR1cM/6lcFQW5I4Et6Mhs81BWO2OazcxZdOd+KprEWCHiJY
	 qILIxMvzJ4iecffBuBr6lDNeNoauVhJ1bR/EHj3Dza2xhqi9yTxiGA2iUXoAB461EM
	 n2fN7RXNZnChA==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Leonardo Bras <leo.bras@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 14/28] KVM: arm64: nv: Respect HA when computing translated TCR
Date: Fri, 23 Oct 2026 13:55:56 -0700
Message-ID: <20261023205610.1044532-15-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023205610.1044532-1-oupton@kernel.org>
References: <20261023205610.1044532-1-oupton@kernel.org>
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

Add the missing forwarding of TCR_EL2.HA to TCR_EL1.HA, which are
different bit indices, to ensure that FEAT_HAF actually works for an L1
hypervisor in the EL2 translation regime.

Cc: stable@vger.kernel.org
Fixes: d5bbb76f4474 ("KVM: arm64: nv: Expose hardware access flag management to NV guests")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index f0ac36fff652..d51d011fc68a 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -29,7 +29,8 @@ static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
 	       (tcr & TCR_EL2_TG0_MASK) |
 	       (tcr & TCR_EL2_ORGN0_MASK) |
 	       (tcr & TCR_EL2_IRGN0_MASK) |
-	       (tcr & TCR_EL2_T0SZ_MASK);
+	       (tcr & TCR_EL2_T0SZ_MASK) |
+	       ((tcr & TCR_EL2_HA) ? TCR_HA : 0);
 }
 
 static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)
-- 
2.47.3

