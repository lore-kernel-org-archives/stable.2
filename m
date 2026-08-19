Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701D4078E2
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166538; cv=none; b=bM9OwRak0/nFWPislryR47Fqp8fMa3PEJc16zN8TjL5sohBveQP/++tjuFepupXyHO1aNzBxXKtmt0Jt0AFV1J8fhte/4sogFpZG8QG78AWFYWUfu2pPUZWmbHCYuBzZlec+y95LGvRi1gaOKkiNlieEGggYAgVqsUK7ertA+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166538; c=relaxed/simple;
	bh=91BkZM/TWBQdXsooPw6P7aDyiadno6+ubA8IE/leZEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTvAy3bkhQl3QtBeB2o50OcI+Frt34sWzGrPJiyYyJv5VfEzgO0oWmmXe2ZKm9aL80ZzMC6vV09yUKg+ezTUjwnC87UavsCob0oVMG6D1R7HMy/BAj52f7sck3FGdmeJOdsu8Ccywy93B25cAhhI04bMdJuq+W+Sz95zmCKVvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjsRhOZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjsRhOZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400211F00A3A;
	Wed, 19 Aug 2026 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166536;
	bh=1WsEZv7Esh99B3RYOmVSBgZE1V2A9KNRNhjAnvlXRoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjsRhOZlltL9UT0JQMwZZ4Euxo/4JoR4afnJeC/Ex/wPsxrD4eWvjMmKzRbfjz0Qp
	 rWGBk+KBgYYE1pNnmytowalcEs940Fi41diXNyAGpDc4nDe28N5FpsS+HerjBN5eY0
	 M0swSdHv1G0SEMGRf2G5kGUOgp2XimbYu50yNnQk4GtM8E5MoxLGvaSaAbqvODqvLk
	 GfpCYZEGs+gHJ3rbAiOa/td2QHz1Y8RpMI+kWguvYiSffjIAXz3dPYlGRNmaIuEHXB
	 c8ftAX053KhFWMuliGAkPzf6nSAFL6Og7YycHGDUi+CrSZIqeR+lS9J51qPjKv1f32
	 /XrzU3Vr0Hlpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] x86/mce: Set up the polling timer before CMCI discovery
Date: Wed, 19 Aug 2026 15:08:51 -0400
Message-ID: <20260819190851.563607-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190851.563607-1-sashal@kernel.org>
References: <2026081738-avert-freebie-72be@gregkh>
 <20260819190851.563607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit a213dfaa2596c1c0dc4dae91c14fbfa499c03223 ]

I hit the following on one of my machines:

  mce: CPU0 BANK15 CMCI inherited storm
  ------------[ cut here ]------------
  ODEBUG: assert_init not available (active state 0) object: (____ptrval____) object type: timer_list hint: 0x0
  WARNING: lib/debugobjects.c:632 at debug_object_assert_init+0x178/0x230, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5 #3 PREEMPTLAZY
  RIP: 0010:debug_object_assert_init+0x18f/0x230
  Call Trace:
   <TASK>
   __mod_timer
   mce_timer_kick
   cmci_discover
   intel_init_cmci
   mce_intel_feature_init
   mcheck_cpu_init
   identify_cpu
   identify_boot_cpu
   arch_cpu_finalize_init
   start_kernel

A second splat follows right after, from timer_setup() finding that same
timer already queued:

  ODEBUG: init active (active state 0) object: (____ptrval____) object type: timer_list hint: stub_timer+0x0/0x10

This is happening because CMCI storm detection is trying to modify the timer
before latter was properly set up.

Set up the timer first. __mcheck_cpu_setup_timer() only calls timer_setup(),
and depends on neither the generic nor the vendor init.

  [ bp: Massage commit message. ]

Fixes: 1f68ce2a0272 ("x86/mce: Handle Intel threshold interrupt storms")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260803-mce_timer_init-v1-1-9539db424330@debian.org
[ kept 6.12's `__mcheck_cpu_init_clear_banks()`/`__mcheck_cpu_check_banks()` pair instead of the merged `__mcheck_cpu_init_prepare_banks()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c95698dd648ac..01a17e729a80f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2251,11 +2251,11 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
+	__mcheck_cpu_setup_timer();
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_clear_banks();
 	__mcheck_cpu_check_banks();
-	__mcheck_cpu_setup_timer();
 	cr4_set_bits(X86_CR4_MCE);
 }
 
-- 
2.53.0

