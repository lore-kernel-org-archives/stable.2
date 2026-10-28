Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157085;
	b=0Eu/2LR3+pUgKmZeWnEGtZ00cTUhXojk4/QBrRuBWdZ5wop0TI3aOwRtcy6GdDeH33oO
	 NdZgSiHP0kZa0nhYmTmxS+hwherXomsYO0DxCt02nfSjRXZ2HxhZf/Yue/ExWox+L0M/5
	 qXzrHPQvBa+0B23eN7qwPRhVXTOfMfbeWvU2qouWl0bvW6duhIsZHgRjO0J0CuNF1ejDS
	 EpWVGRcCeSIWmqKSXWV/vYVkPT3VIFfHvCwtvqOx+dwqQZI8Z9675Gn4Kt2RqtKw1kN/o
	 sAnhhn/K7Lmlws4CgzH/IAfJmUJcOczmV99SyDtNq4WwIl8vYFcZro9dLYTMQIJHxuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157085;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOidjj5Ml69IXBVDgaaqFA/kPNhQ/xUITVxdD/pzEd8=;
	b=woGA7rU5Zf/DdZ53DWRRfvlZH7k6XlqAHN0u7rrsWvgv7dK3Gp4R+xDX9J0L0zbPj5zc
	 /e/D1ZVqgx5OGJBK2chaSbJIWPakEXe0ud9F77gNyUhu0g3Qkc4dRLpbwHwVPq9+h5Bya
	 VOnCSZ+HOI3ZJ6PmWBs4RpCH6XbSNLrnRitRzWpRbQp/1TphDY/o5SyMaOOyZbArQBd6c
	 0zRTeeP6DGVH6KR1dGJAePlrvx4gXRIRyypvZea/DL6iqQYh+7LCtPGIkACxpZ0nwyZ/N
	 Gg2G835b/zrXUdnKC2uM6saaw8l9pY1lK9EGfb1IvUZjv4YShvot6Id+Z4nuoVKhQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O72jPzr2;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F7606A31A;
	Wed, 28 Oct 2026 03:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C0F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O72jPzr2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793157082; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NOidjj5Ml69IXBVDgaaqFA/kPNhQ/xUITVxdD/pzEd8=;
	b=O72jPzr2bD793SFpqsi7HsCUAp/9pOyTAa+eACVnYdCSsyWOHJzHoZ2dPt1cb1HLIEOMgqvxq6ZdeftLpm4HkXKOCRCLTstRi442JU1EyNU3SUcJV7LSpOnqCpVBzYHmy249F4xFiHwuEcBO1PLYadoU3IQgPz8RZS51YODnZ1I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=jinyue.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XDfYO0M_1793157079;
Received: from aa8c952a0f58..(mailfrom:jinyue.li@linux.alibaba.com fp:SMTPD_---0XDfYO0M_1793157079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 11:11:20 +0800
From: Li Jinyue <jinyue.li@linux.alibaba.com>
To: Atish Patra <atish.patra@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Xixin Liu <liuxixin@kylinos.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drivers/perf: riscv: Fix racy hw.idx use in user access paths
Date: Wed, 28 Oct 2026 03:11:19 +0000
Message-Id: <20261028031119.1485928-1-jinyue.li@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
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

riscv_pmu_event_idx() and arch_perf_update_userpage() are called from
perf_mmap() through perf_event_update_userpage(), and
pmu_sbi_set_scounteren()/pmu_sbi_reset_scounteren() run on every CPU in
mm_cpumask() through IPIs sent by pmu_sbi_event_mapped() and
pmu_sbi_event_unmapped(). None of them hold the event context lock, so
the event can be scheduled in or out on another CPU at the same time,
and riscv_pmu_add()/riscv_pmu_del() change hw.idx underneath them.

Taking the context lock is not an option: perf_event_update_userpage()
is also called from riscv_pmu_add() and riscv_pmu_del(), which already
hold it.

Commit 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap
support") added hw.idx != -1 checks to the scounteren helpers and to
riscv_perf_user_access(), but hw.idx is loaded again afterwards to
index pmu_ctr_list, so the check does not cover the access.
riscv_pmu_event_idx() has no check and relies on perf_event_index(),
which only looks at the software state (event->state and hw.state) and
not at hw.idx. event_sched_in() marks the event ACTIVE before calling
pmu::add(), and hw.state is still zero on the first schedule-in, so
perf_event_index() can call into the driver with hw.idx == -1.
event_sched_out() likewise calls pmu::del() before the state changes.

syzkaller hits this on QEMU with KASAN. In every report the faulting
address is pmu_ctr_list[-1]:

  BUG: KASAN: slab-out-of-bounds in pmu_sbi_csr_index+0x80/0x82
  Read of size 8 at addr ff60000009933bf8 by task syz.0.5217/27313
  Call Trace:
   pmu_sbi_csr_index+0x80/0x82
   riscv_pmu_event_idx+0x9c/0xd8
   perf_event_update_userpage+0x544/0x6ca
   riscv_pmu_event_mapped+0x6e/0x98
   perf_mmap+0xbcc/0x22ae
   __mmap_region+0x1128/0x2398
   mmap_region+0x3cc/0x466
   do_mmap+0xe7c/0x162c
   vm_mmap_pgoff+0x1e8/0x362
   ksys_mmap_pgoff+0x338/0x402
   __riscv_sys_mmap+0x11c/0x18c

The same read is also reported in pmu_sbi_ctr_get_width() from
arch_perf_update_userpage(), in pmu_sbi_set_scounteren() from the IPI
handler and in pmu_sbi_reset_scounteren() from perf_mmap_close().

Load hw.idx once with READ_ONCE() in these paths, check that value and
use it for the lookup. Change the csr_index() callback to take the
counter index so that the value checked is the value used; neither
backend needs anything else from the event. Use WRITE_ONCE() for the
stores in riscv_pmu_add() and riscv_pmu_del().

Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in the SBI backend")
Cc: stable@vger.kernel.org
Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
---
 drivers/perf/riscv_pmu.c        | 22 ++++++++++++++--------
 drivers/perf/riscv_pmu_legacy.c |  4 ++--
 drivers/perf/riscv_pmu_sbi.c    | 14 ++++++++------
 include/linux/perf/riscv_pmu.h  |  2 +-
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 8e3cd0f35336..0ec4114595b0 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -18,18 +18,23 @@
 
 #include <asm/sbi.h>
 
-static bool riscv_perf_user_access(struct perf_event *event)
+static bool riscv_perf_user_access(struct perf_event *event, int idx)
 {
 	return ((event->attr.type == PERF_TYPE_HARDWARE) ||
 		(event->attr.type == PERF_TYPE_HW_CACHE) ||
 		(event->attr.type == PERF_TYPE_RAW)) &&
 		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) &&
-		(event->hw.idx != -1);
+		(idx != -1);
 }
 
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
+	/*
+	 * hw.idx is updated by pmu::add()/del() on another CPU, so take a
+	 * snapshot and use it for both the check and the lookup.
+	 */
+	int idx = READ_ONCE(event->hw.idx);
 	struct clock_read_data *rd;
 	unsigned int seq;
 	u64 ns;
@@ -37,7 +42,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
-	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
+	userpg->cap_user_rdpmc = riscv_perf_user_access(event, idx);
 
 	/*
 	 * The counters are 64-bit but the priv spec doesn't mandate all the
@@ -45,7 +50,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	 * the cpu vendor.
 	 */
 	if (userpg->cap_user_rdpmc)
-		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
+		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(idx) + 1;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
@@ -265,7 +270,7 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
-	hwc->idx = idx;
+	WRITE_ONCE(hwc->idx, idx);
 	cpuc->events[idx] = event;
 	cpuc->n_events++;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
@@ -293,7 +298,7 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
 	if (rvpmu->ctr_clear_idx)
 		rvpmu->ctr_clear_idx(event);
 	perf_event_update_userpage(event);
-	hwc->idx = -1;
+	WRITE_ONCE(hwc->idx, -1);
 }
 
 static void riscv_pmu_read(struct perf_event *event)
@@ -353,12 +358,13 @@ static int riscv_pmu_event_init(struct perf_event *event)
 static int riscv_pmu_event_idx(struct perf_event *event)
 {
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
+	int idx = READ_ONCE(event->hw.idx);
 
-	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) || idx == -1)
 		return 0;
 
 	if (rvpmu->csr_index)
-		return rvpmu->csr_index(event) + 1;
+		return rvpmu->csr_index(idx) + 1;
 
 	return 0;
 }
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 1b8e4789cb3c..e540bb798fb6 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -76,9 +76,9 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
 	local64_set(&hwc->prev_count, initial_val);
 }
 
-static uint8_t pmu_legacy_csr_index(struct perf_event *event)
+static uint8_t pmu_legacy_csr_index(int idx)
 {
-	return event->hw.idx;
+	return idx;
 }
 
 static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_struct *mm)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 2991dd92def2..2360ee5d8843 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -530,9 +530,9 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
 }
 EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
 
-static uint8_t pmu_sbi_csr_index(struct perf_event *event)
+static uint8_t pmu_sbi_csr_index(int idx)
 {
-	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
+	return pmu_ctr_list[idx].csr - CSR_CYCLE;
 }
 
 static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
@@ -809,19 +809,21 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 static void pmu_sbi_set_scounteren(void *arg)
 {
 	struct perf_event *event = (struct perf_event *)arg;
+	int idx = READ_ONCE(event->hw.idx);
 
-	if (event->hw.idx != -1)
+	if (idx != -1)
 		csr_write(CSR_SCOUNTEREN,
-			  csr_read(CSR_SCOUNTEREN) | BIT(pmu_sbi_csr_index(event)));
+			  csr_read(CSR_SCOUNTEREN) | BIT(pmu_sbi_csr_index(idx)));
 }
 
 static void pmu_sbi_reset_scounteren(void *arg)
 {
 	struct perf_event *event = (struct perf_event *)arg;
+	int idx = READ_ONCE(event->hw.idx);
 
-	if (event->hw.idx != -1)
+	if (idx != -1)
 		csr_write(CSR_SCOUNTEREN,
-			  csr_read(CSR_SCOUNTEREN) & ~BIT(pmu_sbi_csr_index(event)));
+			  csr_read(CSR_SCOUNTEREN) & ~BIT(pmu_sbi_csr_index(idx)));
 }
 
 static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index ecaa40370830..4690a5646ae9 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -66,7 +66,7 @@ struct riscv_pmu {
 	void		(*event_init)(struct perf_event *event);
 	void		(*event_mapped)(struct perf_event *event, struct mm_struct *mm);
 	void		(*event_unmapped)(struct perf_event *event, struct mm_struct *mm);
-	uint8_t		(*csr_index)(struct perf_event *event);
+	uint8_t		(*csr_index)(int idx);
 
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
-- 
2.25.1

