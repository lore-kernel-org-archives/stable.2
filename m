Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665776;
	b=pAO32585dmqCKRAdE2NjGPtcXzqKlFvqx/QeCtFViyOgbCm/a/nputHykl5HHHI2TI2p
	 LsYQutnbw26CMt6YkDyhnI4w2VCLvhLf/ZYRhnk/YsB8o6+ujPXHvHvvDxWDwEN3mysKI
	 qiJyun51M0mwrob9ZjVlMkeSVdPXqWDf/NrAiJJ8PUiC+3qX4FjKdX+0E9JIPTXGKjIPn
	 7uyzQbN42bsMWXSQfnyv9iMJTqgemJxEnVAWk2YqrO5MWBS67c3rXY1QXl93EOe8AU8jc
	 8Rh3HjAexq+Ems4KzP2e0uATQneg+NghNZNZvM8jTYcO5JrkLI/FSk7d5OR3P3X5b+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665776;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=NN4M4Jo+5ge6yw1x29JgvGW6JvzHEGW3JJZE1kQgeRg=;
	b=srgvVkarYFtsvA/3NIpfxA9/hmDUe7uHU7JCV6xgF2iu4PhNdvT/Zk101iggV9Dp2jvY
	 0q8QHU/AiqkLluNPNOqACkCtszN4iDMJOPIkoJzJy+MJladLKC3bGuC7oRIXm6wq1lvN0
	 lC1bZVYnToBsBZ2jH8LbqV9v7OWFoEBSVWUJ2AN0Iy1fzGpkzO8pjCuj8iV3T9JXIPWgs
	 zn3NEg5hMiY5tVbcl9i/kTYfkTV4F+gJHdAyDT3XWdSrzcemRZ2SSohfFIPeoi2vvpE30
	 LsMWYbcOGwoh1lCDyMair9wHGIsRyNUmPhohL4kmPluA/USk2ltELYE4/sbmc2TrSAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B7606A323;
	Thu, 26 Nov 2026 04:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72B7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jZjYz0PcLz1rqxP;
	Thu, 26 Nov 2026 12:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 77177405F2;
	Thu, 26 Nov 2026 12:02:51 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOullrwdrepVXFw--.42150S2;
	Thu, 26 Nov 2026 12:02:51 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Song Liu <song@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	alexander.shishkin@linux.intel.com
Subject: [PATCH stable/linux-6.6.y 0/9] perf/bpf: Fix NULL pointer dereference
Date: Thu, 26 Nov 2026 04:34:49 +0000
Message-Id: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHOullrwdrepVXFw--.42150S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUXF1UCryrZF4kCw1kGrg_yoWxZrW8pF
	ZxKrnIkr4kGF1I9w4fA3W2yFnrur4fXr45Jw1vyrWrCa90grZxXF9rK343KrW5JryvvFy2
	qw18KrWYkryUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
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

For a software event the overflow comes from perf_swevent_hrtimer() in
hardirq context on the same CPU, so no memory ordering is involved at all,
only the store order; the publish lands first and the hrtimer interrupt
fires in between. bpf_overflow_handler() then runs the attached BPF program
and, for a non-zero return value, calls the still-NULL
orig_overflow_handler (struct perf_event is allocated with __GFP_ZERO).

Upstream status:
Not affected. f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not
through overflow machinery", v6.10) removed orig_overflow_handler and
calls bpf_overflow_handler() directly from __perf_event_overflow(), so
the reordering window no longer exists. That rework was not backported
to any stable tree, and there is no standalone upstream fix for the
ordering itself.

Affected version:
Introduced by aa6a5f3cb2b2 ("perf, bpf: add perf events core support for
BPF_PROG_TYPE_PERF_EVENT programs", v4.9) and still present in the 5.10,
5.15, 6.1 and 6.6 LTS trees; v6.10 removed the field altogether.

To backport f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not
through overflow machinery"), that commit has to come with the series it
was posted in, and with the fixups it later needed. f11f is not a
standalone change: it calls bpf_overflow_handler() from
__perf_event_overflow(), i.e. from a position the series first moves that
function to, and the new call site reads struct perf_event members that
the series first un-conditionalizes. On its own it does not produce a
tree that builds in every Kconfig combination, and it regresses bpftrace
until the follow-up fix is in.

The series f11f was posted in, and which this backport carries in full:

  Link: https://lore.kernel.org/r/20240412015019.7060-1-khuey@kylehuey.com

  1. 4c03fe11b96b perf/bpf: Reorder bpf_overflow_handler() ahead of
     __perf_event_overflow()                             [prerequisite]
  2. 924d934393f9 perf/bpf: Create bpf_overflow_handler() stub for
     !CONFIG_BPF_SYSCALL                                 [prerequisite]
  3. 14e40a9578b7 perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct
     perf_event members                                  [prerequisite]
  4. f11f10bfa1ca perf/bpf: Call BPF handler directly, not through
     overflow machinery                                 [the fix]
  5. 76f6d5884582 perf/bpf: Remove unneeded uses_default_overflow_handler()
  6. c4fcc7d1f415 perf/bpf: Allow a BPF program to suppress all sample
     side effects                                  [rest of the series]

  f11f (0004 here) is the fix. 0001-0003 are prerequisites: 0001 moves
  bpf_overflow_handler() ahead of __perf_event_overflow(), which is where
  0004 calls it from; 0002 and 0003 make the new call site, which sits
  outside #ifdef CONFIG_BPF_SYSCALL and reads event->prog
  unconditionally, work when BPF is disabled. 0005 and 0006 are part of
  the same series: they clean up what the refactoring left behind and add
  the ability to suppress side effects, which is the point of the rework
  but not the reason we are backporting it.

The follow-up fixes, i.e. what upstream had to correct after the series
landed:

  7. 93d3fde7fd19 perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to
     static inlines                                  [compile fix, Ingo]
  8. 854dd99b5ddc perf/bpf: Mark perf_event_set_bpf_handler() and
     perf_event_free_bpf_handler() as inline too     [compile fix, Ingo]
  9. 100bff23818e perf/bpf: Don't call bpf_overflow_handler() for tracing
     events                                          [Fixes: f11f10bfa1ca]

The result is a verbatim backport of the series and its follow-up fixes
(one hunk re-based, see "Adaptation notes"), so the tree stays identical
to mainline and later perf/bpf backports continue to apply.

Adaptation notes
----------------

Only 0005 needs manual handling.  0001-0004 and 0006-0009 apply with
plain "git apply".  0005 conflicts on include/linux/perf_event.h because
the hunk trailer references perf_event_header__init_id(), which does not
exist in 6.6.y (perf_event_header__init() still has the extra
type/misc/size arguments).  It was applied by replacing exactly the
removed block; the resulting file is byte-identical to the mainline
result for that hunk.

Ingo Molnar (2):
  perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static inlines
  perf/bpf: Mark perf_event_set_bpf_handler() and
    perf_event_free_bpf_handler() as inline too

Kyle Huey (7):
  perf/bpf: Reorder bpf_overflow_handler() ahead of
    __perf_event_overflow()
  perf/bpf: Create bpf_overflow_handler() stub for !CONFIG_BPF_SYSCALL
  perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct perf_event
    members
  perf/bpf: Call BPF handler directly, not through overflow machinery
  perf/bpf: Remove unneeded uses_default_overflow_handler()
  perf/bpf: Allow a BPF program to suppress all sample side effects
  perf/bpf: Don't call bpf_overflow_handler() for tracing events

 arch/arm/kernel/hw_breakpoint.c   |   8 +-
 arch/arm64/kernel/hw_breakpoint.c |   4 +-
 include/linux/perf_event.h        |  23 +---
 kernel/events/core.c              | 193 +++++++++++++++---------------
 4 files changed, 108 insertions(+), 120 deletions(-)

-- 
2.34.1

