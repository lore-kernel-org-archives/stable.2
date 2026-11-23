Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454169;
	b=X+uPhuMoYhmgAxUv5sMKut13/hf0adrnxbyMe+PIXX2cwF5YEveu4jkMdVNlJ9u8cNL4
	 59mI8wup77YLEBysPEcsGy4ICSRXeoIgd4c1xTncatg8wHR8OrEVndQ6etpJX4rhlMXmo
	 W7VwFW1lc8p1cSeXu3/3OyMZfj4E0hJxAGT2o1rvqoapnFIwolr79Ega9dTq6HtJazwgG
	 ckSHWdZthaPtZqnGMKNuo75TfLuXdoSB3zId6TD/SKmK8uSwgoA7rw7KPDXLOBLUZLNjx
	 bHTuKtuINAyCKqWDvDYun7AD7Ut4EzHwmauZrVMqq5ozvqIpy8lqX0EI/i3ZlS7agOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454169;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ya6v0UyKzX4mmCXRtci1TvYwloWMFBhWYhOd/yqiouQ=;
	b=ttQdtTK9R0hXFKj7N9K4hYxeNz7MHQDiLLrUFvpo9HYX963I1TOWnFKSRtEtJiBQHCN8
	 E9bB8pPbhJ2cCUSXgKrZC3aDAPK2nsh66YQJCL+n51R6XQTjqGYz6/NosIfXkdC10Ut9l
	 sqGBoQY0wPYUC6Du6lwrZkOirOYMjp5uGXPqSMcr+uiKJyg4NWiC6Z8um0BP2+pDfUM09
	 FkoZIppZ38mH/2wilBqqWL8pwSnbBLCgdHCW9ow/Ui7K/d6IztSXD0SLue7wZpo7qfglT
	 ocZMqGA8A7r6mWjpRUQAoOvI0qHtoK5AMxlqQybUyaYaCaZs2elhqF9oy7eT0SQCHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O0QnIOfk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00013606A32C;
	Mon, 23 Nov 2026 17:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00013606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O0QnIOfk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53586176B;
	Mon, 23 Nov 2026 09:16:05 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 870AC3F763;
	Mon, 23 Nov 2026 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795454168; bh=LFtDzB/okrnQHH291WRp6toxRg+swNwN8gcOpZd7uFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0QnIOfkL73MNoc91NYxTAD9VVYpv8ma/GCrN8yHd55fA8kVyYwGHRJBz2Q66uArH
	 ISKQvISI9h+0x2jCkTCVGx2Tt7lbgJT22BHox58wgqTQ2m7D1nUkyyd8AKgr7TpeRk
	 7SJGdZVWmDqQhZfU+6XvkfWcGn5hY1txFhlDZk7Q=
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
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
Subject: [PATCH v3 1/3] arm64: entry: sdei: always set VBAR_EL1 on SDEI entry
Date: Mon, 23 Nov 2026 17:15:55 +0000
Message-ID: <20261123171557.140944-2-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123171557.140944-1-ada.coupriediaz@arm.com>
References: <20261123171557.140944-1-ada.coupriediaz@arm.com>
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

SDEI can interrupt at any time, so we cannot guarantee that VBAR_EL1
points to the kernel vectors.
Unconditionally set VBAR_EL1 to the kernel vectors on SDEI entry so
the SDEI handler always runs on the correct vectors.

Commit 9bf6ee7952c7 ("arm64: sdei: Run the event handler on the kernel
vectors") sets VBAR_EL1 to the kernel vectors when KPTI is on
and it still points to the trampoline vectors.

This is only covers the KPTI case, as any other VBAR_EL1 value would
not be changed, while pointing to the wrong exception vectors.
KVM in VHE mode would be such a case as, in VHE, VBAR_EL1 is an alias for
VBAR_EL2, which KVM uses for the hypervisor vectors when running guests.

Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
Cc: stable@vger.kernel.org
Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/entry-common.c | 25 ++++++++++++++-----------
 arch/arm64/kernel/sdei.c         |  3 ---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index beb56891fc4f..cb122163a68d 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -1079,19 +1079,22 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	far = read_sysreg(far_el1);
 
 	/*
-	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
-	 * EL0 until the next exception from EL0 maps the kernel. They only
-	 * handle exceptions from EL0: an exception taken here would run their
-	 * empty current-EL half and never come back. Switch to the kernel
-	 * vectors. The IRQ-like resume keeps using the interrupted VBAR, so it
-	 * still goes through the trampoline.
+	 * As an SDEI event can take over at any point, VBAR_EL1 might not allow
+	 * us to take an exception safely :
+	 * - With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
+	 *   EL0 until the next exception from EL0 maps the kernel. They only
+	 *   handle exceptions from EL0: an exception taken here would run their
+	 *   empty current-EL half and never come back ;
+	 * - With VHE, the kernel runs at EL2 and VBAR_EL1 accesses VBAR_EL2.
+	 *   KVM might be running a guest and switched VBAR_EL2 to the
+	 *   hypervisor vectors.
+	 *
+	 * Switch to the kernel vectors unconditionally and restore
+	 * the interrupted VBAR_EL1 before returning.
 	 */
 	vbar = read_sysreg(vbar_el1);
-	if (arm64_kernel_unmapped_at_el0() &&
-	    vbar == (unsigned long)raw_cpu_read(this_cpu_vector)) {
-		write_sysreg((unsigned long)vectors, vbar_el1);
-		isb();
-	}
+	write_sysreg((unsigned long)vectors, vbar_el1);
+	isb();
 
 	state = irqentry_nmi_enter(regs);
 	ret = do_sdei_event(regs, arg, vbar);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 1b902da8ba43..1027138ba5b4 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -255,9 +255,6 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 	 * exception registers; __sdei_handler() puts them back. Only the last
 	 * one's syndrome survives; report it if it is not one known to be
 	 * harmless.
-	 *
-	 * If the event interrupted a KVM world switch, VBAR points at the KVM
-	 * hyp vectors and any such exception is a hyp panic instead.
 	 */
 	nested_elr = read_sysreg(elr_el1);
 	nested_esr = read_sysreg(esr_el1);
-- 
2.43.0

