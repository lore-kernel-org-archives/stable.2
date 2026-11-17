Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937707;
	b=TABJudZhyHFaBDNr8/wDduJXGfD9OvH4v5p8NzSeaxdSIRZBHOFLaVNHvnlavFrxmAxG
	 qAhliTZPTfaye4b3LpR+7CED3oVx6/z/xfB40zc3d3qdebOhKxDv+55K5TPL3fClMeIt2
	 gx7eEJiNwF1SqqGnB1How0ZIX64ElFDLaolLG9vEkqX1vO96p/DhAU0QaxAGvrw2PEXib
	 ykrEFZThPJDlz1Ggc6B2056GhJtFfj6l2d502VcwgExaSN2ltzPO0Dm83E96gY069/1XM
	 pM+LFZUJUctIh5yAqsvKfyhwmh+slnuXjPd3/TohLKk2XdUwoG7r0ScQH4pjspoCwNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937707;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xZPkTs2PciItdtjhjdoxtbfKcAnAHUD0fc5OCQIMaKQ=;
	b=R+ir8HGn49sgfpktQ4LGWzRJyc7bAzF6NtAZnN2QiMExrqO24FFwc2wOpDCDcWE8kD33
	 H3oWZByQz99jPOFzkRPnxoitGCe6kjoY6gu9fPXK0pfZfaynn7ENXK4XDUW/XdrAJEXX7
	 Ny+kHg0ST/14Rlk/c2NrFMHzSEtb0nFmjhcpqIdw7l6lMp836Ii/0Tc2Jznb7pSYW0oUs
	 5C90WBRfTYYdiUyJ7uUlKFIh+PhV/avDGkGU20i0okUAg8SMEr975lQky97daE4uVvuSD
	 qFETHDXkyhC6/puiBfh7MyhM37hepZjsEKEBZkCzPZ9zuOIrDhK2NmIPX9HzhqojZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="A5z/wg6V";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4D606A332;
	Tue, 17 Nov 2026 17:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA4D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A5z/wg6V
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2B0B1A32;
	Tue, 17 Nov 2026 09:48:23 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF0A63F632;
	Tue, 17 Nov 2026 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794937706; bh=7PIC3PDMqrlBZ0mHhY/p6avIINTftQj7nZ6BHmw1YMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5z/wg6VFmntekH8636Oc4TE84/Y8Jv5WuG6Fyb5jBXWj+UqOtF54C7YxWEQ95b/z
	 XFlGlRQugLx+s6POr6ZH4RlrSGJPl7qHPd2uDnd+mxIwVOwJRcV43RUyB/GIwH1JT/
	 YnqJbWg35N+aNfNU5GZnPAQG1vszfzuty7urBIn4=
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
Subject: [PATCH 1/3] arm64: entry: sdei: always set VBAR_EL1 on SDEI entry
Date: Tue, 17 Nov 2026 17:48:12 +0000
Message-ID: <20261117174814.95936-2-ada.coupriediaz@arm.com>
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
 1 file changed, 14 insertions(+), 11 deletions(-)

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
-- 
2.43.0

