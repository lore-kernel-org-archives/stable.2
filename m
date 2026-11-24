Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549643;
	b=TVqxhfz/sYV+kDqm0ewWHmixyYNjwunpsxN+CRgg7dgEM/l2wkAhhnQMYDjGfZkg4PKK
	 1CYd6GK5dk1BDuazTh6n2E557dy/i4QRpc8t60BSPFfTyQCMK/83Njv4EJKnK55Dx7t6x
	 ASSRuOgUQx9mSY7167AzEYpYViipWQu58UE1ANwc4UPPfzR8c6wLsp49hWEITuHB4cgpy
	 kysrUfWAgrpuU1tK6LMU3xZTsd4KGtkVGZXvb5l4fNjegNO+Q3qjqiAU2SRTv+4H0Wt5p
	 eT0KmnToThko0YL9/EENpeLuzy01k/FajEZK8g9z19mY+t6wKqPuhgZhodEsO+BznEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549643;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jb7UacLdyzgROEM6VeFj8C1lCP+Li5b9218DpdLXBEc=;
	b=4ObEWU6BLwT7uQtikhXKUNNSvntrXsQuP+EUMCht93y6+mhR4MLN64zeQ7CTCiA0v+k6
	 hCfmqPvmlmv7+8D0IyW0M4zh/paAnurZEMf7EV7L6y3lH0GVaGb8uqAciF6E1ThTMUPEu
	 gQNnU0v0huRZAtJZRkMU5R+URnKypRitBfSkiNlgVgrZ/2WCCuF7B1w6QM7y2gj+pcgZk
	 DARLu0VlDjsyTOiC0lHox13e53esG42FzzQVPFT2/xCPDXNAgiEDsIt2XLaxgujQYsnCE
	 Od+igzvHvAyc/4iR1T3RUxc37+9ZJ2ZsdNIVaFqtIKzu2Tep0aRv+FyNRAKmbt02E2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke7n9tdz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB869606A6A9;
	Tue, 24 Nov 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke7n9tdz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7AD1F000F4;
	Tue, 24 Nov 2026 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549643;
	bh=Jb7UacLdyzgROEM6VeFj8C1lCP+Li5b9218DpdLXBEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ke7n9tdzmh78RWE/vlZb+cPXV5Am6Cyy+xNXTKld/9H1PgV1OOgytyfroznoOcaiz
	 nreVQuF0SWmYrfhJ3eVZNIJa71/TNc9hrEixvhfrsI3qLPFOh6JC7PWGrrL73MTtSV
	 +ZJBzOWmlP1u4KZRdE51Pb+VMqC819ECQWn1y1epSk+lFb0S6wNy8uUC5yNKkLVMHT
	 eh/3SIUa04c/LLl12Qk7FpZkE7l9m68H4k7FJrz66o3uMcWH8I1+1DQyqWTsXw43CE
	 foH82+lKPsNhh2cRvQi/eREsWrIBtQh1NqNB30D/1ixITP/pCOc/hH7bYz3u5DJUj0
	 0rGC7knzTYlxw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5ACE81980047;
	Tue, 24 Nov 2026 14:47:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 14:47:20 -0500
X-ME-Sender: <xms:xekFa0cmu2gUb8M5YJxYK7s8sCMxYvibiLGG3W40q2-VN4Jo4GW3rQ>
    <xme:xekFa0kA-upSFROVy9-3OKa8CkNOj4J6kTWdtM83VLNK7MiQthhOT7d4LN-CWau0B
    JTPv8jjkWJvO7mxy0beNkQOwY59hgK9IImgBIE6hbL98n4O7CS34UmW2w>
X-ME-Received: <xmr:xekFaxhua7X7NHCCrwHeXtuMWatqn1SAQaW-Wiv026GNNERfs8Fi3kmtsdI>
X-ME-Proxy-Cause: dmFkZTF8mK3hTCRd90aqnSvOpCd4gzquwbaRY1ybcFkVdEZH36HujOrk/L6VV6Y1vtNMHJ
    6VVt7i5u8kMpzFTrCKxhljVCQ0KWilRMz8P/2EHJr4WvH0fuZpYQC7sK293mDxYM5fCpxr
    1T3W9hf6dB8LZqtzE4IkJAYo0VMIBVV8zOeHK0H62E2wvN3S7anHOZYKNhLPFJ87IUM61S
    qHy4D0IvnCfOjgesgxbhRacdN4oSj4TucPlCavxmzsp4Gkj0PCKNRZJx/kx70DdCFDXw+q
    7xJwCo/wVwK7Yl9cyU5U0q9sKTnCGo1ZKourJqEYJheN6vPystHS9LyDe6Aaf2u3+CwkI8
    K0JxkNkTYnrafKZ/rTj/3+9Cp9lcsGjXEwFv/7cqddgUQW1JxEbcN2FXocQC6sokP77iTz
    4rFrL77wxX12ppPWSMVZwxp19CXJ0zfLguT3cdPHVkfzezIu+smY5OQy4cfTbZFhJai4jB
    qioc+3L14it17ZZqJ4ZF6Bnn419bRnXUI5OLbowlPINKMA4fFjOlriEYMVbgvrEMVmIGoe
    G0Me4uLkDxVpzwekgnG0s9azudRcd/8aoyRo2FA7cagRqEdCXxQUA4Z/C5Q2BrbWG+Nvx/
    +OoIzYgvtUzHpR22FRjEmXOcLWgi+Kvv0g9Kvv04EWtoKGWbRjR5HU7A/p7Q
X-ME-Proxy: <xmx:xekFa9EGI9L4ahECNeOKy9PLeZNJLwtB0SeRXNELsui-ZeELFs6Fnw>
    <xmx:xekFa4zOf4H4XkBgNVEFRyaEqZGefgnS87-IiO3iXpUh-wAp0q-6TQ>
    <xmx:xekFa8ptG5LFDO8P2LynCZIsBDBtiu_gC354pp1S3Bi3FyMHFmG2dA>
    <xmx:xekFa7dIQ7vp6XFCWc-hwYoO9-kQslgtqXxz4YU-ZIH-o1qvT7-nJA>
    <xmx:xekFaygRgIctcxYKCfXNpWhmSCYbso94vTf0CMNuc6xBx11D26g_Z-wE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 14:47:17 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Cong Wang <cwang@multikernel.io>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] firmware: arm_sdei_nmi: Send the backtrace IPI to CPUs with SDEI masked
Date: Tue, 24 Nov 2026 19:47:05 +0000
Message-ID: <20261124194707.1030653-3-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124194707.1030653-1-kas@kernel.org>
References: <20261124194707.1030653-1-kas@kernel.org>
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

sdei_event_signal() refuses a CPU that has SDEI masked. An NMI
backtrace then gets nothing from such a CPU and, after 10 seconds,
reports it as not responding.

The CPU is in a power-down idle state or going offline, and the regular
backtrace IPI wakes it. Send that IPI to the CPUs SDEI refused; every
other CPU still gets event 0.

A stop needs nothing extra: smp_send_stop() has sent its IPIs before it
signals SDEI, and a CPU still online after that is reported as not
stopped.

Fixes: 0c2c56598cc1 ("drivers/firmware: add SDEI cross-CPU NMI service for arm64")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/arm64/include/asm/nmi.h    |  7 +++++++
 arch/arm64/kernel/smp.c         |  2 +-
 drivers/firmware/arm_sdei_nmi.c | 21 ++++++++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
index 2e8974ff8d63..447d681a5475 100644
--- a/arch/arm64/include/asm/nmi.h
+++ b/arch/arm64/include/asm/nmi.h
@@ -45,4 +45,11 @@ static inline void sdei_nmi_stop_cpus(const cpumask_t *mask) { }
  */
 void __noreturn arm64_nmi_cpu_stop(struct pt_regs *regs, bool die_on_crash);
 
+/*
+ * Send the regular backtrace IPI (an NMI with pseudo-NMI) to @mask. The
+ * SDEI provider uses it for the CPUs it cannot signal. Defined in
+ * arch/arm64/kernel/smp.c.
+ */
+void arm64_backtrace_ipi(cpumask_t *mask);
+
 #endif /* __ASM_NMI_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 014b163ce658..8369a4cd3e32 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -946,7 +946,7 @@ static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
 			__ipi_send_single(get_ipi_desc(cpu, nr), cpu);
 }
 
-static void arm64_backtrace_ipi(cpumask_t *mask)
+void arm64_backtrace_ipi(cpumask_t *mask)
 {
 	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
 }
diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
index edea68ef881e..b8ebb97caf18 100644
--- a/drivers/firmware/arm_sdei_nmi.c
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -124,7 +124,7 @@ static int sdei_nmi_handler(u32 event, struct pt_regs *regs, void *arg)
 }
 NOKPROBE_SYMBOL(sdei_nmi_handler);
 
-static void sdei_nmi_fire(unsigned int target_cpu)
+static int sdei_nmi_fire(unsigned int target_cpu)
 {
 	int err = sdei_event_signal(SDEI_NMI_EVENT, target_cpu);
 
@@ -133,8 +133,13 @@ static void sdei_nmi_fire(unsigned int target_cpu)
 		pr_warn("SDEI_EVENT_SIGNAL to CPU %u failed: %d\n",
 			target_cpu, err);
 	}
+
+	return err;
 }
 
+/* CPUs to IPI instead; nmi_trigger_cpumask_backtrace() serialises its users */
+static cpumask_t sdei_nmi_ipi_mask;
+
 /*
  * Raise callback for nmi_trigger_cpumask_backtrace(): signal event 0
  * at every CPU still pending in @mask. The framework excludes the local
@@ -151,8 +156,18 @@ static void sdei_nmi_raise_backtrace(cpumask_t *mask)
 	 */
 	dsb(ishst);
 
-	for_each_cpu(cpu, mask)
-		sdei_nmi_fire(cpu);
+	cpumask_clear(&sdei_nmi_ipi_mask);
+	for_each_cpu(cpu, mask) {
+		if (sdei_nmi_fire(cpu) == -EAGAIN)
+			cpumask_set_cpu(cpu, &sdei_nmi_ipi_mask);
+	}
+
+	/*
+	 * A CPU with SDEI masked is in a power-down idle state or going
+	 * offline. The IPI wakes it and it reports like any other.
+	 */
+	if (!cpumask_empty(&sdei_nmi_ipi_mask))
+		arm64_backtrace_ipi(&sdei_nmi_ipi_mask);
 }
 
 /*
-- 
2.54.0

