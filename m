Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AA3C9EF6;
	Sun,  2 Aug 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689622; cv=none; b=TX4L95Yhx7V7WaK0q+lVu+NwPJtK3vW6ZhCf51wLEhO0dfvniKU8vxotsGYXDh7DJEJ/9/PRO9hupT3QH1PS1zrZpapa0XBf3sU+V02uBtnkRFA40jn1Bf/J9E3ByzZWBp/1mCTbHd0qyPC/vH65MxXEgW+AwCVVg4Sh0RwMfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689622; c=relaxed/simple;
	bh=b/VNPkwPUumPkXZC0NVwXxj5iEweX9a5MwCOIgyy3CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj8Jmm9H7kXB18J/x8XK+aGweEJxwLVMtvVqUo6qCOwKbZPFD6ojnR6XmQl2ucYGbpuTdPcbHw+tl3lWct5gEuJ5euWojVY4IjDmSG/QQnhbhLlpXbVDKJ8Oz+a0KkUzbzIqi3g/zGeu56shntutP3I5AxA439Mb0yFrp/7csd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma03lMFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma03lMFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C21F00A3A;
	Sun,  2 Aug 2026 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689621;
	bh=DebX7evhEtlgthyyjGu18FUeYtqUAeNC8V77aBBdbns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ma03lMFjEIGpCCK44yCD73/RZdEU9x93nIEs2F3en0qOqsY0FmfYB3vaNfwB+Ltxl
	 wL+bii+DHKGgsy2WfccmrkYxZeg4hW6q+hrl8W4DYjitINoxZSDus4nsmMPNJmCyYx
	 naZzIQgzp+D4UwvnQGHeWHVhIMsSeZ5rfCjPATc+2SDLX0c0ulpHmhuHwsgSW2sNXz
	 KzK64QI9AA3L1ciSS3yVze7La95ayIWUhVOQQtXgdJp8m7WLy3ynD7FJHyMKONfPmV
	 BcmoPM44zc0wlYBry3D+sikoWFM9+EYRl0HGoSqXMJ73jfJZpYf9YT84PVWU9HgjUn
	 lGMfvgdUzYCdA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wqZRT-0000000BVIZ-10vj;
	Sun, 02 Aug 2026 16:53:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] clocksource/drivers/arm_arch_timer: Add read_sched_clock_is_arch_counter() predicate
Date: Sun,  2 Aug 2026 17:53:20 +0100
Message-ID: <20260802165327.385217-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802165327.385217-1-maz@kernel.org>
References: <20260802165327.385217-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, tglx@kernel.org, ben.horgan@arm.com, daniel.lezcano@linaro.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The PMUv3 driver really wants to know whether sched_clock() is
backed by the architected timer. However, updates to the timer driver
have broken the check, as there is more than a single accessor
for the counters, depending on the level of brokenness of the HW.

Add a predicate that checks for those accessors, and update the PMUv3
driver to DTRT.

Fixes: 24ee7607b286b ("arm64/arch_timer: Provide noinstr sched_clock_read() functions")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/clocksource/arm_arch_timer.c | 10 ++++++++++
 drivers/perf/arm_pmuv3.c             |  2 +-
 include/clocksource/arm_arch_timer.h |  8 +++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4adf756423de9..c02e97f9b7af5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -951,6 +951,16 @@ static void __init arch_counter_register(void)
 	sched_clock_register(scr, width, arch_timer_rate);
 }
 
+bool read_sched_clock_is_arch_counter(const struct clock_read_data *crd)
+{
+	u64 (*rd)(void) = crd->read_sched_clock;
+
+	return (rd == raw_counter_get_cntvct_stable	||
+		rd == raw_counter_get_cntpct_stable	||
+		rd == arch_counter_get_cntvct		||
+		rd == arch_counter_get_cntpct);
+}
+
 static void arch_timer_stop(struct clock_event_device *clk)
 {
 	pr_debug("disable IRQ%d cpu #%d\n", clk->irq, smp_processor_id());
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8014ff766cff5..ed880145d41b3 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1624,7 +1624,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	do {
 		rd = sched_clock_read_begin(&seq);
 
-		if (rd->read_sched_clock != arch_timer_read_counter)
+		if (!read_sched_clock_is_arch_counter(rd))
 			return;
 
 		userpg->time_mult = rd->mult;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 2eda895f19f54..84cdbaffcfb5e 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -84,13 +84,15 @@ struct arch_timer_mem {
 	struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
 };
 
+struct clock_read_data;
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
 extern bool arch_timer_evtstrm_available(void);
-
+extern bool read_sched_clock_is_arch_counter(const struct clock_read_data *);
 #else
 
 static inline u32 arch_timer_get_rate(void)
@@ -108,6 +110,10 @@ static inline bool arch_timer_evtstrm_available(void)
 	return false;
 }
 
+static bool read_sched_clock_is_arch_counter(const struct clock_read_data *crd)
+{
+	return false;
+}
 #endif
 
 #endif
-- 
2.47.3

