Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016562;
	b=1CO/RBKNHa86cx4pUhBDrI5SNftttrdPG3ITg6xA08k1rfkBu261AVCm3SlCwx4Y8Ryw
	 BkekEVNdblPJwFQWXVwv5Lt7ISR2IGa47k8lhDQUS67bTzy8hYfs96e7212LI4K/ri6uZ
	 wfIyEr2eTF+aDmYHQl85PwcxwQ6YTp5ZqJy5n2mQrnFrN4vXnhhtvYqQ3qAmKLFtaeUSY
	 s+B+CPl1Xt3TTVyKzFMbIhZWw70EFI7WRtB+lhWoUovcTWX+aRSYtwPvE4aKneoFXaiRY
	 u8S+A+Umr2I8bfMgjXhyHe8DQbqiCrd9O2YfIyBNkaxAzIEcXK8itTd/FS2UmBgHk5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016562;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXoVU+zyzO/JVGmjx8QpobF+MHN6a8i8PV7wuxZRA8Y=;
	b=wMKXrCYy1f9tA9uYQfzTMZPG1hvhFQZTCkKKZiAjl8Ch/zP8ZeQeddRUNcgo8jE6pFLH
	 cMX8MOHH1sbXlgxJ/H2KUFgnrAjgme4iKS7nmN77BOlpCuN1SzRwACzi5dEXkSN0YjWk5
	 6KxMBHpq5HLZtqg979u1CNl4xl7LbaLJjwc8HEPEUpJ/VPMFFQiG9PbTqaCIu5lh8gysJ
	 xdHunvkoSuxlDMCcAZx1CKXrKIaMU21sybbaCpZffL8xsNtT0lgjcXup9ZqCttAwo2QDg
	 2wfJoqHWGLZGhp+we3ATh0QODtJeBKSy5uEpczxMAIck9nomnQ4sJy3vSuh/qJm1+aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e07SLl5k;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A56606A333;
	Wed, 18 Nov 2026 15:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A56606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=e07SLl5k
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B80F339;
	Wed, 18 Nov 2026 07:42:38 -0800 (PST)
Received: from e137867.cambridge.arm.com (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 075293F632;
	Wed, 18 Nov 2026 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795016561; bh=+tCwHyaMbDnFYKCMMHM4gMAYD6cSQpaChWqSWXyJq+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e07SLl5kVNB3CtW+vgqxR4VZKtstwTke+UCp6+TtNjlxNQkBYg+EI9GI4OrmAv3KB
	 1WvzVduXvNDEE109iCWEA7mv54+Sv+EiyVsHyOykiiiGGD93DeQJxISnHpev2r4lBp
	 n41QOEYCPym7yG5tw49nGVCtHm5acpXX5XbmArYw=
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
Subject: [PATCH v2 2/3] arm64: entry: sdei: save and restore PMR for pseudo-NMI
Date: Wed, 18 Nov 2026 15:42:33 +0000
Message-ID: <20261118154233.83599-1-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117174814.95936-3-ada.coupriediaz@arm.com>
References: <20261117174814.95936-3-ada.coupriediaz@arm.com>
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

