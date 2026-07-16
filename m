Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58D421A07
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229272; cv=none; b=Oi7SY4gUsxMFND6cAZTx78ee6IoZm1GeBO95i/Zku0FFf9Zq7Q5SJVCYEEmIkBcGCbZioFc/L+62Hd6CPRFumze3bnXTff+YhLDhSPWb2PDWLM5vMmTq58SZw0tKubxzvhUMaMb3G/Occ6Sk8NqaMFTP2KtehX2nvbx7nOevil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229272; c=relaxed/simple;
	bh=c5lCKmFuB3DWjceJsKr27ZWOFRAJItMi/YidvfeGX9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlTji1c41a4Qtyw/9935+DkQzsOSoQNbBuV4BLFC6xTIsH4727PEkaiaf1xqpqgEamDY1WCEdCixgIovg+B531bgzy3k96DyG9/xR/T8XrrVZJ9syamDzNzy17EDShnu0+DTvCbvgduYQWiY5Cojf6aRR+TowfadrnyUummQurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIZLXrWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIZLXrWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF3D1F000E9;
	Thu, 16 Jul 2026 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784229271;
	bh=eIrizTHvzesx8TU6rTLdILxvr5VVL3eHQfeUraLjWVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YIZLXrWI1rCjzuLeQ0njZwPkGueh0UnYvlMl3tLKmGn6QkYHmP9IdFE8HWuIqAVjT
	 cNci+OaVfBHQqmjgI8RTe8ozm4BNoH1GtWTpeGM1ZZIQYvt5pWYY+0gYBhkrQzDYcB
	 NLmAInJDN24v/UUkEU2ib1ivXVQ+pVi4JdDsvvf58tMf+ibA9Y/nYXF1GUM0ckT//x
	 bZwns+O1xeBz6/z2Qmu5mNjsUdNpo6HKzJ/YdDv/qi6qNFDxrkiQzuCGIWvchkAioA
	 Qxe2by/Wd+185IQulHqkCMP5S9T/yqBhC++rD+I1zoNAxb3mIRSKe/MII+gGs7YPNB
	 P7EV0oZJA8tZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zide Chen <zide.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Thu, 16 Jul 2026 15:14:28 -0400
Message-ID: <20260716191428.1077510-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071405-reach-wasting-2c44@gregkh>
References: <2026071405-reach-wasting-2c44@gregkh>
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
index 912fb3821a6bbe..4aa3abf6d8906f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -445,12 +445,6 @@ void tgl_uncore_cpu_init(void)
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
@@ -469,7 +463,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.53.0

