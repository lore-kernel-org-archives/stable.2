Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8142E8D6
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227860; cv=none; b=kEmfZvhVenyowPsqNFQa90xNVoCxBCi8KCCKnb2aaVpS8cpc3/UpVb5gx3AQcUrz+3sXTQ5NPmYD7jnRl657Sw2L/GufDrjXPNpaZsulm9+YkW7Ohx1iKdqk8O1eZ1qU2AKHFsKBhUeA/ej7jA02aoUWdTUeg+tudai+KZjwgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227860; c=relaxed/simple;
	bh=j0wO39SUE4PKw8lWRwQXC+uBf2EoBJv4AIy+7NaIhtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7PUsAQzhTd9mIf/CcukDTbGdChgsynGO9r5UIgwCOHNNpuE6qfYJxjBw0t4+59Paz5+/2M0tmDLjXdFKtG1RMkccmnCNBvgMYX3vsO5uXnibYcukwEeaxvr35XHiJjYTbvtmbsV1N/Y195KRqLmblTFrb5fMnksVHYM8MTKKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH9S3Jf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH9S3Jf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458F91F000E9;
	Thu, 16 Jul 2026 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227858;
	bh=HG3VZFS3kjeKc2R8rvcN+1lRTTdw3MO+4pwtoVKRkrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mH9S3Jf0IR2mtpFKAzGbj5/PwdXTg8GbAbx/q1QeRQpsl4Bj0K1njbRVpJyKa43j3
	 ROHIDHbE1RKrumYJgGFsDm3ugRWs7u79Hz8IaQ0E1u6gBmAdkHeZ1WilZO1qGOpP1E
	 Zo2LwpzlB9wSCY0jpFnSzIOeqseDkbnZQKKtYTN966UqQjxa5hzvpfeWsit0bIohcE
	 2rQ+z1hXBKGNYH5n7QINx4N2jotIvnQH54uPrEh0k54zkuIVP91rx0lXvXBBzGVoI/
	 LGXa8QsRG5XMjAEdeyP+3+2fZFLHhL+uAfHKUwOFF5tnNg7wJlZuF6QKu1u/1YWFsq
	 GtE4744mlyfWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zide Chen <zide.chen@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Thu, 16 Jul 2026 14:50:56 -0400
Message-ID: <20260716185056.1020113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071405-hunk-reflex-20c7@gregkh>
References: <2026071405-hunk-reflex-20c7@gregkh>
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

