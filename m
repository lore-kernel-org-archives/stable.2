Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF605412272
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970806; cv=none; b=A+mszmI7U82CFi8QU3ooD3EuS+oDLH01WT9//UeO2xFf+sZYsmxjdybD55jMPwf6VfpvcNM/haw2KL6cJXCYlBtYLcsh+F6HWFDkafFXZXuip3B0Co5ue5iKW2HAIiLOEiPPcg28g9bT/wl707kk+Sq3DHy/KjRWg23N50eVz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970806; c=relaxed/simple;
	bh=wiK3bzeuvuPsfR/R3UQyyR6lxPlWRvdW1Ac0XJY2dGM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fw7fTv2Pt+yiEnxf9blXG3SJfszTtCtNp1mW4etwu7jJ0WNyyTC20q2N/Wn6hXAWdkKSQsRxB++mFnFf2Kdm3K5k1fE/7DQTKKDU29DqcWg3QSQndw14Kc340joauF3GvhVzoYzqNmIEKYBPl+bwyg7CNzuf90mheqGfcedqtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pv0lYUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pv0lYUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3601F000E9;
	Mon, 17 Aug 2026 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970804;
	bh=eL/Y0/WnteRQmlz7calkoOoEZeShZ7OTOgCm9klpR1c=;
	h=Subject:To:Cc:From:Date;
	b=1pv0lYUYNdHpXPCBxCfs55cQ0XNmOV+ce+Fh/HkyCZa/PVdnsTC53Lb4Siln1s9os
	 CBDKgzOWE9S+ZN7NASxl2/RjlptpkjEyRfrq04z9LKaaa4VE3491070In2zGimntqD
	 2E9Hbd+pxyBHGt7xSAyS1wnH7ShzB9vLwJPY1srs=
Subject: FAILED: patch "[PATCH] x86/mce: Set up the polling timer before CMCI discovery" failed to apply to 6.12-stable tree
To: leitao@debian.org,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:46:38 +0200
Message-ID: <2026081738-avert-freebie-72be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a213dfaa2596c1c0dc4dae91c14fbfa499c03223
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081738-avert-freebie-72be@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a213dfaa2596c1c0dc4dae91c14fbfa499c03223 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Mon, 3 Aug 2026 02:47:40 -0700
Subject: [PATCH] x86/mce: Set up the polling timer before CMCI discovery

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

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2f03af..cfb74be19994 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2266,10 +2266,10 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
+	__mcheck_cpu_setup_timer();
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
-	__mcheck_cpu_setup_timer();
 	cr4_set_bits(X86_CR4_MCE);
 }
 

