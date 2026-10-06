Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028F463B7C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302146; cv=none; b=npDIyQiuxCB9xkTJvlYFrAn2GLh91coREC4eTaABzzT+pjWN+9D01yQe1TxbD4VYzthR1ttYgWflCj8y6gjpbhLi2pNAD7aPBt61A1Puc9xpRkieHcKWzhxWtgLZ5va8zbG2XepKgIApb3V87B/+8UdDt0omxOs+9zHk5kFnu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302146; c=relaxed/simple;
	bh=6p0BhHyn4I31U2S7KD6Dft1ou+UXu+nmMIFLtVTgau0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYst0+uQRL3Qm0QwdoLsfg5l9+1Hy2IpRK8jXuIR+mXqB9jTL3jyluEnuAH78wvBidnFTvLN3+TQ2lfxt3DmNR52ftv7YmsAxbgsMN2eaFYYD8qznYSb9+vuHFq1CBj+mKbGDTNA7lMi79x3kHShQXcfRoVmnZ/4KZcu26dBoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Och1ih6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Och1ih6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2EA1F0089B;
	Tue,  6 Oct 2026 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302144;
	bh=LPj1pN1epljv7/4OMxJttMQsnP/W6KrNj+Kdd5hT9ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Och1ih6MZbQi6mbJGfRVnITcTCx4AvDO/KcHE2gR2zgOZ7NUSRJOyDLcvl1hNgw7X
	 iOzmotHdSgN33kxdlYV2Z9ARW7w/VadOOe4qV03J/cMSL+zmSAdkBIOZplv58F35nM
	 7i4XcBH/fIaRc+Ho2WyWepJUezmNlNM2NrebuWsRKLFrCjOkYRi3aV1D3Ve0Mo7DcS
	 Ss0gifF35tE7WlTlQgRcKJPH5rP6+Ia7U6XSSjHtpwgJ3Qj/K4hEkuftfAiYMhJ/ih
	 FA7ByKL64un6LQwFoy3YqhNBbX2IVb6sKGTkHV784Vc5UtveN1iQ4Ai2Fe2BcSEyXx
	 Q9f9GjoXeg9gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] KVM: arm64: Always populate FGT masks at boot time
Date: Tue,  6 Oct 2026 11:55:39 -0400
Message-ID: <20261006155528.856144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100548-subsidy-prepay-7444@gregkh>
References: <2026100548-subsidy-prepay-7444@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 54adbfe40e3b6d238293cc36ef071ed9f35c8af7 ]

We currently only populate the FGT masks if the underlying HW does
support FEAT_FGT. However, with the addition of the RES1 support for
system registers, this results in a lot of noise at boot time, as
reported by Nathan.

That's because even if FGT isn't supported, we still check for the
attribution of the bits to particular features, and not keeping the
masks up-to-date leads to (fairly harmess) warnings.

Given that we want these checks to be enforced even if the HW doesn't
support FGT, enable the generation of FGT masks unconditionally (this
is rather cheap anyway). Only the storage of the FGT configuration is
avoided, which will save a tiny bit of memory on these machines.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: c259d763e6b09 ("KVM: arm64: Account for RES1 bits in DECLARE_FEAT_MAP() and co")
Link: https://lore.kernel.org/r/20260120211558.GA834868@ax162
Link: https://patch.msgid.link/20260122085153.535538-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: 4bdd2b3a708c ("KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index fbb37edfbabae..5fffa51ec1736 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2269,9 +2269,6 @@ int __init populate_nv_trap_config(void)
 	kvm_info("nv: %ld coarse grained trap handlers\n",
 		 ARRAY_SIZE(encoding_to_cgt));
 
-	if (!cpus_have_final_cap(ARM64_HAS_FGT))
-		goto check_mcb;
-
 	for (int i = 0; i < ARRAY_SIZE(encoding_to_fgt); i++) {
 		const struct encoding_to_trap_config *fgt = &encoding_to_fgt[i];
 		union trap_config tc;
@@ -2291,6 +2288,15 @@ int __init populate_nv_trap_config(void)
 			}
 
 			tc.val |= fgt->tc.val;
+
+			if (!aggregate_fgt(tc)) {
+				ret = -EINVAL;
+				print_nv_trap_error(fgt, "FGT bit is reserved", ret);
+			}
+
+			if (!cpus_have_final_cap(ARM64_HAS_FGT))
+				continue;
+
 			prev = xa_store(&sr_forward_xa, enc,
 					xa_mk_value(tc.val), GFP_KERNEL);
 
@@ -2298,11 +2304,6 @@ int __init populate_nv_trap_config(void)
 				ret = xa_err(prev);
 				print_nv_trap_error(fgt, "Failed FGT insertion", ret);
 			}
-
-			if (!aggregate_fgt(tc)) {
-				ret = -EINVAL;
-				print_nv_trap_error(fgt, "FGT bit is reserved", ret);
-			}
 		}
 	}
 
@@ -2318,7 +2319,6 @@ int __init populate_nv_trap_config(void)
 	kvm_info("nv: %ld fine grained trap handlers\n",
 		 ARRAY_SIZE(encoding_to_fgt));
 
-check_mcb:
 	for (int id = __MULTIPLE_CONTROL_BITS__; id < __COMPLEX_CONDITIONS__; id++) {
 		const enum cgt_group_id *cgids;
 
-- 
2.53.0

