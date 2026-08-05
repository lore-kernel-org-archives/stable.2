Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0463E0C4F;
	Wed,  5 Aug 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916264; cv=none; b=f1GiFFsLpTDjEM9fdGi+FxNSPq/ITRSIIAflkuGUzdLVPC8Nkcoi+4Z9Nf8Dy9DQ8yFmmSJa/Yrpsh8mtBbN8klZWKE/Ija7a/qBDZahrgoM6DKB7j9pQa+0XqdIn0QWyXbQK3+LzSA0sWEADkFVTKnPJVOkvssh09YXsfkZIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916264; c=relaxed/simple;
	bh=pW6LONWKn+9k4wzFVYjL3OTPo7tIkw0UEPCVyCNi1fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mjXhdNzvPJFnVjE1cSiTn0KPKyqgBDb52c5VulamtNAiND92I8NAKU/+K9CFAF4vfRScAS0c5NbK6/cb3hfBca8feMePwfCf/WvTFhvsHkQIY1ZaZ3lJEaCYnZlxT47AMJH6h/5K66MkGkOL5X4iW0njquqTdxAVbKOpblcBEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUdDm6PG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BsVEXm1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUdDm6PG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BsVEXm1D"
Date: Wed, 05 Aug 2026 07:50:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785916260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcgKWsf25t1+oz0PMKFIrygZNMqeTTCTDCJgmZ2tfHY=;
	b=bUdDm6PGgZ4H8kxBXcVIOK5l7Tz9Btyiu6hJQ5BkDKj5IQjo1fynoH4ixCQhtXs0bIT/76
	3TvoUBDDfrmUypuA4rMN/EEBPziX8pNnfEBZEu+gGZbaRKQo0j28xlP6e6PhYe2U6gyrVi
	Eye13RJLlDX/1qFkQU1ZDEemSwtXC8qIggRgxbjDAkcDqM5vMJFu+cNkXbiPAapYD56Fg5
	ypeP0l8WWb9pU4lS3HScU/cTEP7dqKOuvcV5q7nbDsTH4swnPgWVaajDIML0J9O5AbRPMR
	2FsDYN0CRudJnppQDnbv5rUj1J5MfNw8aJhuL8hnJqsPJXiLCZgrJVtYPZFw3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785916260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcgKWsf25t1+oz0PMKFIrygZNMqeTTCTDCJgmZ2tfHY=;
	b=BsVEXm1DoLe5IGKcsgcmOUfffwqsy9pBBSwxruDds3L+bwWMYMBK8xSvV3hKdi5MnH8ygD
	FA66gQ+jw1bAjtAw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mce: Set up the polling timer before CMCI discovery
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803-mce_timer_init-v1-1-9539db424330@debian.org>
References: <20260803-mce_timer_init-v1-1-9539db424330@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178591625266.708.5471494787214838709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a213dfaa2596c1c0dc4dae91c14fbfa499c03223
Gitweb:        https://git.kernel.org/tip/a213dfaa2596c1c0dc4dae91c14fbfa499c=
03223
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 03 Aug 2026 02:47:40 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 04 Aug 2026 15:09:25 -07:00

x86/mce: Set up the polling timer before CMCI discovery

I hit the following on one of my machines:

  mce: CPU0 BANK15 CMCI inherited storm
  ------------[ cut here ]------------
  ODEBUG: assert_init not available (active state 0) object: (____ptrval____)=
 object type: timer_list hint: 0x0
  WARNING: lib/debugobjects.c:632 at debug_object_assert_init+0x178/0x230, CP=
U#0: swapper/0/0
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

  ODEBUG: init active (active state 0) object: (____ptrval____) object type: =
timer_list hint: stub_timer+0x0/0x10

This is happening because CMCI storm detection is trying to modify the timer
before latter was properly set up.

Set up the timer first. __mcheck_cpu_setup_timer() only calls timer_setup(),
and depends on neither the generic nor the vendor init.

  [ bp: Massage commit message. ]

Fixes: 1f68ce2a0272 ("x86/mce: Handle Intel threshold interrupt storms")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260803-mce_timer_init-v1-1-9539db424330@debi=
an.org
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2..cfb74be 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2266,10 +2266,10 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
=20
 	mca_cfg.initialized =3D 1;
=20
+	__mcheck_cpu_setup_timer();
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
-	__mcheck_cpu_setup_timer();
 	cr4_set_bits(X86_CR4_MCE);
 }
=20
