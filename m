Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454172;
	b=EassNJyo/EOd81hFH3/0VlyAHq80bT2/GKBeIsKBhL7yB2P9pQvGV1ySvHaF3A4yLvmt
	 4VMfRHQuwK8kLRnkM/8xXshPD9gbhrTE/M+rYId+dSYYHL6Thicm5TYOVgIjO5oNBIJ30
	 3p5qS+uGKwFiBCEBLzDFLIxLktM3rRe9sVjgmY8YOM5zV0QlZzxj1rCkxP8E6W+2AGry1
	 a5bgzq7daCK8wsrzXXQeANMGSxPtIL7axz/8aBBwo8TREzwgTA/pMdWVVawpott5wGpcK
	 BE2Zg14LPlGF7JZPuFYwsf8PxkxiK3SshZjf3Zge85C9i/hKNIEtHoY4dFGdgGWZdoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454172;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXoVU+zyzO/JVGmjx8QpobF+MHN6a8i8PV7wuxZRA8Y=;
	b=D2czWkQiFayslCrjwVY0LWCdbU0HeGUgXH7JTtC8SsKx4GfFfI8thrq2ov9F1tOXwLcp
	 /zpY3ps+wlz5vLj64S2GigAC6lV+0wncIfR86WVE9XWrIJp4jAniQ94AZIniNH7JpocFE
	 sxuI3RifFThDwBzZhqMES2gN6YGzaJ0If6J37d9ntfw3VBlafl1fxkgz7QcRStIQPt0OE
	 YmpEBb3hxQGKGkTKBMRy6VeSKOQT5d5Jue6TxTBZbXwUYAdI8pOTHuD5n3hysF0J9etmy
	 jDu8eDrLscTJ+fkc8OkrvID0bwU3cDbpxdYzMIcDnEQ5Lc/3fTmVLdxkr80qkQH6Jzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O6Br+14B;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE030606A334;
	Mon, 23 Nov 2026 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE030606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O6Br+14B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D5AB19F0;
	Mon, 23 Nov 2026 09:16:08 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 824AE3F763;
	Mon, 23 Nov 2026 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795454171; bh=+tCwHyaMbDnFYKCMMHM4gMAYD6cSQpaChWqSWXyJq+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6Br+14BuoEfTrQNtHyzIzXyi+iiUWwSrLBgp4Y7EJQ6wtdQtszN3OgcTbiXIC70A
	 /AS+awE8Xr1edg3/kuvabZSQwTRddLx3HB2uCelcDQZgF8oRs/b94al+1eLIULyxZ+
	 iWT1X9CzshlF4qDjA49BHXU6aqavoHA6+x2LG4v8=
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
Subject: [PATCH v3 2/3] arm64: entry: sdei: save and restore PMR for pseudo-NMI
Date: Mon, 23 Nov 2026 17:15:56 +0000
Message-ID: <20261123171557.140944-3-ada.coupriediaz@arm.com>
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

When using pseudo-NMIs, the PMR affects if IRQs are disabled
and is not updated by the CPU on exception entry/exit. It must be saved
and restored to/from pt_regs, as the DAIF bits are, so that
`regs_irqs_disabled()` can reliably work with pseudo-NMIs.

We do so in the regular entry path, and set it to a known value
reflecting that DAIF is masking all interrupts.
Do the same for SDEI, as it can interrupt the kernel at any point
and does not mandate firmware to touch PMR, but does mandate masking DAIF.

This makes `regs_irqs_disabled()` reliable in the SDEI handler with
pseudo-NMIs enabled, which is critical as the return path to the kernel
depends on if the interrupted task had IRQs disabled or not.
This also avoids returning to the interrupted task with a different PMR
and a possible DAIF/PMR mismatch, as expected by the rest of the kernel.

Fixes: 133d05186325 ("arm64: Make PMR part of task context")
Cc: stable@vger.kernel.org
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/entry-common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cb122163a68d..91afd1a36ec6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -1067,6 +1067,16 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 	else if (cpu_has_pan())
 		set_pstate_pan(0);
 
+	/*
+	 * Regular kernel entry saves and resets the PMR to align with DAIF,
+	 * but __sdei_asm_handler() does not ; do it now.
+	 */
+	if (system_uses_irq_prio_masking()) {
+		regs->pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
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
+		write_sysreg_s(regs->pmr, SYS_ICC_PMR_EL1);
+
 	return ret;
 }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
-- 
2.43.0

