Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626E4A2625
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303876; cv=none; b=IeEknXs+vn7E1QmCpukQ6ogzpS9fxJrOSDKj/sP6zurg2mjFvJ0SbBm6ku74//39G+hJIRbZWT5uKFXkWBR6KWwv7XhuEfLjG/YQ/eVNguI2GK+n5NlD1UjWcEX7lLUUVOeBXKh3/MVJA3zAUrII4ZqI6YBGU/1t7+ZowJJMVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303876; c=relaxed/simple;
	bh=3yW9tBCe5oNGIcMHD5s1PRYlG/N0/BEUaziV2J6K9Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/nwCEWdMa/ONhwUnle7fdW/x7rL7t6XISwtLolwg1NQaRd78IsdR7S8+Snq60+oGRrATXhENYeRAMTJXuHtx+2Hy1g0yrf4h2I0axfJLsBgcpkFI+n3a3a/fG1NyXl4GVVhVcycx5eKL3etvWjdj5CmkY+K7kMLeAZ55odq02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdr1aCj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdr1aCj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624771F0089B;
	Tue,  6 Oct 2026 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303864;
	bh=xzeG2h4cg1d7imSnaf8AL6XPN9iw31rUin6bh6xk3y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fdr1aCj3jQDyhBanw7PR9oObo+T3YMuRuA+cL0+m0ikCp5sU6LWyGWRLffvQYAhkS
	 IGgPRJcqFeAJawW7NXPL2F+i5szONGmWZLperW5sR5DUe+NUDHKnAAnsFYIQCJnJ7b
	 fDhDsidx+ZvgPY+4BhqB0GF0beFwNmrMG+TerJYq45LUZ2pzPfzdeQ/SN0hnE7s5eQ
	 KoOCRiqgODXBkKfysyl2zWHa9cmv/xw+dEOJBIqfwhKmmhqYWr5oSnfVVGI1oeZ+k2
	 vVDtSHrhNrG1OH+epqQczxPf+Q8FPx7WinUyOFIPWe20xrqtTBBX51Y+CfoKp7sJ11
	 ZSlIixYwPCmHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT
Date: Tue,  6 Oct 2026 12:24:21 -0400
Message-ID: <20261006162351.882841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100549-irritant-stammer-cf99@gregkh>
References: <2026100549-irritant-stammer-cf99@gregkh>
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
[ sashal: adapted the in-loop hardware-check removal to the pre-loop goto check_mcb and its unused label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 364beb6f27a1d..3d0c786ffa5df 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1981,9 +1981,6 @@ int __init populate_nv_trap_config(void)
 	kvm_info("nv: %ld coarse grained trap handlers\n",
 		 ARRAY_SIZE(encoding_to_cgt));
 
-	if (!cpus_have_final_cap(ARM64_HAS_FGT))
-		goto check_mcb;
-
 	for (int i = 0; i < ARRAY_SIZE(encoding_to_fgt); i++) {
 		const struct encoding_to_trap_config *fgt = &encoding_to_fgt[i];
 		union trap_config tc;
@@ -2014,7 +2011,6 @@ int __init populate_nv_trap_config(void)
 	kvm_info("nv: %ld fine grained trap handlers\n",
 		 ARRAY_SIZE(encoding_to_fgt));
 
-check_mcb:
 	for (int id = __MULTIPLE_CONTROL_BITS__; id < __COMPLEX_CONDITIONS__; id++) {
 		const enum cgt_group_id *cgids;
 
-- 
2.53.0

