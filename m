Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F263B42CA;
	Mon, 22 Jun 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135684; cv=none; b=YYB/eeaG/HwbF/+gFXGluQjwqcYioiQNDuZ5g+dGl2cxefwZc+TZ2LM+UGo34p/nx2Mx7ENJ4F6v0AQ2mCBBMrGpQpCx+8acdjDQNdY06Uo9jQAm5R3YZGUd6DbKcPNIDkqpm8iD5Hc0KgMoz7SEMviszd7BVZ5Y4LtV240vAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135684; c=relaxed/simple;
	bh=cxNl4o4YUNSUu4iQF9bff2jEaTCjZCpm0GuAKTj2dmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edgow3TYO7nQpMjKuGJvXD3JMwpl06g5EyERxjPT59AdCyf7ISr+3cvVEXbCBCBb72vo0iVrsAhE0UHUvAqlN6hPlmv9/Kek2x1+QB+u3bTBsxON8bZxPq5zYIBmOFocPxnhjMhJm57P1z5SjWpnJ9xKJ89i7mYhWPEnkP8PS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbM9xf6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbM9xf6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18A1F000E9;
	Mon, 22 Jun 2026 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782135682;
	bh=T7IOqd5vkEyp4/rz10IqEF6M2s/kC/BRz6fwpkX+S3I=;
	h=From:To:Cc:Subject:Date;
	b=PbM9xf6UqoPjgC87DNGdi3C2LHB9ff3CYceewfd/HMbPKjO8ytXjPxQXeaxZk1xhq
	 POaCH2DFAtHbRrmu9rXLft6vxOvYt5ldyL4iD/VEMHLPtYTpx69c4iqj4dtaTuj0Z5
	 4UJRsqEFpPSBrBLjr5mEq9WwWp1X7am6BcX0FurrFnNNrdOJM4GrrhFoZ4WeIgI5AH
	 vwACI4uv4QgH4hOBnSBaNZpHKzZ+rFN7nICj4ai3pmypdrK/iRQg3bz2uEIzPNUVin
	 KrwG2AZP4Ev1M9IqfJAEYArY1Cql0/KbY5tG5AzgUsFkGwt3/8xiBHje92E58TsbJ0
	 UF7+4yHiKhHTg==
From: Guo Ren <guoren@kernel.org>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	samuel.holland@sifive.com,
	tglx@kernel.org,
	bigeasy@linutronix.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH] riscv: Report dying CPU to RCU in IPI_CPU_STOP
Date: Mon, 22 Jun 2026 13:40:18 +0000
Message-ID: <20260622134018.817508-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

This is a port of MIPS commit 9f3f3bdc6d9dac1 ("MIPS: smp: report
dying CPU to RCU in stop_this_cpu()") inspired by the Loongarch
mailing thread.

The smp_send_stop() parks all secondary CPUs in IPI_CPU_STOP, which
marks the CPU offline for the scheduler via set_cpu_online(false),
but never informs RCU, so RCU keeps expecting a quiescent state
from CPUs that are now spinning forever with interrupts disabled.

Please read the MIPS commit mentioned before for details.

Cc: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>
Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index fa66f9c97d74..0a73b36be825 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -82,6 +82,7 @@ int riscv_hartid_to_cpuid(unsigned long hartid)
 static void ipi_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
+	rcutree_report_cpu_dead();
 	while (1)
 		wait_for_interrupt();
 }
-- 
2.43.0

