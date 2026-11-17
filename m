Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937711;
	b=AVhE+AHaR3VDlUQRuGWacX3pA2OHuOkTH3G1amgb+69Kno3NbdY4e/CuS4u8qRDYQrwF
	 RLEkRdbEi8PJc1KhjgLLFypdJwEQkoVpSGH52g2+BAw/WrPrPJG06ZgbtnjJaz8cVKer/
	 ogGDYSw0+zd5sjR5yWLuh6IwPQFR9SKatndEc6clFQmGGV7pHwQK3Nh2wEvp9Rj4F9Xxl
	 TUmWT0pV16zOjliNcn+GI6OZvrVr87JHrqsGKgClZinxShP0jsUO/fgI6E9Hh6gHFZdDK
	 qOoOFDdweBOeKRronD05Vo2bQYdU0tJJpe96L3SQ6/v3blHHUWfxhv8jHwR/+0lpSMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+0lOfaArNHSPPmLKVZDVKJqfeIkhQfvkVNfuB1PE5lU=;
	b=rslXRrYvx98AXNcuYjV5dtRIJ5t8KlbKWq6OgTnN9UrGEwfS0yHW+0DlMUu8mdefFKSP
	 kEWUwrZ2tIvtVxqv9d3JsyjCMi9dza8ANwszJiNSvqkRVY6yWANuJObK4Q8mw/758tvs6
	 szHktpjkunTLOsxDeqCrpne4wA3SjWb8vxwnTlVhVtroexqtMVFQqpZo4VrmPJSQ7O3pq
	 OORzACYu196okG/Es5N083s13RaMJC1ijA5Hmgq1CB2zwW2rwEfgMQsxK0+5YKDWA3nGz
	 OJ6+RL6ZA9JZg4wd3FeZ7KAKm3NNmUYGk07I1CKIlv7DZCmXO+oeXwvULxuKdgA6hRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J5GTQhV2;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EE6606A884;
	Tue, 17 Nov 2026 17:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9EE6606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J5GTQhV2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C2F21BD0;
	Tue, 17 Nov 2026 09:48:27 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 030353F632;
	Tue, 17 Nov 2026 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794937710; bh=0PN648yUFxoQTW5++i2JEnjRxqyZhkJP38t4f/fNAQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5GTQhV29EDU20Bia7+BY9Zrk7SwV8JzSSxTxEluB6feRtJ38dn1UrYWgZfz9OKiU
	 IZhwhJDHvfFtDmDaJTQuqsNPYihJb1EMPKit+iu0PJB7Q46KFaUfPQyPvmWTzBwvtq
	 Mw7gYSYLfH3psuBvWTuaKgxzLhpJ0Gi9S5n9Me2M=
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Doug Anderson <dianders@chromium.org>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] arm64: entry: sdei: save and restore PMR for pseudo-NMI
Date: Tue, 17 Nov 2026 17:48:13 +0000
Message-ID: <20261117174814.95936-3-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117174814.95936-1-ada.coupriediaz@arm.com>
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
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

If using pseudo-NMI, PMR must be saved and restored on exception
entry/exit. We do so, and set it to a known value reflecting that DAIF
is masking all interrupts, in the regular entry path.

Do the same for SDEI, as it can interrupt the kernel at any point
and does not mandate firmware to touch PMR, but does mandate masking DAIF.
This avoids potentially returning with a different PMR than interrupted,
and SDEI having the DAIF/PMR pair in a unexpected state compared to
the rest of the kernel.

Fixes: 133d05186325 ("arm64: Make PMR part of task context")
Cc: stable@vger.kernel.org
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/entry-common.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cb122163a68d..17a14c55532c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -1041,7 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
 asmlinkage noinstr unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
-	unsigned long elr, spsr, esr, far, vbar;
+	unsigned long pmr, elr, spsr, esr, far, vbar;
 	irqentry_state_t state;
 	unsigned long ret;
 
@@ -1067,6 +1067,16 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
+	/*
+	 * Regular kernel entry saves and resets the PMR to align with DAIF,
+	 * but __sdei_asm_handler() does not ; do it now.
+	 */
+	if (system_uses_irq_prio_masking()) {
+		pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
+		write_sysreg_s(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET,
+				SYS_ICC_PMR_EL1);
+	}
+
 	/*
 	 * Nothing saved the interrupted context's exception registers on the
 	 * way in, and it may be in the middle of exception entry or return
@@ -1110,6 +1120,9 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	write_sysreg(far, far_el1);
 	write_sysreg(vbar, vbar_el1);
 
+	if (system_uses_irq_prio_masking())
+		write_sysreg_s(pmr, SYS_ICC_PMR_EL1);
+
 	return ret;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
-- 
2.43.0

