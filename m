Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C272311583
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228624; cv=none; b=TcjDZ7nSpS6OX9iTgRSsQq6IliWC0vLCGGn1Kp47nfwvAIOYm765egyoOePfBgLUdcWFcov+zTRE7ALqHUqN0hkK/PNn6sp+aHA0dWcB3cMNmxZ1Rifv1I3d+39LHW4xJK11PXo57PwgmMmJMSv7CaaiIID8HoLQRWSNoglvlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228624; c=relaxed/simple;
	bh=j0wO39SUE4PKw8lWRwQXC+uBf2EoBJv4AIy+7NaIhtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=defL4KvgH9997fN3p61eyew5vyE5bPHhm9SW16md3asMl7uYa7d5NWJbdiyVS9u+sALNi9UZ573v1pW/Yjfej6byhmexDdHVIAQP3NxyTJ+EdvpDGUd05F0vfxC+4AsO6VbKlHn/i+1kbRKLVzChSfqJwIzBCtE/0aGH2b+JaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3vXSfP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3vXSfP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3901F000E9;
	Thu, 16 Jul 2026 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784228623;
	bh=HG3VZFS3kjeKc2R8rvcN+1lRTTdw3MO+4pwtoVKRkrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3vXSfP26EpXJfv92wWpB5n+WJPjhTRwAIiSpGo5OG+h+Q1/DxLV7cSg24fXg309Y
	 HohJIxgVvzj5m6qvaprDK4a/0AqrHtBuLQROmvgGHA/1DFRpZA+SepldG0PKkMhmXp
	 K5nMFCayPqJnTY043Ec2m5NxXnwGLAaCcVOM83n6pkXtgHPw15aROlZXOFhNhNwpj/
	 ErS1g36uQifhOySfzqkeAAapM9h5UEujFxXX8mRwKvm29cjIG/ETwyrAelBdDutCho
	 EhruPxc9Ts3fPUL6OtM63Cs2wchwXxrtG8IS/JtVGh53YTVms9affB+5gHfHTIm2kF
	 J4EtIgjLveNVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zide Chen <zide.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Thu, 16 Jul 2026 15:03:40 -0400
Message-ID: <20260716190340.1045396-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071405-unwritten-empathy-1c04@gregkh>
References: <2026071405-unwritten-empathy-1c04@gregkh>
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
index 7fd4334e12a172..21735c40b2b03d 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -537,12 +537,6 @@ void tgl_uncore_cpu_init(void)
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
@@ -561,7 +555,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.53.0

