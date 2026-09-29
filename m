Received: from mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698F41A92C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685382; cv=none; b=VyhHyS5ITcB45POsJnKtUWwil1tVbawZAEq36X1IEUnHzaJZO4Bqkclk1qDU6B/OOAMQ6iRCRVmpbxnkc3hL7WhQ0D6/kMS8AdEHvGKxfK+7CWUgl6pY4BGPtdlRIC96ZSZxZdvDcUPhYubK6wBUuao6B2kqSe8qFZGhOx15Btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685382; c=relaxed/simple;
	bh=xoHYGWxJ3HWeHZzxXQx61IngW2zJ4SZOM05+4N+3dXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrflFPaJP9tckwXvxldD/sYOe78PpNkWiHZ5i41gudz1p1B8pA5eZDEvuBp8gZ/0nxYu2RXQ+/DyrZ66My41vd9ueJbbV7ru/afNnrHrL6q9KnjHoaSnuirl30B89o/qAvdtPWCLch5/VnE2Worr8WJiyj9djMnR0BWG8atVSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kg9ngOuD; arc=none smtp.client-ip=95.215.58.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kg9ngOuD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xoHYGWxJ3HWeHZzxXQx61IngW2zJ4SZOM05+4N+3dXk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790685376; v=1; x=1791290176;
 b=kg9ngOuDASw95jhxmX90QrkctEXX5swEPm6QwPGvr698EJduFW9SF+s/99xHcqhhHDXK/aZr
 Z8GLpOJGf+xDSLCOOfMfGGdObbwm3jrOscNDzFR9uDFOFEMKVIAgnkMTXq3m3gQeV2IHnT0DcBU
 NdfvMLD6hQT0UqTbPmPgNCbo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 37b61db809701ff9;
	Tue, 29 Sep 2026 12:36:16 +0000
X-Mizu-Trace-ID: 37b61db809701ff9
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: stable@vger.kernel.org
Cc: Fuad Tabba <tabba@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.12.y] arm64/boot: Disable trapping of PMZR_EL0 writes to EL2
Date: Tue, 29 Sep 2026 13:36:11 +0100
Message-Id: <20260929123611.596370-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2026092922-crouton-reaffirm-8593@gregkh>
References: <2026092922-crouton-reaffirm-8593@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2bc6b218717b9d08f466f88209251d54bc09b207 upstream.

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
[Fuad: dropped the nPMSDSFR_EL1 hunk, 6.12 lacks FEAT_SPE_FDS support]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
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
2.39.5

