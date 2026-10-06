Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E549BD8A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302147; cv=none; b=XEATTf7SIXLoHAc5vJJbk6hBniwxYtCDfYQBcH5DV5qRRiKXLmu4zKIgdTDTnfyTzUSZFwytPr/2BIqB0DO2oUjvqpZhG0o3U52xm/YEW7et7/lRJMnp9/68Dm+ZeShY/JeBpRPO+TTohUUCd6wiGt8GiTa0m60PyYlHkFuUAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302147; c=relaxed/simple;
	bh=jyW0i0B1wwAry98MozCecac0X/xfx6q3Aohs1E0Lf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC7fxG1ekMRe3tNKmujGE3zrUFR8AGE3OgeLp6/4XpryHzDLy8GMGSzz13AvVnhcQwxHn7u6jsKqeLZ6tV8V7hQccjn732lJdj74nlT3two1ABR/2gwMKMYLdT3wXQnhB+dhk6pEcVVkqsCV9DMz1sCsH3c+TTwEAKlhpsxlPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7gaIRuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7gaIRuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D521F0089C;
	Tue,  6 Oct 2026 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302146;
	bh=uJbhChIjM5rwE8+yelSj7nCmvTT9TZ18yUOyKcj9yfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7gaIRuzRAtHpphXHUSDUiwQxDcL2a9xHimHxXeRjMrKFqS+8vcCGpMJwW2qwhTwF
	 Q6jKo5NwWImnisc5PI2z2oJJyGOXf8Hasxc+YxtunRqWMWATCBeXsebdstwNXb4FwE
	 C9vqJUOROm6Ik483EKAJWXI5KwXIuqMZy8XznUsLhBfAueowf6k6YGCdUMqya4Kc8M
	 Cyb7GMqh1z73homUkeZVpMcOAu8SH7yR0EzgJKEeFRCbK1TPkrz32bkuropgPhV0BR
	 o0GCQNHQEpH4tnu+kBVRhnTOza/rVmmeX7c+p+PBB0TjT+m/xu8VbCovGEiIgCBQuD
	 O8c3KnFA7BHmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT
Date: Tue,  6 Oct 2026 11:55:40 -0400
Message-ID: <20261006155528.856144-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006155528.856144-1-sashal@kernel.org>
References: <2026100548-subsidy-prepay-7444@gregkh>
 <20261006155528.856144-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 4bdd2b3a708c1feb701cb8b62feb8ad2fd77bb07 ]

FGUs don't actually require hardware support, so don't gate fgt trap
config insertion on FGT. This is the only action required to allow FGUs
always, as kvm_calculate_traps() already computes the FGU bits with or
without FEAT_FGT.

This also fixes a spurious WARN when a TLBI OS is run on a guest in vEL1
without FEAT_TLBIOS on non FEAT_FGT hardware. In this configuration the
course-grained HCR_EL2.TTLBOS trap reaches the handler handle_tlbi_el1(),
which expects an EL1 TLBI only from vEL2. With FGUs enabled the UNDEF
will be injected without needing the specific handler.

Fixes: f5a5a406b4b8b ("KVM: arm64: Propagate and handle Fine-Grained UNDEF bits")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260929090031.3829185-2-fuad.tabba@linux.dev
[oliver: Take Wei-Lin's suggested changelog]
Signed-off-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 5fffa51ec1736..60812caaa080a 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2294,9 +2294,6 @@ int __init populate_nv_trap_config(void)
 				print_nv_trap_error(fgt, "FGT bit is reserved", ret);
 			}
 
-			if (!cpus_have_final_cap(ARM64_HAS_FGT))
-				continue;
-
 			prev = xa_store(&sr_forward_xa, enc,
 					xa_mk_value(tc.val), GFP_KERNEL);
 
-- 
2.53.0

