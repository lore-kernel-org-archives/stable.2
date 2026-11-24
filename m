Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508185;
	b=vqeCOdNuB4QGpi3Mfk9SSyAd+ph0bHo7hA0m2qA7c9FKhij2bE8uUILJytdJlpY5fREP
	 7etNESuXLT3Z0ziu5D+9pN39WmTdDkzz9xpQA10tgfXn7t93GAScGVxDyii5ULUWPPfTr
	 nVAktuEe1jYhrJejNBS2yqlz0QN3l9qnd5kO/U7I23MbvXjZL/FwVOZyPQ0XgUNIOEI+Y
	 kGA4lm5YaDCeOWCWEo95ek6OgiTyRS1Y23byg7Ft7DTrn4wwH/91GtdIrQgrhLHBZVkz5
	 HygdSx9kwc5D/CatfUq5sziTU+89tzurifM2hQz9FzqIlPBl0MUMnh81AMYHin+Jz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508185;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LZM7DGDJCWUkbV6QOLu0g934zpHfuctVlWwnqyDatg4=;
	b=yUauf701EX7wi8XWnH5Ft9kdabBEhwI5fUldI+2uNl4rfztN3bM2XAtu107KixsjLqG0
	 IVeHxjh1lvbk4g5YMKFkSWtBpTu10J2kW8OnY7TTCQvV5LHG9k2mMCGGlNu5GswkS0bZJ
	 u1v/iGfFyeuk/onJQAl9HKXqrAURa5C+JC37o1SPdl2KxIfHx16Pda9kYSLhlmwmQGyo4
	 D8sgWzbPmepBIVaT8TasccA+C9SYAG2lAZ4h6Z48E3G+EgUbHjgy1Up596v3Bs6xZnRRT
	 3HEb+oQnT9VuLhJgDsmpIxNUyQcB4AhSv1CWNK2Nv9C2RBtz05HbzteZ4s0sH/xVCcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36B606A31E;
	Tue, 24 Nov 2026 08:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA36B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jYbHR5Y1Pz209G;
	Tue, 24 Nov 2026 16:16:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3705A4056B;
	Tue, 24 Nov 2026 16:16:21 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCX0O_LRwVrMRxkFg--.47428S2;
	Tue, 24 Nov 2026 16:16:20 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: stable@vger.kernel.org
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	alexander.shishkin@linux.intel.com
Subject: [PATCH stable/linux-6.6.y] perf, bpf: Fix NULL event->orig_overflow_handler dereference
Date: Tue, 24 Nov 2026 08:48:37 +0000
Message-Id: <20261124084837.2327711-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:gCh0CgCX0O_LRwVrMRxkFg--.47428S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr18Wr1DKr18ZFy5CFy3Arb_yoWrGF4kpr
	ZFyr90kr4DWFnF9anIyF1vy3W7ur4fZFs8Ja1vkrWfCayFg3sxXFyUG34agrW5GryjkFyx
	tw1UtryYy34UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

We hit the following problem on x86:

	BUG: kernel NULL pointer dereference, address: 0000000000000000
	#PF: supervisor instruction fetch in kernel mode
	#PF: error_code(0x0010) - not-present page
	RIP: 0010:0x0
	Call Trace:
	 <IRQ>
	 bpf_overflow_handler+0xa4/0x120
	 __perf_event_overflow+0x11d/0x2f0
	 perf_swevent_hrtimer+0x127/0x140
	 __hrtimer_run_queues+0x108/0x250
	 hrtimer_interrupt+0xfb/0x230
	 sysvec_apic_timer_interrupt+0x69/0x90
	 </IRQ>
	 <TASK>
	 asm_sysvec_apic_timer_interrupt+0x1a/0x20
	 __perf_event_set_bpf_prog+0xb7/0x180
	 _perf_ioctl+0x1f9/0xb40
	 perf_ioctl+0x41/0x70
	 __se_sys_ioctl+0x82/0xc0
	 do_syscall_64+0x44/0xb0
	 entry_SYSCALL_64_after_hwframe+0x78/0xe2
	 </TASK>

RIP is 0 with error_code(0x0010) (instruction fetch, not-present), i.e.
an indirect call through a NULL function pointer.

perf_event_set_bpf_handler() records the handler currently installed on
the event and replaces it with bpf_overflow_handler():

	event->prog = prog;
	event->bpf_cookie = bpf_cookie;
	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);

WRITE_ONCE() is a single-copy atomic access, not a compiler barrier, and
the store to orig_overflow_handler is a plain assignment, so the compiler
may reorder the two stores. GCC 11.4.0 does; disassembly of
__perf_event_set_bpf_prog():

	mov    0x3d0(%rbp),%rax                  ; prev = overflow_handler
	mov    %rsi,0x3e8(%rbp)                  ; event->prog = prog
	mov    %r13,0x3f0(%rbp)                  ; event->bpf_cookie = cookie
	movq   $bpf_overflow_handler,0x3d0(%rbp) ; publish overflow_handler
	mov    %rax,0x3e0(%rbp)                  ; orig_overflow_handler = prev

Use smp_store_release()/smp_load_acquire() to guarantee both the compiler
and the memory ordering.

Upstream status:
Not affected. commit f11f10bfa1ca ("perf/bpf: Call BPF handler directly,
not through overflow machinery") removed orig_overflow_handler and
calls bpf_overflow_handler() directly from __perf_event_overflow(), so
the reordering window no longer exists. That rework was not backported
to any stable tree.

Affected version:
Introduced by commit aa6a5f3cb2b2 ("perf, bpf: add perf events core support
for BPF_PROG_TYPE_PERF_EVENT programs").

Fixes: aa6a5f3cb2b2 ("perf, bpf: add perf events core support for BPF_PROG_TYPE_PERF_EVENT programs")
Cc: stable@vger.kernel.org # 6.6
Assisted-by: LLM
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95743e6c5b0c..3ffb313d610c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9717,7 +9717,10 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+	/*
+	 * matches smp_store_release() in perf_event_set_bpf_handler().
+	 */
+	smp_load_acquire(&event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -10626,7 +10629,12 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
 	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
+	/*
+	 * Ensure the update of overflow_handler is after
+	 * orig_overflow_handler. Otherwise, we may call a NULL
+	 * orig_overflow_handler in bpf_overflow_handler.
+	 */
+	smp_store_release(&event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
-- 
2.34.1

