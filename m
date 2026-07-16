Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB52D6E5A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227539; cv=none; b=tLB8GwJKc2FvkvQuEJN6wfNaRf+PaONKxaHCCt/Y2SViWlunjvuL45q4jtewF/FTpMKd573loA4+LVsh6qbEEERsIKHeBmGqK73p1fHF1yJssTGfzSVYcKeoGxil9/oqVHh0ei1tmc1LkX2UaasquERUaYuX5hX1V0kSg5/sVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227539; c=relaxed/simple;
	bh=nM1DCfoZoA5otdR3/QInedSCZPsjv7400DXJ0b6yhI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdmjPYMhvlt+0n+JSFVsV/43QX+BeMl1ogkvxuAT9DJIsBK/2+iccHSNGA/dpgwhAnbdX7qeGj7re1nV8KGgnUj+kRN32Mtic85C2lgJep9fv45MPNoBdMRJIx4EAt1Dxpbb6/cETfDDn4eEutsWPZ1RR9b5tPDeLO1FrZtWBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rim9dNr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rim9dNr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4EA1F000E9;
	Thu, 16 Jul 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227537;
	bh=aoQCkbN8qOBm1mcfbl/5x2lQ49WgJ7Nb2YnY9WU3OM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rim9dNr0bHQB7tcgc6pFIOUniQ2iBmK6s9F/tlPgQ5VzQ9VFISWoanTzGTFrHJA/J
	 TSMs0TTIDZLYtJ6h1FYrsMH77a6Y/IsXFsVmE5mF9VWb+9uz26RXTWeUqZ6lJ26SYJ
	 2g63aXKoUCkNzFUeG+1p1atYke6Uz+yf5yU+oMlcHpZKO/5P5fjuQu4MU3nwJqJXOX
	 5ec0XGH2idBBMZRJNhHOpyvpvHiGsv4yhUjub3Ewag0wLui8onpvtRcmfSvfK6jhtq
	 C/CxFdkHyxYDKMNXTXIO53MiULgpCbqRsuFc0vZAL+SXxECbKuBrW52iFHtkNkHdsp
	 n+pSZCxMdA8pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zide Chen <zide.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Thu, 16 Jul 2026 14:45:34 -0400
Message-ID: <20260716184534.1012849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071404-frays-clover-6c75@gregkh>
References: <2026071404-frays-clover-6c75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zide Chen <zide.chen@intel.com>

[ Upstream commit 9a0bb848a37150aeccc10088e141339917d995dc ]

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

IMC and IMC freerunning counters use a separate control path and are
unaffected.

Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260602144908.263680-5-zide.chen@intel.com
[ deleted adl_uncore_msr_init_box() in its 6.12 wrmsrl() spelling since the tree predates the wrmsrq() rename ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3934e1e4e3b166..c64e4f333563b7 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -538,12 +538,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -562,7 +556,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.53.0

