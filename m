Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866633B0AD6
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484822; cv=none; b=QaIeEw20/weEBw9gIw8cdUpFMc8lMZUuplLtFj+PEvAX2V12ETIjettrmD0cta+C12nsOQjhqbHcijJ8QKFYwT38SfAVs7q8Z8op4lSCYq6RP6DyTnU0rJWu05dYpfF5cNxpDNSgckd+IauRyvA3moM/beOvDk2fxzdITMczFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484822; c=relaxed/simple;
	bh=8BljP1hWhbtKXmA/On32yV+gMdhsFlbsc/9sDPSZtU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rqw2mc0VRJAu5dO2s0KvqJ9upS00mcFLfr0Pgf9TiZQlmewS2z+k33cadClCJdZ9Bhmgrx2I3/DnSYYcX4gnZWbxNtNslOgXbb+R6rnevmiy9zcs1QiJhaNk0S1WmAdCGTw+dABU/FbvGb9AM0sdCnM1Lu8H+qU5Og8IFGDaVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rgzUmm6X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rgzUmm6X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F93F32E4;
	Wed,  3 Jun 2026 04:06:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5798A3F86F;
	Wed,  3 Jun 2026 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484821; bh=8BljP1hWhbtKXmA/On32yV+gMdhsFlbsc/9sDPSZtU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgzUmm6Xgvpu88k0lxqBSQ//hsPUqXlyxKZTZCUh7gNhJ8p53K+/yC1o9JRxoys98
	 v74AyZbz/nAn8u5oiPNSFNWpErf4Xwieih1jr8fH4Pe+JFGoMBPP3dRYgoKDyt9YXH
	 xJU00XE4A44DzTGHfe+3LBWF0XZM1fISpBwGr71I=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 09/20] arm64: fpsimd: Use assembler for SVE instructions
Date: Wed,  3 Jun 2026 12:06:19 +0100
Message-Id: <20260603110630.1027435-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically we supported assemblers which could not assemble SVE
instructions. We dropped support for such assemblers in commit:

  118c40b7b503 ("kbuild: require gcc-8 and binutils-2.30")

Since that commit, all supported assemblers (binutils and LLVM) are
capable of assembling SVE instructions, and there's no need for us to
manually encode SVE instructions.

Rely on the assembler to encode SVE instructions, and remove the manual
encoding. The various _sve_<insn> macros are kept for now, and will be
cleaned up in subsequent patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/fpsimdmacros.h | 65 +++++++--------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index adf33d2da40c3..4ba23e493cb69 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -99,85 +99,54 @@
 	.endif
 .endm
 
-/* SVE instruction encodings for non-SVE-capable assemblers */
-/* (pre binutils 2.28, all kernel capable clang versions support SVE) */
+/* Deprecated macros for SVE instructions */
 
 /* STR (vector): STR Z\nz, [X\nxbase, #\offset, MUL VL] */
 .macro _sve_str_v nz, nxbase, offset=0
-	_sve_check_zreg \nz
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0xe5804000			\
-		| (\nz)				\
-		| ((\nxbase) << 5)		\
-		| (((\offset) & 7) << 10)	\
-		| (((\offset) & 0x1f8) << 13)
+	.arch_extension sve
+	str	z\nz, [X\nxbase, #\offset, MUL VL]
 .endm
 
 /* LDR (vector): LDR Z\nz, [X\nxbase, #\offset, MUL VL] */
 .macro _sve_ldr_v nz, nxbase, offset=0
-	_sve_check_zreg \nz
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0x85804000			\
-		| (\nz)				\
-		| ((\nxbase) << 5)		\
-		| (((\offset) & 7) << 10)	\
-		| (((\offset) & 0x1f8) << 13)
+	.arch_extension sve
+	ldr	z\nz, [X\nxbase, #\offset, MUL VL]
 .endm
 
 /* STR (predicate): STR P\np, [X\nxbase, #\offset, MUL VL] */
 .macro _sve_str_p np, nxbase, offset=0
-	_sve_check_preg \np
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0xe5800000			\
-		| (\np)				\
-		| ((\nxbase) << 5)		\
-		| (((\offset) & 7) << 10)	\
-		| (((\offset) & 0x1f8) << 13)
+	.arch_extension sve
+	str	p\np, [X\nxbase, #\offset, MUL VL]
 .endm
 
 /* LDR (predicate): LDR P\np, [X\nxbase, #\offset, MUL VL] */
 .macro _sve_ldr_p np, nxbase, offset=0
-	_sve_check_preg \np
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0x85800000			\
-		| (\np)				\
-		| ((\nxbase) << 5)		\
-		| (((\offset) & 7) << 10)	\
-		| (((\offset) & 0x1f8) << 13)
+	.arch_extension sve
+	ldr p\np, [x\nxbase, #\offset, MUL VL]
 .endm
 
 /* RDVL X\nx, #\imm */
 .macro _sve_rdvl nx, imm
-	_check_general_reg \nx
-	_check_num (\imm), -0x20, 0x1f
-	.inst	0x04bf5000			\
-		| (\nx)				\
-		| (((\imm) & 0x3f) << 5)
+	.arch_extension sve
+	rdvl x\nx, #\imm
 .endm
 
 /* RDFFR (unpredicated): RDFFR P\np.B */
 .macro _sve_rdffr np
-	_sve_check_preg \np
-	.inst	0x2519f000			\
-		| (\np)
+	.arch_extension sve
+	rdffr p\np\().b
 .endm
 
 /* WRFFR P\np.B */
 .macro _sve_wrffr np
-	_sve_check_preg \np
-	.inst	0x25289000			\
-		| ((\np) << 5)
+	.arch_extension sve
+	wrffr p\np\().b
 .endm
 
 /* PFALSE P\np.B */
 .macro _sve_pfalse np
-	_sve_check_preg \np
-	.inst	0x2518e400			\
-		| (\np)
+	.arch_extension sve
+	pfalse	p\np\().b
 .endm
 
 /* SME instruction encodings for non-SME-capable assemblers */
-- 
2.30.2

