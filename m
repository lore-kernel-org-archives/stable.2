Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3333E8681;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401176; cv=none; b=FuhULvp8oKAHcD48C0wj5oVgObe1nHp3Ak6zMvSPY1Lbgm/BUdBqEJHST83KOyQ/H8TGIspTJSEV07bWBTu0j7PhjSM6SVPCd9lFDrI/hARBLxV0Xq0+/17oraHSH0SegBDR4+feq1+d/MI3SCMRztT53XbLQNADjlMBh24Ey4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401176; c=relaxed/simple;
	bh=VvCRoywPaJN03UXc+yux5HyUvRBNxrewjaj911kEqQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reN+tvX/wbWq4H0dVtUygC1udy1euBJRpEOXDoelVKVhaWOrhs3zCfi8kBjALxvFl06FBjVV8Oej+FY9kbu4v3jB5yGb7edzzmSpV/Q7hJyGq6TW/5zkf+ZXymIrXKhqPW/lMZpzkiRQWyM0M+fZ01THD+lNWYDo60ZGoU3mepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=feYw0QtE; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="feYw0QtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401172;
	bh=EPEc1pvNNTn4Dvd2PhEVJBYnnhjseBlAaeLSgmHJr6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feYw0QtEnBuwHcM8rR/iTMN8OLs8uoVHJopmOwbb0ppQrVnkC1rycr7CH7uSxYdZZ
	 fn0qPfP2vlgzHxtVG4xBX2AxYGvSTIVtP8AzNy5MkBWQWrKYlHvXC+F6RCrZ9eqKNF
	 GO7SH7rSFWaZ4Lhdj2p6/SHdIUlYAaWeJx6iKlrg=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1c5sDpz10tQ;
	Thu, 25 Jun 2026 15:26:12 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1c10GGz10jY;
	Thu, 25 Jun 2026 15:26:12 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 2/4] watchdog: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:56 +0000
Message-ID: <20260625152558.7450-3-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog prints all CPU backtraces itself. When the watchdog mask
contains only SYS_INFO_ALL_BT, stripping that bit leaves zero and
sys_info(0) falls back to kernel_sys_info.

Use sys_info_with_filter() so an explicit all_bt mask does not request
the global default.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/watchdog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..ff284593cb90 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -208,6 +208,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
 	int hardlockup_all_cpu_backtrace;
 	unsigned int this_cpu;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
@@ -216,7 +217,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		return;
 	}
 
-	hardlockup_all_cpu_backtrace = (hardlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(hardlockup_si_mask);
+	hardlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_hardlockup_all_cpu_backtrace;
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
@@ -286,7 +288,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 			clear_bit_unlock(0, &hard_lockup_nmi_warn);
 	}
 
-	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
+	sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
 	if (hardlockup_panic)
 		nmi_panic(regs, "Hard LOCKUP");
 
@@ -798,6 +800,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int softlockup_all_cpu_backtrace;
 	int duration, thresh_count;
+	unsigned long si_mask;
 	unsigned long flags;
 
 	if (!watchdog_enabled)
@@ -809,7 +812,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (panic_in_progress())
 		return HRTIMER_NORESTART;
 
-	softlockup_all_cpu_backtrace = (softlockup_si_mask & SYS_INFO_ALL_BT) ?
+	si_mask = READ_ONCE(softlockup_si_mask);
+	softlockup_all_cpu_backtrace = (si_mask & SYS_INFO_ALL_BT) ?
 					1 : sysctl_softlockup_all_cpu_backtrace;
 
 	watchdog_hardlockup_kick();
@@ -900,7 +904,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
-		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
+		sys_info_with_filter(si_mask, SYS_INFO_ALL_BT);
 		thresh_count = duration / get_softlockup_thresh();
 
 		if (softlockup_panic && thresh_count >= softlockup_panic)
-- 
2.53.0

