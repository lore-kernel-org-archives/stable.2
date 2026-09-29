Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674A3DD525
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686604; cv=none; b=rR43ucLRXIQQ20NOrfCOgmJ56rfrK5tU4t0EiygMk1XfBof73ApjbGSQUKqH63fu8ZjKJOjsUoMWseC7esECe3xwZuuz5goX4iZoIHEnFYnn5t3NRQ69/W5Q2YMftHbj7Hmpy1TEK1FPY2e2F6URGY5Fbbv5Qi4/z4bt8ix/5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686604; c=relaxed/simple;
	bh=3qSZUhk1S1jvMJTV6OnyIO8s6UV99slrAWxLLHpfQLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXthFMpHczC0YjJJ3f/g/o3S/71Vhun+HvNeG3WNq4zyP3WCfkDrDKw6O/ZaABrVeISQrVhjSRtlahGYHF8yjzD2dWZfkjOsGexdHW6YI1uKnRqfqAeaxant54zA5n7/TL0DM6APzMOUnwGS6SZHTvMotVu6jiPyeSzz/HMBYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcloO0ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcloO0ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC81F000FF;
	Tue, 29 Sep 2026 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790686603;
	bh=Ox+MMo4Oh5B5okfy2ciodYnMuBUAHBgxaBwX8PNFxJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcloO0zegMm4qPcjc96a8XOl9XMyjoWgW4d8uprwZtIdr9Uq8qE8SkMxdK6/qf2s8
	 ssRTo7kqGUYosf8KuwZrejnjTi52TSZcEMpoA65pBPK6eaWrftHwLCRUCBrBFEJXTA
	 G+dDPyUZ1sjeWFCT84TP2EUTDSobICTDJq9jqnSv1JBruAYEZ0l2IPTRKDzaW4UrUP
	 6erUubfecVsKrGY1CtcAej6Cqz2i+2poVJ3ZcwTElTUgePTZdA7y3ZKZZBMjUEj++2
	 W9t3ptR1kSxZvLA8Kzn3rS+rVd+UqbmnonmjYxLPlvdxniXvo2PdgLZ6zwAnrY9Emc
	 2hrxEQr72a6Gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64/boot: Disable trapping of PMZR_EL0 writes to EL2
Date: Tue, 29 Sep 2026 08:56:41 -0400
Message-ID: <20260929125641.3466859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092922-crouton-reaffirm-8593@gregkh>
References: <2026092922-crouton-reaffirm-8593@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 2bc6b218717b9d08f466f88209251d54bc09b207 ]

__init_el2_fgt2() writes one mask to both HDFGRTR2_EL2 and HDFGWTR2_EL2.
PMZR_EL0 is write-only, so its trap bit, nPMZR_EL0, exists only in
HDFGWTR2_EL2 and is therefore never set: a PMZR_EL0 write from the host
traps to EL2, where the nVHE hypervisor has no handler and BUG()s. The
kernel never writes PMZR_EL0, but kernel.perf_user_access=1 has the PMU
driver set PMUSERENR_EL0.UEN for a task with a user-read event, so a
write from EL0 reaches the trap and takes the host down without a panic
message.

Accumulate the HDFGWTR2_EL2 bits separately, as __init_el2_fgt() already
does for HDFGWTR_EL2, and set nPMZR_EL0 with the other FEAT_PMUv3p9
bits.

Fixes: 858c7bfcb35e1 ("arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[ Omitted the SPE write-mask update because the target tree lacks the SPE data-source filtering initialization block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 1 +
 arch/arm64/include/asm/el2_setup.h   | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 15bcd1b4003a7..4c43d38d5d70b 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -400,6 +400,7 @@ Before jumping into the kernel, the following conditions must be met:
     - HDFGWTR2_EL2.nPMICNTR_EL0 (bit 2) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMZR_EL0 (bit 21) must be initialised to 0b1.
 
   For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
 
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 9d1c88536ee43..e05218fbd58b4 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -274,6 +274,7 @@
 	b.lt	.Lskip_fgt2_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
 	cmp	x1, #ID_AA64DFR0_EL1_PMUVer_V3P9
@@ -282,9 +283,14 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICNTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
+	orr	x2, x2, #HDFGWTR2_EL2_nPMICNTR_EL0
+	orr	x2, x2, #HDFGWTR2_EL2_nPMICFILTR_EL0
+	orr	x2, x2, #HDFGWTR2_EL2_nPMUACR_EL1
+	/* PMZR_EL0 is write-only, so it has no read trap to disable */
+	orr	x2, x2, #HDFGWTR2_EL2_nPMZR_EL0
 .Lskip_pmuv3p9_\@:
 	msr_s   SYS_HDFGRTR2_EL2, x0
-	msr_s   SYS_HDFGWTR2_EL2, x0
+	msr_s   SYS_HDFGWTR2_EL2, x2
 	msr_s   SYS_HFGRTR2_EL2, xzr
 	msr_s   SYS_HFGWTR2_EL2, xzr
 	msr_s   SYS_HFGITR2_EL2, xzr
-- 
2.53.0

