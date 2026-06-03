Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19C44BC93
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484829; cv=none; b=Dz74HEbo5+GZP1n3yYZMwE+OqrRnX9efS6JRgg78POzwWc1jRI/mKghtMkkhEm4amY/R8PYrXbMykMlCjorjtFJcGqLrpwa3pOxASnCv5siVbWfZKI9AhFWqoX/cu4cvXGyKO+ZzOSvKFjo4L95jPEF4aiQlztKhJdvPL7fjFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484829; c=relaxed/simple;
	bh=HHaMa7eLPPxV9UYKX2lfdGQaVhB7wiDgTAc/6rKQFEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kn1Pih1TQTiInJU08oXMcX2tjV0RG1p04DDfDM3MnEtKlNKk1BLsWlWGn1jxS9OHSsnTMZosOd6BvhWBuLlCWBlPxMVeuw5EhoK28atmdoCBNTzgiliL6SkBP+rQViGDMhvu3QScxUg62DNDyYAzPlKsfJCyye+UGFB65r4LQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LnnBeRdG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LnnBeRdG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6698D49FB;
	Wed,  3 Jun 2026 04:07:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 929C23F86F;
	Wed,  3 Jun 2026 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484827; bh=HHaMa7eLPPxV9UYKX2lfdGQaVhB7wiDgTAc/6rKQFEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnnBeRdG6jH7PVdKhOgYOeCjAkDoznMsj7owQ/Yjp79+B4UbQppt2eHPGXFi8+pgr
	 kHmksh8tIFJsOjWU9Qfqh3ryxqO9D8t7I35qXHJbDWBKq/U8IFQDSYgOlayKfv6vuf
	 gc6JNOJzDEBKWxHI1qB2U8o1FTfGlkIc3j2KOq8Q=
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
Subject: [PATCH v4 12/20] arm64: sysreg: Add FPCR and FPSR
Date: Wed,  3 Jun 2026 12:06:22 +0100
Message-Id: <20260603110630.1027435-13-mark.rutland@arm.com>
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

Add sysreg definitions for FPCR and FPSR.

Some versions of LLVM will refuse to assemble accesses to FPCR and FPSR
unless the "fp" arch extension is enabled, which we don't currently do
for read_sysreg() and write_sysreg(). In general, handling feature
dependencies would complicate read_sysreg() and write_sysreg(), and it's
simpler to use read_sysreg_s() and write_sysreg_s() instead, requiring
sysreg definitions.

The values used can be found in ARM ARM issue M.b:

  https://developer.arm.com/documentation/ddi0487/mb/

... in sections:

* C5.2.8 ("FPCR, Floating-point Control Register")
* C5.2.10 ("FPSR, Floating-point Status Register")

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
 arch/arm64/tools/sysreg | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 6c3ff14e561e6..8b219d6566608 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3790,6 +3790,51 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+Sysreg	FPCR	3	3	4	4	0
+Res0	63:27
+Field	26	AHP
+Field	25	DN
+Field	24	FZ
+Enum	23:22	RMode
+	0b00	RN
+	0b01	RP
+	0b10	RM
+	0b11	RZ
+EndEnum
+Field	21:20	Stride
+Field	19	FZ16
+Field	18:16	Len
+Field	15	IDE
+Res0	14
+Field	13	EBF
+Field	12	IXE
+Field	11	UFE
+Field	10	OFE
+Field	9	DZE
+Field	8	IOE
+Res0	7:3
+Field	2	NEP
+Field	1	AH
+Field	0	FIZ
+EndSysreg
+
+Sysreg	FPSR	3	3	4	4	1
+Res0	63:32
+Field	31	N
+Field	30	Z
+Field	29	C
+Field	28	V
+Field	27	QC
+Res0	26:8
+Field	7	IDC
+Res0	6:5
+Field	4	IXC
+Field	3	UFC
+Field	2	OFC
+Field	1	DZC
+Field	0	IOC
+EndSysreg
+
 Sysreg	FPMR	3	3	4	4	2
 Res0	63:38
 Field	37:32	LSCALE2
-- 
2.30.2

