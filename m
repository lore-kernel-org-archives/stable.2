Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224224;
	b=yt2fgdsc7BJaF14SVeo9hifJP/C3cRkuAigw7WMoOrWGdDanG1veb+Yge894jkqNRcT9
	 41fGmls5b0qbULZXUEkSCUCBSJbHIKw4cIkg66fwx/v27Wsnl4RYbBFenztnf2yRHj161
	 cak8fE7i7GGxOaibWegfdeNjEeWmkfcVW5cLskN95dfSg1kCpyCh1/YD5Z0ms5qp8NqDH
	 c2xfd5yA7CnemfEtFO1OdHkLL1h4KiRF19AsYRCeIbWZnggGx1bO+Xa0D4ZhrLAmRSMrj
	 aO1FiOs5KiJSlsTPuynuhWpcgcn0lP8LqtUSSibsZoIR+AR5PLpES/S+Ympvf/JE2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224224;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=UQgho8y8jCgpD8vbPP8rOlSQ3DTgWNQsTsAnRTOaVbM=;
	b=VjQhgeG1P2vZ5R5GbKandIeZQ0JeH5YcEMRRCqvm4A14FffejS9YrGtc3G7UtN0rghlW
	 6j3udnbXYoHVi54lS7RRKYFvoW9lsU7hgTlmJPTOJbSewnY3QOjLbwDCH1bQ4bkQctEEw
	 zyq5JUsJhkY5QYukk6QylWNK+sh25OmxH9wZqbNSoLOO1hfXEN6U2j603Wafp+KNVFuMO
	 Ga1tsBQFsNj+icU+WBFL6FgTnx9mzbi1Tn8Pna7s14tVg0/uUejh0R32thyCzch1eO5vP
	 xCN1Hvn7MmlVV9wmkDjAyZI4/hX+eAO2+kPcFWvghpJrHf1bIgL0BAk7rymyKASe8yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBF606A336
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BBF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jNSRB51f8z1c0TC
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 45C3840573
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:59 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3C9FQsPFqxNWIDg--.22880S4;
	Mon, 09 Nov 2026 19:36:59 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH 5.10.y 2/2] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
Date: Mon,  9 Nov 2026 19:36:46 +0800
Message-Id: <20261109113646.3140767-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109113646.3140767-1-wutengda@huaweicloud.com>
References: <20261109113646.3140767-1-wutengda@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgC3C9FQsPFqxNWIDg--.22880S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1rGw1kXF1DCryfGFWxZwb_yoW7AF1DpF
	yakryYkr4kJ34UAFy7Aw18Xr1aqa1DCF47GrsrGryruF15Xw15JryIk3y3urn8Cr98ZFyS
	vF1IqryIkry7Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjLID7UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

From: Qais Yousef <qais.yousef@arm.com>

commit 75bd4bff300b3c5252d4a0e7a959569c62d1dbae upstream.

I was hitting the below panic continuously when attaching kprobes to
scheduler functions

	[  159.045212] Unexpected kernel BRK exception at EL1
	[  159.053753] Internal error: BRK handler: f2000006 [#1] PREEMPT SMP
	[  159.059954] Modules linked in:
	[  159.063025] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.11.0-rc4-00008-g1e2a199f6ccd #56
	[rt-app] <notice> [1] Exiting.[  159.071166] Hardware name: ARM Juno development board (r2) (DT)
	[  159.079689] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)

	[  159.085723] pc : 0xffff80001624501c
	[  159.089377] lr : attach_entity_load_avg+0x2ac/0x350
	[  159.094271] sp : ffff80001622b640
	[rt-app] <notice> [0] Exiting.[  159.097591] x29: ffff80001622b640 x28: 0000000000000001
	[  159.105515] x27: 0000000000000049 x26: ffff000800b79980

	[  159.110847] x25: ffff00097ef37840 x24: 0000000000000000
	[  159.116331] x23: 00000024eacec1ec x22: ffff00097ef12b90
	[  159.121663] x21: ffff00097ef37700 x20: ffff800010119170
	[rt-app] <notice> [11] Exiting.[  159.126995] x19: ffff00097ef37840 x18: 000000000000000e
	[  159.135003] x17: 0000000000000001 x16: 0000000000000019
	[  159.140335] x15: 0000000000000000 x14: 0000000000000000
	[  159.145666] x13: 0000000000000002 x12: 0000000000000002
	[  159.150996] x11: ffff80001592f9f0 x10: 0000000000000060
	[  159.156327] x9 : ffff8000100f6f9c x8 : be618290de0999a1
	[  159.161659] x7 : ffff80096a4b1000 x6 : 0000000000000000
	[  159.166990] x5 : ffff00097ef37840 x4 : 0000000000000000
	[  159.172321] x3 : ffff000800328948 x2 : 0000000000000000
	[  159.177652] x1 : 0000002507d52fec x0 : ffff00097ef12b90
	[  159.182983] Call trace:
	[  159.185433]  0xffff80001624501c
	[  159.188581]  update_load_avg+0x2d0/0x778
	[  159.192516]  enqueue_task_fair+0x134/0xe20
	[  159.196625]  enqueue_task+0x4c/0x2c8
	[  159.200211]  ttwu_do_activate+0x70/0x138
	[  159.204147]  sched_ttwu_pending+0xbc/0x160
	[  159.208253]  flush_smp_call_function_queue+0x16c/0x320
	[  159.213408]  generic_smp_call_function_single_interrupt+0x1c/0x28
	[  159.219521]  ipi_handler+0x1e8/0x3c8
	[  159.223106]  handle_percpu_devid_irq+0xd8/0x460
	[  159.227650]  generic_handle_irq+0x38/0x50
	[  159.231672]  __handle_domain_irq+0x6c/0xc8
	[  159.235781]  gic_handle_irq+0xcc/0xf0
	[  159.239452]  el1_irq+0xb4/0x180
	[  159.242600]  rcu_is_watching+0x28/0x70
	[  159.246359]  rcu_read_lock_held_common+0x44/0x88
	[  159.250991]  rcu_read_lock_any_held+0x30/0xc0
	[  159.255360]  kretprobe_dispatcher+0xc4/0xf0
	[  159.259555]  __kretprobe_trampoline_handler+0xc0/0x150
	[  159.264710]  trampoline_probe_handler+0x38/0x58
	[  159.269255]  kretprobe_trampoline+0x70/0xc4
	[  159.273450]  run_rebalance_domains+0x54/0x80
	[  159.277734]  __do_softirq+0x164/0x684
	[  159.281406]  irq_exit+0x198/0x1b8
	[  159.284731]  __handle_domain_irq+0x70/0xc8
	[  159.288840]  gic_handle_irq+0xb0/0xf0
	[  159.292510]  el1_irq+0xb4/0x180
	[  159.295658]  arch_cpu_idle+0x18/0x28
	[  159.299245]  default_idle_call+0x9c/0x3e8
	[  159.303265]  do_idle+0x25c/0x2a8
	[  159.306502]  cpu_startup_entry+0x2c/0x78
	[  159.310436]  secondary_start_kernel+0x160/0x198
	[  159.314984] Code: d42000c0 aa1e03e9 d42000c0 aa1e03e9 (d42000c0)

After a bit of head scratching and debugging it turned out that it is
due to kprobe handler being interrupted by a tick that causes us to go
into (I think another) kprobe handler.

The culprit was kprobe_breakpoint_ss_handler() returning DBG_HOOK_ERROR
which leads to the Unexpected kernel BRK exception.

Reverting commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
kprobe_step_ctx") seemed to fix the problem for me.

Further analysis showed that kcb->kprobe_status is set to
KPROBE_REENTER when the error occurs. By teaching
kprobe_breakpoint_ss_handler() to handle this status I can no  longer
reproduce the problem.

Fixes: ba090f9cafd5 ("arm64: kprobes: Remove redundant kprobe_step_ctx")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210122110909.3324607-1-qais.yousef@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 arch/arm64/kernel/probes/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 215733a51f97..69a8e43b9821 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -375,8 +375,8 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned int esr)
 	unsigned long addr = instruction_pointer(regs);
 	struct kprobe *cur = kprobe_running();
 
-	if (cur && (kcb->kprobe_status == KPROBE_HIT_SS)
-	    && ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
+	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
+	    ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
 		kprobes_restore_local_irqflag(kcb, regs);
 		post_kprobe_handler(cur, kcb, regs);
 
-- 
2.34.1

