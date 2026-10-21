Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609443;
	b=CD4K1CGnCGL9Nacl/AXZNVgPFX7+T2W91VHL97ay8B6UDegKtdYhKA4Mg6x6perfznur
	 t3LnzSIrhktWRxTTt/m9hCuZJx/eo7Zt9o2dp40Cq9BE1zpxOYQGUth3Y9mjbcUQjJI8l
	 c6fdihMW0fbxr6WtHYfuxlHlzFs6Bq46ZXFfODC8V8PwlN1Y9hA2B+UMxSrte/TZkGpfl
	 W5u27VZ7eHwH5crMD8VjODvWgwX4RaApj6d4ZOPW2lxcZoRtQmshYixl8Rg1N59zotW/k
	 +khIlMZDodexD3gH1edNp/RJmRUb9TYR5P3gBCDP+i94Q5K82J/NQskpsc4lJrXfN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n8U3NPb6qJjh33S8/t0CTqr/1TXqpv+wOJ21D7k9Jjk=;
	b=UC1j0QhC82yCcKwzGBN063p3GzRg7C69oW/KBlunRdFssY+UclE8TUQ0TE96exQ4WFGm
	 AKTd2ePCeRm87Sp0xdfIiPyC+LAA1M+S44xZviv9to042h3xJg6SRTGlyZLb1XaOhWd+C
	 PWECW6V0LFpJnmxo+eDM+EF4KdAITSFJj4m25cUOdq06V5MfK46DxAi2rn/5fpkjBSAlD
	 1wzE2hcVEk/98bpdNRT0t83hm+fsMcbTB1vnb5KQhLgVgE3B1SD+E/mOI5yvaWpHktDxD
	 usI8S3FkcSMURseN7eMJh24KUvAWeHz++zkoZ47iqiNXNA2Z+qKWuOnOCEc4DySF6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iF4rFlar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB02606A319;
	Wed, 21 Oct 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iF4rFlar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EDC1F000C1;
	Wed, 21 Oct 2026 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609442;
	bh=n8U3NPb6qJjh33S8/t0CTqr/1TXqpv+wOJ21D7k9Jjk=;
	h=From:To:Cc:Subject:Date;
	b=iF4rFlarNDUzt0Pu+RPkNWNasD01VPEbRg3XHxJCU9XoxEt/De8/bJlnPQIAcq3hv
	 pkzF+gssYeGtkih9uVBCCSofWTm9Pl8/2Ivr55M6Z5MhxShUNzi10H1zpFaLhEfYq5
	 fmMWO56djQgCNELQA2dDdSF6HcWZvncx+bQwV57gOZGTcADHryIgcZade9FpdH49LL
	 +bt5HaX425QuppusFjKSz+53P5RrJxv2RwxiUa1R4GzDkWx/sQBarGn7vEop1bV4QG
	 vBjNkMgKnOop22tkYOqfTNtzvkmgC7Oiz4fkyqmRkspuaGQRi9dVbhWB8cDdEer63O
	 am2V/0FVcaVgw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: SGI-IP27: Install the cache error vector on every CPU
Date: Wed, 21 Oct 2026 21:02:53 +0200
Message-ID: <20261021190253.30128-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hub flips the low 128K of the CKSEG1 (attribute 0) uncached alias
per CPU slice, and the cache error vector is fetched through it.
trap_init() writes the vector through TO_UNCAC(), which is not flipped,
so only slice 0 sees it. Copy it to each secondary CPU's slot as it
comes up.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/sgi-ip27/ip27-smp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 62733e049570..0fef66b86959 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -7,11 +7,13 @@
  * Copyright (C) 2000 - 2001 by Silicon Graphics, Inc.
  */
 #include <linux/init.h>
+#include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/topology.h>
 #include <linux/nodemask.h>
 
+#include <asm/addrspace.h>
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -133,6 +135,18 @@ static void ip27_init_cpu(void)
 	per_cpu_init();
 }
 
+static void ip27_init_secondary(void)
+{
+	/*
+	 * The hub flips the low 128K of the attribute 0 uncached alias per
+	 * CPU slice and the cache error vector is fetched through that alias,
+	 * so the copy trap_init() made through TO_UNCAC() only serves slice 0.
+	 */
+	memcpy((void *)CKSEG1ADDR(0x100), (void *)TO_UNCAC(0x100), 0x80);
+
+	ip27_init_cpu();
+}
+
 static void ip27_smp_finish(void)
 {
 	hub_rt_clock_event_init();
@@ -182,7 +196,7 @@ static void __init ip27_prepare_cpus(unsigned int max_cpus)
 const struct plat_smp_ops ip27_smp_ops = {
 	.send_ipi_single	= ip27_send_ipi_single,
 	.send_ipi_mask		= ip27_send_ipi_mask,
-	.init_secondary		= ip27_init_cpu,
+	.init_secondary		= ip27_init_secondary,
 	.smp_finish		= ip27_smp_finish,
 	.boot_secondary		= ip27_boot_secondary,
 	.smp_setup		= ip27_smp_setup,

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

